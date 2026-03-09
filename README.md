# llm-shared-skills

A single repository of cross-compatible LLM agent skills that work with both
**Claude Code** and **Codex**. All skills use the shared `SKILL.md` format, making
them loadable by either agent without modification.

## Skills

| Skill | Source | Description |
|---|---|---|
| `docker` | Merged (Claude + Codex) | Containers, Compose, Buildx, AI tooling, Windows Desktop |
| `bash` | Codex | Bash scripting, WSL2 interop, pipelines, debugging |
| `powershell` | Codex | PowerShell 7 scripting, remoting, modules, Windows/Linux/macOS |
| `git` | Claude | Git workflows, branching, rebasing, LFS, history recovery |
| `skill-creator` | Merged (Claude + Codex) | Create and update cross-LLM skills |

## Installation

See [INSTALL.md](INSTALL.md) for full instructions. Quick start:

**Claude Code (as local plugin):**
```json
// In ~/.claude/settings.json, add to enabledPlugins:
"llm-shared-skills@local": true
```
Then point Claude Code at this directory as a local plugin source.

**Codex (symlink skills into ~/.codex/skills/):**
```powershell
# PowerShell
$repo = "C:\Users\aaqui\llm-shared-skills\skills"
foreach ($skill in "docker","bash","powershell","git","skill-creator") {
    New-Item -ItemType Junction -Path "$env:USERPROFILE\.codex\skills\$skill" -Target "$repo\$skill" -Force
}
```

## Compatibility Design

Both agents use the same SKILL.md format. This repo adds:
- `agents/openai.yaml` in every skill for Codex UI metadata
- `.claude-plugin/plugin.json` at repo root for Claude plugin registration

Skills use "the agent" instead of "Claude" or "Codex" in body text to stay platform-neutral.

## Adding New Skills

1. Create `skills/<name>/SKILL.md` with YAML frontmatter (`name` + `description`)
2. Create `skills/<name>/agents/openai.yaml` with Codex UI metadata
3. Add `references/`, `scripts/`, `assets/` as needed
4. Update this README's skill table

Follow the `skill-creator` skill's guidance for best practices.

## Structure

```
llm-shared-skills/
├── .claude-plugin/
│   └── plugin.json          # Claude Code plugin registration
├── skills/
│   ├── docker/
│   ├── bash/
│   ├── powershell/
│   ├── git/
│   └── skill-creator/
├── AGENTS.md                # Guidance for AI agents working in this repo
├── INSTALL.md               # Installation instructions
├── LICENSE.md               # MIT
└── README.md
```

## License

[MIT](LICENSE.md)
