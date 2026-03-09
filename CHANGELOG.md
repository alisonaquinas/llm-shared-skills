# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

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

[Unreleased]: https://github.com/anthropics/llm-shared-skills/compare/v1.0.1...HEAD
[1.0.1]: https://github.com/anthropics/llm-shared-skills/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/anthropics/llm-shared-skills/releases/tag/v1.0.0
