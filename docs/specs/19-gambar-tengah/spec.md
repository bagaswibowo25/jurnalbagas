---
issue: 19
epic: Theme
---
# Spec — Gambar di dalam tulisan ditampilkan di tengah

## Latar

Gambar di dalam tulisan yang lebih sempit dari kolom tulisan sekarang menempel di kiri, menyisakan ruang kosong di
kanan. Ini terlihat jelas di tulisan Wake-on-LAN (diagram alur dan animasi demo tombol) dan di tulisan login wajah
Howdy. Owner ingin gambar seperti itu tampil di tengah supaya tulisan terlihat lebih rapi dan seimbang.

## Cerita pengguna

**P1 · Gambar rapi di tengah.** Sebagai pembaca, saya ingin gambar, diagram, dan animasi di dalam tulisan berada di
tengah kolom, supaya halaman terlihat seimbang dan gambar mudah diperhatikan.

## Skenario terima

1. Kalau pembaca membuka tulisan yang gambarnya lebih sempit dari kolom tulisan (mis. diagram dan animasi di tulisan
   Wake-on-LAN dan Howdy), maka gambar itu tampil di tengah kolom, di versi Indonesia maupun Inggris.
2. Kalau gambar selebar kolom atau lebih lebar, maka gambar tetap memenuhi lebar kolom seperti sekarang, tidak
   melebihi layar.
3. Kalau tulisan dibuka di ponsel, maka gambar tetap muat di layar dan halaman tidak ikut bergeser ke samping.
4. Kalau pembaca memakai mode gelap atau terang, maka posisi gambar sama.
5. Kalau tulisan tidak punya gambar, maka tampilannya tidak berubah.

## Aturan

- Berlaku untuk semua gambar di dalam isi tulisan, termasuk tulisan lama (dari Medium dan seri Python Dasar).
- Hanya posisi gambar yang berubah: ukuran, sudut membulat, dan teks alternatif gambar tetap seperti sekarang.
- Gambar di luar isi tulisan (logo, ikon, dan sejenisnya) tidak ikut berubah.
- Tetap mengikuti standar tampilan Theme K1 dan mode gelap/terang K3.

## Kriteria sukses

- Owner membuka tulisan Wake-on-LAN dan Howdy di desktop dan ponsel, dan melihat diagram serta animasinya di tengah.

## Di luar cakupan

- Keterangan (caption) di bawah gambar.
- Mengubah ukuran gambar atau membuat gambar bisa diperbesar saat diklik.
