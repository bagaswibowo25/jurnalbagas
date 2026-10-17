---
issue: 8
---
# Tasks — Merapikan isi repo tanpa mengubah situs

## Persiapan
- [ ] T1 [SH] Build `origin/master` dan simpan daftar file + checksum untuk perbandingan — `scripts/build.sh`

## P1 · Situs tetap sama
- [ ] T2 [SH] Bandingkan build sesudah vs T1: daftar file + isi sama (skenario 1) — `.build/`

## P2 · Repo bersih
- [ ] T3 [CFG] Hapus `public/`, `resources/`, `themes/`, `CNAME` root, `.hugo_build.lock`, `static/pp.jpeg` — repo
- [ ] T4 [CFG] `.gitignore`: `public/`, `resources/`, `.hugo_build.lock` — `.gitignore`
- [ ] T5 [SH] Cek sisa tidak di-track (skenario 2) + repo bersih setelah build (skenario 4) — `scripts/build.sh`
- [ ] T6 [GH] Setelah merge, dengan konfirmasi owner: hapus branch `gh-pages`, `old`, `new`; cek `ls-remote` (skenario 5)

## P3 · Pratinjau tidak mengotori repo
- [ ] T7 [SH] `build.sh serve` render ke memori — `scripts/build.sh`
- [ ] T8 [SH] Mode `ui`: preview sebentar lalu repo harus bersih (skenario 3) — `scripts/build.sh`

## Penutup
- [ ] T9 [DOC] Perbarui Build + Temuan terbuka, AGENTS.md §1 — `docs/reference/system.md`, `AGENTS.md`
- [ ] T10 [SH] `scripts/build.sh ui` hijau
- [ ] T11 [GH] `scripts/worktree.sh diff` bersih, PR dibuka (`Closes #8`); setelah merge: deploy hijau (skenario 6)
