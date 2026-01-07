# PKM Vault

Personal knowledge management vault for Julien (CPO at Nimble).

## Folder Structure

```
PKM/
├── inbox/          # Unprocessed items (n8n automations, quick captures)
├── meetings/       # All meeting notes (client, sales, hiring, internal)
├── projects/       # Active project briefs and planning
├── areas/          # Ongoing areas of responsibility
├── resources/      # Reference material, research, learning notes
├── people/         # Contact notes (clients, candidates, partners)
├── templates/      # Note templates
└── daily/          # Daily notes
```

## Frontmatter Conventions

All notes use YAML frontmatter with these fields:

| Field | Required | Values | Purpose |
|-------|----------|--------|---------|
| `type` | Yes | `daily`, `meeting`, `project`, `resource`, `area`, `person` | Note classification |
| `status` | For actionable | `active`, `completed`, `archived`, `on-hold` | Current state |
| `tags` | No | Array of strings | Topics and themes |
| `date` | For dated notes | YYYY-MM-DD | Event/meeting date |
| `created` | Yes | YYYY-MM-DD | When the note was created |
| `source` | For automated | `n8n`, `email`, `manual` | How the note was created |
| `related` | No | `[[wikilinks]]` | Connected notes |

### Meeting-specific fields

| Field | Values |
|-------|--------|
| `meeting_type` | `client`, `sales`, `hiring`, `internal`, `workshop` |
| `attendees` | Array of names |
| `company` | Company name (for external meetings) |

### Hiring-specific fields

| Field | Values |
|-------|--------|
| `candidate` | Candidate name |
| `role` | Position they're interviewing for |
| `stage` | `screening`, `technical`, `culture`, `final` |
| `decision` | `advance`, `reject`, `hold` |

### Project-specific fields

| Field | Values |
|-------|--------|
| `client` | Client name |
| `phase` | `discovery`, `planning`, `execution`, `review` |

### Person-specific fields

| Field | Values |
|-------|--------|
| `company` | Their company |
| `role` | Their role |
| `context` | How you know them (`client`, `candidate`, `partner`, `colleague`) |

## Templates

| Template | Use case |
|----------|----------|
| Daily Note | Daily planning and reflection |
| Meeting Note | Client, sales, internal meetings |
| Hiring Interview | Candidate evaluations |
| Project Brief | Project planning and scope |
| Person | Contact reference notes |
| Quarterly Review | Periodic reflection and planning |

## Naming Conventions

- **Daily notes**: `YYYY-MM-DD.md`
- **Meetings**: `YYYY-MM-DD Meeting Name.md`
- **Projects**: `Project Name.md`
- **People**: `First Last.md`
- **Resources**: Descriptive title, no date prefix

## AI Usage Notes

This vault is designed for AI-assisted analysis. When querying with Claude:

- Frontmatter enables filtering (e.g., "all client meetings from Q4")
- The `related` field creates an explicit knowledge graph
- Tags enable thematic queries across note types
- Consistent structure allows pattern recognition across similar notes
- `source` field distinguishes automated captures from manual notes
- `created` vs `date` enables "when did I write this" vs "when did this happen"
- Link people with `[[people/Name]]` to build relationship context over time
