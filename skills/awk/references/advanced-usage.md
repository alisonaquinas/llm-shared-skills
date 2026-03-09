# awk — Advanced Usage

## Multi-Dimensional Arrays

Store and query two or more dimensional data:

```bash
# Two-dimensional lookup
awk 'NR==1 {next} {key=$1 "_" $2; data[key]=$3} END {print data["foo_bar"]}' file.txt

# Iterate all keys
awk 'END {for (k in data) print k, data[k]}' file.txt

# Delete entries
awk 'BEGIN {a[1]=10; a[2]=20; delete a[1]}' # Remove a[1]
```

### Multi-Index Syntax (gawk)

```bash
# SUBSEP separates indices (default: \034)
awk 'BEGIN {a[1,2,3]=42; print a[1,2,3]}'

# Change separator for readability
awk 'BEGIN {SUBSEP=":"; a[1,2]=42; print a[1,2]}'

# Iterate with multi-index
awk 'BEGIN {a[1,2]=10; a[1,3]=20; for (k in a) print k, a[k]}'
```

## String Functions

### Built-in Functions

```bash
# Substring
awk 'BEGIN {print substr("hello", 2, 3)}'  # "ell"

# Index (find substring)
awk 'BEGIN {print index("hello", "ll")}'   # 3

# Length
awk 'BEGIN {print length("hello")}'        # 5

# Substitution: replace first match
awk 'BEGIN {s="hello world"; sub(/o/, "O", s); print s}'  # "hellO world"

# Global substitution: replace all matches
awk 'BEGIN {s="hello world"; gsub(/o/, "O", s); print s}'  # "hellO wOrld"

# Tolower / Toupper
awk 'BEGIN {print tolower("HeLLo")}'       # "hello"
awk 'BEGIN {print toupper("HeLLo")}'       # "HELLO"
```

### GNU awk Extensions

```bash
# gensub: replace with capture groups
awk 'BEGIN {print gensub(/([0-9]+)-([0-9]+)/, "\\2-\\1", "g", "12-34")}' # "34-12"

# strftime: format time
awk 'BEGIN {print strftime("%Y-%m-%d", 1234567890)}'  # "2009-02-13"

# mktime: parse date to timestamp
awk 'BEGIN {print mktime("2009 02 13 00 00 00")}'     # 1234516800 (or platform-dependent)

# systime: current timestamp
awk 'BEGIN {print systime()}'
```

## Regex Subtleties

### Regex Context

```bash
# Match operator: ~
awk '$1 ~ /^prod/ {print}'            # Field 1 starts with "prod"

# Not match: !~
awk '$1 !~ /^test/ {print}'           # Field 1 does not start with "test"

# Case-insensitive (IGNORECASE, gawk only)
awk 'BEGIN {IGNORECASE=1} /HELLO/ {print}' file.txt

# Dynamic regex
awk -v pat="$PATTERN" '$1 ~ pat {print}' file.txt
```

### Greedy vs Non-Greedy

awk uses greedy matching (no non-greedy syntax):

```bash
# Greedy: matches from first to last separator
echo "a,b,c,d" | awk -F, '{print $NF}'  # "d"

# Workaround for non-greedy with split
echo "a,b,c,d" | awk '{n=split($0, a, ","); for (i=1; i<=n; i++) print a[i]}'
```

## User-Defined Functions

```bash
# Define and call custom functions
awk '
  function add(a, b) {
    return a + b
  }
  BEGIN {
    print add(3, 5)  # 8
  }
'

# Functions with arrays
awk '
  function sum_array(arr,    i, total) {  # "i, total" are local (3+ spaces)
    total = 0
    for (i in arr) total += arr[i]
    return total
  }
  BEGIN {
    a[1]=10; a[2]=20; a[3]=30
    print sum_array(a)  # 60
  }
'
```

## Scripting Workflows

### Multi-File Processing

```bash
# Process multiple files, reset FNR per file
awk 'FNR==1 {print "--- " FILENAME " ---"} {print}' file1.txt file2.txt file3.txt

# Stop reading current file early (gawk)
awk 'FNR==10 {nextfile} {print}' file1.txt file2.txt  # Print first 9 lines of each file
```

### Reading Input into Arrays

```bash
# Store entire file in array
awk '{lines[NR]=$0} END {for (i=1; i<=NR; i++) print lines[i]}' file.txt

# Store keys/values
awk 'NR==1 {next} {map[$1]=$2} END {for (k in map) print k, map[k]}' file.txt
```

### Output Formatting

```bash
# printf for control
awk 'BEGIN {printf "%10s %5d\n", "name", 42}'  # Right-align, padding

# Multiple output files
awk '{print > ("output_" NR ".txt")}' input.txt  # Creates output_1.txt, output_2.txt, ...

# Append to file
awk '{print >> "log.txt"}' input.txt  # Append instead of overwrite
```

## GNU vs POSIX Differences

| Feature | GNU awk | POSIX awk | Notes |
| --- | --- | --- | --- |
| `gensub()` | Yes | No | Capture groups and global substitution |
| `nextfile` | Yes | No | Skip to next input file |
| `switch` | Yes (4.0+) | No | Pattern matching |
| `strftime()`, `systime()` | Yes | No | Time functions |
| `IGNORECASE` | Yes | No | Case-insensitive matching |
| `FPAT` | Yes | No | Field pattern (instead of FS) |
| Coprocess: `\|&` | Yes | No | Two-way pipes |
| `delete array` | Yes | No | Clear entire array |

Test on the target platform and document assumptions.

## Performance Tips

1. **Avoid nested loops over arrays**: O(n²) can slow large datasets

   ```bash
   # Slow: nested lookup
   awk 'FNR==NR {a[$1]=1; next} {if ($1 in a) print}' file1 file2
   ```

2. **Use `in` operator for existence checks**, not iteration:

   ```bash
   if ($1 in a) print  # Fast
   # vs. for (k in a) if (k==$1) print  # Slow
   ```

3. **Pre-compile patterns** if possible:

   ```bash
   awk 'BEGIN {pat="^[0-9]+"} $1 ~ pat {print}' file.txt
   ```

4. **Use `close()` for large file output**:

   ```bash
   awk '{print $1 > "output.txt"; close("output.txt")}' input.txt
   ```

## Debugging

```bash
# Enable tracing (gawk)
awk -W debug 'BEGIN {x=5} {print x}' file.txt

# Print variables at each step
awk '{print "DEBUG: NR=" NR ", $0=" $0} {print}' file.txt | head -20
```
