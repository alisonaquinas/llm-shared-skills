# mediainfo Cheatsheet

## High-value options

- `--Output=JSON`: Emit structured JSON metadata.

- `--Full`: Show complete metadata details.

- `--Inform=<TPL>`: Custom template output for specific fields.

- `--Language=raw`: Use raw field names for stable parsing.

## Common one-liners

1. List audio stream language

```bash

mediainfo --Inform='Audio;%Language/String%\n' sample.mkv

```

1. Print duration only

```bash

mediainfo --Inform='General;%Duration/String3%' sample.mp4

```

1. JSON pretty output

```bash

mediainfo --Output=JSON sample.mp4 | jq .

```

## Input/output patterns

- Input: Media files (video/audio containers) and output formatting flags.

- Output: Human-readable or JSON metadata describing streams and container.

## Troubleshooting quick checks

- If fields are missing, switch to `--Full` and inspect raw names.

- If JSON parsing fails, ensure command emitted JSON mode exactly.

- If codec IDs seem unfamiliar, cross-check with player/ffprobe outputs.

## When not to use this command

- Do not use `mediainfo` for frame-accurate analysis or transcoding operations.
