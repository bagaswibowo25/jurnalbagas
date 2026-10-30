---
title: "Menyalakan PC dari Mana Saja dengan ESP32 dan Telegram"
date: 2026-10-30T21:00:00+07:00
slug: menyalakan-pc-dengan-esp32-telegram
tags: ["esp32", "iot", "telegram", "wake-on-lan"]
series: ["home-lab"]
part: 1
short: "Wake-on-LAN via Telegram"
summary: "PC utama saya ada di rumah. Setup nya sekarang lagi pakai CachyOS, tersambung kabel LAN ke router."
---
# Cerita

PC utama saya ada di rumah. Setup nya sekarang lagi pakai CachyOS, tersambung kabel LAN ke router. Masalahnya, saya suka membuat lab di PC rumah, tapi kalau lagi diluar atau di kantor gimana saya bisa akses Lab yang ada di Rumah? Membiarkan PC menyala seharian rasanya boros listrik, tapi mematikannya berarti tidak bisa diakses sama sekali. Sangat repot kalau minta tolong orang di Rumah untuk menyalakan.

Solusi klasiknya adalah Wake-on-LAN (WoL): PC yang mati bisa dinyalakan lewat jaringan dengan mengirim paket khusus yang disebut *magic packet*. Masalahnya, router saya TP-Link TL-MR100 yang memakai jaringan 4G, dan seperti kebanyakan koneksi seluler di Indonesia, ia berada di balik CGNAT. Artinya saya tidak punya IP publik, tidak bisa port forwarding, dan tidak ada cara mengirim paket dari internet langsung ke jaringan rumah.

Jadi saya butuh sesuatu yang selalu menyala di dalam jaringan rumah. Pilihannya jatuh ke ESP32-C3 SuperMini, ini atas bantuan rekomendasi rekan kantor saya. Board mungil dengan Wi-Fi yang cukup ditancapkan ke charger HP. Perintahnya saya kirim lewat bot Telegram, karena aplikasinya sudah ada di HP dan tidak perlu membuat aplikasi sendiri.

Pada tulisan ini saya ingin membagikan proses membangunnya, mulai dari perencanaan, challenge yang saya temui, sampai hasil pengujian di hardware. Oke, mari kita mulai.

# Rancangan: Semua Koneksi Keluar

Kunci rancangannya sederhana: ESP32 tidak pernah menunggu koneksi masuk. Ia yang aktif bertanya ke server Telegram, "ada pesan baru untuk saya?", lewat teknik yang disebut *long polling*. Karena semua koneksi berasal dari dalam rumah ke luar, CGNAT sama sekali bukan masalah, dan tidak ada satu port pun yang terbuka di jaringan rumah.

![Diagram alur perintah wake. Di internet: HP pemilik mengirim /wake ke server Telegram. Di jaringan rumah, router 4G di balik CGNAT tanpa port terbuka: ESP32-C3 SuperMini menjemput pesan itu ke server Telegram lewat long polling HTTPS, koneksi keluar. ESP32 lalu mengirim magic packet UDP port 9 ke PC (CachyOS) dan melakukan ping tiap 5 detik.](alur-wake.svg)

Panah dari ESP32 ke server Telegram mengarah ke luar: ESP32 yang menjemput pesan, bukan Telegram yang mengirim ke rumah.

Alurnya kurang lebih seperti ini:

1. Saya mengirim `/wake` ke bot dari HP, di mana pun saya berada.
2. Pesan itu disimpan di server Telegram.
3. ESP32, yang terus melakukan long polling lewat HTTPS, menerima pesan tersebut beberapa saat kemudian.
4. ESP32 memeriksa apakah pengirimnya adalah saya. Kalau bukan, pesan diabaikan.
5. ESP32 mengirim magic packet ke jaringan lokal lewat UDP broadcast di port 9.
6. Kartu jaringan PC mengenali paket itu dan menyalakan PC.
7. ESP32 melakukan ping ke PC setiap 5 detik, lalu mengabari saya lewat Telegram begitu PC terdeteksi online.

Selain lewat Telegram, wake juga bisa dipicu dari tombol BOOT di board dan dari konsol USB. Jalur lokal ini sengaja dibuat tidak bergantung pada Telegram, jadi tetap berfungsi walaupun internet sedang putus.

# Cara Kerja: Spec Dulu, Kode Belakangan

Proyek ini saya kerjakan bersama Claude Code dengan pendekatan *spec-driven development* menggunakan [Spec Kit](https://github.com/github/spec-kit). Alurnya: constitution → spec → plan → tasks → implementasi. Constitution berisi lima prinsip yang mengikat semua keputusan, dan dua yang paling berpengaruh adalah **keamanan dulu** dan **hanya koneksi keluar**.

Saya juga memecah pekerjaan menjadi dua fitur:

- **001 — Wake-on-LAN lokal.** ESP32 bisa menyalakan PC dari tombol dan konsol, mengecek status PC, dan pulih sendiri saat Wi-Fi putus.
- **002 — Kontrol lewat Telegram.** Baru dikerjakan setelah 001 terbukti jalan di hardware.

Pemisahan ini ternyata keputusan yang tepat. Kalau Telegram langsung dikerjakan dan PC tidak menyala, saya tidak akan tahu masalahnya di BIOS, di jaringan, di ESP32, atau di bot.

Untuk development, saya tidak memasang Arduino IDE. Semuanya memakai PlatformIO yang dijalankan di dalam container Docker lewat script kecil bernama `./pio`, jadi laptop tetap bersih:

```bash
./pio test -e native              # unit test logika murni di laptop
./pio run -e supermini -t upload  # build + flash ke ESP32
```

Logika yang tidak butuh hardware, seperti menyusun magic packet, membaca respons Telegram, allowlist, sampai teks balasan bot, saya pisahkan ke library C++ murni yang diuji di laptop. Di akhir proyek ada 54 unit test, dan semuanya bisa jalan tanpa ESP32 tercolok.

# Tahap 1: Wake-on-LAN Lokal

## Pastikan PC bisa dibangunkan dulu

Sebelum menyentuh ESP32, saya memastikan PC memang bisa dibangunkan dari laptop. Di ASRock B850M-X, pengaturannya ada di **Advanced → ACPI Configuration**: `PCIE Devices Power On` diaktifkan dan `Deep Sleep` dimatikan. Di CachyOS, WoL perlu diaktifkan pada koneksi NetworkManager agar tidak hilang setelah reboot:

```bash
nmcli connection modify <koneksi> 802-3-ethernet.wake-on-lan magic
```

## Jebakan pertama: bridge br0

PC saya memakai bridge `br0` sebagai interface utama, dan di sinilah jebakan pertama muncul. MAC address yang terlihat di `ip link` untuk `br0` belum tentu MAC kartu jaringan fisiknya. Padahal magic packet harus berisi **MAC fisik**, karena yang "mendengarkan" saat PC mati adalah kartu jaringannya, bukan bridge di sistem operasi. MAC yang benar bisa dilihat dengan:

```bash
sudo ethtool -P <nama-interface-fisik>
```

Setelah MAC-nya benar, PC berhasil dibangunkan dari laptop menggunakan script Python kecil. Baru setelah itu saya lanjut ke ESP32.

## Jebakan kedua: board kosong yang reboot terus

Begitu ESP32-C3 SuperMini yang masih baru dicolok, port USB-nya muncul dan hilang setiap sekitar 2 detik. Ternyata flash board masih kosong (`invalid header: 0xffffffff`), sehingga chip terus reboot, dan setiap reboot membuat port USB hilang lalu muncul lagi. Upload biasa selalu gagal karena port-nya keburu hilang.

Cara manual menahan BOOT sambil menekan RST tidak berhasil di percobaan saya. Yang akhirnya berhasil adalah "balapan" dengan board: script menunggu `/dev/ttyACM0` muncul, lalu langsung menjalankan `esptool` dengan `--before usb-reset`. Berhasil di percobaan pertama, dan setelah firmware terpasang, upload biasa berjalan normal.

## Firmware tahap 1

Firmware-nya sendiri cukup sederhana:

- Magic packet 102 byte (6 byte `0xFF` lalu MAC target diulang 16 kali), dikirim 3 kali ke alamat broadcast subnet.
- Setelah wake, ESP32 ping PC setiap 5 detik sampai 3 menit untuk memastikan PC benar-benar menyala.
- Wi-Fi tersambung ulang otomatis dengan jeda bertahap 1 sampai 30 detik, dan restart sendiri bila 10 menit tidak tersambung.
- Watchdog 30 detik: kalau program macet, ESP32 restart sendiri.
- TX power Wi-Fi diturunkan ke 8,5 dBm, karena banyak unit SuperMini gagal tersambung di daya penuh akibat desain antenanya.

Hasilnya, PC yang mati menyala dan terdeteksi online sekitar 30 detik setelah tombol BOOT ditekan.

![Tangan memegang ESP32-C3 SuperMini di depan monitor yang gelap. Setelah tombol BOOT di board ditekan, kipas RGB PC menyala, lalu menu boot CachyOS muncul di layar.](demo-tombol-boot.gif)

Demo di atas memperlihatkan PC yang awalnya mati, lalu menyala setelah tombol BOOT di ESP32 ditekan, sampai menu boot CachyOS muncul di layar.

# Tahap 2: Bot Telegram

## Membuat bot dengan aman

Bot dibuat lewat **@BotFather**, akun resmi Telegram untuk membuat bot (pastikan ada centang birunya, karena banyak akun tiruan). BotFather memberikan sebuah *token*, semacam password untuk mengendalikan bot. Token ini hanya disimpan di file konfigurasi yang tidak pernah di-commit ke Git. Saya juga mematikan izin bot untuk bergabung ke grup lewat `/setjoingroups`.

Pertanyaan pertama saya waktu itu: kalau orang lain menemukan bot saya, apakah mereka bisa menyalakan PC saya? Jawabannya tidak, karena bot hanya melayani **ID akun Telegram** yang terdaftar di *allowlist*, dan hanya dari chat pribadi. Pesan dari akun lain tidak dieksekusi dan tidak dibalas sama sekali, sehingga dari sisi orang asing bot ini terlihat mati.

## Mode setup: mencari ID akun tanpa bot pihak ketiga

Cara umum mengetahui ID akun Telegram adalah bertanya ke bot pihak ketiga seperti @userinfobot. Saya tidak mau bergantung pada itu, jadi firmware punya **mode setup**: kalau allowlist masih kosong, bot tidak melayani siapa pun, tapi konsol USB menampilkan ID setiap pengirim pesan.

```
[tg] setup mode: message from id=<ID akun> chat=private
```

Cukup kirim pesan apa saja ke bot, salin angkanya ke konfigurasi, lalu flash ulang. ID akun bukan rahasia, jadi aman muncul di konsol.

## Peringatan kalau ada yang mencoba

Walaupun akun asing tidak dibalas, saya tetap ingin tahu kalau ada yang mencoba. Jadi bot mengirim peringatan ke saya, berisi ID, username, dan potongan pesannya. Supaya penyusup tidak bisa membanjiri HP saya, peringatan dibatasi satu per akun per jam dan maksimal enam per jam secara total. Sisanya dirangkum dalam satu pesan.

## Perintah tidak boleh dieksekusi dua kali atau terlambat

Ada dua skenario yang cukup menjebak:

1. **Eksekusi ganda.** Kalau ESP32 restart tepat setelah memproses `/wake`, Telegram akan mengirim pesan yang sama lagi. Solusinya, nomor pesan terakhir (`update_id`) disimpan ke flash *sebelum* perintah dijalankan.
2. **Perintah basi.** Kalau ESP32 sedang mati lalu saya kirim `/wake`, pesan itu menunggu di server Telegram. Kalau ESP32 baru menyala sejam kemudian, PC tiba-tiba ikut menyala padahal saya sudah tidak butuh. Jadi `/wake` yang umurnya lebih dari 10 menit ditolak dan saya diberi tahu bahwa perintahnya kedaluwarsa.

Untuk menghitung umur pesan, saya tidak memakai jam ESP32 (yang tidak tahu waktu sebelum sinkron). Waktu server diambil dari header HTTP `Date` di respons Telegram, sehingga waktu pesan dan waktu "sekarang" berasal dari jam yang sama.

## Jebakan: token bisa bocor lewat log

Saya sempat memeriksa source library `HTTPClient` bawaan ESP32, dan ternyata library itu mencetak URL lengkap ke log pada level debug. URL Bot API berisi token (`https://api.telegram.org/bot<TOKEN>/...`), jadi kalau log debug sampai menyala, token akan tercetak di konsol. Solusinya, level log dikunci mati, dan firmware dibuat **gagal di-compile** kalau ada yang menyalakannya:

```cpp
#if CORE_DEBUG_LEVEL > ARDUHAL_LOG_LEVEL_WARN
#error "CORE_DEBUG_LEVEL must be <= WARN: HTTPClient would log the bot token"
#endif
```

Satu lagi yang penting: koneksi ke Telegram memakai HTTPS dengan **verifikasi sertifikat** menggunakan bundle root CA bawaan. Banyak contoh di internet memakai `setInsecure()` yang mematikan verifikasi itu, dan saya sengaja menghindarinya.

# Hasil Pengujian

Semua skenario diuji langsung di hardware pada 30 Oktober 2026. Percakapan dengan bot saat PC mati kira-kira seperti ini:

```
Saya: /wake
Bot:  ⏳ Sinyal bangun terkirim ke PC. Menunggu PC online…
Bot:  🟢 PC online setelah 30 detik.
```

| Skenario | Hasil |
| --- | --- |
| `/wake` saat PC mati | PC menyala, terdeteksi online 30 detik kemudian (2 dari 2 percobaan) |
| `/wake` saat PC sudah menyala | "PC sudah online" dalam sekitar 1 detik |
| `/status` | Online 3/3 ping saat PC menyala, 0/3 saat mati |
| Pesan dari akun asing | Tidak dibalas, PC tidak menyala, saya menerima tepat satu peringatan |
| ESP32 dicabut, kirim `/wake`, dicolok lagi sekitar 1 menit kemudian | Perintah dijalankan 5 detik setelah ESP32 menyala |
| ESP32 dicabut, kirim `/wake`, dicolok lagi 15 menit kemudian | Ditolak sebagai kedaluwarsa, PC tetap mati |
| Router di-restart | Bot melayani lagi 39 detik setelah Wi-Fi pulih, dan saya diberi tahu "kembali online" |
| Tombol BOOT saat PC mati | PC menyala, notifikasi tombol dan hasilnya masuk ke Telegram |

Untuk uji akun asing, saya tidak punya akun Telegram kedua. Jadi saya membuat build uji khusus yang menganggap semua pengirim, termasuk saya sendiri, sebagai akun asing. Peringatannya tetap dikirim ke saya, sehingga perilakunya bisa dibuktikan tanpa meminjam HP orang lain.

Pengujian juga menemukan beberapa hal yang tidak ketahuan di unit test: urutan notifikasi "perangkat online" yang kadang datang setelah balasan perintah, dan belum adanya notifikasi saat internet pulih tanpa restart. Keduanya langsung diperbaiki di hari yang sama.

Dari sisi memori, ESP32-C3 masih menyisakan sekitar 121 KB RAM bebas dengan sesi TLS aktif, dan titik terendahnya sekitar 109 KB.

# Trade-off dan Batasan

- **Wake hanya bekerja dari kondisi shutdown atau sleep.** Kalau listrik rumah padam, PC perlu menyala lagi minimal sekali agar kartu jaringannya kembali siaga. Opsi BIOS seperti *restore on AC power loss* bisa membantu, tapi itu di luar proyek ini.
- **Balasan bot tidak instan.** Biasanya beberapa detik, karena ESP32 harus menerima pesan lewat long polling dulu. Untuk menyalakan PC, ini sama sekali tidak terasa.
- **IP PC harus tetap.** Wake memakai MAC, tapi cek status memakai ping ke IP. Saat router di-restart, IP ESP32 sempat berubah, jadi IP PC sebaiknya dikunci lewat DHCP reservation di router.
- **Bergantung pada Telegram.** Kalau Telegram sedang gangguan, wake jarak jauh ikut tidak bisa. Jalur lokal lewat tombol tetap jalan.
- **Keamanan bergantung pada token.** Kalau token bocor, orang lain bisa mengendalikan bot, tapi tetap tidak bisa menyalakan PC tanpa ID akun yang terdaftar. Token juga bisa dicabut kapan saja lewat BotFather.

# Kesimpulan

Sekarang saya bisa menyalakan PC rumah dari mana saja cukup dengan mengetik `/wake` di Telegram, tanpa IP publik, tanpa port forwarding, dan tanpa membiarkan PC menyala seharian. Perangkatnya hanya ESP32-C3 kecil yang menempel di charger HP.

Pelajaran terbesar dari project ini justru bukan di kodenya. Memisahkan WoL lokal dari Telegram membuat setiap masalah mudah dilacak, dan menguji langsung di hardware menemukan hal-hal yang tidak akan ketahuan dari unit test saja. Hal-hal kecil seperti MAC bridge, board kosong yang reboot terus, sampai token yang bisa tercetak di log, adalah jebakan yang baru kelihatan saat benar-benar dicoba.

Kode lengkap, spec, dan panduan setup-nya ada di repo [esp32-wol-telegram](https://github.com/bagaswibowo25/esp32-wol-telegram).
