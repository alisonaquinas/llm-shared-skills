# WSL Interop

Use this reference when the task touches Windows paths, Windows executables, clipboard/process boundaries, or line-ending issues from WSL.

## Path translation

Common patterns:

```bash
wslpath -w "$PWD"
wslpath 'C:\Users\aaqui'
cd /mnt/c/Users/aaqui
```

- `/mnt/c/...` is a Linux path into the Windows filesystem.
- `wslpath -w` converts Linux paths to Windows form.
- `wslpath` without `-w` can convert Windows paths into Linux form.

## Windows executable interop

```bash
cmd.exe /c dir
powershell.exe -NoLogo -NoProfile -Command Get-Date
explorer.exe .
```

- Be explicit about which shell parses the command first.
- Expect CRLF and Windows-style error formatting from Windows commands.
- Prefer quoting for Bash first, then account for the Windows-side parser inside the invoked executable.

## Line endings and text files

- CRLF in shell scripts or config files is a common WSL failure mode.
- Symptoms include `$'\r': command not found` and broken shebang behavior.
- Check files with tools like `sed -n l`, `cat -v`, `file`, or `grep $'\r'`.

## Filesystem caveats

- Linux permissions on `/mnt/c` can behave differently from the native Linux filesystem.
- Path performance, case sensitivity, and metadata can differ between ext4 in WSL and mounted Windows filesystems.
- Prefer the Linux home directory for shell-heavy repos when filesystem behavior matters.

## What to call out in answers

- Whether a path is Linux-form or Windows-form.
- Whether CRLF conversion is part of the bug.
- Whether a Windows executable is involved and therefore a second parser/quoting model applies.
