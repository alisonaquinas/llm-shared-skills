# The Silver Searcher (ag) Patterns and Usage

## Ignore File Precedence

The Silver Searcher respects ignore files in this order (first match wins):

1. `.gitignore` — Git's standard ignore format
2. `.hgignore` — Mercurial ignore format
3. `.ignore` — ag-specific ignore file
4. `$HOME/.agignore` — User global ignore rules

### Example: Stop Searching vendor/node_modules

Create `.ignore` in project root:

```text
vendor/
node_modules/
build/
dist/
```

Or use `--ignore` flag to skip specific patterns:

```bash
ag "pattern" --ignore="node_modules" --ignore="build"
```

## Output Modes Reference

| Mode | Flag | Output | Use Case |
| --- | --- | --- | --- |
| Default | (none) | filename:linenumber:match | Interactive review |
| List files only | `-l` | Matching filenames only | Pipe to xargs |
| Count matches | `-c` | filename:count | Quick stats |
| Show stats | `--stats` | Detailed statistics | Debug slow searches |
| Null separator | `-0` | Results sep by null | Safe for xargs -0 |
| Output match | `-o` | Only matching text | Extract patterns |

### Examples

```bash
# Show only matching files
ag "TODO" -l

# Count matches per file
ag "TODO" -c

# Display detailed statistics
ag --stats "pattern"

# Extract all email addresses, safe for xargs
ag -o "[a-z]+@[a-z.]+" -0 | xargs -0 echo "Found:"
```

## File Type Filtering

### Built-in Type Filters

```bash
# Search only Python files
ag --python "class "

# Search only JavaScript/TypeScript
ag --js "import "

# List available types
ag --list-file-types
```

### Custom Pattern Filters

```bash
# Files matching glob pattern
ag "pattern" -G "*.config.js"

# Exclude pattern
ag "pattern" --ignore="*test*"

# File search (not content search)
ag --file-search-regex "^src/.*\.tsx$"
```

## Context Control

| Flag | Effect | Example |
| --- | --- | --- |
| `-B N` | N lines before | `ag -B 2 "pattern"` |
| `-A N` | N lines after | `ag -A 3 "pattern"` |
| `-C N` | N lines before and after | `ag -C 1 "pattern"` |

```bash
# Show 3 lines of context
ag -C 3 "function declaration"
```

## Multi-Pattern and Boolean Logic

### Multiple Patterns (AND)

Use `-e` flag multiple times:

```bash
ag -e "import" -e "React" file.js  # Find lines with both
```

### Case-Insensitive

```bash
ag -i "TODO"  # Matches todo, TODO, Todo, etc.
```

### Word Boundaries

```bash
# Match "class" as whole word only, not in "classroom"
ag "\bclass\b"
```

## Script-Friendly Patterns

### Null Separator for Safe Piping

```bash
# Safe with filenames containing spaces/newlines
ag "pattern" -0 | xargs -0 command

# Example: delete matching files
ag -l "temp_" -0 | xargs -0 rm
```

### Suppress Coloring and Headers

```bash
# Machine-readable output
ag --nocolor --nofilename --noheading "pattern"
```

### JSON Output (if available)

Some ag builds support JSON output for parsing:

```bash
ag --json "pattern"  # May not be available on all installations
```

## Performance Flags

| Flag | Effect | Use Case |
| --- | --- | --- |
| `--workers N` | Use N threads | Huge codebases (default ~CPU count) |
| `--depth N` | Max directory depth | Avoid deep nested searches |
| `--skip-vcs-ignores` | Don't read .gitignore | Force search of ignored files |
| `--hidden` | Search hidden files | Include .dotfiles |
| `--no-recurse` | Don't descend directories | Current dir only |

### Performance Examples

```bash
# Fast search of large repo
ag --workers 8 "pattern"

# Limit to 3 directory levels deep
ag --depth 3 "pattern"

# Include hidden files
ag --hidden "pattern" .

# Search even git-ignored files
ag --skip-vcs-ignores "pattern"
```

## Troubleshooting

### No Matches Despite Expected Results

**Cause:** Pattern excluded by ignore files.

**Solution:**

1. Check which files match: `ag -l ".*"`
2. Look for `.ignore`, `.gitignore`, `.hgignore` in parent dirs
3. Use `--skip-vcs-ignores` to override: `ag --skip-vcs-ignores "pattern"`

### Binary File Hits

**Cause:** ag searches binary files and returns non-text matches.

**Solution:**

```bash
# Skip binary files
ag --nonbinary "pattern"

# Or ignore common binary dirs
ag "pattern" --ignore="node_modules" --ignore=".git"
```

### Character Encoding Edge Cases

**Issue:** Patterns with UTF-8 or multibyte chars may not match.

**Solution:**

```bash
# Ensure locale is UTF-8
export LC_ALL=en_US.UTF-8

# Test with explicit encoding
ag "pattern" --nonbinary
```

### Slow Search

**Cause:** Searching large ignored directories or many files.

**Solution:**

1. Add patterns to `.ignore` file
2. Use `--depth` to limit recursion
3. Combine with file type: `ag --python "pattern"`
4. Use `--skip-vcs-ignores` if searching limited scope
