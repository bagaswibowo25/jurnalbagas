#!/usr/bin/env bash
# Cek kesiapan device untuk bekerja di jurnalbagas (SDD v2, #4).
#
#   scripts/doctor.sh           # semua cek, ✅/❌ + perintah perbaikan; exit 1 bila ada ❌
#   scripts/doctor.sh --quiet   # hanya cetak yang ❌ (dipakai hook SessionStart di .claude/settings.json); selalu exit 0
#
# Yang dicek: git identity · checkout utama tidak tertinggal origin/master · tema terpasang · gh login + scope
# project · label spec-approved · hugo atau Docker tersedia · skill SDD ada · memory Claude sinkron dengan claude-memory/.
set -uo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
MAIN="$(cd "$(git -C "$ROOT" rev-parse --git-common-dir)/.." && pwd)"
REPO=bagaswibowo25/jurnalbagas
BASE=master
QUIET=0; [ "${1:-}" = "--quiet" ] && QUIET=1
FAIL=0

ok()  { [ $QUIET -eq 1 ] || echo "✅ $1"; }
bad() { echo "❌ $1"; echo "   → $2"; FAIL=1; }
t()   { timeout "$@" 2>/dev/null; }  # t <detik> <cmd…>

# git identity
if [ -n "$(git -C "$ROOT" config user.email)" ]; then ok "git identity: $(git -C "$ROOT" config user.name) <$(git -C "$ROOT" config user.email)>"
else bad "git belum punya identitas — commit akan gagal" "git config user.name \"<nama>\" && git config user.email <email>"; fi

# checkout utama vs origin/master
if t 8 git -C "$MAIN" fetch -q origin "$BASE"; then
  behind=$(git -C "$MAIN" rev-list --count "HEAD..origin/$BASE" 2>/dev/null || echo 0)
  branch=$(git -C "$MAIN" branch --show-current)
  if [ "$branch" = "$BASE" ] && [ "$behind" -gt 0 ]; then
    bad "checkout utama tertinggal $behind commit dari origin/$BASE (aturan & skill bisa usang)" "git -C \"$MAIN\" pull --ff-only"
  else ok "checkout utama ($branch) up to date"; fi
else
  [ $QUIET -eq 1 ] || echo "⚠️  tidak bisa fetch origin (offline?) — cek versi dilewati"
fi

# tema (submodule) — dibutuhkan selama situs masih memakai tema lama
if [ -f "$ROOT/.gitmodules" ]; then
  if [ -n "$(ls -A "$ROOT/themes/bilberry-hugo-theme" 2>/dev/null)" ]; then ok "tema terpasang"
  else bad "tema belum terpasang — scripts/build.sh akan gagal" "git -C \"$ROOT\" submodule update --init --recursive"; fi
fi

# gh + scope project + label
if ! command -v gh >/dev/null; then
  bad "gh CLI tidak ada" "pasang GitHub CLI: https://cli.github.com"
else
  scopes=$(t 10 gh auth status 2>&1 | grep -i 'token scopes' || true)
  if [ -z "$scopes" ]; then bad "gh belum login" "gh auth login -s project,read:project"
  elif ! grep -q "'project'" <<<"$scopes"; then bad "gh tidak punya scope project (scripts/gh-project.sh gagal)" "gh auth refresh -s project,read:project"
  else ok "gh login + scope project"; fi
  if lbl=$(t 10 gh label list -R "$REPO" --search spec-approved --json name --jq '.[].name'); then
    if grep -qx spec-approved <<<"$lbl"; then ok "label spec-approved ada"
    else bad "label spec-approved tidak ada di $REPO" "gh label create spec-approved -R $REPO --color 0E8A16"; fi
  fi
fi

# hugo atau Docker (scripts/build.sh butuh salah satu)
if command -v hugo >/dev/null; then ok "hugo: $(hugo version 2>/dev/null | awk '{print $2}')"
elif command -v docker >/dev/null && t 5 docker info >/dev/null; then ok "hugo tidak ada, build lewat Docker"
else bad "hugo tidak ada dan Docker tidak jalan — scripts/build.sh tidak bisa jalan (AGENTS.md §1)" "pasang Hugo extended, atau jalankan Docker"; fi

# skill SDD (ikut repo — hilang berarti checkout tidak lengkap/usang)
missing=""
for k in sdd-spec sdd-plan sdd-implement sdd-check grilling grill-me; do
  [ -f "$ROOT/.claude/skills/$k/SKILL.md" ] || missing="$missing $k"
done
if [ -z "$missing" ]; then ok "skill SDD lengkap"
else bad "skill tidak ada:$missing" "git pull di checkout ini"; fi

# memory Claude ↔ claude-memory/
key=$(echo "$MAIN" | sed 's#/#-#g')
mem="$HOME/.claude/projects/$key/memory"
stale=""
for f in "$MAIN"/claude-memory/*.md; do
  [ -f "$f" ] || continue
  b=$(basename "$f")
  [ "$b" = MEMORY.md ] && continue
  [ -f "$mem/$b" ] || stale="$stale $b"
done
if [ -z "$stale" ]; then ok "memory Claude sinkron"
else bad "memory Claude belum terpasang:$stale" "bash \"$MAIN/scripts/install-memory.sh\""; fi

if [ $QUIET -eq 1 ]; then
  [ $FAIL -eq 1 ] && echo "(scripts/doctor.sh — sampaikan ❌ di atas ke owner sebelum mulai bekerja)"
  exit 0
fi
[ $FAIL -eq 0 ] && echo "Semua siap." || exit 1
