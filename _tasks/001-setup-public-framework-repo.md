# Setup Public Framework Repository

**Status**: Completed
**Priority**: High
**Created**: 2026-01-09
**Completed**: 2026-01-10
**Project Name**: Synapse
**Version**: 0.1.0

## Summary

Separate the PKM framework (reusable by anyone) from the personal vault content (private) using Option 4: Template Repo + Personal Overlay.

**Synapse** = The connection point between human knowledge and AI. A framework for structuring Obsidian vaults so AI assistants can effectively read, understand, and work with your notes.

## Outcome

Released Synapse v0.1.0 at https://github.com/julien731/synapse-pkm

## Repository

- **GitHub**: https://github.com/julien731/synapse-pkm
- **Local clone**: `~/workspace/synapse-pkm`
- **Config**: `.claude/synapse-config.json`

## What's Included

```
synapse-pkm/
├── .claude/
│   ├── commands/
│   │   ├── synapse-setup.md
│   │   ├── synapse-review.md
│   │   ├── synapse-update.md
│   │   ├── synapse-publish.md
│   │   ├── synapse-changelog.md
│   │   └── synapse-migrate-notion.md
│   └── synapse-config.json
├── templates/
│   ├── Daily Note.md
│   ├── Meeting Note.md
│   ├── Hiring Interview.md
│   ├── One-on-One.md
│   ├── Person.md
│   ├── Project Brief.md
│   └── Quarterly Review.md
├── scripts/
│   ├── test-synapse.sh
│   └── README.md
├── areas/.gitkeep
├── archive/.gitkeep
├── daily/.gitkeep
├── inbox/.gitkeep
├── journal/meetings/.gitkeep
├── journal/reflections/.gitkeep
├── people/.gitkeep
├── projects/.gitkeep
├── resources/.gitkeep
├── CLAUDE.md          # Template with section markers
├── README.md          # Framework documentation
├── CHANGELOG.md       # Version history
├── LICENSE            # MIT
└── .gitignore
```

## Implementation Steps

1. [x] Create `synapse-pkm` repo on GitHub (public)
2. [x] Create template versions of CLAUDE.md and README.md
   - Placeholders for user context
   - Section markers for update separation
3. [x] Copy framework files to new repo
4. [x] Add LICENSE (MIT)
5. [x] Update `.gitignore` for the framework repo
6. [x] Write user-facing README with:
   - What this framework is
   - How to install (clone + open in Obsidian)
   - How to configure (`/synapse-setup`)
   - Available commands
   - AI optimization principles
7. [ ] Test fresh clone + setup flow (needs user testing)

## Workflow

**Improving the framework (maintainer):**
1. Make changes in personal vault (Obsidian)
2. Test the changes
3. Run `/synapse-publish` to push to framework repo via PR
4. Changes are automatically stripped of personal content

**Updating an instance (users):**
1. Run `/synapse-update` to check for updates
2. Preview changes
3. Apply updates (framework sections only, preserves user content)

## Section Markers

CLAUDE.md and README.md use markers to separate user content from framework content:

```markdown
<!-- SYNAPSE:USER-CONTEXT:START -->
User's personalized content (preserved during updates)
<!-- SYNAPSE:USER-CONTEXT:END -->

<!-- SYNAPSE:FRAMEWORK:START -->
Framework documentation (updated automatically)
<!-- SYNAPSE:FRAMEWORK:END -->
```

## Decisions Made

- License: MIT (simple and permissive)
- Version tags without "v" prefix (e.g., `0.1.0` not `v0.1.0`)
- Publishing via PRs for safety review
