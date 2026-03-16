# ps Troubleshooting

## grep matches its own process

**Symptom:** `ps aux | grep foo` always shows at least one result (the grep itself).

```bash
ps aux | grep foo | grep -v grep        # Exclude the grep process
pgrep -l foo                            # Cleaner: pgrep filters itself out
pgrep -a foo                            # Show full command lines
```

## Process shows but kill has no effect

**Causes:**
- Process is in `D` (uninterruptible sleep, usually waiting on I/O or kernel call) — SIGKILL will not work until the kernel operation completes
- Process is a zombie (`Z`) — already dead, cannot be killed; reap via the parent
- Insufficient permissions — you do not own the process

```bash
ps aux | grep PID                       # Check STATE column
# D state: wait for I/O or reboot if stuck
# Z state: find and signal/restart the parent
ps -o pid,ppid,stat -p 1234            # Find parent PID
kill -CHLD <parent-pid>                # Request parent to reap zombie
```

## Truncated command lines

**Symptom:** `COMMAND` column is cut off with `...`

```bash
ps aux --cols 200                       # Wider output (GNU)
ps -ww aux                              # Unlimited width (BSD/macOS)
cat /proc/1234/cmdline | tr '\0' ' '   # Full command on Linux
```

## macOS flags not working

**Symptom:** `ps: illegal option` or unexpected output on macOS.

macOS uses BSD `ps`. GNU-only flags (`--forest`, `--sort`, `-C`) are not available.

```bash
ps -ef                                  # POSIX style — works on both
ps aux                                  # BSD style — works on both
brew install htop                       # htop provides tree view on macOS
```

## High CPU process not appearing

**Symptom:** A process consuming CPU is not in `ps aux` output.

`ps` is a snapshot. Short-lived processes (faster than the snapshot interval) may not appear.

```bash
top -b -n 1                             # Top snapshot including ephemeral processes
pidstat -u 1 5                          # Sample CPU every 1s for 5s (Linux, sysstat)
```

## Permission denied reading /proc

**Symptom:** On Linux, some process info is hidden.

```bash
ps aux                                  # You can still see PID and command
sudo ps aux                             # Full detail for all processes
sudo cat /proc/<pid>/status             # Full status with privileges
```

## ps -p returns nothing

**Symptom:** `ps -p 1234` shows no output even though the process should exist.

```bash
kill -0 1234 2>&1                       # Check if PID exists (no signal sent)
ls /proc/1234                           # Linux: confirm process entry exists
```

The process may have exited between when you got the PID and when you ran `ps`.
