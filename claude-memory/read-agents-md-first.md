---
name: read-agents-md-first
description: Always read AGENTS.md (and docs/constitution.md) before doing any work in the jurnalbagas repo
metadata:
  type: feedback
---

Before starting ANY task in jurnalbagas, read `AGENTS.md` first — it holds the binding rules (CLAUDE.md points to it). Key rules: verify with `scripts/build.sh` (Hugo build + checks); the site must stay a static GitHub Pages site with no server (constitution #4); log any bug/finding/new feature as a GitHub issue in the Project (users/bagaswibowo25/projects/2) via `scripts/gh-project.sh new` — never to markdown; SDD v2: before executing a task confirm the issue has the `spec-approved` label, is Ready/In Progress, and has `docs/specs/<n>-<slug>/{spec,plan,tasks}.md` — never code first, never write plan.md before the owner labels the spec; read `docs/constitution.md` + the relevant `docs/epics/` doc, and `docs/reference/` (system, design) for technical rules.

**Why:** the same rule exists in 1994-erp, where the owner corrected agents for acting before reading AGENTS.md; the owner wants identical development rules here.

**How to apply:** at the start of work in this repo, read AGENTS.md and docs/specs/README.md before touching anything. Related: [[sdd-v2]].
