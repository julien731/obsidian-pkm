---
type: resource
created: 2026-03-10
summary: "360 feedback review for Got from the 2025 review cycle"
tags:
  - performance-review
  - nimble
related:
  - "[[people/Got]]"
---

# 360 Review: Got (2025)

## Summary

**Strengths:**
- Hardworking and hands-on (3 reviewers) — wears multiple hats, rolls up sleeves to troubleshoot, actively involved in QA
- Clear issue creation and documentation (2) — tickets are well-structured and aligned with client goals
- Proactive client engagement (1) — regularly visits stores to check on the apps, handles client issues quickly

**Areas for improvement:**
- AI-generated ticket quality (1) — tickets look convincing but edge cases aren't thought through, AC doesn't always make sense, "Technical Considerations" can mislead junior devs
- Documentation and knowledge transfer (1) — no up-to-date docs when handing over, backlog out of scope, designs/PRDs had limited clarity
- Bias toward quick fixes over proper solutions (1) — results in patchwork code that makes future development harder
- Timeline alignment with team capacity (1) — needs more realistic planning

## What Went Well

### From Clark

I see Got as an extremely hardworking PM. He is consistently willing to wear multiple hats when needed, and it’s clear that he can handle a significant workload at the same time

### From Htoo

The issues he created were clear, well-structured, and directly aligned with client goals — making it easy for the team to understand the intent and priority behind each task.
He was actively involved in the QA process, supporting developers rather than leaving them to validate alone. This kept things moving and reduced back-and-forth.
When problems came up, he didn't just flag them and step back — he rolled up his sleeves and helped troubleshoot, which made a real difference in how quickly the team could get unblocked.

### From Ryan

- Got took charge with fielding Jones Salad issues. He either raised it to the team to fix asap or was able to handle them himself. I don't recall an incident where client issues were suppressed or hidden from the team.
- Got regularly went to the stores to check in with the staff to see if the apps were working as expected, so feedback felt pretty fast.

### From Chuu

Maintains clear and structured documentation for features and requirements.
Coordinates discussions between stakeholders and the development team.

### From Julien (me)

- As usual, strong ownership.
- You've done a great job with deploying Okya and supporting clients.
- You're setting the right sense of urgency with the team to ensure that we deliver things on time.
- Great that you're getting more hands-on now using AI.

## What Could Be Better

### From Clark

In my opinion, knowledge transfer was the biggest challenge when I took over the project. There was no up-to-date documentation I could rely on as a reference. Across key areas including designs, backlog, and PRDs there was limited clarity on the current state of the project and overall alignment. Some documentation was outdated or inaccurate, and the backlog appeared significantly out of scope, both internally and in relation to client expectations.

Going forward, implementing a more structured and consistently maintained documentation and communication process would greatly improve continuity and project alignment

### From Htoo

When working on large and complex features, he should take more time to verify and align with the product goal rather than relying solely on AI-generated output. This is especially important in areas where we're still building up domain knowledge together.

### From Ryan

- Got must improve the work put into the tickets created for the team. Initially, the tickets were barebones (2-3 lines each), but this was at the height of the extreme workload while prepping for Jones Salad's initial launch so I understand why. The issue is the usage of AI to create the tickets now: They look convincing, but not all cases have been thought through and many times the AC does not make total sense. The "Technical Considerations" part of the tickets can also influence decisions taken by less experienced devs on the team: I think they should not be included at all and the focus should be on defining clear AC. At least with the barebones tickets, it was clear when a task has not been fully thought out yet.
- Got has a tendency to push for quick fixes rather than proper robust solutions. This typically results in a lot of patchwork being put into the code, which makes future development trickier. It would be ideal to have the chance to think through and apply proper fixes to anything buggy rather than pushing out so frequently that people lose track of what has changed.
- I have concerns about the QA done to the app before launch. Typical Nimble process has the PM's do final testing before release, but I don't know how often this happens. Having a proper QA flow with official sign-offs on release stating that the app has been tested (plus if there are any known issues) would be helpful for this case.

### From Chuu

Align timelines more realistically with team capacity.

### From Julien (me)

At this point, the main thing holding you back is the same thing we've been discussing many times: you need much more polish, clarity, and precision in what you do.

You have the grit, the mindset, and the practical thinking needed to become a brilliant individual contributor (Principal track). However, you are still struggling to bring clarity and alignment. Your content doesn't look professional enough because of the lack of polish and precision.

You also need to work on better structure and organization. You will need this to bring the level of clarity needed, to ensure you are on track for what you're doing, to avoid surprises, and to better enable the team.

## Phase 2: AI Synthesis

### Patterns Across Reviewers

**Strong consensus (3+ reviewers):**
- **Ownership and hustle** — Clark ("extremely hardworking, willing to wear multiple hats"), Htoo ("rolled up his sleeves and helped troubleshoot"), Ryan ("took charge with fielding Jones Salad issues"), Julien ("strong ownership"). This is Got's defining strength and it's universally recognized.
- **Hands-on with clients and QA** — Htoo ("actively involved in the QA process"), Ryan ("regularly went to the stores"), Julien ("great job deploying Okya and supporting clients"). Got closes the gap between the team and the end user in a way few PMs do.

**Emerging consensus (2 reviewers):**
- **Documentation and clarity are insufficient** — Clark ("no up-to-date documentation," "limited clarity on current state") and Julien ("lack of polish and precision," "better structure and organization"). Two different angles on the same root issue: Got's outputs don't hold up when someone else needs to pick them up.
- **AI-generated work masks shallow thinking** — Ryan ("tickets look convincing but not all cases have been thought through") and Htoo ("should take more time to verify rather than relying solely on AI-generated output"). AI is amplifying Got's speed but also amplifying his tendency to skip the careful thinking step.

### Diverging Perspectives

- **Chuu** describes Got's documentation as "clear and structured," while Clark found it outdated and insufficient for handover. This likely reflects timing — documentation may be adequate during active collaboration but degrades when Got moves on to other priorities. It suggests Got documents for his own working memory, not for others.

### Blind Spots

- **Got likely doesn't see how his speed creates debt for others.** He experiences his quick fixes as responsiveness and client focus. The team experiences them as patchwork code (Ryan) and incomplete handovers (Clark). The praise he gets for speed may reinforce the very behavior that's holding him back.
- **The AI-generated ticket issue is probably invisible to Got.** The tickets look thorough on the surface — that's exactly the problem. Without someone flagging specific examples, Got may genuinely believe the quality is fine.
- **No reviewer mentioned strategic thinking or prioritization.** Got is praised for execution and responsiveness, but nobody describes him shaping product direction, challenging requirements, or making hard tradeoff calls. For someone on a Principal PM track, this absence is notable.

### Strength-to-Growth-Area Connections

- **High ownership → shortcuts on process.** Got's drive to get things done fast means documentation, proper fixes, and structured handovers feel like friction. The same trait that makes him reliable in a crisis makes him cut corners in steady state.
- **Hands-on client engagement → reactive mode.** Visiting stores and handling issues personally is valuable, but it can keep Got operating as a firefighter rather than stepping back to build systems that prevent fires.
- **AI adoption enthusiasm → surface-level quality.** Got is doing the right thing by embracing AI tools (Julien praised this). But without the discipline to critically review AI output, it's producing work that looks complete but isn't — worse than obviously incomplete work because it erodes trust silently.

### Development Recommendations

1. **Implement a "handover readiness" check before moving off any project.** Before transitioning work, Got should ask: "If someone took this over tomorrow with zero context from me, could they find everything they need?" Have Clark or the receiving PM validate this explicitly for the next two transitions.

2. **Stop including "Technical Considerations" in AI-generated tickets entirely.** As Ryan flagged, these influence junior devs and Got isn't positioned to validate them. Strip that section. Instead, add a standing step: after AI drafts a ticket, Got reviews each acceptance criterion by asking "What happens if [edge case]?" and documents at least two edge cases per ticket. Track this for one sprint to build the habit.

3. **For every bug fix or hotfix, write one sentence: "The proper fix would be [X], and we're choosing the quick fix because [Y]."** This forces Got to consciously acknowledge the tradeoff rather than defaulting to speed. When the reason is just "it's faster," that's a signal to do the proper fix.

4. **Dedicate 30 minutes weekly to organizing and updating project documentation.** Not when handing over — continuously. This builds the structure and organization muscle Julien flagged. Use a simple checklist: Are designs current? Is the backlog scoped? Are PRDs reflecting reality?

5. **Before the next review cycle, identify one product decision where Got proactively shaped direction** — not just executed what was asked, but challenged scope, proposed an alternative approach, or said "we shouldn't build this." This is the gap between a strong executor and a Principal-track PM.