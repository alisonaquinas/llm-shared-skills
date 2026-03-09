# llm-shared-skills

A single repository of cross-compatible LLM agent skills that work with both
**Claude Code** and **Codex**. All skills use the shared `SKILL.md` format, making
them loadable by either agent without modification.

> **Note:** This entire repository was created via vibe-coding with Claude and Codex.
> It's a fun experiment in AI-driven skill development—use with the understanding that
> it's a living collection that may benefit from human review before production use.
> The install scripts and references have been tested, but your feedback is welcome! 🚀

## What's New in v1.2.0

- **New `changelog` skill** — Maintain CHANGELOG.md files in [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) format with structured entries, release workflows, and semantic versioning
  - 4 comprehensive reference files: format specification, setup guides, CI/CD automation, troubleshooting
  - Cross-platform install scripts for optional git-cliff integration
  - Safety guardrails to prevent vague entries and enforce consistency
  - Support for both manual curation and automated changelog generation

See [CHANGELOG.md](CHANGELOG.md) for full release notes.

## Skills

| Skill | Source | Description |
|---|---|---|
| `docker` | Merged (Claude + Codex) | Containers, Compose, Buildx, AI tooling, Windows Desktop |
| `bash` | Codex | Bash scripting, WSL2 interop, pipelines, debugging |
| `powershell` | Codex | PowerShell 7 scripting, remoting, modules, Windows/Linux/macOS |
| `zsh` | Claude | Zsh interactive shell, completion system, ZLE, globbing, scripting |
| `git` | Claude | Git workflows, branching, rebasing, LFS, history recovery |
| `changelog` | Claude | Maintain keepachangelog-format CHANGELOG.md files with structured entries and releases |
| `skill-creator` | Merged (Claude + Codex)* | Create and update cross-LLM skills |
| `ag` | Codex | Fast recursive search with The Silver Searcher (`ag`) |
| `aws` | Codex | AWS CLI auth, profile context, and safe service commands |
| `az` | Codex | Azure CLI auth, subscription context, and safe ARM commands |
| `glab` | Codex | GitLab CLI auth, MR/issue/CI workflows, and safe commands |
| `markdownlint` | Codex | Lint and fix Markdown with markdownlint |
| `sqlite` | Codex | Complete SQLite workflows from queries and backups to diffing and migrations |
| `zoxide` | Codex | Fast directory jumps with zoxide |
| `7z` | vibe-coding | 7z archive creation, extraction, listing, and compression |
| `ar` | vibe-coding | Static library (`.a`) inspection, member extraction, and manipulation |
| `awk` | vibe-coding | Text processing with field extraction, pattern matching, and filtering |
| `binwalk` | vibe-coding | Binary firmware analysis, file signatures, and embedded data extraction |
| `cmp` | vibe-coding | Byte-by-byte file comparison and binary difference detection |
| `diff` | vibe-coding | Text file comparison, unified diffs, and line-by-line changes |
| `exiftool` | vibe-coding | EXIF/metadata extraction from images, videos, and documents |
| `file` | vibe-coding | File type detection using magic numbers and content analysis |
| `head` | vibe-coding | Display first lines of files for quick previews and header inspection |
| `hexdump` | vibe-coding | Hex dump generation, byte visualization, and binary data inspection |
| `jq` | vibe-coding | JSON querying, filtering, transformation, and pretty-printing |
| `ldd` | vibe-coding | Dynamic library dependency analysis for ELF binaries |
| `less` | vibe-coding | Interactive paging, search, and navigation of large text files |
| `mediainfo` | vibe-coding | Audio/video metadata extraction and multimedia file analysis |
| `nm` | vibe-coding | Symbol table inspection from object files and binaries |
| `objdump` | vibe-coding | Disassembly, section analysis, and low-level binary inspection |
| `od` | vibe-coding | Octal/hex dumps with custom formatting for binary analysis |
| `openssl` | vibe-coding | Cryptography, SSL/TLS, certificate generation, and data hashing |
| `pdfinfo` | vibe-coding | PDF metadata extraction and document property inspection |
| `pdftotext` | vibe-coding | PDF text extraction and conversion to plain text |
| `readelf` | vibe-coding | ELF binary analysis, headers, sections, symbols, and relocations |
| `rg` | vibe-coding | Fast ripgrep-based search with regex, file filtering, and counting |
| `sed` | vibe-coding | Stream editing with regex substitution, filtering, and transformations |
| `ssh-client` | vibe-coding | SSH connections, remote command execution, and secure tunneling |
| `ssh-keygen` | vibe-coding | SSH key generation, conversion, and management |
| `strings` | vibe-coding | Printable string extraction from binary files for analysis |
| `tail` | vibe-coding | Display last lines of files with real-time monitoring (`-f`) |
| `tar` | vibe-coding | Tape archive creation, extraction, and multi-format support |
| `tree` | vibe-coding | Directory tree visualization with filtering and depth control |
| `unzip` | vibe-coding | ZIP archive extraction and listing with encryption support |
| `xmllint` | vibe-coding | XML validation, formatting, and XPath query processing |
| `xxd` | vibe-coding | Hex dump and binary reverse engineering with custom formatting |

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

```text
llm-shared-skills/
├── .claude-plugin/
│   └── plugin.json                  # Claude Code plugin registration
├── skills/
│   ├── ag/
│   ├── aws/
│   ├── az/
│   ├── bash/
│   ├── docker/
│   ├── git/
│   ├── glab/
│   ├── markdownlint/
│   ├── powershell/
│   ├── sqlite/
│   ├── zoxide/
│   └── skill-creator/
├── AGENTS.md                        # Guidance for AI agents working in this repo
├── CHANGELOG.md                     # Release history
├── INSTALL.md                       # Installation instructions
├── LICENSE.md                       # MIT
└── README.md
```

## License

[MIT](LICENSE.md)
