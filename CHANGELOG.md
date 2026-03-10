# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.4.1] - 2026-03-10

### Fixed

- **All 264 markdown files now pass linting** — Resolved all 131 markdownlint errors
  - Auto-fixed 117 errors: blank lines around lists/code fences, multiple consecutive blank lines
  - Manual fixes: Added language specifications to 5 code blocks
  - Config update: Disabled MD024 (no-duplicate-heading) for CHANGELOG.md — expected per-version duplication
  - Configuration: Updated `.markdownlint-cli2.jsonc` to reflect best practices

### Technical Details

- Installed `markdownlint-cli2 v0.21.0` for comprehensive markdown validation
- Total files linted: 264 with 0 errors
- All fixes maintain semantic correctness and improve code block readability

## [1.4.0] - 2026-03-10

### Added

- **Comprehensive skill linting and validation system** — Automated quality gates for all skills
  - **Linting system** (`linting/`) with 12 automated checks (L01–L12):
    - Frontmatter validation, file structure, YAML field requirements, name format validation
    - Required file presence (SKILL.md, agents/openai.yaml, agents/claude.yaml)
    - Character limits, syntax validation, dangling reference detection
    - Platform language detection, forbidden file detection, markdown linting
  - **Validation system** (`validation/`) with 8-criterion LLM scoring rubric (V01–V08):
    - Description effectiveness, intent router completeness, quick reference coverage
    - Safety documentation, example quality, reference depth, LLM usability
    - Alignment with Anthropic/OpenAI/academic prompt engineering standards
  - **Two new agent-facing skills**:
    - `skill-linting` — Lint skills for structural correctness
    - `skill-validation` — Validate skill quality and effectiveness
  - **Enhanced skill-creator** — Integrated Step 7 (Lint and Validate) workflow
  - **Prompt Engineering Standards** — 7 principles added to skill-creator reference

- **Documentation updates**:
  - AGENTS.md: Added "Linting and Validation" section with command references
  - README.md: Updated "What's New" for v1.3.0 features
  - INSTALL.md: Added Quality Assurance section with linting and validation instructions
  - New files: `linting/rules.md`, `validation/rubric.md`, `validation/public-references.md`

### Fixed

- **6 known violations resolved**:
  - `sqlite`: short_description reduced from 86 to 54 characters (both openai.yaml and claude.yaml)
  - `7z`: short_description reduced from 75 to 43 characters
  - `unzip`: short_description reduced from 71 to 38 characters
  - `tar`: short_description reduced from 69 to 34 characters
  - `openssl`: short_description reduced from 65 to 54 characters
  - `git`: Removed second-person language ("You are a Git expert" → imperative form)

- **All 48 skills now pass linting** with zero FAIL conditions (L01–L12 checks)

### Technical Details

- Linting system: 4 files, 12 portable shell check functions
- Validation system: 3 files, 8-criterion rubric with LLM guidance
- Cross-platform compatibility: All scripts tested on macOS and Linux
- Integration ready: Pre-commit hook instructions in AGENTS.md
- 24 files modified/created for this release

## [1.2.0] - 2026-03-09

### Added

- **New `changelog` skill** — Maintain CHANGELOG.md files following [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) format with structured entries, release workflows, and semantic versioning
  - 4 comprehensive reference files: cheatsheet (format spec), install-and-setup (optional git-cliff), advanced-usage (CI/CD automation), troubleshooting (anti-patterns)
  - Cross-platform install scripts for optional git-cliff integration (Bash and PowerShell)
  - Safety guardrails: prevent vague entries, enforce entry types, maintain [Unreleased] section, validate dates and links
  - Supports both manual curation and automated generation workflows

## [1.1.1] - 2026-03-09

### Added

- **Complete agent file coverage** — Added `claude.yaml` to all 13 core and CLI skills that were missing them
  - Ensures cross-platform compatibility for Claude Code, Codex, and other Claude-based systems
  - Skills: ag, aws, az, bash, docker, git, glab, markdownlint, powershell, skill-creator, sqlite, zoxide, zsh

## [1.1.0] - 2026-03-09

### Added

- **32 command-line utility skills upgraded to mature quality standard**:
  - Restructured SKILL.md with 7-section format: Intent Router, Safety Notes table, Quick Command Reference
  - Added 3 new reference files per skill: install-and-setup, advanced-usage, troubleshooting
  - Added cross-platform install scripts for all 32 skills (install.sh for Bash, install.ps1 for PowerShell)
  - Enhanced openai.yaml with tool-specific metadata and descriptions
  - Tools upgraded: awk, diff, head, sed, tail, 7z, ar, tar, unzip, binwalk, cmp, file, hexdump, nm, objdump, od, readelf, strings, xxd, exiftool, mediainfo, pdfinfo, pdftotext, xmllint, openssl, ssh-client, ssh-keygen, rg, less, ldd, jq, tree

### Changed

- **Skill naming standardization** — Removed unnecessary postfixes for cleaner names:
  - ag-search → ag
  - aws-cli → aws
  - az-cli → az
  - glab-cli → glab
  - markdownlint-cli2-enforcer → markdownlint
  - zoxide-navigation → zoxide

- **SQLite skills consolidation** — Merged two complementary skills into single unified interface:
  - sqlite-file-workbench + sqlite-file-workbench-advanced → sqlite
  - Combined 8 reference files covering core workflows through advanced operations (diffing, sync, migrations, integration)
  - Expanded Intent Router to guide users to appropriate references for their task level

### Fixed

- **Frontmatter violations** — ssh-client and ssh-keygen: removed 6 extra prohibited fields (category, version, requires_git, safety_tier, execution_mode, labels)
- **Markdown linting** — All 32 upgraded skills pass 100% linting validation (0 errors)

### Technical Details

- All 32 command skills now follow the same architecture as mature skills (bash, powershell, zsh, git, docker)
- Install scripts validated with bash -n syntax checking
- 288 total files created/modified for skill upgrades
- 84 files changed for naming standardization and consolidation
- Documentation synchronized across README, CHANGELOG, INSTALL, and plugin.json

## [1.0.1] - 2026-03-09

### Fixed

- **Markdown linting compliance**: Added `.markdownlint-cli2.jsonc` configuration with sensible defaults
- **44 markdown formatting issues**: Auto-fixed blank lines around code fences, headings, and lists across 88 files
- **Code block language specification**: Added language identifiers to all 40 bare code blocks (using `text`, `output`, `bicep`)
- **Emphasis-as-heading errors**: Converted 4 instances of bold text used as headings to proper markdown headings
- **Duplicate heading**: Renamed duplicate "Examples" heading to "Performance Examples" in ag-patterns.md

### Technical Details

- Markdownlint configuration disables overly strict rules: `line-length`, `no-trailing-punctuation`, `no-inline-html`, `table-column-style`
- All markdown files now pass linting validation (0 errors)

## [1.0.0] - 2026-03-09

### Added

- **11 cross-compatible tool skills**: ag, aws, az, bash, docker, git, glab, markdownlint, powershell, sqlite, zoxide
- **Install scripts** for all 12 skills:
  - `scripts/install.sh` (bash) with platform detection, distro-specific package managers (apt, dnf, pacman, zypper), and installation verification
  - `scripts/install.ps1` (PowerShell) with Windows/macOS/Linux support and winget/scoop/package manager integration
- **Install & setup references** for all 12 skills:
  - `references/install-and-setup.md` with platform-specific install commands, post-install configuration steps, verification commands, and troubleshooting
- **Intent Router entries** in each skill's SKILL.md to guide users to install-and-setup references
- **Cross-platform support**: macOS (Homebrew), Linux (Debian/Ubuntu, Fedora/RHEL, Arch, Alpine), Windows (WSL2, Git Bash, native)
- **Skill-creator tool**: Framework for creating new cross-compatible skills with consistent structure
- **Comprehensive reference documentation**: Each skill includes detailed guides for common workflows, troubleshooting, and platform-specific behavior
- **Claude Code plugin registration**: `.claude-plugin/plugin.json` for Claude Code plugin discovery
- **Codex compatibility**: `agents/openai.yaml` in each skill for Codex UI and cross-platform execution
- **Installation guide** (INSTALL.md): Instructions for installing as Claude Code plugin or Codex skill source

### Technical Details

- All `install.sh` scripts use `set -euo pipefail` for safety and error handling
- Platform detection via `uname -s` and `/etc/os-release` for robust OS/distro identification
- Tagged output format (`[INFO]`, `[OK]`, `[WARN]`, `[ERROR]`, `[HINT]`) for consistent, parseable script output
- PowerShell scripts use `Set-StrictMode -Version Latest` and `$ErrorActionPreference = 'Stop'` for safety
- Pre-install checks: scripts verify if tools are already installed and skip installation if current version meets requirements
- Post-install verification: all scripts confirm successful installation and print setup hints

[Unreleased]: https://github.com/alisonaquinas/llm-shared-skills/compare/v1.2.0...HEAD
[1.2.0]: https://github.com/alisonaquinas/llm-shared-skills/compare/v1.1.1...v1.2.0
[1.1.1]: https://github.com/alisonaquinas/llm-shared-skills/compare/v1.1.0...v1.1.1
[1.1.0]: https://github.com/alisonaquinas/llm-shared-skills/compare/v1.0.1...v1.1.0
[1.0.1]: https://github.com/alisonaquinas/llm-shared-skills/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/alisonaquinas/llm-shared-skills/releases/tag/v1.0.0
