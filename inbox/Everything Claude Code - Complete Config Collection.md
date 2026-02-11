---
type: repository
status: active
summary: Complete Claude Code configuration collection from an Anthropic hackathon winner. Production-ready agents, skills, hooks, commands, rules, and MCP configurations evolved over 10+ months of intensive daily use building real products.
tags:
  - claude-code
  - ai-development
  - ai-agents
  - productivity
  - coding-assistant
  - mcp
  - automation
url: https://github.com/affaan-m/everything-claude-code
author: affaan-m
site: GitHub
created: 2026-02-11
---

# Everything Claude Code - Complete Config Collection

Complete Claude Code configuration collection from an Anthropic hackathon winner. Production-ready agents, skills, hooks, commands, rules, and MCP configurations evolved over 10+ months of intensive daily use building real products.

## Highlights

- **42K+ stars** — battle-tested by the community
- **15+ agents, 30+ skills, 30+ commands**
- **Multi-language support:** TypeScript, Python, Go, Java
- **Memory persistence hooks** — saves/loads context across sessions automatically
- **Multi-agent orchestration** — PM2 integration for complex workflows
- **Cross-platform:** Windows, macOS, Linux

## Key Guides

| Topic | What You'll Learn |
|-------|-------------------|
| Token Optimization | Model selection, system prompt slimming, background processes |
| Memory Persistence | Hooks that save/load context across sessions automatically |
| Continuous Learning | Auto-extract patterns from sessions into reusable skills |
| Verification Loops | Checkpoint vs continuous evals, grader types, pass@k metrics |
| Parallelization | Git worktrees, cascade method, when to scale instances |
| Subagent Orchestration | The context problem, iterative retrieval pattern |

## Quick Start

```bash
# Add marketplace
/plugin marketplace add affaan-m/everything-claude-code

# Install plugin
/plugin install everything-claude-code@everything-claude-code

# Clone for rules (plugins can't distribute rules)
git clone https://github.com/affaan-m/everything-claude-code.git

# Install common rules
cp -r everything-claude-code/rules/common/* ~/.claude/rules/

# Install language-specific rules
cp -r everything-claude-code/rules/typescript/* ~/.claude/rules/
```

## Relevance

Useful for AI-first development workflows (budgeting app, side projects). The memory persistence and continuous learning hooks are particularly valuable for longer projects.

## Source

[GitHub Repository](https://github.com/affaan-m/everything-claude-code)
