---
name: preview-and-peer-sessions
description: Verify a local preview really serves the new build before announcing it; confirm which agent session works on which issue
metadata:
  type: feedback
---

- Before telling the owner a preview is updated, verify the served page contains the change (curl the page and grep for a new string); restart `scripts/build.sh serve` if needed. Always say which port belongs to which issue.
- Agent session names don't show which issue a session works on. Ask the candidate or the owner before sending issue-specific content.

**Why:** in 1994-erp (#721/#742) a stale preview made the owner see "nothing changed", and a note went to the wrong session. The owner is impatient with slow, roundabout flows.

**How to apply:** verify before claiming; act directly when work is unblocked. Related: [[merge-via-owner-bang]].
