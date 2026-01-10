---
type: resource
created: 2026-01-10
status: active
source: n8n
summary: Article arguing that AI coding agents require strict engineering practices (tests, types, modularity) as automated guardrails to be effective.
tags:
  - ai
  - coding
  - software-engineering
migrated_from: notion
migrated_at: 2026-01-10
---

# AI Is Forcing Us To Write Good Code - by Steve Krenzel

Article by Steve Krenzel on how AI coding agents force teams to finally invest in rigorous engineering practices. Source: [bits.logic.inc](https://bits.logic.inc/p/ai-is-forcing-us-to-write-good-code)

## Key takeaway

AI coding agents are powerful but brittle, so to use them effectively you must turn previously “optional” engineering best practices into strict, automated constraints that reduce ambiguity and degrees of freedom.[](https://bits.logic.inc/p/ai-is-forcing-us-to-write-good-code)​

## Core ideas

- **Agents need structure, not heroics**
    
    - Humans can hack something together and clean it up later; agents tend to amplify existing messes (“Roomba dragging poop around the house”).[](https://bits.logic.inc/p/ai-is-forcing-us-to-write-good-code)​
        
    - The only real safety comes from guardrails you explicitly **set** and **enforce**: tests, types, linters, clear interfaces, and environments that make bad states impossible or obvious.[](https://bits.logic.inc/p/ai-is-forcing-us-to-write-good-code)​
        
- **100% test coverage as a phase change**
    
    - The team enforces 100% code coverage not as a bug-free guarantee, but as a mechanism to ensure every line an agent writes is exercised by tests.[](https://bits.logic.inc/p/ai-is-forcing-us-to-write-good-code)​
        
    - At exactly 100%, any uncovered line is unambiguous new work, turning the coverage report into a todo list for tests and removing judgment calls about what is “important enough” to test.[](https://bits.logic.inc/p/ai-is-forcing-us-to-write-good-code)​
        
- **Filesystem and modularity as an API for agents**
    
    - Agents navigate mainly via the filesystem: listing directories, reading filenames, grepping, and loading files into context.[](https://bits.logic.inc/p/ai-is-forcing-us-to-write-good-code)​
        
    - Meaningful names and small, well-scoped files (e.g., `billing/invoices/compute.ts` instead of `utils/helpers.ts`) act as a semantic map that improves retrieval, context loading, and performance.[](https://bits.logic.inc/p/ai-is-forcing-us-to-write-good-code)​
        
- **Fast, ephemeral, concurrent dev environments**
    
    - Guardrails (tests, checks) must be very fast so agents can run them constantly in tight loops: small change → run suite → fix → repeat.[](https://bits.logic.inc/p/ai-is-forcing-us-to-write-good-code)​
        
    - The team uses one-command workflows that spin up fresh worktrees with config, dependencies, and an agent ready to work, making environments ephemeral and cheap to create and destroy.[](https://bits.logic.inc/p/ai-is-forcing-us-to-write-good-code)​
        
    - Environments must run concurrently without conflicts (ports, DBs, caches), often via config and containerization, so many agent sessions can execute in parallel.[](https://bits.logic.inc/p/ai-is-forcing-us-to-write-good-code)​
        
- **End-to-end types and automated constraints**
    
    - As many best practices as possible are enforced automatically: strict linters/formatters, typed languages, and checks that run on every agent task or commit.[](https://bits.logic.inc/p/ai-is-forcing-us-to-write-good-code)​
        
    - Types (especially in TypeScript) shrink the search space for the LLM, encode domain semantics in names (`UserId`, `WorkspaceSlug`, `SignedWebhookPayload`), and act as executable documentation.[](https://bits.logic.inc/p/ai-is-forcing-us-to-write-good-code)​
        
    - The stack uses OpenAPI for typed API clients, Postgres types and constraints (plus triggers) for data invariants, and strongly typed clients/wrappers for third-party services, so invalid actions surface as clear failures.[](https://bits.logic.inc/p/ai-is-forcing-us-to-write-good-code)​
        
- **Big picture takeaway**
    
    - AI agents are “tireless, often brilliant coders,” but only as effective as the environment around them.[](https://bits.logic.inc/p/ai-is-forcing-us-to-write-good-code)​
        
    - Moving to agentic development is an excuse—and a forcing function—to finally invest in the rigorous codebase (tests, structure, types, tooling) that many teams have deferred for years.[](https://bits.logic.inc/p/ai-is-forcing-us-to-write-good-code)​