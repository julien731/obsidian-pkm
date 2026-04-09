---
type: project
status: active
created: 2026-04-09
tags: [product, side-project, saas, svelte, postgres, ai-first]
summary: An AI-first life management app where all personal and professional information lives under one roof so LLMs can work with full context.
phase: discovery
related: [[resources/Solus - Project Management Spec]]
---

# Solus — Project Brief

Solus is a self-hosted, AI-first life management app. It starts as a collaborative project management tool and grows into a full personal OS — documents, contacts, ideas, meetings, daily notes — all in one place so LLMs can work with complete context rather than a fragmented slice of your life.

## Problem

Personal knowledge and work information is fragmented across too many tools. Tasks live in one place, notes in another, contacts in a third. AI assistants can only ever see a slice of context and can't deliver meaningful intelligence as a result. Existing PM tools (Linear, Shortcut, Plane) also gate basic functionality like multi-team support behind paid subscriptions.


## Solution

A unified life management app where every piece of information — projects, tasks, people, documents, ideas, meetings — is a typed entity in a single graph. Relationships between entities are first-class and queryable. The AI layer operates with full context across everything, not just one domain.


## Vision

A personal operating system structured for both human navigation and AI retrieval. Influenced by the PARA mental model (Projects, Areas, Resources, Archive) as a thinking framework for how information connects. Long-term SaaS potential targeting prosumer and knowledge worker segments who already use PKM tools and understand their limitations.


## Roadmap

| Phase | Scope |
|---|---|
| v1 | Project management — projects, tasks, teams, cycles, sharing |
| v2 | Documents and knowledge management |
| v3 | People / lightweight CRM |
| v4 | Ideas, meeting notes, daily notes |
| v5 | AI layer — embeddings, semantic search, cross-entity queries |


## Stack

SvelteKit (TypeScript) · PostgreSQL + pgvector · Drizzle ORM · Better Auth · Tailwind + shadcn-svelte · Docker Compose on Proxmox


## Principles

- **AI-first data design** — every entity has a summary and embedding vector for LLM retrieval
- **Optimistic UI** — mutate local state first, no spinners on interactions
- **Unified entity model** — everything in one graph, relationships are explicit edges
- **Self-hostable** — Docker Compose, no vendor lock-in, full data ownership
- **SaaS-ready from day one** — RLS on every table, workspace-scoped data
- **Build for yourself first** — use it daily, productize from real usage


## Open Questions

- Final name (working name: Solus)
- Pricing model if productized
- Mobile experience — responsive web or native app