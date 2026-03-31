# Lesson 2: Setting Up Your First AI Team

> This lesson has a video walkthrough (coming soon). For now, follow the text guide below.

## What You'll Have After This Lesson

- 2 AI agents with persistent memory and identity
- An inbox/outbox communication system
- Agent security rules
- A source of truth document
- Automation scripts for notifications and backups
- Everything running in about 15 minutes

---

## Prerequisites

- **Claude Code** installed (or any Claude terminal client)
- **A Claude subscription** (Pro or Max)
- **macOS** (the scripts use macOS notifications — Linux users can adapt)
- **A project idea** (even vague is fine — "I want to build a web app" works)

---

## Step 1: Download the Starter Kit

Download the AI Team Starter Kit zip and unzip it somewhere on your machine.

The kit contains:
```
ai-team-starter-kit/
├── setup.sh                  <-- This is the magic script
├── templates/                <-- File templates
├── prebuilt-roles/           <-- Ready-to-go agent roles
├── scripts/                  <-- Automation
└── docs/                     <-- How it all works
```

---

## Step 2: Run the Setup Script

Open a terminal and run:

```bash
cd path/to/ai-team-starter-kit
./setup.sh
```

The script asks you 5 questions:

### Question 1: Your Name
```
Your name: Daniel
```
This goes into all the template files so your agents know who the boss is.

### Question 2: Your Location
```
Your location: Seattle, WA
```

### Question 3: What You Do
```
One line about what you do: Building a task management SaaS
```

### Question 4: Project Details
```
Project name: TaskFlow
What are you building? AI-powered task manager for remote teams
Your north star question: Does this move us closer to launch?
```

The "north star question" is powerful. Every agent reads it before every session. It keeps all decisions aligned.

### Question 5: Team Size

```
How many agents do you want to start with?

  1) Solo (1 agent) — Builder who does everything
  2) Duo (2 agents) — Builder + QA Tester
  3) Squad (4 agents) — Team Lead + Builder + QA + Designer
  4) Full Team (6 agents) — All roles

Choose [1-4]: 2
```

**Start with Duo.** You can always add more agents later. Two agents (Builder + QA) is the minimum viable team and it's enough to see the power of the system.

### Question 6: Name Your Agents

```
Give each agent a name:
  Builder: Bolt
  QA Tester: Keeper
```

Pick names you like. These become their identity. Naming matters — it's what makes them feel like teammates instead of tools.

### Done!

```
Setup Complete!

  Project: TaskFlow
  Location: ~/Desktop/TaskFlow
  Team: 2 agents

  Your agents:
    + Bolt — Builder
    + Keeper — QA Tester
```

---

## Step 3: Look at What Was Generated

Open the project folder. Here's what you'll see:

```
TaskFlow/
├── .claude.md              <-- Rules for all agents
├── SOURCE-OF-TRUTH.md      <-- Project status (everyone reads this)
├── OWNER-SOUL.md           <-- Who you are (values, style)
├── WORKFLOW-PROTOCOL.md    <-- How agents work with you
├── agents/
│   ├── READ-THIS-FIRST-Bolt.md    <-- Bolt's identity anchor
│   └── READ-THIS-FIRST-Keeper.md  <-- Keeper's identity anchor
├── agent-rules/
│   ├── Bolt-RULES.md       <-- What Bolt can/can't do
│   └── Keeper-RULES.md     <-- What Keeper can/can't do
├── memory/
│   ├── MEMORY.md            <-- Shared team memory
│   ├── bolt.md              <-- Bolt's personal memory
│   └── keeper.md            <-- Keeper's personal memory
├── inbox/
│   ├── bolt/                <-- Drop work for Bolt here
│   └── keeper/              <-- Drop work for Keeper here
├── outbox/
│   ├── bolt/                <-- Bolt delivers work here
│   └── keeper/              <-- Keeper delivers work here
└── scripts/
    ├── mailroom.sh          <-- Watches for new files, sends notifications
    ├── signal-owner.sh      <-- Agents ping you when blocked
    └── snapshot-state.sh    <-- Backup your team state
```

Every file has a purpose. No bloat.

---

## Step 4: Open Your First Agent

Open a terminal, navigate to your project, and launch Claude Code:

```bash
cd ~/Desktop/TaskFlow
claude
```

Your first message to the agent:

```
You are Bolt. Read agents/READ-THIS-FIRST-Bolt.md
```

Watch what happens. The agent reads its identity file and comes to life:

- It knows its name (Bolt)
- It knows its role (Builder)
- It knows who you are (from OWNER-SOUL.md)
- It knows the project (from SOURCE-OF-TRUTH.md)
- It knows its boundaries (from agent-rules/Bolt-RULES.md)
- It has memory that persists (from memory/bolt.md)

**This is the moment.** Your AI agent just went from "generic assistant" to "named teammate with memory and identity."

---

## Step 5: Open Your Second Agent

Open a NEW terminal tab/window:

```bash
cd ~/Desktop/TaskFlow
claude
```

First message:

```
You are Keeper. Read agents/READ-THIS-FIRST-Keeper.md
```

Now you have two agents running simultaneously, each with their own identity, memory, and rules.

---

## Step 6: Start the Mailroom (Optional)

In a third terminal:

```bash
./scripts/mailroom.sh &
```

This watches your inbox and outbox folders. When an agent drops a file, you get a macOS notification. No more checking folders manually.

---

## Step 7: Give Your First Assignment

Talk to Bolt (your Builder):

```
I need you to create a basic Express.js server with a /health endpoint.
Build it in a new directory called "api/" in my project.
```

Bolt will:
1. Read the workflow protocol (knows to ask clarifying questions if needed)
2. Build the feature
3. Commit the code
4. Report back with what was built

Then tell Keeper (your QA):

```
Bolt just built an Express server with a /health endpoint in api/.
Run it and verify the endpoint returns 200 OK.
File your QA report in outbox/keeper/.
```

Keeper will:
1. Read the code Bolt wrote
2. Test it
3. Write a QA report
4. Drop the report in their outbox folder

**You just coordinated two AI agents on a build-and-test workflow.** Each one stayed in their role. Each one knows who they are. And tomorrow, they'll remember what happened today.

---

## What Just Happened

In 15 minutes, you went from one amnesiac AI to a two-agent team with:

- Persistent memory (survives across sessions)
- Anchored identity (won't drift in long sessions)
- Security rules (can't accidentally break things)
- Communication (inbox/outbox)
- A shared source of truth
- Automated notifications

This is the foundation. In Module 2, we'll go deep on the memory system — how to make your agents genuinely smarter over time.

---

*Next: Lesson 3 — Identity Anchoring: The Secret Sauce*
