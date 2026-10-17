---
issue: 6
---
# Tasks — Memindahkan tiga tulisan Medium ke blog

## Persiapan
- [ ] T1 [SH] Ambil feed + hitung elemen sumber (pre/img/heading/li/blockquote) per tulisan — feed Medium

## P1 · Semua tulisan di satu tempat
- [ ] T2 [CONTENT] Konversi 3 tulisan (pandoc) + front matter (tanggal asli, tag topik, `medium`) — `content/tulisan/*/index.en.md`
- [ ] T3 [CONTENT] Unduh gambar ke bundle, buang piksel statistik, isi bahasa blok kode — `content/tulisan/*/`
- [ ] T4 [SH] Cek skenario 5, 6, 10 — `tests/build-checks.sh`

## P2 · Pembaca menemukan dan membacanya
- [ ] T5 [THEME] Feed id memuat tulisan bahasa lain tanpa terjemahan, lencana = nama bahasa — `layouts/_partials/feed-pages.html`, `layouts/_partials/post-entry.html`
- [ ] T6 [SH] Cek skenario 1, 2, 8, 9 + sesuaikan cek lama S1/S12/S14 — `tests/build-checks.sh`
- [ ] T7 [SH] Test UI: S7 ketiga alamat di 320–768px, S9 cari helm/zuul, S3 disesuaikan — `tests/ui/site.spec.mjs`

## P3 · Sumber asli jelas
- [ ] T8 [THEME] Catatan "First published on Medium" + tautan — `layouts/page.html`, `i18n/`
- [ ] T9 [SH] Cek skenario 3, 4 — `tests/build-checks.sh`

## Penutup
- [ ] T10 [DOC] Front matter `medium` + aturan lencana — `docs/reference/system.md`
- [ ] T11 [SH] `scripts/build.sh ui` hijau; baca ketiga tulisan sekali vs Medium
- [ ] T12 [GH] `scripts/worktree.sh diff` bersih, PR dibuka (`Closes #6`)
