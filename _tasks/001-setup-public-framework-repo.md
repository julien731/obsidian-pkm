# Setup Public Framework Repository

**Status**: Pending
**Priority**: High
**Created**: 2026-01-09
**Project Name**: Synapse

## Summary

Separate the PKM framework (reusable by anyone) from the personal vault content (private) using Option 4: Template Repo + Personal Overlay.

**Synapse** = The connection point between human knowledge and AI. A framework for structuring Obsidian vaults so AI assistants can effectively read, understand, and work with your notes.

## Goal

- Public repo `synapse-pkm` (or `synapse-obsidian`) contains only framework files
- Private repo (current vault) contains personal content
- Both can be worked on from the same LLM context
- Users can clone the framework, run `/synapse-setup`, and start using it

## Repository

- **GitHub**: `git@github.com:julien731/synapse-pkm.git`
- **Local clone**: `~/workspace/synapse-pkm`
- **Config**: `.claude/synapse-config.json`

## Framework Files to Include

```
synapse-pkm/
├── .claude/
│   ├── commands/
│   │   ├── synapse-setup.md
│   │   ├── synapse-review.md
│   │   ├── synapse-update.md
│   │   └── synapse-publish.md
│   └── synapse-config.json
├── templates/
│   ├── Daily Note.md
│   ├── Meeting Note.md
│   ├── Hiring Interview.md
│   ├── One-on-One.md
│   ├── Person.md
│   ├── Project Brief.md
│   └── Quarterly Review.md
├── areas/.gitkeep
├── daily/.gitkeep
├── inbox/.gitkeep
├── meetings/.gitkeep
├── people/.gitkeep
├── projects/.gitkeep
├── resources/.gitkeep
├── CLAUDE.md          # Template version with placeholders
├── README.md          # Framework documentation + setup instructions
├── LICENSE
└── .gitignore
```

## Implementation Steps

1. [ ] Create `synapse-pkm` repo on GitHub (public)
2. [ ] Create template versions of CLAUDE.md and README.md
   - Replace personal references (Julien, Nimble, team members) with placeholders
   - Add "Getting Started" section explaining `/synapse-setup`
3. [ ] Copy framework files to new repo
4. [ ] Add LICENSE (MIT or similar)
5. [ ] Update `.gitignore` for the framework repo
6. [ ] Write user-facing README with:
   - What this framework is
   - How to install (clone + open in Obsidian)
   - How to configure (`/synapse-setup`)
   - Available commands
   - AI optimization principles (condensed)
7. [ ] Test fresh clone + setup flow
8. [ ] Update private vault's `.gitignore` to exclude `_tasks/` if desired

## Workflow After Setup

**Improving the framework (maintainer):**
1. Make changes in personal vault (Obsidian)
2. Test the changes
3. Run `/synapse-publish` to push to framework repo
4. Changes are automatically stripped of personal content

**Updating an instance (users):**
1. Run `/synapse-update` to check for updates
2. Preview changes
3. Apply updates (framework sections only, preserves user content)

**Personal vault updates:**
- Continue as normal, push to private repo
- Framework files in personal vault may drift from public repo (that's fine)

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

This enables `/synapse-update` to update framework docs without touching user's personal context.

## Open Questions

- ~~Should there be a `/pkm-update` command to pull framework updates?~~ ✅ Created `/synapse-update`
- Should framework repo include example content to demonstrate structure?
- What license to use? (MIT is simple and permissive)

## Related

- This task was created during conversation about versioning the framework
- Depends on finalizing which commands and templates are "framework" vs "personal"
