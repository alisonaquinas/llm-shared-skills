# llm-shared-skills

A single repository of cross-compatible LLM agent skills that work with both
**Claude Code** and **Codex**. All skills use the shared `SKILL.md` format, making
them loadable by either agent without modification.

> **Note:** This entire repository was created via vibe-coding with Claude and Codex.
> It's a fun experiment in AI-driven skill development—use with the understanding that
> it's a living collection that may benefit from human review before production use.
> The install scripts and references have been tested, but your feedback is welcome! 🚀

## What's New

**New in v1.6.7:**

- **10 new POSIX/GNU command skills** — `cat`, `cp`, `echo`, `grep`, `ln`, `ls`, `mv`, `printf`, `ps`, `rsync`
  - Each includes a cheatsheet, advanced-usage, and troubleshooting reference
  - `grep` skill recommends ag (The Silver Searcher) over grep for recursive code search when installed
  - `rsync` emphasises dry-run-first workflow and trailing-slash semantics
  - `printf` covers `printf -v` for subshell-free variable assignment and locale-stable numeric output
- **Meta-skills added** — `skill-development`, `skill-test-drive`, `skill-linting`, `skill-validation`

See [CHANGELOG.md](CHANGELOG.md) for full release notes.

## Skills

This repository currently contains 69 shared skills.

| Skill | Source | Description |
|---|---|---|
| `bash` | Codex | Bash scripting, WSL2 interop, pipelines, debugging |
| `powershell` | Codex | PowerShell 7 scripting, remoting, modules, Windows/Linux/macOS |
| `zsh` | Claude | Zsh interactive shell, completion system, ZLE, globbing, scripting |
| `git` | Claude | Git workflows, branching, rebasing, LFS, history recovery |
| `changelog` | Claude | Maintain keepachangelog-format CHANGELOG.md files with structured entries and releases |
| `skill-creator` | Merged (Claude + Codex)* | Create and update cross-LLM skills |
| `skill-development` | Claude | Orchestrate the full end-to-end SDLC for authoring a new LLM agent skill |
| `skill-linting` | Claude | Lint skills for structural correctness and rule compliance |
| `skill-validation` | Claude | Validate skill quality, effectiveness, and prompt engineering alignment |
| `skill-test-drive` | Claude | Test-drive a skill by designing live scenarios, executing them, and reporting usability gaps |
| `chatgpt-docs` | Claude | Look up official OpenAI platform documentation at platform.openai.com/docs |
| `claude-docs` | Claude | Look up official Anthropic Claude API documentation at platform.claude.com/docs |
| `claude-cli` | Claude | Install, configure, manage, and troubleshoot the Claude Code CLI binary |
| `claude-cli-docs` | Claude | Look up official Claude Code documentation at code.claude.com/docs |
| `codex-docs` | Claude | Look up official OpenAI Codex documentation at developers.openai.com/codex |
| `codex-cli` | Claude | Install, configure, manage, and troubleshoot the OpenAI Codex CLI binary |
| `codex-cli-docs` | Claude | Look up official OpenAI Codex CLI documentation at developers.openai.com/codex/cli |
| `ag` | Codex | Fast recursive search with The Silver Searcher (`ag`) |
| `markdownlint` | Codex | Lint and fix Markdown with markdownlint |
| `edit-files` | Codex | Safe generic file editing with planning, patches, and verification |
| `sqlite` | Codex | Complete SQLite workflows from queries and backups to diffing and migrations |
| `zoxide` | Codex | Fast directory jumps with zoxide |
| `7z` | vibe-coding | 7z archive creation, extraction, listing, and compression |
| `ar` | vibe-coding | Static library (`.a`) inspection, member extraction, and manipulation |
| `awk` | vibe-coding | Text processing with field extraction, pattern matching, and filtering |
| `binwalk` | vibe-coding | Binary firmware analysis, file signatures, and embedded data extraction |
| `cat` | Claude | Concatenate and display file contents; feed files into pipelines |
| `cp` | Claude | Copy files and directories with permission and metadata control |
| `cmp` | vibe-coding | Byte-by-byte file comparison and binary difference detection |
| `curl` | Codex | HTTP requests, API calls, downloads, uploads, redirects, and TLS-aware transfer control |
| `diff` | vibe-coding | Text file comparison, unified diffs, and line-by-line changes |
| `echo` | Claude | Print strings and variables to stdout; use printf for portable escape handling |
| `exiftool` | vibe-coding | EXIF/metadata extraction from images, videos, and documents |
| `grep` | Claude | Search files and pipelines by pattern; prefer ag for recursive code search when available |
| `file` | vibe-coding | File type detection using magic numbers and content analysis |
| `head` | vibe-coding | Display first lines of files for quick previews and header inspection |
| `hexdump` | vibe-coding | Hex dump generation, byte visualization, and binary data inspection |
| `jq` | vibe-coding | JSON querying, filtering, transformation, and pretty-printing |
| `ldd` | vibe-coding | Dynamic library dependency analysis for ELF binaries |
| `ln` | Claude | Create symbolic and hard links between files and directories |
| `ls` | Claude | List directory contents with permissions, sizes, timestamps, and sorting |
| `less` | vibe-coding | Interactive paging, search, and navigation of large text files |
| `mv` | Claude | Move or rename files and directories safely |
| `mediainfo` | vibe-coding | Audio/video metadata extraction and multimedia file analysis |
| `nm` | vibe-coding | Symbol table inspection from object files and binaries |
| `objdump` | vibe-coding | Disassembly, section analysis, and low-level binary inspection |
| `od` | vibe-coding | Octal/hex dumps with custom formatting for binary analysis |
| `openssl` | vibe-coding | Cryptography, SSL/TLS, certificate generation, and data hashing |
| `printf` | Claude | Portable formatted output with escape sequences, columns, and cross-shell consistency |
| `ps` | Claude | Inspect running processes, PIDs, CPU, memory, and process trees |
| `pdfinfo` | vibe-coding | PDF metadata extraction and document property inspection |
| `pdftotext` | vibe-coding | PDF text extraction and conversion to plain text |
| `readelf` | vibe-coding | ELF binary analysis, headers, sections, symbols, and relocations |
| `rg` | vibe-coding | Fast ripgrep-based search with regex, file filtering, and counting |
| `rsync` | Claude | Efficient, resumable file sync locally or over SSH with exclusion and dry-run support |
| `sed` | vibe-coding | Stream editing with regex substitution, filtering, and transformations |
| `ssh-client` | vibe-coding | SSH connections, remote command execution, and secure tunneling |
| `ssh-keygen` | vibe-coding | SSH key generation, conversion, and management |
| `strings` | vibe-coding | Printable string extraction from binary files for analysis |
| `tail` | vibe-coding | Display last lines of files with real-time monitoring (`-f`) |
| `tar` | vibe-coding | Tape archive creation, extraction, and multi-format support |
| `tree` | vibe-coding | Directory tree visualization with filtering and depth control |
| `unzip` | vibe-coding | ZIP archive extraction and listing with encryption support |
| `wget` | Codex | File downloads, resume, mirroring, timestamping, and recursive retrieval controls |
| `xml2` | vibe-coding | XML to flat line format for pipeline processing; reconstruct XML with `2xml` |
| `xq` | vibe-coding | XML querying and transformation with jq-compatible filter syntax |
| `xmllint` | vibe-coding | XML parsing, validation (DTD/XSD/RelaxNG), XPath querying, formatting, and XXE-safe processing |
| `xxd` | vibe-coding | Hex dump and binary reverse engineering with custom formatting |
| `yq` | Claude | Process YAML, XML, and TOML with jq-like filtering; format conversion and in-place editing |

**\* About skill-creator:** This skill is built from the combined interfaces of Claude Code and
Codex tools—it's a synthesis of both platforms' capabilities. We make no claim to ownership or
copyright of the underlying tool designs; skill-creator exists to make creating new skills easier
and is provided as-is.

## Build, Test, and Verify

Use GNU Make as the primary local entrypoint:

```bash
make lint
make test
make build
make verify
```

Build artifacts land in `built/` as one ZIP per skill. Each archive is rooted at
`llm-shared-skills/skills/<skill>/...` so release uploads match the repo layout.

The Python helpers are also available directly when you want a narrower run:

```bash
python scripts/lint_skills.py
python scripts/validate_skills.py
python -m unittest discover -s tests -v
```

Legacy `linting/` and `validation/` shell entrypoints remain available as
compatibility wrappers for one release cycle, but they now delegate to the
Python baseline.

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

## Release Artifacts

Tagged releases are expected to:

- run `make test`
- run `make all`
- attach every `built/*-skill.zip` artifact to the GitHub release
- dispatch the marketplace rebuild only when `MARKETPLACE_DISPATCH_TOKEN` is configured

## Structure

```text
llm-shared-skills/
├── .claude-plugin/
│   └── plugin.json                  # Claude Code plugin registration
├── .github/workflows/
│   ├── ci.yml                       # Markdown, YAML, Python, and skill validation
│   └── release.yml                  # Release validation and ZIP publishing
├── built/                           # Per-skill ZIP bundles generated by make build
├── scripts/                         # Python lint, validation, and verification helpers
├── tests/                           # Stdlib-only tests for packaging/build helpers
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
├── Makefile                         # Canonical local build/lint/test entrypoint
└── README.md
```

## License

[MIT](LICENSE.md)
