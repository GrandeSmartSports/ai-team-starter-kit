# Module 4, Lesson 3: Maintaining Quality at Scale

## The Speed vs. Quality Trap

More agents = more output. More output = more bugs, more inconsistency, more things to review.

At 2 agents, quality is easy. You see everything. At 6+, you can't review every line of code, every design decision, every commit. You need systems.

This lesson covers the patterns that keep quality high as your team grows.

---

## Pattern 1: The QA Gate

Nothing ships without QA. Period.

```
Builder finishes feature
     |
     v
Builder hands off to QA (with test instructions)
     |
     v
QA tests everything
     |
     v
QA PASSES → Ship
QA FAILS → Back to Builder with specific bugs
     |
     v
Builder fixes
     |
     v
QA re-tests ONLY the fixes
     |
     v
QA PASSES → Ship
```

**The rule: No feature goes live without a QA pass.**

This sounds obvious, but under pressure, teams skip QA "just this once." That one time is when the bug hits production.

### QA Report Format

Standardize how QA reports:

```markdown
# QA Report — [Feature Name]

**Date:** March 30, 2026
**Build:** commit abc123
**Tested by:** QA Agent

## Overall: PASS / FAIL / PASS WITH NOTES

## Tests Run
- [PASS] Test description
- [PASS] Test description
- [FAIL] Test description — details below

## Bugs Found
### BUG-1: [Title]
- **Severity:** Critical / High / Medium / Low
- **Steps to reproduce:** ...
- **Expected:** ...
- **Actual:** ...
- **Screenshot/log:** (if applicable)

## Recommendation
Ship / Fix first / Needs discussion
```

Every feature gets this. It takes QA 5 minutes to write and saves hours of debugging later.

---

## Pattern 2: Code Standards

When multiple agents write code, consistency matters. Without standards, you get:
- Different naming conventions in different files
- Mixed indentation (tabs vs spaces, 2 vs 4)
- Inconsistent error handling
- Different patterns for the same thing

### The Standards File

Create a standards file that all agents reference:

```markdown
# Code Standards

## Naming
- Variables/functions: camelCase
- CSS classes: kebab-case
- Database columns: snake_case
- Constants: UPPER_SNAKE_CASE
- Files: kebab-case.js

## Formatting
- 2 spaces for indentation
- Single quotes for strings
- Semicolons required
- Max line length: 100 characters

## Patterns
- Error handling: try/catch with specific error types
- API responses: { success: boolean, data: any, error: string }
- Database queries: always use parameterized queries
- Environment vars: always check for existence at startup

## Don'ts
- No console.log in production code (use proper logger)
- No hardcoded URLs (use environment variables)
- No magic numbers (use named constants)
- No commented-out code (delete it, git remembers)
```

Put this in `docs/code-standards.md` and reference it in each agent's rules:

```markdown
## Code Quality
Follow the standards in docs/code-standards.md for all code changes.
```

---

## Pattern 3: The Review Checklist

Before marking any feature as "done," agents run through a checklist:

```markdown
## Before Marking Complete

- [ ] Code follows project standards
- [ ] No hardcoded secrets or credentials
- [ ] Error cases are handled
- [ ] Edge cases are considered
- [ ] Changes are committed with descriptive message
- [ ] No unnecessary files are included
- [ ] Feature works as specified
- [ ] No regressions in existing functionality
```

This is your last line of defense before QA even sees it. It catches the lazy mistakes.

---

## Pattern 4: Regression Testing

The most painful bug: something that USED to work stops working because of a new change.

### The Regression Checklist

After every significant change, QA tests not just the new feature but the core existing features:

```markdown
## Regression Tests (Run After Every Major Change)

### Core Functionality
- [ ] App starts without errors
- [ ] Login/logout works
- [ ] Main navigation works
- [ ] Data saves correctly
- [ ] Data loads correctly

### Recent Features
- [ ] [Last feature] still works
- [ ] [Feature before that] still works

### Known Trouble Spots
- [ ] Timezone handling (Known Issue #1)
- [ ] CORS on new endpoints (Known Issue #2)
```

This list grows over time. Each new "Known Issue" from your memory files becomes a regression test item.

---

## Pattern 5: The Weekly Review

Once a week, do a 30-minute quality review:

### What to Check

1. **Memory Files** — Are they accurate? Too bloated? Missing important lessons?

2. **Source of Truth** — Does it reflect reality? Any outdated information?

3. **Agent Performance** — Any agents consistently producing bugs? Need better rules or training?

4. **Code Quality** — Quick scan of recent commits. Any patterns of sloppiness?

5. **Blockers** — Anything that's been stuck for more than 2 sessions?

### What to Update

- Archive completed work from memory files
- Add new lessons learned
- Update code standards if new patterns emerged
- Adjust agent rules if you see recurring issues
- Remove or reassign stuck tasks

---

## Pattern 6: The Definition of Done

Every team needs a shared definition of "done." Without it, "done" means different things to different agents.

```markdown
## Definition of Done

A feature is DONE when:

1. Code is written and committed
2. Code follows project standards
3. QA has tested and passed
4. Documentation is updated (if applicable)
5. No known bugs above LOW severity
6. Status update is posted
7. Memory file is updated

A feature is NOT done if:
- "It works on my machine" (must be testable by others)
- "Just needs a few tweaks" (tweaks are work — do them first)
- "QA will catch anything I missed" (QA validates, they don't replace your own testing)
```

---

## The Quality Compound Effect

Here's what happens over time when you maintain quality systems:

**Month 1:** You're setting up systems, writing standards, building checklists. It feels slow.

**Month 2:** Agents are following standards. QA catches bugs earlier. You spend less time reviewing.

**Month 3:** Lessons Learned are preventing old bugs. Code is consistent across agents. Regressions are caught immediately.

**Month 6:** Your agents produce better code than most human teams. They never forget the standards. They never skip the checklist. They never miss a regression test. And they get better every session.

**This is the compounding effect.** Every standard, every checklist, every lesson learned makes the next session better. Human teams forget. AI teams with good systems don't.

---

## Scaling Quality Checklist

Before going from 4 to 6+ agents:

- [ ] QA gate is enforced (no shipping without QA)
- [ ] Code standards document exists
- [ ] Review checklist is in every Builder's rules
- [ ] Regression test list exists and is maintained
- [ ] Weekly review is scheduled
- [ ] Definition of Done is shared
- [ ] Team Leads are managing (not building)
- [ ] Memory files are current and clean

If you can check all of these, you're ready to scale.

---

## Key Takeaway

Quality at scale comes from systems, not willpower. QA gates, code standards, checklists, regression tests, weekly reviews, and a shared definition of "done." Set these up once, maintain them weekly, and your AI team will produce consistent, high-quality work no matter how many agents you add.

---

*End of Module 4. You now have the complete playbook — from your first agent to a scaled AI team. The starter kit gives you the tools. The course gives you the knowledge. Now go build.*
