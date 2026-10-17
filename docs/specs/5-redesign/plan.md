# Plan — Tampilan baru Jurnal Bagas, dua bahasa (#5)

## 1. Ringkasan pendekatan

Tema `bilberry` (submodule) dicopot dan diganti tema sendiri di `layouts/` + `assets/` (tanpa folder `themes/`),
mengikuti `docs/reference/design.md`. Konfigurasi ditulis ulang ke `hugo.toml` dengan dua bahasa (id default, en),
permalink per bahasa, dan taksonomi `tags` + `series`. Konten dipindah ke page bundle `content/tulisan/<slug>/`
dengan `aliases` untuk semua alamat lama. Pencarian = indeks JSON per bahasa buatan Hugo + JavaScript kecil tanpa
library. Karena tema lama hilang, patokan Hugo dinaikkan dari 0.123.8 ke 0.154.5. Interaksi (sembunyikan navigasi,
ganti mode, ponsel) dibuktikan dengan test Playwright di Docker; sisanya dengan cek hasil build di `scripts/build.sh`.

## 2. Cek constitution

| Prinsip | | Catatan |
|---|---|---|
| 2 Tulisan milik penulis | ✅ | Isi markdown tidak diubah; hanya front matter (series, part, aliases) dan lokasi file. |
| 3 Alamat tidak putus | ✅ | Tabel §5: setiap alamat lama tulisan/halaman/tag punya alias; dicek otomatis. |
| 4 Statis, tanpa server | ✅ | Hugo statis; pencarian di browser dari JSON statis; Algolia dicopot. |
| 5 Ringan, tanpa pelacak | ✅ | Font IBM Plex di-host sendiri (bukan Google Fonts); JS hanya untuk mode, navigasi seri, cari — tanpa JS isi tetap terbaca. |
| 6 Standar tampilan | ✅ | Token warna/font/layout = `docs/reference/design.md`; semua halaman (404, tag, seri, tentang) memakai layout yang sama. |
| 7 Aksesibel | ⚠️ | Tulisan lama memakai `#` (h1) untuk subjudul → bentrok dengan h1 judul halaman. Diatasi render hook heading yang menurunkan level +1 tanpa mengubah isi markdown. Kontras token sudah ≥4.5:1 (cek di §8). |
| 8 Keputusan epic | ✅ | Theme K1–K7. |
| 9 Skenario dicek otomatis | ✅ | §8 — setiap skenario punya cek build atau test Playwright. |

## 3. Bagian yang disentuh

- Hapus: `.gitmodules`, `themes/bilberry-hugo-theme`, `config.toml`, `algolia/`, `content/gallery/`,
  `layouts/partials/favicon.html` (lama).
- Baru: `hugo.toml`, `i18n/id.toml`, `i18n/en.toml`, `layouts/` (baseof, home, list, single, taxonomy, term, 404,
  partials header/footer/series-nav/post-entry/search/lang-switch, render hook heading, alias), `assets/css/main.css`,
  `assets/js/{theme,series-nav,search}.js`, `static/fonts/` (IBM Plex Mono/Sans woff2, OFL), `content/tulisan/*`,
  `content/tentang/`, `content/kontak/`, `tests/ui/` (Playwright), `tests/fixture/` (konten uji dua bahasa).
- Ubah: `scripts/build.sh` (patok Hugo, cek per skenario, mode `ui`), `scripts/doctor.sh` (hapus cek tema),
  `docs/reference/system.md`.

## 4. Konten dan front matter

- `content/article/python/basic/<x>.md` + gambar → `content/tulisan/<slug>/index.md` + gambar di bundle yang sama.
- Front matter tulisan: `title`, `date` (tetap), `tags`, `series: [python-dasar]`, `part: <1–8>`, `summary` (diambil
  dari kalimat pertama — teks penulis, tidak ditulis ulang), `aliases`. `featuredImage`, `author`, `noSummary`
  dibuang (tidak dipakai desain; gambar tetap ada di bundle).
- Urutan seri dari `date`: 1 Tipe Data, 2 Kondisional, 3 Perulangan, 4 Fungsi, 5 List, 6 Tuple, 7 Set, 8 Dictionary.
- Halaman: `content/tentang/index.md` + `index.en.md`, `content/kontak/index.md` + `index.en.md` (isi dari
  `content/page/*`, gambar ikut pindah).
- Terjemahan tulisan nanti: `index.en.md` di bundle yang sama (+ `slug` Inggris).

## 5. URL, SEO, dan feed

Permalink: id `tulisan = "/tulisan/:slug/"`; en `tulisan = "/posts/:slug/"` (Hugo menambah `/en`). Term:
id `tags = "/tag/:slug/"`, `series = "/seri/:slug/"`; en `tags = "/tags/:slug/"`, `series = "/series/:slug/"`.

| Lama | Baru |
|---|---|
| `/article/python/basic/tipe_data/` | `/tulisan/belajar-python-tipe-data/` |
| `/article/python/basic/kondisional/` | `/tulisan/belajar-python-kondisional/` |
| `/article/python/basic/perulangan/` | `/tulisan/belajar-python-perulangan/` |
| `/article/python/basic/fungsi/` | `/tulisan/belajar-python-fungsi/` |
| `/article/python/basic/list/` | `/tulisan/belajar-python-list/` |
| `/article/python/basic/tuple/` | `/tulisan/belajar-python-tuple/` |
| `/article/python/basic/set/` | `/tulisan/belajar-python-set/` |
| `/article/python/basic/dictionary/` | `/tulisan/belajar-python-dictionary/` |
| `/page/tentang-saya/` | `/tentang/` |
| `/page/kontak/` | `/kontak/` |
| `/en/page/about-me/` | `/en/about/` |
| `/en/page/contact/` | `/en/contact/` |
| `/tags/python/`, `/tags/programming/` | `/tag/python/`, `/tag/programming/` |
| `/article/`, `/id/` | `/tulisan/`, `/` |

Redirect = `aliases` Hugo (halaman HTML dengan `meta refresh` + `rel=canonical`), satu file statis per alamat lama.
Alias tag/section via file konten `_index.md` dengan `aliases`. Halaman demo tema lama (`/audio/`, `/quote/`, `/de/`,
`/author/…`, `/categories/…`, `/page/about-bilberry/`, …) tidak dibuatkan alias → 404 sesuai spec 18.

RSS per bahasa (`/index.xml`, `/en/index.xml`), `sitemap.xml` multibahasa dengan `hreflang`, `<link rel=alternate
hreflang>` di halaman yang punya terjemahan. Output JSON per bahasa untuk pencarian (`/index.json`, `/en/index.json`).

## 6. Tampilan

- CSS custom properties dari token W9; `@media (prefers-color-scheme)` sebagai default, atribut `data-theme` pada
  `<html>` (diset JS dari `localStorage`) menimpa — tanpa JS tetap ikut perangkat.
- Beranda (L3): baris whoami, chip tag (link ke halaman tag), daftar entri (`[tanggal] tag seri`, judul mono, ringkasan,
  `cat <slug> →`), paginasi Hugo "tampilkan lebih lama" → `/page/2/`.
- Tulisan (AL2): sidebar seri (`series` + `part`) dengan daftar isi bagian aktif dari `.TableOfContents`; tombol
  sembunyikan menyetel `data-nav=hidden` (+ `localStorage`); rail kecil untuk membuka lagi. Tanpa JS sidebar tampil.
  Ponsel (<900px): sidebar diganti `<details>` "seri" di atas tulisan (jalan tanpa JS). Prev/next dari `part`.
- Versi Inggris: entri tulisan tanpa terjemahan diambil dari situs id, diberi lencana "ID" dan link ke versi id.
- Header: logo `~/jurnalbagas_`, nav, tombol cari (disembunyikan bila tanpa JS via kelas `no-js`), ganti mode, ganti
  bahasa (link ke `.Translations` atau beranda bahasa lain). Footer: GitHub, LinkedIn, Medium, RSS.

## 7. Build dan deploy

- `scripts/build.sh`: `HUGO_IMAGE` default → `hugomods/hugo:exts-0.154.5`; cek tema dihapus.
- Deploy memakai `scripts/build.sh` (#7), jadi patokan baru otomatis dipakai saat terbit. Tidak ada perubahan
  workflow di issue ini. Situs live baru berubah setelah #7 merged.

## 8. Strategi cek otomatis

Cek build (`scripts/build.sh`, grep pada `.build/`):

| Skenario | Cek |
|---|---|
| 1 | `index.html` memuat ≥8 entri `post-entry` berurutan tanggal, tanpa elemen hero |
| 2 | `/tag/python/index.html` ada dan hanya memuat tulisan bertag python |
| 3 | `/page/2/` ada saat `paginate` < jumlah tulisan (fixture) |
| 4, 6, 7 | `/tulisan/belajar-python-dictionary/` memuat `series-nav` dengan 8 item + item aktif + TOC; tulisan non-seri (fixture) tanpa `series-nav`; prev/next ke bagian 7 |
| 11, 13 | fixture dua bahasa: halaman en memuat `hreflang` + link ke versi id dan sebaliknya; menu en dari `i18n/en.toml` |
| 12 | `/en/index.html` memuat entri berlencana `ID` yang menaut ke `/tulisan/…` |
| 14 | `/index.json` dan `/en/index.json` valid dan hanya berisi tulisan bahasanya |
| 16 | semua alamat baru di tabel §5 ada |
| 17 | semua alamat lama di tabel §5 ada dan memuat `meta refresh` ke alamat baru yang benar |
| 18 | `/audio/`, `/quote/`, `/de/`, `/categories/`, `/author/`, `/gallery/` tidak ada |
| aturan | tidak ada `algolia`, `fonts.googleapis`, atau domain pihak ketiga lain di HTML/JS hasil build |

Test UI (`scripts/build.sh ui`, Playwright di Docker terhadap `hugo server`):

| Skenario | Test |
|---|---|
| 5 | klik sembunyikan → sidebar hilang, artikel di tengah, rail tampil; klik rail → kembali |
| 8 | viewport 390px: tombol menu, `scrollWidth ≤ clientWidth`, kartu seri buka-tutup |
| 9 | `colorScheme: dark/light` → warna latar sesuai token |
| 10 | klik ganti mode → berubah; reload → tetap |
| 14, 15 | ketik "dictionary" → hasil muncul; `javaScriptEnabled: false` → tombol cari tidak terlihat, tulisan terbaca |
| kontras | token teks vs latar ≥4.5:1 di kedua mode (hitung dari CSS) |

## 9. Risiko dan rollback

- Perubahan besar pada struktur konten: rollback = revert PR (alias belum terbit sebelum #7 jalan).
- `aliases` di bahasa non-default: pastikan alias en ditulis absolut (`/en/page/about-me/`); dicek skenario 17.
- Hugo 0.154 bisa menolak sintaks lama — tidak relevan karena template ditulis baru.
- Font self-host menambah ±200 KB; dibatasi 4 file woff2 (subset latin).

## 10. Catatan pengerjaan

<!-- Diisi selama pengerjaan: "- YYYY-MM-DD — temuan teknis singkat". Bug/pekerjaan baru → issue baru. -->
