# Plan — Merapikan isi repo tanpa mengubah situs (#8)

## 1. Ringkasan pendekatan

Hapus dari repo: `public/` (406 file), `resources/` (7), `themes/` (114, ananke), `CNAME` di root,
`.hugo_build.lock`, `static/pp.jpeg`. Tambahkan `public/`, `resources/`, `.hugo_build.lock` ke `.gitignore`. Akar
masalah preview: Hugo 0.154 `hugo server` me-render ke disk secara bawaan (ke `public/`) — `scripts/build.sh serve`
diberi `--renderToMemory`. Penjaga permanen: `scripts/build.sh` gagal bila setelah build ada perubahan/file baru yang
tidak di-ignore di repo (`git status --porcelain` kosong), dan mode `ui` juga menjalankan preview sebentar lalu
memastikan repo tetap bersih. Situs dibuktikan sama dengan membandingkan hasil build sebelum vs sesudah. Tiga cabang
lama dihapus setelah PR di-merge, dengan konfirmasi owner sebelum perintah dijalankan.

## 2. Cek constitution

| Prinsip | | Catatan |
|---|---|---|
| 2 Tulisan milik penulis | ✅ | Konten tidak disentuh. |
| 3 Alamat tidak putus | ✅ | Hasil build sebelum = sesudah (daftar file + isi), termasuk alias (§8). |
| 4 Statis, tanpa server | ✅ | Tidak ada perubahan cara terbit. |
| 5 Ringan, tanpa pelacak | ✅ | Tidak ada perubahan halaman. |
| 6 Standar tampilan | ✅ | Tidak ada perubahan tampilan. |
| 7 Aksesibel | ✅ | Tidak ada perubahan halaman. |
| 8 Keputusan epic | ✅ | Infra K3 (`prod` tidak disentuh), K4 (cabang dihapus tanpa arsip), K5 (foto dihapus). |
| 9 Skenario dicek otomatis | ✅ | §8; skenario 5–6 diverifikasi setelah merge (`needs-prod-verify`). |

## 3. Bagian yang disentuh

- Dihapus: `public/`, `resources/`, `themes/`, `CNAME` (root), `.hugo_build.lock`, `static/pp.jpeg`.
- `.gitignore`, `scripts/build.sh` (serve `--renderToMemory`, cek repo bersih, cek sisa), `AGENTS.md` §1,
  `docs/reference/system.md` (Build, Temuan terbuka).
- Setelah merge (GitHub): hapus branch `gh-pages`, `old`, `new`.

## 4. Konten dan front matter

Tidak ada. `static/CNAME` tetap (dipakai Hugo untuk CNAME di hasil build; deploy juga menulis `cname`).

## 5. URL, SEO, dan feed

Tidak ada perubahan; dibuktikan dengan perbandingan build (§8).

## 6. Tampilan

Tidak ada.

## 7. Build dan deploy

Deploy tidak berubah (sudah membangun dari nol ke `.build/`). `hugo` tidak lagi menulis `.hugo_build.lock`/
`resources/` ke repo yang ter-commit — keduanya di-ignore.

## 8. Strategi cek otomatis

| Skenario | Cek |
|---|---|
| 1 | Satu kali sebelum PR: build `origin/master` vs branch → daftar file sama dan isi tiap file sama kecuali `version.txt` (dan nama CSS/JS berhash bila berbeda). Hasil di PR + plan §10. |
| 2 | `scripts/build.sh`: `public/`, `resources/`, `themes/`, `CNAME` root, `.hugo_build.lock`, `static/pp.jpeg` tidak di-track git |
| 3 | `scripts/build.sh ui`: jalankan preview ±8 detik, hentikan, `git status --porcelain` kosong |
| 4 | `scripts/build.sh`: setelah build, `git status --porcelain` kosong (hasil build hanya di folder ter-ignore) |
| 5 | Setelah merge: `git ls-remote --heads origin` = `master` + `prod` |
| 6 | Setelah merge: run deploy hijau (sudah termasuk verifikasi `version.txt` di situs live) |

## 9. Risiko dan rollback

- Cek "repo bersih" bisa gagal bila pengembang punya perubahan belum di-commit saat menjalankan `build.sh` — pesannya
  menyebut file yang berubah; itu memang diharapkan sebelum PR. Untuk kerja harian bisa dilewati dengan
  `ALLOW_DIRTY=1`.
- Penghapusan cabang tidak bisa dibatalkan (keputusan owner, Infra K4). Dijalankan terakhir, setelah merge.
- Rollback file: revert PR.

## 10. Catatan pengerjaan

<!-- Diisi selama pengerjaan: "- YYYY-MM-DD — temuan teknis singkat". Bug/pekerjaan baru → issue baru. -->
- 2026-10-17 — Akar masalah preview terkonfirmasi: `hugo server` (0.154) tanpa `--renderToMemory` menulis ke `public/`.
  Sekarang `public/` di-ignore dan `serve` render ke memori; `build.sh ui` memastikan repo tetap bersih.
- 2026-10-17 — Perbandingan build `master` vs branch (sha256 semua file kecuali `version.txt`): 144 file identik,
  satu-satunya beda = `/pp.jpeg` hilang (foto dihapus, Infra K5). File itu masih tersaji di situs live (200), dulu
  dipakai tema lama sebagai avatar, tidak ditautkan dari halaman mana pun sekarang → ditanyakan ke owner.
