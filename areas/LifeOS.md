---
type: project
status: active
created: 2026-04-08
tags: [product, side-project, saas, svelte, postgres, ai-first]
summary: An AI-first life management app starting with collaborative project management, designed so LLMs can operate with full personal context across all important information.
phase: discovery
---

# Solus — AI-First Life Management App

This document captures the concept, technical decisions, and scope for Solus — a self-hosted, AI-first life management app built by Julien. It starts as a personal project management tool (replacing Linear/Shortcut for side projects) and expands into a full personal OS: documents, CRM, ideas, meetings, and daily notes — all under one roof so LLMs can work with complete context.

---

## Problem

Existing PM tools (Linear, Shortcut, Plane) gate basic multi-team functionality behind paid plans. More broadly, personal knowledge and work information is fragmented across too many tools — tasks in one place, notes in another, contacts in a third — meaning AI assistants only ever see a slice of context and can't deliver meaningful intelligence.

---

## Solution

A self-hosted, collaborative life management app with a unified entity model. Everything — projects, tasks, people, documents, ideas, meetings — is a typed node in a single graph. Relationships between entities are first-class and queryable. The AI layer operates with full context across all entity types, not just one slice.

### Why build instead of buy

- No open-source tool offers multi-team PM without a subscription
- No existing tool is designed from the ground up for LLM context retrieval
- Full data ownership and no recurring cost
- Stack already known and productive (SvelteKit, Postgres, Tailwind)

---

## Vision

A personal operating system where all important information lives in one place, structured for both human navigation and AI retrieval. Long-term SaaS potential targeting prosumer/knowledge worker segment who already use PKM tools and understand their limitations.

---

## Scope

### v1 — Project Management (current focus)

- Workspaces
- Multiple teams (the core pain point — free plans restrict this)
- Projects and tasks
- Team-scoped statuses and workflows
- Cycles / sprints
- List and Kanban views
- Optimistic UI (Linear-feel responsiveness)
- Collaborative: sharing, permissions, guest access
- Self-hosted on Proxmox via Docker Compose

### Future layers

- Documents
- People / lightweight CRM
- Ideas (lifecycle: new → developing → decided)
- Meeting notes
- Daily notes
- AI layer: embeddings, semantic search, cross-entity queries
- Workflow automation (Synapse-style commands as UI flows)
- Comments and reactions
- Presence indicators
- Public share links

---

## Technical Decisions

### Stack

| Layer | Choice | Rationale |
|---|---|---|
| Frontend + API | SvelteKit (TypeScript) | Known stack, full-stack, no Next.js |
| ORM | Drizzle | TypeScript-native, clean migrations |
| Database | PostgreSQL + pgvector | Relational + vector embeddings in one |
| Auth | Better Auth | Open source, self-hosted, SvelteKit-native |
| UI | Tailwind + shadcn-svelte | Existing component library |
| Deployment | Docker Compose on Proxmox | Home lab, zero cost |
| File storage | Local volume (S3-compatible abstraction) | Swap to R2/S3 later without code changes |
| Realtime | Postgres LISTEN/NOTIFY + SSE | No extra infra, sufficient for use case |
| Multi-tenancy | Row-level security via Postgres RLS | SaaS-ready from day one |

### What was ruled out and why

- **Supabase** — vendor dependency, want full control on home lab
- **Next.js** — personal preference against React ecosystem
- **Redis/WebSockets for realtime** — overkill for current scale
- **Live collaborative editing (CRDTs/Yjs)** — deferred, schema leaves door open via `yjs_state bytea` column
- **Offline support** — not needed, always-on home lab
- **Keyboard shortcuts** — not a priority for v1

---

## Data Model

### Core principle

Everything is an **entity** — a typed node with a universal schema. Relationships between entities are explicit, typed edges. This mirrors the Obsidian/Synapse mental model but with proper relational structure and LLM-optimised fields.

### Entity types

`task` `project` `person` `meeting` `idea` `document` `area` `daily` `resource`

### Key tables

- `entities` — universal node table with `type`, `summary`, `properties` (JSONB), `content`, `embedding` (vector), `occurred_at`
- `entity_relations` — typed graph edges between any two entities
- `teams` — multiple teams per workspace, each with own statuses and cycles
- `statuses` — team-scoped workflow states
- `cycles` — sprints, team-scoped
- `workspace_members` / `team_members` / `project_members` — RBAC permission layers
- `entity_shares` — public share links with access level, password, expiry
- `guest_invitations` — external collaborator access scoped to specific entities
- `comments` — universal, references `entities(id)`, threaded via `parent_id` (built later, schema-ready now)

### Permission model

```
workspace (owner / admin / member / guest)
  └── team (admin / member / viewer)
        └── project (admin / member / viewer — optional override)
```

Permission resolution order:
1. Public share link → apply link access level
2. Guest user → entity_shares / guest_invitations only
3. Project restricted → project_members
4. Default → team_members
5. Fallback → workspace_members role

### Sharing model

- Internal: team-scoped by default, project can be restricted
- Guest access: invite by email, scoped to specific entity
- Public links: per entity, optional password + expiry + sub-item toggle
- Daily notes and meeting notes: private by default

---

## Product Principles

1. **AI-first data design** — every entity has a `summary` field and `embedding` vector for LLM retrieval. Relationships are explicit and queryable, not implicit in folder structure.
2. **Optimistic UI** — mutate local state first, sync in background. No spinners on interactions.
3. **Unified entity model** — everything in one graph. A task can relate to a person, a meeting, and an idea without cross-system joins.
4. **Self-hostable by design** — Docker Compose, no vendor lock-in, full data ownership.
5. **SaaS-ready from day one** — RLS on every table, workspace-scoped data, portable auth.
6. **Build for yourself first** — use it daily, let the product emerge from real usage before productizing.

---

## Competitive Context

| Tool | Gap |
|---|---|
| Linear | Multi-team gated behind paid plan, no life management layer |
| Shortcut | Same multi-team restriction, no PKM angle |
| Plane CE | Work Item Types and advanced features require Commercial Edition |
| Notion | Not a PM tool, AI context fragmented, no graph model |
| Obsidian | Flat files, no structured data, AI bolted on via plugins |

Closest reference found: heyron.ai — different category (AI chatbot wrapper), not a real comparable.

---

## Open Questions

- What to call it (working name: Solus)
- Pricing model if productized (per seat vs flat rate vs usage-based)
- Whether Synapse commands become UI flows in a future version
- Exact feature scope for AI layer in v2
- Mobile experience — responsive web or native app

---

## Next Steps

- [ ] Finalise UI structure and views
- [ ] Generate Drizzle schema from data model
- [ ] Set up Docker Compose with Postgres + SvelteKit
- [ ] Build auth with Better Auth
- [ ] Build team + workspace management
- [ ] Build task CRUD with optimistic updates
- [ ] Build Kanban and list views
- [ ] Build sharing and permissions UI