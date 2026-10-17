# Sistem — keadaan saat ini

> Rujukan teknis untuk plan. Perbarui halaman ini setiap kali stack, struktur konten, atau deploy berubah.
> Keadaan per 2026-10-17 (#4, #7, #5).

## Stack

- **Hugo** extended **0.154.5** (dipatok di `scripts/build.sh` lewat image Docker `hugomods/hugo:exts-0.154.5`).
  Konfigurasi: `hugo.toml`.
- **Tema sendiri** di `layouts/` (sistem template Hugo baru: `baseof.html`, `home.html`, `page.html`, `section.html`,
  `term.html`, `taxonomy.html`, `404.html`, `home.json`, `_partials/`, `_markup/`), `assets/css/main.css`,
  `assets/js/` (mode, navigasi seri, pencarian). Standar tampilan: `docs/reference/design.md`. Tidak ada `themes/`.
- **Font:** IBM Plex Mono/Sans woff2 di `static/fonts/` (OFL), tanpa Google Fonts.
- **Dua bahasa:** `id` (bawaan, di root) dan `en` (`/en/`). Teks tampilan di `i18n/`. Terjemahan tulisan =
  `index.en.md` di bundle yang sama (+ `slug` Inggris).
- **Konten:** `content/tulisan/<slug>/index.md` (page bundle + gambar). Front matter: `title`, `date`, `slug`, `tags`,
  `series`, `part`, `short` (label di navigasi seri), `summary`, `aliases`, `medium` (URL asli tulisan impor →
  catatan "First published on Medium"). Bundle yang hanya berisi satu bahasa non-bawaan (mis. hanya `index.en.md`)
  wajib memberi akhiran bahasa pada nama gambar (`img-01.en.png`) — tanpa itu Hugo tidak menerbitkan gambarnya. Saat
  versi id ditambahkan, hapus akhiran itu agar gambar dipakai bersama. Halaman: `content/tentang/`,
  `content/kontak/`. Term: `content/tags/<tag>/_index.md`, `content/series/<seri>/_index.md`.
- **Alamat:** id `/tulisan/:slug/`, `/tag/…`, `/seri/…`; en `/en/posts/:slug/`, `/en/tags/…`, `/en/series/…`.
  Alamat lama dialihkan lewat `aliases` (tabel di `docs/specs/5-redesign/plan.md` §5).
- **Feed lintas bahasa:** tiap beranda/daftar tulisan menampilkan tulisan bahasa lain yang belum diterjemahkan, dengan
  lencana nama bahasanya ("ID"/"EN") — `layouts/_partials/feed-pages.html`.
- **Pencarian:** `/index.json` dan `/en/index.json` (buatan Hugo) dibaca `assets/js/search.js` di browser.

## Build

- `scripts/build.sh` — build `hugo --minify` ke `.build/`, lalu cek hasilnya (`tests/build-checks.sh`, termasuk
  situs uji dari `tests/fixture/content` → `.build-fixture/`). `scripts/build.sh ui` menambah test browser
  (Playwright di Docker, `tests/ui/`). Memakai `hugo` lokal bila ada, kalau tidak lewat Docker.
- `public/` dan `resources/` saat ini ikut ter-commit di `master` (artefak lama). Jangan diubah manual; pembersihan
  lewat issue tersendiri.

## Deploy

- Domain `www.jurnalbagas.com` (file `CNAME`, juga di `static/`).
- GitHub Pages mode **legacy**: menyajikan branch **`prod`** apa adanya (Infra K3 — pengaturan Pages tidak diubah).
- `.github/workflows/deploy.yml` (#7): push ke `master` atau *Run workflow* → `scripts/build.sh` → publish `.build/`
  ke `prod` (`peaceiris/actions-gh-pages`, CNAME `www.jurnalbagas.com`) → tunggu `/version.txt` di situs live = SHA
  commit (maks 10 menit). `concurrency: deploy-prod` tanpa cancel + job `gate` (hanya HEAD `master` yang deploy).
- `/version.txt` = commit yang sedang terbit.

## Temuan terbuka

- Artefak build (`public/`, `resources/`) ter-commit di branch kerja.
