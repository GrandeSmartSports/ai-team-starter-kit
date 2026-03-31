# Module 5, Lesson 2: Advanced Workflow Patterns

## Patterns That Emerge After Weeks of Use

The basic workflow (Issues → Build → QA → Ship) works from day one. But after a few weeks, you develop shortcuts and patterns that make everything faster. Here are the ones that stuck.

---

## The "Polish" Command

When you don't have specific tasks, tell your agent:

> "No new issues. Polish."

The agent proactively:
- Cleans up code style
- Fixes small bugs it noticed earlier
- Updates documentation
- Improves error messages
- Refactors messy code

This is surprisingly valuable. Agents notice things during builds that they don't fix because they're focused on the task. "Polish" gives them permission to clean up.

**How to implement:**

Add to your workflow protocol:

```markdown
## Special Commands

### "Polish"
When the owner says "Polish" with no other tasks:
1. Review recent code for improvements
2. Fix any small bugs or inconsistencies
3. Update outdated documentation
4. Clean up code style
5. Report what you improved
```

---

## The "Discuss" Mode

Before committing to a big feature, use discuss mode:

> "I'm thinking about adding user auth. Discuss."

The agent doesn't build — it asks planning questions:
- What type of auth? (email/password, OAuth, magic link)
- What pages need protection?
- Do we need user roles?
- What about password reset?
- How does this affect existing features?

One question at a time. Each with a recommendation.

This prevents the expensive mistake of building the wrong thing. 15 minutes of discussion saves hours of rebuilding.

---

## The Sprint Protocol

For bigger projects, use a sprint structure:

```markdown
## Sprint Protocol

### Sprint Start (You — 5 min)
1. Read each agent's status from last session
2. Set 3-5 priorities for this sprint
3. Send priorities to Team Lead(s)

### Sprint Work (Agents — the whole session)
4. Team Lead breaks priorities into tasks
5. Tasks get assigned to agents
6. Agents work, commit, hand off
7. QA tests everything

### Sprint End (Agents — 5 min)
8. Each agent writes status update
9. Team Lead writes sprint summary
10. Memory files get updated

### Sprint Review (You — 10 min)
11. Read the sprint summary
12. Test anything that needs manual verification
13. Set next sprint priorities
```

This gives structure to long build sessions without micromanaging.

---

## The "Build and Test" Shortcut

For straightforward features, skip the back-and-forth:

> "Add a delete endpoint for subscribers. Build and test."

The agent:
1. Builds the feature
2. Tests it themselves (happy path + edge cases)
3. Fixes any bugs they find
4. THEN reports back with results

You only get involved after it's fully working. This is the most efficient pattern for clear, well-defined tasks.

---

## The Parallel Build Pattern

With 2+ builders, you can parallelize:

```
You: "Two tasks. Builder A: add the API endpoint.
      Builder B: build the frontend component.
      Meet in the middle at the API contract."

Builder A → works on /api/endpoint
Builder B → works on frontend component
                    (uses mock data while API isn't ready)

Builder A finishes → QA tests API
Builder B finishes → connects to real API → QA tests integration
```

The key: agree on the API contract (request/response format) upfront. Then both builders can work independently.

---

## The Emergency Rollback Pattern

When something breaks in production:

```markdown
## Emergency Protocol
1. STOP all current work
2. Signal owner immediately
3. Identify the breaking change (check git log)
4. Revert the commit: git revert [commit]
5. Verify the revert fixes the issue
6. Then investigate root cause
7. Fix properly and re-deploy
```

Revert first, investigate second. Don't debug in production.

---

## The Context Dump Pattern

Starting a new session with a lot of context? Do a context dump:

> "Before we start building, let me dump some context. Don't act on any of this yet — just absorb it."

Then paste:
- Recent decisions
- User feedback
- Design requirements
- Technical constraints
- Business context

End with: "Got all that? Now let's talk about what to build."

This is faster than drip-feeding context through back-and-forth. The agent has the full picture before starting.

---

## The Hot Potato Pattern

For cross-cutting work that touches multiple domains:

```
You: "This feature needs API + frontend + QA.
     Builder A starts with the API.
     When done, hot potato to Builder B for frontend.
     When done, hot potato to QA for testing."

Builder A: builds API → drops handoff in Builder B's inbox
Builder B: reads handoff → builds frontend → drops handoff in QA's inbox
QA: reads handoff → tests everything → reports to you
```

Work flows through agents like a relay race. Each agent picks it up, does their part, hands it off.

---

## Key Takeaway

Advanced workflows aren't complex — they're shortcuts that emerge from real use. Polish mode, discuss mode, build-and-test, parallel builds, hot potato handoffs. Each one saves time by matching the right pattern to the right situation.

Use these when they fit. Don't force them. The basic workflow loop covers 80% of work. These patterns cover the other 20%.

---

*Next: Lesson 3 — Automation and Scripting*
