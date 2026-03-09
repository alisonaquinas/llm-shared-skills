---
name: ag-search
description: >
  High-speed repository and document text search with The Silver Searcher (`ag`).
  Use when the user asks for `ag`/Silver Searcher explicitly, or when tasks need fast
  recursive matching, filename filtering, match counting, ignore-aware scanning
  (`.gitignore`/`.hgignore`/`.ignore`/`$HOME/.agignore`), context extraction, script-friendly
  result lists, multi-file search, file type filtering, or performance-critical searching.
---

# Ag Search

Use `ag` to find text across code and documents quickly with the right scope, output mode, and ignore behavior.

## Intent Router

| Request | Reference | Load When |
|---|---|---|
| Output modes, file filtering, patterns | `references/ag-patterns.md` | User needs ignore file info, output format details, or complex filtering |
| Preflight and environment | `scripts/probe-ag.sh` | Verify ag availability and features before workflows |

## Workflow
1. Confirm search goal: matching lines, matching files, counts, filename search, or inverse match.
2. Pick pattern mode:
- Regex (default)
- Literal: `-Q` / `--literal`
- Whole word: `-w`
- If pattern starts with a dash, use `--` before the pattern.
3. Pick scope:
- Path(s): `ag '<pattern>' <path>`
- File name restriction: `-G '<file-regex>'`
- File type restriction: run `ag --list-file-types`, then use `--<type>`
- Depth restriction: `--depth <num>`
4. Pick output:
- Files only: `-l`
- Count per file: `-c`
- Column and line numbers: `--column --numbers`
- Script-safe filenames: `-0` with `xargs -0`
5. Run and summarize totals plus notable matches.

## Ignore and Visibility Rules
Default behavior:
- Obey `.gitignore`, `.hgignore`, `.ignore`, and `$HOME/.agignore`
- Skip binary files

Overrides:
- `--hidden`: include hidden files and still obey ignore files
- `-U`: ignore VCS ignore files and still obey `.ignore`
- `-t`: search all text files (not hidden)
- `-a`: search all file types (not hidden)
- `-u`: unrestricted (hidden + binary + ignore bypass)

## Command Patterns
- Basic recursive search: `ag '<pattern>' .`
- Literal string search: `ag -Q '<literal>' .`
- Files containing match: `ag -l '<pattern>' .`
- Count matches per file: `ag -c '<pattern>' .`
- Filename-only search: `ag -g '<filename-regex>' .`
- Search pattern only in matching filenames: `ag -G '<filename-regex>' '<pattern>' .`
- Include context lines: `ag -C 2 '<pattern>' .`
- Search compressed content (if supported): `ag -z '<pattern>' .`
- Safe pipeline:
```bash
ag -l -0 '<pattern>' . | xargs -0 <command>
```

## Safety and Guardrails

| Operation | Guardrail | Why |
|---|---|---|
| **Recursive search** | Always use `--ignore` or check `.gitignore` | Avoid unintended vendor/node_modules search blowup |
| **Script output** | Use `-0` (null separator) with `xargs -0` | Safe with filenames containing spaces/newlines |
| **Large codebases** | Start with `-l`, `-c`, or `--depth` | Prevent output flood; control volume |
| **Pattern safety** | Quote patterns to avoid shell expansion | `'pattern'` not `pattern` |

## Practical Guardrails
- Quote patterns to avoid shell expansion.
- For machine-readable output, add `--nocolor` and optionally `--nogroup`.
- For very large trees, start with `-l`, `-c`, or `--depth` to control output volume.
- Runtime defaults can vary by build/version; check `ag --help` on this machine when behavior differs.
- Run probe script first: `scripts/probe-ag.sh` to verify ag availability and features

## Sources
- Official repository: https://github.com/ggreer/the_silver_searcher
- README: https://raw.githubusercontent.com/ggreer/the_silver_searcher/master/README.md
- Manpage source: https://raw.githubusercontent.com/ggreer/the_silver_searcher/master/doc/ag.1.md
