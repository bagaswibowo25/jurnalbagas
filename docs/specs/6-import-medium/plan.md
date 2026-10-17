# Plan — Memindahkan tiga tulisan Medium ke blog (#6)

## 1. Ringkasan pendekatan

Sumber = feed RSS `https://bagas-awibowo.medium.com/feed` (isi lengkap `content:encoded`). Konversi HTML → Markdown
sekali jalan dengan pandoc (Docker `pandoc/core`), lalu dirapikan: gambar `cdn-images-1.medium.com` diunduh ke bundle,
piksel statistik Medium (`medium.com/_/stat…`) dibuang, bahasa blok kode diisi. Hasil = tiga bundle
`content/tulisan/<slug>/index.en.md` dengan front matter `medium` (URL asli). Template: catatan "First published on
Medium" di bawah judul, dan feed bahasa Indonesia juga menampilkan tulisan berbahasa lain yang belum diterjemahkan
(lencana = nama bahasanya, "EN"). Skrip konversi tidak di-commit (import sekali, Content K4); perintahnya dicatat di §10.

## 2. Cek constitution

| Prinsip | | Catatan |
|---|---|---|
| 2 Tulisan milik penulis | ✅ | Isi dikonversi apa adanya; hanya format (kode, gambar). Dicek jumlah elemen vs sumber (§8). |
| 3 Alamat tidak putus | ✅ | Alamat baru, tidak ada alamat lama di domain ini. Tulisan Medium tetap di Medium. |
| 4 Statis, tanpa server | ✅ | Gambar disimpan di repo; tidak ada pemanggilan ke Medium saat halaman dibuka. |
| 5 Ringan, tanpa pelacak | ✅ | Piksel statistik Medium di feed dibuang; dicek tidak ada domain medium.com selain tautan "First published". |
| 6 Standar tampilan | ✅ | Memakai layout tulisan yang ada; catatan sumber memakai gaya `post-meta`. |
| 7 Aksesibel | ✅ | Teks alt gambar dari sumber (atau keterangan gambar); heading tetap lewat render hook. |
| 8 Keputusan epic | ✅ | Content K1–K4, Theme K4. |
| 9 Skenario dicek otomatis | ✅ | §8. |

## 3. Bagian yang disentuh

- `content/tulisan/{kubernetes-logs-observability-with-clickstack,effortless-kubernetes-delivery-with-zuul-ci,helm-templating-network-policy}/index.en.md` + gambar.
- `content/tags/<tag>/_index.en.md` bila perlu judul tag (kubernetes, devops, helm, cicd, observability).
- `layouts/_partials/feed-pages.html` (cadangan dari semua bahasa lain, bukan hanya bahasa bawaan),
  `layouts/_partials/post-entry.html` (lencana = `.Language.LanguageName`), `layouts/page.html` (catatan sumber),
  `i18n/{id,en}.toml` (`first_published`, `untranslated_title`).
- `tests/build-checks.sh`, `tests/ui/site.spec.mjs`, `docs/reference/system.md`.

## 4. Konten dan front matter

```yaml
title: "Helm — Templating Network Policy using Helm"
date: 2024-02-04T…+07:00        # pubDate asli dari feed
slug: helm-templating-network-policy
tags: ["helm", "kubernetes", "devops"]
summary: "<kalimat pertama tulisan>"
medium: "https://bagas-awibowo.medium.com/helm-templating-network-policy-using-helm-…"
```

Tanpa `series`. Hanya `index.en.md` (belum ada versi id). Gambar `img-01.<ext>`… di bundle, alt dari `alt`/figcaption
sumber.

## 5. URL, SEO, dan feed

- Baru: `/en/posts/kubernetes-logs-observability-with-clickstack/`, `/en/posts/effortless-kubernetes-delivery-with-zuul-ci/`,
  `/en/posts/helm-templating-network-policy/`. Tidak ada alamat lama → tidak ada alias.
- Canonical = halaman blog sendiri (sudah dari `baseof.html`, Content K1).
- Tag en: `/en/tags/kubernetes/`, `/en/tags/devops/`, `/en/tags/helm/`, `/en/tags/cicd/`, `/en/tags/observability/`.
- RSS en dan `en/index.json` ikut memuat ketiganya.

## 6. Tampilan

- Catatan di bawah meta: "First published on Medium · 4 Feb 2024" (tautan ke `medium`), gaya `post-meta`.
- Beranda id: entri tulisan en tanpa terjemahan id, lencana "EN" (dari nama bahasa halaman), tag menaut ke tag en.
- Blok kode: `pre` sudah `overflow-x: auto` (tidak menggeser halaman, dicek S7).

## 7. Build dan deploy

Tidak ada perubahan. Terbit lewat deploy #7 setelah merge.

## 8. Strategi cek otomatis

| Skenario | Cek (`tests/build-checks.sh` site, kecuali disebut) |
|---|---|
| 1 | `en/index.html` + halaman berikutnya: ketiga judul ada, urutan tanggal turun, tanpa lencana |
| 2 | `index.html` + halaman berikutnya: 3 entri lencana `EN` menaut ke `/en/posts/…` |
| 3 | tiap halaman memuat `First published on Medium` + tautan ke URL `medium` yang benar |
| 4 | `<link rel=canonical href=https://www.jurnalbagas.com/en/posts/<slug>/>` |
| 5 | jumlah `<pre>`, `<img>`, `<h*>`, `<li>`, `<blockquote>` di hasil build = sumber feed (angka dicatat di cek) |
| 6 | tidak ada `cdn-images-1.medium.com`, `miro.medium.com`, `medium.com/_/stat` di hasil build; semua `<img>` lokal |
| 7 | test UI S8: ketiga alamat ditambah ke daftar halaman 320–768px |
| 8 | `en/tags/kubernetes/` memuat ketiganya |
| 9 | `en/index.json` memuat ketiganya; test UI cari "helm"/"zuul" di `/en/` |
| 10 | ketiga alamat ada |

Cek lama yang terdampak (jumlah tulisan berubah): S1/S12 menghitung semua halaman feed; S14 indeks en = 3 tulisan;
test UI S3 (5 → 10 → 11).

## 9. Risiko dan rollback

- Konversi pandoc bisa salah pada `<br>` di dalam `<pre>` (Medium memakai `<br>` untuk baris kode) → diperiksa dengan
  cek jumlah elemen dan pembacaan manual sebelum PR.
- Rollback: revert PR.

## 10. Catatan pengerjaan

<!-- Diisi selama pengerjaan: "- YYYY-MM-DD — temuan teknis singkat". Bug/pekerjaan baru → issue baru. -->
- 2026-10-17 — Feed berisi 3 tulisan, tanpa embed/iframe. Tiap tulisan memuat piksel statistik `medium.com/_/stat…`
  (pelacak) → dibuang saat konversi. Kata "gist" di Zuul CI bukan embed.
