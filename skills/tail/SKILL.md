---
name: tail
description: Sample file endings and monitor growing logs with tail for real-time log viewing, end-of-file inspection, and live log following. Use when the agent needs the last N lines or bytes, follow-mode monitoring of append-only files, or track log file rotation.
---

# tail

Sample and monitor file endings and live-updating streams.

## Quick Start

1. Verify `tail` is available: `tail --version` or `man tail`
2. Establish the command surface: `man tail` or `tail --help`
3. Start with a read-only probe: `tail -n 10 file.txt`

## Intent Router

Load only the reference file needed for the active request.

- `references/install-and-setup.md` — Installing tail (GNU, BSD) on macOS, Linux, Windows
- `references/cheatsheet.md` — Common flags, line/byte counts, follow mode, multiple files
- `references/advanced-usage.md` — GNU vs BSD differences, log rotation handling, large files, performance
- `references/troubleshooting.md` — Follow mode issues, file rotation, encoding, exit codes

## Core Workflow

1. Verify tail version and variant (GNU vs BSD): `tail --version` or `man tail`
2. Specify count explicitly: `-n <N>` for lines or `-c <N>` for bytes
3. Use `-F` for logs (follows by filename, survives rotation)
4. Use `-f` for regular files (follows by file descriptor)
5. Set bounded startup context before follow mode

## Quick Command Reference

```bash
tail --version                          # Check version (GNU vs BSD)
tail -n 10 file.txt                    # Last 10 lines (explicit count)
tail -c 1024 file.bin                  # Last 1024 bytes (explicit count)
tail -n +10 file.txt                   # All lines from line 10 onward
tail -f app.log                        # Follow (append-only, not rotation)
tail -F /var/log/app.log               # Follow with rotation support
tail -n 50 -F app.log                  # Last 50 lines, then follow
tail -q -n 5 file1.txt file2.txt      # Last 5 lines, no headers
man tail                               # Full manual and options
```

## Safety Notes

| Area | Guardrail |
| --- | --- |
| **Explicit counts** | Always use `-n` or `-c` with explicit numbers; defaults (10 lines) may not match intent. |
| **Log rotation** | Use `-F` for logs that rotate; `-f` alone may lose updates when file is replaced. |
| **Multiple files** | Follow mode (`-f`) on multiple files prints clear headers; verify file source before processing. |
| **GNU vs BSD** | GNU supports `-n +N` (from line N); BSD uses same syntax but behavior may differ. Test on target platform. |
| **Large files** | tail seeks to end (efficient), but reads backward for line boundaries; very large files may be slow. |
| **Incomplete lines** | When using `-c`, output may end mid-line; subsequent processing may fail if expecting complete records. |

## Source Policy

- Treat the installed `tail` behavior and `man tail` as runtime truth.
- Use GNU Coreutils documentation (gnu.org/software/coreutils) for GNU-specific extensions.
- Use BSD manual for BSD variant behavior differences.

## Resource Index

- `scripts/install.sh` — Install tail (GNU, BSD, or POSIX variant) on macOS or Linux.
- `scripts/install.ps1` — Install tail on Windows or any platform via PowerShell.
