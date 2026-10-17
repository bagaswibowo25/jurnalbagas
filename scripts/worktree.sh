#!/usr/bin/env bash
# Worktree per issue — satu-satunya cara yang dipakai agen (AGENTS.md §6).
#
#   scripts/worktree.sh new <dir> <branch>
#       Worktree di <dir> (dari origin/master) pada branch baru <branch>.
#       Konvensi: ../jurnalbagas-<n>, branch feat|fix|chore/<n>-<slug>.
#   scripts/worktree.sh check [<dir>]
#       Gagal bila worktree tidak berada di branch (HEAD lepas).
#   scripts/worktree.sh diff [<dir>]
#       `git diff --stat origin/master...HEAD`, file TERHAPUS disorot.
#       Wajib dibaca sebelum membuka PR: setiap file harus milik issue ini.
#   scripts/worktree.sh rm <dir>
#       Hapus worktree.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
# Dari dalam worktree, ROOT menunjuk worktree itu; checkout utama = induk common dir.
MAIN="$(cd "$(git -C "$ROOT" rev-parse --git-common-dir)/.." && pwd)"
BASE=master
die() { echo "✗ $*" >&2; exit 1; }

# <dir> selalu absolut (relatif ke cwd pemanggil).
abs_dir() {
  local parent
  parent="$(dirname "$1")"
  [ -d "$parent" ] || die "folder induk tidak ada: $parent"
  echo "$(cd "$parent" && pwd)/$(basename "$1")"
}

check_dir() {
  local dir="$1" br
  br="$(git -C "$dir" branch --show-current)"
  [ -n "$br" ] || die "$dir: HEAD lepas ($(git -C "$dir" rev-parse --short HEAD)) — jangan commit/squash; cek 'git -C $dir status' dulu"
}

cmd="${1:-}"; shift || true
case "$cmd" in
  new)
    dir="$(abs_dir "${1:?dir}")"; branch="${2:?branch}"
    git -C "$MAIN" fetch -q origin
    git -C "$MAIN" worktree add -q -b "$branch" "$dir" "origin/$BASE"
    check_dir "$dir"
    echo "✓ worktree $dir ($branch)"
    ;;
  check)
    check_dir "$(abs_dir "${1:-$ROOT}")"
    echo "✓ worktree sehat"
    ;;
  diff)
    dir="$(abs_dir "${1:-$ROOT}")"
    git -C "$dir" fetch -q origin
    echo "━━ $(git -C "$dir" branch --show-current || echo '?') vs origin/$BASE"
    git -C "$dir" diff --stat "origin/$BASE...HEAD" | cat
    deleted="$(git -C "$dir" diff --name-only --diff-filter=D "origin/$BASE...HEAD")"
    if [ -n "$deleted" ]; then
      printf '  ⚠ DIHAPUS (pastikan memang disengaja):\n%s\n' "$(echo "$deleted" | sed 's/^/    /')"
    fi
    ;;
  rm)
    dir="$(abs_dir "${1:?dir}")"
    git -C "$MAIN" worktree remove --force "$dir"
    echo "✓ $dir dihapus"
    ;;
  *) sed -n '2,13p' "$0"; exit 1 ;;
esac
