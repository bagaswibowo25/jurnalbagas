---
name: merge-via-owner-bang
description: The owner merges PRs; open them, then hand over the exact `! gh pr merge` line instead of merging
metadata:
  type: feedback
---

The auto-mode classifier denies `gh pr merge` (and `gh api …/merge`) even after the owner asks Claude to merge. Don't retry or work around it. Open the PR(s), check them, then hand the owner the exact line: `! gh pr merge <n> -R bagaswibowo25/jurnalbagas --squash`.

**Why:** learned in 1994-erp (#716/#717, 2026-10-11): repeated denied attempts wasted time; the owner is fine running the merge themselves.

**How to apply:** after the PR is open and `scripts/build.sh` is green, offer the `!` command directly. Related: [[sdd-v2]].
