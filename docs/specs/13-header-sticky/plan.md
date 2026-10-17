# Plan — Navigasi atas muncul lagi saat scroll ke atas (#13)

## 1. Ringkasan pendekatan

Header jadi `position: sticky; top: 0` di CSS (tanpa JS = selalu menempel, skenario 9). Skrip kecil
`assets/js/header.js` memberi kelas `header-hidden` pada `<html>` saat scroll ke bawah melewati tinggi header dan
mencabutnya saat scroll ke atas (ambang beberapa px), kecuali menu/kotak cari terbuka atau fokus keyboard ada di
header. Bilah progres baca dipindah jadi `position: fixed` di tepi atas layar (di atas header), sehingga selalu
terlihat. Sidebar seri dan target daftar isi memakai variabel `--header-h` (tinggi header, diukur JS) untuk posisi
`top` dan `scroll-margin-top`.

## 2. Cek constitution

| Prinsip | | Catatan |
|---|---|---|
| 2 Tulisan milik penulis | ✅ | Konten tidak disentuh. |
| 3 Alamat tidak putus | ✅ | Tidak ada perubahan URL. |
| 4 Statis, tanpa server | ✅ | CSS + JS kecil di situs sendiri. |
| 5 Ringan, tanpa pelacak | ✅ | Tanpa JS tetap jalan (header menempel); listener scroll `passive`. |
| 6 Standar tampilan | ✅ | Theme K9 dicatat di `docs/reference/design.md`; tampilan header tidak berubah. |
| 7 Aksesibel | ✅ | Fokus keyboard di header memunculkan header; `prefers-reduced-motion` tanpa animasi. |
| 8 Keputusan epic | ✅ | Theme K9. |
| 9 Skenario dicek otomatis | ✅ | §8, test UI Playwright. |

## 3. Bagian yang disentuh

`assets/css/main.css`, `assets/js/header.js` (baru), `layouts/baseof.html` (gabung JS), `tests/ui/site.spec.mjs`.

## 4. Konten dan front matter

Tidak ada.

## 5. URL, SEO, dan feed

Tidak ada.

## 6. Tampilan

- `.site-header`: sticky, latar `--bg`, `z-index` di atas isi, `transition: transform .2s`;
  `html.header-hidden .site-header { transform: translateY(-100%) }`.
- `.progress`: `position: fixed; top: 0` di atas header (selalu terlihat).
- `.series-nav { top: var(--header-h) }`, `html.header-hidden .series-nav { top: 0 }`, transisi `top`.
- `.content [id] { scroll-margin-top: calc(var(--header-h) + 16px) }`.
- `@media (prefers-reduced-motion: reduce)`: tanpa transisi.

## 7. Build dan deploy

Tidak ada perubahan.

## 8. Strategi cek otomatis

Test UI (`tests/ui/site.spec.mjs`):

| Skenario | Test |
|---|---|
| 1 | di posisi atas, header terlihat (`top = 0`) |
| 2, 3 | scroll ke bawah 800px → header di luar layar; scroll ke atas 40px → header terlihat, tombol bisa diklik |
| 4 | halaman tulisan: bilah progres di `top 0`, terlihat saat header muncul maupun menyingkir |
| 5 | desktop: `top` sidebar seri = bawah header saat header muncul, = 0 saat menyingkir; tidak saling menutup |
| 6 | ponsel: menu dibuka lalu scroll ke bawah → header tetap terlihat; kotak cari terbuka → header tetap |
| 7 | klik item daftar isi → judul bagian di bawah header (tidak tertutup) |
| 8 | skenario 2–3 dijalankan di 390px dan 1280px, gelap dan terang |
| 9 | `javaScriptEnabled: false` → setelah scroll, header tetap terlihat di atas |
| aturan | Tab ke header saat tersembunyi → header muncul; `reducedMotion: 'reduce'` → `transition-duration` 0 |

## 9. Risiko dan rollback

- Header sticky menambah layer di atas isi; z-index dijaga di bawah dialog pencarian dan menu. Rollback: revert PR.

## 10. Catatan pengerjaan

<!-- Diisi selama pengerjaan: "- YYYY-MM-DD — temuan teknis singkat". Bug/pekerjaan baru → issue baru. -->
