# Installation Guide

**Version:** 1.1.1 (see [CHANGELOG.md](CHANGELOG.md) for release details)

## Quick Start: Clone from Release

The easiest way to get started is to clone the repository and link it locally:

### Git Clone (Latest or Specific Version)

```bash
# Clone the latest version
git clone https://github.com/alisonaquinas/llm-shared-skills.git
cd llm-shared-skills

# Or clone a specific version (v1.0.0)
git clone --branch v1.0.0 https://github.com/alisonaquinas/llm-shared-skills.git
cd llm-shared-skills
```

Then follow the appropriate setup below for Claude Code or Codex.

---

## Claude Code

Claude Code discovers skills via its plugin system. To use this repo as a local plugin:

### Option A: Add as extra known marketplace (local path)

Claude Code supports local plugin sources. Add this repo to your `~/.claude/settings.json`:

```json
{
  "enabledPlugins": {
    "llm-shared-skills@local": true
  },
  "extraKnownMarketplaces": {
    "local": {
      "source": {
        "source": "local",
        "path": "C:\\Users\\aaqui\\llm-shared-skills"
      }
    }
  }
}
```

### Option B: Symlink individual skills into an existing plugin

If you have a plugin already set up, symlink the `skills/` directories into it:

```powershell
$repo = "C:\Users\aaqui\llm-shared-skills\skills"
$pluginSkills = "C:\path\to\your\plugin\skills"
foreach ($skill in "ag","aws","az","bash","docker","git","glab","markdownlint","powershell","sqlite","zoxide","skill-creator") {
    New-Item -ItemType Junction -Path "$pluginSkills\$skill" -Target "$repo\$skill" -Force
}
```

---

## Codex

Codex loads skills from `~/.codex/skills/`. Create directory junctions (Windows) or symlinks (Linux/macOS) pointing into this repo:

### Windows (PowerShell — Junction links)

```powershell
$repo = "C:\Users\aaqui\llm-shared-skills\skills"
foreach ($skill in "docker","bash","powershell","git","skill-creator") {
    $target = "$env:USERPROFILE\.codex\skills\$skill"
    if (Test-Path $target) {
        Write-Host "Skipping $skill (already exists)"
    } else {
        New-Item -ItemType Junction -Path $target -Target "$repo\$skill"
        Write-Host "Linked $skill"
    }
}
```

### Linux / macOS (Bash — Symlinks)

```bash
REPO="$HOME/llm-shared-skills/skills"  # adjust path as needed
for skill in ag aws az bash docker git glab markdownlint powershell sqlite zoxide skill-creator; do
    target="$HOME/.codex/skills/$skill"
    if [ -e "$target" ]; then
        echo "Skipping $skill (already exists)"
    else
        ln -s "$REPO/$skill" "$target"
        echo "Linked $skill"
    fi
done
```

### Verify

After linking, confirm Codex sees the skills by running `/skills` in the Codex TUI.

---

## Removing a Skill

**Windows:** `Remove-Item "$env:USERPROFILE\.codex\skills\<skill>" -Force`

**Linux/macOS:** `rm "$HOME/.codex/skills/<skill>"`

This only removes the link — the skill files in this repo remain intact.
