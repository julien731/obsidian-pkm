# Synapse Publish Command

**For framework maintainers only.** Push improvements from your personal instance to the public Synapse framework repository via pull request.

## What This Command Does

1. Identifies framework files that have changed in your instance
2. Strips user-specific content (your personal context)
3. Copies clean framework files to the Synapse repo
4. Creates a pull request for review before merging

## Why PRs Instead of Direct Commits

- **Safety**: Review step catches accidental personal data leaks
- **Versioning**: Clear history of what changed and when
- **Rollback**: Easy to revert a specific release if needed
- **Audit trail**: PR descriptions document the "why" behind changes

## Prerequisites

- You must have the `synapse-pkm` repo cloned locally at `~/workspace/synapse-pkm`
- You must have push access to the repository
- GitHub CLI (`gh`) installed and authenticated
- Run `./scripts/test-synapse.sh` to validate framework structure
- Run `/synapse-changelog` first to document what changed (recommended)

## Configuration

The framework repo location is configured in `.claude/synapse-config.json`:

```json
{
  "source_repo": "https://github.com/julien731/synapse-pkm",
  "local_repo_path": "~/workspace/synapse-pkm",
  "branch": "main"
}
```

## Process

### Step 1: Identify Changes

Compare current instance files against the last known framework version:
- `.claude/commands/*.md`
- `templates/*.md`
- `CLAUDE.md` (framework sections only)
- `README.md` (framework sections only)

Show list of files that have changed.

### Step 2: Prepare Framework Files

For each changed file:

1. **Commands** (`.claude/commands/`):
   - Copy as-is (commands should be generic)
   - Verify no user-specific paths or names are hardcoded

2. **Templates** (`templates/`):
   - Copy as-is (templates should be generic)

3. **CLAUDE.md**:
   - Extract content between `SYNAPSE:FRAMEWORK:START` and `END` markers
   - Replace user context section with template placeholders:
     ```markdown
     <!-- SYNAPSE:USER-CONTEXT:START -->
     ## Vault Owner

     **[Your Name]** - [Your Role] at [Your Organization]. This vault contains...

     (Run `/synapse-setup` to personalize this section)
     <!-- SYNAPSE:USER-CONTEXT:END -->
     ```

4. **README.md**:
   - Replace first line with: `# Synapse PKM`
   - Replace user identity line with template text
   - Keep all framework documentation

### Step 3: Review Changes

Show a diff of what will be published:
- Files being added/updated
- Content being changed

Ask for confirmation.

### Step 4: Copy to Framework Repo

Copy prepared files to `~/workspace/synapse-pkm`:
```
synapse-pkm/
├── .claude/commands/
├── templates/
├── CLAUDE.md
├── README.md
└── ...
```

### Step 5: Changelog Check

Check if CHANGELOG.md has been updated for this release:

1. Look for an entry matching the version being published
2. If no changelog entry exists, prompt:
   - "No changelog entry found. Run `/synapse-changelog` first? (recommended)"
   - Options: Run changelog command / Skip changelog / Cancel

For breaking changes, **require** a changelog entry with migration instructions before allowing publish.

### Step 6: Create Release Branch

Create a branch for the release:

```bash
cd ~/workspace/synapse-pkm
git checkout main
git pull origin main
git checkout -b release/x.x.x
```

Branch naming: `release/1.2.0` for version 1.2.0

### Step 7: Commit Changes

Stage and commit all changed files:

```bash
git add -A
git commit -m "feat: [description of changes]"
```

### Step 8: Push and Create PR

Push the branch and create a pull request:

```bash
git push -u origin release/x.x.x

gh pr create \
  --title "Release x.x.x: [brief description]" \
  --body "$(cat <<'EOF'
## Summary

[Description of what's included in this release]

## Changes

- [List of changes from changelog]

## Safety Checklist

- [ ] No personal names or identifiers
- [ ] No hardcoded paths
- [ ] No personal note content
- [ ] All placeholders intact
- [ ] Tests pass (`./scripts/test-synapse.sh`)

## Version

Bumping from x.x.x → y.y.y
EOF
)"
```

### Step 9: Review PR

The command outputs the PR URL. Before merging:

1. **Review the diff in GitHub** - Check for any personal data
2. **Verify safety checklist** - All items should be checked
3. **Check CI status** - Structural tests should pass

### Step 10: Merge and Tag

After PR review and approval:

1. Merge the PR (squash or merge commit)
2. Create a version tag:
   ```bash
   git checkout main
   git pull origin main
   git tag x.x.x
   git push origin x.x.x
   ```

## Usage

```
/synapse-publish                    # Interactive publish flow (creates PR)
/synapse-publish --dry-run          # Show what would be published, don't execute
/synapse-publish --prepare-only     # Copy files and create branch, don't push/PR
```

## Files Tracked as Framework

The command knows these are framework files:

```
.claude/commands/synapse-setup.md
.claude/commands/synapse-review.md
.claude/commands/synapse-update.md
.claude/commands/synapse-publish.md
.claude/commands/synapse-changelog.md
.claude/commands/synapse-migrate-notion.md
templates/Daily Note.md
templates/Meeting Note.md
templates/Hiring Interview.md
templates/One-on-One.md
templates/Person.md
templates/Project Brief.md
templates/Quarterly Review.md
CLAUDE.md (framework sections)
README.md (framework sections)
```

User-created commands or templates are NOT published unless explicitly added to this list.

## Safety Checks

Before publishing, verify:
- [ ] No user-specific names in commands (grep for configured user name)
- [ ] No hardcoded paths specific to your machine
- [ ] No personal notes content accidentally included
- [ ] All placeholder markers are intact

If any check fails, warn and ask for confirmation.

## Example Session

```
User: /synapse-publish

Claude: Checking for framework changes...

Found 3 files changed since last publish:
- .claude/commands/synapse-review.md (modified)
- templates/Meeting Note.md (modified)
- CLAUDE.md (framework section modified)

Preparing files for publish...
- Stripping user context from CLAUDE.md
- Verifying no personal data in commands

Running safety checks...
✓ No personal names detected
✓ No hardcoded paths
✓ Placeholders intact

Ready to publish to ~/workspace/synapse-pkm

Preview changes? (y/n)

User: y

Claude: [shows diff]

Version bump? (patch/minor/major/skip)

User: patch

Claude: Bumping version 1.0.0 → 1.0.1

Creating release branch and PR...

✓ Files copied to synapse-pkm
✓ Created branch: release/1.0.1
✓ Committed: "fix: improve review command edge case handling"
✓ Pushed to origin/release/1.0.1
✓ Created PR #12: "Release 1.0.1: Review command improvements"

PR URL: https://github.com/julien731/synapse-pkm/pull/12

Next steps:
1. Review the PR diff for any personal data
2. Check the safety checklist in the PR
3. Merge when ready
4. Tag the release: git tag 1.0.1 && git push origin 1.0.1
```

## Notes

- Always review the PR diff before merging
- The command won't publish your personal notes—only framework files
- Run `/synapse-changelog` before publishing to document changes for users
- Breaking changes require a changelog entry with migration instructions
- The PR provides a final review opportunity before changes go public
- Consider testing `/synapse-update` in a fresh clone after merging
