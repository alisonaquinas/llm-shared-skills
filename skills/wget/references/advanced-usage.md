# wget Advanced Usage

## Resume and Timestamping

Resume interrupted transfers:

```bash
wget --continue --output-document artifact.tar.gz https://example.com/file.tar.gz
```

Avoid re-downloading unchanged files:

```bash
wget --timestamping https://example.com/releases/tool.zip
```

Use `--continue` only for the same remote object and local file.

## Rate Control and Politeness

For repeated or bulk downloads:

```bash
wget --limit-rate=500k --wait=1 --random-wait https://example.com/file.tar.gz
```

These controls reduce pressure on shared services and avoid bursty scraping behavior.

## Recursive Retrieval

Basic recursion:

```bash
wget --recursive --level=2 https://example.com/docs/
```

Safer recursion with domain and path limits:

```bash
wget --recursive --level=2 \
  --domains example.com \
  --no-parent \
  https://example.com/docs/
```

## Mirroring

Mirror a site section:

```bash
wget --mirror --no-parent --domains example.com https://example.com/docs/
```

`--mirror` expands to recursive timestamped retrieval with listing preservation, so verify scope before running it.

## Accept and Reject Patterns

Restrict downloads to file types:

```bash
wget --recursive --no-parent \
  --accept=pdf,zip \
  https://example.com/downloads/
```

Reject noisy or unwanted files:

```bash
wget --recursive --no-parent \
  --reject=jpg,png,gif \
  https://example.com/docs/
```

Regex-based scope:

```bash
wget --recursive \
  --accept-regex='.*\.(pdf|zip)$' \
  --domains example.com \
  https://example.com/downloads/
```

## Directory Layout Control

Save under a chosen directory:

```bash
wget --directory-prefix downloads https://example.com/file.tar.gz
```

Flatten host directories:

```bash
wget --recursive --no-host-directories --cut-dirs=1 https://example.com/docs/
```

## Cookies and Session Flows

Save cookies from a login step:

```bash
wget --save-cookies cookies.txt --keep-session-cookies https://example.com/login
```

Reuse cookies later:

```bash
wget --load-cookies cookies.txt https://example.com/private/file.tar.gz
```

Protect cookie files and remove them when the session ends.

## Auth and Headers

Basic auth:

```bash
wget --user "$WGET_USER" --password "$WGET_PASS" https://example.com/file.tar.gz
```

Custom header:

```bash
wget --header="Authorization: Bearer $API_TOKEN" https://example.com/private/file.tar.gz
```

Avoid storing credentials in shared logs.

## TLS and Pinning

Use a custom CA file:

```bash
wget --ca-certificate=/path/to/internal-ca.pem https://internal.example.com/file.tar.gz
```

Pin a public key when required:

```bash
wget --pinnedpubkey='sha256//BASE64HASH' https://internal.example.com/file.tar.gz
```

## Input Files

Download a curated list of URLs:

```bash
wget --input-file urls.txt --directory-prefix downloads
```

Review the URL list before running bulk retrieval.

## Logging and Server Responses

Capture server response headers:

```bash
wget --server-response --output-file wget.log https://example.com/file.tar.gz
```

Verbose debugging:

```bash
wget --debug --output-file wget-debug.log https://example.com/file.tar.gz
```

## Resources

- `man wget`
- GNU Wget manual: <https://www.gnu.org/software/wget/manual/wget.html>
