# Reusable skill quality loop

Run the standard reusable tooling loop for an individual skill.

- Inspect `skills/<skill-name>/SKILL.md` and relevant references.
- Run:
  - `python scripts/lint_skills.py <skill-name>`
  - `python scripts/validate_skills.py <skill-name>`
- Validate repository impact with:
  - `make lint`
  - `make verify`
