---
epic: Theme
issue: 1
---
# Epic — Theme

> Dokumen hidup, diisi bertahap saat ada spec baru di domain ini. Status pekerjaan ada di GitHub Project.

## 1. Tujuan

Tampilan blog yang segar, bersih, bernuansa tech, dan nyaman dibaca di desktop maupun ponsel, dalam mode gelap dan
terang. Standar tampilannya: [`docs/reference/design.md`](../reference/design.md).

## 2. Keputusan owner

| # | Keputusan | Tanggal |
|---|---|---|
| K1 | Arah tampilan A · Terminal, font IBM Plex Mono + IBM Plex Sans (F3), warna monokrom + navy (W9), beranda feed log tanpa hero (L3), artikel dengan navigasi seri di kiri (AL2) | 2026-10-17 |
| K2 | Navigasi seri di halaman artikel bisa disembunyikan pembaca | 2026-10-17 |
| K3 | Mode gelap dan terang sama-sama didukung | 2026-10-17 |
| K4 | Dua bahasa (Indonesia utama, Inggris): teks tampilan selalu dua bahasa; terjemahan tulisan opsional per tulisan, yang belum diterjemahkan tampil di versi Inggris dengan penanda "ID" | 2026-10-17 |
| K5 | Alamat baru per bahasa: `/tulisan/`, `/seri/`, `/tag/`, `/tentang/`, `/kontak/` dan `/en/posts/`, `/en/series/`, `/en/tags/`, `/en/about/`, `/en/contact/`; alamat diambil dari judul; semua alamat lama dialihkan | 2026-10-17 |
| K6 | Pencarian berjalan di situs sendiri, tanpa layanan luar (Algolia dicopot) | 2026-10-17 |
| K7 | Tidak ada kolom komentar | 2026-10-17 |
| K8 | Chip tag dan daftar seri menampilkan tag/seri dari kedua bahasa; yang dari bahasa lain diberi tanda bahasa dan membuka halamannya di bahasa itu (#6) | 2026-10-17 |
| K9 | Navigasi atas menyingkir saat scroll ke bawah dan muncul lagi saat scroll ke atas; bilah progres baca tetap terlihat; tanpa JS navigasi selalu menempel (#13, dipilih dari mockup) | 2026-10-17 |

## 3. Istilah

- **Seri** — kumpulan tulisan berurutan dengan satu topik (mis. Python Dasar, bagian 1–8).
- **Feed** — daftar tulisan kronologis di beranda.

## 4. Peta spec

| Spec | Issue | Bergantung pada |
|---|---|---|
| [Tampilan baru, dua bahasa](../specs/5-redesign/spec.md) | #5 | #7 (agar terbit ke situs live) |
| [Navigasi atas muncul saat scroll ke atas](../specs/13-header-sticky/spec.md) | #13 | #5 |
