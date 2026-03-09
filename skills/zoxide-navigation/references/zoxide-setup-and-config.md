# Zoxide Setup and Configuration

## Shell Integration

Zoxide requires shell-specific initialization to hook into `cd`. Each shell has a different init command.

### Bash

```bash
# Add to ~/.bashrc
eval "$(zoxide init bash)"
```

Restart shell or source: `source ~/.bashrc`

### Zsh

```bash
# Add to ~/.zshrc
eval "$(zoxide init zsh)"
```

Restart shell or source: `source ~/.zshrc`

### Fish

```fish
# Add to ~/.config/fish/config.fish
zoxide init fish | source
```

### PowerShell

```powershell
# Add to $PROFILE
zoxide init powershell | Out-String | Invoke-Expression
```

Create profile if it doesn't exist:
```powershell
New-Item -Path $PROFILE -ItemType File -Force
```

### Nushell

```nu
# Add to $env.NU_CONFIG_PATH
zoxide init nushell | save --raw ~/.local/share/nushell/init-zoxide.nu
# Then source in config
source ~/.local/share/nushell/init-zoxide.nu
```

## Database Location by Platform

Zoxide stores ranked directory data in a SQLite database:

| OS | Default Path | Override |
|---|---|---|
| Linux | `~/.local/share/zoxide/db.zo` | `$_ZO_DATA_DIR` |
| macOS | `~/Library/Application Support/zoxide/db.zo` | `$_ZO_DATA_DIR` |
| Windows | `%APPDATA%\zoxide\db.zo` | `$_ZO_DATA_DIR` |

### Custom Database Location

```bash
export _ZO_DATA_DIR="$HOME/.config/zoxide"
```

## Score Algorithm and Aging

Zoxide ranks directories by a weighted score combining frequency and recency.

### Scoring Rules

1. **Frecency:** Combination of frequency (how often visited) and recency (how recently visited)
2. **Promotion:** Visiting directory increases score exponentially
3. **Aging:** Scores decay over time if not visited (fading older entries)
4. **Threshold:** Must reach minimum score to be ranked (prevents noise from one-off visits)

### Viewing Scores

```bash
# List all ranked directories with scores
zoxide query --list

# Show top 10 directories
zoxide query -ls | head -10

# Full output with details
zoxide query --interactive
```

## Environment Variables Reference

| Variable | Default | Effect |
|---|---|---|
| `_ZO_DATA_DIR` | Platform-specific (see above) | Directory containing `db.zo` |
| `_ZO_ECHO` | `0` | Set to `1` to print new directory on `cd` |
| `_ZO_EXCLUDE_DIRS` | `.git` | Colon-separated dirs to exclude from ranking |
| `_ZO_FZF_OPTS` | (none) | Extra options for fzf (used by `zi`) |
| `_ZO_MAXDB` | `10000` | Max entries in database |
| `_ZO_RESOLVE_SYMLINKS` | `0` | Set to `1` to resolve symlinks in ranking |

### Example Configuration

```bash
# Disable echo, use custom database location, exclude more paths
export _ZO_DATA_DIR="$HOME/.config/zoxide"
export _ZO_ECHO=0
export _ZO_EXCLUDE_DIRS=".git:venv:node_modules"
export _ZO_RESOLVE_SYMLINKS=1
eval "$(zoxide init bash)"
```

## Interactive Mode (zi): fzf Dependency

The `zi` command provides interactive fuzzy selection of frequently used directories. It requires **fzf** (fuzzy finder).

### Installation

```bash
# macOS
brew install fzf

# Linux
sudo apt install fzf

# Manual (all platforms)
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

### Customizing fzf

```bash
# Custom fzf preview and color scheme
export _ZO_FZF_OPTS="--preview 'ls -la {}' --color=16"

# Bind a different key
export _ZO_FZF_OPTS="--bind=ctrl-d:abort"
```

Without fzf, `zi` will fail with: `[ERROR] fzf not found on PATH`

## Migration from Other Tools

### From autojump

```bash
zoxide import --from autojump ~/.local/share/autojump/autojump.txt
```

### From z (bash/zsh version)

```bash
zoxide import --from z ~/.z
```

### From fasd

```bash
zoxide import --from fasd ~/.fasd
```

After import, verify with: `zoxide query --list | head -5`

## Script-Safe Patterns

Zoxide outputs can be piped for non-interactive use:

```bash
# Get full path to most-visited "project" dir
zoxide query --exact project

# Get all dirs matching pattern, one per line
zoxide query --list | grep "\.config"

# Use in scripts (no shell integration needed)
cd "$(zoxide query --best project)"

# Safe null-separated output for xargs
zoxide query --list -0 2>/dev/null | xargs -0 ls -ld
```

## Troubleshooting

### z/zi Command Not Found

**Cause:** Shell initialization not sourced.

**Solution:**
1. Check `~/.bashrc`/`~/.zshrc` for `eval "$(zoxide init ...)"`
2. If present, restart shell: `exec $SHELL`
3. If not present, add init line and source file

### zi Command Fails: fzf Not Found

**Cause:** Interactive mode requires fzf.

**Solution:**
```bash
# Install fzf
brew install fzf  # macOS
sudo apt install fzf  # Linux/Debian

# Verify fzf installed
command -v fzf
```

### Scores Not Updating

**Cause:** Database not writable or shell init not active.

**Solution:**
1. Check database file permissions: `ls -la ~/.local/share/zoxide/`
2. Verify zoxide hooks active: `type z` (should show shell function)
3. Manually update score: `zoxide add /path/to/dir`

### Database Reset

```bash
# Wipe all scores and start fresh
rm ~/.local/share/zoxide/db.zo
zoxide init bash  # Recreate database

# Or set custom location and reset
export _ZO_DATA_DIR="$HOME/.config/zoxide"
rm "$_ZO_DATA_DIR/db.zo"
```

### Symlink Issues

If directory moved but symlink still active:
```bash
# Enable symlink resolution
export _ZO_RESOLVE_SYMLINKS=1
```

This ensures symlinks resolve to actual paths before ranking.
