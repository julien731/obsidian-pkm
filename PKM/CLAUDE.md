# Claude Context File

This file provides context for AI assistants (primarily Claude) working with this Obsidian vault.

## Vault Owner

**Julien** - Chief Product Officer (CPO) at Nimble, a software consultancy based in Bangkok, Thailand. This is his personal knowledge management vault for work-related notes.

## Organization: Nimble

Nimble is a software consultancy that builds digital products for clients. The Product & Design team includes:

- **Julien** (CPO) - Vault owner, strategic leadership
- **[[people/Vu]]** - Head of Product, oversees PM team
- **[[people/Julien V]]** - Principal Product Manager
- **[[people/Andrew]]** - Lead Designer, oversees design team

Key clients mentioned in notes include Jollibee (JB), CBTL, Jones Salad, and internal product Okya.

## Vault Structure

```
PKM/
├── inbox/          # Unprocessed items (n8n automations, quick captures)
├── meetings/       # All meeting notes (client, sales, hiring, internal)
├── projects/       # Active project briefs and planning
├── areas/          # Ongoing areas of responsibility
├── resources/      # Reference material, research, learning notes
├── people/         # Contact notes (clients, candidates, partners, colleagues)
├── templates/      # Note templates
└── daily/          # Daily notes
```

## Frontmatter Fields

All notes use YAML frontmatter. Key fields:

| Field | Purpose |
|-------|---------|
| `type` | Note classification: `daily`, `meeting`, `project`, `resource`, `area`, `person` |
| `status` | Current state: `active`, `completed`, `archived`, `on-hold` |
| `summary` | One-sentence description for AI retrieval (read this first) |
| `tags` | Topics and themes as array |
| `related` | Connected notes as `[[wikilinks]]` |
| `created` | When the note was created (YYYY-MM-DD) |
| `date` | When the event happened (for meetings, etc.) |

## How to Use This Vault

### Finding Information

1. **Start with frontmatter**: The `summary` field provides quick context without reading the full note
2. **Use `type` for filtering**: e.g., all `type: meeting` notes, all `type: person` notes
3. **Follow `related` links**: These form an explicit knowledge graph
4. **Check `status`**: Focus on `active` notes for current information

### Understanding Context

- Notes are self-contained: the first paragraph after frontmatter provides full context
- People are linked as `[[people/Name]]` - follow these for role and relationship info
- Projects reference clients in frontmatter

### Key Current Initiatives (2026)

- **AI adoption**: Standardizing AI workflows across product and design teams
- **Quality standards**: Restoring quality as core differentiator after 2025 compromises
- **Client relationships**: Building ties with decision-makers, not just execution-level contacts
- See [[areas/2026 Team Goals]] and [[areas/2026 Team Goals Analysis]] for details

## Conventions for AI Interactions

When working with this vault:

1. **Respect existing structure**: Follow frontmatter conventions, naming patterns, and folder organization
2. **Prefer editing over creating**: Update existing notes rather than creating new ones when possible
3. **Use explicit references**: When linking, include context (e.g., "See [[page]] for the full analysis")
4. **Maintain self-contained notes**: Each note should be understandable without following links
5. **Add `summary` to new notes**: One sentence that captures the note's purpose
