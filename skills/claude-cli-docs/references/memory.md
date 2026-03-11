# Claude Code CLI — Memory & CLAUDE.md

## Reference Page

<https://code.claude.com/docs/en/memory>

## CLAUDE.md

`CLAUDE.md` is a markdown file at your project root (or `~/.claude/CLAUDE.md` for
user-global instructions) that Claude Code reads at the start of every session.

**Use it to store:**

- Coding standards and conventions
- Architecture decisions and preferred patterns
- Build, test, and lint commands
- Libraries in use and why
- Off-limits files or patterns
- Review checklists

```markdown
# My Project

## Commands
- Build: `npm run build`
- Test: `npm test`
- Lint: `npm run lint`

## Conventions
- Use TypeScript strict mode
- All components go in src/components/
- Write tests for all public APIs
```

## CLAUDE.md Locations (priority order)

1. Current directory `./CLAUDE.md`
2. Parent directories (Claude walks up)
3. User global `~/.claude/CLAUDE.md`

## Auto Memory

Claude Code automatically saves learnings to memory files during sessions — things like:

- Build commands it discovered
- Project-specific quirks
- Debugging insights

Auto memory is stored in `~/.claude/projects/<project>/memory/`.

## Memory Types (auto memory)

| Type | When saved |
| --- | --- |
| `user` | User preferences or profile info |
| `feedback` | Corrections or changes to Claude's approach |
| `project` | Project goals, initiatives, or context |
| `reference` | Pointers to external systems/resources |
