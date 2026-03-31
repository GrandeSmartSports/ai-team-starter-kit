# Module 2, Lesson 3: Making Agents Smarter Over Time

## The Compound Effect of Memory

Most people think of AI memory as a simple log — write what happened, read it next time. That works, but it's just the beginning.

The real power comes when your agents **learn from their mistakes** and **accumulate institutional knowledge** that makes them better at their job over time.

This is the difference between an agent that remembers what it did and an agent that's genuinely smarter than it was a month ago.

---

## The Lessons Learned Pattern

Every memory file has a "Lessons Learned" section. This is where compounding happens.

### How It Works

When something goes wrong (or surprisingly right), the agent adds it to Lessons Learned:

```markdown
## Lessons Learned

### Bugs & Mistakes
- Always validate email format before saving (Session: March 15)
- Never use `git push --force` on shared branches (Session: March 18)
- Check for null responses from external APIs before parsing (Session: March 22)

### Performance
- Database queries on user table need an index on email column (Session: March 20)
- Caching API responses reduced load time from 2s to 200ms (Session: March 25)

### Architecture
- JWT refresh tokens should rotate on each use (Session: March 28)
- Separate auth logic into its own service file — cleaner (Session: March 28)

### Owner Preferences
- Owner prefers Tailwind over plain CSS
- Owner wants snake_case in the API, camelCase in the frontend
- Owner doesn't want time estimates — use complexity ratings instead
```

### Why It Compounds

Session 1: The agent doesn't know your preferences.
Session 5: The agent knows your coding style.
Session 20: The agent knows your architecture patterns, common bugs to avoid, and how to communicate with you.
Session 50: The agent is essentially a senior team member with institutional knowledge.

**Every lesson learned is a mistake that never happens again.**

---

## The "Known Issues" Pattern

Some problems are recurring. Track them explicitly:

```markdown
## Known Issues

### The Timezone Bug
When saving timestamps, always use UTC. The server is in US-East
but the owner is in US-Pacific. We've been bitten by this twice.
Always: new Date().toISOString() — never: new Date().toString()

### The CORS Problem
Every new API endpoint needs CORS headers. We forget this every
time and waste 20 minutes debugging "why doesn't the frontend
work?" Add CORS middleware to every new route immediately.
```

These are like sticky notes on your monitor. The agent sees them every session and proactively avoids the traps.

---

## The Decision Log

Major decisions should be logged with WHY, not just WHAT:

```markdown
## Key Decisions

### Database: PostgreSQL over MongoDB (March 20)
WHY: Our data is highly relational (users → teams → projects).
MongoDB would require manual join logic. PostgreSQL handles this
natively. Scout's research confirmed this — see docs/database-research.md.

### Auth: JWT over Sessions (March 22)
WHY: We need stateless auth for API consumers. Sessions require
server-side storage which adds complexity. JWT with refresh token
rotation gives us security without server state.

### Payments: Stripe over Paddle (March 28)
WHY: Better API, more documentation, larger community. Paddle is
simpler but we need Stripe's subscription management features for
team billing.
```

When a new agent joins the team (or an existing agent's context gets compressed), the decision log tells them WHY things are the way they are. Without it, agents might suggest changing something that was deliberately chosen.

---

## Building a Project Knowledge Base

As your project grows, some knowledge doesn't belong in individual memory — it's project-wide. Create dedicated knowledge files:

```
docs/
├── api-contracts.md      — Every endpoint, request/response format
├── data-models.md        — Every database table and its fields
├── architecture.md       — System design, why it's structured this way
├── deployment.md         — How to deploy, environment variables
├── common-bugs.md        — Bugs that keep coming back and how to fix them
└── glossary.md           — Project-specific terminology
```

Reference these in your shared memory:

```markdown
## Project Knowledge
- API specs: docs/api-contracts.md (updated after every new endpoint)
- Data models: docs/data-models.md (updated after every migration)
- Architecture: docs/architecture.md (updated after major decisions)
```

Agents read the knowledge files when they need context for a specific task. Not every session — just when relevant.

---

## The Memory Checkpoint Pattern

Every 2 weeks, do a memory checkpoint:

1. **Review each agent's memory file** — is it accurate? Is it bloated?
2. **Archive old session notes** — move completed work to an archive file
3. **Update the Source of Truth** — does it reflect reality?
4. **Check Lessons Learned** — any patterns you should extract into docs?
5. **Update the Knowledge Base** — any new decisions or conventions?

This takes 30 minutes and keeps your entire memory system healthy.

---

## Memory Scaling Rules

| Team Size | Memory Approach |
|-----------|----------------|
| 1-2 agents | Individual memory + Source of Truth. Keep it simple. |
| 3-4 agents | Add shared memory file. Start a docs/ knowledge base. |
| 5-8 agents | Full three-layer architecture. Inbox/outbox for cross-agent communication. Monthly cleanups. |
| 8+ agents | Sub-team memory (each team has shared memory). Team leads manage their sub-team's memory. |

---

## Key Takeaway

Memory isn't just a log — it's a learning system. Lessons Learned prevent repeated mistakes. Decision logs preserve institutional knowledge. Known Issues proactively avoid traps. The longer your agents run, the smarter they get.

This is the real moat. Your agents have context that no one else's agents have. They know your project, your preferences, your architecture, and your mistakes. That's irreplaceable.

---

*End of Module 2. Next up: Module 3 — Agent Rules & Security*
