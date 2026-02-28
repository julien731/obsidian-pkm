---
type: project
status: active
created: 2026-02-23
summary: Spec-driven Nimble AI Product Engine — an LLM-agnostic framework for structured AI-assisted development
tags:
  - ai
  - framework
  - developer-tools
  - nimble
related:
  - "[[inbox/SNAIPE - Spec-driven Nimble AI Product Engine]]"
  - "[[inbox/GSD Feedback]]"
---
SNAIPE (Spec-driven Nimble AI Product Engine) is a framework for structured AI-assisted development, inspired by [GSD](https://github.com/glittercowboy/get-shit-done). It encodes Nimble's existing product rigor (user stories, acceptance criteria, SA docs) into an AI workflow that works across LLMs and tools.

## Problem

AI coding assistants produce inconsistent results when working from vague prompts. Context degrades over long sessions. Ad-hoc work goes untracked. Existing frameworks like GSD solve some of this but are tightly coupled to specific tools (Claude Code) and don't follow team conventions (Gitflow, testing, commit standards).

## Design Principles

1. **Spec-driven** — AI works from structured specifications, not freeform prompts. The workflow: describe idea, generate detailed spec, AI builds against spec, verify against spec.
2. **LLM-agnostic** — The framework's value lives in spec files and prompt templates, not in any specific LLM or tool's capabilities.
3. **Nimble-native** — Encodes Nimble's existing practices (user stories, acceptance criteria, phased delivery) rather than inventing new ones.
4. **Configurable conventions** — Commit formats, branching strategy (Gitflow), and test expectations are configurable, not hardcoded.

## Architecture

SNAIPE is built on three layers:

### 1. Spec Format (LLM-agnostic)

A defined set of markdown files with conventions for how requirements, plans, and verification criteria are structured. This is the core of the framework. Any LLM can read these files and understand what to build.

Incorporates [agents.md](https://agents.md/) as the repo-level configuration layer ("how to work here"), with SNAIPE spec files on top as the workflow layer ("what to build and in what order").

### 2. Prompt Templates (LLM-agnostic)

Role-specific prompts for each workflow phase:
- **Researcher** — Investigates ecosystem, patterns, and constraints
- **Planner** — Breaks work into tasks with dependencies and verification criteria
- **Executor** — Implements against plan with atomic commits
- **Verifier** — Checks implementation against specs, including test generation

Written in plain language. Not tied to any tool's API or calling convention.

### 3. Tool Adapters (tool-specific)

Thin wrappers that map SNAIPE's workflow into each tool's native mechanism:
- **Claude Code** — Slash commands and agent orchestration (first adapter)
- **Cursor** — `.cursorrules` + context files
- **Copilot** — Instruction files
- **Generic** — Manual prompt template usage

Switching LLMs or tools only requires a new adapter. Specs and prompts carry over.

## Workflow Phases

Adapted from GSD, with Nimble-specific additions:

1. **Discuss** — Capture requirements and design decisions
2. **Plan** — Research + task breakdown + dependency analysis
3. **Execute** — Implementation with atomic commits following configured conventions
4. **Verify** — Automated checks + test generation + spec compliance
5. **Complete** — Docs update, milestone tracking

## Improvements Over GSD

| GSD Pain Point | SNAIPE Approach |
|---|---|
| Hardcoded commit prefixes, no Gitflow | Configurable commit conventions and branching strategy |
| No test writing in workflow | Verification phase includes test generation |
| Docs drift after execution | Spec files update as a side effect of execution |
| Ad-hoc work untracked | Lightweight capture mechanism that feeds back into specs |
| Claude Code-specific | LLM-agnostic spec format with tool-specific adapters |

## Build Plan

### Phase 1: Spec Format Design
Define the file structure, naming conventions, and content format for all spec files. This is the foundation — everything else builds on it.
- Define project-level files (requirements, roadmap, state)
- Define phase-level files (context, research, plan, verification)
- Define how Nimble concepts (user stories, AC) map into the format
- Define `AGENTS.md` integration points
- Define configuration format (commit style, branching, test expectations)

### Phase 2: Prompt Templates
Write the role-specific prompts that drive each workflow phase.
- Researcher prompt template
- Planner prompt template
- Executor prompt template
- Verifier prompt template
- Define how prompts reference and update spec files

### Phase 3: Claude Code Adapter
Build the first tool integration since this is the current daily driver.
- Slash commands for each workflow phase
- Agent orchestration mapping
- Git integration with configurable conventions

### Phase 4: Validation
Test the full workflow on a real Nimble project.
- Run end-to-end on an active project
- Collect feedback from team usage
- Iterate on spec format and prompts

### Phase 5: Additional Adapters
Expand to other tools as needed.
- Cursor adapter
- Copilot adapter
- Documentation for generic/manual usage
