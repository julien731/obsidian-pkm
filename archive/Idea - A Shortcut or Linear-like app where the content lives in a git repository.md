---
type: resource
status: active
created: 2026-01-16
summary: Product idea for a Linear-like project management app where all content (modules, features, stories) lives in a git repository as Markdown files, enabling full LLM context access.
tags:
  - product-idea
  - tooling
  - ai
  - project-management
---

A product concept for a project management tool inspired by Linear, but with content stored in a git repository. This would give LLMs full context (codebase, docs, stories) while providing PMs with a pleasant interface for managing work.

# Conclusion

Not worth it. It's gonna be very difficult to manage with Gitflow and the PR review process. The gains would be marginal and the overhead would be high.

## Core Concept

- Full context for LLM: codebase, docs, stories
- Still an interface for PMs to work from that's more pleasant
- North star: Linear

## What users can do
	- Create modules
	- Create Features (a feature belongs to a module)
	- Create user stories (a story belongs to a feature)
	- Assign stories to people
	- View in Kanban view
		- Filter by module and feature
	- Move stories and features across states
- We could use Markdown with Frontmatter for managing relationships, status, metadata