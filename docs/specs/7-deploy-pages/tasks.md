---
issue: 7
---
# Tasks — Situs terbit otomatis lagi

## Persiapan
- [x] T1 [SH] Simpan daftar halaman `prod` sekarang untuk perbandingan di PR — `origin/prod`

## P1 · Terbit otomatis
- [x] T2 [CI] Workflow deploy: push `master` → `scripts/build.sh` → publish `.build/` ke `prod` + CNAME — `.github/workflows/deploy.yml`
- [x] T3 [SH] `build.sh` menulis `version.txt` (SHA commit) + cek ada di hasil build — `scripts/build.sh`
- [x] T4 [CI] Langkah verifikasi live: tunggu `version.txt` = SHA, maks 10 menit (skenario 1, 7) — `.github/workflows/deploy.yml`
- [x] T5 [CI] Hapus workflow lama (skenario 6) — `.github/workflows/master.yml`
- [x] T6 [SH] `build.sh` cek workflow: actionlint via Docker + trigger hanya `master` (skenario 4, 6) — `scripts/build.sh`

## P2 · Situs tetap aman saat gagal
- [x] T7 [CI] `concurrency` tanpa cancel + job `gate` HEAD master (skenario 3) — `.github/workflows/deploy.yml`
- [x] T8 [SH] Simulasi build gagal: `build.sh` exit≠0 dan tidak ada langkah publish yang jalan (skenario 2) — `scripts/build.sh`

## P3 · Terbit ulang manual
- [x] T9 [CI] Trigger `workflow_dispatch`, run manual selalu lolos `gate` (skenario 4) — `.github/workflows/deploy.yml`

## Penutup
- [x] T10 [DOC] Perbarui bagian Deploy + Temuan terbuka — `docs/reference/system.md`
- [x] T11 [SH] `scripts/build.sh` hijau; bandingkan daftar halaman dengan T1 (skenario 5, 7)
- [x] T12 [GH] `scripts/worktree.sh diff` bersih, PR dibuka (`Closes #7`); label `needs-prod-verify` setelah merge
