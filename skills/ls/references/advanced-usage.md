# ls Advanced Usage

## GNU vs BSD differences

macOS ships BSD `ls`. Many GNU flags are absent. Key differences:

| Feature | GNU ls | BSD ls (macOS) |
| --- | --- | --- |
| `--color=auto` | Yes | `-G` flag instead |
| `--group-directories-first` | Yes | No |
| `-X` (sort by extension) | Yes | No |
| `-v` (natural sort) | Yes | No |
| Human sizes | `-h` (requires `-l`) | `-h` (requires `-l`) |

Install GNU coreutils on macOS for GNU behaviour:

```bash
brew install coreutils
# then use gls instead of ls
alias ls='gls --color=auto'
```

## Scripting safely with ls output

**Do not parse `ls` output** for filenames in scripts — filenames can contain
spaces, newlines, and other characters that corrupt pipelines. Use `find` with
`-print0` and `xargs -0` instead:

```bash
# Unsafe — breaks on spaces and special characters
for f in $(ls *.txt); do process "$f"; done

# Safe — null-delimited
find . -maxdepth 1 -name "*.txt" -print0 | xargs -0 -I{} process {}

# Also safe — shell glob expansion
for f in *.txt; do [[ -f "$f" ]] && process "$f"; done
```

## Combining ls with pipelines

```bash
# Count files in directory
ls -1 | wc -l

# Find largest files
ls -lS | head -20

# List files modified in last 24h (approximate via sort)
ls -lt | awk 'NR>1 && /Jan|Feb|Mar/ {print}'

# Feed file list to another command
ls -1 *.log | xargs grep "ERROR"
```

## Directory-only and file-only listings

```bash
# List directories only
ls -d */                            # Glob: trailing slash matches dirs
ls -l | grep '^d'                   # Filter long output
find . -maxdepth 1 -type d          # Reliable alternative

# List files only
ls -p | grep -v '/'                 # -p appends / to dirs; filter them out
find . -maxdepth 1 -type f          # Reliable alternative
```

## Inode and block information

```bash
ls -i file.txt          # Show inode number
ls -s file.txt          # Show allocated blocks (not file size)
ls -li                  # Long format + inodes
```

## Colour configuration

```bash
# GNU: use dircolors to customise colours
eval "$(dircolors -b)"
export LS_COLORS

# BSD (macOS): use LSCOLORS env var
export LSCOLORS=ExFxBxDxCxegedabagacad
```
