# Plan — Situs terbit otomatis lagi (#7)

## 1. Ringkasan pendekatan

Workflow lama `.github/workflows/master.yml` (jalan di setiap push, runner `ubuntu-18.04` yang sudah mati, Hugo
`latest`) diganti `.github/workflows/deploy.yml`. Workflow baru hanya jalan di push ke `master` dan lewat tombol
*Run workflow*, membangun situs dengan `scripts/build.sh` (Hugo terpatok 0.123.8 via Docker, sama dengan gerbang PR),
lalu mem-publish `.build/` ke branch `prod` yang disajikan GitHub Pages (mode legacy, Infra K3 — pengaturan Pages tidak
disentuh). Pola `concurrency` tanpa cancel + job `gate` "masih HEAD master" diambil dari deploy 1994-erp. Setelah
publish, workflow menunggu sampai situs live menyajikan `version.txt` berisi SHA commit yang di-deploy.

## 2. Cek constitution

| Prinsip | | Catatan |
|---|---|---|
| 2 Tulisan milik penulis | ✅ | Konten tidak disentuh. |
| 3 Alamat tidak putus | ✅ | Struktur hasil build sama dengan sekarang; CNAME tetap ikut ter-publish. |
| 4 Statis, tanpa server | ✅ | Tetap GitHub Pages dari branch `prod`. Actions hanya dipakai saat build. |
| 5 Ringan, tanpa pelacak | ✅ | Tidak ada perubahan halaman. |
| 6 Standar tampilan | ✅ | Tidak ada perubahan tampilan. |
| 7 Aksesibel | ✅ | Tidak ada perubahan halaman. |
| 8 Keputusan epic | ✅ | Infra K1 (statis, Pages) dan K3 (Pages dari `prod`) dipatuhi. |
| 9 Skenario dicek otomatis | ✅ | `scripts/build.sh` + actionlint sebelum merge; verifikasi `version.txt` di situs live sesudah deploy (§8). |

## 3. Bagian yang disentuh

- `.github/workflows/master.yml` — dihapus.
- `.github/workflows/deploy.yml` — baru.
- `scripts/build.sh` — tulis `.build/version.txt` (SHA commit); tambah cek workflow (actionlint via Docker).
- `docs/reference/system.md` — bagian Deploy dan Temuan terbuka diperbarui.

## 4. Konten dan front matter

Tidak ada.

## 5. URL, SEO, dan feed

Tidak ada perubahan URL. Satu file baru di situs live: `/version.txt` (SHA commit terakhir yang terbit; tidak
ditautkan dari halaman mana pun).

## 6. Tampilan

Tidak ada.

## 7. Build dan deploy

`deploy.yml`:

- `on: push: branches: [master]` + `workflow_dispatch` (skenario 4, 6). Tanpa `paths-ignore` — push yang hanya dokumen
  tetap men-deploy hasil yang sama (skenario 5).
- `concurrency: { group: deploy-prod, cancel-in-progress: false }` — run tidak pernah tumpang tindih (skenario 3).
- `permissions: contents: write` (push ke `prod`).
- Job `gate` (`ubuntu-latest`): bandingkan `github.sha` dengan HEAD `master` via `gh api`; output `fresh`. Run manual
  (`workflow_dispatch`) selalu `fresh`.
- Job `deploy` (`needs: gate`, `if: fresh`): `actions/checkout@v4` (`submodules: recursive`) → `scripts/build.sh`
  (gagal = job berhenti, `prod` tidak disentuh — skenario 2) → `peaceiris/actions-gh-pages@v4` (`publish_dir: ./.build`,
  `publish_branch: prod`, `cname: www.jurnalbagas.com`) → langkah verifikasi: poll
  `https://www.jurnalbagas.com/version.txt` tiap 20 detik, maks 10 menit, sampai isinya = `github.sha` (skenario 1, 7).
- Pages legacy menyajikan ulang `prod` otomatis setelah push (workflow bawaan `pages-build-deployment`).
  `peaceiris` menambahkan `.nojekyll` secara default, sehingga Jekyll tidak memproses hasil build.

## 8. Strategi cek otomatis

| Skenario | Cek |
|---|---|
| 1 Terbit ≤10 menit | Langkah verifikasi `version.txt` di job deploy (gagal bila >10 menit) |
| 2 Gagal → situs tetap | Build gagal menghentikan job sebelum publish; dicek dengan `scripts/build.sh` exit≠0 di lokal (simulasi config rusak) |
| 3 Merge berdekatan | `concurrency` + `gate` — divalidasi actionlint + review; dibuktikan saat merge berikutnya |
| 4 Terbit ulang manual | `workflow_dispatch` ada (actionlint); dipakai sekali setelah merge |
| 5 Push dokumen | Tidak ada `paths-ignore`; build tetap menghasilkan halaman yang sama (`build.sh` hitung halaman) |
| 6 Cabang lain | Trigger hanya `master` (actionlint + cek `grep` di `build.sh`); workflow lama dihapus |
| 7 Domain + alamat | `build.sh` cek `CNAME` + `version.txt`; verifikasi live memakai domain |

Skenario yang hanya terbukti di situs live (1, 3, 4) → label `needs-prod-verify` setelah merge, dicek pada run deploy
pertama.

## 9. Risiko dan rollback

- **Isi `prod` diganti** hasil build `master` (bukan build Maret 2026). Isinya praktis sama: konten tidak berubah sejak
  itu, tema sama, Hugo 0.123.8 vs `latest` lama — halaman demo tema yang ada di `prod` mungkin hilang/bertambah; itu
  memang bukan tulisan owner. Daftar halaman sebelum/sesudah dibandingkan di PR.
- Rollback: `prod` menyimpan riwayat commit; owner bisa `git revert` di `prod` atau menjalankan ulang workflow dari
  commit lama. Tidak ada perubahan pengaturan Pages yang perlu dikembalikan.

## 10. Catatan pengerjaan

<!-- Diisi selama pengerjaan: "- YYYY-MM-DD — temuan teknis singkat". Bug/pekerjaan baru → issue baru. -->
