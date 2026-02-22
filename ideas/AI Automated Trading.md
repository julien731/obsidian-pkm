---
type: idea
status: active
created: 2026-02-22
category: side-project
summary: Explore building or using an AI-powered agent to automate financial research and trading decisions, starting with Dexter as a foundation.
tags:
  - ai
  - finance
  - trading
  - agent
  - automation
  - side-project
related:
  - "[[resources/Dexter - Financial Research Agent]]"
---

# AI Automated Trading

## Concept

Use an AI agent to automate financial research and, eventually, trading decisions. The goal is to move from manual portfolio monitoring (daily stock briefings) to an intelligent system that can identify opportunities, surface insights, and potentially execute decisions autonomously or with minimal human input.

## Starting Point

[[resources/Dexter - Financial Research Agent]] is a strong foundation — it's an autonomous financial research agent that already handles task decomposition, financial data fetching, and self-validation. Built on Bun/TypeScript with OpenAI (Anthropic-compatible), it's a viable base to extend toward trading.

## Potential Directions

- **Research automation**: Let Dexter run scheduled deep-dives on portfolio holdings (AMZN, NVDA, AAPL, TSLA, PYPL) and flag material changes
- **Signal generation**: Train or prompt the agent to surface buy/sell signals based on fundamental + sentiment data
- **Paper trading**: Test signals against historical or live market data before committing real capital
- **Brokerage integration**: Connect to an API (e.g., Alpaca, Interactive Brokers) for eventual autonomous execution

## Open Questions

- What risk guardrails are needed before any autonomous execution?
- Which data sources beyond Dexter's current stack (FinancialDatasets API) are needed?
- Should this stay as a research tool or evolve toward actual trade execution?
- What's the right paper trading sandbox to test signals safely?

## Next Steps

1. Clone and run Dexter locally
2. Point it at current portfolio (AMZN, NVDA, AAPL, TSLA, PYPL) for a trial research run
3. Evaluate output quality vs. the existing daily briefing
4. Identify gaps and extension points
