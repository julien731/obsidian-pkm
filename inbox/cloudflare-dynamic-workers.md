---
type: resource
status: active
created: 2026-03-26
summary: Cloudflare introduces Dynamic Workers — secure, lightweight isolates for executing AI-generated code that are 100x faster than containers with millisecond startup times.
tags:
  - cloudflare
  - ai
  - workers
  - sandboxing
  - infrastructure
source: https://blog.cloudflare.com/dynamic-workers/
---

# Sandboxing AI agents, 100x faster

**Source:** [Cloudflare Blog](https://blog.cloudflare.com/dynamic-workers/)
**Published:** 2026-03-24
**Authors:** Kenton Varda, Sunil Pai, Ketan Gupta

## Summary

Cloudflare is introducing **Dynamic Workers** (now in open beta for paid Workers users), which allow a Cloudflare Worker to instantiate another Worker — in its own sandbox, with code specified at runtime — entirely on the fly.

This enables secure execution of AI-generated code without the overhead of containers. Key benefits:

- **100x faster** than traditional Linux containers
- **Millisecond startup times** (vs. hundreds of ms for containers)
- **Lower memory footprint** (vs. hundreds of MB for containers)
- **True isolation** — no need to reuse containers across tasks, which would compromise security

## Context

This builds on their earlier **Code Mode** announcement, where agents write code to call APIs instead of making tool calls — cutting token usage by up to 81%. Dynamic Workers provide the safe execution layer for that AI-generated code.

The key insight: at consumer scale (every user has an agent), containers are too slow and expensive. Workers' V8 isolate model solves this.

## Relevance

Relevant for AI agent architecture, especially any project where sandboxed code execution is needed (e.g., agentic workflows, dynamic tool generation).
