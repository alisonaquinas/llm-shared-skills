# ls Cheatsheet

## Essential flags

| Flag | Meaning |
| --- | --- |
| `-l` | Long format: permissions, links, owner, group, size, date, name |
| `-a` | Include hidden files (names starting with `.`) |
| `-A` | Include hidden files except `.` and `..` |
| `-h` | Human-readable sizes (K, M, G) — requires `-l` |
| `-R` | Recursive listing of all subdirectories |
| `-1` | One entry per line (useful for pipelines) |
| `-d` | List directory entries themselves, not their contents |
| `--color=auto` | Colourised output (GNU only) |

## Sorting flags

| Flag | Sort order |
| --- | --- |
| `-t` | By modification time, newest first |
| `-S` | By size, largest first |
| `-r` | Reverse the current sort order |
| `-u` | By last access time (with `-l`) |
| `-c` | By last status-change time (with `-l`) |
| `-X` | Alphabetically by file extension (GNU) |
| `--group-directories-first` | Directories before files (GNU) |

## Common invocations

```bash
ls                          # Current directory, short names
ls -l                       # Long listing
ls -lah                     # Long, all files, human-readable
ls -lt                      # Sorted by modification time, newest first
ls -ltr                     # Sorted by time, oldest first (log review)
ls -lS                      # Sorted by size, largest first
ls -laSh                    # All files, sorted by size, human-readable
ls -1                       # One filename per line
ls -d */                    # Directories in current dir only
ls -lh *.py                 # Long listing filtered by glob
ls -la /etc/                # Hidden files in a specific directory
ls --color=always | less -R # Coloured output piped to pager
```

## Understanding long-format output

```text
-rw-r--r--  1  alice  staff  4096  Mar 15 10:23  notes.txt
^^^^^^^^^   ^  ^^^^^  ^^^^^  ^^^^  ^^^^^^^^^^^  ^^^^^^^^^
permission  links owner group size  date/time    filename
```

Permission string breakdown: `[type][owner][group][other]`

- Type: `-` file, `d` directory, `l` symlink, `p` pipe, `s` socket
- Each triplet: `r` read, `w` write, `x` execute, `-` not set

## Filtering output

```bash
ls *.txt                    # Files matching shell glob
ls -d .*/                   # Hidden directories only
ls -l | grep "^d"           # Directories only (via long format prefix)
ls -l | grep "^-"           # Regular files only
ls -l | grep "^l"           # Symlinks only
ls -lt | head -10           # 10 most recently modified files
```
