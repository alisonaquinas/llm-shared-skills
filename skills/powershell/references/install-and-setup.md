# PowerShell 7 Install & Setup

## Prerequisites

- macOS 10.13+, Linux (Debian/Fedora/Arch), or Windows 10+
- Package manager or installer access

## Install by Platform

| macOS | Debian/Ubuntu | Fedora/RHEL | Windows |
|-------|---------------|-------------|---------|
| `brew install powershell` | See Linux note | `dnf install powershell` | `winget install Microsoft.PowerShell` |

**Debian/Ubuntu:** Add Microsoft apt repository:

```bash
curl https://aka.ms/install-powershell.sh | bash
```

## Post-Install Configuration

### Create $PROFILE

PowerShell 7 uses `~/.config/powershell/Microsoft.PowerShell_profile.ps1`:

```powershell
# Create directory if needed
$dir = [System.IO.Path]::GetDirectoryName($PROFILE)
if (!(Test-Path $dir)) { mkdir $dir }

# Create profile
New-Item -Path $PROFILE -Type File -Force
```

### Add Profile Content

Edit `$PROFILE` in your editor:

```powershell
# Show PowerShell version
Write-Host "PowerShell $($PSVersionTable.PSVersion) on $([System.Runtime.InteropServices.RuntimeInformation]::OSDescription)"

# PSReadLine for better command editing
if ((Get-Module PSReadLine).Version -lt '2.2.0') {
  Install-Module PSReadLine -Force
}

# Common aliases
Set-Alias -Name ll -Value Get-ChildItem -Option AllScope -Force

# PSReadLine options
$PSReadLineOptions = @{
  EditMode = 'Vi'  # or 'Windows' for emacs-like
  HistoryNoDuplicates = $true
  HistorySearchCursorMovesToEnd = $true
}
Set-PSReadLineKeyHandler -Chord UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Chord DownArrow -Function HistorySearchForward
```

### Install Modules

```powershell
# PSReadLine (better REPL)
Install-Module PSReadLine -Force

# posh-git (git integration)
Install-Module posh-git -Force

# OhMyPosh (custom prompt, optional)
Install-Module oh-my-posh -Force

# Import modules in profile
Import-Module PSReadLine
Import-Module posh-git
Import-Module oh-my-posh
```

### Reload Profile

```powershell
& $PROFILE
```

## Verification

```powershell
# Check version
pwsh --version

# Verify $PROFILE location
$PROFILE

# Test module imports
Get-Module | Select Name
```

## Troubleshooting

### "$PROFILE does not exist"

- Create it: `New-Item -Path $PROFILE -Type File -Force`

### "Import-Module: The specified module 'PSReadLine' was not found"

- Install the module: `Install-Module PSReadLine -Force`
- May need `-SkipPublisherCheck` if already installed:

  ```powershell
  Install-Module PSReadLine -Force -SkipPublisherCheck
  ```

### Changes to $PROFILE not applying

- Reload: `. $PROFILE` or `& $PROFILE`

### Execution policy prevents running scripts

- Check: `Get-ExecutionPolicy`
- Set for current user: `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser`
