# ps Advanced Usage

## Combining ps with other tools

### Find and signal a process

```bash
# Identify the PID first
ps aux | grep nginx | grep -v grep

# Use pgrep for cleaner lookup
pgrep -l nginx                      # List matching PIDs and names
pgrep -u alice                      # All PIDs owned by alice

# Signal only after confirming PID
kill -TERM $(pgrep nginx)           # Graceful stop
pkill nginx                         # Signal by name (careful: matches substrings)
pkill -f "python myapp.py"          # Match against full command line
```

### Monitoring top CPU/memory consumers

```bash
# One-shot top-10 by memory
ps aux --sort=-%mem | head -11

# One-shot top-10 by CPU
ps aux --sort=-%cpu | head -11

# Watch repeatedly (alternative to top)
watch -n 2 'ps aux --sort=-%cpu | head -20'
```

### Checking parent-child relationships

```bash
ps -o pid,ppid,cmd --forest         # Tree with parent PIDs
ps -o pid,ppid,cmd -p 1234          # Parent of a specific PID
pstree -sp 1234                     # Full ancestry chain for PID
```

## Zombie processes

A `Z` state process has exited but its parent has not called `wait()`. It holds a PID slot but consumes no memory or CPU.

```bash
ps aux | grep 'Z'                   # Find zombie processes
ps -o pid,ppid,stat,cmd | grep Z    # With parent PIDs

# Zombies cannot be killed with kill — they are already dead.
# The fix is to signal or restart the parent process.
kill -CHLD <parent-pid>             # Ask parent to reap children
```

## Linux /proc alternative

On Linux, `ps` reads from `/proc`. You can query it directly for precise data:

```bash
cat /proc/1234/status               # Detailed process status
cat /proc/1234/cmdline | tr '\0' ' ' # Command line with arguments
ls -la /proc/1234/fd/               # Open file descriptors
cat /proc/1234/maps                 # Memory map
```

## macOS differences

```bash
# macOS uses BSD ps — no --forest, no --sort
ps aux | grep nginx                 # Same basic invocations work
ps -ef                              # POSIX style works too
ps -p 1234 -o pid,ppid,user,stat,command   # Custom columns

# Use Activity Monitor or htop for tree views on macOS
brew install htop
```

## Scripting with ps

```bash
# Check if a process is running
if pgrep -x nginx > /dev/null; then
    echo "nginx is running"
fi

# Get PID of a specific process
PID=$(pgrep -x nginx | head -1)

# Wait for a process to exit
while kill -0 "$PID" 2>/dev/null; do sleep 1; done
echo "Process $PID has exited"

# List all PIDs for a command
pgrep -a python3
```
