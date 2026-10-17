---
name: sdd-plan
description: Write plan.md and tasks.md for an issue whose spec the owner approved (SDD v2, step 2) in jurnalbagas, then move it to Ready. Use when asked to plan an approved issue.
argument-hint: <issue number>
---

Plan issue #$ARGUMENTS. Rules: `docs/specs/README.md`.

1. **Gate:** `gh issue view <n> -R bagaswibowo25/jurnalbagas --json labels` must include `spec-approved`, and
   `scripts/gh-project.sh show <n>` must have Priority + Size + Epic. If not, stop and tell the owner — never plan an
   unapproved spec.
2. Use the issue's existing worktree/branch (`scripts/worktree.sh new ../jurnalbagas-<n> <branch>` if missing).
3. Read `spec.md`, `docs/constitution.md`, the epic, and `docs/reference/` (`system.md`, `design.md`). Read the actual
   layouts, config, and content you will change.
4. Write `plan.md` from `docs/templates/plan.md` (all 10 sections; "Tidak ada" where irrelevant; every ⚠️ in the
   constitution check explained). Any URL change lists old → new addresses and the redirect.
5. Write `tasks.md` from `docs/templates/tasks.md`: grouped by the spec's user stories, T1…Tn, tags
   [THEME]/[CONTENT]/[CFG]/[CI]/[DOC]/[SH]/[GH], one line each with the main file. Every acceptance scenario must map to
   at least one automated check task.
6. Run the `sdd-check` skill. Fix what it reports.
7. Commit + push, then `scripts/gh-project.sh status <n> Ready`.
8. If planning shows the spec itself must change (what the owner gets), stop: edit spec.md, remove the
   `spec-approved` label, comment on the issue what changed and why.
