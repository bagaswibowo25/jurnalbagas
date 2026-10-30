---
epic: Content
issue: 2
---
# Epic — Content

> Dokumen hidup, diisi bertahap saat ada spec baru di domain ini. Status pekerjaan ada di GitHub Project.

## 1. Tujuan

Owner bisa rutin menulis lagi, dan tulisan lama di Medium dipindahkan ke blog ini tanpa kehilangan isi, tanggal,
maupun tautan ke sumber aslinya.

## 2. Keputusan owner

| # | Keputusan | Tanggal |
|---|---|---|
| K1 | Versi blog adalah versi utama tulisan impor; tiap tulisan impor mencantumkan "pertama terbit di Medium" + tautan ke aslinya, tanggal terbit tetap tanggal asli | 2026-10-17 |
| K2 | Tag mengikuti topik tulisan, bukan asalnya — tidak ada tag "medium" | 2026-10-17 |
| K3 | Tulisan berbahasa Inggris tanpa versi Indonesia tampil di beranda Indonesia dengan lencana "EN" (cerminan Theme K4) | 2026-10-17 |
| K4 | Import Medium dilakukan sekali (3 tulisan); tulisan baru ditulis langsung di blog | 2026-10-17 |
| K5 | Tiga tulisan Medium menjadi seri "kubernetes-in-practice" (Helm → Zuul CI → ClickStack); tulisan Kubernetes berikutnya bisa ditambahkan ke seri ini | 2026-10-17 |
| K6 | Seri baru "linux-tips" untuk tips Linux; tulisan login wajah (Howdy) di openSUSE jadi bagian 1, terbit dalam bahasa Indonesia + Inggris (#16) | 2026-10-17 |
| K7 | Seri baru "home-lab" untuk proyek lab dan perangkat di rumah; tulisan ESP32 + Telegram (menyalakan PC dari mana saja) jadi bagian 1, terbit dalam bahasa Indonesia + Inggris (#18) | 2026-10-30 |

## 3. Istilah

- **Tulisan impor** — tulisan yang aslinya terbit di Medium lalu dipindahkan ke blog ini.
- **Arsip Medium** — kumpulan tulisan impor.

## 4. Peta spec

| Spec | Issue | Bergantung pada |
|---|---|---|
| [Memindahkan tiga tulisan Medium](../specs/6-import-medium/spec.md) | #6 | #5 (dua bahasa) |
| [Tulisan baru: login pakai wajah (Howdy) di openSUSE](../specs/16-howdy-login-wajah/spec.md) | #16 | #5 (dua bahasa) |
| [Tulisan baru: menyalakan PC dari mana saja dengan ESP32 dan Telegram](../specs/18-esp32-wol-telegram/spec.md) | #18 | #5 (dua bahasa) |
