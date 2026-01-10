---
type: task
status: completed
created: 2026-01-10
completed: 2026-01-10
tags:
  - synapse
  - framework
related:
  - "[[_tasks/001-setup-public-framework-repo]]"
---

# Generalize Notion Migration Command

Make `/synapse-migrate-notion` generic for any Notion user, not just Julien's specific workspace structure.

## Outcome

The command has been rewritten to be fully generic with auto-detection and interactive mapping.

## Implementation Steps

1. [x] Auto-detect Notion properties from export
   - Scans export to find folder structure and file counts
   - Samples 10-20 files to detect common property patterns
   - Identifies property values for select/status fields
   - Detects relationship properties (links to other pages)

2. [x] Interactive mapping flow
   - Shows detected structure analysis to user
   - Asks user to map each folder to Synapse destination
   - Offers type-based routing for Type/Category properties
   - Handles status overrides (inbox → inbox/, archived → archive/)
   - Provides sensible defaults based on pattern matching

3. [x] Save mapping configuration
   - Stores choices in `.claude/migration-config.json`
   - Supports `--use-config` flag for re-running
   - Skips existing files (no overwrites)

4. [x] Handle common Notion patterns
   - UUIDs in filenames stripped automatically
   - Property lines parsed (both simple and relation format)
   - Callouts converted to Obsidian format
   - Linked databases converted to wikilinks
   - Nested exports recursively scanned

5. [x] Update documentation
   - README.md updated with generic examples
   - Command file uses placeholder examples
   - Sensible defaults documented

6. [ ] Test with different Notion exports
   - Validated with Julien's export (409 files)
   - Additional testing needed with other workspace structures

## Default Mappings

| Pattern | Suggested Destination |
|---------|----------------------|
| Folder contains "project" | `projects/` |
| Folder contains "resource", "reference" | `resources/` |
| Folder contains "archive" | `archive/` |
| Folder contains "meeting", "journal" | `journal/meetings/` |
| Folder contains "note", "inbox" | `inbox/` |
| Folder contains "people", "contact" | `people/` |
| Type = Meeting, Call, Interview | `journal/meetings/` |
| Type = Article, Video, Podcast, Website | `resources/` |
| Type = Book | `resources/books/` |
| Status = inbox, new | `inbox/` override |
| Status = archive, done, completed | `archive/` override |

## Notes

- Command tested successfully with Julien's Notion export
- Migration report generated at `_migration-report.md`
- Consider supporting other sources later (Roam, Logseq, etc.)
