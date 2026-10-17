---
name: ui-review-workflow
description: How the owner wants visual/design decisions made — mockups in light+dark and desktop+mobile, local preview, then roll out
metadata:
  type: feedback
---

For design decisions the owner wants: (1) a mockup per decision before deciding (one decision at a time), showing **both light and dark mode** and **both desktop and mobile**; (2) the decision applied and shown in a **local preview** (`scripts/build.sh serve`) so they can judge it live; (3) only then make it permanent in `docs/reference/design.md`, rolling out larger changes through separate issues.

**Why:** same workflow as 1994-erp; for the 2026-10-17 redesign the owner explicitly asked for mobile/desktop + dark/light mockups and iterated colour options (picked mono + navy).

**How to apply:** follow `docs/reference/design.md` (constitution #6). If preview feedback changes the spec, remove `spec-approved` and comment. Related: [[sdd-v2]], [[explain-before-asking]].
