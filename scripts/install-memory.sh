#!/usr/bin/env bash
# Pasang "memory" Claude Code ke laptop ini — supaya konteks & keputusan
# dari percakapan sebelumnya ikut ter-"spawn" di laptop baru.
# Jalankan sekali di laptop baru, dari dalam folder jurnalbagas:  bash scripts/install-memory.sh
set -euo pipefail
cd "$(dirname "$0")/.."

if [ ! -d claude-memory ]; then
  echo "❌ Folder claude-memory/ tidak ditemukan."
  exit 1
fi

# Nama folder project di ~/.claude dihitung dari path absolut (slash -> dash)
PROJ_KEY=$(echo "$PWD" | sed 's#/#-#g')
DEST="$HOME/.claude/projects/$PROJ_KEY/memory"

mkdir -p "$DEST"
cp -f claude-memory/*.md "$DEST/"
echo "✅ Memory terpasang ke:"
echo "   $DEST"
echo "   File: $(ls claude-memory/*.md | wc -l) memory"
echo "Claude Code di laptop ini kini mengingat konteks project ini."
