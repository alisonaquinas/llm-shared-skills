# Phase 2: Authoring

Deep guidance for the authoring phase. Load when building or reworking a skill's
file structure, writing SKILL.md content, or designing reference files.

---

## Pre-Authoring Checklist

Confirm ideation outputs are complete before authoring:

- [ ] Trigger phrases documented (3+ user phrasings)
- [ ] Success scenario written (what does done look like?)
- [ ] Reference files planned (topic list, no dangling refs)
- [ ] Scope boundaries set (what is explicitly out of scope?)

---

## Directory Initialization

```bash
cd repos/llm-shared-skills
mkdir -p skills/<name>/agents
mkdir -p skills/<name>/references
```

---

## 7-Step Authoring Workflow

Follow this order to avoid L07 dangling reference violations:

1. Create directory skeleton (`agents/`, `references/`)
2. Write all `references/*.md` files
3. Write `agents/claude.yaml` and `agents/openai.yaml`
4. Write `SKILL.md` (last — all referenced files must exist first)
5. Run linting: `bash linting/lint-skill.sh skills/<name>`
6. Run validation: `bash validation/validate-skill.sh skills/<name>`
7. Run test drive: 5+ scenarios in a disposable workspace

---

## SKILL.md Writing Guide

### Frontmatter

```yaml
---
name: skill-name
description: >
  What this skill does and when to use it. Include 3+ trigger phrases,
  concrete scenarios, and specific keywords. Target 50–100 words.
---
```

Only `name` and `description` are allowed in frontmatter (L01 rule).

### Body Structure

```text
# Title
One-sentence summary.

## Intent Router
[List all reference files with specific load conditions]

## Quick Start — [Topic]
[Table or brief overview of phases/commands]

## [Section per major workflow]
[4–6 lines prose + command block]

## Resource Index
[Table: file | phase | load condition]
```

### Body Length Target

Keep body under 450 lines (WARN threshold). Target 200–300 lines for a
well-structured skill. Move detailed docs to `references/` to stay within limits.

---

## Anti-Patterns

| Anti-Pattern | Problem | Fix |
|---|---|---|
| Writing SKILL.md before references | L07 dangling refs guaranteed | Write references first |
| Inlining all details | Body bloat, exceeds 450-line WARN | Move to `references/` |
| Second-person language | L11 WARN | Use imperative form |
| Platform names in body | L09 FAIL | Replace with "the agent" |
| Extra frontmatter fields | L01 FAIL | Only `name` and `description` |

---

## Gate Criterion

Authoring phase is complete when:

- All planned directories exist
- All referenced files exist on disk (no dangling refs)
- SKILL.md body is under 450 lines
- Both agent YAML files are present and populated
- Frontmatter has exactly `name` and `description`
