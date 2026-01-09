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
- Changelog of what's new

If already up to date, inform user and exit.

### Step 2: Preview Changes

Show the user what will change:
- New/modified commands
- New/modified templates
- Documentation updates

Ask for confirmation before proceeding.

### Step 3: Apply Updates

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

### Step 4: Update Version Tracking

Update `.claude/synapse-version.json` with:
```json
{
  "version": "1.2.0",
  "updated_at": "2026-01-15T10:30:00Z",
  "files_updated": ["commands/review-notes.md", "templates/Meeting Note.md"]
}
```

### Step 5: Summary

Report what was updated and any manual steps needed.

## Usage

```
/synapse-update              # Check for and apply updates
/synapse-update --check      # Only check, don't apply
/synapse-update --force      # Update even if versions match
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
- **Markers missing**: Guide user to add markers or run `/pkm-setup` again
- **Merge conflict**: Present options, don't auto-resolve

## Notes

- Updates are non-destructive: your content is always preserved
- You can always re-run `/pkm-setup` after an update if context sections get corrupted
- Custom commands you create (not part of Synapse) are never touched
