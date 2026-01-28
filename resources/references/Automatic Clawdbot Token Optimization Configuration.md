## Why Clawdbot Burns Through Tokens

The main culprits:

1. **Context accumulation** — Clawdbot stores all tool outputs in the session transcript. Commands with huge outputs (like `config.schema` or `status --all`) balloon the context, and every subsequent message pays for that accumulated history.
2. **Bootstrap files** — On every run, Clawdbot injects `AGENTS.md`, `SOUL.md`, `TOOLS.md`, `IDENTITY.md`, `USER.md`, etc. into the system prompt, up to 20k characters by default.
3. **Cache misses** — If a session goes idle past the cache TTL (5 min for Anthropic), the next request re-caches the full context at the higher cache-write rate.
4. **Cron jobs** — Even "no-op" heartbeat/cron runs can consume tokens if they trigger agent turns.
## Token Optimization Configuration

The good news: Clawdbot has several built-in mechanisms that work automatically once configured. You can set these up in `~/.clawdbot/clawdbot.json` and forget about them.

### 1. Session Pruning (Most Important)

This automatically trims old tool results from context before each LLM call. It's **the biggest lever** for reducing token waste from accumulated tool outputs.

```json5
{
  agents: {
    defaults: {
      contextPruning: {
        mode: "cache-ttl",    // Enables TTL-aware pruning for Anthropic
        ttl: "5m",            // Match your cache TTL
        keepLastAssistants: 3,
        softTrimRatio: 0.3,   // Start soft-trimming at 30% context
        hardClearRatio: 0.5,  // Hard-clear at 50% context
        minPrunableToolChars: 50000,
        softTrim: {
          maxChars: 4000,
          headChars: 1500,
          tailChars: 1500
        },
        hardClear: {
          enabled: true,
          placeholder: "[Old tool result content cleared]"
        },
        // Optionally exclude specific tools from pruning
        tools: { deny: ["browser", "canvas"] }
      }
    }
  }
}
```

**Smart defaults for Anthropic users**: If you're using OAuth or setup-token auth, Clawdbot automatically enables `cache-ttl` pruning and sets heartbeat to 1h. With API keys, it defaults to 30m heartbeat and 1h cache TTL.

### 2. Automatic Session Reset

Prevents sessions from becoming stale context monsters. Sessions automatically reset daily and/or after idle periods:

```json5
{
  session: {
    reset: {
      mode: "daily",
      atHour: 4,              // Reset at 4 AM local time
      idleMinutes: 10080      // Also reset after 7 days idle
    },
    // Per-session-type overrides
    resetByType: {
      dm: { idleMinutes: 1440 },     // DMs reset after 1 day idle
      group: { idleMinutes: 60 }     // Groups reset after 1 hour idle
    }
  }
}
```

### 3. Cache Warmth with Heartbeat

Keep the Anthropic prompt cache warm to avoid expensive re-caching. Set heartbeat interval just under your cache TTL:

```json5
{
  agents: {
    defaults: {
      model: {
        primary: "anthropic/claude-opus-4-5"
      },
      models: {
        "anthropic/claude-opus-4-5": {
          params: {
            cacheControlTtl: "1h"
          }
        }
      },
      heartbeat: {
        every: "55m"    // Just under the 1h cache TTL
      }
    }
  }
}
```

### 4. Auto-Compaction with Memory Flush

Before auto-compaction kicks in, Clawdbot can silently save important context to disk so it survives summarization:

```json5
{
  agents: {
    defaults: {
      compaction: {
        mode: "safeguard",           // Chunked summarization for long histories
        reserveTokensFloor: 20000,   // Headroom for housekeeping turns
        memoryFlush: {
          enabled: true,
          softThresholdTokens: 6000, // Trigger flush this far before compaction
          systemPrompt: "Session nearing compaction. Store durable memories now.",
          prompt: "Write any lasting notes to memory/YYYY-MM-DD.md; reply with NO_REPLY if nothing to store."
        }
      }
    }
  }
}
```

### 5. Bootstrap File Size Limits

Reduce the system prompt overhead by capping how much of your workspace files get injected:

```json5
{
  agents: {
    defaults: {
      bootstrapMaxChars: 10000  // Default is 20000, reduce if your files are bloated
    }
  }
}
```

### 6. Model Fallbacks for Cost Control

Use cheaper models for non-critical work automatically:

```json5
{
  agents: {
    defaults: {
      models: {
        "anthropic/claude-opus-4-5": { alias: "opus" },
        "anthropic/claude-sonnet-4-5": { alias: "sonnet" },
        "anthropic/claude-haiku-4-5": { alias: "haiku" }
      },
      model: {
        primary: "anthropic/claude-sonnet-4-5",  // Default to Sonnet
        fallbacks: ["anthropic/claude-haiku-4-5"]
      },
      // Use cheaper model for sub-agents
      subagents: {
        model: "anthropic/claude-haiku-4-5"
      }
    }
  }
}
```

### 7. Disable/Tune Token-Hungry Features

```json5
{
  agents: {
    defaults: {
      // Reduce heartbeat frequency if you don't need proactive updates
      heartbeat: {
        every: "2h"  // Or "0m" to disable entirely
      }
    }
  },
  // Limit group message history context
  messages: {
    groupChat: { historyLimit: 20 }  // Default is 50
  },
  channels: {
    telegram: { dmHistoryLimit: 30 },
    whatsapp: { historyLimit: 20 }
  }
}
```

---

## Complete Token-Optimized Configuration Template

Here's a comprehensive config combining all the automatic optimizations:

```json5
{
  agents: {
    defaults: {
      workspace: "~/clawd",
      bootstrapMaxChars: 12000,
      
      // Model setup with cost-conscious defaults
      models: {
        "anthropic/claude-opus-4-5": { alias: "opus" },
        "anthropic/claude-sonnet-4-5": { alias: "sonnet" },
        "anthropic/claude-haiku-4-5": { alias: "haiku" }
      },
      model: {
        primary: "anthropic/claude-sonnet-4-5",
        fallbacks: ["anthropic/claude-haiku-4-5"]
      },
      
      // Cache optimization
      models: {
        "anthropic/claude-sonnet-4-5": {
          params: { cacheControlTtl: "1h" }
        }
      },
      
      // Keep cache warm
      heartbeat: {
        every: "55m",
        target: "none"  // Silent heartbeat, just for cache warming
      },
      
      // Automatic context pruning
      contextPruning: {
        mode: "cache-ttl",
        ttl: "5m",
        keepLastAssistants: 3,
        softTrimRatio: 0.3,
        hardClearRatio: 0.5,
        minPrunableToolChars: 30000
      },
      
      // Compaction with memory preservation
      compaction: {
        mode: "safeguard",
        reserveTokensFloor: 20000,
        memoryFlush: {
          enabled: true,
          softThresholdTokens: 5000
        }
      },
      
      // Cheaper sub-agents
      subagents: {
        model: "anthropic/claude-haiku-4-5",
        maxConcurrent: 1
      }
    }
  },
  
  // Automatic session resets
  session: {
    reset: {
      mode: "daily",
      atHour: 4,
      idleMinutes: 1440  // 24 hours
    },
    resetByType: {
      group: { idleMinutes: 120 }  // Groups reset after 2 hours idle
    }
  },
  
  // Reduce context from message history
  messages: {
    groupChat: { historyLimit: 25 }
  },
  
  channels: {
    whatsapp: {
      allowFrom: ["+your-number"],
      historyLimit: 30
    },
    telegram: {
      dmHistoryLimit: 30,
      historyLimit: 25
    }
  }
}
```

---

## Summary of What Runs Automatically

|Feature|What it does|Key config|
|---|---|---|
|**Session pruning**|Trims old tool results before LLM calls|`contextPruning.mode: "cache-ttl"`|
|**Cache-TTL pruning**|Prunes when cache expires to reduce re-cache cost|`contextPruning.ttl`|
|**Heartbeat cache warming**|Keeps prompt cache alive|`heartbeat.every: "55m"`|
|**Auto session reset**|Clears stale sessions daily or on idle|`session.reset`|
|**Memory flush**|Saves important context before compaction|`compaction.memoryFlush.enabled`|
|**Safeguard compaction**|Chunked summarization for long histories|`compaction.mode: "safeguard"`|
|**History limits**|Caps how much chat history enters context|`historyLimit`, `dmHistoryLimit`|

With this configuration, you shouldn't need to manually run `/compact` or `/clear` — the system handles context management automatically. You can still use `/status` periodically to verify things are working as expected.