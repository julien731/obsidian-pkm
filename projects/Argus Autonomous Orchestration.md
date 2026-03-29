---
type: project
status: active
created: 2026-03-15
summary: Autonomous orchestration layer for Argus — centralized runner that polls for stories, dispatches parallel agent sessions, and manages the full spec-to-PR lifecycle with minimal human intervention
tags:
  - ai
  - framework
  - developer-tools
  - nimble
  - automation
related:
  - "[[projects/Argus]]"
  - "[[resources/Research - Autonomous Orchestration for Argus]]"
  - "[[resources/Research - Runner Deployment and Team Patterns for Argus]]"
  - "[[resources/cloudflare-dynamic-workers]]"
---

The autonomous orchestration layer sits on top of Argus to enable parallel, unattended feature execution. A long-running centralized runner polls the PM tool for stories in "Ready" status, dispatches isolated agent sessions per story, and manages each through a blueprint (state machine) from setup to PR — with human gates only at spec approval and PR review.

## Relationship to Argus

This is a **separate application** (`argus-runner`) in its own repo. Argus is the framework — prompt templates, spec formats, config files, Claude Code adapters — that lives inside each project repo (`.argus/` directory). The runner is a long-running daemon that *consumes* the Argus framework: it reads `.argus/` config, invokes the SE blueprint, and follows the spec format. Argus is the playbook, the runner is the player that executes it autonomously.

## Problem

Argus today requires a human operator to trigger each workflow phase. This limits throughput to one story at a time and requires constant attention. The research shows the industry has converged on a pattern — poll for work, dispatch to isolated environments, run agents with bounded concurrency, gate on human review at the end — that Argus can adopt.

## Core Architecture

### LLM-Agnostic Design

The runner mirrors Argus's philosophy: **Argus defines what to do, adapters define who does it, the runner sequences the work.** Most of the runner is LLM-agnostic — polling, worktree management, blueprint orchestration, deterministic steps (git ops, linting, CI, PR creation), status tracking, and notifications. The only LLM-specific part is a thin **agent adapter** that spawns an actual agent session.

The adapter interface: given a worktree, story context, and instruction, run an agent session and return the result. Each blueprint agent node calls the configured adapter rather than a specific tool.

| Layer | Examples | LLM-specific? |
|-------|----------|---------------|
| Orchestration | Poll loop, eligibility, dispatch, concurrency | No |
| Blueprint engine | State machine, step sequencing, retry logic | No |
| Deterministic nodes | Git ops, linters, CI wait, PR creation | No |
| Agent nodes | IMPLEMENT, REVIEW, FIX | Yes (via adapter) |

**v1 adapter:** Claude Code (spawned as child process via CLI). Future adapters could target Codex, Cursor CLI, or any headless agent runtime.

### Centralized Runner

A single cloud VM (4-8 vCPU, 16 GB RAM) running the orchestrator as a systemd service in its own repo (`argus-runner`). No containers, no Kubernetes, no CI integration required for v1.

**Components:**
- **Poll Loop** — Polls PM tool (GitHub Projects) every 30s for stories in "Ready" status
- **Story Eligibility Engine** — Checks status, dependencies, concurrency limits, priority
- **Worktree Manager** — Creates/cleans up git worktrees per story for isolation
- **Session Runner** — Executes the SE Blueprint per story via the configured agent adapter
- **Status Surface** — CLI-based observability (`argus status`)

### SE Blueprint (State Machine)

Interleaves deterministic and agentic nodes, adapted from Stripe's blueprint pattern:

1. **SETUP** (deterministic) — Create worktree, feature branch
2. **RESEARCH** (agent) — Analyze story, research approach
3. **PLAN** (agent) — Generate implementation plan
4. **IMPLEMENT** (agent) — Write code with atomic commits
5. **LOCAL VERIFY** (deterministic) — Run linters, type checks, unit tests
6. **FIX LOCAL ISSUES** (agent, conditional) — Fix failures, max 2 iterations
7. **REVIEW** (agent/architect) — Review against spec and conventions
8. **ADDRESS REVIEW** (agent, conditional) — Address feedback, max 1 iteration
9. **PUSH AND PR** (deterministic) — Push branch, create PR, link to issue
10. **CI** (deterministic) — Wait for CI
11. **FIX CI** (agent, conditional) — Fix CI failures, max 1 round
12. **QA** (agent) — Run Playwright tests, post confidence verdict
13. **COMPLETE** (deterministic) — Update story status to "In Review", notify

### Authentication

Split identity model:
- **Code operations** (commits, PRs) — GitHub App (auto-rotating tokens, no seat cost)
- **PM tool operations** (status changes, comments) — Per-user API tokens via encrypted token vault

### Concurrency

| Team Size | Concurrent Sessions |
|-----------|-------------------|
| 1-5 | 2-3 |
| 6-15 | 3-5 |
| 16-25 | 5-8 |
| 25+ | 8-12 |

Target: 5 concurrent sessions for a 20-person team, scaling to 8 based on review throughput. Estimated $50-150/day in API costs at 5 sessions.

## Cost Management

API costs scale linearly with team size and concurrency. Unmanaged, a 20-person team at 8 concurrent sessions could exceed $7,000/month. Cost control is a first-class design concern.

### Model Routing Per Blueprint Step

The adapter interface supports per-step model selection. Not every step needs a frontier model — simpler steps can route to cheaper models (including open models via Groq/Ollama), reserving expensive models for high-stakes work.

| Step | Complexity | Model Tier | Examples |
|------|-----------|------------|----------|
| RESEARCH | Low | Budget | Haiku, Llama via Groq |
| PLAN | Medium | Mid | Sonnet |
| IMPLEMENT | High | Frontier | Opus |
| FIX LOCAL ISSUES | Low | Budget | Haiku, Llama via Groq |
| REVIEW | Medium | Mid | Sonnet |
| ADDRESS REVIEW | Medium | Mid | Sonnet |
| FIX CI | Low-Medium | Budget/Mid | Haiku, Sonnet |
| QA | Medium | Mid | Sonnet |

Budget steps that only need basic tool use (read file, run command, apply fix) can be served by a lightweight agent wrapper calling any inference API, rather than requiring a full agent runtime like Claude Code.

### Other Cost Levers

- **Story size filtering** — Only dispatch S/M stories autonomously. L/XL stories ($30-80 each) stay manual.
- **Per-step token budgets** — Cap spend per blueprint step. Escalate early instead of letting agents spin.
- **Prompt caching** — Cache repeated context (spec format, conventions, codebase docs) to reduce input token costs.
- **Cost threshold gate** — Pause a story and notify if its cumulative cost exceeds a configured limit.
- **Team-level daily/weekly budget caps** — Orchestrator stops dispatching new stories when budget is exhausted.

## Team Interaction

- **Ownership signal** — GitHub App as assignee + `argus:in-progress` label
- **Handoff** — Status-based (move to "Ready" for AI, "Blocked" for human attention)
- **Review routing** — Story assignee first, CODEOWNERS fallback
- **Queue control** — All via PM tool (priority field, labels, status changes)
- **Escalation** — 2 failed attempts then hand to human, post structured comment, free the slot
- **Notifications** — GitHub-native for v1, Slack webhook for v2

## Human Gates

| Gate | Default |
|------|---------|
| Spec approval | Human required |
| Story approval | Human required |
| Implementation plan | Skipped (architect + QA catch issues downstream) |
| PR review | Human required |

## Build Plan

### Phase 1: Foundation
- Orchestrator poll loop against GitHub Projects
- Story eligibility engine (status, dependencies, concurrency)
- Worktree manager (create, clean up)
- Single-story blueprint execution (sequential, one at a time)

### Phase 2: Parallelization
- Concurrent blueprint execution across multiple worktrees
- Priority-based dispatch
- Resource monitoring and bounded concurrency

### Phase 3: Resilience
- Retry with exponential backoff
- Restart recovery from PM tool state (stateless orchestrator)
- Conflict detection and rebase strategy
- Failure escalation notifications

### Phase 4: Observability
- Structured logging of orchestrator decisions
- Per-story execution timeline
- Token usage tracking
- CLI status surface (`argus status`)

### Phase 5: Team Features
- Per-user token vault for PM tool attribution
- Slack notifications for failures/escalations
- Dashboard web UI
- Horizontal scaling with claim-based dispatch

## Key Design Principles

1. **PM tool is the control plane** — All queue management happens through the PM tool's native interface. No separate orchestrator UI needed.
2. **Crash-safe by design** — All durable state lives in the PM tool and git. The orchestrator can be killed and restarted at any time.
3. **Escalate fast** — 2 failed attempts then hand to human. Token cost of a stuck agent far exceeds the time cost of human intervention.
4. **Polling over webhooks** — 30s latency is irrelevant when agent runs take 15-60 minutes. Dramatically simpler to implement and debug.
5. **Git worktrees for isolation** — Adequate for individual projects at near-zero cost. Containers/VMs are a v2 concern.
