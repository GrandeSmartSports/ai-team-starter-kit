# Module 3, Lesson 2: Security Essentials

## Why Security Matters with AI Agents

Your AI agents have access to your codebase, your terminal, and potentially your entire file system. That's powerful — and it requires basic security hygiene.

This isn't about paranoia. It's about preventing the three things that actually go wrong:

1. **Secrets in code** — API keys, passwords, tokens committed to git
2. **Agents stepping on each other** — one agent overwrites another's work
3. **Scope creep** — agents doing things outside their domain

Let's fix all three.

---

## Problem 1: Secrets in Code

The most common security mistake with AI agents: they put API keys directly in source code.

```javascript
// BAD — agent wrote the key right into the code
const API_KEY = "sk-abc123realkey456";
```

This happens because the agent is trying to be helpful. You told it to "connect to the API" and it did — by hardcoding the key.

### The Fix: Environment Variables

Add this to your global rules:

```markdown
## Secret Management
- NEVER hardcode API keys, passwords, or tokens in source code
- Use environment variables: process.env.API_KEY
- Use .env files for local development
- .env files MUST be in .gitignore
- If you accidentally commit a secret, alert the owner IMMEDIATELY
```

Then teach the pattern:

```javascript
// GOOD — agent uses environment variable
const API_KEY = process.env.API_KEY;
if (!API_KEY) {
  throw new Error("API_KEY environment variable is required");
}
```

### The .gitignore Rule

Every project should have a `.gitignore` that includes:

```
.env
.env.local
.env.production
*.key
*.pem
credentials.json
```

Add a rule: "Before first commit, verify .gitignore includes .env files."

---

## Problem 2: Agents Stepping on Each Other

With multiple agents, file conflicts are inevitable. Two agents edit the same file at the same time. One agent's changes overwrite the other's.

### The Fix: Ownership Boundaries

Every agent owns specific directories and files:

```markdown
# Builder's Ownership
## What I Own
- All files in src/ directory
- All files in api/ directory
- package.json
- Database migrations

## What I Don't Touch
- tests/ directory (QA's domain)
- docs/ directory (Ops' domain)
- design/ directory (Designer's domain)
- .claude.md (Owner only)
```

When an agent sees a problem outside its domain, it doesn't fix it. It reports it:

```markdown
## Cross-Domain Issues
If you find a bug in code you don't own:
1. Do NOT fix it yourself
2. Drop a note describing the issue
3. Tag which agent should handle it
4. Continue with your own work
```

This sounds rigid, but it prevents the chaos of agents overwriting each other's work. In practice, 90% of work stays within ownership boundaries.

### The 10% Exception

Sometimes an agent genuinely needs to edit a shared file (like package.json). For these cases:

```markdown
## Shared Files
These files may be edited by multiple agents:
- package.json — coordinate with others before editing
- .env.example — any agent can add their needed variables
- README.md — any agent can update their section

For shared files: check git status first. If another agent has
uncommitted changes, wait or coordinate.
```

---

## Problem 3: Scope Creep

Your Builder agent is fixing an API endpoint and notices the CSS on the login page is broken. Being helpful, it fixes the CSS too.

Sounds fine. But:
- The CSS fix might conflict with the Designer's current work
- The Builder might not know the design standards
- The "fix" might break something else
- Now there are unreviewed CSS changes mixed into an API commit

### The Fix: Stay In Lane Rules

```markdown
## Scope Rules
- Only work on tasks you've been assigned
- If you notice issues outside your domain, report them — don't fix them
- If a task requires cross-domain work, flag it for the owner to coordinate
- When in doubt about scope, ask before acting
```

Combine this with the identity anchor from Module 1. An agent that knows "I am the Builder — I own API code" is much less likely to drift into CSS fixes.

---

## The Audit Trail

For accountability, every agent should leave a trail:

```markdown
## Audit Trail Rules
- Commit after every completed feature (not at end of session)
- Commit messages should explain WHAT and WHY
- Log major decisions in your memory file
- When you make a judgment call, note it in session notes
```

This isn't bureaucracy. It's how you catch problems early and understand what happened when something goes wrong.

Good commit discipline:
```
git commit -m "Add email validation to subscribe endpoint

Prevents invalid emails and duplicates. Chose regex validation
over library to avoid new dependency."
```

Bad commit discipline:
```
git commit -m "updates"
```

---

## The Paid API Rule

This deserves its own section because it's caught many people off guard.

AI agents can make API calls. Some API calls cost money. Without a rule, an agent might:
- Call GPT-4 in a loop for data processing ($50 in 10 minutes)
- Hit a paid geocoding API for every address in a database
- Generate images via DALL-E for every product ($0.04 each × 10,000 products = $400)

```markdown
## Paid API Rule (PERMANENT)
NEVER make external paid API calls without owner approval.
This includes:
- AI model APIs (OpenAI, Anthropic, etc.)
- Paid data services (maps, weather, etc.)
- Any service that charges per request

Before implementing any feature that calls a paid API:
1. Tell the owner which API and estimated cost
2. Wait for explicit approval
3. Implement with cost monitoring
```

---

## Quick Security Checklist

Before your first real build session, verify:

- [ ] `.gitignore` includes `.env` and credential files
- [ ] No hardcoded secrets in any source file
- [ ] Each agent has clear ownership boundaries
- [ ] Shared files are documented
- [ ] "Ask Before" list is in each agent's rules
- [ ] Paid API rule is in global rules
- [ ] Commit discipline is established

---

## Key Takeaway

Security with AI agents is mostly about prevention. Secrets stay in .env files. Agents stay in their lanes. Costly actions require approval. It's not about locking things down — it's about setting up guardrails so you can trust your agents to work autonomously.

Set the rules once. Then stop worrying about it.

---

*Next: Lesson 3 — Communication Between Agents*
