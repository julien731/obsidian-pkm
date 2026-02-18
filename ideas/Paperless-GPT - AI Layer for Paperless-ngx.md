---
type: idea
status: interested
created: 2026-02-18
category: self-hosted/tools
summary: AI-powered companion for Paperless-ngx using local LLMs for OCR, tagging, and document analysis
tags:
  - self-hosted
  - paperless
  - llm
  - document-management
  - ollama
---

# Paperless-GPT — AI Layer for Paperless-ngx

## What It Is
A self-hosted companion service for [Paperless-ngx](https://github.com/paperless-ngx/paperless-ngx) that adds LLM-powered document processing. Works with local Ollama models or cloud APIs.

## Source
- Article: https://www.xda-developers.com/i-use-my-local-llms-with-this-tool-to-manage-documents-in-paperless-ngx/
- GitHub: https://github.com/icereed/paperless-gpt

## Key Features
- **LLM-powered OCR** — better than built-in ngx OCR, especially for tables, visual elements, low-quality scans
- **Auto title generation** — LLM-generated document titles pushed back to Paperless-ngx
- **Auto tags & correspondents** — AI-generated tags and correspondent detection
- **Custom fields** — generate custom fields via custom prompts (useful for warranties, press releases, etc.)
- **Document analysis** — ad-hoc summaries for long/complex documents
- **Customizable prompts** — modify prompts for every tool

## How It Works
- Pulls documents tagged with `paperless-gpt` from Paperless-ngx
- Processes them via local vision LLM (e.g. Ollama)
- One-click "Apply" pushes results back to Paperless-ngx

## Notes
- Needs an existing Paperless-ngx instance
- Works with local Ollama models (preferred) or cloud APIs
- Alternative worth comparing: **Paperless AI** (reportedly better at auto tag generation)
