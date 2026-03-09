# pdfinfo Advanced Usage

## Common Usage Patterns

Refer to man page for detailed usage.

## Performance Optimization

For batch processing large files:

```bash
# Process multiple files efficiently
for file in *.pdf; do
  pdfinfo "$file"
done
```

## Output Handling

```bash
# Redirect output to file
pdfinfo input > output.txt

# Or combine with other tools
pdfinfo input | grep "pattern"
```

## Resources

- Manual: man pdfinfo
