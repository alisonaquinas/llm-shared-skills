# pdftotext Troubleshooting

## Exit Codes

| Code | Meaning |
| --- | --- |
| 0 | Success |
| 1 | Error |

## Common Issues

### Installation Failed

```bash
# Install dependencies
apt-get install -y pdftotext

# Or verify in PATH
which pdftotext
```

### File Not Found

```bash
# Verify file exists
ls -la file

# Use full path
pdftotext /full/path/to/file
```

### Permission Denied

```bash
# Check file permissions
ls -l file

# Add read permission
chmod +r file
```

## Resources

- Manual: man pdftotext
