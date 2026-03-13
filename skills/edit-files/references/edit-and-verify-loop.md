# Edit and Verify Loop

Use this reference when the agent is ready to modify files and needs a disciplined execution loop.

## Core Loop

1. Inspect
2. Plan
3. Patch
4. Format
5. Lint
6. Test
7. Review diff
8. Summarize

Treat the loop as mandatory for any meaningful file change. Deterministic verification is more reliable than intuition.

## Practical Editing Rules

- Prefer targeted patches over rewriting full files.
- Make one logical change at a time when practical.
- Re-run focused validation after each meaningful change.
- Review the diff before moving on to the next checkpoint.
- Stop broadening scope once the requested behavior is satisfied.

## Patch Failure Fallback

When generic patch tooling fails, treat it as a workflow problem to route around, not as a reason to abandon disciplined editing.

1. Retry once with a smaller, more tightly scoped patch.
2. Retry once with repo-relative path targeting if the first attempt used a longer or more complex path shape.
3. If `apply_patch` still returns only a generic failure with no actionable diagnostics, stop retrying the same patch pattern.
4. Switch to the safest reliable local edit method allowed by the environment.
5. Continue the same verify-and-review loop after the fallback edit.
6. Summarize that the alternate edit path was triggered by tool failure, not by request scope.

## Small Changes

For a small change:

1. Inspect nearby code and tests.
2. Apply the minimum patch.
3. Run the narrowest relevant checks.
4. Review the diff.
5. Summarize what changed and anything still uncertain.

## Medium or Large Changes

Split the work into checkpoints such as:

- interface or config changes
- implementation updates
- caller updates
- test updates
- final validation

Run at least one focused verification step per checkpoint, then a broader pass at the end if the repo supports it.

## Structured Edit Examples

Prefer structured data tools over freeform text substitutions when the file format supports them.

JSON with `jq`:

```bash
jq '.version = "2.0"' package.json
jq '.scripts.test = "vitest"' package.json
```

YAML with `yq`:

```bash
yq '.image.tag = "v2"' deploy.yaml
yq '.jobs.build.steps += [{"name":"lint"}]' ci.yml
```

TOML with `yq` / `tomlq`:

```bash
tomlq '.tool.poetry.version = "1.2.0"' pyproject.toml
```

XML with `yq` / `xq`:

```bash
xq '.project.version = "2.0"' pom.xml
```

Use generic patch editing when the change is semantic, spans prose and code together, or is better expressed as a human-readable diff.

## Verification Expectations

After edits:

- run formatter or normalizer if the repo uses one
- run lint or type checks when relevant
- run focused tests for affected behavior
- run broader regression checks when the change radius justifies it
- summarize the exact checks performed
- explain any fallback editing path taken because generic patch tooling failed silently

If validation cannot run, say so explicitly and note the remaining risk.
