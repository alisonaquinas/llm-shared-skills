# Skill Format Reference

Canonical specification for the SKILL.md format and platform-specific extensions.

---

## SKILL.md Frontmatter

| Field | Required | Type | Notes |
|---|---|---|---|
| `name` | Yes | string | kebab-case, lowercase, digits, hyphens only; max 64 chars; matches folder name |
| `description` | Yes | string | Primary trigger mechanism; include all "when to use" info; ~100–300 words |

No other YAML fields should appear in frontmatter. Do not add `version`, `tags`, `author`, etc.

### Description quality checklist

- [ ] Describes **what** the skill does
- [ ] Lists **specific user phrases** or **keywords** that should trigger it
- [ ] Covers **concrete scenarios** (not vague topics)
- [ ] Claude Code style: third-person — "This skill should be used when the user wants to..."
- [ ] Does NOT contain "when to use" guidance that belongs in the body

---

## agents/openai.yaml (Codex UI metadata)

Location: `skill-name/agents/openai.yaml`

```yaml
interface:
  display_name: "Human Readable Name"       # Title case, max ~30 chars
  short_description: "Brief description"    # 25–64 chars; shown as chip label
  default_prompt: "Use $skill-name to ..."  # Suggested prompt; must use $skill-name

  # Optional fields (only include if explicitly needed):
  icon_small: "./assets/icon-small.png"     # 64×64 PNG
  icon_large: "./assets/icon-large.png"     # 256×256 PNG
  brand_color: "#3B82F6"                    # hex color for UI accents

dependencies:                               # optional MCP tool requirements
  tools:
    - type: "mcp"
      value: "tool-name"
      description: "What this tool does"
      transport: "streamable_http"
      url: "https://..."

policy:
  allow_implicit_invocation: true           # default true; set false to require explicit trigger
```

**Claude Code behavior:** The `agents/openai.yaml` file is silently ignored. Safe to include.

---

## .claude-plugin/plugin.json (Claude Code plugin registration)

Location: at the **root** of the plugin/repo, not inside individual skills.

```json
{
  "name": "plugin-name",
  "description": "What this plugin provides",
  "author": {
    "name": "Author Name",
    "email": "optional@email.com"
  }
}
```

Claude Code scans the `skills/` directory inside a plugin root and auto-discovers all subdirectories containing `SKILL.md`.

**Codex behavior:** This file is ignored. Safe to include.

---

## Platform Loading Behavior

| Phase | Claude Code | Codex |
|---|---|---|
| Always in context | `name` + `description` frontmatter | Same |
| On skill trigger | Full SKILL.md body | Same |
| On demand | Files in `references/`, `scripts/`, `assets/` | Same |
| Plugin discovery | `skills/` in `.claude-plugin` dir | `~/.codex/skills/` directory |

---

## Directory Structure Conventions

```
skill-name/
├── SKILL.md                    (required)
├── agents/
│   └── openai.yaml             (recommended for cross-compatibility)
├── references/
│   ├── topic-a.md              (loaded when topic-a is in scope)
│   └── topic-b.md
├── scripts/
│   ├── probe-env.sh            (bash: environment probe)
│   └── probe-env.ps1           (powershell: same, for Windows)
├── assets/
│   └── templates/
│       └── starter.yaml
└── evals/
    └── evals.json              (optional: evaluation test cases)
```

### File type conventions

- `scripts/` — executable code; test before shipping; include contract comment at top
- `references/` — markdown docs; include ToC for files >100 lines; one topic per file
- `assets/` — output files (templates, images, fonts); NOT loaded into context
- `evals/` — test cases; not loaded into context

---

## Progressive Disclosure Patterns

**Pattern 1: Intent Router**

```markdown
## Intent Router
- `references/aws.md` — AWS deployment patterns
- `references/gcp.md` — GCP deployment patterns
Load only the file matching the user's chosen provider.
```

**Pattern 2: Conditional details**

```markdown
## Creating Documents
Use docx-js. See references/docx-js.md for full API.

For tracked changes: see references/redlining.md
```

**Guidelines:**

- Keep references one level deep from SKILL.md
- For reference files >100 lines, include a table of contents at the top
- Never duplicate information across SKILL.md and a reference file; choose one location
