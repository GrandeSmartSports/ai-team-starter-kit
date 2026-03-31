# Module 2, Lesson 2: Structuring Memory for Teams

## The Problem with Growing Teams

Two agents? Easy. Each has a memory file. Done.

Four agents? Manageable. Four memory files plus shared memory.

Eight agents? Now you have a problem. Agent A doesn't know what Agent B decided yesterday. Agent C and Agent D are building conflicting features. The shared memory file is a mess of everyone's notes.

This lesson teaches you how to structure memory so it scales.

---

## The Three-Layer Memory Architecture

```
LAYER 1: Individual Memory
    Each agent has their own file
    Only they read/write it
    Contains: their work, their lessons, their context

LAYER 2: Shared Memory
    Everyone reads this
    Contains: team roster, universal rules, key file locations

LAYER 3: Source of Truth
    The single brain of the project
    Contains: current status, blockers, assignments, decisions
```

### Layer 1: Individual Memory

**File:** `memory/{agent-name}.md`
**Read by:** Only that agent
**Updated by:** Only that agent

This is private workspace. Your Builder doesn't need to know the details of your Designer's color palette decisions. Your QA agent doesn't need to know how the Researcher structured their competitive analysis.

Keep individual memory focused on that agent's work.

**Good individual memory:**
```markdown
## Current Work
### User Authentication API
- Built JWT token generation
- Refresh token rotation working
- Tests: 12 passing, 0 failing
- Next: Add password reset endpoint
```

**Bad individual memory (too broad):**
```markdown
## Current Work
### Everything the team is doing
- Builder is working on auth
- Designer is doing the landing page
- QA is testing the email feature
```

That second example belongs in the Source of Truth, not individual memory.

### Layer 2: Shared Memory

**File:** `memory/MEMORY.md`
**Read by:** All agents at session start
**Updated by:** Team leads or you

This is the team directory. It answers: "Who's on the team? Where do I find things? What rules apply to everyone?"

Keep it short and stable. This file shouldn't change every session — it changes when the team structure changes.

```markdown
# Shared Memory

## Team Roster
| Name | Role | Memory File |
|------|------|-------------|
| Atlas | Builder | memory/atlas.md |
| Keeper | QA | memory/keeper.md |
| Scout | Researcher | memory/scout.md |
| Spark | Designer | memory/spark.md |

## Universal Rules
- Commit often, push after QA
- Signal owner when blocked
- No paid API calls without approval
- Builder commits, QA tests, nobody else touches git

## Key Locations
- Source of Truth: SOURCE-OF-TRUTH.md
- Workflow: WORKFLOW-PROTOCOL.md
- Soul file: OWNER-SOUL.md
```

### Layer 3: Source of Truth

**File:** `SOURCE-OF-TRUTH.md`
**Read by:** All agents at session start
**Updated by:** Designated ops agent or team lead

This is the living status document. It changes frequently — after every significant milestone, blocker, or decision.

```markdown
# TaskFlow — Source of Truth

## Status Snapshot (Updated March 30)
Atlas: Building user auth — JWT complete, password reset in progress
Keeper: QA queue — email subscription passed, auth pending
Scout: Researching payment integration options
Spark: Landing page v2 — hero section complete, pricing table next

## Active Blockers
BLOCKER: Stripe API key not configured
Owner: Atlas | Status: Waiting on owner
Severity: HIGH — blocks all payment features

## Recent Decisions
- March 28: Using JWT over session tokens (Atlas recommended, owner approved)
- March 29: PostgreSQL over MongoDB for user data (Scout's research)
- March 30: Stripe over Paddle for payments (Scout's recommendation pending)
```

---

## Cross-Agent Knowledge Sharing

Sometimes Agent A needs to know what Agent B decided. How do you handle this without giving everyone access to everyone's memory?

### Pattern 1: Inbox Messages

Agent A writes a note and drops it in Agent B's inbox:

```markdown
# atlas-to-spark-2026-03-30.md

Hey Spark — the auth API returns user objects that look like this:

{
  "id": "uuid",
  "email": "user@example.com",
  "name": "Display Name",
  "role": "admin" | "user"
}

You'll need this for the dashboard user profile component.
```

This is the cleanest approach. Explicit communication. No ambiguity.

### Pattern 2: Source of Truth Decisions

Major decisions that affect multiple agents go in the Source of Truth:

```markdown
## Recent Decisions
- Auth tokens expire after 24 hours (affects API and frontend)
- User roles: "admin" and "user" only (affects UI permission checks)
- All API responses use camelCase (affects frontend data parsing)
```

Every agent reads this, so every agent knows.

### Pattern 3: Shared Knowledge Files

For larger blocks of shared context, create a dedicated file:

```
docs/api-contracts.md     — All API endpoint specs
docs/data-models.md       — All data schemas
docs/design-tokens.md     — Colors, fonts, spacing
docs/architecture.md      — System architecture decisions
```

Reference these in the shared memory file so agents know where to look.

---

## Memory Anti-Patterns (What NOT to Do)

### 1. One Giant Memory File for Everyone
```markdown
# EVERYTHING.md
[Builder's work]
[QA's reports]
[Designer's decisions]
[Researcher's findings]
[500+ lines of mixed context]
```
**Why it fails:** Too noisy. Agents can't find their own context. Important info gets buried.

### 2. No Memory at All (Relying on Conversation)
**Why it fails:** Session ends, everything is lost. Tomorrow starts from scratch.

### 3. Memory That Never Gets Cleaned
```markdown
## Current Work
### Feature from January (DONE)
### Bug fix from February (DONE)
### Feature from March (DONE)
### Actual current work
```
**Why it fails:** The file becomes so long that the agent stops reading it effectively. Completed work should move to session notes or get archived.

### 4. Agents Editing Each Other's Memory
**Why it fails:** Agent A overwrites something Agent B wrote. Merge conflicts in memory files. Use inbox/outbox instead.

---

## The Soul File: Memory for Your Identity

There's one more memory file we haven't discussed: the Owner Soul file.

This isn't about project status — it's about WHO YOU ARE as the project owner.

```markdown
# Owner Soul

## What I Believe
- Agents are teammates, not tools
- Truth over speed
- Data is sacred, code is disposable

## How I Communicate
- Direct, casual, no jargon
- I want honest feedback, not agreement
- One question at a time, not walls of text

## My North Star
"Does this move us closer to launch?"
```

Every agent reads this. It means every agent communicates the way you prefer, challenges you the way you want to be challenged, and makes decisions aligned with your values.

This is the most underrated file in the entire system. It's why agents feel like teammates instead of tools.

---

## Key Takeaway

Memory scales through layers: individual (private workspace), shared (team directory), and source of truth (project brain). Keep each layer focused on its purpose. Use inbox/outbox for cross-agent communication. Clean your memory files monthly.

The next lesson covers advanced memory techniques — learning systems where agents get smarter over time, and how to build memory that compounds.

---

*Next: Lesson 3 — Making Agents Smarter Over Time*
