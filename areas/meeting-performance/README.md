# Meeting Performance Tracking System

Personal system for tracking my meeting performance over time, based on research into what actually drives meeting effectiveness.

## Core Principle

**A meeting is effective when it changes what people will do next — not just what they think.**

The same applies to my contribution: Did I change what will happen, or did I just participate? Participation feels productive. Changing outcomes IS productive. They're not the same thing.

## How It Works

1. Run meeting analysis in Meeting Transcriber with self-assessment enabled
2. Copy the "Your Contribution" section
3. Paste to Claude with: "Create a performance assessment note from this for [meeting name] on [date], type: [client/sales/internal/other]"
4. Claude generates a complete note with frontmatter
5. Save to `assessments/YYYY-MM-DD - Meeting Name.md`
6. Periodically share assessments with Claude for trend analysis and feedback

## Frontmatter Schema

```yaml
---
date: YYYY-MM-DD
meeting: "Meeting name"
type: client | sales | internal | other
talk_time: 28                    # percentage
questions: 4                     # total count
questions_clarifying: 2
questions_challenging: 1
questions_leading: 1
ideas_adopted: 1                 # count of my ideas that became decisions
progress_driver: true | false
hedging: 2                       # instances flagged
interruptions_by_me: 1
interruptions_of_me: 0
commitment_strength: strong | moderate | vague
listening: building | waiting    # built on others vs waited to speak
position_changed: true | false   # did I change my view based on discussion
tags:
  - meeting-assessment
---
```

## What the Metrics Mean

### Talk Time
Not just a number — context matters.

- **>40%**: Likely dominating. Unless I was the subject matter expert presenting, this is a warning sign.
- **15-35%**: Healthy range for most meetings.
- **<10%**: May be under-contributing, especially if I had relevant expertise.

**The trap:** High talk time feels productive but may indicate going in circles, asserting without persuading, or filling silence without adding value.

### Questions
Research (Gong, 326K calls): Winners ask 15-16 questions; losers ask 20. Interrogation-style backfires. Quality > quantity.

- **Clarifying questions**: Seeking to understand. Shows listening.
- **Challenging questions**: Testing assumptions. Drives rigor.
- **Leading questions**: Steering toward predetermined answer. Can be manipulative.

**What to watch:** Am I asking questions to understand, or to set up my rebuttal? Am I listening to the answers?

### Ideas Adopted
Did I introduce something that became a decision or action item? This is a concrete measure of influence.

**Note:** The quiet person whose single question changed the meeting's direction had more impact than someone who talked for 20 minutes without shifting anything.

### Progress Driver
Was I identified as someone who moved things forward? This means:
- Introduced ideas that were adopted
- Asked questions that unlocked stuck discussions
- Synthesized disparate points into actionable conclusions

**The insight:** This person may have spoken very little. Volume ≠ value.

### Hedging
Words like "might," "could," "perhaps," "sort of," "I think," "it seems."

Hedging indicates:
- Genuine uncertainty (fine)
- Lack of commitment (problem)
- Political positioning (worth examining)
- Deferred disagreement (I don't actually agree but won't say so)

**What to watch:** Do I hedge when disagreeing with senior people? That may indicate I'm not feeling safe to be direct, or I'm avoiding necessary conflict.

### Interruptions
Two directions matter:
- **By me**: Am I cutting people off? Especially watch if I interrupt the same people repeatedly, or interrupt junior people more than senior.
- **Of me**: Am I being interrupted? By whom? This reveals power dynamics.

### Commitment Strength
44% of meeting action items are never completed. Vague commitments are a leading cause.

- **Strong**: "I will deliver X by Friday" — clear verb, owner, deadline
- **Moderate**: "I'll look into that this week" — owner, rough timeline, vague deliverable
- **Vague**: "We should explore this" — no owner, no timeline

**"We" commitments with no individual accountability = no one is accountable.**

### Listening
- **Building**: I referenced others' points, built on their ideas, explicitly acknowledged what they said.
- **Waiting**: I was formulating my response while they talked, then pivoted to my pre-planned point.

**Honest test:** Can I accurately summarize the other person's position (not a strawman)?

### Position Changed
Did I actually change my thinking based on what someone said?

If the answer is never "yes" across many meetings, I'm either always right (unlikely) or not actually open to influence (problem).

## Self-Assessment Dimensions

When reviewing my contribution, consider:

### 1. Signal vs. Noise
Did I move things forward, or add noise?
- Introduced an idea that was adopted?
- Asked a question that unlocked something?
- Synthesized scattered points into clarity?
- Or: restated what others said, filled silence, repeated my position?

### 2. Elicitor vs. Dominator
Research: The "elicitor" role (drawing out others) correlates most strongly with satisfaction AND productivity. The "central actor" role (dominating) correlates negatively with team performance.

- Did I draw out perspectives from quieter people?
- Did I build on others' ideas, or compete with them?

### 3. Rhetorical Patterns
- **Building a case**: Evidence → reasoning → conclusion
- **Assertion**: Repeating a position (possibly louder)
- **Persistence**: "Winning" by not giving up rather than by persuading

If I won an argument, did I persuade or just persist?

### 4. Psychological Safety Contribution
Did my presence make the room safer or less safe for others to speak?
- Did I react well when someone disagreed with me?
- Did I admit uncertainty or mistakes?
- Did I interrupt or talk over?

### 5. Directness
Did I say what I actually thought, or hedge?
- "I think maybe we could possibly consider..." when I meant "We should..."
- Stayed silent and complained later
- Gave comfortable feedback instead of honest feedback

## Anti-Patterns to Watch

### The Explainer
Restating what others said in different words. Feels like contributing. Adds nothing.
*Catch phrase: "So what you're saying is..." followed by exactly what they said.*

### The Devil's Advocate Addict
Constantly poking holes without offering alternatives. Slows everything down.
*Catch phrase: "But what about..." without ever saying "Here's what I'd suggest..."*

### The Loudest Voice
Equating volume and repetition with being right. Winning through persistence, not persuasion.
*Catch phrase: [Same point, third time, louder]*

### The Vague Committer
Agreeing to things without specificity. Creates illusion of progress.
*Catch phrase: "Yeah, I can look into that."*

### The Silent Critic
Staying quiet in the meeting, criticizing the decisions afterward.
*Catch phrase: [In meeting: silence] [After: "I never thought that was a good idea"]*

### The Multitasker
Physically present, mentally absent. Asks questions that were already answered.
*Catch phrase: "Sorry, can you repeat that?"*

### The Premature Anchorer
States preference early, group converges around it. Shuts down exploration.
*Research: When members express preferences at the start, groups are less likely to uncover hidden information.*

## Benchmarks

| Metric | Target | Why |
|--------|--------|-----|
| talk_time | 15-35% | Not dominating, not silent |
| questions | 2-5 quality | Quality > quantity |
| ideas_adopted | ≥1 | Actually influencing outcomes |
| progress_driver | true | Changing what happens next |
| hedging | 0-1 | Direct when it matters |
| commitment_strength | strong | Clarity enables follow-through |
| listening | building | Genuine engagement |
| position_changed | sometimes true | Open to influence |

## Trend Review

To get feedback on patterns over time, share this README plus recent assessments with Claude:

```
Review my meeting performance assessments from the past [period].
Based on the system documented in the README, give me feedback on:

1. Trends in my metrics — what's improving, what's stuck, what's declining?
2. Recurring patterns — both strengths and issues
3. Am I becoming more effective, or just more comfortable?
4. Specific, actionable focus areas for the next month
5. Evidence of actual impact — meetings where I demonstrably changed outcomes
```

## The Uncomfortable Truth

Most people overestimate their contribution to meetings.

Research on anonymous input: Normal meetings surface 50-90 opinions; anonymous input surfaces 130-190. **Half of what people think stays hidden.**

The question isn't just "Did I speak?" but:
- Did I say the thing that needed to be said?
- Did I stay silent when I should have spoken?
- Did I speak when I should have listened?

## Note Structure

Each assessment note contains:
1. **Frontmatter** — Structured metrics for trend analysis
2. **Analysis Output** — Full "Your Contribution" section from Meeting Transcriber
3. **Personal Reflection** — What I noticed, what worked, what to change
