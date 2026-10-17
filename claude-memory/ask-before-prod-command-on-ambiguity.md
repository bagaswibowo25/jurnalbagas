---
name: ask-before-prod-command-on-ambiguity
description: If a message about the live site is ambiguous, ask; never offer a live-changing command as a conditional option
metadata:
  type: feedback
---

If the owner says something ambiguous about the live site (www.jurnalbagas.com, GitHub Pages settings, the `prod` branch, DNS), report the observed state and ask one short question. Do not offer a live-changing command (switching the Pages source, force-pushing `prod`, deleting branches) "just in case".

**Why:** in 1994-erp (2026-10-12) a conditional production command was offered for an ambiguous message; the owner ran it and cut off staff access.

**How to apply:** give the live-changing command only once intent is explicit. Related: [[merge-via-owner-bang]].
