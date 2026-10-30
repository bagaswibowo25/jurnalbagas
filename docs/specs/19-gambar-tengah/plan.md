# Plan — Gambar di dalam tulisan ditampilkan di tengah (#19)

## 1. Ringkasan pendekatan

Satu aturan CSS: `.content img` menjadi `display: block; margin-inline: auto`. Semua gambar di isi tulisan sudah
dirender sendirian di dalam `<p>` (kadang diikuti keterangan `<em>` dari tulisan Medium), jadi menjadikannya blok
tidak memotong teks. `max-width: 100%` yang sudah ada tetap menjaga gambar lebar memenuhi kolom tanpa melebihi layar.
Cek UI ditambah untuk membuktikan gambar sempit berada di tengah dan gambar lebar tetap selebar kolom.

## 2. Cek constitution

| Prinsip | | Catatan |
|---|---|---|
| 2 Tulisan milik penulis | ✅ | Isi tidak disentuh. |
| 3 Alamat tidak putus | ✅ | Tidak ada alamat berubah. |
| 4 Statis, tanpa server | ✅ | Hanya CSS. |
| 5 Ringan, tanpa pelacak | ✅ | Satu baris CSS. |
| 6 Standar tampilan | ✅ | Sudut membulat dan ukuran tetap; hanya posisi. |
| 7 Aksesibel | ✅ | Teks alternatif tidak berubah; urutan baca sama. |
| 8 Keputusan epic | ✅ | Theme K1, K3. |
| 9 Skenario dicek otomatis | ✅ | §8. |

## 3. Bagian yang disentuh

- `assets/css/main.css` (aturan `.content img`).
- `tests/ui/site.spec.mjs`.

## 4. Konten dan front matter

Tidak ada.

## 5. URL, SEO, dan feed

Tidak ada.

## 6. Tampilan

- Gambar sempit (diagram 360 px, GIF 400 px di tulisan Wake-on-LAN; diagram dan GIF Howdy) di tengah kolom.
- Gambar lebar (tangkapan layar tulisan Medium) tetap selebar kolom.
- Keterangan `<em>` di bawah gambar Medium tetap rata kiri (keterangan di luar cakupan).
- Halaman Tentang memakai `.content` juga, jadi gambarnya ikut di tengah; tetap konsisten dengan aturan "gambar di
  isi halaman", bukan logo/ikon.
- Gelap dan terang tidak terpengaruh (tidak ada warna yang berubah).

## 7. Build dan deploy

Tidak ada perubahan.

## 8. Strategi cek otomatis

| Skenario | Cek |
|---|---|
| 1 gambar sempit di tengah | UI 1280 px: tiap gambar di isi tulisan Howdy dan Wake-on-LAN (id + en), jarak kiri dan kanan ke tepi kolom sama (selisih ≤ 1 px) |
| 2 gambar lebar | UI 1280 px: gambar pertama tulisan Zuul CI selebar kolom (selisih ≤ 1 px) |
| 3 ponsel | Sudah: daftar `PAGES` tanpa geser samping 320–768 px; #16 S8/#18 S8 gambar muat layar |
| 4 gelap/terang | Posisi tidak bergantung tema; UI dijalankan di skema bawaan |
| 5 tulisan tanpa gambar | Tidak ada elemen yang disentuh selain `img` |

## 9. Risiko dan rollback

- Gambar inline di tengah kalimat akan pindah ke baris sendiri. Saat ini tidak ada (dicek di hasil build: semua
  `<img>` sendirian di `<p>`). Rollback: revert PR.

## 10. Catatan pengerjaan

- Tulisan Wake-on-LAN (#18) belum ada di `master` saat branch ini dibuat (PR #20 belum di-merge), jadi cek UI memakai
  tulisan Howdy (id + en) yang gambarnya sama-sama sempit; aturan CSS-nya berlaku sama untuk tulisan #18.
- Setelah PR #20 masuk `master`, branch di-rebase (konflik hanya di tes UI, kedua sisi dipertahankan) dan cek S1 diperluas
  ke tulisan Wake-on-LAN (id + en).
