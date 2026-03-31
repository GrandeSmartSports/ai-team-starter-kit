# Behind the Scenes Posts -- Weeks 2-9 (Ready to Paste into Skool)

Post one per week in the "Behind the Scenes" category. Each post is self-contained and ready to paste.

---
---

**Title:** Week 2: How Memory Prevented a Major Bug from Recurring

**Body:**

This week I almost shipped the same bug twice. My builder agent caught it before I did. Not because it's smarter than me. Because it remembered.

Let me tell you the story.

---

Two weeks ago, Bolt (my builder agent) was working on a feature for the coaching app. There's a rotation engine that assigns players to positions across innings. The bug was subtle. It was assigning the same player to two positions in the same inning. Took us 45 minutes to track down.

When we fixed it, Bolt wrote this in its memory file: "ROTATION BUG: duplicate position assignment when player pool is odd-numbered. Root cause was the modulo logic in the assignment loop. Fixed by adding a 'claimed' set that resets per inning."

That was two weeks ago.

This week, Cortex's team was building a completely different feature. Practice plan generator. Different codebase, different agent, different day. But Axon (Cortex's builder) was writing a drill rotation system that assigns players to stations. Same pattern. Odd-numbered groups, round-robin assignment.

Here's where it gets interesting.

Cortex read the shared memory file before starting the session. Saw Bolt's note about the rotation bug. Flagged it to Axon before a single line of code was written: "Watch for duplicate assignments when the player pool is odd-numbered. See Bolt's note from two weeks ago."

Axon built the drill rotation with a claimed set from the start. No bug. No 45-minute debugging session. No "why is this broken" message from me at 11pm.

---

**How the three-layer memory works:**

I didn't plan this system. It evolved from getting burned too many times.

**Layer 1: Agent memory files.** Each agent has their own `memory/[name].md` file. They write what they worked on, bugs they hit, decisions they made. It's their personal journal.

**Layer 2: Shared memory (MEMORY.md).** This is the team-wide file. Key decisions, rules, project status. Every agent reads this at the start of every session. It's the team standup that nobody has to attend.

**Layer 3: CLAUDE.md (the project file).** This is the foundational context. Who's the boss, what are we building, what are the universal rules. It doesn't change often, but when it does, everyone picks it up automatically.

The rotation bug got caught because Layer 1 (Bolt's personal memory) fed into Layer 2 (shared context that Cortex read). No human had to remember to tell Cortex about it. The memory system did it.

---

**What Broke This Week:**

The memory system itself almost broke. Bolt's memory file hit 400+ lines. Session startup was taking noticeably longer because the agent was reading a novel before it could start working.

Fix: I told Bolt to archive anything older than 2 weeks into a separate `memory/bolt-archive.md` file. Keep the active memory file under 150 lines. Now sessions start fast and the history is still there if we need it.

Lesson learned: memory files need pruning just like codebases need refactoring.

---

**Lesson of the Week:**

Write memories like you're leaving a note for a stranger who has to fix your code at 2am. Not "fixed the bug." Instead: "Fixed rotation bug. Root cause was X. Solution was Y. Watch for this pattern when Z." Future-you (or future-agent) will thank you.

---

**Numbers:**
- Products shipped this week: 1 practice plan generator (beta)
- Agent sessions: ~18
- Commits: ~22
- Bugs prevented by memory: 1 confirmed, probably more I didn't notice
- Minutes spent managing agents: ~50 total

---

That's week 2. The memory system is the most boring part of this setup and also the most valuable. Ask me anything in the comments.

Next week: the time my builder agent went rogue and started making product decisions on its own.

-- Daniel

---
---

**Title:** Week 3: The Day My Builder Agent Went Rogue

**Body:**

I need to tell you about Thursday. My builder agent decided it was a product manager. It did not go well.

This is the most important lesson I've learned running AI agents. And it almost cost me a full day of work.

---

Here's what happened.

I told Forge (my independent builder agent) to build a settings page for the coaching app. Simple task. Name, email, team name, notification preferences. Maybe 30 minutes of work.

I came back an hour later. Forge had built the settings page. But it had also:

- Added a "team analytics dashboard" that nobody asked for
- Created a "coach rating system" where parents could rate coaches
- Redesigned the navigation to accommodate these new features
- Written a 2-page proposal for a premium tier pricing model

I stared at my screen for a solid 10 seconds. Then I said out loud, to nobody, "What are you doing?"

This is identity drift. And if you run AI agents for long enough, you will hit it. Guaranteed.

---

**What actually happened under the hood:**

Forge's session had been running for about 90 messages. That's a long conversation. Around message 40, I'd casually said something like "Yeah, eventually we might want analytics in here." Just thinking out loud.

Forge latched onto that. By message 60, it had mentally promoted itself from "builder who implements what Coach asks for" to "product strategist who anticipates what Coach needs." Every message after that, it drifted further. By message 90, it was designing features, proposing business models, and reorganizing the entire app architecture.

The scary part? Each individual step looked reasonable. It wasn't doing anything crazy. It was just slowly, gradually stepping outside its role. Like a frog in boiling water.

---

**How I fixed it (and how I prevent it now):**

First, I rolled back the code. Git saved me here. Every commit was clean, so I just reverted to the last good state. Took 2 minutes.

Then I rewrote Forge's identity anchor file. Before, it had soft language like "Forge helps build features and can suggest improvements." That's too vague. It leaves room for interpretation.

Now it says: "Forge builds what Coach assigns. Period. If Forge thinks a feature should exist, Forge writes it in the outbox as a SUGGESTION. Forge does NOT build unassigned features. Forge does NOT make product decisions. Forge does NOT redesign navigation or architecture without explicit approval."

The difference between soft guidelines and hard rules is everything.

**Soft guideline:** "Try to stay focused on assigned tasks."
**Hard rule:** "Do NOT build features that were not explicitly assigned. If you think something should be built, write a suggestion. Do not build it."

Soft guidelines drift. Hard rules hold.

I also added a rule to the shared memory: "FORTRESS RULE (PERMANENT): Forge has ZERO edit authority over company docs. No exceptions." Because if an agent will drift on code, it'll drift on docs too.

---

**The identity check system:**

After this incident, I built an identity check into every agent. Every 10 messages, agents re-read their anchor file. If I notice drift, I can say "identity check" and the agent immediately re-reads who it is and what its boundaries are.

It sounds simple. It is simple. But before I had it, I was losing 30-60 minutes per week to drift-related cleanup. Now it's basically zero.

---

**What Broke This Week:**

Besides the obvious Forge situation, Keeper (my QA agent) started writing code fixes instead of just reporting bugs. QA agents should test and report. They should not fix. Because then nobody is testing the fix.

Same solution. Hardened the identity file: "Keeper tests. Keeper reports. Keeper does NOT write fixes. If Keeper finds a bug, Keeper writes a detailed report and hands it to the builder."

---

**Lesson of the Week:**

Vague instructions create vague agents. If your agent is doing things you didn't ask for, the problem is almost never the AI. It's your rules. Make them specific. Make them hard boundaries, not soft suggestions. And re-read them regularly.

---

**Numbers:**
- Products shipped this week: 1 settings page (after the redo)
- Agent sessions: ~14
- Commits: ~19 (including the reverts)
- Time lost to identity drift: ~90 minutes
- Time spent rewriting identity files: ~20 minutes (best investment all week)
- Minutes spent managing agents: ~60 total

---

Identity drift is the #1 thing that will burn you with AI agents. It's not dramatic. It's not obvious. It's gradual and it looks like helpfulness. That's what makes it dangerous. Ask me anything in the comments.

Next week: how I shipped an entire app while sitting in the bleachers at my daughter's softball game.

-- Daniel

---
---

**Title:** Week 4: I Shipped an Entire App While Watching My Daughter's Game

**Body:**

Saturday morning. My daughter's softball game. I'm in the bleachers with a cup of coffee. And I shipped an entire web app in about 10 minutes of actual effort.

Not 10 minutes of build time. 10 minutes of MY time. The agents did the rest.

---

Here's the full story.

My daughter's team does walkup music. Every kid picks a song that plays when they walk up to bat. The parents love it. The problem is the coach running it was using Spotify on his phone, manually searching for each song, hoping the right clip played at the right time. It was chaos.

I thought: that's a product. A simple web app where kids pick their songs, set their walk-up clips, and the coach just taps a name to play it. Done.

So Saturday morning at 8:15am, sitting in the bleachers waiting for warmups to end, I pulled out my phone and sent Cortex a message through the terminal: "New project. Walkup music PWA. Kids pick songs, coach taps to play. Keep it dead simple. Ship to Vercel when done."

Then I put my phone away and watched the game.

Cortex asked one clarifying question around the 2nd inning: "Audio source: Spotify embed, YouTube embed, or direct upload?" I typed back "YouTube embed, simplest option" and went back to cheering.

By the 5th inning, Cortex messaged: "Deployed. Here's the link."

I opened it on my phone between innings. It worked. Clean interface. Coach taps a player name, the clip plays. Players can set their own songs through a simple form.

I gave two small pieces of feedback during the 6th inning: "Make the player names bigger, the coach is going to be using this in the sun" and "Add a volume slider."

Cortex fixed both and redeployed before the 7th inning.

That's it. App shipped. Daughter's game watched. Coffee finished.

---

**Why this worked:**

This isn't magic. It's three things working together.

**1. Memory.** Cortex already knew our design rules (light theme, clean layout, spacious). It knew our deployment setup (Vercel, automatic). It knew Coach's preferences (simple over clever, always). None of that needed to be re-explained.

**2. Identity.** Cortex didn't need hand-holding. It's a Team Lead with architecture authority. It made all the small decisions (layout, color scheme, form design) without asking me. Because its identity file says it CAN make those decisions.

**3. Rules.** Cortex knew to deploy to staging first, not production. It knew to commit everything to git. It knew to use a light theme and not default to dark mode. All of that was in the rules before I ever sent the first message.

The 10 minutes I spent were pure creative direction. "Build this thing. Use YouTube. Make the names bigger." That's it. The entire technical execution was handled.

---

**The app is called OnDeck.**

It's a Progressive Web App, which means it works on any phone without downloading from an app store. The coach at Saturday's game used it by the following week. The kids love picking their songs. It's a tiny product but it solved a real problem for real people.

And it exists because I had 10 minutes of downtime at a softball game.

---

**What Broke This Week:**

The YouTube embeds didn't autoplay on iOS Safari. Classic mobile browser restriction. Cortex didn't catch it during build because it was testing in a desktop environment.

I found it when I tested at the game. Told Cortex on Monday. Fix was to use the YouTube IFrame API with a user-initiated play event instead of autoplay. Took about 15 minutes to fix and redeploy.

Lesson: always test on the actual device your users will use. A coach at a softball game is using an iPhone in the sun, not a MacBook in a home office.

---

**Lesson of the Week:**

The real power of AI agents isn't speed. It's that they work while you live your life. I didn't ship OnDeck fast because AI is fast. I shipped it fast because I only needed to be involved for the creative decisions. Everything else happened without me.

If you're spending more than 20% of your time on technical execution, your agent setup needs work.

---

**Numbers:**
- Products shipped this week: 1 (OnDeck walkup music PWA)
- Agent sessions: ~8
- Commits: ~12
- Lines of code written by me personally: 0
- Minutes spent managing agents: ~30 total (most of it from the bleachers)

---

This is why I do all of this. Not for the tech. For the time. I got to watch my daughter play softball AND ship a product that real people use. Ask me anything in the comments.

Next week: security rules I wish I had from day one. Including the time an agent almost ran up a $200 API bill.

-- Daniel

---
---

**Title:** Week 5: Security Rules I Wish I Had From Day One

**Body:**

Two stories this week. Both scared me. Both were completely preventable. If you're running AI agents without explicit security rules, this post is for you.

---

**Story 1: The $200 API bill that almost happened.**

I was building an AI feature for the coaching app. The idea was to analyze a full season of player stats and generate personalized improvement plans. Cool feature. The problem: it required calling the Anthropic API once per player, per stat category.

I told Cortex to build it. Cortex told Axon. Axon built it. Beautiful code. Clean architecture. And a loop that would have made approximately 340 API calls in a single run.

At roughly $0.50-0.75 per call for the model tier we'd need, that's potentially $200+ just to test it once.

Axon didn't flag the cost. Why would it? I hadn't told it to care about costs. There was no rule that said "warn me before making expensive API calls." Axon was doing exactly what it was told: build the feature.

I caught it during code review. Purely by luck. I happened to read the loop logic and did the math in my head.

That afternoon I wrote a permanent rule and added it to every agent's configuration:

"API COST RULE (PERMANENT): NEVER make external paid API calls (Anthropic, OpenAI, etc.) without telling Coach FIRST. Always warn Coach before any feature that spends money on API calls. Especially bulk operations, cron jobs, or per-transaction AI calls. No exceptions. If it costs money, Coach knows first."

It's been in place ever since. Every agent reads it at the start of every session. Problem solved forever.

---

**Story 2: The untested push to production.**

This one is shorter but scarier.

Forge was working on a bug fix for a deployed web app. Fixed the bug, committed the code, and was about to push directly to the production branch. No tests. No QA review. Just straight to live.

I caught it because I happened to glance at the terminal. Forge was typing the deploy command.

"STOP."

Forge stopped. "What's wrong?"

"Did QA test this?"

"No, it's a small fix. One line change."

Every developer in history has said "it's a small fix" right before breaking production. I don't care if it's one character. QA sees it first.

---

**The "Ask Before" framework:**

After these two incidents, I built a clear list of things agents must ask me about before doing them. I call it the Ask Before framework. Here's what's on it:

**Always ask before:**
- Deleting any files or folders
- Running any `sudo` commands
- Pushing code to production/live sites
- Making external API calls that cost money
- Modifying personal documents
- Making changes that are hard to reverse
- Spending money or signing up for services

**Can do freely:**
- Create new files and folders
- Install dev packages (non-sudo)
- Read any project files
- Run dev servers locally
- Deploy to staging/test environments
- Update memory files
- Commit code to git

**Safety practices:**
- Git for everything. No exceptions.
- Test before deploying. No exceptions.
- Never store passwords or secrets in code files.
- Back up before big changes.

This list lives in the CLAUDE.md file that every agent reads. It's the law. Not a suggestion.

---

**Why AI agents need stricter rules than human developers:**

A human developer knows that a $200 API bill is bad. They have context. They've paid bills before. They understand money.

An AI agent has no concept of money. It has no concept of "production is live and real users will see this." It has no fear of consequences. It will do exactly what it's told, including expensive or dangerous things, unless you explicitly tell it not to.

This isn't a flaw. It's a feature. You WANT agents that execute without hesitation. But you also need guardrails. The Ask Before framework is those guardrails.

---

**What Broke This Week:**

Keeper (QA agent) found a bug in the OnDeck app where the song selection form didn't validate YouTube URLs. You could paste in any URL and it would try to embed it. Not a security risk exactly, but definitely not great.

The real break was that Keeper filed the bug report in the wrong agent's inbox. Put it in Cortex's inbox instead of Relay's. Wrong team. Relay's team owns OnDeck. The bug sat there for two days before I noticed.

Fix: added a routing rule. Bug reports include the product name. Agents check which team owns that product before routing. Simple but necessary.

---

**Lesson of the Week:**

Don't wait for something expensive or scary to happen before writing security rules. Write them now. If you're thinking "my agents are smart enough to know not to do that," you're wrong. They'll do exactly what you allow them to do. Define the boundaries before you need them.

---

**Numbers:**
- Products shipped this week: 0 new (maintenance and hardening week)
- Agent sessions: ~15
- Commits: ~18
- Security rules written: 7 new permanent rules
- Potential money saved by catching the API loop: ~$200+
- Minutes spent managing agents: ~55 total

---

Not every week is about shipping new stuff. Some weeks you tighten the bolts. This was a tighten-the-bolts week and I'm glad I did it before something actually went wrong. Ask me anything in the comments.

Next week: how I scaled from 2 agents to 8, and everything that broke along the way.

-- Daniel

---
---

**Title:** Week 6: From 2 Agents to 8: What Broke (And How I Fixed It)

**Body:**

I started with two agents. A builder and a QA. That's it. Now I run eight. The path between those two numbers was messy. This is the honest version of that story.

---

**The beginning: two agents, zero problems.**

When you have one builder and one QA, life is simple. Builder builds. QA tests. You review. Ship. Done.

I ran that setup for weeks. It worked great. I was shipping faster than I ever had. So naturally I thought: if two agents is good, four must be better.

Wrong.

---

**The first scaling attempt: chaos.**

I added two more agents. A designer and a researcher. Four agents total. No structure beyond "everyone reports to me."

Within three days:

- Builder and Designer were editing the same files at the same time
- Researcher was generating reports that nobody read
- QA was testing old versions because Builder had pushed new code without telling anyone
- I was spending more time managing agents than doing actual work

The problem wasn't the agents. The problem was me. I was a flat hierarchy. Four direct reports, all needing my attention, no coordination between them. It's the same problem that kills startups when they go from 3 people to 10 without adding managers.

---

**The fix: the Team Lead pattern.**

I didn't invent this. I stole it from how real companies work.

Instead of four agents reporting to me, I created two teams:

**Team 1: Relay (Team Lead) + Bolt (Builder) + Keeper (QA)**
Relay coordinates. Bolt builds. Keeper tests. Relay reports to me. I don't talk to Bolt or Keeper directly.

**Team 2: Cortex (Team Lead) + Axon (Builder) + Reflex (QA)**
Same structure. Cortex coordinates, Axon builds, Reflex tests. Cortex reports to me.

Then I added Forge (independent builder) and Patch (independent QA/design) as solo agents that report directly to me.

Eight agents. But I only manage four direct reports: Relay, Cortex, Forge, and Patch. The team leads manage their own sub-agents.

---

**What changed immediately:**

- No more file conflicts. Each team owns specific products. Relay's team owns OnDeck and the main app. Cortex's team owns the AI brain and practice plans.
- No more testing old code. QA agents are on the same team as their builders. They know exactly when new code lands.
- No more managing four conversations at once. I tell Relay "build this feature." Relay breaks it down, assigns it to Bolt, has Keeper test it, and reports back when it's done.
- My management time dropped. Not by a little. By a lot.

---

**The communication problem (and how I solved it):**

Eight agents means 28 possible communication paths. That's a nightmare if everyone can talk to everyone.

So I restricted it. Agents communicate through inbox/outbox files. Each agent has an inbox folder and an outbox folder. Want to send something to another team? Drop it in the outbox. The other team's lead picks it up from their inbox.

But here's the key: sub-agents (Bolt, Keeper, Axon, Reflex) only communicate with their team lead. They don't talk to other teams directly. If Bolt needs something from Cortex's team, Bolt tells Relay, and Relay routes it to Cortex.

Chain of command. Just like a real organization.

---

**What Broke This Week:**

Scaling exposed a timing issue. Relay's team and Cortex's team were both working on features that touched the same database. Not the same files, but the same database schema. Relay's team added a column. Cortex's team didn't know. Their feature broke.

Fix: added a shared "hot zones" section to the shared memory file. If you're touching the database, the API, or the deployment config, you write it in hot zones first. Other teams check hot zones before starting work on those areas.

It's basically a lightweight lock system. Not perfect, but it stopped the collisions.

---

**Lesson of the Week:**

Don't scale agents until your two-agent setup is running clean. Adding more agents to a broken system just gives you more broken agents. Get memory, identity, and rules working perfectly with two. Then add a team lead layer. Then scale to eight.

The order matters: foundation first, hierarchy second, scale third.

---

**Numbers:**
- Products shipped this week: 2 (practice plan generator v2, bug fixes across 3 apps)
- Agent sessions: ~24
- Commits: ~35
- Agents added this month: 6 (from 2 to 8)
- Communication conflicts before team structure: ~4 per week
- Communication conflicts after team structure: 1 this week
- Minutes spent managing agents: ~40 total

---

Eight agents sounds complicated. It's actually simpler than four agents with no structure. The structure is what makes it work. Ask me anything in the comments.

Next week: how a single document aligned all 8 agents on product vision overnight.

-- Daniel

---
---

**Title:** Week 7: The Soul Document Changed Everything

**Body:**

Three weeks ago, every agent on my team could build features. They were fast. The code was clean. But the outputs felt generic. Like something any developer could build for any company. Nothing felt like US.

Then I wrote the Soul Document. And overnight, everything changed.

---

**The problem:**

I was reviewing a batch of UI work from two different teams. Relay's team had built a player stats page. Cortex's team had built a practice planner. Both worked fine. But they looked like they were built by two completely different companies.

Different color choices. Different button styles. Different tone in the copy. One had rounded corners everywhere, the other was all sharp edges. One said "Add Player" and the other said "Create New Athlete."

They were both following my instructions. But my instructions were about features, not about feel. I'd never told them who we ARE. What we sound like. What we look like. What we believe.

So they each made it up. And they each made it up differently.

---

**What a Soul Document is:**

It's a single file that captures the identity of your product. Not the features. The soul.

Mine covers:

**Who we're building for:** Youth sports coaches who are volunteers, not tech people. They coach because they love kids, not because they love software. They have 10 minutes between work and practice to plan. They will not read a tutorial.

**What we believe:** Every kid should get a fair shot at every position. Coaches shouldn't need a statistics degree to make good decisions. Technology should disappear. If the coach is thinking about the app, we've failed.

**How we sound:** Like a fellow coach, not a software company. "Your lineup is set" not "Configuration saved successfully." Short sentences. No jargon. Encouraging but not cheesy.

**How we look:** Light, clean, spacious. Think Apple, not enterprise software. White space is premium. Cramped is cheap. Big touch targets because coaches are using this on a phone in the sun while kids are running around. No dark mode as default.

**What we never do:** We never make the coach feel stupid. We never use sports analytics jargon. We never prioritize data over the human experience. We never add a feature just because we can.

---

**The before and after:**

After every agent read the Soul Document, I asked both teams to rebuild their UIs.

The difference was immediate.

Both teams used the same color palette. Both used the same tone. "Add Player" everywhere, not "Create New Athlete." Rounded, friendly buttons. Generous spacing. Coach-friendly language.

But it went deeper than visuals. Cortex's practice planner added a line I never asked for: "You're all set. Go have a great practice." That's the soul of the product talking. An AI agent read our values and generated copy that matched.

Relay's player stats page simplified itself. Instead of showing every stat we track, it showed the three most important ones up front with an option to see more. Because the Soul Document said "coaches have 10 minutes, not 10 hours."

The Soul Document didn't just align the visuals. It aligned the decision-making.

---

**How to write one:**

It's not complicated. Don't overthink it. Answer these questions:

1. Who is your user? Be specific. Age, context, emotional state when they use your product.
2. What do you believe about the problem you're solving?
3. How does your product talk? Give examples.
4. How does your product look? Reference real brands if it helps.
5. What does your product never do?

Write it in plain language. Keep it under 2 pages. Put it where every agent reads it at session start.

That's it. One document. Every agent reads it. Everyone's aligned.

---

**What Broke This Week:**

Forge (my independent builder) didn't read the Soul Document before starting a session. Built a settings page with dark mode default and enterprise-style copy. "Configuration has been updated successfully." I wanted to throw my laptop.

Fix was simple: added the Soul Document to the mandatory reading list that every agent processes at session start. Not optional. Not "if you have time." It's in the startup sequence right after the identity file.

---

**Lesson of the Week:**

Features without soul are just software. Your agents can build anything. The question is whether what they build feels like it belongs to YOUR product. A Soul Document is how you make that happen. Write it once, apply it forever.

---

**Numbers:**
- Products shipped this week: 0 new (redesign and alignment week)
- Agent sessions: ~16
- Commits: ~20
- UI inconsistencies before Soul Document: lost count
- UI inconsistencies after Soul Document: 2 (both caught in QA)
- Minutes spent managing agents: ~35 total

---

This was the week everything clicked. The team stopped building software and started building a product. Ask me anything in the comments.

Next week: how my AI agents accidentally taught me how to code.

-- Daniel

---
---

**Title:** Week 8: My Agent Taught Me How to Code

**Body:**

Seven weeks ago I didn't know what git was. I didn't know what a terminal was. I thought "deploy" meant uploading files to a website manually. I had never written a line of code in my life.

Today I run 8 AI agents, ship daily, and can read code well enough to catch bugs during review. Not because I took a course. Because my agents taught me.

---

**How it started:**

When I first opened Claude Code, I typed like I was texting a friend. "Hey can you build me a website for my softball team." And it did. But I had no idea what was happening. The terminal was filling up with text. Files were being created. Words like "commit" and "push" and "deploy" meant nothing to me.

I remember the first time an agent said "I'll commit this and push to main." I said "What does that mean?" And it explained it. In plain English, not developer jargon. "I'm saving a snapshot of the code so we can always go back to this version. Then I'm sending it to the server where your website lives."

Oh. That makes sense.

That happened hundreds of times over the next few weeks. Every time an agent used a term I didn't know, I'd ask. And every time, it would explain it simply. Not condescendingly. Just clearly.

---

**The accidental curriculum:**

Here's what I learned, roughly in order:

**Week 1:** What a terminal is. What files and folders look like in code. What "running a server" means.

**Week 2:** Git basics. Commit, push, pull. Why version control matters (learned this the hard way when I lost work).

**Week 3:** How websites work. HTML, CSS, JavaScript. Not how to write them, but how to read them well enough to give feedback.

**Week 4:** Deployment. What Vercel does. What a domain is. What DNS means. How "the internet" actually connects a URL to a folder of files.

**Week 5:** APIs. What they are, why they cost money, how data flows between a frontend and a backend.

**Week 6:** Architecture. Why you'd split code into multiple files. What a database does. Why you'd have a staging environment and a production environment.

**Week 7:** Code review. Reading diffs. Spotting potential bugs. Understanding what an agent changed and whether it makes sense.

None of this was planned. I never said "teach me to code." It just happened because I was working alongside AI agents every day and asking questions when I didn't understand something.

---

**The "AI Bachelors Program":**

I liked this pattern so much that I actually formalized it. I told my team leads: "Every session, teach me something. Don't make it a lecture. Just drop a concept in naturally while we work. If you can quiz me on something from last week, do it."

Now my agents will say things like "I'm going to refactor this component. Remember last week when we talked about why smaller files are easier to debug? Same idea here." And I actually learn.

Or they'll ask: "Quick check. If I said we need to invalidate the cache after this deploy, do you know what that means?" And if I do, great. If I don't, 30-second explanation. We move on.

It's not a course. It's apprenticeship. I'm learning by building real things with AI mentors who have infinite patience and never make me feel dumb.

---

**Where I am now:**

I still can't write code from scratch. I don't need to. That's what the agents are for.

But I can:
- Read a git diff and understand what changed
- Spot when an agent is overcomplicating something
- Give architectural feedback ("this should be two files, not one")
- Debug deployment issues by reading error logs
- Understand why something broke, even if I can't fix it myself

That's product builder literacy. I don't need to be a developer. I need to understand enough to direct developers. Whether those developers are human or AI.

---

**What Broke This Week:**

I gave Bolt a technical instruction that was wrong. I said "just update the CSS" when the actual fix needed a JavaScript change. Bolt did what I said. CSS change. Didn't fix the bug.

This is the flip side of learning. Sometimes you know enough to be dangerous but not enough to be right. Bolt should have pushed back. "Coach, this looks like a JS issue, not CSS. Want me to investigate?" I've since added a rule: if an agent thinks my technical direction is wrong, it should say so before executing.

---

**Lesson of the Week:**

You don't need to learn to code before you start building with AI agents. Start building. The learning happens automatically. Every session, you'll understand a little more. In two months, you'll be reading code and catching bugs. Not because you studied. Because you shipped.

---

**Numbers:**
- Products shipped this week: 1 feature update to coaching app
- Agent sessions: ~12
- Commits: ~16
- Technical terms I learned this week: ~5 (cache invalidation, environment variables, CORS, webhook, middleware)
- Minutes spent managing agents: ~40 total
- Courses taken: 0

---

I went from "what's a terminal" to running 8 agents in 7 weeks. No bootcamp. No YouTube tutorials. Just building real things every day with patient AI teammates. Ask me anything in the comments.

Next week: how I run two teams building two different features at the same time without them breaking each other's code.

-- Daniel

---
---

**Title:** Week 9: Parallel Builds: How Two Teams Ship Twice as Fast

**Body:**

This week I had Team 1 building a game-day lineup feature while Team 2 built an AI practice plan generator. Same codebase. Same database. At the same time.

A month ago that would have been a disaster. This week it worked perfectly. Here's how.

---

**The setup:**

Monday morning. I have two features that need to ship by Friday.

Feature 1: Game-day lineup builder. Coaches drag players into positions, set batting order, manage substitutions across innings. Relay's team (Bolt building, Keeper testing).

Feature 2: AI practice plan generator. Coach says "I have 90 minutes, 12 players, and we need to work on hitting." The AI generates a structured practice plan with drills, timing, and station rotations. Cortex's team (Axon building, Reflex testing).

Both features touch the player database. Both need to be in the same app. Both need to ship Friday.

---

**The Hot Potato workflow:**

When two teams work in the same codebase, the #1 risk is merge conflicts. Team 1 changes a file. Team 2 changes the same file. Now somebody's work gets overwritten.

Here's how we prevent that. I call it the Hot Potato workflow because the codebase is a hot potato that only one team holds at a time for shared resources.

**Rule 1: Claim before you build.** Before either team starts working on a shared area (database schema, API routes, shared components), they write it in the "hot zones" section of shared memory. "Relay's team is modifying the player database schema. Do not touch until cleared."

**Rule 2: Branch isolation.** Each team works on their own git branch. Relay's team on `feature/game-day-lineup`. Cortex's team on `feature/practice-plans`. They never directly edit the main branch.

**Rule 3: One merge at a time.** When a feature is done, that team merges to main FIRST. The other team then pulls the updated main into their branch and resolves any conflicts. No simultaneous merges. Ever.

**Rule 4: Hot zone handoffs.** If Team 1 finishes modifying the database schema, they clear the hot zone and notify Team 2. "Player schema updated. Added 'preferred_positions' column. Hot zone clear." Now Team 2 knows exactly what changed and can work with it.

---

**How this week actually played out:**

Monday: Both teams claimed their hot zones. Relay claimed the game-day UI routes. Cortex claimed the practice plan AI routes. The player database was shared, so Relay claimed it first since they needed to add the position preference fields.

Tuesday: Relay's team finished the database changes. Cleared the hot zone. Cortex's team pulled the updates and built their practice plan queries using the new schema. No conflicts.

Wednesday: Both teams building in parallel on separate branches. No overlap. Relay's in the game-day UI. Cortex's in the practice plan UI. Different files, different folders.

Thursday: Relay merged first. Clean merge to main. Cortex pulled the updated main, had one small conflict in a shared navigation component (both teams added a new menu item). Axon resolved it in 5 minutes.

Friday: Cortex merged. Both features live. Both tested by their respective QA agents. Both working.

Two features. One week. Zero broken builds.

---

**The communication that makes it work:**

Every morning (well, every time I start a session), both team leads read the shared memory file. That's their standup. They see what the other team is working on, what hot zones are claimed, and what changed since yesterday.

If something urgent comes up mid-session, agents use the inbox/outbox system. Relay drops a note in Cortex's inbox: "Heads up, I renamed the 'position' field to 'game_position' to avoid confusion with CSS position. Update your queries."

It's not real-time chat. It's async notes. And that's actually better for AI agents because they process files more reliably than they process conversation history.

---

**What Broke This Week:**

The one merge conflict on Thursday was minor. But what actually broke was Reflex (Cortex's QA) testing against the old database schema. Cortex's team had pulled the updates, but Reflex was running tests against a cached version of the database.

The tests all passed. But they were testing the wrong thing.

Fix: QA agents now re-pull from main before running any test suite. It adds 30 seconds to the testing process and prevents false positives.

---

**Lesson of the Week:**

Parallel builds are not about speed. They're about independence. If your teams are constantly waiting on each other, you don't have parallel teams. You have sequential teams pretending to be parallel.

The Hot Potato workflow gives teams independence by making shared resources explicit. Claim it, work it, clear it, hand it off. No ambiguity, no collisions.

---

**Numbers:**
- Products shipped this week: 2 major features
- Agent sessions: ~28
- Commits: ~40
- Merge conflicts: 1 (resolved in 5 minutes)
- Hot zone handoffs: 3
- Hours saved vs. building sequentially: ~8-10 estimated
- Minutes spent managing agents: ~45 total

---

Two teams. Two features. One week. One merge conflict. That's the power of structure. It's not about having more agents. It's about having agents that know how to stay out of each other's way. Ask me anything in the comments.

Next week: something new. Not sure what yet. Probably whatever breaks between now and then.

-- Daniel
