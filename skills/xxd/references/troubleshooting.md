# xxd Troubleshooting

## Exit Code Reference

| Code | Meaning |
| --- | --- |
| 0 | Success |
| 1 | Data/file error |
| 2 | Command error |

## Common Issues

### "Command not found"

**Cause:** Tool not installed or PATH not set.

**Fix:**

```bash
apt-get install -y xxd    # Linux
brew install xxd          # macOS
```

### "Permission denied"

**Cause:** No read permission on input file.

**Fix:**

```bash
chmod +r input_file
xxd input_file
```

### "No such file"

**Cause:** File doesn't exist or wrong path.

**Fix:**

```bash
ls -la /full/path/to/file
xxd /correct/path/file
```

## Platform Differences

Consult man page for platform-specific behavior.

## Resources

- Manual: man xxd
