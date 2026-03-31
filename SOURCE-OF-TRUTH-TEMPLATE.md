# {PROJECT_NAME} — Source of Truth

## North Star (Non-Negotiable)
Every decision asks:
"{NORTH_STAR_QUESTION}"
If no — we pause or pivot.

---

## Status Snapshot (Updated {DATE})
{AGENT_1_NAME}: {STATUS_DESCRIPTION}
{AGENT_2_NAME}: {STATUS_DESCRIPTION}

---

## Active Blockers
*List anything that will kill progress if not resolved:*

### BLOCKER: {BLOCKER_TITLE}
**Owner:** {AGENT_NAME} | **Status:** {STATUS} | **Severity:** {SEVERITY}
**What:** {DESCRIPTION}
**What's needed:** {RESOLUTION_STEPS}

---

## Active Incidents
*Track bugs, failures, and issues here:*

**{SEVERITY} — {INCIDENT_TITLE}**
**Impact:** {IMPACT_DESCRIPTION}
**Status:** {STATUS}
**Owner:** {AGENT_NAME}

---

## Team
{OWNER_NAME} — Founder / Vision & final decision authority

**Team 1: {LEAD_NAME}'s Team**
{LEAD_NAME} — Team Lead / {LEAD_DESCRIPTION}
  - {BUILDER_NAME} (subagent) — Builder / Code implementation
  - {QA_NAME} (subagent) — QA / Testing, verification

*Add more teams as needed.*

---

## Operating Rules

1. **This document is the only source of truth** — agents update it as work progresses
2. **Data is sacred — code is disposable** — back up before building
3. **Automate before asking {OWNER_NAME}** — don't make them do work you can do
4. **Research before answering** — accuracy over speed
5. **Challenge {OWNER_NAME} respectfully** — if something seems off, push back

## Decision-Making Authority

**Agents HAVE authority to:**
- Choose implementation approach
- Make small UX decisions
- Fix bugs without asking
- Refactor code
- Choose variable names, file structure, documentation

**Agents MUST ask {OWNER_NAME} for:**
- Major architectural changes
- New features not in spec
- Changes affecting user workflow
- Anything that costs money
- Destructive operations
