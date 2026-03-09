# Zoxide & fzf Install & Setup

## Prerequisites

- macOS 10.13+, Linux (Debian/Fedora/Arch), or Windows
- bash, zsh, fish, or PowerShell shell
- (Optional) fzf for interactive directory selection with `zi`

## Install by Platform

### Zoxide (required)

| macOS | Debian/Ubuntu | Fedora/RHEL | Arch Linux | Windows |
|-------|---------------|-------------|-----------|---------|
| `brew install zoxide` | `apt install zoxide` | `dnf install zoxide` | `pacman -S zoxide` | `winget install ajeetdsouha.zoxide` |

### fzf (optional but recommended)

| macOS | Debian/Ubuntu | Fedora/RHEL | Arch Linux | Windows |
|-------|---------------|-------------|-----------|---------|
| `brew install fzf` | `apt install fzf` | `dnf install fzf` | `pacman -S fzf` | `winget install junegunn.fzf` |

## Post-Install Configuration

### Add Shell Initialization

After installing, add initialization to your shell startup file:

#### bash (~/.bashrc)

```bash
eval "$(zoxide init bash)"
```

#### zsh (~/.zshrc)

```bash
eval "$(zoxide init zsh)"
```

#### fish (~/.config/fish/config.fish)

```bash
zoxide init fish | source
```

#### PowerShell ($PROFILE)

```powershell
Invoke-Expression (& { (zoxide init powershell | Out-String) })
```

Then reload your shell: `source ~/.bashrc` (bash) or reopen terminal.

### Configure Environment Variables (optional)

```bash
# Add to ~/.bashrc or ~/.zshrc

# Directory to store zoxide data (default: ~/.local/share/zoxide)
export _ZO_DATA_DIR="$HOME/.config/zoxide"

# Echo the matched directory
export _ZO_ECHO=1

# Exclude directories from frecency ranking
export _ZO_EXCLUDE_DIRS="$HOME:$HOME/tmp:$HOME/.cache"

# Pass custom flags to fzf for interactive selection
export _ZO_FZF_OPTS="--height 40% --reverse"

# Resolve symlinks before recording (useful for macOS /tmp symlink)
export _ZO_RESOLVE_SYMLINKS=1
```

## Verification

```bash
# Check installation
z --help
zi --help  # Interactive version (requires fzf)

# Test basic navigation
cd /tmp
z -l        # List all ranked directories

# Interactive test (if fzf installed)
zi
```

## Usage

```bash
# Jump to frequently accessed directory
z project    # Matches $HOME/work/project

# Jump with full path
z work/project/src

# Interactive selection (requires fzf)
zi           # Opens fzf menu to pick directory

# List all tracked directories with scores
z -l

# Add current directory manually
z /path/to/dir

# Remove directory from history
z --remove /path/to/dir

# Clean up data file
z --clean

# Show stats
z -l | head
```

## fzf Integration (optional)

If you installed fzf, you get interactive `zi` for fuzzy finding:

```bash
# Customize fzf preview with zoxide
export _ZO_FZF_OPTS="--height 40% --reverse --preview 'ls -la {}' --preview-window right:20%"
```

## Troubleshooting

### "z: command not found"
- Installation incomplete. Re-run `brew install zoxide` (macOS) or package manager for your OS.
- Or restart shell: `source ~/.bashrc` or close/reopen terminal.

### "zi command not found"
- fzf not installed. Run: `brew install fzf` (or package manager for your OS).

### Directory not tracked or zi shows nothing
- Zoxide learns from your `cd` commands. Navigate to directories first.
- Or manually add: `z /path/to/dir`
- Check tracked dirs: `z -l`

### "fzf: command not found" when using zi
- Install fzf: `brew install fzf` (macOS) or `apt install fzf` (Linux).

### zi freezes or behaves oddly
- fzf options may be wrong. Check: `echo $_ZO_FZF_OPTS`
- Reset to defaults: `unset _ZO_FZF_OPTS` and try again.
