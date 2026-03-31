# Module 4, Lesson 1: From Two Agents to Four

## When to Scale

You've been running a Builder + QA pair for a few weeks. It works great. So when do you add more agents?

**Scale when you feel the bottleneck.** Not before.

Signs you need more agents:
- Your Builder is constantly switching between frontend and backend work
- QA can't keep up with the Builder's output
- You're spending time on tasks agents could handle (documentation, research, design)
- Features are sitting untested because QA is backlogged
- You need specialized knowledge (database optimization, security audit, design system)

Signs you DON'T need more agents:
- Everything is flowing smoothly
- You don't have enough work to keep 2 agents busy
- You're still figuring out the workflow with 2

**The rule: If 2 agents feel easy, stay at 2. If 2 agents feel like a bottleneck, add 2 more.**

---

## The First Expansion: Splitting the Builder

The most common first expansion: split your Builder into Frontend and Backend.

### Before (2 agents):
```
Builder → builds everything (frontend + backend + database)
QA     → tests everything
```

### After (4 agents):
```
Frontend Builder → HTML, CSS, JavaScript, UI components
Backend Builder  → API, database, server logic
QA              → tests everything
Ops/Research     → documentation, deployment, research
```

### Why This Works

Your original Builder was probably context-switching between frontend and backend constantly. Each switch costs cognitive overhead — the agent has to reload different mental models, different file sets, different patterns.

Split agents stay focused. The Frontend Builder thinks in HTML/CSS/JavaScript all day. The Backend Builder thinks in APIs and databases all day. Each one gets better at their specialty faster.

---

## Setting Up Agent #3: Frontend Builder

Run the starter kit's setup for a new agent, or create the files manually:

### 1. Identity Anchor
```markdown
# Spark — Read This First

YOU ARE SPARK. Frontend Builder.

## Who You Are
Name: Spark
Role: Frontend Builder — HTML, CSS, JavaScript, UI/UX
Boss: [Your name]

## What You Own
- All files in src/components/
- All files in src/pages/
- All CSS/SCSS files
- Frontend build configuration

## What You Don't Own
- api/ directory (Backend Builder)
- database/ directory (Backend Builder)
- tests/ directory (QA)

## Startup Sequence
1. Read this file
2. Read memory/spark.md
3. Read the workflow protocol
4. Check inbox/spark/
```

### 2. Rules File
Same structure as Module 3, but customized:
```markdown
## Spark-Specific Rules
- Use Tailwind CSS (project standard)
- Mobile-first responsive design
- No direct API calls — use the service layer
- All new components need props documentation
```

### 3. Memory File
```markdown
# Spark Memory

## Identity
- I am Spark — Frontend Builder
- Boss = [Your name]
- Project = [Your project]

## Current Work
[Empty — ready for first session]

## Lessons Learned
[Empty — will grow over time]
```

---

## Setting Up Agent #4: Ops/Research

The fourth agent depends on your biggest pain point:

| Pain Point | Agent Role | Focus |
|-----------|-----------|-------|
| Documentation is always outdated | **Ops** | Docs, deployment, config |
| You need answers before building | **Researcher** | Technical research, competitive analysis |
| Design is inconsistent | **Designer** | UI consistency, design system |
| Deployment is manual/scary | **DevOps** | CI/CD, infrastructure, monitoring |

For most small teams, **Ops** is the best fourth agent. It handles the work nobody else wants to do — keeping docs updated, managing deployment, maintaining the project's operational health.

---

## The 4-Agent Workflow

Here's how a typical feature flows through a 4-agent team:

```
You: "Add user authentication"
     |
     v
Backend Builder: Builds auth API, database tables, JWT logic
     |
     v
Frontend Builder: Builds login/signup pages, auth state management
     |
     v
QA: Tests the full flow — API + frontend + edge cases
     |
     v
Ops: Updates docs, deployment config, environment variables
     |
     v
You: Manual test of the visual flow → Ship
```

Each agent does their part, hands off to the next, and moves on to new work. You only get involved for the final visual check.

---

## Coordination at 4 Agents

With 4 agents, you need slightly more structure:

### Daily Status Updates
Each agent writes a status at the end of every session (see Module 3). At the start of your day, you read 4 short updates and know exactly where everything stands.

### Shared Source of Truth
Your SOURCE-OF-TRUTH.md becomes critical. It tracks:
- What each agent is working on
- What's blocked and why
- What's ready for the next agent
- Overall project status

### The "Who Handles What" Matrix

Post this in your shared memory:

```markdown
## Task Routing
| Task Type | Primary | Backup |
|-----------|---------|--------|
| API endpoints | Backend | — |
| UI components | Frontend | — |
| Database changes | Backend | — |
| Testing | QA | — |
| Documentation | Ops | Frontend |
| Deployment | Ops | Backend |
| Bug fixes | Whoever owns the file | — |
| New features | Backend + Frontend | — |
```

No ambiguity about who handles what.

---

## Common Mistakes at 4 Agents

### Mistake 1: Over-Coordinating
Don't micromanage. If your Backend Builder is working on the API and your Frontend Builder is working on the UI, they don't need to talk to each other constantly. They both know the API contract. Let them work independently.

### Mistake 2: Unbalanced Workload
If your Frontend Builder finishes in 20 minutes and your Backend Builder takes 2 hours, the frontend agent is sitting idle. Either:
- Give Frontend more scope (documentation, testing help)
- Merge Frontend and Backend back into one agent
- Assign Frontend to work on the next feature ahead

### Mistake 3: Skipping QA
With more agents building faster, it's tempting to skip QA to "move faster." Don't. QA exists because it catches the bugs that builders miss. The faster you build, the MORE you need QA.

---

## Key Takeaway

Going from 2 to 4 agents is about specialization. Split the Builder into Frontend and Backend. Add Ops or Research as your fourth. Use the same patterns from Module 1-3 — identity, memory, rules, communication — just with more participants.

Scale when you feel the bottleneck, not before.

---

*Next: Lesson 2 — Team Leads and Sub-Teams*
