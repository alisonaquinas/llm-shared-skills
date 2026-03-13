# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.6.0] - 2026-03-13

### Added

- `skills/claude-cli`: new shared skill for installing, configuring, managing, and troubleshooting the Claude Code CLI binary — covers install, update, auth, CLAUDE.md, permissions, MCP servers, scripting, and troubleshooting; defers to `claude-cli-docs` for deep documentation lookups
- `skills/codex-cli`: new shared skill for installing, configuring, managing, and troubleshooting the OpenAI Codex CLI binary — covers install, update, auth (browser and API key), AGENTS.md, approval modes, scripting, and troubleshooting; defers to `codex-cli-docs` for deep documentation lookups
- `skills/xml2`: new shared skill covering `xml2` (XML→flat line format) and `2xml` (flat→XML) for Unix pipeline processing — includes cheatsheet with flat format anatomy and common pipeline patterns, and examples-and-recipes with 8 practical recipes
- `skills/xq`: new shared skill for jq-syntax XML querying via the `xq` binary (from `pip install yq`) — includes cheatsheet with full flag table and XML-to-JSON mapping, and advanced-usage covering streaming large files, roundtrip XML, and format conversion

### Changed

- `skills/xmllint`: major overhaul — rewrote SKILL.md with accurate description, table-format Intent Router, and inline Quick Reference covering `--noout`, `--format`, `--xpath`, `--schema`, `--valid`, and `--nonet`; added dedicated XXE security section; rewrote all four reference files with correct install package names (`libxml2-utils` / `libxml2`), full flag table with `XMLLINT_INDENT` env var, comprehensive XPath and schema validation examples, and full exit code table with common error explanations
- `.claude-plugin/plugin.json`: bumped the published plugin version to `1.6.0`

## [1.5.3] - 2026-03-13

### Added

- `skills/curl`: new shared skill for safe curl-based HTTP requests, downloads, uploads, redirects, authentication, and API inspection workflows
- `skills/wget`: new shared skill for wget-based file retrieval, resume, timestamping, recursive mirroring, and crawl-scope control workflows
- `skills/edit-files`: new shared skill for disciplined, tool-agnostic file editing with planning, patch-first changes, structured-data editing guidance, and verification templates

### Changed

- Replaced the placeholder `CLAUDE.md` content with a valid markdown stub that points contributors at `AGENTS.md`.
- `.claude-plugin/plugin.json`: bumped the published plugin version to `1.5.3` so the release tag and plugin metadata stay in sync
- `CHANGELOG.md`: moved unreleased entries into the `1.5.3` release section and refreshed compare links for the new tag

### Fixed

- Added an explicit `text` language tag to the release-workflow failure example so repository markdownlint checks pass cleanly.

## [1.5.2] - 2026-03-13

### Added

- GitHub Actions release workflow that creates GitHub releases from changelog entries and triggers `alisonaquinas/llm-skills` to rebuild static marketplace artifacts, including the combined RSS feed

### Changed

- `.claude-plugin/plugin.json`: bumped the published plugin version to `1.5.2` so the release tag, plugin metadata, and GitHub release workflow stay in sync
- `CHANGELOG.md`: refreshed compare links so `Unreleased` and recent release entries point at the correct GitHub diffs

## [1.5.1] - 2026-03-11

### Added

- `skills/claude-docs`: documentation-lookup skill for Anthropic Claude API (platform.claude.com/docs) - covers models, prompt engineering, tool use, extended thinking, Agent SDK, and REST API reference
- `skills/chatgpt-docs`: documentation-lookup skill for OpenAI platform API (platform.openai.com/docs) - covers models, API reference, function calling, Assistants, and guides
- `skills/codex-docs`: documentation-lookup skill for OpenAI Codex agent (developers.openai.com/codex) - covers concepts, AGENTS.md, MCP, interfaces, and automation/SDK
- `skills/claude-cli-docs`: documentation-lookup skill for Claude Code CLI (code.claude.com/docs) - covers installation, CLI reference, CLAUDE.md, MCP, hooks, skills, workflows, and integrations
- `skills/codex-cli-docs`: documentation-lookup skill for OpenAI Codex CLI (developers.openai.com/codex/cli) - covers installation, features, CLI flags, and slash commands

## [1.4.4] - 2026-03-11

### Changed

- `LICENSE.md`: added author name (Alison Aquinas) to copyright line
- `.claude-plugin/plugin.json`: set `author.name` to Alison Aquinas; corrected `version` to match git tag
- `AGENTS.md`: added Versioning and Releases section — documents that `plugin.json` version must match the git tag and that `CHANGELOG.md` must be updated before every release

## [1.4.3] - 2026-03-10

### Added

- GitHub Actions `Lint` workflow (`.github/workflows/lint.yml`) — three parallel jobs:
  - **Markdown**: `DavidAnson/markdownlint-cli2-action` with inline PR annotations
  - **YAML**: `ibiqlik/action-yamllint` with inline PR annotations; new `.yamllint.yml` config
  - **Skills**: per-skill `linting/lint-skill.sh` run with `::error::`/`::warning::` annotations,
    job summary pass/fail table, and 14-day log artifact upload

### Fixed

- `linting/lib/checks.sh`: replaced `eval`-based variable assignment in `_emit()` with
  `printf -v` — prevents crash when L09 failure message contains single quotes
- `skills/skill-creator/SKILL.md`: removed prose mentions of platform names that triggered L09;
  replaced with generic terms throughout frontmatter description, Platform Compatibility section,
  headings, checklist, and anti-pattern example
- `skills/skill-linting/SKILL.md`: rephrased L09 rule description to avoid self-referential trigger
- `skills/skill-validation/SKILL.md`: renamed example `references/` paths in code fences to avoid
  false L07 dangling-reference failures
- `CHANGELOG.md`: resolved orphaned merge conflict markers (`<<<<<<< HEAD` / `=======`)
- `README.md`: added blank lines before bullet lists (MD032)

## [1.4.2] - 2026-03-10

### Added

- **yq skill** — Process YAML, XML, and TOML with jq-like filtering
  - 4 reference docs: install-and-setup.md, quick-reference.md, usage-patterns.md, examples-and-recipes.md
  - Content: Installation on multiple platforms, common command flags and options, format conversion (YAML/JSON/TOML/XML), filtering and selection patterns, in-place file editing, string and array operations, multi-file processing, roundtrip mode for tag preservation, Kubernetes manifest processing, configuration management workflows, practical examples and recipes
  - ~900 lines of comprehensive documentation

### Removed

- **4 skills moved to llm-ci-dev** — Consolidated CI/CD-specific skills into dedicated repo
  - `docker` — Container and Docker tooling (now in llm-ci-dev/skills/)
  - `aws` — AWS CLI operations (now in llm-ci-dev/skills/)
  - `az` — Azure CLI operations (now in llm-ci-dev/skills/)
  - `glab` — GitLab CLI workflows (now in llm-ci-dev/skills/)

  **Rationale**: These 4 skills are primarily CI/CD-focused and now reside in the specialized llm-ci-dev
  collection alongside platform-specific CI/CD workflow and runner/agent management skills. This improves
  skill discoverability and maintains thematic coherence. llm-shared-skills now focuses on general-purpose
  system utilities and development tools (45 skills with yq).

### Updated

- Updated README to reflect new skill count (45 with yq, previously 44)
- Integrated with v1.4.1 linting and validation system
- All 45 skills pass structural linting with zero violations
- All 269 markdown files pass linting with zero errors

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

[Unreleased]: https://github.com/alisonaquinas/llm-shared-skills/compare/v1.5.3...HEAD
[1.5.3]: https://github.com/alisonaquinas/llm-shared-skills/compare/v1.5.2...v1.5.3
[1.5.2]: https://github.com/alisonaquinas/llm-shared-skills/compare/v1.5.1...v1.5.2
[1.5.1]: https://github.com/alisonaquinas/llm-shared-skills/compare/v1.4.4...v1.5.1
[1.4.4]: https://github.com/alisonaquinas/llm-shared-skills/compare/v1.4.3...v1.4.4
[1.4.3]: https://github.com/alisonaquinas/llm-shared-skills/compare/v1.4.2...v1.4.3
[1.4.2]: https://github.com/alisonaquinas/llm-shared-skills/compare/v1.4.1...v1.4.2
[1.4.1]: https://github.com/alisonaquinas/llm-shared-skills/compare/v1.4.0...v1.4.1
[1.4.0]: https://github.com/alisonaquinas/llm-shared-skills/compare/v1.2.0...v1.4.0
[1.2.0]: https://github.com/alisonaquinas/llm-shared-skills/compare/v1.1.1...v1.2.0
[1.1.1]: https://github.com/alisonaquinas/llm-shared-skills/compare/v1.1.0...v1.1.1
[1.1.0]: https://github.com/alisonaquinas/llm-shared-skills/compare/v1.0.1...v1.1.0
[1.0.1]: https://github.com/alisonaquinas/llm-shared-skills/compare/v1.0.0...v1.0.1
[1.0.0]: https://github.com/alisonaquinas/llm-shared-skills/releases/tag/v1.0.0
