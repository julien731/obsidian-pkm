---
type: resource
migrated_from: notion
migrated_at: 2026-01-12
created: 2025-02-19
tags:
  - interview
---

# Interview: Rene Schneider

- Tell me more about the size of the projects and teams you’ve managed recently. How many devs? What kind of traffic?
    - Teams
        - Fashion Code: from the ground up. 15 people, 6 IT.
        - Largest team: 40 direct reports.
    - Projects
        - GoCancel: 10k users per day.
        - E-commerce: 3k users per minute.
- Infrastructure expertise. How do you balance cost vs. setup complexity? How do you optimize costs?
    - Start small.
    - Cost optimizations: talked about auto-scaling mostly.
    - Follow-up questions:
        - CI optimizations. From 30 mins to 7 mins.
        - Moved to fully managed ES.
        - 4k → 1.5k on one of the projects
            - Lots of unnecessary machines running. That was because the system was slow. Software optimizations to reduce the need for hardware.
    - Managing infra: it depends.
        - Beanstalk.
        - Doesn’t seem familiar with IaC.
        - Talked about auto-scaling, Kubernetes.
        - Playing with Kamal now. Used in the challenge.
- How do you handle conflictual situations?
    - Source of the conflict?
    - Easy if it’s a technical conflict. Can be based on facts.
    - Personal, more difficult. Performance issues, does the person need some time off?
- Tell me about some difficult cases you’ve faced regarding developers’ performance.
    - Developer started taking an enormous amount of time to do anything.
    - Dev was saying everything’s ok and he’s not doing so bad.
    - “We feel like you’re not performing. Let’s see how you do this week and talk again next week.”
    - Next meeting he brought some data. Highlighted the positive in the past and put it in parallel with recent (under)performance.
        - Based on Jira tickets. Looking at the “kind of work” done in the tickets.
        - Dev got defensive. Excuses.
    - Dev was not opening up.
    - Performance did not improve. They had to let him go.
- Ownership of situations, e.g. downtime, critical bugs, direction when CEO is not present.
    - Lead by example.
    - E.g., lost 1st hour of a Black Friday because auto-scaling did not trigger.
    - Stayed until 5am to fix everything.
    - While the day may end at 5, there can be times where more is needed. Needs to be able to count on the team in those situations.
    - It’s not just about the company. It’s also about helping your colleagues. Be there for the team. Be part of the team.
- What’s your initial reaction if a PM comes to you saying that things are moving too slow on a project?
    - What’s the expected pace/progress?
    - E.g., almost 2 months in, almost nothing to show.
        - Maybe it’s a communication issue.
        - Wrong priorities?
- Process vs action bias
    - Did not ask. He doesn’t have processes.
- When something actually went wrong, how do you handle the situation? E.g., Flexi.
    - Sometimes it’s just a problem of expectations. Need to talk with the team, with the client.
    - Sit down with the client and ask them “how can we improve the delivery for you?”
    - Do we really have this issue? Try to figure out what happens. Find the root cause for the delays.
- What’s your approach to mentoring and developing the team?
    - Have everyone on the same page. Meeting with everyone. At least once a week.
    - Understand what the people want. Leadership? IC?
    - Align with where the company is going.
    - Team-building activities.
    - E-learning platform.
- CTO at Fashion Code:
    
    > I participated in the creation of the technology sector of the company that before me had already been through 3 other people who could not implement the necessary technology in a sustainable way for the future of the company.
    > 
    
    Why?
    
    - He’s practical and likes to do simple things.
    - Other people talk about fancy stuff but don’t actually do things.
    - He made a plan before joining.
        - Hire a team.
        - Setup initial LP. Start capturing leads.
        - Start working on internal system.
        - Integrate the pieces together.
        - Small wins.

# Notes

## TL;DR

He’s got a good attitude and displays a getting-things-done mindset. With his experience, he can probably be a strong technical lead, but he’s not CTO level. At least not in a service company.

- Presentation
    - Very casual. T-shirt.
    - I don’t see him “stakeholder-ready.”
- Leadership
    - He doesn’t seem comfortable on leadership topics.
    - Doesn’t seem to have real experience organizing, mentoring, and developing a team.
    - No method to mentor and develop the team.
    - He might be good at building and delivering 1 project but he doesn’t seem to know how to handle multiple projects, especially in cases where something doesn’t go well on a project.
- Tech
    - He doesn’t seem very strong in infrastructure. At least it did not transpire during the interview.
    - He doesn’t seem critical enough when things don’t seem to go well. Overall, I think he’s mostly used to things going according to plan with the unavoidable problem here and downtime there.