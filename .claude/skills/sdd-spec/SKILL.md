---
name: sdd-spec
description: Write the plain-language spec.md for a GitHub issue in jurnalbagas (SDD v2, step 1). Use when the owner asks to write, draft, or rewrite a spec for an issue.
argument-hint: <issue number>
---

Write `docs/specs/<n>-<slug>/spec.md` for issue #$ARGUMENTS. Rules: `docs/specs/README.md` (read it first).

1. Read the issue (`gh issue view <n> -R bagaswibowo25/jurnalbagas --comments`), `docs/constitution.md`, and the epic
   doc in `docs/epics/` for the issue's Epic.
2. Work in a worktree created by `scripts/worktree.sh new ../jurnalbagas-<n> <branch>` (branch
   `feat|fix|chore/<n>-<slug>`).
3. If the goal, readers, rules, or edge cases are unclear, **ask the owner first** in the style of the `grilling`
   skill (one question at a time, with your recommended answer, preceded by one sentence of context). Look up facts
   yourself; ask only for decisions. Visual decisions: show a mockup (desktop + mobile, dark + light) first.
4. Copy `docs/templates/spec.md` and fill the six sections in plain Indonesian, max ~2 pages. **No** file names,
   templates/partials, shortcodes, libraries, code, or component names. Use the site's and the epic's terms.
5. Add the spec to the epic's "Peta spec" table. A new owner decision for the domain goes into the epic's §2.
6. Commit, push the branch, put the spec link (blob URL on the branch) in the issue body, and comment
   "Spec siap, menunggu label `spec-approved`." Do **not** add the label yourself, and do not write plan.md.
7. Tell the owner the link and that they approve by adding the `spec-approved` label.
