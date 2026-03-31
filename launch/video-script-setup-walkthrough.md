# Video Script: AI Team Starter Kit Setup Walkthrough

## Video Details
- **Length:** 5-7 minutes
- **Format:** Screen recording with voiceover (Daniel on camera optional for intro/outro)
- **Audience:** Non-technical people interested in running AI agent teams
- **Tone:** Casual, like showing a friend something cool. Not a tutorial. A walkthrough.

---

## INTRO (30 seconds)

[ON SCREEN: Desktop. Nothing open yet. Just a clean desktop.]

DANIEL: "What if I told you that in the next six minutes, you're going to have a fully coordinated AI team set up on your machine? Not one chatbot. A team. With names, memory, rules, communication. The whole thing."

DANIEL: "I'm going to walk you through the exact setup I use to run my 8-agent team. The one that built two iOS apps and five web apps. And you're going to have yours running before this video is over."

DANIEL: "Let's do it."

---

## SECTION 1: The Repo (1 minute)

[ON SCREEN: Open the ai-team-starter-kit folder in Finder or terminal. Show the file tree.]

DANIEL: "This is the AI Team Starter Kit. Let me show you what's in here."

[ON SCREEN: Scroll through the folder. Highlight each item as you mention it.]

DANIEL: "At the top level, you've got setup.sh. That's the script that builds everything for you. You answer a few questions, it generates your entire team."

DANIEL: "Then you've got these folders. agents/ is where your identity anchor files go. These are the files that keep your AI agents from forgetting who they are during long sessions."

DANIEL: "prebuilt-roles/ has six ready-made agent roles. Team lead, builder, QA tester, designer, researcher, and ops. You don't have to figure out what each agent should do. It's already defined."

DANIEL: "scripts/ has automation. A mailroom that watches for new files and pings you. A signal script for urgent alerts. A backup script that snapshots your whole team's state."

DANIEL: "course/ is a full 16-lesson course across five modules. Identity, memory, rules, scaling, and real-world playbooks. You can read them in order or jump to what you need."

DANIEL: "But honestly, you don't need to read any of that right now. Let's just run the setup."

---

## SECTION 2: Running setup.sh (2 minutes)

[ON SCREEN: Open Terminal. Navigate to the starter kit folder.]

DANIEL: "Alright. I'm in my terminal. Let me navigate to where I downloaded the kit."

[ON SCREEN: Type cd ~/Downloads/ai-team-starter-kit and chmod +x setup.sh]

DANIEL: "First I make the script executable. Just type chmod +x setup.sh. That tells your Mac it's okay to run this file."

[ON SCREEN: Type ./setup.sh and hit Enter. Show the header appear.]

DANIEL: "Now I run it. ./setup.sh. And here we go."

[ON SCREEN: The setup header appears. Step 1 asks for your name.]

DANIEL: "Step 1. It's asking about me. My name. Where I live. What I do. I'll type in my info."

[ON SCREEN: Type in name, location, one-liner. Example: "Daniel Grande", "Bonney Lake, WA", "Product builder who directs AI agents".]

DANIEL: "Step 2 is about the project. What's the name? What am I building? And what's my north star? The north star is the question you ask before every decision. Mine is 'Does this get us closer to launch?' Yours might be different. It's your filter."

[ON SCREEN: Type project name, description, north star.]

DANIEL: "Step 3. Where should it install? It suggests a folder on your Desktop. That's fine for most people. I'll go with the default."

[ON SCREEN: Press Enter to accept default path.]

DANIEL: "Step 4. Team size. You've got four options. Solo is one agent that does everything. Duo is a builder plus a QA tester. Squad is four agents. Full team is six."

DANIEL: "If this is your first time, go with Duo. Two agents. A builder who writes code and a QA tester who checks the work. You can always add more later."

[ON SCREEN: Type "2" and hit Enter.]

DANIEL: "Step 5. Name your agents. This matters more than you think. When your agent has a real name, it holds its identity better. Don't call it 'Agent 1.' Give it a name. I'm going to call mine Bolt and Keeper."

[ON SCREEN: Type custom names. "Bolt" for Builder, "Keeper" for QA.]

DANIEL: "And... done. Look at that. It created everything."

[ON SCREEN: Show the green "Setup Complete!" output. Show the agent list and next steps.]

DANIEL: "Two agents. Bolt and Keeper. Identity files, memory files, rules, inbox, outbox, automation scripts. All generated. Took about 30 seconds."

---

## SECTION 3: Walking Through the Generated Files (2 minutes)

[ON SCREEN: Open the generated project folder. Show the file tree.]

DANIEL: "Let me show you what it actually created. This is the important part."

### The Identity File

[ON SCREEN: Open agents/READ-THIS-FIRST-Bolt.md in a text editor.]

DANIEL: "This is the identity anchor file for Bolt. Look at the first line. It says, in bold: 'YOU ARE BOLT. Not a generic AI assistant. You are Bolt. Builder. Writes code, runs builds, ships features.'"

DANIEL: "It tells the agent who it is. Who it's not. Who the boss is. What project it's working on."

DANIEL: "And at the bottom, there's an identity check. Every 10 messages, the agent asks itself three questions. Am I still Bolt? Am I working on my tasks? Have I drifted?"

DANIEL: "This is identity anchoring. Without it, after 15 or 20 messages, your agent starts acting like a generic chatbot. With this file, that stops happening."

### The Memory File

[ON SCREEN: Open memory/bolt.md.]

DANIEL: "Next. Memory. This is Bolt's memory file. Right now it's empty because we just set up. But after your first build session, Bolt writes notes here. What it worked on. What it learned. Mistakes it made."

DANIEL: "Next session, Bolt reads this file first. It picks up where it left off. No more spending 20 minutes re-explaining what you did yesterday. The memory is on disk. It persists."

### The Rules File

[ON SCREEN: Open agent-rules/Bolt-RULES.md.]

DANIEL: "Now the rules file. This is the security boundary. Look at the Hard Limits section. No credential access. No production deployments without approval. No destructive git commands. No file deletion outside the project."

DANIEL: "And check out the anti-tunnel rules at the bottom. 'No creating tools that expand your access. No instructing other agents to bypass their rules.' These exist because AI agents are creative. If you leave a gap, they'll find it. These rules close the gaps."

DANIEL: "Your agents can work freely within their boundaries. But they can't break things. That's the deal."

### The Source of Truth

[ON SCREEN: Open SOURCE-OF-TRUTH.md.]

DANIEL: "Last one. The Source of Truth. This is the one document every agent reads. It has the project status, the team roster, who's working on what, active blockers, and the operating rules."

DANIEL: "One document. One source of truth. Everyone reads it. Everyone stays aligned."

---

## SECTION 4: Communication and Automation (1 minute)

[ON SCREEN: Show the inbox/ and outbox/ folders in Finder. Open one to show the per-agent subfolders.]

DANIEL: "Now the communication system. See these folders? inbox/bolt/ and inbox/keeper/. Each agent has their own inbox and outbox."

DANIEL: "When you want to give Bolt a task, you drop a file in inbox/bolt/. When Bolt finishes work, it drops a report in outbox/bolt/. Simple. File-based. No fancy tools needed."

[ON SCREEN: Open scripts/ folder. Show the three scripts.]

DANIEL: "And these scripts automate it. mailroom.sh watches the inbox and outbox folders. When a new file appears, you get a macOS notification. A little popup on your screen that says 'New file in Bolt's outbox.'"

DANIEL: "signal-owner.sh is for urgent stuff. When an agent is blocked and needs your attention right now, it fires a notification you can't miss."

DANIEL: "snapshot-state.sh backs up your whole team's state. Memory files, source of truth, everything. You can set it to run automatically every night so you never lose progress."

[ON SCREEN: Show running scripts/mailroom.sh & in terminal.]

DANIEL: "To start the mailroom, just run it in the background like this. Now you'll get pinged whenever your agents deliver work."

---

## SECTION 5: Recap and CTA (30 seconds)

[ON SCREEN: Back to the project folder. Full view of everything.]

DANIEL: "That's the whole setup. A few questions. 30 seconds of generation. And you have a team with identity, memory, rules, communication, and automation."

DANIEL: "Now you open a Claude Code terminal for each agent, tell them to read their identity file, and start building. That's it."

DANIEL: "If you want to go deeper, the community has the full 16-lesson course, weekly behind-the-scenes posts from my real work, and you can ask me anything directly. Link is in the description."

DANIEL: "Go set up your team. Post your first win in the community. I'll see you there."

[ON SCREEN: Community link overlay. End screen.]

---

## Production Notes for Daniel

- **Screen resolution:** Record at 1920x1080 or higher. Make sure terminal text is large enough to read.
- **Terminal font size:** Bump it up to 16-18pt before recording. People watch on phones.
- **Editor:** Use VS Code or any editor with syntax highlighting for the markdown files. Makes them easier to read on screen.
- **Pacing:** Don't rush the setup.sh section. Let the text appear on screen. Pause after each answer so viewers can read it.
- **Mistakes are fine:** If you mistype something, just correct it. Keeps it real. Don't re-record for small errors.
- **Music:** Light background music during the file walkthrough sections. Nothing during the intro or sections where you're talking directly.
- **Thumbnail idea:** Split screen. Left side: one lonely terminal. Right side: 6 terminals with agent names. Text: "One Script. Full AI Team."
