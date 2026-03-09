# Bash Install & Setup

## Prerequisites

- macOS 10.13+, Linux (Debian/Fedora/Arch), or Windows (WSL2 or Git Bash)
- Ability to use package manager or installer
- Admin rights on macOS (for chsh) and Windows (for WSL2)

## Install by Platform

### macOS

```bash
# Install via Homebrew (macOS 3.2 is ancient; upgrade recommended)
brew install bash

# Add to list of available shells
sudo bash -c 'echo /opt/homebrew/bin/bash >> /etc/shells'

# Change default shell
chsh -s /opt/homebrew/bin/bash

# Verify
bash --version
```

### Linux (Debian/Ubuntu)

```bash
# Update to latest bash
apt update
apt install bash

# Verify
bash --version
```

### Linux (Fedora/RHEL)

```bash
dnf install bash
bash --version
```

### Windows

**Option 1: WSL2 (full Linux environment)**

```powershell
# Install WSL2
wsl --install

# Install bash if needed (usually pre-installed)
sudo apt update
sudo apt install bash
```

**Option 2: Git Bash (Windows-native)**

- Download from <https://git-scm.com/download/win>
- Includes bash, git, and Unix tools (awk, grep, etc.)

## Post-Install Configuration

### Create ~/.bashrc

If missing, create a new one:

```bash
cat > ~/.bashrc << 'EOF'
# Enable vi key bindings
set -o vi

# Or enable emacs key bindings
# set -o emacs

# Customize prompt
PS1='\u@\h:\w$ '

# Add to PATH if needed
export PATH="$PATH:$HOME/.local/bin"

# Useful aliases
alias ll='ls -lah'
alias grep='grep --color=auto'
alias la='ls -la'

# Source other files if they exist
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases
EOF
```

### Create ~/.bash_profile (macOS/login shells)

```bash
cat > ~/.bash_profile << 'EOF'
# Source .bashrc if it exists
if [[ -f ~/.bashrc ]]; then
  source ~/.bashrc
fi
EOF
```

### Set Bash Options

Common options to add to ~/.bashrc:

```bash
# Exit on error in pipelines
set -o pipefail

# Warn about unset variables
set -o nounset

# Quit on first error (use with caution in scripts)
# set -o errexit

# Expand variables in filenames
shopt -s extglob
shopt -s globstar

# Check window size after each command
shopt -s checkwinsize

# Prevent overwriting files with >
set -o noclobber
```

### Enable Bash Completion

```bash
# macOS (via Homebrew)
brew install bash-completion

# Linux (Debian)
apt install bash-completion

# Add to ~/.bashrc:
if [[ -f /etc/bash_completion ]]; then
  source /etc/bash_completion
fi
```

## Verification

```bash
# Check version
bash --version

# Verify .bashrc loaded
echo "SHELL=$SHELL, PS1=$PS1"

# List shell options
set -o
```

## Troubleshooting

### "command not found" after shell change

- Your PATH is wrong or ~/.bashrc is missing.
- Run `echo $PATH` to check.

### Changes to .bashrc not applying

- You need to restart the shell or run `source ~/.bashrc`.

### "Permission denied" when running scripts

- Scripts need execute bit: `chmod +x script.sh`

### macOS still uses old bash

- After installing via brew, verify it's in your shell list: `cat /etc/shells | grep bash`
- Then change: `chsh -s /opt/homebrew/bin/bash`
