# Plan — <judul> (#<n>)

<!--
Teknis, untuk agent & reviewer. Ditulis setelah spec berlabel spec-approved. Bagian yang tidak relevan: tulis "Tidak ada".
Baca dulu: docs/constitution.md, epic terkait, docs/reference/ (system, design).
-->

## 1. Ringkasan pendekatan

<3–5 kalimat.>

## 2. Cek constitution

| Prinsip | | Catatan |
|---|---|---|
| 2 Tulisan milik penulis | ✅ / ⚠️ | |
| 3 Alamat tidak putus | ✅ / ⚠️ | |
| 4 Statis, tanpa server | ✅ / ⚠️ | |
| 5 Ringan, tanpa pelacak | ✅ / ⚠️ | |
| 6 Standar tampilan | ✅ / ⚠️ | |
| 7 Aksesibel | ✅ / ⚠️ | |
| 8 Keputusan epic | ✅ / ⚠️ | |
| 9 Skenario dicek otomatis | ✅ / ⚠️ | |

Setiap ⚠️ wajib dijelaskan.

## 3. Bagian yang disentuh

<layouts/, assets/, content/, static/, config, workflow, scripts.>

## 4. Konten dan front matter

<Field front matter baru/berubah, struktur folder konten, tulisan yang terdampak.>

## 5. URL, SEO, dan feed

<Permalink, alias/redirect untuk alamat lama, RSS, sitemap, meta/canonical. Daftar URL sebelum vs sesudah.>

## 6. Tampilan

<Halaman/layout, gelap + terang, desktop + ponsel — dicek terhadap docs/reference/design.md.>

## 7. Build dan deploy

<Versi Hugo, perubahan workflow GitHub Pages, dampak ke situs live.>

## 8. Strategi cek otomatis

<Cek apa di scripts/build.sh (atau tambahan) yang membuktikan tiap skenario terima di spec.>

## 9. Risiko dan rollback

## 10. Catatan pengerjaan

<!-- Diisi selama pengerjaan: "- YYYY-MM-DD — temuan teknis singkat". Bug/pekerjaan baru → issue baru. -->
