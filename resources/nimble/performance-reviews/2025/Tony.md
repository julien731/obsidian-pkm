---
type: resource
created: 2026-03-10
summary: "360 feedback review for Tony from the 2025 review cycle"
tags:
  - performance-review
  - nimble
related:
  - "[[people/Tony]]"
---

# 360 Review: Tony (2025)

## Summary

**Strengths:**
- Quality mindset (2 reviewers) — strong sense of how good apps should work, already raised the quality bar on the team, finds edge cases others miss
- Clear communication and story quality (2) — effective in-person and async communication, test cases in stories help developers focus on code quality
- Fast learner with clear progress (1) — noticeable improvement since joining, adapting well to company processes
- Ownership under pressure (1) — cuts through noise during high-pressure releases, keeps team aligned

**Areas for improvement:**
- Proactiveness and autonomy (1) — tends to seek permission before acting on clearly wrong things; should push for the right thing without waiting for approval
- Edge case thinking before handoff (1) — thinking through "what could go wrong?" before finalizing requirements would reduce scope creep
- Visibility of process improvements (1) — should share improvements with the wider team rather than applying them silently on individual projects

## What Went Well

### From Avishek

* Communication: Conversations—both in person and in the DMs as well as response to the comments made on the stories—led to quick decision making, unblocking technical challenges, and moving things forward quickly.
* Story descriptions, AC, test cases: the new convention of adding test cases in story descriptions made it easier for developers to implement features without spending time on thinking of all possible scenarios and edge cases. Which helped them focus more on the code quality. It also made it easier for the developers to create proof of work for all the scenarios mentioned in the story instead of just the happy paths.
* Testing, feature improvments, and bugfixes: On few occasions, some extreme edge cases, including some long-standing ones, have been found and fixed, making the app UX more enjoyable. Here are some examples: [https://jfc-dcd.atlassian.net/jira/software/c/projects/JB/issues?jql=project%20%3D%20JB%0AAND%20creator%20%3D%20712020%3A2b3e93d9-7d67-4f2e-a182-16d56110e8af%0AAND%20assignee%20IN%20(currentUser()%2C%20712020%3A495c4729-f5a1-492d-8da4-476a63006690%2C%205f7aaf874d09f7007610db55%2C%20712020%3Aed4d8ada-9330-4724-9cbf-cf5684ddf9c6)%0AAND%20type%20%3D%20Bug%0AORDER%20BY%20created%20DESC&quickFilter=11]()
* Improvement in following the company processes and convention has been noticed.

### From Roman

Has a great sense of quality. Strong taste and experience in how good web and mobile apps should work. Already raised the quality bar on the team, found and communicated many issues. His past QA background is obvious. Also a fast learner. The progress since the first month is clear. Does a good job on ticket descriptions and providing test cases there.

### From Thaw Zin Toe

Strong at aligning the team around priorities and communicating with stakeholders clearly. When scope gets messy, they step in quickly to cut through the noise and keep us moving. That kind of ownership makes a real difference during high-pressure releases.

### From Julien (me)

- Good job with getting up-to-speed with everything Jollibee. It's a lot.

## What Could Be Better

### From Avishek

No pattern has been observed yet that needs to be improved.

### From Roman

Tends to seek guidance or permission before acting when something is clearly wrong. It's understandable because he just joined, but being more proactive and pushing for the right thing without waiting for approval would make him more effective.

### From Thaw Zin Toe

When the PM joins early conversations about how something will be built, it helps bridge the gap between product vision and technical reality — and leads to smarter decisions on both sides.
Also, thinking through edge cases more deeply before handing off requirements would be a big win for the team. When edge cases are missed at the planning stage, they often surface during development and cause scope creep or last-minute rework. A simple habit of asking "what could go wrong?" before finalizing a requirement would reduce that pressure significantly and help the team ship with more confidence.

### From Julien (me)

- It's great that you work on improving processes and conventions, and you should share it with the wider team. If you find areas for improvement, it's important that you share so that every project can benefit. You must remember: changing processes is fine, changing processes "silently" on certain projects is not. Visibility is lost and other projects don't benefit from potential improvements.
  - You need to get more involved with the Product team as a whole when it comes to doing improvements and making progress.

## Phase 2: AI Synthesis

### Patterns Across Reviewers

**Strong consensus (3+ reviewers):**
- **Quality-driven mindset** — Avishek, Roman, and Julien all note Tony's ability to find issues others miss and raise the quality bar. Avishek highlights edge case discovery and the test-case convention; Roman calls out his "strong taste" for how apps should work; Julien acknowledges how much he's absorbed on a complex project.
- **Clear, structured communication** — Avishek and Roman both praise his story quality, particularly the test-case descriptions in tickets. Thaw Zin Toe highlights his ability to align the team and communicate with stakeholders under pressure.

**Emerging theme (2 reviewers):**
- **Growth trajectory** — Roman explicitly notes visible progress since month one. Avishek observes improvement in following company processes. This is a strong signal for someone relatively new to Nimble.

**Where perspectives diverge:**
- Avishek sees "no pattern that needs to be improved" while Roman and Thaw Zin Toe both identify meaningful growth areas. This may reflect that Avishek works closely enough with Tony to benefit from his improvements but not at the level where autonomy and strategic thinking gaps become visible.

### Blind Spots

- **Process improvements stay local.** Tony is actively improving how he works (and Avishek benefits), but Julien's feedback reveals Tony doesn't realize this creates a visibility and fairness problem. Other projects don't benefit, and leadership can't track what's changing. Tony likely sees himself as "just doing good work" without recognizing the organizational cost of silent changes.
- **Permission-seeking reads as caution, not thoroughness.** Roman frames the tendency to seek approval as understandable for someone new — but it may persist beyond the grace period if Tony doesn't consciously push past it. He may not realize that others interpret it as lack of confidence rather than diligence.
- **Edge case thinking is reactive, not proactive.** Thaw Zin Toe notes that Tony catches edge cases well during testing (a strength everyone sees) but doesn't apply the same rigor during planning/handoff. Tony likely doesn't see the gap because he's solving the same problems — just at a more expensive stage.

### Strength-Growth Connections

| Strength | Connected Growth Area |
|---|---|
| Finds edge cases others miss (testing phase) | Doesn't yet apply the same "what could go wrong?" lens during requirements/planning — catching issues earlier would multiply his impact |
| Improves processes and conventions naturally | Applies improvements silently on his projects rather than sharing with the wider team — limits organizational value |
| Strong quality bar and attention to detail | May reinforce permission-seeking behavior: wanting to "get it right" before acting can slow him down on judgment calls where speed matters more than perfection |

### Development Recommendations

1. **Shift edge-case thinking earlier in the process.** Before finalizing any requirement or story, run a 5-minute "pre-mortem": list 3 things that could go wrong, 3 assumptions that might be wrong, and 3 user paths not covered. This is the same skill Tony already uses in QA — it just needs to happen at the planning table.

2. **Make process improvements visible and shared.** When Tony improves a convention or workflow on his project, he should write a short post (Slack, Confluence, or team standup) explaining what changed, why, and what he'd recommend for other projects. Target: at least one shared improvement per sprint cycle.

3. **Practice "act then inform" on low-risk decisions.** When something is clearly wrong (broken flow, confusing copy, missing edge case), fix it or file it and tell the team after — don't ask permission first. Start with small calls to build the muscle, then gradually take on bigger judgment calls. A useful test: "If I do this and it's wrong, how bad is it?" If the downside is small, act.

4. **Get involved in cross-project Product team work.** Tony should participate in team-level discussions about standards, tooling, and process — not just project-level work. This builds visibility, spreads his good instincts wider, and positions him for growth beyond a single project scope.