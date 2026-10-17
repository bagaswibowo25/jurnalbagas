---
issue: 8
epic: Infra
---
# Spec — Merapikan isi repo tanpa mengubah situs

## Latar

Repo blog masih menyimpan banyak sisa yang tidak dipakai: hasil jadi situs dari masa lalu (±16 MB), tema lama yang
sudah diganti, sisa konfigurasi lama, satu foto yang tidak tampil di mana pun, dan tiga cabang lama di GitHub. Sisa
ini membuat repo berat dan membingungkan, dan sudah menimbulkan masalah nyata: saat owner melihat pratinjau lokal,
hasil jadi situs ikut tersimpan ke repo bersama perubahan lain (#5, #6).

Situs live tidak bergantung pada sisa ini — sejak #7 situs disusun ulang dari awal setiap terbit. Jadi pembersihan ini
tidak boleh mengubah apa pun yang dilihat pembaca.

## Cerita pengguna

**P1 · Situs tetap sama.** Sebagai pembaca, saya tidak merasakan perubahan apa pun: semua halaman, alamat, dan gambar
tetap ada.

**P2 · Repo bersih.** Sebagai penulis, saya ingin repo hanya berisi bahan situs (tulisan, tampilan, pengaturan) dan
alat kerja, supaya ringan dan jelas.

**P3 · Pratinjau tidak mengotori repo.** Sebagai penulis, saya ingin bisa melihat pratinjau lokal kapan saja tanpa ada
file di repo yang ikut berubah.

## Skenario terima

1. Kalau situs disusun setelah pembersihan, maka daftar halaman, alamat (termasuk pengalihan alamat lama), dan gambar
   sama persis dengan sebelum pembersihan.
2. Kalau owner membuka repo, maka hasil jadi situs lama, tema lama, sisa konfigurasi lama, dan foto yang tidak dipakai
   sudah tidak ada.
3. Kalau pratinjau lokal dijalankan lalu dihentikan, maka tidak ada satu pun file di repo yang berubah atau bertambah.
4. Kalau situs disusun untuk pengecekan atau terbit, maka hasil jadinya tidak bisa ikut tersimpan ke repo secara tidak
   sengaja.
5. Kalau owner membuka daftar cabang di GitHub, maka hanya ada cabang utama dan cabang hasil jadi yang disajikan
   GitHub Pages.
6. Kalau perubahan ini terbit, maka situs live tetap dapat dibuka seperti biasa dan versi yang terbit adalah versi
   terbaru.

## Aturan

- Situs live tidak boleh berubah tampilan maupun isinya (constitution #3: alamat tidak putus).
- Cabang hasil jadi yang disajikan GitHub Pages tidak disentuh (Infra K3).
- Tiga cabang lama (deploy 2022, cabang lama 2022, cabang Mei 2026) dihapus langsung tanpa arsip (Infra K4).
- Foto profil yang tidak dipakai dihapus; bila nanti ingin dipakai, lewat issue baru dengan mockup (Infra K5).
- Riwayat repo tidak ditulis ulang — file lama tetap bisa dilihat di riwayat.

## Kriteria sukses

- Owner melihat repo berisi folder yang semuanya dipakai, dan ukurannya jauh lebih kecil.
- Owner menjalankan pratinjau lokal, menutupnya, dan tidak ada perubahan yang perlu disimpan.
- Daftar cabang di GitHub hanya berisi dua cabang.

## Di luar cakupan

- Mengecilkan riwayat repo (menghapus file besar dari riwayat lama).
- Perubahan tampilan atau isi situs.
