---
issue: 5
epic: Theme
---
# Spec — Tampilan baru Jurnal Bagas: bernuansa terminal, dua bahasa

## Latar

Jurnal Bagas masih memakai tampilan bawaan dari pihak lain yang sudah lama tidak dirawat. Tampilannya terasa usang,
masih menyisakan halaman contoh (audio, kutipan, bahasa Jerman) yang bukan tulisan owner, pencariannya tidak pernah
mencari tulisan owner, dan alamat halamannya bercampur bahasa Inggris dan Indonesia. Owner ingin kembali rutin
menulis, jadi blog butuh tampilan yang segar, bersih, bernuansa tech, nyaman dibaca di ponsel, dan siap untuk pembaca
berbahasa Inggris.

Tampilannya sudah dipilih owner lewat mockup (Theme K1–K3): nuansa terminal, monokrom dengan satu aksen biru navy,
beranda berupa daftar tulisan tanpa banner besar, dan halaman tulisan dengan navigasi seri di samping. Rinciannya ada
di standar tampilan blog.

## Cerita pengguna

**P1 · Beranda yang langsung ke tulisan.** Sebagai pembaca, saya ingin beranda langsung menampilkan tulisan terbaru
beserta ringkasannya, supaya saya cepat menemukan yang ingin dibaca.

**P2 · Membaca seri dengan mudah.** Sebagai pembaca, saya ingin melihat posisi tulisan dalam serinya dan pindah ke
bagian lain dengan mudah, tapi bisa menyembunyikan navigasi itu saat ingin fokus membaca.

**P3 · Nyaman di mana saja.** Sebagai pembaca, saya ingin blog enak dibaca di ponsel maupun desktop, dalam mode gelap
maupun terang.

**P4 · Pembaca berbahasa Inggris.** Sebagai pembaca berbahasa Inggris, saya ingin bisa memakai blog dalam bahasa
Inggris dan tahu tulisan mana yang sudah diterjemahkan.

**P5 · Mencari tulisan.** Sebagai pembaca, saya ingin mencari tulisan berdasarkan kata kunci.

**P6 · Alamat rapi tanpa link putus.** Sebagai penulis, saya ingin alamat tulisan rapi dan konsisten, tanpa membuat
link lama yang sudah tersebar menjadi mati.

## Skenario terima

**Beranda (P1)**
1. Kalau pembaca membuka beranda, maka yang tampil pertama adalah satu baris perkenalan, lalu daftar tulisan dari
   yang terbaru: tanggal, tag, seri, judul, ringkasan, dan tautan untuk membaca. Tidak ada banner besar.
2. Kalau pembaca memilih tag (mis. python), maka daftar hanya menampilkan tulisan dengan tag itu.
3. Kalau tulisan lebih banyak dari satu halaman, maka ada tombol untuk menampilkan tulisan yang lebih lama.

**Tulisan dan seri (P2)**
4. Kalau pembaca membuka tulisan yang termasuk seri, maka di samping kiri tampil daftar semua bagian seri, bagian yang
   sedang dibuka disorot, dan daftar isi tulisan itu tampil di bawahnya.
5. Kalau pembaca menekan tombol sembunyikan navigasi, maka navigasi seri tertutup, tulisan bergeser ke tengah, dan
   tersisa tombol kecil untuk membukanya lagi.
6. Kalau tulisan tidak termasuk seri, maka tidak ada navigasi seri dan tulisan tampil di tengah.
7. Di akhir tulisan berseri ada tautan ke bagian sebelumnya dan berikutnya.

**Ponsel dan mode tampilan (P3)**
8. Kalau dibuka di ponsel, maka menu menjadi satu tombol, tidak ada geser ke samping, dan navigasi seri menjadi kartu
   "seri" yang bisa dibuka-tutup di atas tulisan.
9. Kalau perangkat pembaca memakai mode gelap, maka blog tampil gelap; kalau terang, blog tampil terang.
10. Kalau pembaca menekan tombol ganti mode, maka mode berubah, dan pilihan itu diingat saat ia kembali dengan
    perangkat yang sama.

**Dua bahasa (P4)**
11. Kalau pembaca menekan tombol bahasa, maka ia pindah ke halaman yang sama dalam bahasa lain; menu, tombol, dan label
    ikut berganti bahasa.
12. Kalau di versi Inggris ada tulisan yang belum diterjemahkan, maka tulisan itu tetap muncul dengan penanda "ID" dan
    membuka versi Indonesianya.
13. Kalau tulisan punya versi Inggris, maka versi Inggrisnya yang tampil di beranda Inggris, dan kedua versi saling
    menautkan.

**Pencarian (P5)**
14. Kalau pembaca menekan tombol cari dan mengetik kata kunci, maka muncul tulisan yang cocok dalam bahasa halaman
    yang sedang dibuka.
15. Kalau JavaScript di browser pembaca mati, maka tombol cari tidak tampil, sementara semua tulisan tetap bisa dibaca.

**Alamat (P6)**
16. Tulisan beralamat `/tulisan/<judul>/` (Indonesia) dan `/en/posts/<judul>/` (Inggris); seri `/seri/…`, tag
    `/tag/…`, halaman `/tentang/` dan `/kontak/` (Inggris: `/en/series/…`, `/en/tags/…`, `/en/about/`,
    `/en/contact/`).
17. Kalau seseorang membuka alamat lama (mis. `/article/python/basic/dictionary/` atau `/page/tentang-saya/`), maka ia
    langsung diarahkan ke alamat barunya.
18. Halaman contoh bawaan tampilan lama yang bukan tulisan owner tidak ada lagi di situs.

## Aturan

- Semua halaman mengikuti standar tampilan blog (constitution #6, Theme K1–K3), termasuk halaman tentang saya, kontak,
  daftar seri, daftar tag, dan halaman tidak ditemukan.
- Bahasa utama Indonesia; situs tidak otomatis berpindah bahasa berdasarkan perangkat pembaca.
- Terjemahan isi tulisan bersifat opsional per tulisan; teks tampilan (menu, tombol, label) selalu tersedia dua bahasa.
- Tidak ada kolom komentar.
- Tidak ada layanan pihak luar yang wajib hidup: pencarian berjalan di situs sendiri, tanpa pelacak (constitution #4,
  #5). Pencarian pihak luar yang lama dicopot.
- Isi tulisan tidak diubah (constitution #2); yang berubah hanya tampilan dan alamatnya.
- Bagian galeri yang kosong dihapus.
- Bagian bawah halaman memuat tautan GitHub, LinkedIn, Medium ([alamat profil Medium — dari owner]), dan RSS.
- Teks bisa dibaca dengan kontras cukup di kedua mode, semua tombol bisa dipakai dengan keyboard (constitution #7).

## Kriteria sukses

- Owner membuka beranda, satu tulisan seri, dan halaman tentang saya di ponsel dan desktop, dalam mode gelap dan
  terang, dan semuanya sesuai mockup yang dipilih.
- Owner membuka beberapa alamat lama dan selalu sampai di tulisan yang benar.
- Owner berpindah ke bahasa Inggris dan melihat menu berbahasa Inggris serta tulisan berpenanda "ID".
- Owner mencari "dictionary" dan menemukan tulisannya.

## Di luar cakupan

- Memindahkan tulisan dari Medium (#6) dan menerjemahkan isi tulisan yang sudah ada.
- Menerbitkan otomatis ke situs live (#7) — tampilan baru baru terlihat di situs live setelah #7 selesai.
- Membersihkan hasil jadi lama yang tersimpan di repo (#8).
- Kolom komentar, langganan email, dan statistik pengunjung.
