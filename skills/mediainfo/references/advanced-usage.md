# mediainfo Advanced Usage

## Common Usage Patterns

Refer to man page for detailed usage.

## Performance Optimization

For batch processing large files:

```bash
# Process multiple files efficiently
for file in *.txt; do
  mediainfo "$file"
done
```

## Output Handling

```bash
# Redirect output to file
mediainfo input > output.txt

# Or combine with other tools
mediainfo input | grep "pattern"
```

## Resources

- Manual: man mediainfo
