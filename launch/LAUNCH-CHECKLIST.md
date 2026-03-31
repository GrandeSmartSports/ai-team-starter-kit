# Launch Checklist - Go Live Today

## Everything is ready. Follow these steps in order.

---

### Step 1: Create Skool Account (15 min)
- [ ] Read `launch/SKOOL-SETUP-GUIDE-FOR-COACH.md`, explains everything in plain English
- [ ] Go to skool.com and create an account
- [ ] Create a group called "AI Team Builders"
- [ ] Set pricing to $29/month
- [ ] Connect Stripe (Skool walks you through this)
- [ ] Set up categories from `launch/skool-categories.md`

### Step 2: Add Content to Skool (15 min)
- [ ] Post the welcome message from `launch/skool-welcome-post.md` → pin it in General
- [ ] Upload `ai-team-starter-kit.zip` in Resources (the zip is at the project root)
- [ ] Post the Start Here guide from `launch/start-here-guide.md` in Resources → pin it
- [ ] Add Module 1 lessons to the Classroom tab (copy from `course/module-1/`)
- [ ] (Optional) Add Modules 2-4, can do this over the next few days

### Step 3: Update Links (5 min)
- [ ] Copy your Skool community URL
- [ ] Find-and-replace `{YOUR_SKOOL_LINK}` in `PITCH.md`
- [ ] Find-and-replace `{YOUR_SKOOL_LINK}` or update the join button `href` in `launch/landing-page/index.html`

### Step 4: Deploy Landing Page (5 min, optional)
- [ ] Run `npm install -g vercel` (if not installed)
- [ ] Run `vercel login`
- [ ] Run `cd launch/landing-page && ./deploy.sh`
- [ ] Copy the live URL

### Step 5: Start Sharing (10 min)
- [ ] Pick your best social media post from `launch/social-media-posts.md`
- [ ] Post in the OpenAI chat room (you're already in there)
- [ ] Post on Reddit r/ClaudeAI or r/ChatGPTCoding
- [ ] Save the DM response template for when people ask you about it

### Step 6: Welcome New Members
- [ ] Read `launch/welcome-sequence.md` for DM templates
- [ ] Send welcome DM to every new member within 24 hours
- [ ] Post your first "Behind the Scenes" content within the first week

---

## That's it. You're live.

**Time to complete: ~45 minutes total**

Everything you need to paste is already written. Just copy → paste → publish.

---

## Quick Reference

| What | Where |
|------|-------|
| What is Skool + how to set it up | `launch/SKOOL-SETUP-GUIDE-FOR-COACH.md` |
| About page copy | `launch/skool-community-description.md` |
| Welcome post | `launch/skool-welcome-post.md` |
| Category names | `launch/skool-categories.md` |
| Start Here guide | `launch/start-here-guide.md` |
| Social media posts | `launch/social-media-posts.md` |
| Welcome DM templates | `launch/welcome-sequence.md` |
| Landing page | `launch/landing-page/index.html` |
| Pitch copy | `PITCH.md` |
| Course content | `course/` (4 modules, 13 lessons) |
| Starter kit zip | `ai-team-starter-kit.zip` |
