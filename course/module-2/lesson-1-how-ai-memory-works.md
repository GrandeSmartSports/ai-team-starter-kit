# Module 2, Lesson 1: How AI Memory Actually Works

## The Truth About AI Memory

Here's something most people don't understand: **AI doesn't have memory. At all.**

Every time you start a new Claude session, the AI has zero knowledge of your previous conversations. It doesn't remember your name. It doesn't remember your project. It doesn't remember the brilliant architecture decision you made together last Tuesday.

The AI "remembers" things within a single session only because your entire conversation is fed back to it with every message. It's not remembering — it's re-reading the whole conversation every time you press enter.

When the session ends, it's gone. Permanently.

---

## Context Windows: The Whiteboard Analogy

Think of the AI's "brain" as a whiteboard of fixed size.

- **Claude Opus:** Very large whiteboard (~200,000 tokens, roughly 150,000 words)
- **Claude Sonnet:** Medium whiteboard (~200,000 tokens)
- **GPT-4:** Medium whiteboard (~128,000 tokens)

As your conversation fills the whiteboard, old content gets erased (compressed) to make room for new content. This is why:

1. Early instructions get weakened (identity drift)
2. The AI "forgets" things you discussed an hour ago
3. Very long sessions become less coherent

**The whiteboard gets wiped completely between sessions.**

---

## The Three Types of Memory You Need

To make AI agents that actually remember, you need three types of memory:

### 1. Session Memory (Built-in, Limited)
This is what the AI already has — the conversation itself. It works within a session but dies when the session ends.

**Analogy:** Your short-term memory. You remember what someone said 5 minutes ago, but not what someone said last week.

### 2. Persistent Memory (Files on Disk)
This is what we build. Memory files that agents read at session start and update as they work. The files live on your computer — they never get erased unless you delete them.

**Analogy:** A notebook you carry everywhere. You write down important things and read them the next morning.

### 3. Shared Memory (Team Coordination)
Memory that all agents can read. The Source of Truth document, shared MEMORY.md, and the inbox/outbox system. This is how agents know what other agents have done.

**Analogy:** A shared whiteboard in the office that everyone can see.

---

## How Persistent Memory Works in Our System

Here's the flow:

```
SESSION START
     |
     v
Agent reads memory/{name}.md
     |
     v
Agent knows: what it worked on last time,
what decisions were made, what's next
     |
     v
[Agent works for the session]
     |
     v
Agent updates memory/{name}.md with new context
     |
     v
SESSION END
     |
     v
Memory file persists on disk
     |
     v
NEXT SESSION START
     |
     v
Agent reads memory/{name}.md
     |
     v
Continuity restored. Agent picks up where it left off.
```

The magic is simple: **read a file at the start, write to it during work.** That's it. No database. No API. No vector embeddings. Just a markdown file on your hard drive.

---

## What Goes in a Memory File

A good memory file has four sections:

### 1. Identity (Who Am I)
```markdown
## Identity
- I am Bolt — Builder for TaskFlow
- Boss = Daniel
- I own: api/ directory, database migrations, server config
```

This is redundant with the identity anchor file — on purpose. Redundancy prevents drift.

### 2. Current Work (What Am I Doing)
```markdown
## Current Work

### Email Subscription API
- Status: Complete, QA passed
- Branch: feature/email-subscribe
- Commits: abc123, def456
- Key files: api/subscribe.js, api/subscribers.js
- Next: Add rate limiting
```

This section grows and changes every session. It's your agent's work log.

### 3. Lessons Learned (What Did I Learn)
```markdown
## Lessons Learned
- Always add duplicate checks on insert endpoints
- The POST endpoint needs input validation before saving
- JSON file storage works for prototype but needs database for production
```

This is where agents get genuinely smarter. A lesson learned in session 5 prevents the same mistake in session 50.

### 4. Session Notes (What Happened When)
```markdown
## Session Notes

### March 30 — Email Subscription Build
- Built POST and GET endpoints
- QA found duplicate email bug, fixed
- Landing page complete with form validation
- Next session: Add rate limiting and error logging
```

Dated entries give you (and the agent) a timeline of progress.

---

## The Shared Memory File

The shared `memory/MEMORY.md` file serves a different purpose — team coordination:

```markdown
# Shared Memory — All Teammates

## Team Roster
| Name | Memory File | Role |
|------|-------------|------|
| Bolt | memory/bolt.md | Builder |
| Keeper | memory/keeper.md | QA Tester |

## Universal Rules
- Commit freely
- Signal owner when blocked
- No paid API calls without approval

## Key Files
- SOURCE-OF-TRUTH.md — project status
- WORKFLOW-PROTOCOL.md — how we work
```

Every agent reads this at session start. It tells them who else is on the team, where to find things, and what rules apply to everyone.

---

## Memory Hygiene: Keeping Files Clean

Memory files can grow bloated over time. Here's how to keep them useful:

### Do:
- Update after every significant work session
- Keep "Current Work" focused on active projects (archive completed ones)
- Add to "Lessons Learned" when something breaks or surprises you
- Use dates in session notes

### Don't:
- Log every single command or action (too noisy)
- Keep completed work in "Current Work" forever (move to session notes)
- Let the file grow beyond ~500 lines (agents won't read all of it effectively)

### Monthly Cleanup:
Once a month, review your agents' memory files:
1. Archive old session notes to a separate file
2. Remove completed projects from "Current Work"
3. Keep "Lessons Learned" — those are permanent
4. Update "Identity" if the agent's role has evolved

---

## Key Takeaway

AI memory is a file. You read it at the start, you write to it during work, and it persists on disk between sessions. No database, no API, no complexity. Just a markdown file that gives your AI continuity.

The next lesson covers advanced memory patterns — how to structure memory for teams of 4+ agents, how to handle cross-agent knowledge, and how to build a "Source of Truth" that actually works.

---

*Next: Lesson 2 — Structuring Memory for Teams*
