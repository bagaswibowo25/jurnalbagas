---
issue: <n>
---
# Tasks — <judul>

<!--
Checklist saja: satu baris per langkah, tanpa paragraf cerita. Kelompok = cerita pengguna di spec.
Tanda: [ ] belum · [x] selesai · [!] terhambat (+ alasan satu baris).
Tag: [THEME] [CONTENT] [CFG] [CI] [DOC] [SH] [GH].
Temuan teknis → plan.md §10. Pekerjaan baru → issue baru.
-->

## Persiapan
- [ ] T1 [CFG] <langkah> — `<file utama>`

## P1 · <judul cerita pengguna 1>
- [ ] T2 [THEME] <langkah> — `<file>`
- [ ] T3 [SH] Cek otomatis skenario terima 1–2 — `scripts/build.sh`

## P2 · <judul cerita pengguna 2>
- [ ] T4 …

## Penutup
- [ ] Tn `scripts/build.sh` hijau
- [ ] Tn `scripts/worktree.sh diff` bersih, PR dibuka (`Closes #<n>`)
