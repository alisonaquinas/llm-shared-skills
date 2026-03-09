# WSL Interop

Use this reference when the task crosses the PowerShell ↔ WSL boundary: calling Linux tools from `pwsh.exe`, calling `pwsh.exe` from Bash, path translation, or line-ending handling.

## Calling WSL from PowerShell

```powershell
# Run a Linux command from pwsh
wsl.exe ls -la /home

# Capture output (stdout as string array)
$files = wsl.exe find /tmp -name '*.log'

# Path translation: Linux → Windows
$winPath = wsl.exe wslpath -w '/home/user/project'

# Path translation: Windows → Linux
$linuxPath = wsl.exe wslpath -u 'C:\Users\user\project'
```

- `wsl.exe` returns text; PowerShell receives strings, not objects.
- Line endings in `wsl.exe` output are LF; PowerShell usually handles them transparently, but `TrimEnd()` or `-replace '\r',''` may be needed if CRLF appears.
- Long paths with spaces must be quoted inside the WSL command string:

  ```powershell
  wsl.exe bash -c "cat '/path with spaces/file.txt'"
  ```

## Calling PowerShell from WSL Bash

```bash
# Run a pwsh command from Bash
pwsh.exe -NoLogo -NoProfile -Command 'Get-Date'

# Pass a Bash variable into PowerShell
value="hello"
pwsh.exe -NoLogo -NoProfile -Command "Write-Output '$value'"

# Check exit code
pwsh.exe -File /mnt/c/scripts/deploy.ps1
echo "Exit: $?"
```

- Single-quote the PowerShell command in Bash to prevent Bash from expanding `$`.
- `pwsh.exe` on WSL resolves to the Windows binary; use `which pwsh.exe` to confirm the path.
- Exit codes from `pwsh.exe` are available in `$?` or `$PIPESTATUS` as usual.

## Path translation patterns

| Direction | Tool | Example |
|-----------|------|---------|
| Linux → Windows | `wslpath -w` | `wsl.exe wslpath -w "$PWD"` (from pwsh) |
| Windows → Linux | `wslpath -u` | `wslpath -u 'C:\Users\user'` (from bash) |
| Relative → absolute | `wslpath -a` | `wslpath -a '../file'` |

- Always quote paths that may contain spaces.
- `/mnt/c/` mounts correspond to `C:\` on the Windows side.

## Line-ending (CRLF) handling

```powershell
# Detect CRLF in a file from PowerShell
$content = Get-Content -LiteralPath $path -Raw
if ($content -match '\r\n') { Write-Warning 'CRLF line endings detected' }

# Write without BOM and with LF endings
$content -replace '\r\n', "`n" | Set-Content -LiteralPath $path -NoNewline
```

```bash
# Fix CRLF in a file from Bash
dos2unix file.sh

# Check for CRLF
file file.sh        # reports "with CRLF line terminators" if present
cat -A file.sh | grep -c $'\r'
```

- Scripts sourced or executed in Bash must use LF; CRLF causes `$'\r': command not found` errors.
- When writing files from PowerShell that will be consumed in WSL, use `Set-Content -NoNewline` after normalizing endings.

## What to call out in answers

- Which side initiates the call (pwsh or bash) — quoting rules differ.
- Whether path translation is needed and in which direction.
- Whether the output will have CRLF line endings and whether the consumer handles them.
- Exit code propagation across the boundary.
