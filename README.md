# AI Team Starter Kit

**Build a coordinated team of AI agents that ships real products.**

One setup script. Five questions. Your AI team is running in 10 minutes.

---

## What This Is

A complete system for running multiple AI coding agents as a coordinated team. Built from 7 weeks of daily use shipping 2 iOS apps and 5+ web apps with an 8-agent team.

### The Problem

Most people using AI coding tools (Claude Code, Cursor, etc.) hit the same walls:

- **No memory.** Every session starts from zero.
- **Identity drift.** Agents forget their role in long sessions.
- **No coordination.** Multiple agents step on each other.
- **No guardrails.** Agents can accidentally break things.

### The Solution

Six components that make AI agents work like a real team:

| Component | What It Does |
|-----------|-------------|
| **Identity Anchoring** | Files on disk agents re-read to stay in role. No more drift. |
| **Persistent Memory** | Markdown files that survive across sessions. No more re-explaining. |
| **Security Rules** | "Ask Before" and "Can Do Freely" lists. Safe to trust. |
| **Communication** | Inbox/outbox for clean handoffs between agents. |
| **Source of Truth** | One document everyone reads. Always aligned. |
| **Automation** | Notification scripts, backups, monitoring. |

---

## Quick Start

```bash
git clone https://github.com/GrandeSmartSports/ai-team-starter-kit.git
cd ai-team-starter-kit
chmod +x setup.sh
./setup.sh
```

The script asks 5 questions and generates your entire team: identity files, memory, rules, communication folders, and automation scripts.

---

## What's Included

```
ai-team-starter-kit/
├── setup.sh                    # Interactive setup script
├── agents/                     # Identity, rules, and memory templates
├── prebuilt-roles/             # 6 ready-made agent roles
│   ├── team-lead.md
│   ├── builder.md
│   ├── qa-tester.md
│   ├── designer.md
│   ├── ops.md
│   └── researcher.md
├── scripts/                    # Automation
│   ├── mailroom.sh             # Inbox/outbox notifications
│   ├── signal-owner.sh         # Urgent alerts
│   └── snapshot-state.sh       # Team state backups
├── docs/
│   └── ARCHITECTURE.md         # System design explained
└── course/                     # 5-module, 16-lesson course
    ├── module-1/               # The Foundation
    ├── module-2/               # Memory Systems
    ├── module-3/               # Rules & Security
    ├── module-4/               # Scaling Your Team
    └── module-5/               # Real-World Playbook (Bonus)
```

---

## The Course

16 lessons across 5 modules. Read them in order or jump to what you need.

| Module | Lessons | What You Learn |
|--------|---------|----------------|
| 1: The Foundation | 4 | First team, identity anchoring, first build session |
| 2: Memory Systems | 3 | Persistent memory, team memory, compounding knowledge |
| 3: Rules & Security | 3 | Agent rules, security, communication patterns |
| 4: Scaling | 3 | Going from 2 to 8+ agents, team leads, quality |
| 5: Real-World Playbook | 3 | Soul documents, advanced workflows, automation |

---

## Who Built This

I'm Daniel. I'm not a traditional developer. I'm a product builder who directs AI agents. I started with one Claude Code terminal 7 weeks ago. Now I run 8 coordinated agents that ship real products every day.

This system wasn't planned. It was built one piece at a time, through real pain, while shipping real products. Every pattern in the course comes from a problem I hit and solved.

---

## Community

I run a paid community where I teach this system, share behind-the-scenes from my daily work, and help members set up their own AI teams.

**AI Team Builders**, $29/month founding member rate (locked forever for early members).

Includes: starter kit, full course, weekly content, direct access to ask questions, community of builders.

---

## License

MIT. Use it however you want.
