# Module 3, Lesson 1: Why Rules Matter

## The "Oh No" Moment

It happens to everyone. Your agent is humming along, building great stuff, and then:

- It runs `rm -rf` on a directory without asking
- It pushes untested code to production
- It makes a paid API call that costs you $40
- It overwrites a file you were in the middle of editing
- It sends a message to a client with the wrong tone

No malice. No bugs. The agent just didn't know where the boundaries were.

**Rules aren't about limiting your agents. They're about making them safe to trust.**

---

## Two Types of Rules

### 1. Hard Limits (Never Cross These)

Hard limits are rules that should never be broken, regardless of context:

```markdown
## Hard Limits — Never Cross These

1. NEVER delete files without owner approval
2. NEVER run sudo commands
3. NEVER push to production without QA sign-off
4. NEVER make paid API calls without owner approval
5. NEVER modify another agent's files without coordination
6. NEVER store secrets in code files
7. NEVER skip git — all changes must be version controlled
8. NEVER force-push to shared branches
9. NEVER access personal accounts (email, banking, social)
10. NEVER make irreversible changes without confirmation
```

These go in an agent's Rules file. The agent reads them at session start and they stay in context.

### 2. Soft Guidelines (Prefer These, But Use Judgment)

Soft guidelines are preferences that can flex when needed:

```markdown
## Guidelines

- Prefer small, frequent commits over large batches
- Ask clarifying questions one at a time, not all at once
- When blocked, try 2 approaches before escalating
- Default to the simplest solution that works
- Write code comments only where logic isn't obvious
```

---

## The "Ask Before" Framework

The most practical rule pattern is the "Ask Before" list. It defines exactly what requires owner approval:

```markdown
## Always Ask Before:
- Deleting any files or folders
- Running destructive commands (rm, drop, reset)
- Pushing to production or live environments
- Making external API calls that cost money
- Changing authentication or security settings
- Modifying shared configuration files
- Installing new dependencies
- Making changes that affect other agents' work

## Can Do Freely:
- Create new files and folders
- Edit files within your ownership
- Run local development servers
- Run tests
- Read any project file
- Commit to your feature branch
- Update your own memory file
```

This is liberating, not limiting. When an agent knows exactly what it can do freely, it moves faster. It doesn't waste time asking permission for routine work.

---

## Rules Prevent Expensive Mistakes

Here's a real story. An AI agent was tasked with "clean up the data directory." Without rules, it interpreted this as "delete everything in the data directory and start fresh." It ran `rm -rf data/` — wiping out the entire database.

With a simple rule — "NEVER delete files without owner approval" — that catastrophe gets caught:

```
Agent: "I'd like to clean up the data directory. This would involve
deleting 47 files. Should I proceed, or would you like to review
the list first?"
```

**One rule. One sentence. Saved an entire database.**

---

## The Escalation Ladder

Not everything needs the owner. Build an escalation path:

```markdown
## Decision Authority

### Agent decides alone:
- Code style and formatting
- Variable and function names
- File organization within owned directories
- Test strategy
- Commit messages

### Agent decides but logs the decision:
- Architecture within a single feature
- Library choices for non-critical dependencies
- Error handling approach
- Performance optimization strategy

### Must ask owner:
- New external dependencies
- Database schema changes
- API contract changes
- Security-related decisions
- Anything that affects other agents' work
- Anything that costs money
```

This keeps the agent autonomous for 80% of decisions while protecting you on the 20% that matter.

---

## Where Rules Live

```
your-project/
├── .claude.md          ← Global rules (all agents)
├── agents/
│   ├── AGENT-RULES-builder.md   ← Builder-specific rules
│   ├── AGENT-RULES-qa.md        ← QA-specific rules
│   └── AGENT-RULES-designer.md  ← Designer-specific rules
```

- **Global rules** (in .claude.md) apply to every agent
- **Agent-specific rules** add role-based boundaries

Example: Your Builder agent might have "can freely install npm packages" while your QA agent has "NEVER install packages — only test existing code."

---

## Key Takeaway

Rules make agents trustworthy. Without rules, you're babysitting. With rules, you're delegating. The "Ask Before" framework + escalation ladder = agents that move fast but never break things.

Write your rules once. Your agents follow them every session, forever.

---

*Next: Lesson 2 — The Security Essentials*
