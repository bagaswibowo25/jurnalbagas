---
name: sdd-v2
description: How the owner wants SDD to work in jurnalbagas (copied from 1994-erp, 2026-10-17) — and why
metadata:
  type: project
---

jurnalbagas uses the same SDD v2 as 1994-erp (set up in #4, 2026-10-17); only the project context (a Hugo blog) and deployment (GitHub Pages) differ. Layers: constitution → epic (Theme / Content / Infra) → spec.md (plain language, for the owner) → plan.md (technical) → tasks.md (checklist). The rules live in `docs/specs/README.md`.

**Why:** the owner wants to approve *what* gets built by reading one short, non-technical document, with one uniform flow for every kind of work (no light path for small fixes, no exception when the site is down).

**How to apply:**
- Never write plan.md before the owner adds the `spec-approved` label.
- Never add the label yourself.
- If the spec's substance changes, remove the label and comment on the issue.
- When grilling the owner, ask one question at a time, not whole rounds.

Related: [[read-agents-md-first]], [[explain-before-asking]].
