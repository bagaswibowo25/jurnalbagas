---
name: sdd-check
description: Consistency check of an issue's spec.md, plan.md, and tasks.md against each other and docs/constitution.md in jurnalbagas (SDD v2). Run at the end of sdd-plan, before opening a PR, or when asked to check/analyze an SDD folder.
argument-hint: <issue number>
---

Check `docs/specs/<n>-*/` for issue #$ARGUMENTS. Read-only: report findings as a list (✅ / ❌ + where), then fix
them only when running inside sdd-plan or sdd-implement.

**spec.md**
- Six sections present: Latar, Cerita pengguna (P1–P3, per peran), Skenario terima ("Kalau … maka …"), Aturan,
  Kriteria sukses, Di luar cakupan. About two pages at most.
- No technical terms: file paths, `code`, template/partial/shortcode names, library names, English identifiers
  (CamelCase, snake_case). Quote each offending line.
- Frontmatter `issue` + `epic`; listed in the epic's "Peta spec".
- Label `spec-approved` present on the issue (`gh issue view <n> -R bagaswibowo25/jurnalbagas --json labels`).

**plan.md**
- All 10 sections; the constitution check covers every principle and explains each ⚠️.
- Visual changes consistent with `docs/reference/design.md` (dark + light, desktop + mobile).
- URL changes list old → new and a redirect (constitution #3). Nothing requires a server (constitution #4).
- Nothing in the plan changes what the spec promises; if it does → spec change rule (remove label).

**tasks.md**
- Groups match the spec's user stories; every acceptance scenario has at least one automated check task.
- Only checkboxes + one line each; no prose, no status/priority fields.
- Before a PR: all boxes `[x]`, or `[!]` with a reason the owner has accepted.
