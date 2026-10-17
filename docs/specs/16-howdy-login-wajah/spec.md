---
issue: 16
epic: Content
---
# Spec — Tulisan baru: login pakai wajah (Howdy) di openSUSE

## Latar

Owner berhasil membuat login pakai wajah, mirip Windows Hello, di laptopnya (Lenovo IdeaPad Slim 5, openSUSE Leap
16.1, dual-boot dengan Windows). Alatnya Howdy. Hasilnya tidak instan: lampu inframerah kamera tidak menyala di Linux,
alat yang biasa dipakai untuk menyalakannya gagal, sampai akhirnya ketemu cara menyalakannya sendiri. Setelah itu
masih ada beberapa jebakan khas openSUSE (pengaturan yang tertimpa saat pasang ulang, SELinux yang menolak kamera di
layar login).

Pengalaman ini belum ada di blog, dan panduan Howdy untuk openSUSE dengan kamera seperti ini jarang. Owner ingin
menuliskannya sebagai tulisan pertama di seri baru **linux-tips**.

## Cerita pengguna

**P1 · Bisa mengikuti sampai berhasil.** Sebagai pembaca yang memakai openSUSE (atau Linux lain) di laptop berkamera
inframerah, saya ingin panduan langkah demi langkah yang bisa saya salin, supaya saya bisa login, membuka layar
terkunci, dan menjalankan sudo dengan wajah.

**P2 · Tahu kenapa, bukan hanya caranya.** Sebagai pembaca, saya ingin tahu apa yang dicoba, apa yang gagal, dan
kenapa, supaya saya bisa menyesuaikan bila laptop saya berbeda.

**P3 · Tahu risikonya dan cara mundur.** Sebagai pembaca, saya ingin tahu batas keamanannya dan cara mematikan atau
menghapus semuanya, supaya saya tidak terkunci dari laptop sendiri.

**P4 · Dua bahasa.** Sebagai pembaca berbahasa Indonesia maupun Inggris, saya ingin membaca tulisan ini dalam bahasa
saya.

## Skenario terima

1. Kalau pembaca membuka beranda Indonesia, maka tulisan ini tampil paling atas (tulisan terbaru) dengan judul
   Indonesia; di beranda Inggris tampil versi Inggrisnya.
2. Kalau pembaca membuka tulisan ini, maka ia bisa berpindah ke versi bahasa lainnya.
3. Kalau pembaca membuka tulisan ini, maka di samping tampil navigasi seri **linux-tips** dengan tulisan ini sebagai
   bagian 1.
4. Kalau pembaca membuka daftar seri (Indonesia maupun Inggris), maka seri linux-tips ikut tampil.
5. Kalau pembaca menekan tag topik tulisan ini (linux, opensuse, howdy, security), maka tulisan ini muncul di
   daftarnya.
6. Kalau pembaca mencari "howdy" atau "opensuse", maka tulisan ini muncul.
7. Kalau tulisan dibuka, maka isinya sama dengan draf yang disetujui owner: cerita singkat → mengenali kamera
   inframerah → jalan buntu dengan alat penyala lampu inframerah → kunci: pengaturan bawaan Windows Hello di kamera
   (dengan diagram siklusnya) → memasang Howdy → SELinux di layar login (dengan animasi hasilnya) → hasil dan
   trade-off → kesimpulan dan tautan ke repo.
8. Kalau tulisan dibuka di ponsel, maka perintah dan potongan kode yang panjang bisa digeser di dalam kotaknya sendiri
   tanpa membuat halaman ikut bergeser.
9. Kalau tulisan dibuka, maka tidak ada data pribadi: nama pengguna, nama komputer, nomor seri perangkat, atau alamat
   folder pribadi owner.

## Aturan

- Isi dari pengalaman nyata owner pada 17 Oktober 2026; angka dan pesan error diambil dari catatan sesi itu, bukan
  dikarang.
- Isi tulisan diambil dari draf yang sudah owner sunting (dokumen draf di Claude, 17 Oktober 2026); agent hanya
  memindahkannya ke blog tanpa mengubah kalimat (constitution #2).
- Bahasa Indonesia dan Inggris berisi sama; versi Inggris terjemahan versi Indonesia, bukan tulisan terpisah.
- Perbaikan kecil pada Howdy, modul SELinux, dan alat ceknya ditautkan ke repo GitHub owner `howdy-setup-suse`, yang
  dibuat publik oleh owner sebelum tulisan terbit.
- Seri baru **linux-tips** untuk tips Linux berikutnya; tulisan ini bagian 1 (keputusan owner baru, Content K6).
- Tag mengikuti topik (Content K2).
- Ada satu animasi singkat (±8 detik) dari rekaman owner: laptop terkunci lalu terbuka dengan wajah. Animasinya
  disimpan di blog sendiri, punya teks alternatif, dan cukup ringan untuk ponsel (±2,6 MB). Selain itu tulisan berupa
  teks, perintah, potongan kode, dan diagram siklus lampu inframerah.

## Kriteria sukses

- Owner membaca kedua versi dan setuju isinya akurat dan nyaman dibaca.
- Owner melihat tulisan ini di kedua beranda, di daftar seri linux-tips, dan di tag-tagnya.

## Di luar cakupan

- Panduan untuk distro selain openSUSE atau kamera tanpa pengaturan inframerah ala Windows Hello. Perbedaannya hanya
  disinggung.
- Mengirim perbaikan Howdy ke proyek aslinya.
- Mengubah visibilitas repo `howdy-setup-suse` (dilakukan owner sendiri).
- Tulisan lanjutan di seri linux-tips.
