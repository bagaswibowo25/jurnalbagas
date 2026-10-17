---
issue: 5
---
# Tasks — Tampilan baru Jurnal Bagas, dua bahasa

## Persiapan
- [ ] T1 [CFG] Copot tema bilberry, submodule, Algolia, galeri, config lama — `.gitmodules`, `config.toml`
- [ ] T2 [CFG] `hugo.toml`: dua bahasa, permalink per bahasa, taksonomi, output JSON — `hugo.toml`
- [ ] T3 [SH] Patok Hugo 0.154.5, hapus cek tema — `scripts/build.sh`, `scripts/doctor.sh`
- [ ] T4 [THEME] Font IBM Plex self-host + token warna W9 — `static/fonts/`, `assets/css/main.css`
- [ ] T5 [THEME] Kerangka: baseof, header, footer, i18n id/en — `layouts/_default/baseof.html`, `i18n/`
- [ ] T6 [SH] Fixture konten uji (tulisan non-seri, tulisan dua bahasa, cukup untuk 2 halaman) — `tests/fixture/`

## P1 · Beranda yang langsung ke tulisan
- [ ] T7 [THEME] Beranda feed + chip tag + paginasi — `layouts/index.html`, `layouts/partials/post-entry.html`
- [ ] T8 [THEME] Halaman tag, seri, daftar tulisan — `layouts/_default/term.html`, `layouts/_default/list.html`
- [ ] T9 [SH] Cek skenario 1–3 — `scripts/build.sh`

## P2 · Membaca seri dengan mudah
- [ ] T10 [CONTENT] Pindah 8 tulisan ke bundle + series/part/summary — `content/tulisan/`
- [ ] T11 [THEME] Halaman tulisan + sidebar seri + TOC + prev/next — `layouts/_default/single.html`, `layouts/partials/series-nav.html`
- [ ] T12 [THEME] Render hook heading (h1 isi → h2) — `layouts/_default/_markup/render-heading.html`
- [ ] T13 [THEME] Sembunyikan/tampilkan navigasi seri — `assets/js/series-nav.js`
- [ ] T14 [SH] Cek skenario 4, 6, 7 — `scripts/build.sh`
- [ ] T15 [SH] Test UI skenario 5 — `tests/ui/`

## P3 · Nyaman di mana saja
- [ ] T16 [THEME] Responsif ponsel: menu tombol, kartu seri `<details>` — `assets/css/main.css`
- [ ] T17 [THEME] Mode gelap/terang + tombol + ingat pilihan — `assets/js/theme.js`
- [ ] T18 [SH] Test UI skenario 8–10 + kontras — `tests/ui/`

## P4 · Pembaca berbahasa Inggris
- [ ] T19 [CONTENT] Halaman tentang + kontak id/en — `content/tentang/`, `content/kontak/`
- [ ] T20 [THEME] Ganti bahasa + hreflang + lencana "ID" di beranda en — `layouts/partials/lang-switch.html`
- [ ] T21 [SH] Cek skenario 11–13 — `scripts/build.sh`

## P5 · Mencari tulisan
- [ ] T22 [THEME] Indeks JSON per bahasa + kotak cari — `layouts/index.json`, `assets/js/search.js`
- [ ] T23 [SH] Cek skenario 14 (build) + test UI 14–15 — `scripts/build.sh`, `tests/ui/`

## P6 · Alamat rapi tanpa link putus
- [ ] T24 [CONTENT] Aliases semua alamat lama (tabel plan §5) — `content/tulisan/*/index.md`, `content/*/_index.md`
- [ ] T25 [SH] Cek skenario 16–18 + tanpa domain pihak ketiga — `scripts/build.sh`

## Penutup
- [ ] T26 [DOC] Perbarui stack, struktur konten, temuan — `docs/reference/system.md`
- [ ] T27 [SH] `scripts/build.sh` + `scripts/build.sh ui` hijau; preview untuk owner (gelap/terang, desktop/ponsel)
- [ ] T28 [GH] `scripts/worktree.sh diff` bersih, PR dibuka (`Closes #5`)
