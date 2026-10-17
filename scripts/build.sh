#!/usr/bin/env bash
# Build + cek situs (AGENTS.md §1) — gerbang test untuk setiap PR.
#
#   scripts/build.sh          # hugo --minify ke .build/, lalu cek hasilnya; exit 1 bila gagal
#   scripts/build.sh serve    # preview lokal: hugo server di http://localhost:1313 (render ke memori, repo tidak berubah)
#   scripts/build.sh ui       # build + test UI (Playwright di Docker, tests/ui/) terhadap .build/
#
# Memakai `hugo` di mesin bila ada; kalau tidak, lewat Docker (image $HUGO_IMAGE).
# Cek bawaan: build sukses, halaman beranda + 404 + RSS ada, CNAME ikut ter-publish.
# Cek per-spec ditambahkan di bawah "Cek tambahan" oleh pekerjaan yang membutuhkannya.
# Repo harus bersih setelah build (hasil build hanya di folder ter-ignore, #8); ALLOW_DIRTY=1 melewati cek ini saat
# masih ada perubahan yang belum di-commit.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
# Dipatok ke 0.154.5 (#5, tema sendiri). Mengubah versi = catat di docs/reference/system.md.
HUGO_IMAGE="${HUGO_IMAGE:-hugomods/hugo:exts-0.154.5}"
ACTIONLINT_IMAGE="${ACTIONLINT_IMAGE:-rhysd/actionlint:1.7.7}"
PLAYWRIGHT_VERSION=1.48.2
PLAYWRIGHT_IMAGE="${PLAYWRIGHT_IMAGE:-mcr.microsoft.com/playwright:v$PLAYWRIGHT_VERSION-noble}"
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


if [ "${1:-}" = "serve" ]; then
  # Hugo ≥0.123 me-render server ke disk (public/) secara bawaan — render ke memori agar repo tidak berubah (#8).
  hugo_run server --bind 0.0.0.0 --port 1313 --disableFastRender --renderToMemory
  exit 0
fi

# Output di .build/ (di-.gitignore) — di dalam repo supaya bisa di-mount ke container.
OUT="$ROOT/.build"
rm -rf "$OUT"
hugo_run --minify --destination .build --cleanDestinationDir
# version.txt = commit yang dibangun; deploy menunggu situs live menyajikannya (#7).
git -C "$ROOT" rev-parse HEAD > "$OUT/version.txt"

# Status repo sebelum build — cek "repo bersih" di bawah membandingkan dengan ini.
dirty_before="$(git -C "$ROOT" status --porcelain)"
fail=0
need() { [ -e "$OUT/$1" ] && echo "✅ $1" || { echo "❌ $1 tidak ada di hasil build"; fail=1; }; }
need index.html
need 404.html
need index.xml
need CNAME
need version.txt

# Cek tambahan (per spec) — tulis di bawah sini, satu blok per skenario terima.

# #5 — skenario tampilan baru: situs asli + situs uji dari tests/fixture/content.
"$ROOT/tests/build-checks.sh" site "$OUT" || fail=1
rm -rf "$ROOT/.build-fixture"
hugo_run --quiet --minify --contentDir tests/fixture/content --destination .build-fixture --cleanDestinationDir >/dev/null
"$ROOT/tests/build-checks.sh" fixture "$ROOT/.build-fixture" || fail=1

# #7 — workflow deploy valid, hanya terpicu push master + tombol manual, workflow lama tidak ada.
WF="$ROOT/.github/workflows"
if command -v docker >/dev/null; then
  docker run --rm -v "$ROOT:/repo:z" -w /repo "$ACTIONLINT_IMAGE" -no-color \
    && echo "✅ actionlint: workflow valid" || { echo "❌ actionlint menemukan masalah"; fail=1; }
else
  echo "⚠️  Docker tidak ada — actionlint dilewati"
fi
if [ "$(ls "$WF")" = "deploy.yml" ] \
  && grep -qE '^    branches: \[master\]$' "$WF/deploy.yml" \
  && grep -q '^  workflow_dispatch:' "$WF/deploy.yml" \
  && grep -q 'cancel-in-progress: false' "$WF/deploy.yml"; then
  echo "✅ deploy: hanya master + manual, concurrency tanpa cancel"
else
  echo "❌ workflow deploy tidak sesuai (#7 skenario 3, 4, 6)"; fail=1
fi

# #8 skenario 2 — sisa lama tidak di-track lagi.
left=$(git -C "$ROOT" ls-files public resources themes CNAME .hugo_build.lock static/pp.jpeg | head -3)
[ -z "$left" ] && echo "✅ repo: tanpa hasil build lama, tema lama, sisa konfigurasi, foto tak terpakai" \
  || { echo "❌ repo masih men-track: $left"; fail=1; }

# #8 skenario 4 — build tidak mengubah/menambah file di repo.
repo_clean() {
  local now; now="$(git -C "$ROOT" status --porcelain)"
  if [ "$now" = "$dirty_before" ]; then echo "✅ repo bersih setelah $1"
  else echo "❌ $1 mengubah repo:"; diff <(echo "$dirty_before") <(echo "$now") | grep '^>' | head -5; fail=1; fi
}
repo_clean "build"
if [ -n "$dirty_before" ] && [ "${ALLOW_DIRTY:-0}" != 1 ]; then
  echo "⚠️  ada perubahan belum di-commit — sebelum PR, commit dulu lalu jalankan ulang (atau ALLOW_DIRTY=1)"
fi

# #8 skenario 3 — preview lokal tidak mengubah repo.
if [ $fail -eq 0 ] && [ "${1:-}" = "ui" ] && command -v docker >/dev/null; then
  cid=$(docker run -d --rm -u "$(id -u):$(id -g)" -v "$ROOT:/src:z" -w /src "$HUGO_IMAGE" \
    hugo server --bind 0.0.0.0 --port 1313 --disableFastRender --renderToMemory)
  sleep 8; docker stop "$cid" >/dev/null
  repo_clean "preview lokal"
fi

if [ $fail -eq 0 ] && [ "${1:-}" = "ui" ]; then
  command -v docker >/dev/null || die "test UI butuh Docker"
  docker run --rm --ipc=host -v "$ROOT:/repo:z" "$PLAYWRIGHT_IMAGE" bash -c "
    set -e
    (cd /repo/.build && python3 -m http.server 8080 >/dev/null 2>&1 &)
    mkdir -p /tmp/pw && cd /tmp/pw && npm init -y >/dev/null && npm i -s @playwright/test@$PLAYWRIGHT_VERSION >/dev/null
    cp /repo/tests/ui/*.mjs /tmp/pw/ && npx playwright test -c playwright.config.mjs
  " || fail=1
fi

[ $fail -eq 0 ] && echo "Build OK ($(find "$OUT" -name '*.html' | wc -l) halaman HTML)" || exit 1
