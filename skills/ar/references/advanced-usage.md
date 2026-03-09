# ar Advanced Usage

## Archive Format and Structure

### Archive Header Format

ar archives have a simple format:

- Magic bytes: `!<arch>` (7 bytes + newline)
- File members with headers
- Optional symbol table

```bash
# View archive magic bytes
od -c libexample.a | head -2
# Should show: ! < a r c h (newline)
```

## Symbol Table Management

### Creating and Rebuilding Symbol Table

```bash
# Create/rebuild symbol table
ar s libexample.a

# Useful after manual member modifications
# Ensures linker can find symbols correctly
```

### Examining Symbol Table

```bash
# View symbols in archive
nm libexample.a

# Count symbols
nm libexample.a | wc -l

# Find specific symbol
nm libexample.a | grep "func_name"

# Show symbol types
nm -v libexample.a
# T = text (code)
# D = data
# U = undefined (external reference)
```

## Member Management

### Understanding Member Order

```bash
# Member order can matter for linkers
# Especially for static initialization

# View members in order
ar t libexample.a

# Extract in order
ar x libexample.a
ls -U  # List in creation order
```

### Selective Member Operations

```bash
# Add member at specific position
ar r libexample.a -a existing.o new.o
# Adds new.o after existing.o

# Insert before specific member
ar r libexample.a -b existing.o new.o
# Adds new.o before existing.o

# Delete specific member
ar d libexample.a unwanted.o

# Extract without full archive
ar p libexample.a module.o > module.o.extracted
```

## GNU vs BSD ar

### Differences

Most modern systems use GNU ar. Key differences:

```bash
# GNU ar: more options
ar --help

# BSD ar: fewer options
man ar

# Both support basic operations
ar t, ar x, ar r, ar d
```

### Compatibility

```bash
# Archives created with GNU ar work on BSD
# Archives created with BSD ar work on GNU

# Symbol table format is compatible
ar s libexample.a  # Works on both

# Long filename handling differs slightly
# But most files are under 16-character limit
```

## Advanced Member Extraction

### Extract with Modification Dates

```bash
# View modification times
ar tv libexample.a

# Extract preserving timestamps
ar x libexample.a
touch -r libexample.a *.o  # Match archive time

# Restore original times before re-archiving
ar rcs libexample.a module1.o module2.o
```

### Conditional Replacement

```bash
# Only replace if source is newer
ar ru libexample.a newer_module.o
# 'u' flag: only replace if newer

# Replace all matching
ar r libexample.a *.o
```

## Archive Statistics

```bash
# Archive size
du -h libexample.a

# Detailed contents
ar tv libexample.a

# Count members
ar t libexample.a | wc -l

# Total member size (uncompressed)
ar t libexample.a | xargs -I {} ar p libexample.a {} | wc -c
```

## Building and Linking

### Using Archive in Build

```bash
# Compile and create archive
gcc -c module1.c -o module1.o
gcc -c module2.c -o module2.o
ar rcs libmylib.a module1.o module2.o

# Link against archive
gcc -o program main.c -L. -lmylib

# Link with explicit path
gcc -o program main.c libmylib.a
```

### Checking for Unresolved Symbols

```bash
# After linking, check for undefined symbols
nm libmylib.a | grep ' U '
# 'U' means undefined (external reference)

# If many undefined, archive may have missing dependencies
# Link order becomes important for circular dependencies
```

## Real-World Patterns

### Creating Staged Archives

```bash
# Stage 1: Compile everything
for source in *.c; do
  gcc -c "$source"
done

# Stage 2: Create base archive
ar rcs libbase.a base1.o base2.o
ar s libbase.a

# Stage 3: Add optional modules
ar r libbase.a optional1.o optional2.o
ar s libbase.a

# Stage 4: Verify
ar t libbase.a
nm libbase.a | wc -l
```

### Debugging Symbol Resolution

```bash
# Create archive with verbose output
ar rsvc libexample.a *.o
# 'v' = verbose (shows what's being added)

# Check symbol table is current
ar s libexample.a
ar t libexample.a

# Verify with nm
nm -C libexample.a  # C++ demangling
nm -v libexample.a  # Verbose with types
```

## Performance Considerations

### Archive Size Management

Large archives can slow linking:

```bash
# Split large archive into multiple archives
# Only link what's needed

# Check archive size
du -h libexample.a

# Compress separate smaller archives
for module in module1 module2 module3; do
  ar rcs lib${module}.a ${module}.o
done

# Link multiple smaller archives
gcc -o program main.c -lmodule1 -lmodule2 -lmodule3
```

## Resources

- ar Manual: <https://sourceware.org/binutils/docs/binutils/ar.html>
- GNU Binutils: <https://www.gnu.org/software/binutils/>
