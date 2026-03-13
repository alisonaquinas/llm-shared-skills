# wget Troubleshooting

## Common Failure Areas

- reachability
- local write permissions
- partial downloads
- recursion scope
- TLS validation
- auth and cookie reuse

## Probe First

Start with a read-only check:

```bash
wget --spider https://example.com/file.tar.gz
```

If the probe fails, fix connectivity or auth before downloading to disk.

## Permission and Path Errors

### Symptom

Download fails because the destination path is not writable or points to the wrong directory.

### Checks

```bash
pwd
ls -ld downloads
wget --directory-prefix downloads https://example.com/file.tar.gz
```

Set output paths explicitly to avoid writing into unexpected directories.

## Partial Downloads and Resume Problems

### Symptom

The local file exists but appears incomplete or corrupted.

### Checks

```bash
ls -lh artifact.tar.gz
wget --continue --output-document artifact.tar.gz https://example.com/file.tar.gz
```

If the remote file changed since the partial download started, delete the bad file and start clean instead of resuming.

## HTTPS and Certificate Errors

### Symptom

TLS handshake or certificate validation fails.

### Checks

```bash
wget --server-response https://example.com/file.tar.gz
wget --ca-certificate=/path/to/internal-ca.pem https://internal.example.com/file.tar.gz
```

Prefer fixing CA trust or hostname issues before using `--no-check-certificate`.

## Auth and Cookie Failures

### Common causes

- expired cookies
- wrong user or password
- missing auth header
- redirect to a different host without the expected credentials

### Checks

```bash
wget --debug --output-file wget-debug.log \
  --user "$WGET_USER" --password "$WGET_PASS" \
  https://example.com/private/file.tar.gz
```

Review logs carefully because they may contain sensitive values.

## Runaway Recursion

### Symptom

Recursive retrieval expands far beyond the intended scope.

### Fix

Restrict scope aggressively:

```bash
wget --recursive --level=2 \
  --domains example.com \
  --no-parent \
  https://example.com/docs/
```

Use `--accept`, `--reject`, `--include-directories`, or `--exclude-directories` when mirroring narrow sections.

## Overwrites or Unwanted File Layout

Use one of these controls:

```bash
wget --output-document artifact.tar.gz https://example.com/file.tar.gz
wget --directory-prefix downloads https://example.com/file.tar.gz
wget --no-clobber https://example.com/file.tar.gz
```

Avoid relying on default names when multiple URLs or redirects are involved.

## Proxy Problems

### Symptom

Browser downloads work but wget fails.

### Checks

```bash
echo "$https_proxy"
wget --no-proxy https://example.com/file.tar.gz
```

Confirm proxy URL, auth, and `no_proxy` exclusions.

## Slow or Unstable Retrieval

Bound retries and timeouts:

```bash
wget --tries=5 --timeout=30 --waitretry=2 https://example.com/file.tar.gz
```

Use `--limit-rate` when the server or network path is sensitive to bursts.

## Resources

- `man wget`
- GNU Wget manual: <https://www.gnu.org/software/wget/manual/wget.html>
