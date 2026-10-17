---
issue: 7
epic: Infra
---
# Spec — Situs terbit otomatis lagi setiap ada perubahan

## Latar

Setiap perubahan di blog (tulisan baru, perbaikan, tampilan) seharusnya langsung tampil di www.jurnalbagas.com
setelah disetujui dan digabungkan. Saat ini proses terbit otomatis itu mati: mesin yang dulu dipakai untuk menyusun
situs sudah dihentikan oleh GitHub, sehingga setiap percobaan menggantung lalu dibatalkan setelah sehari. Akibatnya
situs live terakhir diperbarui 28 Maret 2026, dan apa pun yang digabungkan sesudahnya — termasuk redesign dan tulisan
baru nanti — tidak akan pernah sampai ke pembaca.

Situs saat ini disajikan GitHub Pages dari satu cabang khusus berisi hasil jadi situs. Cara itu dipertahankan, jadi
pengaturan GitHub Pages tidak perlu diubah.

## Cerita pengguna

**P1 · Terbit otomatis.** Sebagai penulis, saya ingin setiap perubahan yang sudah digabungkan otomatis tampil di
situs dalam beberapa menit, supaya saya cukup menulis dan menyetujui, tanpa langkah manual untuk menerbitkan.

**P2 · Situs tetap aman saat gagal.** Sebagai pembaca, saya ingin situs tetap bisa dibuka seperti biasa walaupun ada
perubahan yang gagal disusun, supaya saya tidak pernah menemukan halaman rusak atau kosong.

**P3 · Terbit ulang manual.** Sebagai penulis, saya ingin bisa menerbitkan ulang situs dengan satu tombol, supaya bisa
memulihkan situs tanpa menunggu ada perubahan baru.

## Skenario terima

1. Kalau sebuah perubahan digabungkan ke cabang utama, maka dalam ±10 menit situs live menampilkan versi baru itu.
2. Kalau penyusunan situs gagal, maka situs live tetap menampilkan versi terakhir yang berhasil, dan kegagalannya
   terlihat di daftar proses terbit di GitHub.
3. Kalau beberapa perubahan digabungkan berdekatan, maka yang akhirnya tampil adalah versi paling baru, dan dua proses
   terbit tidak pernah menimpa situs bersamaan.
4. Kalau owner menekan tombol terbit ulang di GitHub, maka situs disusun dan diterbitkan ulang dari cabang utama.
5. Kalau perubahan hanya menyentuh dokumen kerja (spec, aturan, catatan) tanpa mengubah isi situs, maka situs tetap
   diterbitkan dengan hasil yang sama — tidak ada halaman yang hilang.
6. Kalau ada cabang kerja lain yang di-push, maka tidak ada proses terbit yang berjalan (hanya cabang utama yang
   diterbitkan), dan tidak ada lagi proses yang menggantung seharian.
7. Kalau situs selesai diterbitkan, maka domain www.jurnalbagas.com tetap mengarah ke situs ini dan alamat tulisan
   yang sudah ada tetap bisa dibuka.

## Aturan

- Situs tetap statis di GitHub Pages, tanpa server (constitution #4, Infra K1).
- Cara penyajian GitHub Pages yang sekarang (dari cabang hasil jadi) tidak diubah.
- Versi alat penyusun situs dipatok sama dengan yang dipakai saat pengecekan sebelum digabung, supaya yang lolos
  pengecekan pasti bisa terbit.
- Hasil jadi situs hanya diperbarui oleh proses terbit otomatis, tidak diubah dengan tangan.
- Alamat tulisan lama tidak boleh putus (constitution #3).

## Kriteria sukses

- Owner menggabungkan satu perubahan kecil, lalu melihat perubahan itu di www.jurnalbagas.com tanpa langkah lain.
- Di halaman proses GitHub tidak ada lagi proses yang menggantung atau dibatalkan karena kehabisan waktu.
- Tombol terbit ulang tersedia dan berhasil dipakai sekali.

## Di luar cakupan

- Mengganti tampilan situs (redesign, #5) dan memindahkan tulisan Medium (#6).
- Membersihkan hasil jadi lama yang ikut tersimpan di cabang utama (#8).
- Pindah ke cara penyajian GitHub Pages yang baru (tanpa cabang hasil jadi).
- Notifikasi ke email atau chat saat terbit gagal.
