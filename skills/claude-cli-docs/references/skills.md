# Claude Code CLI — Skills & Custom Commands

## Reference Page

<https://code.claude.com/docs/en/skills>

## What are Skills?

Skills (also called custom commands) are reusable slash commands you create to package
repeatable workflows. Example: `/review-pr`, `/deploy-staging`, `/run-migration`.

## Skill File Structure

```text
.claude/
└── skills/
    └── my-command/
        └── SKILL.md
```

Or in a shared plugin repo with the structure this repo uses.

## SKILL.md Format

```markdown
---
name: my-command
description: >
  What this command does and when to trigger it.
---

# My Command

Instructions for Claude on how to execute this workflow...
```

## Invoking Skills

```bash
/my-command                    # invoke in interactive mode
claude -p "/my-command args"   # invoke non-interactively
```

## Skill Discovery

Claude Code discovers skills from:

1. `.claude/skills/` in the current project
2. Enabled plugins in `~/.claude/settings.json`
3. The `anthropic-skills` official plugin

## Plugin Registration

Register a local skill directory as a plugin in `~/.claude/settings.json`:

```json
{
  "enabledPlugins": {
    "my-skills@local": true
  },
  "extraKnownMarketplaces": {
    "local": {
      "source": { "source": "file", "path": "/path/to/parent" }
    }
  }
}
```
