#!/usr/bin/env bash
# Helper GitHub Project (https://github.com/users/bagaswibowo25/projects/2) — AGENTS.md §2–§4c.
# Butuh: gh CLI dengan scope `project` (gh auth refresh -s project,read:project).
#
#   scripts/gh-project.sh new "<judul>" [type] [body]   # buat issue + masukkan ke Project (Backlog, belum di-triage)
#   scripts/gh-project.sh status <n> "<Status>"         # Icebox | Backlog | Ready | In Progress | Review | Done
#   scripts/gh-project.sh set <n> <Field> "<Value>"     # Priority P0–P3 · Size XS–XL · Epic (Theme|Content|Infra) · Cycle (mis. 2026-10)
#   scripts/gh-project.sh epic <n> <Epic>               # isi field Epic + jadikan sub-issue dari issue "Epic: <Epic>"
#   scripts/gh-project.sh triage <n> <P> <Size> <Epic>  # Priority + Size + Epic sekaligus, lalu Status Backlog
#       triage / set Priority|Size / status Ready|In Progress|Review menolak issue tanpa label spec-approved
#   scripts/gh-project.sh show <n>                      # tampilkan field Project untuk issue #n
set -euo pipefail

REPO=bagaswibowo25/jurnalbagas
OWNER=bagaswibowo25
NUM=2

project_id() { gh project view "$NUM" --owner "$OWNER" --format json --jq .id; }

item_id() { # issue number → project item id (menambahkan ke Project kalau belum ada)
  local url="https://github.com/$REPO/issues/$1"
  gh project item-add "$NUM" --owner "$OWNER" --url "$url" --format json --jq .id
}

set_field() { # <n> <Field> <Value>
  local n=$1 field=$2 value=$3 fields fid kind opt
  fields=$(gh project field-list "$NUM" --owner "$OWNER" --format json)
  fid=$(jq -r --arg f "$field" '.fields[] | select(.name==$f) | .id' <<<"$fields")
  kind=$(jq -r --arg f "$field" '.fields[] | select(.name==$f) | .type' <<<"$fields")
  [ -n "$fid" ] || { echo "Field '$field' tidak ada" >&2; exit 1; }
  if [ "$kind" = "ProjectV2IterationField" ]; then
    opt=$(gh api graphql -f query="{node(id:\"$fid\"){... on ProjectV2IterationField{configuration{iterations{id title} completedIterations{id title}}}}}" \
      --jq "[.data.node.configuration.iterations[], .data.node.configuration.completedIterations[]] | map(select(.title==\"$value\")) | .[0].id")
    [ -n "$opt" ] && [ "$opt" != "null" ] || { echo "Cycle '$value' tidak ada" >&2; exit 1; }
    gh project item-edit --id "$(item_id "$n")" --project-id "$(project_id)" --field-id "$fid" --iteration-id "$opt" >/dev/null
  else
    opt=$(jq -r --arg f "$field" --arg v "$value" '.fields[] | select(.name==$f) | .options[] | select(.name==$v) | .id' <<<"$fields")
    [ -n "$opt" ] || { echo "Nilai '$value' tidak ada di field '$field'" >&2; exit 1; }
    gh project item-edit --id "$(item_id "$n")" --project-id "$(project_id)" --field-id "$fid" --single-select-option-id "$opt" >/dev/null
  fi
  echo "#$n $field = $value"
}

link_epic() { # <n> <Epic>
  local parent child
  parent=$(gh issue list --repo "$REPO" --label epic --state all --search "\"Epic: $2\" in:title" --json number --jq '.[0].number')
  [ -n "$parent" ] || { echo "Issue 'Epic: $2' tidak ditemukan" >&2; exit 1; }
  child=$(gh api "repos/$REPO/issues/$1" --jq .id)
  gh api -X POST "repos/$REPO/issues/$parent/sub_issues" -F sub_issue_id="$child" >/dev/null 2>&1 \
    || echo "(#$1 sudah sub-issue dari #$parent, atau gagal ditautkan — cek manual)"
  echo "#$1 → sub-issue dari Epic: $2 (#$parent)"
}

require_approved() { # <n> — SDD v2: triage, Priority/Size, dan Ready hanya untuk spec berlabel spec-approved
  local labels
  labels=$(gh issue view "$1" --repo "$REPO" --json labels --jq '[.labels[].name] | join(",")')
  case ",$labels," in
    *,spec-approved,*|*,epic,*) ;;
    *) echo "✗ #$1 belum berlabel spec-approved — spec harus disetujui owner dulu (docs/specs/README.md)" >&2; exit 1 ;;
  esac
}

cmd=${1:-}; shift || true
case "$cmd" in
  new)
    title=$1 type=${2:-finding} body=${3:-}
    url=$(gh issue create --repo "$REPO" --title "$title" --label "type:$type" --body "${body:-_(isi temuan + bukti)_}")
    gh project item-add "$NUM" --owner "$OWNER" --url "$url" >/dev/null
    echo "$url"
    ;;
  status) case "$2" in Ready|"In Progress"|Review) require_approved "$1" ;; esac; set_field "$1" Status "$2" ;;
  set)    case "$2" in Priority|Size) require_approved "$1" ;; esac; set_field "$1" "$2" "$3" ;;
  epic)   set_field "$1" Epic "$2"; link_epic "$1" "$2" ;;
  triage) require_approved "$1"; set_field "$1" Priority "$2"; set_field "$1" Size "$3"; set_field "$1" Epic "$4"; link_epic "$1" "$4"; set_field "$1" Status Backlog ;;
  show)
    gh project item-list "$NUM" --owner "$OWNER" --format json --limit 1000 \
      --jq ".items[] | select(.content.number==$1 and .content.repository==\"$REPO\") | {title, status, priority, size, epic, cycle}"
    ;;
  *) sed -n '2,12p' "$0"; exit 1 ;;
esac
