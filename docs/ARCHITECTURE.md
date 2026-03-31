# AI Team Starter Kit — How It Works

## The Problem

You're using Claude Code (or similar AI coding tools) as a single agent with no memory. Every session starts fresh. You waste time re-explaining context. The AI drifts off task in long sessions. You can't coordinate multiple agents.

## The Solution

This kit turns a single AI agent into a coordinated team with:
- **Persistent memory** that survives across sessions
- **Identity anchoring** that prevents agents from drifting
- **Communication infrastructure** (inbox/outbox) between agents
- **Security boundaries** that keep each agent in their lane
- **Automation scripts** for notifications and backups
- **A workflow protocol** that teaches agents how to work with you

## Architecture Overview

```
YOU (Owner/Founder)
|
+--- GOVERNANCE LAYER
|    +-- .claude.md (global rules — what agents can/can't do)
|    +-- SOURCE-OF-TRUTH.md (project status — single brain)
|    +-- OWNER-SOUL.md (your identity — who agents work for)
|    +-- WORKFLOW-PROTOCOL.md (how agents work with you)
|
+--- TEAM LAYER
|    +-- agents/READ-THIS-FIRST-{Name}.md (identity anchors)
|    +-- agent-rules/{Name}-RULES.md (security boundaries)
|    +-- memory/{name}.md (persistent memory per agent)
|    +-- memory/MEMORY.md (shared team memory)
|
+--- COMMUNICATION LAYER
|    +-- inbox/{agent}/ (work assignments IN)
|    +-- outbox/{agent}/ (deliverables OUT)
|    +-- scripts/mailroom.sh (notification watcher)
|    +-- scripts/signal-owner.sh (blocking alerts)
|
+--- AUTOMATION LAYER
     +-- scripts/snapshot-state.sh (disaster recovery)
     +-- Cron jobs for automated backups
```

## Key Concepts

### Identity Anchoring
AI agents lose their identity in long sessions. Context compression weakens early instructions. The READ-THIS-FIRST pattern forces agents to re-anchor their identity at session start and every 10+ messages. This is the single most important innovation in this kit.

### Persistent Memory
Each agent has a memory file that they read at session start and update as they work. This means Agent A remembers what they did yesterday without you re-explaining it. Shared memory (MEMORY.md) keeps the team roster and universal rules in sync.

### Agent Rules (Security)
Each agent has explicit boundaries — what they CAN do and what they CANNOT do. This prevents scope creep, accidental deletions, credential exposure, and agents overriding each other. Anti-tunnel rules prevent agents from creating workarounds to bypass their boundaries.

### Inbox/Outbox Communication
Agents communicate via files in a shared inbox/outbox structure. The owner drops work in an agent's inbox. The agent delivers results to their outbox folder. The mailroom script watches for new files and sends macOS notifications.

### Source of Truth
One living document that tracks project status, active blockers, team assignments, and operating rules. Every agent reads this at session start so everyone is aligned.

### Owner Soul File
A document that captures who you are — your values, communication style, vision, and what you believe. Agents read this so they understand the human they're working for, not just the code they're writing.

## Why This Works

1. **Clear identity = focused work.** Agents with anchored identity don't drift off task.
2. **Memory = continuity.** No more "starting fresh" every session.
3. **Boundaries = safety.** Agents can't accidentally break things outside their scope.
4. **Communication = coordination.** Multiple agents can work in parallel without stepping on each other.
5. **One source of truth = alignment.** Everyone knows the current state of the project.
6. **Automation = sanity.** You get notified when agents need you. Backups happen automatically.

## Scaling Your Team

**Start small (2 agents), grow as needed:**

- **2 agents:** Builder + QA — the minimum viable team
- **4 agents:** Add a Team Lead (coordination) + Designer (polish)
- **6 agents:** Add Researcher (strategy) + Ops (organization)
- **8+ agents:** Split into sub-teams with Team Leads who spawn their own subagents

The kit's patterns scale because each agent is self-contained — their own memory, rules, identity, and inbox. Adding an agent means creating 3-4 files, not rewriting the system.

## Battle-Tested

This system was built organically while shipping real products:
- 2 iOS apps live in the App Store
- Multiple web apps in production
- 8 active AI agents coordinating daily
- Months of real-world use, debugging, and refinement

The patterns in this kit aren't theoretical — they solved real problems that emerged from running multi-agent teams at scale.
