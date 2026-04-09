---
type: resource
status: active
created: 2026-04-09
tags: [product, solus, spec, project-management]
summary: Detailed technical and product spec for Solus v1 — the project management layer, covering data model, permissions, sharing, and scope.
related: [[areas/LifeOS]]
---

# Solus — PM Spec (v1)

This document covers the detailed product and technical decisions for Solus v1 — the project management layer. For the high-level overview see [[areas/LifeOS]].

## Scope

### In

- Workspaces
- Groups and Teams
- Projects with Objectives, Initiatives, and Tasks
- Team-scoped statuses and workflows
- Cycles / sprints
- List and Kanban views
- Optimistic UI
- Sharing, permissions, and guest access
- Documents linked to projects (optional)

### Out for now

- Documents and knowledge management
- People / CRM
- Ideas, meeting notes, daily notes
- AI layer and embeddings
- Comments and reactions (schema-ready, not built)
- Live collaborative editing
- Keyboard shortcuts
- Offline support
- Mobile app


## Data Model

### Core principle

Everything is an **entity** — a typed node with a universal schema. Relationships are explicit, typed edges. Type-specific fields live in a `properties` JSONB column rather than separate tables, avoiding migrations when fields change.

### Entity table

```sql
entities
  id            uuid primary key
  workspace_id  uuid references workspaces(id)
  type          text          -- 'project' | 'task' | 'document' | ...
  title         text not null
  summary       text          -- one-liner for LLM context
  status_id     uuid references statuses(id)
  properties    jsonb         -- type-specific fields
  content       text          -- rich text body
  content_type  text          -- 'markdown' | 'yjs' (future)
  yjs_state     bytea         -- null now, live editing later
  embedding     vector(1536)  -- pgvector, populated async
  source        text          -- 'manual' | 'import' | 'api'
  occurred_at   timestamptz   -- when did this happen
  created_at    timestamptz default now()
  updated_at    timestamptz default now()
```

### Entity relations (the graph)

```sql
entity_relations
  id            uuid primary key
  workspace_id  uuid references workspaces(id)
  from_id       uuid references entities(id)
  to_id         uuid references entities(id)
  type          text    -- 'child' | 'related' | 'blocks' | 'duplicate' | 'document'
  created_at    timestamptz
```

### Project management hierarchy

```
Project (entity type: 'project')
  ├── Objectives (entity type: 'objective')
  │     └── optional parent for Initiatives via entity_relations
  ├── Initiatives (entity type: 'initiative')
  │     ├── may belong to an Objective
  │     └── Tasks may belong to an Initiative
  ├── Tasks (entity type: 'task')
  │     ├── may belong to an Initiative (or float freely under Project)
  │     ├── assignee_id → workspace member
  │     ├── requester_id → workspace member
  │     └── status_id → team-scoped status
  ├── Teams → reference a Group
  └── Documents → linked via entity_relations, not owned
```

### Task-specific properties (stored in JSONB)

```json
{
  "priority": "urgent | high | medium | low",
  "due_date": "timestamptz",
  "estimate": "number",
  "sort_order": "number",
  "assignee_id": "uuid",
  "requester_id": "uuid"
}
```

### Groups and Teams

Groups and Teams are the same underlying resource. The distinction is in usage only — Groups for workspace-level permission management, Teams for project execution context.

```sql
groups
  id            uuid primary key
  workspace_id  uuid references workspaces(id)
  name          text
  type          text    -- 'group' | 'team' (UI hint only)
  created_at    timestamptz

group_members
  group_id      uuid references groups(id)
  user_id       uuid references users(id)
  role          text    -- 'admin' | 'member'

project_teams
  project_id    uuid references entities(id)
  group_id      uuid references groups(id)
```

### Statuses

Statuses are team-scoped. Each team defines its own workflow.

```sql
statuses
  id            uuid primary key
  team_id       uuid references groups(id)
  name          text        -- 'Backlog' | 'In Progress' | 'Done' | ...
  type          text        -- 'backlog' | 'started' | 'completed' | 'cancelled'
  color         text
  sort_order    integer
```

### Cycles / Sprints

```sql
cycles
  id            uuid primary key
  project_id    uuid references entities(id)
  name          text
  start_date    date
  end_date      date
  status        text    -- 'upcoming' | 'active' | 'completed'

cycle_entities
  cycle_id      uuid references cycles(id)
  entity_id     uuid references entities(id)
```

### Issue identifiers

```sql
entity_identifiers
  entity_id     uuid references entities(id)
  group_id      uuid references groups(id)
  number        integer
  -- unique: (group_id, number) → e.g. ENG-001, MKT-042
```

### Workspaces and members

```sql
workspaces
  id            uuid primary key
  name          text
  owner_id      uuid references users(id)
  created_at    timestamptz

workspace_members
  workspace_id  uuid references workspaces(id)
  user_id       uuid references users(id)
  role          text    -- 'owner' | 'admin' | 'member' | 'guest'
```

### Documents

Documents are a first-class entity type (`type: 'document'`) managed independently. They may optionally link to a project via `entity_relations` (`type: 'document'`) but are not owned by it. A document can exist with no project relationship at all — this is the intersection with the future knowledge management layer.

### Comments (schema-ready, not built in v1)

```sql
comments
  id            uuid primary key
  workspace_id  uuid references workspaces(id)
  entity_id     uuid references entities(id)
  parent_id     uuid references comments(id)    -- threaded replies
  author_id     uuid references users(id)
  content       text
  resolved_at   timestamptz
  edited_at     timestamptz
  created_at    timestamptz
```


## Permissions

### Model

```
workspace (owner / admin / member / guest)
  └── group / team (admin / member)
        └── project (admin / member / viewer — optional override)
```

### Role capabilities

| Role | Capabilities |
|---|---|
| Workspace owner | Everything including billing and deletion |
| Workspace admin | Manage members, create/delete groups and projects |
| Group admin | Manage group members and statuses |
| Group member | Create and edit tasks and projects within group |
| Project viewer | Read-only on a specific project |
| Guest | Scoped to explicitly shared entities only |

### Permission resolution order

1. Public share link → apply link access level
2. Guest user → entity_shares / guest_invitations only
3. Project restricted → project_members override
4. Default → group / team membership
5. Fallback → workspace_members role

### Row-level security

All tables include `workspace_id` as the RLS anchor. Postgres RLS policies enforce access at the database level — no risk of application-layer leaks.


## Sharing

### Primitives

- **Internal** — team-scoped by default; project can be restricted to explicit members
- **Guest access** — invite by email, scoped to a specific entity, role: viewer / commenter / editor
- **Public links** — per entity, optional password + expiry + sub-item toggle
- **Group sharing** — share a document or resource with an entire group in one action

### Schema

```sql
entity_shares
  id              uuid primary key
  entity_id       uuid references entities(id)
  token           text unique
  access_level    text          -- 'view' | 'comment' | 'edit'
  password        text
  expires_at      timestamptz
  allow_nested    boolean
  created_by      uuid references users(id)
  created_at      timestamptz

guest_invitations
  id              uuid primary key
  workspace_id    uuid references workspaces(id)
  entity_id       uuid references entities(id)
  email           text
  role            text          -- 'viewer' | 'commenter' | 'editor'
  token           text unique
  accepted_at     timestamptz
  expires_at      timestamptz
  invited_by      uuid references users(id)
```


## UI Scope (v1)

- Sidebar: workspace switcher, projects list, groups
- Project view: tasks in list and Kanban views
- Task detail: full properties, relations, assignee, requester, status
- Objectives and initiatives as collapsible hierarchy within project
- Cycle management: create, assign tasks, track progress
- Sharing modal: invite members, generate public link, manage guest access
- Workspace settings: members, groups, billing placeholder


## Technical Notes

### Optimistic UI pattern

1. User performs action
2. UI updates immediately from local Svelte store
3. API call fires in background
4. On success: no visible change (already correct)
5. On failure: rollback store + show error toast

### Realtime

Postgres LISTEN/NOTIFY + SSE for status changes and task updates. No WebSocket server required. Sufficient for home lab / small team use case.

### Performance

- Indexes on `workspace_id`, `type`, `status_id`, `updated_at` on entities table
- Indexes on `from_id`, `to_id`, `type` on entity_relations
- pgvector index on `embedding` column (HNSW) when AI layer is added


## Open Questions

- Whether Objectives and Initiatives should be entity types in the universal table or separate dedicated tables
- Exact status types and defaults per team
- Whether cycles are project-scoped or group/team-scoped
- Task number format — per-project (PROJ-001) or per-team (ENG-001)