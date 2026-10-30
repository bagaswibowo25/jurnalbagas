---
issue: 18
---
# Tasks — Tulisan baru: menyalakan PC dari mana saja dengan ESP32 dan Telegram

## Persiapan
- [ ] T1 [CONTENT] Ambil isi terbaru draf owner dari Claude Docs (rev terbaru) — `content/tulisan/menyalakan-pc-dengan-esp32-telegram/index.md`
- [ ] T2 [CONTENT] Seri baru home-lab (id + en) — `content/series/home-lab/_index.md`

## P1 · Paham idenya
- [ ] T3 [CONTENT] Tulis `index.md` dari draf (front matter §4, tabel, blok kode, tautan repo) — `index.md`
- [ ] T4 [CONTENT] Diagram alur perintah sebagai SVG statis vertikal + teks alternatif — `alur-wake.svg`
- [ ] T5 [SH] Cek skenario 1, 3, 4, 5; sesuaikan cek #16 S1 — `tests/build-checks.sh`

## P2 · Bisa mengikuti dan menghindari jebakan
- [ ] T6 [CONTENT] Salin GIF demo tombol + teks alternatif — `demo-tombol-boot.gif`
- [ ] T7 [SH] Cek skenario 7 (isi lengkap, gambar ber-alt, tautan repo) — `tests/build-checks.sh`

## P3 · Yakin aman
- [ ] T8 [SH] Cek skenario 9 (tanpa data pribadi) — `tests/build-checks.sh`

## P4 · Dua bahasa
- [ ] T9 [CONTENT] Terjemahan Inggris + diagram en — `index.en.md`, `wake-flow.en.svg`
- [ ] T10 [SH] Cek skenario 2, 6; jumlah indeks pencarian dan beranda en — `tests/build-checks.sh`
- [ ] T11 [SH] UI: pencarian id/en, ponsel tanpa geser, blok kode, "tampilkan lebih lama" 13 — `tests/ui/site.spec.mjs`

## Penutup
- [ ] T12 `scripts/build.sh ui` hijau
- [ ] T13 Preview untuk owner (`scripts/build.sh serve`)
- [ ] T14 `scripts/worktree.sh diff` bersih, PR dibuka (`Closes #18`)
