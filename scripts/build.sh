#!/usr/bin/env bash
# Build + cek situs (AGENTS.md §1) — gerbang test untuk setiap PR.
#
#   scripts/build.sh          # hugo --minify ke .build/, lalu cek hasilnya; exit 1 bila gagal
#   scripts/build.sh serve    # preview lokal: hugo server di http://localhost:1313
#
# Memakai `hugo` di mesin bila ada; kalau tidak, lewat Docker (image $HUGO_IMAGE).
# Cek bawaan: build sukses, halaman beranda + 404 + RSS ada, CNAME ikut ter-publish.
# Cek per-spec ditambahkan di bawah "Cek tambahan" oleh pekerjaan yang membutuhkannya.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
# Dipatok ke 0.123.8: tema bilberry lama gagal di Hugo ≥0.125 (template _internal/google_analytics_async dihapus).
# Naikkan setelah tema diganti (Epic Theme) — dan catat di docs/reference/system.md.
HUGO_IMAGE="${HUGO_IMAGE:-hugomods/hugo:exts-0.123.8}"
die() { echo "✗ $*" >&2; exit 1; }

hugo_run() {
  if command -v hugo >/dev/null; then
    (cd "$ROOT" && hugo "$@")
  elif command -v docker >/dev/null; then
    local port=()
    [ "${1:-}" = "server" ] && port=(-p 1313:1313)
    docker run --rm -u "$(id -u):$(id -g)" -v "$ROOT:/src:z" -w /src "${port[@]}" "$HUGO_IMAGE" hugo "$@"
  else
    die "hugo tidak ada dan Docker tidak tersedia — pasang salah satu (lihat docs/reference/system.md)"
  fi
}

if [ -f "$ROOT/.gitmodules" ] && [ -z "$(ls -A "$ROOT/themes/bilberry-hugo-theme" 2>/dev/null)" ]; then
  die "tema belum terpasang — jalankan: git -C \"$ROOT\" submodule update --init --recursive"
fi

if [ "${1:-}" = "serve" ]; then
  hugo_run server --bind 0.0.0.0 --port 1313 --disableFastRender
  exit 0
fi

# Output di .build/ (di-.gitignore) — di dalam repo supaya bisa di-mount ke container.
OUT="$ROOT/.build"
rm -rf "$OUT"
hugo_run --minify --destination .build --cleanDestinationDir

fail=0
need() { [ -e "$OUT/$1" ] && echo "✅ $1" || { echo "❌ $1 tidak ada di hasil build"; fail=1; }; }
need index.html
need 404.html
need index.xml
need CNAME

# Cek tambahan (per spec) — tulis di bawah sini, satu blok per skenario terima.

[ $fail -eq 0 ] && echo "Build OK ($(find "$OUT" -name '*.html' | wc -l) halaman HTML)" || exit 1
