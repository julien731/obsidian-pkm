# Team Performance Analytics Framework

Personal framework for analyzing team and relationship health across multiple meetings. This is longitudinal analysis — patterns that emerge over time, not single-meeting snapshots.

## Purpose

Meeting analysis tells you what happened in ONE meeting. Team performance analytics tells you:
- How is this team/relationship functioning over time?
- What patterns are emerging?
- Where should I intervene or coach?
- Are things improving or declining?

## What to Track Per Meeting

After each meeting analysis, extract and log:

### Participation Metrics
- [ ] Talk-time distribution (approximate %)
- [ ] Who exceeded 40% threshold?
- [ ] Who was notably silent?
- [ ] Question count by participant

### Contribution Quality
- [ ] Who drove progress? (introduced adopted ideas, unlocked discussions)
- [ ] Who filled airtime without adding value?
- [ ] Airtime/impact mismatches noted

### Decision Dynamics
- [ ] Number of decisions made
- [ ] Decision yield vs. meeting length
- [ ] Any rapid convergence without dissent?
- [ ] Were unique perspectives explored?

### Psychological Safety Indicators
- [ ] Did junior people speak up?
- [ ] Was dissent expressed openly?
- [ ] Hedging language when disagreeing upward?
- [ ] Questions asked vs. statements made

### Commitment Quality
- [ ] Action items with clear owners + deadlines
- [ ] Vague commitments ("we should explore")
- [ ] Follow-up on previous action items (completed?)

### Issues Flagged
- [ ] Confusions or misunderstandings
- [ ] Hidden disagreements suspected
- [ ] Unresolved items carried forward
- [ ] Intent vs. words mismatches

## Longitudinal Patterns to Watch

### Psychological Safety Trend
Track across 5+ meetings with same team:
- Is silence from specific people consistent?
- Do the same people always defer to the same others?
- Are mistakes/problems being raised more or less openly over time?

**Red flag pattern:** Junior person X has spoken <10% in last 5 meetings despite having relevant domain expertise.

### Decision Quality Trend
- Are decisions sticking, or being revisited in subsequent meetings?
- Is decision yield improving or declining?
- Are the same blockers recurring?

**Red flag pattern:** Topic Y has been "decided" in 3 separate meetings but keeps returning.

### Commitment Follow-Through
- What % of action items from Meeting N are completed by Meeting N+1?
- Who consistently delivers? Who doesn't?
- Are deadlines being met or slipping?

**Red flag pattern:** Person Z has had 8 action items across 4 meetings; 2 completed.

### Power Dynamics
- Who dominates consistently?
- Who elicits others consistently?
- Is centralization increasing or decreasing?
- Do the same people always "win" disagreements?

**Red flag pattern:** All decisions in last 6 meetings aligned with Person A's initial position.

### Relationship Health (Client/Stakeholder)
- Is client sentiment improving or declining?
- Are the same concerns being raised repeatedly?
- Is trust building or eroding?

**Red flag pattern:** Client has mentioned timeline concerns in 4 consecutive meetings with increasing frustration signals.

## Meeting Series Template

For tracking a specific team or client relationship:

```markdown
## [Team/Client Name] Meeting Series

### Overview
- Meeting cadence: [weekly/biweekly/etc.]
- Key participants: [names and roles]
- Relationship start: [date]
- Current health: [🟢 healthy / 🟡 watch / 🔴 concern]

### Pattern Log

#### Psychological Safety
- [Date]: [Observation]
- [Date]: [Observation]
- **Trend:** [improving/stable/declining]

#### Decision Effectiveness
- [Date]: [X decisions, Y yield]
- [Date]: [X decisions, Y yield]
- **Trend:** [improving/stable/declining]

#### Recurring Issues
- [Issue]: First raised [date], still unresolved as of [date]
- [Issue]: Raised [N] times across [M] meetings

#### Action Item Completion
- Meeting [date]: [X/Y completed]
- Meeting [date]: [X/Y completed]
- **Average completion rate:** [%]

### Intervention Notes
- [Date]: [What I did and why]
- [Date]: [Result observed]
```

## Analysis Prompts

Questions to ask yourself periodically:

### After Every Meeting
1. Did anything surprise me about participation patterns?
2. Were there moments of unusual silence or hedging?
3. Did we actually decide things, or just discuss?
4. What's the ONE thing I should watch in the next meeting?

### Monthly Review
1. What patterns have emerged across this month's meetings?
2. Is this team/relationship healthier than last month?
3. Who might need coaching or support?
4. What intervention should I try?

### Quarterly Review
1. Which teams/relationships improved most? Why?
2. Which declined? What did I miss?
3. Are there systemic issues across multiple teams?
4. What have I learned about effective meetings?

## Intervention Playbook

### Low Psychological Safety Detected
- Try: Explicitly invite quiet participants ("X, you have experience with this — what's your take?")
- Try: Use anonymous input for contentious topics
- Try: Share your own uncertainty first to model vulnerability
- Try: Private 1:1 to understand what's blocking them

### Rapid Convergence / Groupthink Risk
- Try: Assign devil's advocate role
- Try: "What would have to be true for the opposite to be right?"
- Try: Silent brainstorming before discussion
- Try: Explicitly ask "What are we missing?"

### Low Decision Yield
- Try: Start meeting with "We will decide X, Y, Z today"
- Try: Timebox discussion, force decision at end
- Try: "We have the information we need — let's decide"
- Try: Identify what data is actually blocking and get it before next meeting

### Poor Action Item Follow-Through
- Try: Review previous action items at start of every meeting
- Try: Public commitment with specific deadline
- Try: Smaller, more concrete action items
- Try: Direct conversation about pattern

### Dominant Speaker Problem
- Try: Round-robin input on key questions
- Try: "Let's hear from people who haven't spoken yet"
- Try: Time limits per speaker
- Try: Private feedback on pattern

## Integration with Meeting Transcriber

After using the Meeting Transcriber app:
1. Review the Internal Analysis output
2. Extract relevant metrics into this framework
3. Update the Meeting Series log for that team/client
4. Note any patterns emerging
5. Plan any interventions for next meeting

## Tags
#team-performance #meetings #framework #longitudinal-analysis
