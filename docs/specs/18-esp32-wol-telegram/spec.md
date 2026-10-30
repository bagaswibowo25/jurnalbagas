---
issue: 18
epic: Content
---
# Spec — Tulisan baru: menyalakan PC dari mana saja dengan ESP32 dan Telegram

## Latar

Owner sering membuat lab di PC rumah, tetapi tidak bisa memakainya saat di luar rumah kalau PC dalam keadaan mati.
Router rumahnya memakai jaringan 4G tanpa alamat publik, sehingga cara biasa menyalakan PC dari jauh tidak bisa
dipakai. Owner lalu membangun alat kecil (ESP32-C3 SuperMini) yang selalu menyala di rumah dan menyalakan PC saat
menerima perintah dari bot Telegram. Alat ini sudah diuji langsung pada 30 Oktober 2026, dan kode lengkapnya dibuka
untuk umum di repo GitHub owner esp32-wol-telegram.

Owner ingin menuliskan pengalaman ini sebagai tulisan pertama di seri baru **home-lab**: catatan proyek lab dan
perangkat di rumah.

## Cerita pengguna

**P1 · Paham idenya.** Sebagai pembaca yang ingin menyalakan PC rumah dari jauh, saya ingin tahu kenapa rancangan ini
tetap jalan walau rumah saya tidak punya alamat publik, supaya saya bisa menilai apakah cocok untuk rumah saya.

**P2 · Bisa mengikuti dan menghindari jebakan.** Sebagai pembaca yang mau membuatnya sendiri, saya ingin langkah
pentingnya dan jebakan yang ditemui owner, supaya saya tidak terjebak di tempat yang sama.

**P3 · Yakin aman.** Sebagai pembaca, saya ingin tahu bagaimana bot ini hanya melayani pemiliknya dan apa batasannya,
supaya saya tidak membuka celah ke jaringan rumah saya.

**P4 · Dua bahasa.** Sebagai pembaca berbahasa Indonesia maupun Inggris, saya ingin membaca tulisan ini dalam bahasa
saya.

## Skenario terima

1. Kalau pembaca membuka beranda Indonesia, maka tulisan ini tampil paling atas (tulisan terbaru) dengan judul
   Indonesia; di beranda Inggris tampil versi Inggrisnya.
2. Kalau pembaca membuka tulisan ini, maka ia bisa berpindah ke versi bahasa lainnya.
3. Kalau pembaca membuka tulisan ini, maka di samping tampil navigasi seri **home-lab** dengan tulisan ini sebagai
   bagian 1.
4. Kalau pembaca membuka daftar seri (Indonesia maupun Inggris), maka seri home-lab ikut tampil.
5. Kalau pembaca menekan tag topik tulisan ini (esp32, iot, telegram, wake-on-lan), maka tulisan ini muncul di
   daftarnya.
6. Kalau pembaca mencari "esp32" atau "wake-on-lan", maka tulisan ini muncul.
7. Kalau tulisan dibuka, maka isinya sama dengan draf yang disetujui owner: cerita → rancangan semua koneksi keluar
   (dengan diagram alurnya) → cara kerja spec dulu dan pengembangan tanpa Arduino IDE → tahap 1 Wake-on-LAN lokal
   beserta jebakannya (dengan animasi demo tombol) → tahap 2 bot Telegram beserta pengamanannya → hasil pengujian →
   trade-off dan batasan → kesimpulan dengan tautan ke repo esp32-wol-telegram.
8. Kalau tulisan dibuka di ponsel, maka perintah, potongan kode, dan tabel yang lebar bisa digeser di dalam kotaknya
   sendiri tanpa membuat halaman ikut bergeser.
9. Kalau tulisan dibuka, maka tidak ada data pribadi: token bot, nama atau password Wi-Fi, ID dan username Telegram
   owner, nama bot, alamat MAC perangkat, atau alamat folder pribadi owner.

## Aturan

- Isi dari pengalaman nyata owner pada 30 Oktober 2026; angka dan pesan diambil dari catatan sesi pengujian itu,
  bukan dikarang.
- Isi tulisan diambil dari draf yang sudah owner sunting (dokumen draf di Claude, 30 Oktober 2026); agent hanya
  memindahkannya ke blog tanpa mengubah kalimat (constitution #2).
- Bahasa Indonesia dan Inggris berisi sama; versi Inggris terjemahan versi Indonesia, bukan tulisan terpisah.
- Tautan ke repo esp32-wol-telegram hanya dipasang setelah repo itu publik di GitHub.
- Seri baru **home-lab** untuk proyek lab dan perangkat di rumah; tulisan ini bagian 1 (keputusan owner baru,
  Content K7).
- Tag mengikuti topik (Content K2).
- Ada satu animasi singkat (±19 detik) dari rekaman owner: tombol di alat ditekan, lalu PC yang mati menyala sampai
  menu boot muncul. Animasinya disimpan di blog sendiri, punya teks alternatif, dan cukup ringan untuk ponsel
  (±3,4 MB). Ada juga satu diagram alur perintah. Selain itu tulisan berupa teks, perintah, potongan kode, dan tabel.

## Kriteria sukses

- Owner membaca kedua versi dan setuju isinya akurat dan nyaman dibaca.
- Owner melihat tulisan ini di kedua beranda, di daftar seri home-lab, dan di tag-tagnya.

## Di luar cakupan

- Panduan untuk board selain ESP32-C3 SuperMini atau aplikasi chat selain Telegram. Perbedaannya hanya disinggung.
- Membuat repo esp32-wol-telegram menjadi publik (dilakukan terpisah sebelum tulisan terbit).
- Tulisan lanjutan di seri home-lab.
