# ps Cheatsheet

## Syntax styles

`ps` supports two distinct syntax styles — mixing them causes errors:

| Style | Example | Notes |
| --- | --- | --- |
| BSD | `ps aux` | No leading dash; widely supported |
| POSIX/SysV | `ps -ef` | Leading dash; more portable |
| GNU long | `ps --forest` | Double-dash; Linux only |

## Essential invocations

```bash
ps aux                          # All processes: user, PID, %CPU, %MEM, command
ps -ef                          # All processes: UID, PID, PPID, time, command
ps aux | grep nginx             # Find processes matching a name
ps aux | grep -v grep           # Exclude the grep process itself from results
ps -p 1234                      # Details for a specific PID
ps -p $$                        # Details for the current shell process
ps -u alice                     # Processes owned by a specific user
```

## Output columns (ps aux)

| Column | Meaning |
| --- | --- |
| `USER` | Owner of the process |
| `PID` | Process ID |
| `%CPU` | CPU usage since start |
| `%MEM` | Resident memory as percentage of total RAM |
| `VSZ` | Virtual memory size (KB) |
| `RSS` | Resident set size — physical memory used (KB) |
| `TTY` | Controlling terminal (`?` = no terminal) |
| `STAT` | Process state (see below) |
| `START` | Time the process started |
| `TIME` | Cumulative CPU time used |
| `COMMAND` | Command with arguments |

## Process states (STAT column)

| Code | Meaning |
| --- | --- |
| `R` | Running or runnable |
| `S` | Interruptible sleep (waiting for event) |
| `D` | Uninterruptible sleep (usually I/O) |
| `Z` | Zombie — finished but not reaped by parent |
| `T` | Stopped (by signal or job control) |
| `<` | High priority |
| `N` | Low priority (nice) |
| `s` | Session leader |
| `+` | Foreground process group |
| `l` | Multi-threaded |

## Sorting and filtering

```bash
ps aux --sort=-%mem             # Sort by memory descending (GNU)
ps aux --sort=-%cpu             # Sort by CPU descending (GNU)
ps aux --sort=pid               # Sort by PID ascending
ps aux | sort -k4 -rn           # Sort by %MEM (column 4), portable
ps aux | sort -k3 -rn           # Sort by %CPU (column 3), portable
ps aux | awk '$3 > 5.0'         # Processes using more than 5% CPU
```

## Process trees

```bash
ps --forest                     # ASCII tree (GNU/Linux)
ps -ejH                         # Hierarchical, POSIX-compatible
pstree                          # More readable tree (separate package)
pstree -p                       # Include PIDs
```

## Custom output format

```bash
ps -o pid,ppid,user,stat,cmd                # Select specific columns
ps -o pid,etime,cmd                         # PID, elapsed time, command
ps -o pid,%cpu,%mem,rss,cmd --sort=-%mem    # Memory-focused view
ps -C nginx -o pid,stat,cmd                 # Processes named nginx
```
