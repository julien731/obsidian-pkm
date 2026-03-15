# Research: Centralized Runner Deployment and Team Interaction Patterns

## Purpose

This document provides deep research on two areas identified as gaps in the initial autonomous orchestration research: (1) where and how to deploy the centralized runner process, and (2) how teams of ~20 people interact with an autonomous agent orchestrator in practice. Findings are mapped to Argus's existing architecture.

## 1. Centralized Runner Architecture

### 1.1 Deployment Options Compared

| Option | Cost (monthly) | Setup Complexity | Reliability | Scaling | Best For |
|--------|---------------|-----------------|-------------|---------|----------|
| **Dedicated VPS/Cloud VM** (e.g., Hetzner, DigitalOcean, AWS EC2) | $20-100 | Low | High (always-on) | Vertical (resize VM) | MVP and production |
| **GitHub Actions self-hosted runner** | $0 (own hardware) or VM cost | Medium | Medium (runner lifecycle mgmt) | Horizontal (add runners) | Teams already on GitHub Actions |
| **Container PaaS** (Railway, Fly.io, Render) | $20-50 | Very low | Medium (cold starts, eviction) | Limited | Prototyping only |
| **Kubernetes pod** | Varies (cluster cost) | High | Very high (self-healing) | Excellent | Teams with existing K8s |
| **Dedicated CI server** (Jenkins, Buildkite) | VM cost | Medium-High | High | Good | Teams with existing CI infra |
| **Developer's local machine** | $0 | Very low | Low (machine sleeps, reboots) | None | Solo developer / testing |

**Analysis of each option:**

**Dedicated VPS/Cloud VM.** The simplest production-grade option. A single VM (4 vCPU, 8-16 GB RAM) runs the orchestrator as a systemd service or Docker container. The orchestrator creates git worktrees on the VM's local filesystem and spawns Claude Code sessions as child processes. Recovery is straightforward: the process restarts and recovers state from the PM tool (as established in the previous research). Cost is predictable. Hetzner offers a CPX31 (4 vCPU, 8 GB RAM) for ~$15/mo; a DigitalOcean droplet with similar specs runs ~$24/mo; an AWS t3.large is ~$60/mo.

**GitHub Actions self-hosted runner.** GitHub Copilot Coding Agent (see Section 1.2) uses this model. The runner registers with GitHub, listens for workflow dispatch events, and executes in the Actions runtime. Advantages: native GitHub integration, no separate auth for GitHub APIs, built-in secrets management via Actions secrets. Disadvantages: the Actions runtime has a job-oriented model (start, run, finish) rather than a long-running daemon model, which means the orchestrator must either (a) use a long-polling workflow that stays alive or (b) be triggered externally on a schedule. Self-hosted runners also require the team to manage the runner machine. For Argus's polling-based orchestrator, this model adds friction without clear benefit over a plain VM.

**Container PaaS (Railway, Fly.io, Render).** These platforms excel at web services but have limitations for Argus's use case. The orchestrator needs: (a) persistent filesystem for git worktrees, (b) long-running child processes (Claude Code sessions that run 10-60 min), (c) no request timeout constraints. Railway and Render impose process duration limits on free/hobby plans. Fly.io's Machines API supports long-running processes and persistent volumes, making it the best PaaS option. However, the overhead of containerizing Claude Code + git worktrees adds complexity. This is viable for teams that want zero-ops deployment but introduces constraints that a plain VM avoids.

**Kubernetes pod.** Overkill for most Argus deployments. The primary advantage is self-healing (pod restarts on crash) and horizontal scaling (multiple orchestrator replicas with leader election). Given that the orchestrator is designed to be stateless (recovers from PM tool on restart), K8s adds significant operational complexity for marginal reliability gain. Only justified if the team already runs a K8s cluster.

**Dedicated CI server.** Jenkins, Buildkite, or similar. These are designed for job execution, not long-running daemons. Can work if the orchestrator is modeled as a perpetually-running "build" or a frequently-triggered scheduled job. Buildkite's agent model is closer to what Argus needs (persistent agent on a machine that picks up jobs). However, this conflates CI infrastructure with agent orchestration infrastructure, which complicates operations.

### 1.2 How Existing Tools Handle Deployment

**GitHub Copilot Coding Agent.** Runs as a GitHub Actions workflow on GitHub-hosted or self-hosted runners. When a Copilot agent session is triggered (via issue assignment, PR comment, or Copilot chat), GitHub dispatches a workflow run. The workflow checks out the repo, runs the agent in a sandboxed environment, and pushes results. Key characteristics:
- GitHub manages the lifecycle entirely for hosted runners
- Each agent run is a fresh Actions job (no persistent state)
- Authentication is handled via the GitHub App token (GITHUB_TOKEN) automatically injected into the workflow
- Concurrency is managed by GitHub's queue system with concurrency groups
- The agent creates a branch, makes commits, and opens a PR, all within the Actions job
- Timeout: individual jobs have a 6-hour limit (extendable on self-hosted runners)

This model works because GitHub controls both the trigger mechanism and the execution environment. Argus cannot replicate this exactly since it operates across PM tools, but the pattern of "agent runs as a job on managed infrastructure" is informative.

**OpenAI Symphony.** Deployed as a long-running Node.js process. The README instructs users to run it on a server or VM. No container image is provided in the open-source release. It connects to Linear via API polling and spawns Codex agents as child processes. Symphony assumes the deployment machine has git, Node.js, and Codex CLI installed. This is the closest model to what Argus should adopt: a simple daemon process on a VM.

**Cline (via Claude Code).** Cline does not have a centralized runner in its open-source offering. It operates as a VS Code extension, meaning each developer runs their own instance. There is no "team mode" or centralized dispatch. Some teams have experimented with running headless VS Code + Cline on a server, but this is unofficial and fragile. This validates that Argus's centralized runner is a differentiator.

**Cursor Background Agents (launched Jan 2026, GA March 2026).** Cursor runs agents on remote VMs managed by Cursor's cloud. Each agent gets a cloud sandbox with the repo cloned, runs autonomously, and produces a PR. The user sees status in the Cursor UI. This is a fully managed model that Argus cannot replicate (it requires Cursor's infrastructure), but the UX patterns (status visibility, PR as output) are relevant.

**Factory.ai / Codegen / Sweep.** These are SaaS platforms that manage their own runner infrastructure. Users connect their GitHub repos, and agents run on the vendor's cloud. The deployment model is "sign up and connect your repo." Argus targets a self-hosted model, so these are not directly comparable, but they validate the market for centralized agent runners.

### 1.3 Minimal Viable Deployment Recommendation

For a team of 20, the recommended deployment is:

**A single cloud VM (4-8 vCPU, 16 GB RAM) running the orchestrator as a systemd service.**

Setup:
1. Provision a VM (Ubuntu 24.04) on any cloud provider
2. Install dependencies: Node.js, git, Claude Code CLI
3. Clone the target repository
4. Configure environment variables (API keys, PM tool tokens)
5. Start the orchestrator via systemd (auto-restart on crash)
6. Set up log shipping to the team's logging tool (optional)

This can be operational in under an hour. No container registry, no Kubernetes, no CI integration required.

### 1.4 Authentication and Secrets Management

The runner needs credentials for four systems:

| System | Auth Method | Secret Type | Rotation |
|--------|------------|-------------|----------|
| **GitHub** (branches, PRs, code) | GitHub App installation | Auto-rotating installation token | Auto (1-hour expiry) |
| **PM Tool** (Shortcut, Linear, etc.) | Per-user API tokens | User-specific secrets | Varies by tool |
| **LLM API** (Claude) | API key | `ANTHROPIC_API_KEY` | On demand |
| **MCP Servers** | Varies per server | Server-specific | Varies |

#### Identity Model: Bot for Code, User for PM Actions

The runner operates with a **split identity model**:

- **Code operations** (commits, branches, PRs): Attributed to the **Argus Bot** via a GitHub App. This clearly distinguishes AI-generated code from human work in git history. Human reviewers act under their own name when reviewing/approving PRs.
- **PM tool operations** (story status changes, comments, assignments): Attributed to the **individual user** who owns the story. This preserves accurate audit trails in the PM tool — the team sees "Sarah moved US-042 to In Progress" rather than "argus-bot moved US-042 to In Progress."

This split is necessary because PM tools like Shortcut use per-user API tokens. Actions performed with a user's token are attributed to that user. There is no "bot account" concept in Shortcut — you'd need a paid seat for a service account.

#### Per-User Token Vault

Since PM tool actions must be attributed to individual users, the runner needs a **token vault** where team members register their PM tool credentials:

- Each team member provides their PM tool API token to the runner (one-time setup)
- When the orchestrator acts on a story, it uses the token of the story's assignee (or the person who moved it to "Ready")
- Tokens are stored encrypted at rest on the runner
- If a user's token is missing or expired, the orchestrator skips their stories and notifies them

**v1 implementation:** Encrypted file on disk (e.g., `~/.argus/tokens.enc` with a master key from environment variable). Team members register via `argus register-token --tool shortcut --token <token>`.

**v2 implementation:** Integration with a secrets manager (AWS Secrets Manager, HashiCorp Vault, 1Password CLI) for teams with stricter security requirements.

#### GitHub App for Code Operations

A GitHub App provides:
- Fine-grained permissions (only the repos and scopes needed)
- Auto-rotating installation tokens (1-hour expiry, auto-refreshed)
- Clear audit trail (actions attributed to the App, not a person)
- No seat consumption (the App is not a user)

#### MCP Server Authentication

Depends on the specific servers. Playwright MCP needs no external auth. If the team adds MCP servers for external services (Slack, databases), each server's auth must be configured in the runner's environment.

### 1.5 Failure and Recovery

| Scenario | Impact | Recovery |
|----------|--------|----------|
| **Orchestrator process crash** | In-flight agent sessions are orphaned | systemd restarts the process. Orchestrator scans PM tool for "In Progress" stories and resumes or restarts them. Orphaned Claude Code processes are killed on startup. |
| **VM reboot** | All state lost | Same as crash recovery. Git worktrees persist on disk. Orchestrator re-evaluates each worktree's state on boot. |
| **VM disk full** | Agent sessions fail with I/O errors | Monitoring alert triggers. Worktree cleanup frees space. Implement a disk usage check before dispatching new stories. |
| **Network outage** | API calls fail (PM tool, LLM, GitHub) | Retry with exponential backoff. Agent sessions pause. Orchestrator poll loop continues retrying. |
| **GitHub App token expires** | API calls return 401 | GitHub App tokens auto-rotate. If the App itself is revoked, manual intervention is needed. |
| **LLM API outage** | Agent sessions hang or fail | Agent-level timeout triggers. Story is retried after backoff. |

**Key design principle:** The orchestrator must be crash-safe. Since all durable state lives in the PM tool (story statuses) and git (branches, worktrees), the orchestrator can be killed and restarted at any time without data loss. This is already established in the previous research (Symphony pattern) and is the most important reliability property.

**Orphaned process cleanup:** On startup, the orchestrator should:
1. List all existing git worktrees
2. For each worktree, check if the corresponding story is still "In Progress"
3. Kill any Claude Code processes associated with stale worktrees
4. Either resume or clean up each worktree based on story state

## 2. Team Interaction Patterns

### 2.1 Ownership Signal: Human vs. AI Working on a Story

The PM tool must clearly indicate whether a human or the AI orchestrator is working on a given story. This prevents conflicts (two actors working on the same story) and provides visibility to the team.

**Options compared:**

| Approach | Pros | Cons | Used By |
|----------|------|------|---------|
| **Label/Tag** (e.g., `ai-assigned`) | Simple, visible in list views, filterable | Can be accidentally removed, no mutual exclusion | Copilot Coding Agent uses `copilot` label |
| **Assignee** (assign to bot account) | Clear ownership, natural PM tool semantics, blocks human self-assignment | Consumes a seat (for user-based tools), less visible than a label | Cursor Background Agents |
| **Custom field** (e.g., "Worker: AI / Human") | Explicit, queryable, no seat cost | Requires custom field setup, not visible at a glance in all PM tools | Symphony (via Linear custom fields) |
| **Status sub-state** (e.g., "In Progress - AI", "In Progress - Human") | Very visible, naturally groups items | Pollutes the status workflow, harder to change | No major tool uses this |

**Recommendation for Argus:** Use a **combination of assignee + label**.

- **Assignee:** The orchestrator's GitHub App becomes the assignee when it picks up a story. This provides natural mutual exclusion: a story assigned to the bot is clearly "AI is working on this." When a human wants to take over, they reassign to themselves.
- **Label:** Apply an `argus:in-progress` label when the orchestrator starts work. This is filterable and visible in board views without inspecting the assignee. Remove the label when work completes.

GitHub Copilot Coding Agent uses a similar pattern: it adds a `copilot` label to issues it is working on, and the Copilot bot appears as the PR author.

### 2.2 Handoff Between Human and AI

Four handoff scenarios exist:

**Scenario 1: Human starts, hands off to AI.**
A developer starts a story, gets stuck or deprioritizes it. They want the AI to finish.
- Pattern: Developer moves the story back to "Ready" status, removes themselves as assignee, and adds a label like `ai-handoff`. The orchestrator picks it up on the next poll. The existing branch and any commits are preserved in the worktree.
- Consideration: The orchestrator must handle a non-empty branch (existing code to build on). The agent's system prompt should include "continue from existing implementation" context.

**Scenario 2: AI completes, human iterates on the PR.**
The orchestrator produces a PR. A reviewer wants changes.
- Pattern: This is the standard PR review flow. The reviewer leaves comments. Two sub-options:
  - **(a) Human makes the changes:** The reviewer pushes commits directly to the AI's branch. This is the simplest path and requires no orchestrator involvement.
  - **(b) AI addresses review feedback:** The reviewer adds a label like `argus:revise` or comments with a trigger phrase (e.g., `/argus fix`). The orchestrator detects this, spins up a new agent session on the existing branch, and the agent addresses the review comments. GitHub Copilot Coding Agent supports this: commenting `@copilot` on a PR review triggers the agent to address feedback.
- **Recommendation:** Support both. Default to (a) for v1. Add (b) as a v2 feature, since it requires the orchestrator to monitor PR comments in addition to story statuses.

**Scenario 3: AI gets stuck, escalates to human.**
The agent fails after max retries or hits an ambiguity it cannot resolve.
- Pattern: The orchestrator moves the story to a "Blocked" or "Needs Attention" status, adds a label like `argus:stuck`, posts a comment on the story explaining what went wrong and where it stopped, and sends a notification (see Section 2.5). A human investigates, fixes the blocker, and either completes the work manually or moves the story back to "Ready" for the AI to retry.

**Scenario 4: Human and AI working on related stories simultaneously.**
See Section 4.1 for detailed treatment.

### 2.3 PR Assignment and Review Routing

With 20 team members and potentially many AI-generated PRs per day, review routing is critical to avoid bottlenecks and ensure quality.

**Options compared:**

| Approach | How It Works | Pros | Cons |
|----------|-------------|------|------|
| **Story assignee reviews** | The person who wrote/owns the spec reviews the AI's PR | Domain context, accountability | Single point of failure, bottleneck |
| **CODEOWNERS** | GitHub's CODEOWNERS file routes reviews by file path | Automatic, scales with codebase | Requires maintaining CODEOWNERS, may route to overloaded reviewers |
| **Round-robin** | Rotate through the team | Even distribution | No domain context, random reviewer may lack context |
| **Team-based routing** | PRs for `frontend/` go to frontend team, etc. | Domain expertise | Requires team structure definition, overhead |
| **PM tool assignment** | The PM tool's "reviewer" field determines who reviews | Explicit control, set during planning | Extra field to maintain |

**How existing tools handle this:**

- **GitHub Copilot Coding Agent:** Uses CODEOWNERS and repository review assignment rules. The PR is created by the Copilot bot and review is requested from CODEOWNERS-matched reviewers automatically.
- **Stripe Minions:** The engineer who invoked the minion is the implicit reviewer (since minions are invoked by individuals, not a centralized orchestrator).
- **Cursor Background Agents:** The user who started the agent session is the implicit reviewer.

**Recommendation for Argus:** Use a **layered approach**:

1. **Primary:** If the story has an assignee (the human who wrote/approved the spec), request review from them. They have the most context.
2. **Fallback:** If no assignee, or if the assignee is unavailable, use CODEOWNERS.
3. **Override:** Allow a `reviewer` field in the story (custom field in GitHub Projects) to explicitly set the reviewer.

This matches how teams naturally work: the person who defined the requirement is best positioned to verify the implementation.

### 2.4 Dashboard and Observability

**What a team of 20 needs to see:**

| Information | Why | Update Frequency |
|-------------|-----|-----------------|
| **Active agent sessions** (which stories, current blueprint step, duration) | Know what the AI is doing right now | Real-time (5s refresh) |
| **Queue** (stories in "Ready" waiting for dispatch) | Understand backlog and prioritization | On poll (30s) |
| **Recent completions** (PRs opened in last 24h, pass/fail) | Track throughput and quality | On completion |
| **Failures/escalations** (stuck stories, failed runs) | Immediate attention needed | On failure |
| **Resource usage** (concurrent sessions, token costs today/this week) | Budget management | Aggregated hourly |

**Existing dashboard patterns:**

- **OpenAI Symphony:** Provides a "status surface" that is a simple CLI output showing active runs, their states, and recent completions. No web UI in the open-source version.
- **Cursor Background Agents:** Shows a panel in the Cursor IDE with agent status (running, completed, failed), a timeline of actions taken, and a link to the resulting PR.
- **GitHub Copilot:** Status is visible directly on the GitHub issue (comments showing progress) and the resulting PR. No separate dashboard.

**Recommendation for Argus v1:** A **CLI-based status surface** (similar to Symphony) that shows:

```
Argus Orchestrator — 3/5 slots active — $12.40 today

ACTIVE
  US-042  feature/user-notifications   [IMPLEMENT]  12m elapsed   ████████░░
  US-044  feature/export-csv           [CI-WAIT]     3m elapsed   ██████████
  US-047  feature/dashboard-filters    [RESEARCH]    1m elapsed   ██░░░░░░░░

QUEUE (Ready)
  US-048  Search pagination             Priority: Must-have
  US-051  Error boundary components     Priority: Should-have

COMPLETED TODAY
  US-039  ✓ PR #287 opened — awaiting review (assigned: @sarah)
  US-041  ✓ PR #289 opened — awaiting review (assigned: @mike)
  US-043  ✗ Failed at [CI-FIX] — escalated to @alex

FAILED
  US-043  Lint errors after 2 fix attempts — label: argus:stuck
```

This can be an `argus status` CLI command that reads orchestrator state and renders it. A web dashboard is a v2 concern.

### 2.5 Notification Patterns

| Event | Channel | Recipients | Priority |
|-------|---------|------------|----------|
| **PR ready for review** | GitHub notification (native) + Slack | Story assignee / CODEOWNERS | Normal |
| **Agent failed/stuck** | Slack + GitHub issue comment | Story assignee + team channel | High |
| **Story completed** | GitHub issue comment | Story assignee | Low |
| **Merge conflict detected** | Slack + GitHub PR comment | Story assignee | High |
| **Cost threshold exceeded** | Slack | Team lead / admin | High |
| **Orchestrator down** | External uptime monitor (e.g., Uptime Robot) | Admin | Critical |

**Integration approach:**

- **GitHub notifications are automatic:** Creating PRs, requesting reviews, and commenting on issues all trigger GitHub's built-in notification system. No additional integration needed.
- **Slack integration:** A single Slack webhook that posts to a dedicated channel (e.g., `#argus-activity`). Messages include: story ID, event type, link to PR/issue, and any actionable context. For high-priority events (failures, conflicts), use Slack's `@here` mention or thread the notification to the story assignee.
- **No email:** GitHub and Slack cover notification needs. Email adds latency without value for this use case.

**Recommendation:** v1 uses GitHub-native notifications only (zero additional integration). v2 adds a Slack webhook for failure/escalation events. This is sufficient for a 20-person team.

### 2.6 Priority and Queue Management

The orchestrator dispatches stories in priority order (as established in the previous research). The team needs ways to influence the queue.

**Queue control mechanisms:**

| Action | How | Implementation |
|--------|-----|---------------|
| **Bump priority** | Change story priority in PM tool (Critical > High > Medium > Low) | Orchestrator reads priority on each poll; higher priority stories are dispatched first |
| **Pause a story** | Move story from "In Progress" back to "Ready" or add `argus:pause` label | Orchestrator detects status/label change, gracefully stops the agent session, preserves the worktree |
| **Cancel an in-flight run** | Move story to "Won't Do" or add `argus:cancel` label | Orchestrator kills the agent session, cleans up the worktree, updates story status |
| **Skip a story** | Add `argus:skip` label | Orchestrator ignores the story during dispatch even if it is in "Ready" status |
| **Force immediate dispatch** | Add `argus:urgent` label | Orchestrator dispatches on next poll, even if at concurrency limit (bumps lowest-priority active session to queue) |

**Key principle:** The PM tool is the control plane. All queue management happens through the PM tool's native interface (status changes, labels, priority fields). The orchestrator does not have its own control interface -- it reads intent from the PM tool. This means any team member can influence the queue without learning a new tool.

## 3. Concurrency and Scaling for 20-Person Teams

### 3.1 Realistic Concurrency Modeling

In a 20-person team using Argus's full workflow (BA specs -> PM stories -> autonomous execution):

- **Spec throughput:** A BA agent produces 1-3 specs per day. Each spec yields 3-8 stories. Assuming 2 specs/day with 5 stories each, that is ~10 stories entering "Ready" per day.
- **Burst scenario:** After a planning session, a PM agent could create 20-40 stories at once. Not all will be "Ready" immediately (dependencies, human gates on specs/stories).
- **Realistic "Ready" queue:** At any given time, 5-15 stories might be in "Ready" status, with 3-8 actively being worked on by agents.
- **Agent session duration:** Based on industry data (Stripe: minutes to hours; OpenAI Harness: up to 6 hours), an Argus blueprint run for an S/M story likely takes 15-45 minutes. L stories could take 1-2 hours.

**Concurrency ceiling recommendation:**

| Team Size | Concurrent Sessions | Rationale |
|-----------|-------------------|-----------|
| 1-5 people | 2-3 | Limited story throughput, review bandwidth is the bottleneck |
| 6-15 people | 3-5 | Moderate throughput, enough reviewers to absorb PR volume |
| 16-25 people | 5-8 | High throughput, must ensure review bandwidth matches |
| 25+ people | 8-12 | Consider multiple runner instances |

For a 20-person team: **start with 5 concurrent sessions, scale to 8 based on review throughput.** If PRs queue up waiting for review, adding more concurrent sessions wastes resources.

### 3.2 Resource Requirements

| Concurrent Sessions | CPU | RAM | Disk | Claude API Cost (est.) |
|---------------------|-----|-----|------|----------------------|
| 3 | 4 vCPU | 8 GB | 20 GB | $30-90/day |
| 5 | 6-8 vCPU | 16 GB | 30 GB | $50-150/day |
| 8 | 8-12 vCPU | 24-32 GB | 50 GB | $80-240/day |

**Cost breakdown per story** (estimated, varies heavily by story complexity):
- S-size story: $3-10 in API costs, 15-30 min runtime
- M-size story: $10-30 in API costs, 30-60 min runtime
- L-size story: $30-80 in API costs, 1-3 hours runtime

**Disk usage:** Each git worktree shares objects with the main repo, so disk overhead per worktree is small (a few MB for the working directory). The main cost is `node_modules` or equivalent dependency directories if each worktree needs its own install. For a typical JS project, budget 200-500 MB per worktree for dependencies.

### 3.3 Horizontal vs. Vertical Scaling

| Approach | How | When |
|----------|-----|------|
| **Vertical** (bigger VM) | Increase CPU/RAM on the single VM | Up to ~8 concurrent sessions |
| **Horizontal** (multiple runners) | Multiple VMs, each running an orchestrator instance with partition awareness | Beyond 8 sessions or multi-repo setups |

**Horizontal scaling requires coordination:** If two orchestrator instances poll the same PM tool, they must avoid both picking up the same story. Solutions:
- **Partition by label:** Each runner instance is configured to handle stories with a specific label (e.g., `runner-1`, `runner-2`).
- **Claim-based dispatch:** When a runner picks up a story, it immediately updates the story status/assignee, and other runners skip claimed stories. Race condition window is small (one poll interval) and can be mitigated with optimistic locking.
- **Shared queue with locking:** Use a lightweight coordinator (Redis, a shared file) to manage the queue. Adds infrastructure complexity.

**Recommendation:** Vertical scaling for v1 (up to 8 concurrent sessions on a single VM). This handles 20-person teams comfortably. Horizontal scaling is a v2 concern for larger organizations or multi-repo setups.

### 3.4 Burst Handling

After a planning session, 15+ stories may become "Ready" simultaneously. The orchestrator should:

1. **Queue, not reject.** Stories beyond the concurrency limit wait in the "Ready" queue. The orchestrator dispatches them as slots open.
2. **Priority-aware dispatch.** Must-have stories go first, regardless of when they entered the queue.
3. **No special burst mode.** The bounded concurrency limit exists precisely for this scenario. Bursting past it risks resource exhaustion and degraded agent quality (context window pressure from resource contention).
4. **Estimated wait times.** The CLI status surface should show estimated dispatch time based on current session durations and queue position.

## 4. Human-AI Collaboration Patterns

### 4.1 Concurrent Work on Related Code

When a human developer and an AI agent (or two AI agents) work on stories that touch the same files:

**Prevention (preferred):**
- The PM agent should identify file-level overlap during story creation and mark dependencies. Stories with overlapping file areas should be sequenced, not parallelized.
- The orchestrator should maintain a "touched files" registry: when an agent session starts, it declares (or the blueprint predicts) which files it will modify. New sessions check for overlap and defer if conflicts are likely.
- Heuristic: stories in the same epic that modify the same module should be dispatched sequentially.

**Detection:**
- When a PR is opened, GitHub automatically shows merge conflicts. The orchestrator should check for conflicts against all open AI-generated PRs and in-progress branches.
- If a human is working on a branch that overlaps with an AI branch, the merge conflict will surface at PR time. No special detection is needed beyond standard git workflow.

**Resolution:**
- For AI-AI conflicts: The orchestrator pauses the later story, merges/rebases the earlier one first, then re-dispatches the later story on the updated base.
- For human-AI conflicts: The human takes priority. The AI branch is rebased onto the human's merged changes. If rebase fails, the story is escalated.

### 4.2 Human Fixing an AI-Generated PR

A developer wants to manually adjust code in an AI-generated PR before merging:

- **Direct push to the branch:** The simplest approach. The developer checks out the AI's branch, makes changes, pushes. The PR updates. No orchestrator involvement needed.
- **Co-authoring:** The developer's commits appear alongside the AI's commits. Git history clearly shows what was AI-generated vs. human-modified.
- **Orchestrator should not interfere:** Once a PR is in "In Review" status, the orchestrator should not touch the branch unless explicitly asked (via `argus:revise` label).

### 4.3 Preventing Inappropriate Story Dispatch

Not all "Ready" stories should be auto-dispatched. The orchestrator should skip stories that need human judgment.

**Filter rules:**

| Filter | How to Implement | Rationale |
|--------|-----------------|-----------|
| **Size threshold** | Skip stories sized L or XL | Large stories have higher failure rates and waste tokens on failure |
| **Complexity label** | Skip stories with `needs-discussion` or `complex` labels | Team explicitly flags stories needing human input |
| **Story type** | Skip spikes, research tasks, and infrastructure stories | These require judgment, not just code generation |
| **Missing acceptance criteria** | Skip stories without AC | Agent needs clear success criteria |
| **Dependency on unmerged PR** | Skip if a dependency story's PR is not yet merged | Building on unmerged code risks rework |

**Configuration in `.argus/config.yml`:**

```yaml
autonomous:
  dispatch_filters:
    max_size: M              # Skip L and XL stories
    skip_labels:             # Skip stories with these labels
      - needs-discussion
      - spike
      - infrastructure
    require_acceptance_criteria: true
    require_dependencies_merged: true
```

### 4.4 Escalation Model

When should the AI escalate to a human, and how?

**Escalation triggers:**

| Trigger | Detection | Escalation Channel |
|---------|-----------|-------------------|
| Agent exceeds max retries | Blueprint retry counter | GitHub issue comment + Slack |
| Ambiguous requirements | Agent detects contradictory AC or missing information | GitHub issue comment asking for clarification |
| Token budget exceeded | Orchestrator cost tracking | Slack notification to admin |
| Architectural decision needed | Agent detects it needs to choose between non-trivial approaches | GitHub issue comment with options |
| Test environment unavailable | QA blueprint step fails to connect | Slack notification |
| Merge conflict cannot be auto-resolved | Git rebase fails | GitHub PR comment + Slack |

**Escalation protocol:**
1. The agent/orchestrator posts a structured comment on the GitHub issue describing: what was attempted, what failed, what help is needed.
2. The story status changes to "Blocked" or a label `argus:needs-human` is applied.
3. A Slack notification is sent to the story assignee (or team channel if no assignee).
4. The orchestrator frees the concurrency slot and moves on to other stories.
5. When the human resolves the issue and moves the story back to "Ready," the orchestrator re-dispatches it.

**Key principle:** Escalation should be fast and cheap. An agent that is stuck for 10 minutes and retrying is worse than an agent that escalates after 2 failed attempts. Token cost of a stuck agent far exceeds the time cost of a human intervention.

## 5. Consolidated Recommendations for Argus

### Deployment
1. **v1: Single VM** (4-8 vCPU, 16 GB RAM) running the orchestrator as a systemd service. Use a GitHub App for authentication.
2. **v2: Docker container** on the same VM for reproducible deployment. Optional Fly.io support for teams that want managed hosting.
3. **v3: Horizontal scaling** with claim-based dispatch for multi-repo or high-throughput teams.

### Team Interaction
1. **Ownership:** GitHub App as assignee + `argus:in-progress` label.
2. **Handoff:** Status-based (move to "Ready" for AI pickup, move to "Blocked" for human attention).
3. **Review routing:** Story assignee first, CODEOWNERS fallback.
4. **Notifications:** GitHub-native for v1, Slack webhook for v2.
5. **Queue control:** All via PM tool (priority field, labels, status changes).

### Concurrency
1. **Start with 5 concurrent sessions** for a 20-person team.
2. **Scale vertically** (bigger VM) up to 8 sessions.
3. **Budget $50-150/day** in API costs for 5 concurrent sessions.
4. **Do not add concurrency if PRs are queueing for review** -- review bandwidth is usually the bottleneck, not agent throughput.

### Collaboration
1. **Prevent conflicts** via dependency-aware dispatch and file-overlap prediction.
2. **Filter stories** by size, labels, and completeness before dispatch.
3. **Escalate fast** -- 2 failed attempts, then hand to human.
4. **Do not interfere** with PRs in review unless explicitly asked.

## References

- GitHub Copilot Coding Agent documentation: https://docs.github.com/en/copilot/using-github-copilot/using-copilot-coding-agent
- OpenAI Symphony: https://github.com/openai/symphony
- Cursor Background Agents: https://docs.cursor.com/background-agent
- Stripe Minions (Part 1): https://stripe.dev/blog/minions-stripes-one-shot-end-to-end-coding-agents
- Stripe Minions (Part 2): https://stripe.dev/blog/minions-stripes-one-shot-end-to-end-coding-agents-part-2
- OpenAI Harness Engineering: https://openai.com/index/harness-engineering/
- GitHub Apps authentication: https://docs.github.com/en/apps/creating-github-apps/authenticating-with-a-github-app
- Fly.io Machines (long-running processes): https://fly.io/docs/machines/
- systemd service management: https://www.freedesktop.org/software/systemd/man/systemd.service.html
