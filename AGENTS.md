# AGENTS.md — Guide for AI Agents Working in This Repo

This file tells AI agents (Claude Code, Codex, or any LLM tool) how to navigate,
use, and contribute to this repository effectively.

---

## What This Repo Is

A collection of cross-compatible **skills** — modular knowledge packages in `SKILL.md`
format — that extend LLM agent capabilities. Skills work identically in both
**Claude Code** and **Codex** without modification.

---

## Repo Layout

```text
llm-shared-skills/
├── .claude-plugin/plugin.json   # Claude Code plugin registration (ignored by Codex)
├── linting/                     # Skill linting system (12 automated checks)
│   ├── lib/
│   │   └── checks.sh            # Check functions library
│   ├── lint-skill.sh            # Lint one skill directory
│   ├── lint-all.sh              # Lint all skills
│   └── rules.md                 # Rule specifications and override mechanism
├── validation/                  # Skill quality validation (8-criterion rubric)
│   ├── validate-skill.sh        # Automated pre-flight context generator
│   ├── rubric.md                # LLM scoring rubric
│   └── public-references.md     # Anthropic/OpenAI/academic standards
├── skills/                      # One subdirectory per skill
│   └── <skill-name>/
│       ├── SKILL.md             # Required: frontmatter + instructions
│       ├── agents/
│       │   ├── openai.yaml      # Codex UI metadata (ignored by Claude Code)
│       │   └── claude.yaml      # Claude Code UI metadata (ignored by Codex)
│       ├── references/          # Deep docs, loaded on demand
│       ├── scripts/             # Executable helpers
│       └── assets/              # Templates and output files
├── AGENTS.md                    # This file
├── INSTALL.md                   # Installation instructions
├── LICENSE.md                   # MIT
└── README.md                    # Human-facing overview
```

---

## Reading Skills

- Start with a skill's `SKILL.md` — it contains the trigger description and core instructions.
- Load `references/*.md` only when the task requires depth on a specific sub-topic. Each
  skill's SKILL.md has an **Intent Router** section that tells you which reference to load.
- `scripts/` files are executable — run them rather than reading them when possible.
- `assets/` files are output templates — copy or adapt them; do not load them into context.

---

## Modifying Skills

### Editing an existing skill

1. Read `skills/<name>/SKILL.md` before making any changes.
2. Keep the SKILL.md body under ~500 lines. Move new content to `references/` if needed.
3. Update the Intent Router in SKILL.md when adding a new reference file.
4. If the `description` changes materially, update `agents/openai.yaml` to match
   (`short_description` and `default_prompt`).
5. Do not add platform-specific language ("Claude", "Codex") to SKILL.md body text.
   Use "the agent" instead.

### Adding a new skill

1. Create `skills/<name>/` with the exact skill name in kebab-case.
2. Write `SKILL.md` with valid YAML frontmatter (`name` and `description` only — no other fields).
3. Create `agents/openai.yaml` with `display_name`, `short_description`, and `default_prompt`.
4. Add to the skill table in `README.md`.
5. Follow the `skills/skill-creator/` skill for detailed guidance and best practices.

### Removing a skill

Remove the entire `skills/<name>/` directory and delete its row from the `README.md` table.

---

## Invariants — Do Not Violate

- Every skill directory **must** contain `SKILL.md` with `name` and `description` frontmatter.
- Every skill **must** contain `agents/openai.yaml` with `display_name`, `short_description`,
  and `default_prompt` — this is what makes skills cross-compatible with Codex.
- SKILL.md frontmatter **must not** contain fields other than `name` and `description`.
- `references/` files must be linked from the SKILL.md Intent Router section.
- Do not create `README.md`, `CHANGELOG.md`, or other auxiliary docs inside skill directories.
- Do not commit sensitive data (tokens, passwords, keys) anywhere in this repo.

---

## Cross-Compatibility Rules

| Concern | Rule |
|---|---|
| Body text | Use "the agent", not "Claude" or "Codex" |
| Platform scripts | Include both `.sh` (bash) and `.ps1` (PowerShell) where relevant |
| SKILL.md format | Identical for both systems — no system-specific frontmatter |
| `agents/openai.yaml` | Required in every skill; silently ignored by Claude Code |
| `.claude-plugin/plugin.json` | At repo root only; silently ignored by Codex |

---

## Linting and Validation

Before committing any new or modified skill, run:

```bash
make lint
```

When you need a tighter loop for one skill, use:

```bash
python scripts/lint_skills.py <skill-name>
python scripts/validate_skills.py <skill-name>
```

All FAIL items must be resolved before committing. WARN items should be addressed.

Compatibility wrappers remain available for one release cycle:

```bash
bash linting/lint-skill.sh skills/<name>
bash linting/lint-all.sh
bash validation/validate-skill.sh skills/<name>
```

For qualitative validation of skill effectiveness:

```bash
python scripts/validate_skills.py <skill-name>
```

Then load `validation/rubric.md` and score each criterion using the `skill-validation` skill.

Reference files:

- `linting/rules.md` — full rule specifications
- `validation/rubric.md` — 8-criterion scoring rubric
- `validation/public-references.md` — public documentation standards

---

## Git Workflow

This repo uses **trunk-based development**. The developer works alone.

- Commit directly to `main`. Do not create feature branches or open pull requests.
- Push directly: `git push origin main`.
- For releases, tag the commit on `main` and push the tag.

## Commit Conventions

- Use conventional commits: `feat:`, `fix:`, `docs:`, `refactor:`
- Scope to the skill name when relevant: `feat(docker): add cloud-and-remote reference`
- Do not amend published commits — create new ones.
- Do not commit without running the baseline quality gate:
  - `make test`
  - `make build`
  - `make verify`
  - or the narrow Python equivalents when you are changing one skill in isolation

---

## Versioning and Releases

- The canonical version lives in the **git tag** (e.g. `v1.4.4`).
- When setting or bumping the version, always:
  1. Set `.claude-plugin/plugin.json` `"version"` to match the git tag (strip the leading `v`). **This is enforced by CI** — the release workflow checks that `GITHUB_REF_NAME` (e.g. `v1.6.7`) equals `plugin.json version` (e.g. `1.6.7`). A mismatch aborts the run immediately: `ERROR: tag v1.6.7 does not match plugin.json version v1.6.6`.
  2. Add a new dated entry to `CHANGELOG.md` under `## [<version>] - <YYYY-MM-DD>` **before** tagging.
     Move all items from `## [Unreleased]` into the new entry.
  3. Commit both files, then tag: `git tag -a v<version> -m "Release v<version>"`.
- Never tag before updating `plugin.json` — the tag triggers CI and a stale version will fail the gate.
- The `CHANGELOG.md` **must** be updated as part of every release — do not tag without it.
- The release workflow runs `make test`, then `make all`, attaches `built/*.zip`, and skips marketplace dispatch cleanly when the token is absent.

---

## Installing Skills (for agents setting up a new environment)

See `INSTALL.md` for full instructions. The short version:

**Codex** — create directory junctions/symlinks from `~/.codex/skills/<name>` pointing
into `skills/<name>` in this repo.

**Claude Code** — register this directory as a local plugin source in `~/.claude/settings.json`.

---

## Editing Lessons

- In this Windows workspace, the `apply_patch` tool can reject large or path-heavy diffs without a useful error message.
- Prefer smaller edits and repo-relative paths first.
- If `apply_patch` fails repeatedly without actionable diagnostics, treat that as an environment or tooling issue rather than as proof that the requested edit is wrong.
- Stop retrying the same patch shape after one smaller-scope retry and one repo-relative retry.
- If the patch tool still rejects the change, switch promptly to the safest reliable local file-edit method allowed by the environment instead of burning turns on the same failed diff strategy.
- In your closeout, document that the fallback edit path was triggered by tool failure so reviewers understand why a non-patch edit method was used.

---

## Command + Agent Templates

### Command Templates

```bash
# Focused single-skill loop
python scripts/lint_skills.py <skill-name>
python scripts/validate_skills.py <skill-name>

# Full baseline gate
make lint
make test
make build
make verify
```

### Agent Template (Reusable Tooling Domain)

1. Start with `SKILL.md`; load references only when needed.
2. Prefer runnable `scripts/` over duplicating logic.
3. Keep cross-platform examples (`.sh` and `.ps1`) where relevant.
4. Enforce strict frontmatter (`name`, `description` only).
5. Never include secrets, tokens, or real credentials.
