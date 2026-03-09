# The Silver Searcher (ag) Install & Setup

## Prerequisites

- macOS 10.13+, Linux (Debian/Fedora/Arch), or Windows (native or WSL2)
- Ability to use package manager or compile from source

## Install by Platform

| macOS | Debian/Ubuntu | Fedora/RHEL | Arch Linux | Windows |
|-------|---------------|-------------|-----------|---------|
| `brew install the_silver_searcher` | `apt install silversearcher-ag` | `dnf install the_silver_searcher` | `pacman -S the_silver_searcher` | `winget install ggreer.ag` |

## Post-Install Configuration

### Create Global .agignore

The Silver Searcher respects ignore patterns in `~/.agignore`. Create one:

```bash
mkdir -p ~/.config/ag  # optional: keep config together
touch ~/.agignore
```

Add common ignore patterns to `~/.agignore`:

```
# Version control
.git
.gitignore
.hg
.svn

# Build artifacts
node_modules
dist
build
*.o
*.a
*.so

# IDE/Editor
.vscode
.idea
*.swp
*~
.DS_Store

# Runtime
__pycache__
.pytest_cache
*.pyc
.env
```

### Verify Installation

```bash
# Check version
ag --version

# Test a simple search
ag "test" ~/.bashrc 2>/dev/null || echo "No matches (expected if pattern not in file)"
```

## Usage Tips

```bash
# Search in current directory
ag "pattern"

# Search with file type restriction
ag --type=python "def foo"

# List matching filenames only
ag -l "pattern"

# Count matches
ag --count "pattern"

# Show context (lines before/after)
ag -C 3 "pattern"

# Search in specific directory
ag "pattern" /path/to/dir

# Exclude directories
ag "pattern" --ignore-dir=node_modules --ignore-dir=.git
```

## Troubleshooting

### "ag: command not found"
- Install not completed. Re-run the install command for your platform.

### Slow searches
- You're likely searching in a large directory (node_modules, .git, etc.).
- Use `--ignore-dir` to exclude them: `ag "pattern" --ignore-dir=node_modules`

### Too many matches
- Use `-t` (type) filter: `ag -t python "import"`
- Limit to specific directory: `ag "pattern" src/`
- Use `-C 0` to show matching lines only (no context): `ag -C 0 "pattern"`
