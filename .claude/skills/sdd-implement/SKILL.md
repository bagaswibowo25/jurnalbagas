---
name: sdd-implement
description: Implement a Ready issue in jurnalbagas following its tasks.md (SDD v2, step 3) through to an open PR. Use when asked to work on, build, or implement an issue that is Ready.
argument-hint: <issue number>
---

Implement issue #$ARGUMENTS. Rules: `AGENTS.md` (§1 build, §4d content & URL, §6 worktree) and `docs/specs/README.md`.

1. **Gate:** label `spec-approved` present and Status Ready (or In Progress when resuming); `plan.md` + `tasks.md`
   exist. Otherwise stop and say what is missing.
2. Worktree only via `scripts/worktree.sh new ../jurnalbagas-<n> <branch>`. Then
   `scripts/gh-project.sh status <n> "In Progress"`.
3. Work through `tasks.md` in order. Check each box (`[x]`) as soon as it is done and commit early.
   Blocked step → `[!]` + one-line reason.
4. During the work:
   - technical finding that affects this work → `plan.md` §10 `- YYYY-MM-DD — …`;
   - bug / idea / out-of-scope work → `scripts/gh-project.sh new …`;
   - the spec must change (what the owner gets) → stop, edit spec.md, remove label `spec-approved`, comment why,
     and wait;
   - no prose in tasks.md.
5. Verify with `scripts/build.sh`. Every acceptance scenario in spec.md must be covered by an automated check on the
   build output. For visual work, offer the owner a local preview (`scripts/build.sh serve`) and say which port.
6. Run the `sdd-check` skill, then read `scripts/worktree.sh diff` — every file must belong to this issue.
7. Open the PR with `Closes #<n>`, following `.github/pull_request_template.md`. Then
   `scripts/gh-project.sh status <n> Review`. Merging is the owner's: hand over `! gh pr merge <n> --squash`.
8. Site down: you may prepare the fix in the worktree while the spec awaits the label, but do not open a PR or
   deploy before the label exists.
