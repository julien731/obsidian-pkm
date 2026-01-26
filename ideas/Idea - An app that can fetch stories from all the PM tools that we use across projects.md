---
type: idea
created: 2026-01-26
status: active
category: product-tool
summary: Unified kanban dashboard that aggregates tasks from Jira, Shortcut, and Linear across all projects.
tags:
  - nimble
  - productivity
  - project-management
  - tooling
---

# Unified PM Dashboard

An internal tool idea to aggregate and manage tasks from multiple project management platforms in a single kanban view.

## Why

One of the primary challenges at work is to keep track of each and every project. One of the things that makes it difficult or, at least, time-consuming, is that we have to use different tools: JIRA, Shortcut, Linear...

## Acceptance Criteria

- I need a "dashboard" kanban that can pull from multiple projects on multiple platforms:
	- Jira
	- Shortcut
	- Linear
- All the tasks show up in my kanban and I can filter them by project.
- I should be able to map tasks' status to ensure consistent display regardless of the workflow for a given project.
- I should be able to see comments and comment on tasks.
	- When I comment, my comment appears from my user on the correct platform.
- For the UI, I want to use Tailwind. We can use a pre-built theme for speed but needs to be assessed.
