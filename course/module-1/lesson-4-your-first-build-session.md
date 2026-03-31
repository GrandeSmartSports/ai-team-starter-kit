# Lesson 4: Your First Real Build Session

## The Workflow Loop

Every build session follows the same pattern. Memorize this — it's the backbone of everything:

```
YOU FILE ISSUES
     |
     v
Agent: "Filed. Next issue?"
     |
     v
Collect all issues
     |
     v
Agent creates build summary
     |
     v
Agent asks clarifying questions (ONE at a time)
     |
     v
You approve
     |
     v
Agent: "Going dark to build."
     |
     v
Agent builds + commits often
     |
     v
Blocked? Agent keeps working on other stuff
     |
     v
Agent does full QA
     |
     v
Agent reports back (2-3 sentences)
     |
     v
YOU test only the manual/final stuff
     |
     v
DONE
```

Let's walk through each step with your two-agent team.

---

## Step 1: File Issues

Talk to your Builder agent:

```
I need three things built:

1. A landing page with an email signup form
2. A /api/subscribe endpoint that saves emails to a JSON file
3. A /api/subscribers endpoint that returns all emails
```

Your agent responds: **"Filed. Anything else?"**

```
That's it for now.
```

---

## Step 2: Build Summary

Your Builder creates a summary:

```
ISSUES TO BUILD:
1. Landing page with email signup — SMALL complexity
2. POST /api/subscribe endpoint — SMALL complexity
3. GET /api/subscribers endpoint — SMALL complexity

ORDER: #2 → #3 → #1 (API first, then frontend)

Ready to build or do you have questions first?
```

Notice: **No time estimates.** Time estimates from AI are always wrong. Complexity indicators (small/medium/large) are honest.

---

## Step 3: Clarifying Questions

The agent might ask:

```
Question: What tech stack for the frontend?

Options:
A) Plain HTML/CSS (simplest)
B) React (more setup, more flexibility)
C) Next.js (full framework)
D) Something else

My recommendation: A — plain HTML/CSS. We're prototyping, not building for scale yet.
```

**One question at a time.** Not five. Not ten. One. You answer, they ask the next one.

This is important: agents that dump 10 questions on you are wasting your time. Train them (via the workflow protocol) to ask one at a time with a recommendation.

---

## Step 4: "Going Dark to Build"

Once all questions are answered:

```
Agent: "All clear. Going dark to build."
```

This means: **Leave me alone. I'm working.** The agent will:
- Build each feature
- Commit after each one
- Handle errors and edge cases
- Do its own QA

You don't need to watch. Go do something else. Come back when it reports.

---

## Step 5: The Report

When the agent finishes, you get a concise report:

```
All 3 items complete.

Built: Email subscription API (POST /subscribe, GET /subscribers)
and landing page with signup form. 3 commits, all builds passing.

Ready for you to test:
- Open the landing page and submit an email
- Verify the email appears at /api/subscribers
- Check the form validation (empty/invalid email)
```

**2-3 sentences.** Not an essay. Not a code dump. Just: what was built, and what you need to verify manually.

---

## Step 6: Bring In QA

Now switch to your QA agent's terminal:

```
Builder just completed an email subscription system.

Files:
- landing-page.html (frontend)
- api/subscribe.js (POST endpoint)
- api/subscribers.js (GET endpoint)
- data/emails.json (storage)

Please run a full QA pass:
1. Does the API return correct responses?
2. Does the landing page form work?
3. What happens with invalid input?
4. What happens with duplicate emails?
5. File your report in outbox/keeper/
```

Your QA agent runs all the tests and drops a report:

```
QA REPORT — Email Subscription System
Date: March 30, 2026
Build: commit abc123

OVERALL: PASS (with 1 minor issue)

Tests Run:
- [PASS] POST /subscribe with valid email — returns 200
- [PASS] GET /subscribers — returns array of emails
- [PASS] Landing page form submits correctly
- [PASS] Empty email — returns 400 with error
- [FAIL] Duplicate email — currently saves duplicates

Bugs Found:
- BUG-1: Duplicate emails accepted — Severity: LOW
  Submit the same email twice → both saved
  Expected: Reject duplicate with message
  Actual: Silently saves duplicate

Recommendation: Ship with BUG-1 noted. Fix in next iteration.
```

---

## Step 7: Fix and Ship

Back to your Builder:

```
QA found one issue — duplicate emails are being saved.
Add a duplicate check to the subscribe endpoint.
```

Builder fixes it, commits, tells QA. QA re-tests. Signs off. Done.

---

## The Three Commands You'll Use Most

### "Polish"
**When to use:** You don't have specific tasks right now.
**What happens:** The agent finds improvements on its own — cleans up code, fixes small bugs, updates documentation.

```
You: "No new issues. Polish."
Agent: [Finds and fixes things proactively]
```

### "Discuss"
**When to use:** You have an idea but need to think it through.
**What happens:** The agent asks planning questions before building.

```
You: "I'm thinking about adding user authentication. Discuss."
Agent: "What type of auth? Options: A) Email/password B) OAuth..."
```

### "Build and test"
**When to use:** You want the full loop — build it AND QA it.
**What happens:** The agent implements, tests everything, fixes bugs, THEN reports.

```
You: "Add a delete endpoint for subscribers. Build and test."
Agent: [Builds, tests, fixes, then reports when fully done]
```

---

## What Your Memory Files Look Like After a Session

After this build session, your Builder's memory file automatically gets updated:

```markdown
# Bolt Memory

## Identity
- I am Bolt — Builder
- Boss = Daniel
- Project = TaskFlow

## Current Work
### Email Subscription System
- Location: api/ and landing-page.html
- Status: Complete, QA passed
- Commits: abc123, def456, ghi789
- Key files: api/subscribe.js, api/subscribers.js, data/emails.json
- BUG-1 fixed: duplicate email check added

## Lessons Learned
- Always add duplicate checks on insert endpoints
- QA caught what I missed — the system works
```

**Tomorrow, when you start a new session, Bolt reads this file and remembers everything.** No re-explaining. No lost context. Just: "I see where we left off. What's next?"

---

## Key Takeaways

1. **The workflow loop is everything.** Issues → Summary → Questions → Build → QA → Report. Repeat forever.
2. **One question at a time.** Never let an agent dump 10 questions on you.
3. **Agents do QA, not you.** You only test the manual/visual stuff.
4. **"Going dark to build"** means leave them alone. Come back for the report.
5. **Memory updates are automatic.** Tomorrow picks up where today left off.

---

## What's Next

You now have a working two-agent team. Module 2 goes deep on the memory system — how to structure memory files, what to track, and how to make your agents genuinely smarter over time.

Module 3 covers agent rules and security — because as your team grows, boundaries become critical.

Module 4 teaches team scaling — going from 2 agents to 4, then 6, then 8+.

You've got the foundation. Now let's build on it.

---

*End of Module 1. See you in Module 2.*
