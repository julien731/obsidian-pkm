---
type: resource
created: 2026-03-10
summary: "AI-assisted approach for writing individual performance reviews using 360 feedback"
tags:
  - performance-review
  - nimble
  - process
related: []
---

# Performance Review Process

This documents the approach for writing individual performance reviews using AI as a synthesis and structuring tool — not as the author.

## Core Principle

AI should organize and articulate evidence that humans have gathered and validated. The moment AI generates content without grounding in specific, real evidence, it produces generic, trust-eroding output.

## Inputs Per Person

Before writing any review, gather:

1. **360 feedback file** — the raw reviewer comments already collected
2. **People note** — role context, history, working relationship
3. **Project/meeting notes** — relevant artifacts from the review period
4. **Your own observations** — rough bullet points on what you saw firsthand ("struggled with X on Project Y", "impressed me when Z")
5. **Previous review** — if one exists, for tracking growth trajectory

Your own observations are the most important input. They're the only source for things reviewers wouldn't see, and they make this a manager's review rather than a summary of peer feedback.

## Phase 1: Enrich Inputs

Add your personal observations directly to each person's review file under a new `## Manager Observations` section. Even rough bullets are fine — specificity matters more than polish.

## Phase 2: AI Synthesis

For each team member, have AI:

- **Find patterns across reviewers** — where do 3+ people say the same thing? Where do perspectives diverge?
- **Identify blind spots** — what do peers see that the person likely doesn't? What's conspicuously absent?
- **Connect strengths to growth areas** — e.g., high ownership as a strength may cause blunt communication as a side effect
- **Propose specific, actionable development recommendations** — not "improve communication" but "before sending Slack messages about blockers, re-read and soften directive language; consider switching to a call for anything that involves assigning blame"

## Phase 3: Draft the Review

Write your key messages first (even as rough notes), then have AI:

- Organize into a consistent structure across all reviews
- Ensure every claim cites specific evidence (project, reviewer, behavior)
- Flag any statement that lacks grounding with `[NEEDS EXAMPLE]` placeholders
- Match tone to your actual assessment — don't let AI be uniformly positive

## Phase 4: Calibration Pass

After drafting all reviews, have AI:

- Compare language intensity across reviews — are you harsher on some people for the same behavior?
- Check that similar performance levels get similar depth and tone
- Highlight where your feedback contradicts reviewer consensus (intentional or oversight?)

## Time Budget Per Person

| Step | Who | Time |
|------|-----|------|
| Add your own observations to the person's file | You | 5-10 min |
| AI synthesizes themes, contradictions, blind spots | AI | 2 min |
| Review synthesis, correct and add nuance | You | 5-10 min |
| AI drafts structured review with evidence citations | AI | 2 min |
| Edit for accuracy, add personal context, adjust tone | You | 10-15 min |
| **Total per person** | | **~25-35 min** |

## Watch-Outs

- **Don't skip your own input.** Without it, the review becomes a summary of what others said — not a manager's review.
- **Beware of AI softening critical feedback.** AI defaults to diplomatic hedging. For development areas, be direct — the person deserves clarity.
- **Don't let AI invent specifics.** If it names a project or metric you didn't provide, delete it.
- **Privacy.** Keep everything in local Claude sessions or the vault. Don't paste employee feedback into web-based AI tools.
