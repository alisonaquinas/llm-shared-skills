# ldd Troubleshooting

## Exit Codes

| Code | Meaning |
| --- | --- |
| 0 | Success |
| 1 | Error |

## Common Issues

### Installation Failed

```bash
apt-get install -y ldd
which ldd
```

### File Not Found

```bash
ls -la file
ldd /full/path/to/file
```

## Resources

- Manual: man ldd
