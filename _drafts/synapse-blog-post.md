---
type: resource
status: draft
created: 2026-01-09
summary: Draft blog post introducing Synapse, an experimental AI-first PKM framework for Obsidian.
tags:
  - synapse
  - blog
  - writing
---

# Synapse: An Experiment in AI-First Personal Knowledge Management

*Building an Obsidian vault that AI can actually understand*

I'm moving away from Notion. After years of using it for everything—meeting notes, project planning, personal knowledge management—I'm starting fresh with Obsidian. But this time, I'm trying something different: building my vault from the ground up to work well with AI assistants.

This post introduces **Synapse**, the framework I'm developing for this experiment. I'm sharing it publicly because I think others might find it useful, but I want to be upfront: I don't know if this is going to work as well as I hope. It's an experiment.

## The Problem

I've been using AI assistants (Claude, mostly) for various tasks, and I keep running into the same friction: when I ask about my notes, projects, or past decisions, the AI struggles. Not because it's not capable, but because my notes aren't structured in a way that helps it understand context.

Consider a simple question like "What did we discuss about the authentication redesign?" If that information is spread across meeting notes, project docs, and Slack summaries—all with different structures, implicit context, and assumptions—the AI has to work much harder to piece things together. Sometimes it fails entirely.

## The Hypothesis

What if we structured notes specifically for AI consumption? Not in a way that makes them worse for humans—markdown is still markdown—but with deliberate choices about:

- What metadata to include
- How to write opening paragraphs
- When to be explicit vs. implicit
- How to link related content

The hypothesis is that small structural changes can dramatically improve how well AI assistants understand and work with your personal knowledge base.

## My (Limited) Understanding of LLMs

I should be clear: I'm not an ML engineer. My understanding of how LLMs process information comes from:

1. **Using them extensively** - Thousands of conversations across different use cases
2. **Reading explanations aimed at practitioners** - Not the papers, but the practical guidance
3. **Experimenting** - Trying different approaches and seeing what works

Here's my working mental model of what matters for retrieval:

- **Frontmatter is searchable metadata** - Fields like `type`, `status`, `summary` let you filter and find notes without reading content
- **First paragraphs carry disproportionate weight** - Whether through attention mechanisms or chunking, opening content matters more
- **Explicit beats implicit** - "Sarah (Engineering Lead at Acme Corp)" retrieves better than "Sarah" with the context buried elsewhere
- **Consistent structure enables pattern matching** - If all meeting notes follow the same format, the AI learns what to expect
- **Redundancy is acceptable** - Repeating context across notes helps when notes are retrieved in isolation

I could be wrong about the mechanisms. But the practical outcomes have been noticeably better when I follow these principles.

## Sources and Influences

I didn't come up with these ideas in a vacuum. Here are the resources that shaped my thinking:

### Research and Guides

- **Anthropic's documentation on Claude** - Particularly their guidance on prompt engineering and context windows
- **OpenAI's best practices for embeddings** - Useful even outside their ecosystem
- **Various RAG (Retrieval-Augmented Generation) guides** - The patterns for preparing documents for retrieval apply directly to personal notes

### Community Knowledge

- **Obsidian forums and Discord** - Lots of discussion about AI integration, though most focuses on plugins rather than structure
- **PARA method (Tiago Forte)** - The Projects/Areas/Resources/Archive taxonomy influenced my folder structure
- **Zettelkasten principles** - Atomic notes, explicit links, and the idea that structure aids thinking

### Conversations with Claude

A significant portion of this framework emerged from extended conversations with Claude (specifically Claude Code). I'd describe what I was trying to achieve, Claude would suggest structures or approaches, I'd push back or ask for alternatives, and we'd iterate.

This wasn't "AI generated my framework." It was more like having an extremely patient collaborator who could:
- Explain tradeoffs between different approaches
- Point out edge cases I hadn't considered
- Help me articulate principles I was intuiting but couldn't name
- Actually implement the tooling (commands, templates) as we designed them

The `/synapse-setup`, `/synapse-review`, and other commands in the framework were designed and built through this collaborative process.

## What Synapse Actually Is

Synapse is a framework for structuring Obsidian vaults so AI assistants can effectively read, understand, and work with your notes. It includes:

**Folder structure:**
```
vault/
├── inbox/          # Unprocessed captures
├── meetings/       # Meeting notes
├── projects/       # Active project briefs
├── areas/          # Ongoing responsibilities
├── resources/      # Reference material
├── people/         # Contact notes
├── templates/      # Note templates
└── daily/          # Daily notes
```

**Frontmatter conventions:**
- Required fields for each note type
- A `summary` field for every note (one sentence describing its purpose)
- Consistent metadata that enables filtering and retrieval

**Content principles:**
- Self-contained first paragraphs (context without following links)
- Explicit references (full names and roles, not just pronouns)
- Hierarchical headers that provide semantic structure

**Claude commands:**
- `/synapse-setup` - Personalize the vault for your context
- `/synapse-review` - Clean up manually-created notes
- `/synapse-update` - Pull framework updates
- Plus maintenance commands for framework contributors

## The Experiment

Here's what I'm testing:

1. **Can I actually maintain this?** - Structured notes require discipline. Will I stick with it, or will entropy win?

2. **Does it improve AI interactions?** - When I ask Claude about my notes, projects, or past decisions, are the answers noticeably better?

3. **Is the overhead worth it?** - Adding summaries and explicit context takes time. Does the payoff justify the investment?

4. **What breaks?** - Which principles turn out to be unnecessary? Which are missing?

I'll be updating this post (or writing follow-ups) as I learn more.

## Why Leave Notion?

A few reasons:

- **Local files** - I want my notes in markdown files I control, not a proprietary database
- **Git versioning** - Every change tracked, easy backup, no vendor lock-in
- **AI flexibility** - I can point Claude Code at my vault and work with it directly
- **Performance** - Notion gets slow with large databases; local files don't

I'll miss Notion's databases and the ease of sharing. But for a personal knowledge system that I want to integrate deeply with AI tooling, local markdown feels like the right foundation.

## Try It Yourself

The framework is open source: [github.com/julien731/synapse-pkm](https://github.com/julien731/synapse-pkm)

To get started:
1. Clone the repo (or use it as a template)
2. Open it in Obsidian
3. Run `/synapse-setup` to personalize it
4. Start taking notes

If you try it, I'd love to hear what works and what doesn't. This is very much a v0.x release—feedback will shape where it goes.

## What I Don't Know

Plenty:

- Whether these principles generalize beyond my use case (CPO at a software consultancy)
- How well this works with other AI assistants (I've only tested with Claude)
- If the complexity is justified for smaller vaults
- Whether better AI tooling will make structural optimization unnecessary
- If I'll still be using this in a year

The honest answer is that I'm building this because it *seems* like the right approach based on my current understanding. That understanding will evolve. The framework will too.

---

*Synapse is named for the connection point between neurons—and by extension, the connection point between human knowledge and AI. It's also just a word that sounds nice and wasn't taken on GitHub.*

*If you found this useful, I write about product management, AI tools, and building software at [your-blog-url]. Follow along for updates on this experiment.*
