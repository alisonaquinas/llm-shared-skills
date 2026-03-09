# GitLab CLI Command Cookbook

## Official Documentation
- GitLab CLI docs: https://docs.gitlab.com/cli/

## Preflight and Context
```bash
scripts/glab-preflight.sh
scripts/glab-auth-status.sh
scripts/glab-context.sh
scripts/glab-diagnostics.sh --json
```

## Inspect-First Patterns
```bash
glab auth status
glab repo view
glab issue list
glab mr list
glab ci list
glab release list
```

## Planned Write Patterns (Confirm First)
```bash
glab issue create --title "<title>"
glab mr create --title "<title>"
glab mr merge <id>
glab release create <tag>
```

## API Patterns
```bash
glab api projects/:id/merge_requests
glab api user
```

## Environment Notes
- Set `GLAB_CONFIG_DIR` if default config path is unavailable.
- Verify active host/project context before mutating commands.
