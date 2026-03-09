# llm-shared-skills

A single repository of cross-compatible LLM agent skills that work with both
**Claude Code** and **Codex**. All skills use the shared `SKILL.md` format, making
them loadable by either agent without modification.

> **Note:** This entire repository was created via vibe-coding with Claude and Codex.
> It's a fun experiment in AI-driven skill development—use with the understanding that
> it's a living collection that may benefit from human review before production use.
> The install scripts and references have been tested, but your feedback is welcome! 🚀

## Skills

| Skill | Source | Description |
|---|---|---|
| `docker` | Merged (Claude + Codex) | Containers, Compose, Buildx, AI tooling, Windows Desktop |
| `bash` | Codex | Bash scripting, WSL2 interop, pipelines, debugging |
| `powershell` | Codex | PowerShell 7 scripting, remoting, modules, Windows/Linux/macOS |
| `git` | Claude | Git workflows, branching, rebasing, LFS, history recovery |
| `skill-creator` | Merged (Claude + Codex)* | Create and update cross-LLM skills |
| `ag-search` | Codex | Fast recursive search with The Silver Searcher (`ag`) |
| `aws-cli` | Codex | AWS CLI auth, profile context, and safe service commands |
| `az-cli` | Codex | Azure CLI auth, subscription context, and safe ARM commands |
| `glab-cli` | Codex | GitLab CLI auth, MR/issue/CI workflows, and safe commands |
| `markdownlint-cli2-enforcer` | Codex | Lint and fix Markdown with markdownlint-cli2 |
| `sqlite-file-workbench` | Codex | Core SQLite file ops with preflight, queries, and backups |
| `sqlite-file-workbench-advanced` | Codex | SQLite diff, sync, migration validation, and smoke tests |
| `zoxide-navigation` | Codex | Fast directory jumps with zoxide |

**\* About skill-creator:** This skill is built from the combined interfaces of Claude Code and
Codex tools—it's a synthesis of both platforms' capabilities. We make no claim to ownership or
copyright of the underlying tool designs; skill-creator exists to make creating new skills easier
and is provided as-is.

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
foreach ($skill in "ag-search","aws-cli","az-cli","bash","docker","git","glab-cli","markdownlint-cli2-enforcer","powershell","sqlite-file-workbench","sqlite-file-workbench-advanced","zoxide-navigation","skill-creator") {
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
│   └── plugin.json                  # Claude Code plugin registration
├── skills/
│   ├── ag-search/
│   ├── aws-cli/
│   ├── az-cli/
│   ├── bash/
│   ├── docker/
│   ├── git/
│   ├── glab-cli/
│   ├── markdownlint-cli2-enforcer/
│   ├── powershell/
│   ├── sqlite-file-workbench/
│   ├── sqlite-file-workbench-advanced/
│   ├── zoxide-navigation/
│   └── skill-creator/
├── AGENTS.md                        # Guidance for AI agents working in this repo
├── CHANGELOG.md                     # Release history
├── INSTALL.md                       # Installation instructions
├── LICENSE.md                       # MIT
└── README.md
```

## License

[MIT](LICENSE.md)
