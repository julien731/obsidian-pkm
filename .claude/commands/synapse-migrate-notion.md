# Synapse Migrate Notion Command

Migrate content from a Notion export into a Synapse-structured Obsidian vault.

## What This Command Does

1. Scans a Notion Markdown export to detect structure and properties
2. Presents detected patterns and asks user to map them to Synapse folders
3. Converts Notion properties to YAML frontmatter
4. Rebuilds relationships as Obsidian `[[wikilinks]]`
5. Cleans up Notion export artifacts (UUIDs in filenames, broken links)
6. Generates a migration report

## Prerequisites

- Export your Notion workspace as Markdown (Settings → Export → Markdown & CSV)
- Unzip the export to a known location
- Have your Synapse vault ready (run `/synapse-setup` first if needed)

## Process

### Step 0: Explain Recommendations

Before starting the migration, explain the recommendation system:

```
=== Synapse Migration ===

This migration will ask you to map your Notion content to Synapse folders.

Each choice shows a "(Recommended)" option. These recommendations follow
Synapse's AI-first organization principles:

- Content flows through inbox/ for processing
- Resources go to resources/ for reference retrieval
- Active work goes to projects/
- Completed/old items go to archive/

Following the recommended options ensures your migrated content works
well with Synapse's AI retrieval and organization patterns.

You can always choose differently if your use case requires it.
```

### Step 1: Locate Export

Ask user for the Notion export path:
```
Where is your Notion export folder?
Example: ~/Downloads/Export-12345678-abcd
```

Validate:
- Folder exists
- Contains `.md` files
- Looks like a Notion export (has UUIDs in filenames or CSV files)

### Step 2: Auto-Detect Structure

Scan the export to discover:

1. **Folder structure** - List all folders and count files in each
2. **Properties** - Sample 10-20 files to detect common property patterns
3. **Property values** - For select properties (like Type, Status), list unique values
4. **Relationships** - Identify properties that link to other pages

Report findings:
```
=== Notion Export Analysis ===

Folders found:
- Projects/ (45 files)
- Resources/ (120 files)
- Notes/ (30 files)
- Archive/ (15 files)

Properties detected (from sampling 20 files):
- Type: Article, Video, Note, Document, Meeting (5 values)
- Status: Active, Done, Archived (3 values)
- Tags: (relationship to Tags database)
- Category: Work, Personal, Learning (3 values)
- URL: (text field)

Relationship properties:
- Tags → links to Tags/
- Projects → links to Projects/
```

### Step 3: Interactive Mapping

For each detected folder, ask user where it should go:

```
=== Folder Mapping ===

Where should "Projects/" content go?
  1. projects/ (Recommended)
  2. areas/
  3. resources/
  4. inbox/
  5. Skip (don't migrate)
  6. Custom path...

> 1

Where should "Resources/" content go?
  1. resources/ (Recommended)
  2. inbox/
  3. areas/
  4. Skip (don't migrate)
  5. Custom path...

> 1

Where should "Notes/" content go?
  1. inbox/ (Recommended)
  2. resources/
  3. areas/
  4. Skip (don't migrate)
  5. Custom path...

> 1

Where should "Archive/" content go?
  1. archive/ (Recommended)
  2. resources/
  3. Skip (don't migrate)
  4. Custom path...

> 1
```

For Type or Category properties with multiple values:
```
=== Type-Based Routing ===

You have a "Type" property with these values:
- Article (45 files)
- Video (30 files)
- Note (25 files)
- Document (12 files)
- Meeting (8 files)

How should these be routed?

Option A: Route by type (I'll ask for each) (Recommended)
Option B: All to same folder (resources/)
Option C: Use folder mapping only (ignore Type)

> A

Where should Type="Article" go?
  1. resources/ (Recommended)
  2. inbox/
  3. Custom...
> 1

Where should Type="Meeting" go?
  1. journal/meetings/ (Recommended)
  2. resources/
  3. Custom...
> 1
```

For Status property:
```
=== Status Handling ===

You have a "Status" property. How should it affect routing?

  1. Override destination (inbox/archived items go to special folders) (Recommended)
  2. Frontmatter only (keep status but don't change destination)
  3. Ignore status

> 1

Which status values mean "needs processing" (→ inbox/)?
Enter comma-separated: inbox, new, unread
> inbox

Which status values mean "archived" (→ archive/)?
Enter comma-separated: archived, done, completed
> archived, done
```

### Step 4: Confirm Mapping

Show summary before proceeding:
```
=== Migration Plan ===

Folder mapping:
  Projects/ → projects/
  Resources/ → resources/
  Notes/ → inbox/
  Archive/ → archive/

Type routing:
  Article → resources/
  Video → resources/
  Meeting → journal/meetings/
  Note → inbox/
  Document → resources/

Status overrides:
  inbox → inbox/
  archived, done → archive/

Relationship handling:
  Tags → convert to frontmatter tags
  Projects → convert to related: wikilinks

Files to migrate: 210
Files to skip: 0

Proceed? (y/n/edit)
```

### Step 5: Process Files

For each Notion file:

1. **Clean filename**
   - Remove Notion UUIDs: `My Note abc123def456.md` → `My Note.md`
   - Handle duplicates by appending numbers

2. **Extract properties**
   - Parse property lines at top of file (format: `Property: Value`)
   - Handle relationship properties: `Tags: tag1 (link), tag2 (link)`

3. **Convert to YAML frontmatter**
   ```yaml
   ---
   type: [inferred from Type property or folder]
   created: [today's date]
   status: [from Status property, normalized]
   tags:
     - [extracted tags]
   related:
     - "[[Related Page]]"
   url: [if URL property exists]
   migrated_from: notion
   migrated_at: [today's date]
   ---
   ```

4. **Determine destination**
   - Check Status overrides first
   - Then check Type/Category routing
   - Fall back to folder mapping
   - Default to `inbox/` if unclear

5. **Clean content**
   - Remove property lines from body
   - Convert Notion links to wikilinks
   - Convert callouts to Obsidian format

6. **Write file**
   - Create destination folders as needed
   - Write with frontmatter + cleaned content

### Step 6: Save Configuration

Save the mapping to `.claude/migration-config.json` for future runs:
```json
{
  "source_path": "~/Downloads/Export-xxx",
  "folder_mapping": {
    "Projects/": "projects/",
    "Resources/": "resources/"
  },
  "type_mapping": {
    "Article": "resources/",
    "Meeting": "journal/meetings/"
  },
  "status_overrides": {
    "inbox": "inbox/",
    "archived": "archive/",
    "done": "archive/"
  },
  "skip_folders": ["Tags/"],
  "tag_property": "Tags",
  "relationship_properties": ["Projects", "Related"]
}
```

### Step 7: Generate Report

Create `_migration-report.md`:
```markdown
# Notion Migration Report

**Migrated:** [date]
**Source:** [export path]

## Summary

| Category | Count |
|----------|-------|
| Total files processed | X |
| Successfully migrated | X |
| Skipped | X |
| Errors | X |

## Destination Breakdown

- `resources/` - X files
- `projects/` - X files
- `inbox/` - X files
...

## Files Needing Attention

- [List of Untitled files]
- [Files with missing properties]
- [Broken internal links]

## Configuration Used

[Include mapping summary for reference]

## Next Steps

1. Review files in `inbox/`
2. Run `/synapse-review` to add summaries
3. Delete this report when done
```

## Usage

```
/synapse-migrate-notion                      # Interactive migration
/synapse-migrate-notion ~/path/to/export     # Specify export path
/synapse-migrate-notion --dry-run            # Preview without writing
/synapse-migrate-notion --use-config         # Reuse saved mapping
```

## Default Mappings

When suggesting destinations, use these sensible defaults:

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
| Type = Person, Contact | `people/` |
| Status = inbox, new, unprocessed | `inbox/` override |
| Status = archive, done, completed | `archive/` override |

## Notion Export Quirks Handled

- **UUIDs in filenames**: Stripped automatically
- **Property format**: `Property: value` or `Property: name (link)` for relations
- **Linked databases**: Converted to wikilinks
- **Nested exports**: Recursively scanned
- **CSV files**: Used to detect database structure (not migrated)
- **Callouts**: Converted to Obsidian `> [!type]` format
- **Images**: Preserved with relative paths
- **Code blocks**: Preserved as-is

## Re-running Migration

If you need to migrate again (e.g., new Notion export):
1. Use `--use-config` to reuse your mapping
2. Existing files with same name are skipped (no overwrites)
3. Only new content is added
4. Check migration report for what changed

## Rollback

If something goes wrong:
1. All migrated files have `migrated_from: notion` in frontmatter
2. Find them: search for `migrated_from: notion`
3. Or restore from git: `git checkout HEAD~1 -- .`

## Notes

- Always backup your vault before migrating (git commit recommended)
- The command doesn't modify or delete your Notion export
- Tag database pages become frontmatter tags (not separate files)
- Run `/synapse-review` after migration to add summaries
