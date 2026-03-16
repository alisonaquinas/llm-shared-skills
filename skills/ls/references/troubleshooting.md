# ls Troubleshooting

## No colour output

**Symptom:** `ls` shows plain text with no colour highlighting.

**Causes and fixes:**

```bash
# Check if colour is configured
echo $LS_COLORS                     # Should be non-empty on Linux
ls --color=auto                     # Force colour (GNU)
ls -G                               # Force colour (BSD/macOS)

# Add to ~/.bashrc or ~/.zshrc
alias ls='ls --color=auto'          # GNU
alias ls='ls -G'                    # macOS
```

## Broken symlinks shown but not obvious

**Symptom:** A filename appears in the listing but operations on it fail.

```bash
ls -l                               # Broken link shows: lrwxrwxrwx ... -> missing
ls -la --color=always               # Broken links shown in red (GNU)
find . -maxdepth 1 -type l ! -e .   # Find all dangling symlinks
```

## Filenames with spaces or special characters

**Symptom:** Output looks malformed; filenames are split at spaces.

```bash
ls -Q                               # Quote filenames (GNU)
ls -b                               # Show non-printable chars as backslash escapes
ls --quoting-style=shell            # Shell-safe quoting (GNU)
```

Never try to parse `ls` output for filenames with special characters in scripts. Use `find -print0` instead.

## GNU flag not available on macOS

**Symptom:** `ls: illegal option -- -` or flag silently ignored.

```bash
ls --version                        # GNU or BSD?
brew install coreutils && gls ...   # Use gls for GNU behaviour on macOS
```

Common GNU-only flags: `--color`, `--group-directories-first`, `--sort=extension`, `-v`.

## Permission denied on some entries

**Symptom:** `ls: cannot open directory ...: Permission denied`

```bash
ls -la /restricted/dir              # Confirm permissions of directory itself
sudo ls /restricted/dir             # List with elevated privileges
```

## Extremely long listing output

**Symptom:** `ls -R` produces thousands of lines.

```bash
ls -R | less                        # Page the output
ls -R | wc -l                       # Count lines before displaying
find . | head -50                   # Alternative with depth control
tree -L 2                           # Visual summary limited to 2 levels
```

## Files not appearing in listing

**Symptom:** A known file is not shown.

```bash
ls -a                               # Check if it is a hidden (dot) file
ls -l /exact/path/to/file           # Check it exists at the expected path
file /exact/path/to/file            # Confirm type
```
