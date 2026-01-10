# Obsidian Vault

Personal knowledge management vault for Julien (CPO at Nimble).

## Folder Structure

```
Obsidian/
├── .claude/        # Claude commands and configuration
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

This vault is designed for AI-assisted analysis. See [CLAUDE.md](CLAUDE.md) for the full AI context file.

### Basic Conventions

- Frontmatter enables filtering (e.g., "all client meetings from Q4")
- The `related` field creates an explicit knowledge graph
- Tags enable thematic queries across note types
- Consistent structure allows pattern recognition across similar notes
- `source` field distinguishes automated captures from manual notes
- `created` vs `date` enables "when did I write this" vs "when did this happen"
- Link people with `[[people/Name]]` to build relationship context over time

### AI Optimization Principles

These principles make notes more effective for LLM retrieval and understanding:

#### 1. Use the `summary` Field

Add a one-sentence `summary` in frontmatter for every note. This allows AI to understand a note's purpose without reading the full content.

```yaml
summary: Consolidated analysis of 2026 team goals from four Nimble leaders.
```

#### 2. Self-Contained First Paragraph

The first paragraph after frontmatter should provide full context: who, what, why, and how this note relates to others. A note should be understandable without following links.

**Good:**
> This document captures Andrew's (Lead Designer at Nimble) input for 2026 team goals. He identifies problems to fix and proposes solutions. For the consolidated analysis, see [[areas/2026 Team Goals Analysis]].

**Weak:**
> Andrew's input on goals.

#### 3. Explicit Over Implicit

State context explicitly rather than relying on folder paths or assumptions:
- Include full names and roles on first mention
- Avoid ambiguous pronouns ("it", "they") that lose meaning when chunked
- Repeat key context rather than assuming link-following

#### 4. Consistent Structure Within Types

Notes of the same type should follow the same section structure. This enables pattern matching across similar notes. Example for goals input:
- Contributor
- What to Fix
- What to Accomplish
- Skills to Develop

#### 5. Explicit Cross-References

When linking, include semantic context:

**Good:** "For the consolidated analysis across all leaders, see [[areas/2026 Team Goals Analysis]]."

**Weak:** `related: [[areas/2026 Team Goals Analysis]]` (frontmatter only)

#### 6. Atomic Notes

One concept per file. Smaller, focused notes (300-500 words) retrieve more precisely than large documents where relevant content is buried.

#### 7. Hierarchical Headers

Use consistent heading hierarchy (H1 → H2 → H3). Header text provides semantic labels that help with chunking and contextual retrieval.

### What Hurts LLM Retrieval

| Pattern | Problem |
|---------|---------|
| Tables with merged cells | Parsing fails |
| Images without alt text | No semantic content |
| Heavy abbreviations | Context lost when chunked |
| Ambiguous pronouns | Referent unclear in isolation |
| Links without context | AI may not follow links |

### Synapse Commands

Synapse commands are available in `.claude/commands/`. Use these to manage your vault.

#### `/synapse-setup` - Initialize or Reconfigure Vault

Personalizes the vault for a new user through a short interview (2-3 questions).

**What it does:**
- Collects your identity (name, role, organization)
- Asks what you'll use the vault for (work, personal, learning, etc.)
- Optionally captures work context (team members, clients)
- Updates CLAUDE.md and README.md with your specific context

**Usage:**
```
/synapse-setup                   # Run the setup interview
```

Run this when you first adopt the vault, or anytime you want to update your context.

#### `/synapse-review` - Review and Fix Manual Notes

Cleans up manually-created notes to comply with AI-first organization standards.

**What it does:**
- Finds notes missing required frontmatter (especially `summary`)
- Adds missing fields (`type`, `created`, `status`, `tags`, `related`)
- Generates summaries from content
- Adds self-contained first paragraphs where missing
- Batches any ambiguous cases for human input at the end

**Usage:**
```
/synapse-review                  # Review notes from last 7 days
/synapse-review inbox/           # Review specific folder
/synapse-review areas/MyNote.md  # Review specific file
/synapse-review --all            # Review entire vault
```

**When human input is needed:**
- Type is ambiguous (content doesn't fit a single category)
- Status is unclear (active vs. completed vs. archived)
- Summary requires interpretation
- Related notes are uncertain
- Personal vs. work classification is unclear

#### `/synapse-update` - Update Framework

Pull the latest Synapse framework updates into your vault.

**What it does:**
- Fetches latest commands and templates from the Synapse repository
- Shows changelog with migration instructions for breaking changes
- Updates framework documentation while preserving your personal context
- Shows preview before applying changes

**Usage:**
```
/synapse-update                  # Check for and apply updates
/synapse-update --check          # Only check, don't apply
```

#### `/synapse-publish` - Publish Framework Changes (Maintainers)

Push framework improvements from your instance to the public Synapse repository.

**Usage:**
```
/synapse-publish                 # Interactive publish flow
/synapse-publish --dry-run       # Preview what would be published
```

#### `/synapse-changelog` - Generate Changelog (Maintainers)

Create changelog entries for framework releases with migration instructions.

**What it does:**
- Reviews commits since last version tag
- Categorizes changes (Added, Changed, Fixed, Breaking)
- Prompts for migration instructions on breaking changes
- Updates CHANGELOG.md and creates version tag

**Usage:**
```
/synapse-changelog               # Interactive changelog generation
/synapse-changelog 0.2.0         # Generate entry for specific version
/synapse-changelog --preview     # Preview without writing
```

#### `/synapse-migrate-notion` - Migrate from Notion

Import content from a Notion export into your Synapse vault with interactive mapping.

**What it does:**
1. Scans your Notion export to auto-detect structure and properties
2. Shows you what it found (folders, property types, values)
3. Asks you to map each folder/type to a Synapse destination
4. Converts Notion properties to YAML frontmatter
5. Rebuilds relationships as `[[wikilinks]]`
6. Cleans up Notion artifacts (UUIDs, broken links)
7. Generates a migration report

**Auto-detection includes:**
- Folder structure and file counts
- Property names and types (from sampling files)
- Property values (for select/status fields)
- Relationship properties (links to other databases)

**Interactive mapping:**
```
=== Notion Export Analysis ===

Folders found:
- Projects/ (45 files)
- Resources/ (120 files)

Properties detected:
- Type: Article, Video, Note (3 values)
- Status: Active, Done, Archived

=== Folder Mapping ===

Where should "Projects/" content go?
  1. projects/ (Recommended)
  2. areas/
  3. resources/
  4. Custom path...
```

**Sensible defaults:**
| Pattern in folder/type name | Suggested destination |
|-----------------------------|----------------------|
| project | `projects/` |
| resource, reference | `resources/` |
| archive | `archive/` |
| meeting, journal | `journal/meetings/` |
| note, inbox | `inbox/` |
| people, contact | `people/` |
| book | `resources/books/` |

**Usage:**
```
/synapse-migrate-notion                 # Interactive migration
/synapse-migrate-notion ~/path/export   # Specify export path
/synapse-migrate-notion --dry-run       # Preview without writing
/synapse-migrate-notion --use-config    # Reuse saved mapping
```

**Re-running migrations:**
- Your mapping is saved to `.claude/migration-config.json`
- Use `--use-config` to apply the same mapping to new exports
- Existing files are skipped (no overwrites)

See [CLAUDE.md](CLAUDE.md) for full review standards.
