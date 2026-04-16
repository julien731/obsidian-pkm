# Vault Gardening Routine

Run a comprehensive maintenance check on the Obsidian vault. This command performs daily housekeeping to ensure content meets quality standards.

## Usage

```bash
/claude garden [options]
```

## Checks Performed

### 1. Git Sync
- Pull latest changes from `origin/main`
- Identify new files that landed via git

### 2. Inbox Processing (`inbox/` folder)
- List all unprocessed notes
- Suggest destination folder based on content analysis
- Check for required frontmatter: `type`, `created`, `summary`, `tags`
- Recommend related notes to link

### 3. Orphan Check
- Scan `projects/`, `areas/`, `ideas/`, `people/` for notes with zero incoming wikilinks
- Prioritize by likely activity level
- Suggest parent notes or hubs to create

### 4. Stale Project Detection
- Find projects in `projects/` not modified in 30+ days
- Categorize: active (should update), archive candidates, on-hold (expected)
- Cross-reference with `Projects Board.md` kanban

### 5. Duplicate Detection
- Identify potential duplicate projects (similar titles, overlapping scope)
- Flag for manual review and potential consolidation

### 6. Frontmatter Validation
- Check all notes have required fields based on `type`
- Flag missing `summary` fields
- Validate `status` values

### 7. Projects Board Sync Check
- Verify active projects appear on `Projects Board.md`
- Note projects on board that may be stale

## Output

Generates a markdown report in `daily/YYYY-MM-DD-gardening.md` with:
- Summary of all checks
- Specific items requiring action
- Recommended next steps

## Standards Reference

See `CLAUDE.md` → "Note Review Standards" section for complete frontmatter requirements.

## Automation

This command is designed to run via:
- Manual invocation: `/claude garden`
- Daily cron: See `.github/workflows/daily-gardening.yml` for CI automation
- Git hook: Post-merge to catch new content
