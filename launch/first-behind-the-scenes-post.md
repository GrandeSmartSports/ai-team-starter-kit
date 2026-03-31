# First Behind the Scenes Post - Ready to Paste into Skool

## Post this in the "Behind the Scenes" category during your first week

---

**Title:** Week 1: How My 8-Agent Team Actually Works (Real Screenshot Walk-Through)

**Body:**

Welcome to Behind the Scenes. Every week I share what's actually happening with my AI team. No theory, just real work.

This week: a walkthrough of how my team is set up and what a typical build session looks like.

---

**My Team Structure:**

I run two sub-teams, each with a Team Lead:

**Team 1: Build Team (Relay)**
- Relay (Team Lead): coordinates build + QA
- Bolt (Builder): writes all the code
- Keeper (QA): tests everything

**Team 2: Brain Team (Cortex)**
- Cortex (Team Lead + Architect): AI features, intelligence
- Axon (Builder): implements brain features
- Reflex (QA): tests accuracy and AI outputs

Plus two independent agents: Forge (full-stack builder) and Patch (design + QA).

I talk to the Team Leads. They manage their sub-teams. I don't micromanage the builders or QA agents directly.

---

**A Real Build Session:**

Yesterday I needed a landing page for a new product. Here's exactly what happened:

1. Told Cortex: "I need a landing page. Clean, light design. Has hero, problem/solution, pricing, FAQ, and about sections."

2. Cortex asked ONE clarifying question: "What price point and who's the target audience?"

3. I answered. Cortex said "Going dark to build."

4. 20 minutes later, Cortex reported back: page built, deployed to Vercel, link ready to test.

5. I checked it on my phone. Looked good. Gave two pieces of feedback (fix the timeline from 6 months to 7 weeks, add a FAQ section).

6. Cortex fixed both, redeployed in under 5 minutes.

Total time from me: about 10 minutes of actual involvement. The rest was the AI team working.

---

**What Broke This Week:**

Honesty time. My builder agent drifted during a long session. Started suggesting design changes when it's supposed to focus on backend code. Classic identity drift.

Fix: I told it "identity check" and it re-read its anchor file. Back on track in 30 seconds.

This is why identity anchoring exists. Without it, that drift would have gone unnoticed and I'd have wasted 20 minutes of unfocused work.

---

**Lesson of the Week:**

Memory files work best when they're specific. Instead of "Worked on the landing page," write "Built landing page with 7 sections, deployed to Vercel at [URL], FAQ uses accordion toggle." The more specific the memory, the faster the next session picks up.

---

**Numbers:**
- Products shipped this week: 1 landing page, 1 starter kit
- Agent sessions: ~12
- Commits: ~15
- Bugs caught by QA before I saw them: 3
- Minutes spent managing agents: ~45 total across the week

---

That's week 1. Ask me anything in the comments. I'll answer everything.

Next week: how the memory system prevented a major bug from recurring.

-- Daniel
