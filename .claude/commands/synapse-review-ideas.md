# Synapse Review Ideas Command

Weekly review of ideas to develop them further, promote them to projects, or discard them.

## Purpose

Ideas need regular attention to progress. This command surfaces ideas that need decisions and helps move them through the lifecycle:

```
new → developing → decided (project or discarded)
```

## Scope

By default, review all ideas with `status: new` or `status: developing`.

If the user specifies a category filter, only review ideas matching that category.

## Process

### 1. Gather Ideas for Review

Find all notes in `ideas/` where:
- `status: new` (never reviewed), OR
- `status: developing` (in progress)

Sort by:
1. `status: new` first (need initial review)
2. Then by `created` date (oldest first)

### 2. Present Ideas

For each idea, show:
- **Title** (filename)
- **Category** (`product`, `workflow`, `content`, `personal`)
- **Age** (days since created)
- **Summary** (from frontmatter)
- **Content preview** (first section if helpful)

### 3. For Each Idea, Ask

Present options using AskUserQuestion:

**"What should we do with this idea?"**

Options:
- **Keep developing** - Add thoughts, connections, or notes; stays at `status: developing`
- **Promote to project** - Ready to act on; will create a project and link it
- **Discard** - Not worth pursuing; mark `status: decided`, `outcome: discarded`
- **Skip for now** - Leave unchanged, review next time

### 4. Handle Each Decision

**Keep developing:**
1. Set `status: developing` (if was `new`)
2. Ask: "Any thoughts to add?" (optional)
3. If yes, append to the Notes section
4. Update `related` if user mentions connections

**Promote to project:**
1. Ask: "What should the project be called?"
2. Create new project in `projects/` using Project Brief template
3. Copy relevant content from idea to project
4. Update idea: `status: decided`, `outcome: "[[projects/Project Name]]"`
5. Add `related: [[ideas/Idea Name]]` to the new project

**Discard:**
1. Optionally ask: "Any reason to note?" (helps future reference)
2. Update idea: `status: decided`, `outcome: discarded`
3. If reason given, append to Notes section

**Skip:**
- No changes, move to next idea

### 5. Summary Report

After reviewing all ideas, provide:
- Total ideas reviewed
- Decisions made:
  - X kept developing
  - X promoted to projects (with links)
  - X discarded
  - X skipped
- Ideas remaining for next review

## Example Usage

User: `/synapse-review-ideas`
→ Review all new and developing ideas

User: `/synapse-review-ideas product`
→ Review only product ideas

User: `/synapse-review-ideas --new`
→ Review only new ideas (skip developing)

## Notes

- Keep the review lightweight; don't force decisions on every idea
- Some ideas need time to incubate; "skip" is a valid choice
- When promoting to project, carry over the "Why It Matters" and "Open Questions" sections
- Discarded ideas stay in the vault; they may become relevant later
- If there are many ideas, consider batching by category
