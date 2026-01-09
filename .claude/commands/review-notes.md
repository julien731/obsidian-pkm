# Review Notes Command

Review manually-created notes in the PKM vault and fix them to comply with AI-first organization standards defined in `PKM/CLAUDE.md`.

## Scope

By default, review notes created in the last 7 days that lack a `summary` field (indicating they were likely created manually without AI assistance).

If the user specifies a folder, file, or time range, use that instead.

## Process

### 1. Identify Notes to Review

Find notes matching the scope criteria:
- Missing `summary` field in frontmatter, OR
- Missing required frontmatter fields for their type, OR
- Specified explicitly by the user

### 2. For Each Note, Check

**Frontmatter completeness:**
- [ ] `type` - Infer from folder location and content
- [ ] `created` - Use file creation date if missing
- [ ] `status` - Required for actionable notes (areas, projects)
- [ ] `summary` - Generate one-sentence description
- [ ] `tags` - Extract from content themes
- [ ] `related` - Collect from inline `[[links]]`
- [ ] Type-specific fields (see CLAUDE.md)

**Content standards:**
- [ ] First paragraph is self-contained (provides full context)
- [ ] Links include surrounding explanation
- [ ] No ambiguous pronouns without clear antecedent
- [ ] Headers follow hierarchy (H2 → H3 → H4)

### 3. Handle Ambiguity

When you cannot confidently determine a value, collect the question and **batch all questions together** at the end of the review. Present them to the user in a single interaction rather than interrupting for each note.

Questions to ask when uncertain:
- What type should this note be? (if content doesn't clearly fit)
- Is this note active, completed, or archived?
- What is the main purpose of this note? (for summary)
- Should this link to [other note]? (for related)
- Is this a work (Nimble) note or personal?

### 4. Apply Fixes

For each note:
1. Update frontmatter with missing/corrected fields
2. Add self-contained first paragraph if missing
3. Report what was changed

### 5. Summary Report

After processing all notes, provide:
- Number of notes reviewed
- Number of notes updated
- List of changes made per note
- Any notes skipped (and why)

## Example Usage

User: `/review-notes`
→ Review notes from last 7 days missing summary field

User: `/review-notes inbox/`
→ Review all notes in inbox folder

User: `/review-notes areas/2026 Team Goals.md`
→ Review specific file

User: `/review-notes --all`
→ Review entire vault (will take longer)

## Notes

- Prefer minimal changes; don't rewrite content unnecessarily
- Preserve the author's voice and style in summaries
- When adding first paragraphs, keep them brief (2-3 sentences max)
- If a note is already compliant, skip it silently
