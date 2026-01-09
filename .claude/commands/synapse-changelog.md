# Synapse Changelog Command

Generate a changelog entry for framework updates, including migration instructions for breaking changes.

## Purpose

When publishing framework updates via `/synapse-publish`, maintainers should document what changed. This command:

1. Generates a structured changelog entry
2. Prompts for migration instructions on breaking changes
3. Appends to CHANGELOG.md in the framework repo

## Version Format

Use semantic versioning with the pattern `x.x.x` (no "v" prefix):
- **Major** (x.0.0): Breaking changes requiring user action
- **Minor** (0.x.0): New features, backward compatible
- **Patch** (0.0.x): Bug fixes, documentation updates

## Process

### 1. Determine Version Bump

Ask the user or infer from changes:

**"What type of changes are in this release?"**

Options:
- **Breaking change** → Major version bump (requires migration instructions)
- **New feature** → Minor version bump
- **Bug fix / docs** → Patch version bump

### 2. Collect Changes

Review recent commits in the framework repo since the last version tag:

```bash
cd ~/workspace/synapse-pkm
git log $(git describe --tags --abbrev=0)..HEAD --oneline
```

Categorize changes by conventional commit prefix:
- `feat:` → Added
- `fix:` → Fixed
- `docs:` → Documentation
- `refactor:` → Changed
- `BREAKING CHANGE:` → Breaking Changes (requires migration)

### 3. Migration Instructions (Breaking Changes Only)

For any breaking change, prompt the user:

**"This is a breaking change. What should users do to migrate?"**

Collect:
- What specifically changed
- Step-by-step migration instructions
- Any files users need to manually update

### 4. Generate Changelog Entry

Format:

```markdown
## x.x.x - YYYY-MM-DD

### Breaking Changes

- **Change description** - Brief explanation of what changed

  **Migration:**
  1. Step one
  2. Step two
  3. Step three

### Added

- New feature or command description

### Changed

- Modification to existing functionality

### Fixed

- Bug fix description

### Documentation

- Documentation update description
```

### 5. Update CHANGELOG.md

Prepend the new entry to `~/workspace/synapse-pkm/CHANGELOG.md` (after the header).

If CHANGELOG.md doesn't exist, create it with:

```markdown
# Synapse Changelog

All notable changes to the Synapse PKM framework.

Format based on [Keep a Changelog](https://keepachangelog.com/).

## x.x.x - YYYY-MM-DD

[entries here]
```

### 6. Create Version Tag

After committing the changelog:

```bash
cd ~/workspace/synapse-pkm
git add CHANGELOG.md
git commit -m "docs: add changelog for x.x.x"
git tag x.x.x
```

## Example Session

```
User: /synapse-changelog

Claude: I'll generate a changelog entry. Let me check recent changes in the framework repo.

[Reviews commits since last tag]

Found 3 commits:
- feat: add synapse-review command
- fix: correct template frontmatter
- BREAKING CHANGE: rename /pkm-setup to /synapse-setup

This includes a breaking change. What type of release is this?
○ Major (breaking changes) - Recommended
○ Minor (new features)
○ Patch (fixes only)

User: Major

Claude: For the breaking change (renamed /pkm-setup to /synapse-setup), what migration steps should users follow?

User: Just use the new command name, the old one won't work

Claude: Generated changelog entry:

## 1.0.0 - 2026-01-09

### Breaking Changes

- **Command renamed: /pkm-setup → /synapse-setup** - All commands now use the synapse- prefix for consistency.

  **Migration:**
  1. Use `/synapse-setup` instead of `/pkm-setup`
  2. No other changes required

### Added

- `/synapse-review` command for reviewing manual notes

### Fixed

- Template frontmatter now includes all required fields

Shall I add this to CHANGELOG.md and create the 1.0.0 tag?
```

## Usage

```
/synapse-changelog              # Interactive changelog generation
/synapse-changelog 0.2.0        # Generate entry for specific version
/synapse-changelog --preview    # Preview without writing
```

## Notes

- Always run this BEFORE `/synapse-publish` to include changelog in the release
- The `/synapse-update` command reads CHANGELOG.md to show users what changed
- Keep entries concise but include enough detail for migration
- Use present tense ("Add feature" not "Added feature") in commit messages, past tense in changelog ("Added")
