# Module 3, Lesson 3: Communication Between Agents

## The Coordination Problem

You have a Builder and a QA agent. Builder finishes a feature. How does QA know?

Option A: You tell QA manually. (Works, but you're the bottleneck.)
Option B: Builder tells QA directly through a shared system. (Better.)

As your team grows past 2 agents, communication becomes the difference between a team that works and a team that's chaos.

---

## The Inbox/Outbox Pattern

The simplest cross-agent communication system: folders on disk.

```
your-project/
├── inbox/
│   ├── builder/      ← Messages FOR the builder
│   ├── qa/           ← Messages FOR QA
│   └── designer/     ← Messages FOR the designer
├── outbox/
│   ├── builder/      ← Messages FROM the builder
│   ├── qa/           ← Messages FROM QA
│   └── designer/     ← Messages FROM the designer
```

**How it works:**

1. Builder finishes a feature
2. Builder writes a file to `outbox/builder/qa-feature-ready.md`
3. QA checks `inbox/qa/` at session start and between tasks
4. QA reads the message and knows what to test
5. QA writes results to `outbox/qa/builder-test-results.md`
6. Builder checks `inbox/builder/` and sees the results

It's email. With files. And it works beautifully.

---

## Message Format

Keep messages structured so agents can parse them quickly:

```markdown
# Message: Feature Ready for QA

**From:** Builder
**To:** QA
**Date:** March 30, 2026
**Priority:** Normal

## What's Ready
Email subscription API — POST /subscribe and GET /subscribers

## Files Changed
- api/subscribe.js (new)
- api/subscribers.js (new)
- data/emails.json (new)
- landing-page.html (new)

## What to Test
1. Submit valid email → should return 200
2. Submit invalid email → should return 400
3. Submit duplicate email → should reject
4. GET /subscribers → should return array
5. Landing page form validation

## Notes
Used JSON file storage for now. Database migration planned for v2.
```

This takes the Builder 2 minutes to write and saves QA 20 minutes of figuring out what to test.

---

## The Routing Problem

With 2 agents, routing is obvious. With 4+, you need a system.

### Option 1: Direct Routing (2-4 Agents)

Agents know who to send messages to:

```markdown
## Communication Rules
- Build questions → ask Owner
- Feature ready for testing → send to QA
- Bug found in code → send to Builder
- Design needed → send to Designer
- Deployment needed → send to Ops
```

Simple. Every agent knows the routing table.

### Option 2: Team Lead Routing (5+ Agents)

With larger teams, a Team Lead agent handles routing:

```markdown
## Communication Rules
- All messages go through Team Lead
- Team Lead routes to the right person
- Direct messages only for urgent items
- Team Lead maintains the daily status
```

The Team Lead acts as a router — they know who's working on what and can direct messages efficiently.

### Option 3: Topic-Based Channels (8+ Agents)

For very large teams, organize by topic:

```
inbox/
├── api/          ← All API-related messages
├── frontend/     ← All frontend messages
├── bugs/         ← Bug reports from any agent
├── decisions/    ← Decisions that need owner input
└── status/       ← Status updates
```

Agents subscribe to the channels relevant to their work.

---

## The Status Update Pattern

At the end of every session, each agent drops a status update:

```markdown
# Status Update — Builder — March 30

## Completed
- Email subscription POST endpoint
- Email subscription GET endpoint
- Landing page with form

## In Progress
- Rate limiting (started, 50% done)

## Blocked
- Nothing

## Needs From Others
- QA: Test the subscription endpoints
- Designer: Landing page needs better mobile layout

## Next Session
- Finish rate limiting
- Start user authentication if QA signs off on subscriptions
```

When agents start their next session, they read everyone's status updates. Instant coordination without a meeting.

---

## Notification Signals

Files are great for async communication. But what about urgent items?

Use system notifications for things that need immediate attention:

```bash
#!/bin/bash
# signal-owner.sh — Send macOS notification

MESSAGE=$1
SOUND=$2  # "Ping" "Basso" "Sosumi" "Glass"

osascript -e "display notification \"$MESSAGE\" \
  with title \"AI Team Alert\" \
  sound name \"$SOUND\""
```

Usage in agent rules:

```markdown
## When to Signal Owner
- BLOCKED and can't continue → signal immediately
- Bug found in production → signal immediately
- Paid API call needed → signal and wait for approval
- Build complete → signal (non-urgent)

Use: scripts/signal-owner.sh "message" "sound"
```

On Linux, use `notify-send` instead of `osascript`.

---

## Anti-Patterns to Avoid

### Don't: Pass messages through code comments

```javascript
// TODO: @QA — test this endpoint
// TODO: @Builder — this function is slow, please optimize
```

Code comments get lost. Use the inbox system.

### Don't: Let agents talk in real-time

AI agents can't actually communicate in real-time. They work in sessions. Design your communication for async — messages that wait patiently until the recipient reads them.

### Don't: Create message overload

If agents send 15 messages per session, nobody reads them. Keep it to:
- 1 status update per session
- Direct messages only when action is needed
- Urgent signals only when truly urgent

---

## The Handoff Protocol

The most important communication pattern: the handoff.

When one agent finishes work that another agent needs:

```markdown
## Handoff Protocol

1. Committer commits all changes with descriptive message
2. Committer writes handoff note to recipient's inbox:
   - What was done
   - What files changed
   - What to do next
   - Any known issues or edge cases
3. Committer signals recipient (if urgent)
4. Committer marks task complete in their own status
5. Recipient reads handoff at next session start
6. Recipient acknowledges by starting work
```

A clean handoff prevents the "what did they do and where did they leave off?" problem that kills productivity in teams.

---

## Key Takeaway

Agent communication is just files in folders. Inbox/outbox for direct messages. Status updates for team awareness. Notification signals for urgent items. Handoff protocol for work transitions.

Keep it simple. Files on disk beat any complex messaging system because every agent can read files.

---

*End of Module 3. Next up: Module 4 — Scaling Your AI Team*
