---
type: task
status: pending
created: 2026-01-10
tags:
  - synapse
  - framework
related:
  - "[[_tasks/001-setup-public-framework-repo]]"
---

# Generalize Notion Migration Command

Make `/synapse-migrate-notion` generic for any Notion user, not just Julien's specific workspace structure.

## Current State

The command currently has hardcoded mappings based on Julien's Notion workspace:
- Specific type values (Article, Video, Brief, etc.)
- Specific folder structure (second_brain/, projects/, tags/, etc.)
- Specific property names (Type, Status, Tags, Projects, URL)

## Goal

Make the command auto-detect Notion structure and prompt users for mapping decisions.

## Implementation Steps

1. [ ] Auto-detect Notion properties from export
   - Scan first N files to find common property patterns
   - Identify relationship properties vs. simple values
   - Detect folder structure in export

2. [ ] Interactive mapping flow
   - Show detected types/folders
   - Ask user to map each to Synapse destination
   - Provide sensible defaults based on common patterns
   - Allow "skip" for irrelevant content

3. [ ] Save mapping configuration
   - Store user's choices in `.claude/migration-config.json`
   - Allow re-running migration with same mapping
   - Support incremental migrations

4. [ ] Handle common Notion patterns
   - Databases vs. pages
   - Linked databases (relations)
   - Rollups and formulas (skip or convert)
   - Gallery/Board/Table views (ignore view type)
   - Nested pages

5. [ ] Update documentation
   - Remove Julien-specific examples
   - Add generic examples
   - Document common Notion → Synapse mappings

6. [ ] Test with different Notion exports
   - Simple workspace (pages only)
   - Database-heavy workspace
   - Nested structure
   - Multiple databases with relations

## Default Mappings to Keep

These mappings are sensible defaults for most users:

| Pattern | Destination |
|---------|-------------|
| `**/inbox/**` or status=inbox | `inbox/` |
| `**/archive/**` or status=archived | `archive/` |
| Meeting-related types | `journal/meetings/` |
| Journal/diary content | `journal/` |
| Project-related | `projects/` |
| Reference/resource | `resources/` |
| People/contacts | `people/` |

## Notes

- Complete Julien's migration first to validate the approach
- Then refactor based on lessons learned
- Consider supporting other sources later (Roam, Logseq, etc.)
