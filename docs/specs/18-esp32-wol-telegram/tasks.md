---
issue: 18
---
# Tasks — Tulisan baru: menyalakan PC dari mana saja dengan ESP32 dan Telegram

## Persiapan
- [x] T1 [CONTENT] Ambil isi terbaru draf owner dari Claude Docs (rev terbaru) — `content/tulisan/menyalakan-pc-dengan-esp32-telegram/index.md`
- [x] T2 [CONTENT] Seri baru home-lab (id + en) — `content/series/home-lab/_index.md`

## P1 · Paham idenya
- [x] T3 [CONTENT] Tulis `index.md` dari draf (front matter §4, tabel, blok kode, tautan repo) — `index.md`
- [x] T4 [CONTENT] Diagram alur perintah sebagai SVG statis vertikal + teks alternatif — `alur-wake.svg`
- [x] T5 [SH] Cek skenario 1, 3, 4, 5; sesuaikan cek #16 S1 — `tests/build-checks.sh`

## P2 · Bisa mengikuti dan menghindari jebakan
- [x] T6 [CONTENT] Salin GIF demo tombol + teks alternatif — `demo-tombol-boot.gif`
- [x] T7 [SH] Cek skenario 7 (isi lengkap, gambar ber-alt, tautan repo) — `tests/build-checks.sh`

## P3 · Yakin aman
- [x] T8 [SH] Cek skenario 9 (tanpa data pribadi) — `tests/build-checks.sh`

## P4 · Dua bahasa
- [x] T9 [CONTENT] Terjemahan Inggris + diagram en — `index.en.md`, `wake-flow.en.svg`
- [x] T10 [SH] Cek skenario 2, 6; jumlah indeks pencarian dan beranda en — `tests/build-checks.sh`
- [x] T11 [SH] UI: pencarian id/en, ponsel tanpa geser, blok kode, "tampilkan lebih lama" 13 — `tests/ui/site.spec.mjs`

## Penutup
- [x] T12 `scripts/build.sh ui` hijau
- [ ] T13 Preview untuk owner (`scripts/build.sh serve`)
- [ ] T14 `scripts/worktree.sh diff` bersih, PR dibuka (`Closes #18`)
