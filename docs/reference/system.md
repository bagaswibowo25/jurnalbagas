# Sistem — keadaan saat ini

> Rujukan teknis untuk plan. Perbarui halaman ini setiap kali stack, struktur konten, atau deploy berubah.
> Keadaan per 2026-10-17 (#4).

## Stack

- **Hugo** extended **0.123.8** (dipatok di `scripts/build.sh` lewat image Docker `hugomods/hugo:exts-0.123.8`).
  Tema lama gagal di Hugo ≥0.125 (template `_internal/google_analytics_async.html` sudah dihapus dari Hugo).
  Konfigurasi: `config.toml`.
- **Tema:** `themes/bilberry-hugo-theme` (git submodule, Lednerb/bilberry-hugo-theme). Akan diganti oleh redesign
  (Epic Theme).
- **Konten:** `content/article/<topik>/<sub>/<slug>.md` (saat ini seri `python/basic`, 8 tulisan), `content/page/`
  (tentang saya, kontak; ID + EN), `content/gallery/`. Gambar tulisan di `static/` dan di samping file konten.
- **Bahasa:** default `id`.
- **Pencarian:** Algolia (konfigurasi di `config.toml`, folder `algolia/`).

## Build

- `scripts/build.sh` — build `hugo --minify` ke folder sementara, lalu cek hasilnya. Memakai `hugo` lokal bila ada,
  kalau tidak lewat Docker.
- `public/` dan `resources/` saat ini ikut ter-commit di `master` (artefak lama). Jangan diubah manual; pembersihan
  lewat issue tersendiri.

## Deploy

- Domain `www.jurnalbagas.com` (file `CNAME`, juga di `static/`).
- GitHub Pages saat ini mode **legacy**: menyajikan branch **`prod`** apa adanya.
- Workflow lama `.github/workflows/` (push → build Hugo → publish ke `prod`) memakai runner `ubuntu-18.04` yang sudah
  dipensiunkan GitHub, sehingga tidak pernah jalan; branch `prod` terakhir diperbarui 2026-03-28. Perbaikan deploy =
  issue Epic Infra.

## Temuan terbuka

- Deploy otomatis mati (runner `ubuntu-18.04`).
- Tema lama mengunci situs di Hugo 0.123.8; Hugo lokal yang lebih baru (bila terpasang) akan gagal build.
- Artefak build (`public/`, `resources/`) ter-commit di branch kerja.
