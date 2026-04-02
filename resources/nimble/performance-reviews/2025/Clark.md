---
type: resource
created: 2026-03-10
summary: "360 feedback review for Clark from the 2025 review cycle"
tags:
  - performance-review
  - nimble
related:
  - "[[people/Clark]]"
---

# 360 Review: Clark (2025)

## Summary

**Strengths:**
- Strong ownership and accountability (4 reviewers) — takes responsibility, follows through on commitments, drives tasks to completion
- Clear communication and stakeholder management (4) — communicates comprehensively, handles scope changes calmly, balances business expectations with technical constraints
- Proactive edge case identification (2) — surfaces potential issues early in development, coordinates across teams and vendors
- Fast ramp-up (2) — caught up with the project quickly, understood complex flows within weeks
- Approachable and supportive (3) — responsive to questions, professional, easy to work with

**Areas for improvement:**
- Pushing back on clients (1) — tends to be soft on pushback compared to more senior PMs; improving but still developing
- QA thoroughness (1) — testing sometimes focused on happy paths, missing edge cases and cross-platform behavior
- Self-initiative on improvements (1) — could proactively identify and apply improvements from other teams without being prompted
- Ticket updates after discussions (1) — sometimes forgets to update tickets when solutions change
- More visual communication (1) — could use flowcharts, sequence diagrams for complex features
- Strategic and discovery thinking (1) — could strengthen ability to independently drive discovery and challenge assumptions

## What Went Well

### From Prajna Vira

In situations where the project requires clear requirements, updates, and alignment across multiple stakeholders, Clark demonstrated strong execution, ownership, and cross-functional leadership. He effectively managed backlog priorities, prepared structured documentation, and escalated risks early to ensure smooth delivery. By proactively aligning with stakeholders and clearly communicating trade-offs, he minimized disruptions and maintained team focus. Clark consistently leveraged data to inform decisions, helping ground discussions in evidence rather than assumptions. As a result, features were delivered predictably, stakeholder trust increased, and working with him was always easy and fun.

### From Mike

- Demonstrated a much stronger understanding of the CBTL project compared to the previous period, which enabled him to effectively drive discussions on Slack and during sprint planning meetings.
- Was very active and supportive in clarifying requirements. Most raised issues were handled with clear, helpful, and timely feedback, enabling the development team to execute tasks efficiently.
- Proactively reached out to more experienced team members to deepen his understanding of the project and technical topics, rather than passively waiting for guidance or handling requirements at a surface level.
- Communicated clearly and comprehensively, which greatly supported team discussions and ticket creation, helping developers better understand requirements.

### From Zaw Myo Naing

- He ensures that tickets and tasks are ready before the sprint planning meeting, which helps the team plan effectively.
- He does timely QA on tickets marked as “Ready for QA,” allowing issues or necessary changes to surface early.
- He is approachable and professional, which makes him easy to work with.

### From Captain

He's catching up with the project so fast after joining. And spent only a few weeks to understand complicated flows and logics. Then, work like he has been here since the kickoff.

His communication skills with clients and third parties also help us to get the appropriate approach when there is a limitation from third-party systems and get the clear picture when working on complicated features.

### From Quang Pham

- Handles stakeholder requests and scope changes calmly and professionally: Instead of blindly accepting incoming requests, he consistently evaluates the scope and explores solutions that achieve the desired outcome while minimizing implementation effort for the team.
- Balances business expectations with technical constraints effectively. He proactively engages the engineering team early to validate feasibility and obtain rough estimations as soon as sufficient information is available. He also brings design into the discussion at the right time, ensuring alignment across product, technical, and UX considerations before commitments are made.
- Demonstrates strong ownership and accountability. He consistently takes responsibility for his work, follows through on commitments, and ensures that tasks and decisions are driven to completion. He remains actively involved in resolving issues and does not rely on others to push progress.
- Supports the team with timely decisions and clarifications, consistently responding to questions and resolving ambiguities with a great attitude. His approachability and responsiveness help the team maintain momentum and work efficiently.

### From Su T.

Clark has demonstrated strong product ownership and cross-functional leadership, particularly through his work on two major epics: [Phone OTP Verification](https://jfc-dcd.atlassian.net/browse/CBTL-3254) and [JPOS Integration](https://jfc-dcd.atlassian.net/browse/CBTL-3217).

Indeed, he consistently identified edge cases and potential user experience issues early in the development process. For the OTP verification flow, he surfaced scenarios such as users getting stuck on the rate-limit screen when re-entering the same phone number, timezone mismatches affecting countdown displays, and timing issues with SessionM's welcome voucher triggering before phone verification. By raising these concerns proactively, he helped the team address problems before they reached production.

On the one hand, Clark worked closely with engineering to navigate technical constraints and align on feasible solutions. When faced with SessionM API limitations for filtering point history, he collaborated with the team to reprioritize and later proposed an updated requirement that the existing endpoints could support. He also coordinated with mobile developers to ensure client-side and server-side handling were aligned, particularly around OTP session management and error handling.

On the other hand, he showed strong ownership by managing dependencies across teams and external vendors. He followed up with Sinch to resolve SMS delivery issues for Vietnamese and Thai phone numbers, coordinated SIM card procurement for testing, and tracked how changes impacted related stories across the backlog. He consistently created and updated tickets to keep the team aligned.

Clark demonstrated openness to input from the team. When his proposed solutions were challenged (for the timezone edge case, etc), he acknowledged the feedback and adjusted his approach. This willingness to adapt helped maintain team trust and kept discussions productive.

## What Could Be Better

### From Prajna Vira

There are opportunities for Clark to deepen his customer-centric thinking and strategic framing. While he executes well within defined directions, he could further strengthen his ability to independently drive discovery, challenge assumptions, and articulate problem statements with greater depth before moving into solutions. In product roadmap, he can linking initiatives to the long-term vision and business impact would clarify prioritization. Hence, Clark can shift from effective implementation to taking greater responsibility for the overall product strategy.

### From Mike

- Compared to Got, he tends to be softer in pushing back and often follows the CBTL client’s unusual expectations until prompted by the TL to push back (e.g., https://nimble-co.slack.com/archives/C05QPD953SL/p1770120944324719?thread_ts=1770117031.583089&cid=C05QPD953SL). This has shown improvement toward the end of this 2026 period with more push-backs, but still requires further development.

-  During the ticket verification phase (Ready to QA → Completed), there were instances where his attention to detail could have been stronger. Testing appeared focused mainly on happy paths, with limited validation of edge cases or cross‑platform behavior. As a result, some edge cases were missed (e.g., https://nimble-co.slack.com/archives/C05QPD953SL/p1769658376187499, https://nimble-co.slack.com/archives/C05QPD953SL/p1768463818464139), or platform misalignments were later raised by TLs (e.g., https://nimble-co.slack.com/archives/C05QPD953SL/p1770279317090019, https://nimble-co.slack.com/archives/C05QPD953SL/p1770200717810689). While developers are primarily responsible for output quality, he could strengthen his role as a gatekeeper to ensure higher overall product quality.

- He could demonstrate more self‑initiative in driving improvements to CBTL project decisions and directions. For example, in the recent production statistics report integration with Slack coming from him (e.g., https://docs.google.com/spreadsheets/d/1L_pqbrAFL9MOG_neTsHFVHibx0EkeiZVYtwgOaOhUGk/edit), I was actually the one who suggested to him the idea of aligning with the JB team’s approach and setting up a similar solution for the CBTL team. He could recognize such improvements and apply them to the project more on his own.

### From Zaw Myo Naing

- We have only worked together for a short period of time so far, and everything has been going well. I don’t have any improvement points at this time.

### From Captain

He is usually planning the next sprint in advance.
But sometimes, there will be a priority ticket that still needs confirmation from the third party after that sprint has started.

I think we can improve it by prioritizing the ticket that needs confirmation from a third party first. And giving them more time by sending questions a bit earlier before the previous sprint ends.

### From Quang Pham

Sometimes he forgets to update the ticket after team discussions, especially when the solution changes.

### From Su T.

Clark could enhance his communication by incorporating more visual diagrams— such as flowcharts, sequence diagrams, or state diagrams—when presenting complex features or issues.

When translating requirements from stakeholders to the engineering team, there is room for Clark to be more structured and explicit. At times, context or constraints from stakeholder discussions may not be fully captured in tickets or Slack threads, leading to assumptions or follow-up questions. A consistent format for documenting requirements—covering the "why" behind decisions, acceptance criteria, and known constraints—would help the team move faster with fewer ambiguities.
### From Julien (me)
- You need to plan proactively for everything. E.g., the JPOS pilot rollout. I should not have had to ask all those questions. You should have prepared it all on your own, even if it's not entirely our responsibility. If we're involved, we need to ensure things will work out smoothly.
- You need to better identify important/dangerous situations. E.g., the CBTL order confirmation email. If they received something from the government, it's a strong signal that we need to be extremely careful with how we're handling it.
