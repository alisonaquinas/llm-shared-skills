# xq Installation and Setup

`xq` is the XML sibling of `yq`, distributed in the same Python package. Both
`jq` (C binary) and `yq` (Python package) must be installed.

## Step 1 — Install jq

### Debian / Ubuntu

```bash
apt-get update && apt-get install -y jq
```

### macOS

```bash
brew install jq
```

### Windows

```powershell
winget install jqlang.jq
```

### Verify

```bash
jq --version
```

## Step 2 — Install yq (provides xq)

### pip (all platforms)

```bash
pip install yq
# or
pip3 install yq
```

### macOS (Homebrew)

```bash
brew install python-yq
```

### Windows (pip)

```powershell
pip install yq
```

### Verify

```bash
xq --version
yq --version
```

## Quick Test

```bash
echo '<root><a>hello</a></root>' | xq '.root.a'
# Expected: "hello"
```

## Upgrading

```bash
pip install --upgrade yq
```

## References

- GitHub: <https://github.com/kislyuk/yq>
- PyPI: <https://pypi.org/project/yq/>
- jq documentation: <https://jqlang.org/manual/>
