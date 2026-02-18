
This document provides configuration and operational guidance for reducing token consumption in OpenClaw. Apply these settings to `~/.openclaw/openclaw.json`.

## Problem Context

OpenClaw can consume excessive tokens due to:

1. **Context accumulation** — Tool outputs are stored in session transcripts; large outputs (e.g., `config.schema`, `status --all`) balloon context and every subsequent message pays for that history
2. **Cache misses** — If sessions go idle past the Anthropic cache TTL (5 min default), the next request re-caches the full context at higher cache-write rates
3. **Bootstrap overhead** — `AGENTS.md`, `SOUL.md`, `TOOLS.md`, etc. are injected into every system prompt (up to 20k chars each by default)
4. **No automatic cleanup** — Without pruning/reset policies, sessions accumulate indefinitely

## Configuration File Location

```bash
~/.openclaw/openclaw.json
```

Use JSON5 format (comments and trailing commas allowed).

---

## Core Optimizations

### 1. Session Pruning (Most Critical)

Automatically trims old tool results from context before each LLM call. This is the **single biggest lever** for token savings.

```json5
{
  agents: {
    defaults: {
      contextPruning: {
        mode: "cache-ttl",       // Enable TTL-aware pruning for Anthropic
        ttl: "5m",               // Match Anthropic's cache TTL
        keepLastAssistants: 3,   // Protect last 3 assistant messages from pruning
        softTrimRatio: 0.3,      // Start soft-trimming at 30% context usage
        hardClearRatio: 0.5,     // Hard-clear tool results at 50% context usage
        minPrunableToolChars: 50000,
        softTrim: {
          maxChars: 4000,
          headChars: 1500,
          tailChars: 1500
        },
        hardClear: {
          enabled: true,
          placeholder: "[Old tool result content cleared]"
        }
      }
    }
  }
}
```

**What happens:**

- `soft-trim`: Keeps head + tail of oversized tool results, inserts `...` in middle
- `hard-clear`: Replaces entire old tool results with placeholder text
- Only `toolResult` messages are affected; user/assistant messages are never modified
- Image blocks in tool results are always preserved

### 2. Automatic Session Resets

Prevents sessions from becoming stale context monsters:

```json5
{
  session: {
    reset: {
      mode: "daily",
      atHour: 4,                // Reset at 4 AM local time
      idleMinutes: 1440         // Also reset after 24 hours idle
    },
    resetByType: {
      dm: { idleMinutes: 1440 },    // DMs reset after 1 day idle
      group: { idleMinutes: 120 }   // Groups reset after 2 hours idle
    }
  }
}
```

### 3. Cache Warmth via Heartbeat

Keep the Anthropic prompt cache alive to avoid expensive re-caching. Set heartbeat interval just under your cache TTL:

```json5
{
  agents: {
    defaults: {
      models: {
        "anthropic/claude-opus-4-5": {
          params: { cacheControlTtl: "1h" }
        },
        "anthropic/claude-sonnet-4-5": {
          params: { cacheControlTtl: "1h" }
        }
      },
      heartbeat: {
        every: "55m",        // Just under the 1h cache TTL
        target: "none"       // Silent heartbeat for cache warming only
      }
    }
  }
}
```

**Note:** If `HEARTBEAT.md` is empty or contains only headers, the heartbeat run is skipped entirely (saves tokens).

### 4. Compaction with Memory Flush

Before auto-compaction, save important context to disk:

```json5
{
  agents: {
    defaults: {
      compaction: {
        mode: "safeguard",              // Chunked summarization for long histories
        reserveTokensFloor: 20000,      // Headroom for housekeeping turns
        memoryFlush: {
          enabled: true,
          softThresholdTokens: 5000     // Trigger flush 5k tokens before compaction
        }
      }
    }
  }
}
```

### 5. Bootstrap File Size Limits

Reduce system prompt overhead:

```json5
{
  agents: {
    defaults: {
      bootstrapMaxChars: 10000    // Default is 20000; reduce if workspace files are large
    }
  }
}
```

### 6. History Limits

Cap how much chat history enters context:

```json5
{
  messages: {
    groupChat: { historyLimit: 25 }   // Default is 50
  },
  channels: {
    whatsapp: { historyLimit: 30 },
    telegram: { 
      historyLimit: 25,
      dmHistoryLimit: 30 
    },
    discord: { historyLimit: 20 },
    slack: { historyLimit: 30 }
  }
}
```

### 7. Model Selection for Cost Control

**Sonnet 4.6 is now the optimal choice for most agentic workloads.** Per Anthropic's February 2026 benchmarks, Sonnet 4.6 actually outperforms Opus 4.5 in many real-world tasks:

|Benchmark|Sonnet 4.6|Opus 4.5|Winner|
|---|---|---|---|
|Office tasks (GDPval-AA)|1633|1416|**Sonnet 4.6**|
|Agentic financial analysis|63.3%|58.8%|**Sonnet 4.6**|
|Agentic computer use|72.5%|66.3%|**Sonnet 4.6**|
|Agentic tool use (Retail)|91.7%|88.9%|**Sonnet 4.6**|
|Scaled tool use|61.3%|62.3%|~Equal|

Pricing: Sonnet 4.6 is **$3/$15 per million tokens** (same as Sonnet 4.5), while Opus models cost significantly more.

**Recommended configuration:**

```json5
{
  agents: {
    defaults: {
      models: {
        "anthropic/claude-sonnet-4-6": { alias: "sonnet" },
        "anthropic/claude-opus-4-6": { alias: "opus" },
        "anthropic/claude-haiku-4-5": { alias: "haiku" }
      },
      model: {
        // Sonnet 4.6 as primary — best cost/performance for agentic work
        primary: "anthropic/claude-sonnet-4-6",
        // Opus 4.6 for complex reasoning fallback, Haiku for budget
        fallbacks: ["anthropic/claude-opus-4-6", "anthropic/claude-haiku-4-5"]
      },
      subagents: {
        // Sonnet 4.6 is cost-effective enough for sub-agents too
        model: "anthropic/claude-sonnet-4-6"
      }
    }
  }
}
```

**When to reach for Opus 4.6:**

- Deep codebase refactoring
- Coordinating multiple agents in complex workflows
- Problems requiring highest reasoning accuracy (HLE benchmark: Opus 4.6 at 53% vs Sonnet 4.6 at 49%)
- Novel problem-solving (ARC-AGI-2: Opus 4.6 at 68.8% vs Sonnet 4.6 at 58.3%)

### 8. Concurrency Limits for Token Economy

OpenClaw uses lane-based queuing with separate concurrency caps for main and sub-agent work:

|Lane|Config Key|Default|Purpose|
|---|---|---|---|
|Main|`agents.defaults.maxConcurrent`|4|All inbound messages + heartbeats (process-wide)|
|Subagent|`agents.defaults.subagents.maxConcurrent`|8|Background worker runs|

**For token optimization, lower these values:**

```json5
{
  agents: {
    defaults: {
      // Main lane: 2 is sufficient for single-user setups
      // Reduces parallel token consumption from concurrent messages
      maxConcurrent: 2,
      
      subagents: {
        // Set to 1 to prevent parallel token burn (default: 8)
        maxConcurrent: 1,
        
        // Prevent runaway fan-out from orchestrators (default: 5)
        maxChildrenPerAgent: 3,
        
        // Use cheaper model for sub-agents
        model: "anthropic/claude-sonnet-4-6"
      }
    }
  }
}
```

**Why this matters:**

- Each sub-agent has its **own context and token usage** — parallel sub-agents multiply your token burn
- Sub-agents have lighter bootstrap (only `AGENTS.md` + `TOOLS.md`, no SOUL/IDENTITY/USER/HEARTBEAT/BOOTSTRAP)
- The `maxConcurrent` settings are **safety valves**, not throughput targets — treat them as ceilings
- For research/long tasks, spawn one sub-agent at a time rather than fanning out

---

## Complete Optimized Configuration

Apply this to `~/.openclaw/openclaw.json`:

```json5
{
  agents: {
    defaults: {
      workspace: "~/clawd",
      bootstrapMaxChars: 12000,
      
      models: {
        "anthropic/claude-sonnet-4-6": { 
          alias: "sonnet",
          params: { cacheControlTtl: "1h" }
        },
        "anthropic/claude-opus-4-6": { 
          alias: "opus",
          params: { cacheControlTtl: "1h" }
        },
        "anthropic/claude-haiku-4-5": { alias: "haiku" }
      },
      
      model: {
        // Sonnet 4.6 is optimal for most agentic work at $3/$15 per million tokens
        primary: "anthropic/claude-sonnet-4-6",
        fallbacks: ["anthropic/claude-opus-4-6", "anthropic/claude-haiku-4-5"]
      },
      
      heartbeat: {
        every: "55m",
        target: "none"
      },
      
      contextPruning: {
        mode: "cache-ttl",
        ttl: "5m",
        keepLastAssistants: 3,
        softTrimRatio: 0.3,
        hardClearRatio: 0.5,
        minPrunableToolChars: 30000,
        softTrim: {
          maxChars: 4000,
          headChars: 1500,
          tailChars: 1500
        },
        hardClear: {
          enabled: true,
          placeholder: "[Old tool result content cleared]"
        }
      },
      
      compaction: {
        mode: "safeguard",
        reserveTokensFloor: 20000,
        memoryFlush: {
          enabled: true,
          softThresholdTokens: 5000
        }
      },
      
      subagents: {
        // Sonnet 4.6 is cost-effective enough for sub-agents
        model: "anthropic/claude-sonnet-4-6",
        // Set to 1 to prevent parallel token burn; default is 8
        maxConcurrent: 1,
        // Prevent runaway fan-out; default is 5
        maxChildrenPerAgent: 3
      },
      
      // Main lane concurrency (inbound messages + heartbeats)
      // Default is 4; for single-user setups, 2 is sufficient
      maxConcurrent: 2
    }
  },
  
  session: {
    reset: {
      mode: "daily",
      atHour: 4,
      idleMinutes: 1440
    },
    resetByType: {
      group: { idleMinutes: 120 }
    }
  },
  
  messages: {
    groupChat: { historyLimit: 25 }
  }
}
```

---

## Verification Commands

After applying configuration, verify with these commands:

```bash
# Validate config and check for issues
openclaw doctor

# View current status including token usage
openclaw status --usage

# Check context breakdown
# (send as chat message)
/context detail

# View per-response token usage
# (send as chat message)  
/usage tokens

# Check session status
# (send as chat message)
/status

# Manual compaction if needed
# (send as chat message)
/compact
```

---

## Operational Best Practices

### Avoid in Main DM Sessions

Never run these commands in your primary chat session (they produce huge outputs that pollute context):

- `config.schema`
- `status --all`
- Large log dumps
- Recursive directory listings

If you must run them, use a separate debug session or the CLI directly.

### Workspace File Hygiene

Keep these files lean:

- `AGENTS.md` — Agent instructions
- `SOUL.md` — Personality/behavior
- `TOOLS.md` — Tool usage guidance
- `USER.md` — User context
- `IDENTITY.md` — Identity info
- `HEARTBEAT.md` — Periodic task instructions (keep minimal or empty)

All of these are injected into every system prompt. Large files = wasted tokens on every turn.

### Session Management

```bash
# List active sessions
openclaw sessions list

# Reset a specific session
openclaw sessions reset <session-id>

# View session history
openclaw sessions history <session-id>
```

---

## Automatic Behaviors Summary

|Feature|What It Does|Trigger|
|---|---|---|
|Session pruning|Trims old tool results before LLM calls|Every request when `contextPruning.mode` is set|
|Cache-TTL pruning|Prunes when Anthropic cache expires|When session idle > `ttl`|
|Heartbeat cache warming|Keeps prompt cache alive|Every `heartbeat.every` interval|
|Daily session reset|Clears stale sessions|At `session.reset.atHour` daily|
|Idle session reset|Clears inactive sessions|After `idleMinutes` of no activity|
|Memory flush|Saves context before compaction|When approaching compaction threshold|
|Safeguard compaction|Chunked summarization|When context exceeds model limit|
|Main lane concurrency|Limits parallel inbound processing|`maxConcurrent` (default: 4, recommended: 2)|
|Sub-agent concurrency|Limits parallel background workers|`subagents.maxConcurrent` (default: 8, recommended: 1)|

---

## Troubleshooting

### High Token Usage Persists

1. Check if pruning is enabled: `openclaw status --all | grep pruning`
2. Verify config is valid: `openclaw doctor`
3. Check for bloated workspace files: `wc -c ~/clawd/*.md`
4. Reset the main session: `/new` in chat

### Context Still Growing

1. Run `/context detail` to see what's consuming tokens
2. Check if cron jobs are adding to context
3. Verify `minPrunableToolChars` isn't set too high

### Cache Misses

1. Ensure `heartbeat.every` is less than `cacheControlTtl`
2. Check if sessions are resetting too frequently
3. Verify heartbeat is running: `openclaw logs --limit 50 | grep heartbeat`

---

## References

- OpenClaw Docs: https://docs.openclaw.ai
- Sub-Agents: https://docs.openclaw.ai/tools/subagents
- Configuration: https://docs.openclaw.ai/gateway/configuration