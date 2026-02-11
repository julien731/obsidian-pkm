# Dexter - Financial Research Agent

**Source:** https://github.com/virattt/dexter
**Added:** 2026-02-11
**Tags:** #ai #agent #finance #research #open-source

## Overview

Dexter is an autonomous financial research agent that thinks, plans, and learns as it works. Think "Claude Code, but built specifically for financial research."

## Key Capabilities

- **Intelligent Task Planning:** Automatically decomposes complex queries into structured research steps
- **Autonomous Execution:** Selects and executes the right tools to gather financial data
- **Self-Validation:** Checks its own work and iterates until tasks are complete
- **Real-Time Financial Data:** Access to income statements, balance sheets, and cash flow statements
- **Safety Features:** Built-in loop detection and step limits to prevent runaway execution

## Tech Stack

- Runtime: Bun (TypeScript)
- LLM: OpenAI (with optional Anthropic, Google, xAI, OpenRouter, Ollama)
- Data: Financial Datasets API
- Web Search: Exa or Tavily (optional)

## Notes

- Has an eval suite using LangSmith + LLM-as-judge for scoring
- Logs all tool calls to scratchpad files for debugging
- MIT Licensed
