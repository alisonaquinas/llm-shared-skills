# Shared skill quality gate

Run quality checks for `llm-shared-skills`.

- For one skill:
  - `python scripts/lint_skills.py <skill-name>`
  - `python scripts/validate_skills.py <skill-name>`
- For all-skill validation:
  - `make lint`
  - `make test`
  - `make build`
  - `make verify`
