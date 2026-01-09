# Synapse Setup Command

Initialize or reconfigure the Obsidian vault for a new user. This command collects context about the user and updates CLAUDE.md and README.md to reflect their specific situation.

## Purpose

When someone adopts the Synapse framework, the vault documentation contains placeholder/example content. This command personalizes the vault by:

1. Gathering essential user context through a short interview
2. Updating CLAUDE.md with their specific context
3. Updating README.md with their identity
4. Optionally setting up initial people/project pages

## Interview Flow

### Step 1: Identity (Required)

Ask the user:

**"Let's set up your vault. First, tell me about yourself:"**

Collect via AskUserQuestion or direct conversation:
- **Name**: Their first name (used in documentation)
- **Role**: Their job title or primary role (e.g., "Software Engineer", "Product Manager", "Founder", "Student")
- **Organization**: Company/school name, or "Independent/Freelance", or skip if purely personal

### Step 2: Vault Purpose (Required)

Ask with multi-select:

**"What will you use this vault for?"**

Options:
- Work notes (meetings, projects, clients)
- Personal projects & side ventures
- Learning & research
- Life management (health, finance, goals)
- Journaling & reflection

This determines which sections appear in CLAUDE.md and which folders are relevant.

### Step 3: Work Context (Conditional)

Only ask if "Work notes" was selected in Step 2.

**"Quick work context (helps AI understand your notes):"**

Options:
- **"Set up now"**: Proceed to collect team/client info
- **"Skip for now"**: Use generic work context, can add later

If they choose to set up:
- **Team members**: "List key colleagues you'll mention often (name, role). Example: Sarah (Engineering Lead), Mike (Designer)"
- **Clients/Projects**: "List main clients or projects. Example: Acme Corp, Project Phoenix"

Keep it light - they can always add more later via people/ pages.

### Step 4: Confirmation

Show a summary of what will be configured:

```
Summary:
- Owner: [Name] ([Role] at [Organization])
- Vault purpose: [selected purposes]
- Work context: [team members, clients if provided]

This will update CLAUDE.md and README.md. Proceed?
```

## Implementation

After confirmation, update the following files:

### CLAUDE.md Updates

Replace the "Vault Owner" section:
```markdown
## Vault Owner

**[Name]** - [Role] at [Organization]. This vault contains [purposes based on selections].
```

Replace or remove "Work Context" section based on their input:
- If work notes selected + details provided: Populate with their team/clients
- If work notes selected + skipped details: Use generic "Work context will be added as you create notes"
- If no work notes: Remove the work context section entirely

Replace or adjust "Personal Context" section:
- If personal purposes selected: List their selected purposes
- If no personal purposes: Remove the section

Remove "Key Current Initiatives" section (they'll add their own over time).

### README.md Updates

Replace the title and first line:
```markdown
# Obsidian Vault

Personal knowledge management vault for [Name] ([Role] at [Organization]).
```

### Optional: Create Initial Pages

If team members were provided, offer to create people/ pages for them with basic templates.

## Important Notes

- **Preserve structure**: Only modify the personalization sections, keep all conventions and AI optimization docs intact
- **Idempotent**: Running setup again should work (reconfigure, not break)
- **Minimal questions**: The goal is 2-3 interactions max for basic setup
- **No pressure**: Make it clear they can skip and add context later
- **Clean output**: After setup, confirm what was changed and remind them they can re-run `/synapse-setup` anytime

## Example Session

```
User: /synapse-setup

Claude: Let's set up your vault.

First, tell me about yourself:
- What's your name?
- What's your role? (e.g., "Software Engineer", "Product Manager", "Student")
- What organization are you with? (or "Independent" if none)

User: I'm Alex, I'm a Senior Developer at TechCorp

Claude: Got it, Alex! What will you use this vault for? (select all that apply)
□ Work notes (meetings, projects, clients)
□ Personal projects & side ventures
□ Learning & research
□ Life management (health, finance, goals)
□ Journaling & reflection

User: Work notes, Learning & research

Claude: Since you'll use this for work, want to add quick context about your team and projects? This helps the AI understand references in your notes.

○ Set up now (1-2 quick questions)
○ Skip for now (add later)

User: Skip for now

Claude: Here's your vault configuration:

Owner: Alex (Senior Developer at TechCorp)
Purpose: Work notes, Learning & research
Work context: Will be added as you create notes

Updating CLAUDE.md and README.md...

Done! Your vault is configured. You can:
- Start creating notes in any folder
- Run /synapse-setup again anytime to update your context
- Add team members by creating pages in people/
```
