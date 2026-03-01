---
type: resource
created: 2026-03-01
tags:
  - ai
  - framework
  - developer-tools
  - nimble
  - brainstorm
related:
  - "[[projects/Argus]]"
source: inbox
---

## Brainstorm Notes

### What is this?

Creating a Nimble-specific framework inspired by [get-shit-done](https://github.com/glittercowboy/get-shit-done) — a spec-driven development system for Claude Code that solves context rot through structured phases and multi-agent orchestration.

### Chosen name direction

**SNAIPE** — Spec-driven Nimble AI Product Engine

### What "spec-driven" means

The AI works from structured specifications (requirements, architecture, acceptance criteria) rather than freestyling from vague prompts. The workflow: **describe idea → generate detailed spec → AI builds against spec → verify against spec**. This is what makes AI-assisted development reliable vs chaotic.

### GSD's core concepts to adapt

- **Context engineering** — structured files (PROJECT.md, REQUIREMENTS.md, ROADMAP.md, PLAN.md) that give AI everything it needs
- **Multi-agent orchestration** — thin orchestrator spawns specialized agents (researcher, planner, executor, verifier)
- **Fresh context per task** — prevents quality degradation as context window fills
- **Atomic commits** — one commit per task, clean git history
- **Phased workflow** — discuss → plan → execute → verify → complete

### Why this fits Nimble

Nimble already works with structured specs (user stories, acceptance criteria, SA docs). SNAIPE encodes that existing rigor into an AI workflow rather than letting Claude wing it.

### Next steps

- Review GSD repo structure in detail
- Define Nimble-specific phases and artifacts
- Build with Claude Code
