---
type: resource
created: 2026-01-10
status: active
summary: Report of Notion to Obsidian migration completed on 2026-01-10
tags:
  - migration
  - notion
---

# Notion Migration Report

**Migrated:** 2026-01-10
**Source:** `~/Downloads/Export-08bc4c7d-6c7d-452d-bd10-99572fc1f41e/Private & Shared`

## Summary

| Category | Count |
|----------|-------|
| Total files processed | 409 |
| Successfully migrated | 409 |
| Skipped (tags) | 147 |
| Errors | 0 |

## Destination Breakdown

| Folder | Count |
|--------|-------|
| `resources/` | 240 |
| `resources/references/` | 25 |
| `resources/books/` | 3 |
| `journal/reflections/` | 14 |
| `projects/` | 58 |
| `archive/projects/` | 60 |
| `inbox/` | 9 |

## Source Mapping

| Notion Source | Destination | Logic |
|--------------|-------------|-------|
| Second Brain/Resources | `resources/` | By default |
| Second Brain/Resources (Status=Inbox) | `inbox/` | Status override |
| Second Brain/Resources (Type=Product/Place) | `resources/references/` | Type override |
| Second Brain/Questions | `journal/reflections/` | Direct mapping |
| Second Brain/Books | `resources/books/` | Direct mapping |
| Projects (Status=Done/Discarded) | `archive/projects/` | Archived status |
| Projects (other statuses) | `projects/` | Active projects |
| Tags | Skipped | Converted to frontmatter |

## Property Conversions

| Notion Property | Obsidian Frontmatter |
|-----------------|---------------------|
| Type | Not stored (used for routing) |
| Status | `status:` (normalized: Reviewed→active, Done→completed, etc.) |
| Tags | `tags:` (lowercase, hyphenated) |
| Projects | `related:` (as wikilinks) |
| URL | `url:` |
| Context | `context:` |

## Files in inbox/ (need triage)

These files had Status=Inbox in Notion and need review:

- AI Is Forcing Us To Write Good Code - by Steve Kre.md
- AI Personal Mentor Purpose – Align with What Matte.md
- From Beginner to Intermediate Runner (9 Habits I W.md
- Obsidian + Cursor AI Organize 2,000+ Notes in 10 M.md
- Pomelli by Google Labs.md
- Stop using default Docker Desktop This lightweight.md
- The Astrion smart remote is a game-changer for Hom.md
- Use Home Assistant notifications You should be usi.md
- Vibe coding beautiful UIs in 3 simple steps - YouT.md

## Untitled Files

These files had no title in Notion and may need renaming:

- resources/Untitled.md through Untitled 19.md (20 files)
- resources/references/Untitled.md (1 file)

## Migration Metadata

All migrated files include:
```yaml
migrated_from: notion
migrated_at: 2026-01-10
```

To find all migrated files:
```
Search for: migrated_from: notion
```

## What Was Not Migrated

- **Tags database pages** - Converted to frontmatter tags instead
- **Attachments in subfolders** - Only main .md files migrated
- **CSV exports** - Notion database exports (redundant with .md files)

## Next Steps

1. Review files in `inbox/` and move to appropriate locations
2. Rename "Untitled" files with meaningful names
3. Run `/synapse-review` to add summaries and improve frontmatter
4. Consider setting up [Readwise Obsidian plugin](https://github.com/readwise/obsidian-readwise) for ongoing book sync
5. Delete this report when migration cleanup is complete

## Rollback

If needed, restore from git:
```bash
git checkout HEAD~1 -- .
```

Or find and remove all migrated files:
```bash
grep -l "migrated_from: notion" **/*.md | xargs rm
```
