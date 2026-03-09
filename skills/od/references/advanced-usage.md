# od Advanced Usage

## Performance Optimization

```bash
# od with large files or datasets
# Refer to man page for specific performance flags
```

## Common Patterns

### Scripting Integration

```bash
# Use od in shell scripts with proper exit code handling
# Exit codes: 0=success, 1=data error, 2=command error
```

### Platform Differences

GNU and BSD versions may differ. Test on target platform.

```bash
od --version 2>/dev/null || man od
```

## Real-World Examples

Consult man page and advanced usage documentation for tool-specific patterns.

## Resources

- Manual: man od
- Upstream: Check official documentation
