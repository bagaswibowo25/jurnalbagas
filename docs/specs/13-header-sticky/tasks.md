---
issue: 13
---
# Tasks — Navigasi atas muncul lagi saat scroll ke atas

## Persiapan
- [ ] T1 [THEME] Header sticky + kelas `header-hidden` + progres fixed + `--header-h` — `assets/css/main.css`

## P1 · Navigasi selalu mudah dicapai
- [ ] T2 [THEME] Skrip arah scroll, pengecualian menu/cari/fokus — `assets/js/header.js`, `layouts/baseof.html`
- [ ] T3 [THEME] Sidebar seri + `scroll-margin-top` mengikuti header — `assets/css/main.css`
- [ ] T4 [SH] Test UI skenario 1, 3, 5, 6, 7, 9 + Tab — `tests/ui/site.spec.mjs`

## P2 · Membaca tanpa terganggu
- [ ] T5 [THEME] Animasi singkat + `prefers-reduced-motion` — `assets/css/main.css`
- [ ] T6 [SH] Test UI skenario 2, 4, 8 + reduced motion — `tests/ui/site.spec.mjs`

## Penutup
- [ ] T7 [SH] `scripts/build.sh ui` hijau; preview untuk owner
- [ ] T8 [GH] `scripts/worktree.sh diff` bersih, PR dibuka (`Closes #13`)
