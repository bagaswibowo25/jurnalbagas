---
issue: 16
---
# Tasks — Tulisan baru: login pakai wajah (Howdy) di openSUSE

## Persiapan
- [x] T1 [CONTENT] Ambil isi terbaru draf owner dari Claude Docs (rev terbaru) — `content/tulisan/windows-hello-di-opensuse/index.md`
- [x] T2 [CONTENT] Seri baru linux-tips (id + en) — `content/series/linux-tips/_index.md`

## P1 · Bisa mengikuti sampai berhasil
- [x] T3 [CONTENT] Tulis `index.md` dari draf (front matter §4, tabel, blok kode, tautan repo) — `index.md`
- [x] T4 [CONTENT] Salin GIF login + teks alternatif — `login-wajah.gif`
- [x] T5 [SH] Cek skenario 1, 3, 4, 5, 7 — `tests/build-checks.sh`

## P2 · Tahu kenapa, bukan hanya caranya
- [x] T6 [CONTENT] Diagram siklus emitter sebagai SVG statis + teks alternatif — `siklus-ir.svg`

## P3 · Tahu risikonya dan cara mundur
- [x] T7 [SH] Cek skenario 9 (tanpa data pribadi) — `tests/build-checks.sh`

## P4 · Dua bahasa
- [x] T8 [CONTENT] Terjemahan Inggris + diagram en — `index.en.md`, `ir-cycle.en.svg`
- [x] T9 [SH] Cek skenario 2, 6; sesuaikan cek #6 jumlah tulisan en — `tests/build-checks.sh`
- [x] T10 [SH] UI: pencarian id/en + ponsel tanpa geser + blok kode — `tests/ui/site.spec.mjs`

## Penutup
- [x] T11 `scripts/build.sh ui` hijau
- [x] T12 Preview untuk owner (`scripts/build.sh serve`)
- [x] T13 `scripts/worktree.sh diff` bersih, PR dibuka (`Closes #16`)
