---
epic: Infra
issue: 3
---
# Epic — Infra

> Dokumen hidup, diisi bertahap saat ada spec baru di domain ini. Status pekerjaan ada di GitHub Project.

## 1. Tujuan

Situs ter-build dan terbit otomatis ke GitHub Pages setiap ada perubahan yang di-merge, tanpa server, dan alur kerja
(SDD) berjalan lancar untuk owner dan agen.

## 2. Keputusan owner

| # | Keputusan | Tanggal |
|---|---|---|
| K1 | Tetap situs statis di GitHub Pages — tidak memakai server dedicated | 2026-10-17 |
| K2 | Alur pengembangan memakai SDD v2 yang sama dengan 1994-erp; hanya konteks project dan deploy yang berbeda | 2026-10-17 |
| K3 | GitHub Pages tetap menyajikan situs dari cabang hasil jadi (`prod`); pengaturan Pages tidak diubah | 2026-10-17 |
| K4 | Cabang lama `gh-pages`, `old`, `new` dihapus langsung tanpa arsip; repo hanya punya `master` + `prod` | 2026-10-17 |
| K5 | Foto `pp.jpeg` yang tidak dipakai dihapus; foto profil nanti lewat issue baru dengan mockup | 2026-10-17 |

## 3. Istilah

- **Deploy** — menerbitkan hasil build ke situs live www.jurnalbagas.com.

## 4. Peta spec

| Spec | Issue | Bergantung pada |
|---|---|---|
| [Situs terbit otomatis lagi](../specs/7-deploy-pages/spec.md) | #7 | — |
| [Merapikan isi repo](../specs/8-bersih-repo/spec.md) | #8 | #7 |
