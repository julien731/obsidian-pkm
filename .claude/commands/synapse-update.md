# Synapse Update Command

Update your Synapse instance to the latest framework version.

## What This Command Does

1. Fetches the latest Synapse framework from the public repository
2. Updates framework files while preserving your personal configuration
3. Shows what changed before applying updates

## Update Scope

### Files That Get Updated

| File/Folder | What Updates |
|-------------|--------------|
| `.claude/commands/*.md` | All command files replaced with latest versions |
| `templates/*.md` | All templates replaced with latest versions |
| `CLAUDE.md` | Framework sections only (between markers) |
| `README.md` | Framework sections only (between markers) |

### Files That Are NEVER Modified

- Your notes (`areas/`, `people/`, `meetings/`, `projects/`, etc.)
- Your personal context in `CLAUDE.md` (Vault Owner, Work Context, Personal Context)
- Your identity line in `README.md`
- Any files you've added outside the framework structure

## Section Markers

Synapse uses HTML comments to mark framework-managed sections:

```markdown
<!-- SYNAPSE:USER-CONTEXT:START -->
Your personalized content here (preserved during updates)
<!-- SYNAPSE:USER-CONTEXT:END -->

<!-- SYNAPSE:FRAMEWORK:START -->
Framework documentation here (updated automatically)
<!-- SYNAPSE:FRAMEWORK:END -->
```

## Process

### Step 1: Check for Updates

Fetch the latest version info from the Synapse repository:
- Current local version (stored in `.claude/synapse-version.json`)
- Latest remote version

If already up to date, inform user and exit.

### Step 2: Show Changelog

Fetch and display the CHANGELOG.md entries between the user's current version and the latest version:

1. Read `CHANGELOG.md` from the framework repo
2. Extract entries from current version to latest
3. Display in order (newest first)
4. **Highlight any Breaking Changes** with migration instructions

Example output:
```
Updates available: 1.0.0 → 1.2.0

## 1.2.0 - 2026-01-15

### Added
- New `/synapse-review` options for folder-specific reviews

### Fixed
- Template frontmatter date format

## 1.1.0 - 2026-01-10

### Breaking Changes
- **Command renamed: /pkm-setup → /synapse-setup**

  Migration:
  1. Use `/synapse-setup` instead of `/pkm-setup`

### Added
- `/synapse-changelog` command for maintainers
```

If there are **Breaking Changes**, warn the user prominently and show migration steps before proceeding.

### Step 3: Safety Check

Before making any changes, perform safety checks and warn about potential risks:

**Check for risky conditions:**

1. **Missing section markers** in CLAUDE.md or README.md
   - Risk: Cannot reliably separate user content from framework content
   - Action: Warn user that update might overwrite personal content

2. **Corrupted or malformed markers** (e.g., START without END)
   - Risk: Content boundaries unclear
   - Action: Show the issue and ask user to fix manually first

3. **User modifications to framework files** (commands, templates)
   - Risk: Customizations will be overwritten
   - Action: List modified files and ask for confirmation per file

4. **Major version jump** (e.g., 1.x → 2.x)
   - Risk: Structural changes may affect content organization
   - Action: Require explicit confirmation, recommend reading migration guide

**If any risks detected, display:**

```
⚠️  Potential data risk detected:

- CLAUDE.md is missing SYNAPSE:USER-CONTEXT:END marker
- templates/Meeting Note.md has local modifications

These issues may cause content loss during update. Changes can be
restored from git history, but review carefully before proceeding.

Options:
1. Create backup branch and continue (recommended)
2. Continue without backup
3. Cancel and fix issues manually
```

### Step 4: Create Backup Branch (If Needed)

When risks are detected OR for major version updates, create a backup branch:

```bash
git checkout -b synapse-backup-YYYY-MM-DD-HHMMSS
git add -A
git commit -m "backup: pre-update snapshot before Synapse x.x.x → y.y.y"
git checkout -  # Return to original branch
```

This allows easy restoration via `git checkout synapse-backup-...` if something goes wrong.

Skip backup creation if:
- User explicitly chose "Continue without backup"
- No risks were detected AND it's a minor/patch update
- `--no-backup` flag was passed

### Step 5: Preview Changes

Show the user what will change:
- New/modified commands
- New/modified templates
- Documentation updates
- Any files where user content might be affected (highlighted)

Ask for confirmation before proceeding.

### Step 6: Apply Updates

For each framework file:

1. **Commands** (`.claude/commands/`):
   - Download latest versions
   - Replace local files entirely
   - Note: User's custom commands (not from Synapse) are preserved

2. **Templates** (`templates/`):
   - Download latest versions
   - Replace local files entirely
   - Note: User's custom templates (not from Synapse) are preserved

3. **CLAUDE.md**:
   - Preserve content between `SYNAPSE:USER-CONTEXT:START` and `END` markers
   - Replace content between `SYNAPSE:FRAMEWORK:START` and `END` markers
   - If markers don't exist, add them (may require user guidance)

4. **README.md**:
   - Preserve the title and first paragraph (user identity)
   - Update framework documentation sections

### Step 7: Update Version Tracking

Update `.claude/synapse-version.json` with:
```json
{
  "version": "1.2.0",
  "updated_at": "2026-01-15T10:30:00Z",
  "files_updated": ["commands/review-notes.md", "templates/Meeting Note.md"]
}
```

### Step 8: Summary

Report what was updated and any manual steps needed.

If a backup branch was created, remind the user:
```
Backup branch created: synapse-backup-2026-01-09-143022
If anything looks wrong, restore with: git checkout synapse-backup-2026-01-09-143022
```

## Usage

```
/synapse-update              # Check for and apply updates
/synapse-update --check      # Only check, don't apply
/synapse-update --force      # Update even if versions match
/synapse-update --no-backup  # Skip backup branch creation
```

## Handling Conflicts

If user has modified a framework file (e.g., customized a template):

1. Detect the modification by comparing with known framework version
2. Ask user: "You've customized `templates/Meeting Note.md`. Options:"
   - **Overwrite**: Replace with latest framework version
   - **Keep**: Keep your customized version
   - **Merge**: Show diff and let user decide per-change
3. Record their choice for future updates

## Source Repository

Default: `https://github.com/julien731/synapse-pkm`

Can be configured in `.claude/synapse-config.json`:
```json
{
  "source_repo": "https://github.com/julien731/synapse-pkm",
  "branch": "main",
  "auto_check": false
}
```

## Error Handling

- **No internet**: Inform user, suggest trying later
- **Markers missing**: Guide user to add markers or run `/synapse-setup` again
- **Merge conflict**: Present options, don't auto-resolve

## Notes

- Updates are non-destructive: your content is always preserved
- Backup branches are created automatically when risks are detected
- You can always re-run `/synapse-setup` after an update if context sections get corrupted
- Custom commands you create (not part of Synapse) are never touched
- The changelog is fetched from the framework repo's CHANGELOG.md file
- To list all backup branches: `git branch | grep synapse-backup`
- To delete old backups: `git branch -d synapse-backup-YYYY-MM-DD-HHMMSS`
