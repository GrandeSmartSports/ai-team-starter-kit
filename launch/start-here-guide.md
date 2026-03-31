# Start Here — Set Up Your AI Team in 10 Minutes
## The only guide you need to go from one agent to a coordinated team

---

## What You're About to Build

Right now you probably have one AI agent (Claude Code, Cursor, etc.) in one terminal. No memory. No identity. Starting fresh every session.

In 10 minutes you'll have a team of 2-6 agents with:
- Names and identities that stick during long sessions
- Memory that persists across sessions
- Security rules so agents stay in their lane
- Communication infrastructure (inbox/outbox)
- Automation that pings you when agents need attention

Let's go.

---

## Step 1: Download the Starter Kit

Download the AI Team Starter Kit zip from the Resources section of this community.

Unzip it somewhere on your machine. You'll see:

```
ai-team-starter-kit/
├── setup.sh           <- The magic script
├── agents/            <- Identity templates
├── prebuilt-roles/    <- Ready-made agent roles
├── scripts/           <- Automation
├── docs/              <- How it all works
└── ...
```

---

## Step 2: Run the Setup Script

Open a terminal and run:

```bash
cd ~/Downloads/ai-team-starter-kit   # or wherever you unzipped it
chmod +x setup.sh
./setup.sh
```

It asks you 5 questions:

1. **Your name** — who's the boss
2. **Your location** — just context
3. **What you do** — one line
4. **Your project name** — what are you building
5. **What are you building** — one sentence
6. **Your north star** — the question every decision asks
7. **Where to install** — it suggests a folder, or pick your own
8. **Team size** — start with Duo (2 agents) if this is your first time

It also asks you to name your agents. Use real names — "Bolt" and "Scout" feel different than "Agent 1" and "Agent 2." Names create identity.

The script generates everything — CLAUDE.md, memory files, identity anchors, rules, inbox/outbox, automation scripts. Done in about 30 seconds.

---

## Step 3: Open Your Terminals

Each agent gets their own Claude Code terminal. If you chose 2 agents (Builder + QA), open 2 terminals.

**Terminal 1 — Your Builder:**

```bash
cd ~/Desktop/YourProject   # wherever setup.sh installed
claude
```

First message:
> "You are Builder. Read agents/READ-THIS-FIRST-Builder.md"

**Terminal 2 — Your QA:**

```bash
cd ~/Desktop/YourProject
claude
```

First message:
> "You are QA. Read agents/READ-THIS-FIRST-QA.md"

Each agent reads their identity file, then their memory, then the workflow protocol. They'll introduce themselves and ask for work.

That's it. Your team is alive.

---

## Step 4: Give Your First Assignment

Talk to your Builder like a teammate, not a chatbot:

> "I need a landing page for my product. It should have a hero section, features list, and email signup form. Use HTML/CSS/JS, keep it simple, deploy to Vercel when you're done."

The agent will:
1. Confirm the assignment ("Filed. Anything else?")
2. Ask clarifying questions one at a time
3. Say "Going dark to build"
4. Build it, commit code, do QA
5. Report back with what was built and what you need to test

Then hand it to QA:

> "Builder just finished the landing page. Please run a full QA — check all links, test on mobile, verify the signup form works."

QA tests everything and gives you a pass/fail report with bug details.

---

## Step 5: Start the Mailroom (Optional)

Want macOS notifications when agents drop files in inbox/outbox?

```bash
~/Desktop/YourProject/scripts/mailroom.sh &
```

You'll hear a notification sound whenever an agent delivers work or needs attention.

---

## How Memory Works

After your first session, your agents will have written to their memory files. Next time you open a terminal and tell them to read their identity file, they'll also read their memory — and pick up right where they left off.

No more re-explaining context. No more "let me read the codebase again." They remember.

---

## The Identity Trick (Why This Works)

In long sessions (10+ messages), AI agents start to forget who they are. Your "Builder" starts acting like a generic assistant. Your "QA" starts writing code instead of testing.

The READ-THIS-FIRST files fix this. Every session starts with the agent reading: "YOU ARE [Name]. You are NOT anyone else." And there's a built-in check every 10 messages.

I discovered this the hard way — my AI brain architect kept drifting to acting like my build engineer. Four incidents before I created the anchor file system. Now it doesn't happen.

---

## What's Next

You're set up. Here's how to level up:

**This week:**
- Give your team a real project (not a test)
- Let them work. Trust the process.
- Post your first win in the Wins channel

**This month:**
- Add a third agent (Designer or Researcher)
- Start customizing agent rules for your specific needs
- Read the Architecture doc in the docs/ folder

**Ongoing:**
- Follow the Behind the Scenes channel — I post what I'm building with my 8-agent team weekly
- Ask questions in Help — I respond to everything
- Share what's working for you so others can learn

---

## Quick Troubleshooting

**Agent seems confused about identity:**
Tell it: "Re-read agents/READ-THIS-FIRST-[YourName].md right now."

**Agent forgot what we worked on yesterday:**
Tell it: "Read your memory file at memory/[name].md"

**Two agents working on the same thing:**
Use inbox/outbox. Drop a note in each agent's inbox specifying their task so there's no overlap.

**Agent needs something outside its rules:**
It should ask you. If it doesn't, check agent-rules/[Name]-RULES.md to see the boundaries.

---

## You're Ready

That's the whole system. Identity, memory, rules, communication. You now have what took me months to figure out — packaged into a 10-minute setup.

Go build something. Post your first win. Welcome to the team.

— Daniel
