# Phase 3: Linting

Deep guidance for the linting phase. Load when running lint checks, interpreting
lint output, or fixing lint violations on a skill.

---

## Run Commands

Single skill:

```bash
bash linting/lint-skill.sh skills/<name>
```

All skills (pre-commit gate):

```bash
bash linting/lint-all.sh
```

Python equivalents for faster feedback:

```bash
python scripts/lint_skills.py <name>
```

---

## 12-Rule Reference Table

| ID | Check | Severity | Pass Condition | Fix Recipe |
|---|---|---|---|---|
| L01 | Frontmatter fields | FAIL | Only `name` and `description` | Remove extra YAML fields |
| L02 | name format | FAIL | kebab-case, ≤64 chars, matches folder | Rename skill or folder |
| L03 | Required files | FAIL | SKILL.md, agents/openai.yaml, agents/claude.yaml | Create missing files |
| L04 | Agent YAML fields | FAIL | Both files have `display_name`, `short_description`, `default_prompt` | Add missing fields under `interface:` |
| L05 | short_description length | FAIL/WARN | 25–64 characters | Truncate (>64 FAIL) or expand (<25 WARN) |
| L06 | Body line count | WARN/FAIL | <450 lines WARN; <500 FAIL | Move content to `references/` |
| L07 | Dangling references | FAIL | Every `references/*.md` in body exists on disk | Create missing files or remove refs |
| L08 | Script syntax | FAIL | All `scripts/*.sh` pass `bash -n` | Fix shell syntax errors |
| L09 | Platform language | FAIL | No "Claude Code" or "Codex" in prose | Replace with "the agent" |
| L10 | Forbidden files | FAIL | No README.md, CHANGELOG.md, etc. | Delete auxiliary files |
| L11 | Second-person | WARN | No "You should", "You can", etc. | Rewrite in imperative form |
| L12 | Markdownlint | FAIL | All `.md` files pass markdownlint-cli2 | Run `markdownlint-cli2 --fix` |

---

## Fix Priority Order

Resolve in this order to avoid cascading failures:

1. FAILs first: L01, L02, L03, L04, L05, L07, L08, L09, L10, L12
2. WARNs next: L06 (body length), L11 (second-person)
3. Re-lint after each batch of fixes

---

## .lintignore Override Mechanism

Create `skills/<name>/.lintignore` to suppress specific rules:

```text
# One rule ID per line
L09
L11
```

Use sparingly. Comment each suppression with a reason. The `skill-creator` skill
legitimately suppresses L09 because it documents cross-platform differences by design.

---

## Common Fix Examples

**L01 — Extra frontmatter fields:**
Remove all fields except `name` and `description` from the SKILL.md frontmatter block.

**L07 — Dangling references:**

```bash
grep -o 'references/[a-z0-9._-]*\.md' SKILL.md | sort -u
# Create any missing files shown above
touch references/missing-topic.md
```

**L09 — Platform language:**
Replace "Claude Code" and "Codex" with "the agent" throughout SKILL.md body prose.

**L12 — Markdownlint errors:**

```bash
npx markdownlint-cli2 --fix "skills/<name>/**/*.md"
npx markdownlint-cli2 "skills/<name>/**/*.md"
```

---

## Gate Criterion

Linting phase is complete when:

- `lint-skill.sh` exits 0
- Zero FAIL items in output
- WARN items addressed or suppressed with documented `.lintignore` entries
