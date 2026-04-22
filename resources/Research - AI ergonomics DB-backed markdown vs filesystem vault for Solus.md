---
type: resource
status: active
created: 2026-04-22
tags: [research, solus, ai, architecture, rag, mcp, postgres, pgvector, obsidian]
summary: Does Solus lose the "AI works great on local markdown files" advantage by moving content into Postgres? Evidence-backed answer with concrete recommendations for the retrieval stack, MCP surface, edit auditability, and portability.
related: [[areas/LifeOS]], [[resources/Solus - Project Management Spec]]
---

# Research — AI ergonomics: DB-backed markdown vs filesystem vault

## Question

Solus replaces an Obsidian vault with Postgres-backed markdown. The worry: Obsidian + AI works well partly *because* the content is a folder of plain-text files. Does that advantage survive the move to a database?

## TL;DR

The "AI works great on local markdown" advantage is real, but roughly 80% of it is portable to a DB-backed app. What you lose is mostly **free portability** and **free git-diffability of AI edits**, both of which are fixable with small engineering additions. A well-designed Postgres + pgvector + MCP stack matches or beats a typical Obsidian + Smart Connections setup on retrieval quality and agent tool surface.

Build the MCP server (in progress — Shortcut epic 61). Layer hybrid retrieval on it. Add a revisions table. Ship a markdown export. Then the DB is a better substrate for AI than the vault was, not a worse one.

## Solus-specific context

From [schema.ts](../../workspace/solus/apps/web/src/lib/server/db/schema.ts) and [handoff.md](../../workspace/solus/.argus/handoff.md):

- Content is stored as literal markdown in `content TEXT` — no rich-text JSON blobs. Good.
- `embedding vector(1536)` with HNSW is already indexed. Scaffolded, not populated.
- `entity_relations` table makes containment queryable without parsing markdown for `[[wikilinks]]`.
- An MCP server spec exists (`docs/specs/mcp-server.md`, epic 61) exposing `/api/v1/` as MCP tools over stdio + Streamable HTTP, workspace-scoped via Better Auth's `apiKey` plugin.
- AI-side orchestration (embeddings, semantic search) is **explicitly out of scope for epic 61** — it's a separate surface.

This is a stronger foundation than a typical Obsidian vault, not a weaker one.

## Decomposing the "folder of markdown" advantage

Four separate things are usually bundled together. Being honest about which survive the move:

| Property | Files | DB (Solus) | Verdict |
|---|---|---|---|
| Plain-text content | ✓ | ✓ (row `content` is markdown) | **Matched** |
| Full-text search | ripgrep | Postgres tsvector + pg_trgm + pgvector hybrid | **DB wins** if you add tsvector |
| Rich agent tool surface | Any LLM with FS access | Requires MCP server | **Matched** once epic 61 lands |
| Relational queries | Parse `[[links]]` | `entity_relations` joins | **DB wins** |
| Git-diffable AI edits | Free | Needs engineering | **DB loses** |
| Works with any LLM client out of the box | ✓ | Requires MCP | **DB loses** |
| Workspace isolation / multi-tenancy | — | RLS | **DB wins** (irrelevant for solo, matters for Solus roadmap) |

## Evidence

### Obsidian + AI tools don't actually use "the filesystem" in an irreplaceable way

- [Obsidian Copilot](https://www.obsidiancopilot.com/en/docs/vault-qa) does lexical search plus a local embedding index; it passes relevant chunks to the model rather than letting the model walk the FS.
- [Smart Connections](https://github.com/brianpetro/obsidian-smart-connections) computes block-level local embeddings and exposes a "connections" view.
- Community Obsidian MCP servers ([cyanheads](https://github.com/cyanheads/obsidian-mcp-server), [StevenStavrakis](https://github.com/StevenStavrakis/obsidian-mcp), [MarkusPfundstein](https://github.com/MarkusPfundstein/mcp-obsidian)) expose ~10–20 verbs: read, write, patch, delete, move, search, tag, frontmatter. Every verb maps 1:1 to a SQL-backed MCP tool.

None of these need the filesystem to be the filesystem — they need plain text, search, and a tool surface. Solus has or can have all three.

### DB-backed notes apps don't fail because they're DB-backed

- Notion AI's [documented limits](https://www.eesel.ai/blog/notion-ai-limitations-best-practices) are product decisions (row caps, no cross-DB AI search, tier-gating) — not storage-model problems.
- [Mem and Capacities reviews](https://www.fahimai.com/capacities-vs-mem-ai) flag thin offline support and weak mobile, again not storage-model problems.
- Notion's own [MCP server](https://developers.notion.com/guides/mcp/mcp-supported-tools) ships ~22 tools and is considered the gold standard for a closed PKM ecosystem; the critique is that its tools treat pages as isolated and don't traverse backlinks well — a **tool-design failure**, not a storage failure. Solus can avoid it by exposing backlink traversal as a first-class tool.

### Retrieval: pgvector beats grep **if** you do hybrid

The "RAG is dead, just grep" meme ([RAG Obituary](https://www.nicolasbustamante.com/p/the-rag-obituary-killed-by-agents), [Akita OnRails](https://akitaonrails.com/en/2026/04/06/rag-is-dead-long-context/)) is about **code**, where tokens are globally unique and trees are shallow. Personal notes are the opposite: synonymy-heavy, fuzzy, cross-referenced.

- [Anthropic's Contextual Retrieval](https://www.anthropic.com/news/contextual-retrieval) shows BM25 + embeddings + rerank reduces failed retrievals ~67%.
- [ParadeDB benchmarks](https://www.paradedb.com/blog/hybrid-search-in-postgresql-the-missing-manual) and [Jonathan Katz](https://jkatz05.com/post/postgres/hybrid-search-postgres-pgvector/): pure vector ~62% precision vs hybrid RRF ~84%.
- Postgres can do BM25-ish (`tsvector`) + pgvector + joins in a single query. A vault of files needs a sidecar index to match that.
- Simon Willison's own workflow ([LLM](https://llm.datasette.io/)) uses SQLite + embeddings — not raw files — for exactly this reason.

### Edit safety: counterintuitively, DB is safer; files are more auditable

- Obsidian's own [sync conflict thread](https://forum.obsidian.md/t/robust-sync-conflict-resolution/93544) documents silent duplication and data loss under concurrent edits. Files are not magically safe.
- Postgres transactions are genuinely safer for concurrent edits.
- What files give you for free is **auditability** — every AI edit is a diff in git.
- Steve Yegge's [Beads](https://steve-yegge.medium.com/introducing-beads-a-coding-agent-memory-system-637d7d92514a) is the canonical pattern: JSONL-in-git for auditability + SQLite for querying. Solus can copy this: an `entity_revisions` table + a periodic markdown dump to a git repo.

## Recommendations for Solus

Four concrete deliverables, prioritized. Epic 61 already covers (1).

1. **Build the MCP server properly** — epic 61, already in flight. The tool surface is the single highest-leverage piece: it turns "DB-backed app" from a liability into a peer of Obsidian. The verb set in the spec (`solus_task_create`, `solus_objective_list`, etc.) is correct.
2. **Hybrid retrieval from day one** when content-bearing entities (notes, docs) land. Pure pgvector will underperform on personal notes. Add a `tsvector` column with GIN index, keep `embedding` with HNSW, combine with Reciprocal Rank Fusion at query time. Expose a single `solus_search` MCP tool that takes a query + optional filters (workspace, entity type, date range, parent entity) and returns hybrid results. **Not in epic 61** — needs its own epic.
3. **`entity_revisions` table** from early on. Columns: `entityId`, `content` (prior), `description` (prior), `actorType` (user/token/system), `actorId`, `createdAt`. Gives you "undo that AI change" as a feature and recovers what git gave for free. **Not in epic 61.**
4. **Markdown export + optional git mirror.** A `GET /entities/:id.md` endpoint and a periodic "dump workspace to a git repo" job recovers portability + git diffability without changing the storage model. Also a legit user-facing feature: "your data is never trapped." **Not in epic 61.**

### Don't do (for now)

- Inline `[[wikilink]]` parsing in markdown. `entity_relations` + the human-readable identifier system (`ENG-O-001`) already covers structured linking better than wikilinks do. Revisit only if UX demands it.

## Framing pushback

The worry "AI is great on files, will it still be great on a DB?" conflates three separate things: rich retrieval, rich tool surface, easy portability. A well-designed DB app **beats** the average vault on the first, **matches** it on the second (with an MCP server), and **only loses** on portability-without-engineering-effort — which is a one-time fix.

The scenario to genuinely regret the DB is single-user, local-only, no relational content. That's not the Solus roadmap. For a product heading toward CRM, meetings, and cross-entity context, the DB is the right substrate.

## Shortcut follow-through

Items created from this research:

- Epic 61 (existing): MCP Server (v1) — no changes. The in-scope + out-of-scope boundary in its description is already correct.
- New epic: **AI Retrieval & Content Grounding** — hybrid retrieval (pgvector + tsvector + RRF), embedding pipeline, `solus_search` MCP tool.
- New epic: **Entity History & Portability** — `entity_revisions` table, per-entity markdown export endpoint, workspace-wide markdown dump (optional git mirror).

## Sources

- [Copilot for Obsidian — Vault QA docs](https://www.obsidiancopilot.com/en/docs/vault-qa)
- [Smart Connections (GitHub)](https://github.com/brianpetro/obsidian-smart-connections)
- [cyanheads/obsidian-mcp-server](https://github.com/cyanheads/obsidian-mcp-server)
- [StevenStavrakis/obsidian-mcp](https://github.com/StevenStavrakis/obsidian-mcp)
- [MarkusPfundstein/mcp-obsidian](https://github.com/MarkusPfundstein/mcp-obsidian)
- [Notion MCP supported tools](https://developers.notion.com/guides/mcp/mcp-supported-tools)
- [ChatForest: MCP and Personal Knowledge Management](https://chatforest.com/guides/mcp-personal-knowledge-management-pkm/)
- [eesel: Notion AI limitations & best practices](https://www.eesel.ai/blog/notion-ai-limitations-best-practices)
- [eesel: Brutally honest Notion review 2025](https://www.eesel.ai/blog/notion-review)
- [FahimAI: Capacities vs Mem AI](https://www.fahimai.com/capacities-vs-mem-ai)
- [FahimAI: Mem AI Review](https://www.fahimai.com/MEM-AI/)
- [Anthropic: Contextual Retrieval](https://www.anthropic.com/news/contextual-retrieval)
- [AkitaOnRails: Is RAG Dead?](https://akitaonrails.com/en/2026/04/06/rag-is-dead-long-context/)
- [Nicolas Bustamante: The RAG Obituary](https://www.nicolasbustamante.com/p/the-rag-obituary-killed-by-agents)
- [ParadeDB: Hybrid Search in PostgreSQL — The Missing Manual](https://www.paradedb.com/blog/hybrid-search-in-postgresql-the-missing-manual)
- [Jonathan Katz: Hybrid search with PostgreSQL and pgvector](https://jkatz05.com/post/postgres/hybrid-search-postgres-pgvector/)
- [Simon Willison: LLM docs](https://llm.datasette.io/)
- [Steve Yegge: Introducing Beads](https://steve-yegge.medium.com/introducing-beads-a-coding-agent-memory-system-637d7d92514a)
- [dev.to: AI Agent Memory — When Markdown Files Are All You Need?](https://dev.to/imaginex/ai-agent-memory-management-when-markdown-files-are-all-you-need-5ekk)
- [Obsidian forum: Robust Sync Conflict Resolution](https://forum.obsidian.md/t/robust-sync-conflict-resolution/93544)
