# Test Harness Setup

Load when setting up tests for the first time, configuring Vitest for TypeScript,
or configuring pytest for Python.

---

## TypeScript: Vitest Setup

### package.json additions

```json
{
  "scripts": {
    "test": "vitest",
    "test:run": "vitest run"
  },
  "devDependencies": {
    "vitest": "^1.0.0"
  }
}
```

### vitest.config.ts

```typescript
import { defineConfig } from "vitest/config";

export default defineConfig({
  test: {
    globals: true,
    environment: "node",
  },
});
```

### Test File Structure

```text
src/
  index.ts          ← server entry point
  tools/
    echo.ts         ← tool handler (importable function)
    read-file.ts
tests/
  echo.test.ts
  read-file.test.ts
```

Separate handler logic from transport wiring so handlers can be imported
and tested directly without starting a server.

### Example Tool Handler (src/tools/echo.ts)

```typescript
export async function echoHandler(args: { message: string }): Promise<string> {
  return args.message;
}
```

### Example Test (tests/echo.test.ts)

```typescript
import { describe, it, expect } from "vitest";
import { echoHandler } from "../src/tools/echo.js";

describe("echoHandler", () => {
  it("returns the message unchanged", async () => {
    const result = await echoHandler({ message: "hello world" });
    expect(result).toBe("hello world");
  });

  it("returns an empty string for empty input", async () => {
    const result = await echoHandler({ message: "" });
    expect(result).toBe("");
  });
});
```

### Running Tests

```bash
npm test           # Watch mode
npm run test:run   # Single run (CI)
```

---

## Python: pytest Setup

### pyproject.toml additions

```toml
[project.optional-dependencies]
test = ["pytest>=8.0.0", "pytest-asyncio>=0.23.0"]

[tool.pytest.ini_options]
asyncio_mode = "auto"
testpaths = ["tests"]
```

Or use requirements-dev.txt:

```text
pytest>=8.0.0
pytest-asyncio>=0.23.0
```

### Project Structure

```text
server.py           ← or src/my_server/server.py
tools/
  echo.py           ← handler functions (importable)
  read_file.py
tests/
  conftest.py
  test_echo.py
  test_read_file.py
```

### conftest.py

```python
import pytest

@pytest.fixture
def sample_text():
    return "hello world"
```

### Example Tool Handler (tools/echo.py)

```python
def echo_handler(message: str) -> str:
    """Return the input message unchanged."""
    return message
```

### Example Test (tests/test_echo.py)

```typescript
from tools.echo import echo_handler

def test_echo_returns_message():
    result = echo_handler("hello world")
    assert result == "hello world"

def test_echo_empty_string():
    result = echo_handler("")
    assert result == ""
```

### Async Tool Test

```python
import pytest
from tools.fetch import fetch_handler

@pytest.mark.asyncio
async def test_fetch_returns_content():
    result = await fetch_handler(url="http://example.com")
    assert isinstance(result, str)
    assert len(result) > 0
```

### Running Tests

```bash
pytest                  # Run all tests
pytest tests/test_echo.py  # Run single file
pytest -v               # Verbose output
```

---

## Test Coverage Targets

For each tool, write tests covering:

| Test Type | What to Test |
|---|---|
| Happy path | Valid input returns expected output type and format |
| Boundary | Edge values (empty string, zero, max length) |
| Optional params | Behavior when optional params are omitted |
| Error return | Invalid input returns error string, not exception |

Minimum: one happy-path test per tool before moving to integration testing.
