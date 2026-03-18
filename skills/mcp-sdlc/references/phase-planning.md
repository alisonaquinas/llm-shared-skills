# Phase 1: Planning

Gate-focused reference for the MCP SDLC planning phase. Load when entering
or reviewing Phase 1.

---

## Pre-Entry Checklist

Before starting Phase 1:
- [ ] The server's problem domain is known (not "build a general MCP server")
- [ ] The primary client environment is identified (Claude Code, Claude Desktop, custom)
- [ ] At least one concrete tool use case can be described in one sentence

---

## Phase 1 Deliverables

Produce all four before moving to Phase 2:

1. **Purpose statement** — One sentence: what the server does and for whom
2. **Capability inventory** — Table of tools, resources, prompts with one-line descriptions
3. **Transport decision** — stdio or SSE with rationale
4. **Client compatibility notes** — Which clients connect; known constraints

---

## Key Questions

- What domain problem does this server solve?
- What tools must it expose? (Name them — don't defer to Phase 2)
- Does it need resources (read-only data by URI) or prompts (templated messages)?
- Will it run locally (stdio) or as a remote service (SSE)?
- Which clients will connect? (Claude Code local = stdio; Claude Desktop = stdio or SSE)

---

## Gate Criterion

Phase 1 is complete when all four deliverables are written and no tool name
is listed as "TBD" or "to be determined."

---

## Common Failures

1. **Vague purpose statement** ("An MCP server that helps with things") — Fix: name
   the domain and the specific actions: "A filesystem MCP server that reads and lists
   local files for Claude Code."

2. **Missing capability inventory** — Proceeding to Phase 2 (design) without
   knowing which tools to build leads to schema design for the wrong interface.
   Fix: list all tools by name before entering Phase 2.

3. **Deferred transport decision** — Not deciding transport before Phase 3 (creation)
   means the startup code may need to be rewritten. Fix: decide stdio vs SSE in
   Phase 1 based on the deployment environment.
