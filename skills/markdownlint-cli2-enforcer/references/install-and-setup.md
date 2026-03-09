# markdownlint-cli2 Install & Setup

## Prerequisites

- Node.js 12+ (includes npm)
- macOS, Linux, or Windows
- Markdown files to lint

## Install Dependencies

### Install Node.js

| macOS | Debian/Ubuntu | Fedora/RHEL | Windows |
|-------|---------------|-------------|---------|
| `brew install node` | `apt install nodejs npm` | `dnf install nodejs` | `winget install OpenJS.NodeJS` |

Verify: `node --version && npm --version`

## Install markdownlint-cli2

### Global Install (recommended for CLI use)

```bash
npm install -g markdownlint-cli2
```

Verify: `markdownlint-cli2 --version`

### Project-Local Install

```bash
npm install --save-dev markdownlint-cli2
npx markdownlint-cli2 "**/*.md"
```

### Zero-Install with npx

No installation required:

```bash
npx markdownlint-cli2 "**/*.md"
```

## Post-Install Configuration

### Create .markdownlint-cli2.jsonc

Create at project root (or in home directory for global rules):

```bash
cat > .markdownlint-cli2.jsonc << 'EOF'
{
  "extends": "markdownlint/style/prettier",
  "default": true,
  "MD004": false,
  "MD013": {
    "line_length": 120,
    "code_block_line_length": 0
  },
  "MD033": false,
  "MD034": false
}
EOF
```

### Common Rule Customizations

```jsonc
{
  "default": true,

  // Disable specific rules
  "MD013": false,           // Line length
  "MD033": false,           // Inline HTML
  "MD034": false,           // Bare URLs

  // Custom line length
  "MD013": {
    "line_length": 100,
    "code_block_line_length": 0  // No limit for code blocks
  },

  // Custom heading levels
  "MD025": {
    "level": 2
  }
}
```

## Usage

```bash
# Lint all markdown files
markdownlint-cli2 "**/*.md"

# Fix automatically
markdownlint-cli2 --fix "**/*.md"

# Lint specific file
markdownlint-cli2 README.md

# Ignore files
markdownlint-cli2 "**/*.md" "#node_modules"

# Config file (if not .markdownlint-cli2.jsonc)
markdownlint-cli2 --config my-config.jsonc "**/*.md"
```

## Verification

```bash
# Check installation
markdownlint-cli2 --version

# Test linting
echo "# Test\n\nThis is a test." > test.md
markdownlint-cli2 test.md
rm test.md
```

## Troubleshooting

### "command not found: markdownlint-cli2"

- Global install failed. Try: `npm install -g markdownlint-cli2`
- Or use npx: `npx markdownlint-cli2 "**/*.md"`

### "Cannot find module" errors

- Node.js or npm not installed. Install Node.js from nodejs.org or via package manager.

### Config file ignored

- Ensure file is named `.markdownlint-cli2.jsonc` (exact name, includes leading dot).
- Or specify explicitly: `markdownlint-cli2 --config path/to/config.jsonc "**/*.md"`

### Fix changes nothing

- Not all rules can auto-fix. Check error messages: `markdownlint-cli2 "**/*.md"`
