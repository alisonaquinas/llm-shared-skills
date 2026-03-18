---
name: mcp-planning
description: >
  Ideation and planning phase for MCP server development. Use when planning a new
  MCP server, clarifying purpose and scope, choosing between stdio and SSE transport,
  inventorying which tools resources and prompts to expose, assessing client
  compatibility, defining success criteria, or documenting the interface contract
  before writing any code. Covers purpose definition, transport selection, capability
  inventory, and client environment analysis.
---

# MCP Planning

Ideation and scope definition before MCP server implementation begins.

## Intent Router

Load reference files on demand — only when the corresponding topic is active:

- `references/transport-selection.md` — Load when transport choice is unsettled,
  involves remote deployment, or multiple clients must connect simultaneously
- `references/client-compatibility.md` — Load when the target client is anything
  other than a local stdio host, or when multi-client support is required

## Quick Start — Planning Outputs

Produce these four outputs before any code is written:

| Output | Description | Gate |
|---|---|---|
| Purpose statement | One sentence: what the server does and for whom | Written |
| Capability inventory | List of tools, resources, prompts with one-line descriptions | All three categories considered |
| Transport decision | stdio or SSE with documented rationale | Decided |
| Client compatibility notes | Which clients will connect; known constraints | Written |

Planning is complete when all four outputs are documented.

## Phase: Purpose Definition

Establish the server's reason for existence before building the capability inventory.
Document: what domain problem it solves, who the primary client is, what tools it
must expose (named), whether resources or prompts are needed.

Scope limit: one server = one domain. A file-system server does not also become
a database connector. If the purpose statement covers more than one domain, split
into two servers.

Trigger phrases to document (3+): how would a user phrase the request that causes
the agent to call this server's tools?

## Phase: Capability Inventory

List every tool, resource, and prompt the server will expose. Use this table:

```
| Type     | Name              | Description (≤15 words)                  | Required |
|----------|-------------------|------------------------------------------|----------|
| tool     | read_file         | Read a file from the local filesystem    | Yes      |
| resource | file://{path}     | URI template for file access             | No       |
| prompt   | summarize_file    | Template: summarize the file at {path}   | No       |
```

Limit: if the inventory exceeds 10 tools, consider splitting into two servers.
Resources and prompts are optional — most servers expose only tools.

## Phase: Transport Selection

Load `references/transport-selection.md` for the full decision matrix.

Quick rule:
- **stdio** — local process, local desktop client, default choice
- **SSE** — remote deployment, multi-client access, requires HTTP infrastructure

When in doubt, use stdio. Only choose SSE when remote access is explicitly required.

## Phase: Client Compatibility

Load `references/client-compatibility.md` when the target client is not
a local stdio host.

Record which clients will connect and note any known constraints (config file
locations, transport limits, tool name length limits) in the planning document.

## Safety Notes

Scope drift is the primary planning risk. An inventory that grows beyond
10 tools during planning is a signal to split scope — not to proceed.
Document explicit out-of-scope items to prevent scope creep during implementation.

## Resource Index

| Reference File | Load When |
|---|---|
| `references/transport-selection.md` | Choosing between stdio and SSE; remote deployment |
| `references/client-compatibility.md` | Supporting Claude Desktop, Cursor, or custom clients |
