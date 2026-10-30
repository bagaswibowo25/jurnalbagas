# Plan — Tulisan baru: menyalakan PC dari mana saja dengan ESP32 dan Telegram (#18)

## 1. Ringkasan pendekatan

Satu page bundle baru `content/tulisan/menyalakan-pc-dengan-esp32-telegram/` berisi `index.md` (isi persis dari draf
owner di Claude Docs) dan `index.en.md` (terjemahan Inggrisnya), plus aset: animasi `demo-tombol-boot.gif` (dipakai
bersama) dan diagram alur perintah sebagai SVG statis (versi id dan en). Seri baru `home-lab` dibuat lewat term bundle
`content/series/home-lab/`. Tidak ada perubahan layout/CSS: seri, dua bahasa, tag, pencarian, dan blok kode yang bisa
digeser sudah ada sejak #5/#6/#16. Cek otomatis ditambah di `tests/build-checks.sh` dan `tests/ui/site.spec.mjs`;
cek lama yang memakai jumlah tetap atau "tulisan teratas" (#16) disesuaikan.

## 2. Cek constitution

| Prinsip | | Catatan |
|---|---|---|
| 2 Tulisan milik penulis | ✅ | Isi id disalin apa adanya dari draf owner; en = terjemahan. Hanya konversi format (markdown, gambar). |
| 3 Alamat tidak putus | ✅ | Hanya alamat baru. |
| 4 Statis, tanpa server | ✅ | GIF dan SVG disimpan di bundle; tautan ke GitHub hanya link biasa. |
| 5 Ringan, tanpa pelacak | ⚠️ | GIF ±3,4 MB (400 px, 8 fps, 19 detik) — sedikit lebih berat dari GIF #16 (2,6 MB); diterima di spec. Diletakkan di tengah tulisan (akhir Tahap 1), bukan di atas. |
| 6 Standar tampilan | ✅ | Tanpa pola baru. Diagram = gambar biasa dengan latar putih sendiri, sama seperti diagram #16. |
| 7 Aksesibel | ✅ | GIF dan diagram diberi teks alternatif yang menjelaskan isinya; judul bagian rapi (h2/h3). |
| 8 Keputusan epic | ✅ | Content K2 (tag topik), K7 (seri home-lab, id + en). |
| 9 Skenario dicek otomatis | ✅ | §8. |

## 3. Bagian yang disentuh

- `content/tulisan/menyalakan-pc-dengan-esp32-telegram/` — `index.md`, `index.en.md`, `demo-tombol-boot.gif`,
  `alur-wake.svg`, `wake-flow.en.svg`.
- `content/series/home-lab/_index.md`, `_index.en.md`.
- `tests/build-checks.sh`, `tests/ui/site.spec.mjs`.
- `docs/epics/content.md` sudah diperbarui saat spec (K7, peta spec).

## 4. Konten dan front matter

```yaml
# index.md
title: "Menyalakan PC dari Mana Saja dengan ESP32 dan Telegram"
date: 2026-10-30T22:00:00+07:00
slug: menyalakan-pc-dengan-esp32-telegram
tags: ["esp32", "iot", "telegram", "wake-on-lan"]
series: ["home-lab"]
part: 1
short: "Wake-on-LAN via Telegram"
summary: <kalimat pertama bagian Cerita>
# index.en.md — sama, kecuali:
title: "Wake Your PC from Anywhere with an ESP32 and Telegram"
slug: wake-pc-with-esp32-telegram
short: "Wake-on-LAN via Telegram"
```

- Judul diambil dari judul draf tanpa awalan "Draf:".
- Subjudul tulisan memakai `#`/`##` (render hook menurunkan satu tingkat, catatan #16): bagian draf `##` → `#`,
  `###` → `##`.
- Diagram: widget draf (760×330, horizontal) ditulis ulang sebagai SVG statis vertikal ±360 px agar teks terbaca di
  ponsel (pelajaran #16), warna tetap seperti diagram #16 (latar `#FFFFFF`, garis `#666`, aksen `#1E3A8A`, teks
  `#0A0A0A`/`#555`). Label en diterjemahkan di `wake-flow.en.svg`.
- GIF: hasil konversi rekaman owner `20261030_094511.mp4` (400 px, 8 fps, 96 warna, 3,4 MB), sudah dicek bebas data
  pribadi.
- Tabel hasil pengujian, blok kode (bash, cpp, log konsol, percakapan bot) dipertahankan sebagai markdown.
- Tautan repo: `https://github.com/bagaswibowo25/esp32-wol-telegram` (publik, dicek 2026-10-30).
- Pertanyaan terbuka di akhir draf (tautan repo) diganti tautan repo itu sendiri, bukan disalin sebagai checklist.

## 5. URL, SEO, dan feed

| Alamat baru | Isi |
|---|---|
| `/tulisan/menyalakan-pc-dengan-esp32-telegram/` | versi id |
| `/en/posts/wake-pc-with-esp32-telegram/` | versi en |
| `/seri/home-lab/`, `/en/series/home-lab/` | halaman seri |
| `/tag/{esp32,iot,telegram,wake-on-lan}/`, `/en/tags/…` | halaman tag |

Tidak ada alamat lama yang berubah, tidak perlu alias. RSS, sitemap, `index.json` ikut otomatis.

## 6. Tampilan

Tidak ada perubahan layout. Yang dicek: blok kode dan tabel hasil pengujian bergeser di dalam kotaknya di ponsel; GIF
dan SVG mengikuti `img { max-width: 100% }`.

## 7. Build dan deploy

Tidak ada perubahan. Terbit otomatis lewat workflow deploy saat merge ke `master`.

## 8. Strategi cek otomatis

| Skenario | Cek |
|---|---|
| 1 beranda | build-checks: entri pertama beranda id/en = tulisan ini; cek #16 S1 "teratas" → "tampil di beranda"; jumlah tulisan en beranda 4 → 5 |
| 2 pindah bahasa | build-checks: `hreflang` id↔en + tombol bahasa ke pasangannya |
| 3 navigasi seri | build-checks: `series-list` berisi 1 tautan ke tulisan ini, bagian aktif |
| 4 daftar seri | build-checks: `/seri/` dan `/en/series/` memuat `home-lab` |
| 5 tag | build-checks: keempat halaman tag id + en ada dan memuat tulisan ini |
| 6 pencarian | build-checks: indeks id 9 → 10, en 4 → 5, memuat tulisan ini; UI: cari "esp32" di id dan "wake-on-lan" di en |
| 7 isi | build-checks: jumlah h2, `pre`, tabel, `img` (GIF + SVG) di isi tulisan, tautan repo, semua `<img>` punya `alt` |
| 8 ponsel | UI: kedua alamat + `/seri/home-lab/` masuk daftar `PAGES` (tanpa geser samping 320–768 px) + blok kode bergeser |
| 9 tanpa data pribadi | build-checks: isi tulisan tanpa `/home/`, `@gmail`, `@outlook`, pola token bot, alamat MAC selain contoh |

UI "tampilkan lebih lama" 12 → 13 tulisan.

## 9. Risiko dan rollback

- GIF berat di jaringan lambat → bila owner keberatan setelah terbit, issue baru untuk pola "video pendek".
- Draf owner berubah lagi setelah plan → isi disalin ulang dari doc sebelum PR.
- Rollback: revert PR (hanya konten + cek).

## 10. Catatan pengerjaan
