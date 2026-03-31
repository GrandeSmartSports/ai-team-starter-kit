# Module 4, Lesson 2: Team Leads and Sub-Teams

## The Management Problem

At 4 agents, you can manage everyone directly. You give tasks, check status, coordinate handoffs.

At 6+ agents, this breaks. You become the bottleneck. Every agent needs your attention. Every handoff goes through you. Every question comes to you.

**The fix: promote agents to Team Leads.**

---

## The Team Lead Pattern

Instead of managing 6 agents directly, you manage 2 Team Leads. Each Team Lead manages their own sub-team.

### Before (flat — you manage everyone):
```
You
├── Frontend Builder
├── Backend Builder
├── QA
├── Designer
├── Ops
└── Researcher
```

You're managing 6 direct reports. That's a full-time job.

### After (hierarchical — Team Leads manage sub-teams):
```
You
├── Team Lead 1 (Build Team)
│   ├── Frontend Builder
│   ├── Backend Builder
│   └── QA
└── Team Lead 2 (Support Team)
    ├── Designer
    ├── Ops
    └── Researcher
```

You talk to 2 Team Leads. They manage the rest.

---

## What Makes a Good Team Lead

A Team Lead agent is different from a Builder or QA. It needs:

### 1. Coordination Skills
The Team Lead assigns tasks, tracks progress, and handles handoffs within their sub-team. Their identity anchor reflects this:

```markdown
# Relay — Read This First

YOU ARE RELAY. Team Lead — Build Team.

## Your Role
You don't build. You COORDINATE.
- Assign tasks to your team (Builder, QA)
- Track progress and unblock your team
- Report status to the Owner
- Make tactical decisions within your scope

## Your Team
- Builder (Bolt) — code implementation
- QA (Keeper) — testing and verification
- You coordinate between them

## What You Own
- Task assignment and priority for your sub-team
- Build schedule and sprint planning
- Status reporting to Owner
- Cross-team coordination with other Team Leads
```

### 2. Decision Authority
Team Leads need the authority to make decisions without you:

```markdown
## Decision Authority
### You decide (no need to ask Owner):
- Task priority within your team
- Which agent works on what
- How to break down features into tasks
- When to move from build to QA
- Bug severity and fix priority

### Escalate to Owner:
- New features not in the current sprint
- Architecture changes
- Anything that affects the other team
- Budget or timeline questions
```

### 3. Communication Hub
The Team Lead is the communication center. Builders don't talk to QA directly — they go through the Team Lead:

```markdown
## Communication Flow
Owner ←→ You ←→ Your sub-team
Other Team Lead ←→ You ←→ Your sub-team

Your sub-team does NOT talk to:
- The Owner directly (go through you)
- The other sub-team (go through you)
```

---

## Setting Up Sub-Teams

### Step 1: Choose Your Team Leads

Pick 2 roles that naturally divide your work:

| Team 1 | Team 2 |
|--------|--------|
| Build (coding, testing) | Product (design, research, ops) |
| Frontend (UI, UX, design) | Backend (API, database, ops) |
| Core Product (main app) | Platform (infrastructure, tooling) |

### Step 2: Create Team Lead Identity Anchors

Each Team Lead gets an identity anchor that emphasizes coordination over building:

```markdown
## Startup Sequence
1. Read this anchor file
2. Read your memory file
3. Read the Source of Truth
4. Check your inbox
5. Check your sub-team's status updates
6. Plan the session's work
7. Assign tasks to your sub-team
```

### Step 3: Set Up Sub-Team Memory

Each sub-team gets a shared memory section:

```markdown
## Team 1 — Build Team

### Team Roster
| Agent | Role | Status |
|-------|------|--------|
| Relay | Team Lead | Active |
| Bolt | Builder | Active |
| Keeper | QA | Active |

### Current Sprint
- Feature: User Authentication
- Status: Bolt building API, Keeper waiting for handoff
- Target: End of day

### Sub-Team Rules
- Bolt commits after every completed endpoint
- Keeper tests within 1 hour of handoff
- Relay reviews all QA reports before sending to Owner
```

---

## The Daily Rhythm with Team Leads

Here's how a typical day flows:

### Morning (You — 10 minutes)
1. Read both Team Leads' status updates
2. Set priorities for the day
3. Send each Team Lead their tasks

### During the Day (Team Leads manage)
4. Team Leads break down tasks and assign to their sub-team
5. Builders build and hand off to QA
6. QA tests and reports back to Team Lead
7. Team Leads coordinate between their agents
8. Team Leads handle blockers within their authority

### End of Day (Team Leads — 5 minutes each)
9. Each Team Lead writes a status update
10. Status includes: completed, in progress, blocked, needs from you

### Evening (You — 5 minutes)
11. Read the status updates
12. Unblock anything that's stuck
13. Plan tomorrow's priorities

**Total time from you: 20 minutes.** The Team Leads handle the other 8 hours.

---

## When Things Go Wrong

### Problem: Team Lead is doing all the work itself
**Fix:** Re-read the identity anchor. "You don't build. You COORDINATE." If the Team Lead keeps building, add explicit rules:

```markdown
## Anti-Pattern: Doing Everything
You are NOT a builder. If you catch yourself writing code:
STOP. Assign it to Bolt instead.

Your job is to:
- Tell Bolt WHAT to build
- Tell Keeper WHAT to test
- Report results to Owner
```

### Problem: Sub-team agents bypass the Team Lead
**Fix:** Update agent rules:

```markdown
## Communication
- All messages to Owner go through your Team Lead
- All task assignments come from your Team Lead
- If you need something from another team, tell your Team Lead
```

### Problem: Team Leads can't agree on priorities
**Fix:** That's your job. You set the priorities, Team Leads execute. Add to their rules:

```markdown
## Priority Disputes
If you disagree with the other Team Lead about priorities:
1. Escalate to Owner
2. Do NOT block work while waiting
3. Continue with your current priorities until Owner decides
```

---

## The Sub-Agent Pattern (Advanced)

In Claude Code specifically, Team Leads can spawn sub-agents — temporary agents that run within their session. This is different from separate terminal agents:

```
Terminal 1: Team Lead (Relay)
  └── Spawns sub-agents as needed:
      ├── Builder task → runs, reports back
      └── QA task → runs, reports back

Terminal 2: Team Lead (Cortex)
  └── Spawns sub-agents as needed:
      ├── Research task → runs, reports back
      └── Design review → runs, reports back
```

Sub-agents share the Team Lead's context and report back automatically. No inbox/outbox needed — they're part of the same session.

This is the most efficient pattern for Claude Code users because:
- No separate terminals to manage
- Sub-agents inherit the Team Lead's memory
- Results come back immediately
- The Team Lead can parallelize work

---

## Key Takeaway

Team Leads let you scale from managing 6 agents to managing 2. The Team Lead coordinates, assigns tasks, and handles sub-team communication. You set priorities and unblock. Everyone else executes.

This is the pattern that lets one person manage an 8-agent team in 20 minutes a day.

---

*Next: Lesson 3 — Maintaining Quality at Scale*
