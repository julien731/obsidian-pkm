---
type: resource
migrated_from: notion
migrated_at: 2026-01-12
created: 2025-07-29
tags:
  - interview
---

# Loic Farge’s Interview

# 1. Technical Depth & Execution Standards

- Tell me about a time you reviewed a project and decided to intervene. What triggered you? What did you do?

Answer:

- Closed-scope and T&M models
- Usually a Project Manager per project
- PM or client sometimes pings him when velocity problems
- He seems product minded

- What’s your personal bar for good code? How do you ensure your teams meet it — without blocking them?

Answer:

- Follow the documentation of the framework you’re using
- Setup linters at the start of the project
- Static code analysis
- Separation of concerns (UI/backend)
- Proper validation everywhere
- Fail fast; throw exceptions
- Unit test functions
- No console logs
- No comments; code should be self-explanatory
- Use interfaces; easier to write unit tests

- You mentioned in your challenge that you’re usually the first to enforce consistency. What are your non-negotiables when reviewing code? What would you never allow into main?

Answer:

- Depends on the context. Does the project need to be maintainable?
- Your function does only one thing.
- Security; validation.

## What to listen for:

- They get into specifics: code smells, anti-patterns, refactoring, observability, etc.
- They are comfortable jumping into complex issues, not just delegating.
- They talk about balancing velocity and quality realistically.

# 2. Proactive Technical Leadership

- How do you know a project is veering off course before anyone tells you?

Answer:

- Usually more on internal projects.
- Did not identify a problem early enough. Healthcare product.
- Monolith PHP app. Hard to maintain. Proposed a micro-service architecture with kafka.
- Came a point when they had to upgrade all the services. Client was unhappy because they were paying for nothing to be delivered.

## What to listen for:

- Signals they track: failing builds, flaky tests, velocity drops, missed edge cases, etc.
- Tools they use: are you using any developers analytics platform (e.g., LinearB)?
- They inspect what’s happening, not just rely on status reports.

# 3. People & Manager of Managers

- When one of your managers is too soft on quality, how do you address it?

Answer:

- Train the person, maybe assign a mentor. Work together.
- If they don’t get better might have to let them go.
- How to identify:
    - Project Managers reports on some performance KPIs.
    - Client asks for him to join a meeting.
    - Standups.
    - Peer feedback.
    - Be in the office. Look & listen, be available.
- Hear from clients.

Follow-up: what do you do if they project went haywire?

- Replace the person that’s not performing.
- Avoid adding more resources.
- **After pushing him even harder,** he said he has, in the past, jumped in for small tasks that don’t take much time.
    - Usually never do it on purpose. Wants the team to learn.
    - Let the team make mistakes and learn.

## What to listen for:

- Strong accountability culture with psychological safety.
- Comfort giving direct feedback to managers.
- Awareness of team signals: morale, retention, blind spots.

# 4. Pragmatism & Bias for Action

- Tell me about a time when you had to cut technical corners. How did you decide where and how to do it?

Answer:

- Always discuss with the client first of all.
- Suggest different prioritization.
- It’s important to be consistent with the team.

- In the challenge, what would you have improved if you had 2 more hours? What if you had 10 more?

Answer:

- Did not ask. Did not find it relevant.

## What to listen for:

- Clear thinking about tradeoffs.
- Comfort making decisions with partial information.
- Not dogmatic — values momentum.

# 5. Wrap-Up and Role Reflection

- What attracts you to this role specifically?

Answer:

- Now: Tech Lead, Manager, recruitment, and other things. Scope is far too large.
- Wants to refocus on the technical part. Building solutions for clients. Training people.
- Human interactions with people, the team.