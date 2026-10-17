---
issue: 13
epic: Theme
---
# Spec — Navigasi atas muncul lagi saat scroll ke atas

## Latar

Navigasi atas (logo, menu, cari, ganti mode, ganti bahasa) saat ini ikut tergulung dan hilang begitu pembaca scroll
ke bawah. Untuk pindah halaman, mencari, atau ganti mode, pembaca harus scroll kembali sampai ke paling atas — terasa
merepotkan, terutama di tulisan panjang. Owner memilih perilaku "muncul saat scroll ke atas" dari mockup (Theme K9):
navigasi menyingkir selama pembaca membaca ke bawah, dan muncul lagi begitu pembaca scroll sedikit ke atas.

## Cerita pengguna

**P1 · Navigasi selalu mudah dicapai.** Sebagai pembaca, saya ingin navigasi atas muncul lagi begitu saya scroll ke
atas, di halaman mana pun dan seberapa jauh pun saya sudah membaca, supaya tidak perlu kembali ke paling atas.

**P2 · Membaca tanpa terganggu.** Sebagai pembaca, saya ingin navigasi menyingkir selama saya membaca ke bawah,
supaya layar — terutama di ponsel — dipakai untuk isi tulisan.

## Skenario terima

1. Kalau pembaca berada di bagian paling atas halaman, maka navigasi atas terlihat seperti sekarang.
2. Kalau pembaca scroll ke bawah melewati navigasi, maka navigasi menyingkir dengan halus.
3. Kalau pembaca lalu scroll ke atas sedikit saja, dari posisi mana pun, maka navigasi muncul lagi di bagian atas
   layar dan semua tombolnya bisa dipakai.
4. Kalau pembaca berada di halaman tulisan, maka bilah progres baca tetap terlihat di tepi atas layar, baik saat
   navigasi muncul maupun menyingkir.
5. Kalau pembaca di halaman tulisan berseri (desktop), maka navigasi seri di samping tidak pernah tertutup oleh
   navigasi atas: ia berada tepat di bawah navigasi saat navigasi muncul, dan naik ke atas saat navigasi menyingkir.
6. Kalau menu (ponsel) atau kotak pencarian sedang terbuka, maka navigasi tidak menyingkir.
7. Kalau pembaca berpindah ke bagian tertentu lewat daftar isi, maka judul bagian itu tidak tertutup navigasi.
8. Kalau dibuka di ponsel maupun desktop, mode gelap maupun terang, maka perilakunya sama.
9. Kalau JavaScript di browser pembaca mati, maka navigasi atas tetap menempel di atas (tidak pernah menyingkir), dan
   semua isi tetap terbaca.

## Aturan

- Perilaku navigasi mengikuti Theme K9; tampilan navigasi sendiri tidak berubah (constitution #6).
- Navigasi yang muncul tidak boleh menutupi isi yang sedang dituju (judul bagian, navigasi seri).
- Semua tombol navigasi tetap bisa dipakai dengan keyboard; saat pembaca berpindah dengan tombol Tab ke navigasi,
  navigasi muncul (constitution #7).
- Gerakan menyingkir/muncul halus dan singkat; pembaca yang mengatur perangkatnya untuk mengurangi animasi melihat
  navigasi berpindah tanpa animasi.

## Kriteria sukses

- Owner membaca tulisan panjang di ponsel, scroll ke bawah (navigasi menyingkir), lalu scroll sedikit ke atas dan
  langsung bisa menekan menu atau cari.
- Di desktop, bilah progres dan navigasi seri tetap terlihat rapi saat navigasi muncul/menyingkir.

## Di luar cakupan

- Mengubah isi atau tampilan navigasi atas.
- Tombol "kembali ke atas".
