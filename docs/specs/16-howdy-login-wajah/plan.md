# Plan — Tulisan baru: login pakai wajah (Howdy) di openSUSE (#16)

## 1. Ringkasan pendekatan

Satu page bundle baru `content/tulisan/windows-hello-di-opensuse/` berisi `index.md` (isi persis dari draf owner di
Claude Docs, rev 104) dan `index.en.md` (terjemahan Inggrisnya), plus dua aset bersama: animasi `login-wajah.gif` dan
diagram siklus emitter sebagai SVG statis (versi id dan en). Seri baru `linux-tips` dibuat lewat term bundle
`content/series/linux-tips/`. Tidak ada perubahan layout/CSS: semua yang dibutuhkan (seri, dua bahasa, tag, pencarian,
blok kode yang bisa digeser) sudah ada sejak #5/#6. Cek otomatis ditambah di `tests/build-checks.sh` dan
`tests/ui/site.spec.mjs`; satu cek lama #6 (jumlah tulisan en = 3) disesuaikan karena beranda en kini memuat 4.

## 2. Cek constitution

| Prinsip | | Catatan |
|---|---|---|
| 2 Tulisan milik penulis | ✅ | Isi id disalin apa adanya dari draf owner; en = terjemahan. Hanya konversi format (markdown, gambar). |
| 3 Alamat tidak putus | ✅ | Hanya alamat baru, tidak ada yang berubah. |
| 4 Statis, tanpa server | ✅ | GIF dan SVG disimpan di bundle; tautan ke GitHub hanya link biasa. |
| 5 Ringan, tanpa pelacak | ⚠️ | GIF ±2,6 MB — paling berat di situs. Diterima di spec (owner); `loading=lazy` tidak tersedia tanpa render hook, jadi GIF ditaruh di bagian bawah tulisan (SELinux) agar tidak menghambat bagian atas. Alternatif video ringan dicatat di §9. |
| 6 Standar tampilan | ✅ | Tanpa pola baru. Diagram adalah gambar biasa (SVG dengan latar putih sendiri, seperti tangkapan layar tulisan Medium). |
| 7 Aksesibel | ✅ | GIF dan diagram diberi teks alternatif yang menjelaskan isinya; judul bagian rapi (h2). |
| 8 Keputusan epic | ✅ | Content K2 (tag topik), K6 (seri linux-tips, id + en). |
| 9 Skenario dicek otomatis | ✅ | §8. |

## 3. Bagian yang disentuh

- `content/tulisan/windows-hello-di-opensuse/` — `index.md`, `index.en.md`, `login-wajah.gif`, `siklus-ir.svg`,
  `ir-cycle.en.svg`.
- `content/series/linux-tips/_index.md`, `_index.en.md`.
- `tests/build-checks.sh`, `tests/ui/site.spec.mjs`.
- `docs/epics/content.md` sudah diperbarui saat spec (K6, peta spec).

## 4. Konten dan front matter

```yaml
# index.md
title: "Windows Hello di openSUSE: Login Wajah dengan Howdy dan Kamera IR"
date: 2026-10-17T22:00:00+07:00
slug: windows-hello-di-opensuse
tags: ["linux", "opensuse", "howdy", "security"]
series: ["linux-tips"]
part: 1
short: "Login wajah Howdy"
summary: <kalimat pertama bagian Cerita>
# index.en.md — sama, kecuali:
title: "Windows Hello on openSUSE: Face Login with Howdy and an IR Camera"
slug: windows-hello-on-opensuse
short: "Howdy face login"
```

- Bundle dua bahasa → aset tanpa akhiran bahasa dipakai bersama (`login-wajah.gif`, `siklus-ir.svg`). Diagram versi
  Inggris diberi nama lain (`ir-cycle.en.svg`) supaya hanya terbit di versi en.
- Diagram: SVG dari widget draf (kode JSX di doc) ditulis ulang sebagai SVG statis 760×300, warna tetap (latar
  `#FFFFFF`, garis `#666`, aksen `#1E3A8A`, teks `#0A0A0A`/`#555`, font IBM Plex Sans/system) — terbaca di mode gelap
  maupun terang karena membawa latarnya sendiri.
- Tabel node video, blok kode (bash, PAM, audit log, CIL), daftar bernomor dan berbutir dipertahankan sebagai markdown.
- Tautan repo: `https://github.com/bagaswibowo25/howdy-setup-suse` (sudah publik, dicek 2026-10-17).
- Nama gambar: GIF dari `~/Downloads/video_2026-10-17_22-05-00.mp4` (360px, ±10 fps, 2,6 MB).

## 5. URL, SEO, dan feed

| Alamat baru | Isi |
|---|---|
| `/tulisan/windows-hello-di-opensuse/` | versi id |
| `/en/posts/windows-hello-on-opensuse/` | versi en |
| `/seri/linux-tips/`, `/en/series/linux-tips/` | halaman seri |
| `/tag/{linux,opensuse,howdy,security}/`, `/en/tags/…` | halaman tag |

Tidak ada alamat lama yang berubah, tidak perlu alias. RSS, sitemap, `index.json` ikut otomatis. Canonical = alamat
blog sendiri; hreflang saling menaut (sudah dari #5).

## 6. Tampilan

Tidak ada perubahan layout. Yang dicek: blok kode panjang (`meson setup …`, audit log) bergeser di dalam kotaknya di
ponsel; GIF dan SVG mengikuti `img { max-width: 100% }`; tabel node video muat di 320px.

## 7. Build dan deploy

Tidak ada perubahan. Terbit otomatis lewat workflow deploy saat merge ke `master`.

## 8. Strategi cek otomatis

| Skenario | Cek |
|---|---|
| 1 beranda | build-checks: entri pertama beranda id = judul id, beranda en = judul en; cek #6 "3 tulisan en" → 4 |
| 2 pindah bahasa | build-checks: `hreflang` id↔en + tombol bahasa ke pasangannya |
| 3 navigasi seri | build-checks: `series-list` berisi 1 tautan ke tulisan ini, bagian aktif |
| 4 daftar seri | build-checks: `/seri/` dan `/en/series/` memuat `linux-tips` |
| 5 tag | build-checks: keempat halaman tag id + en ada dan memuat tulisan ini |
| 6 pencarian | build-checks: `index.json` dan `en/index.json` memuat tulisan ini; UI: cari "howdy" di id dan "opensuse" di en |
| 7 isi | build-checks: jumlah h2, `pre`, `img` (GIF + SVG) di isi tulisan, tautan repo, semua `<img>` punya `alt` |
| 8 ponsel | UI: kedua alamat masuk daftar `PAGES` (tanpa geser samping 320–768px) + blok kode bergeser di kotaknya |
| 9 tanpa data pribadi | build-checks: isi tulisan (div `content`) tanpa `/home/`, `by-id`, `@gmail`, nama host |

## 9. Risiko dan rollback

- GIF berat di jaringan lambat → bila owner keberatan setelah terbit, issue baru untuk pola "video pendek" (butuh
  persetujuan tampilan).
- Draf owner berubah lagi setelah plan → isi disalin ulang dari doc sebelum PR.
- Rollback: revert PR (hanya konten + cek).

## 10. Catatan pengerjaan
