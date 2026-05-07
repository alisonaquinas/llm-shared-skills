# MADR Format Notes

MADR means Markdown Architectural Decision Records. The current public site
announces release 4.0.0 and lists template variants for full, minimal, bare,
and bare-minimal records.

Source references:

- <https://adr.github.io/madr/>
- <https://github.com/adr/madr/tree/4.0.0/template>

## Core Structure

A full MADR-style record normally contains:

| Section | Purpose | Required |
|---|---|---|
| H1 title | Short decision title naming the problem and solution | Yes |
| Context and Problem Statement | The architectural context and decision question | Yes |
| Decision Drivers | Forces, constraints, quality attributes, or tradeoffs | Optional |
| Considered Options | Candidate choices, one option per bullet | Yes |
| Decision Outcome | Chosen option and rationale | Yes |
| Consequences | Good, bad, and neutral results of the decision | Optional |
| Confirmation | How compliance or implementation will be checked | Optional |
| Pros and Cons of the Options | Evidence and tradeoffs for each option | Optional |
| More Information | Links, evidence, review notes, or revisit triggers | Optional |

Use one H1 only. Use H2 for top-level MADR sections and H3 for option details
or outcome subsections.

## Metadata

MADR 4 uses YAML front matter for optional metadata. Common fields:

| Field | Meaning |
|---|---|
| `status` | `proposed`, `rejected`, `accepted`, `deprecated`, or supersession note |
| `date` | Last update date, formatted as `YYYY-MM-DD` |
| `decision-makers` | People or groups with decision authority |
| `consulted` | People whose input was sought with two-way communication |
| `informed` | People kept up to date with one-way communication |

Keep metadata accurate. Do not mark a record as accepted unless the decision has
actually been made.

## File Naming

MADR recommends decision records under a `decisions/` folder, often
`docs/decisions/`.

Common filename pattern:

```text
NNNN-title-with-dashes.md
```

Rules:

- `NNNN` is a four-digit sequence number.
- The title uses lowercase words separated by dashes.
- The suffix is `.md`.
- Categorized directories may restart numbering per category.

## Authoring Checks

Before creating or updating an ADR, verify:

- The decision is architecturally significant or durable enough to record.
- The title names the selected direction, not just the topic.
- Context states the real constraint or force driving the choice.
- Considered options include the selected option and credible alternatives.
- Outcome explains why the selected option wins.
- Consequences include tradeoffs, not only benefits.
- Confirmation describes how the choice will be checked later.

## Markdown Style

The MADR template ships a markdownlint config that permits long lines and
duplicate headings. That matches one-sentence-per-line writing and repeated
option headings. Local project markdown rules still take precedence when they
are stricter.
