#!/usr/bin/env python3
"""Create a MADR-style Architecture Decision Record."""

from __future__ import annotations

import argparse
import datetime as dt
import re
import sys
from pathlib import Path


FILENAME_RE = re.compile(r"^(\d{4})-[a-z0-9]+(?:-[a-z0-9]+)*\.md$")


def slugify(title: str) -> str:
    slug = re.sub(r"[^a-z0-9]+", "-", title.lower()).strip("-")
    slug = re.sub(r"-{2,}", "-", slug)
    if not slug:
        raise SystemExit("error: title must contain at least one letter or digit")
    return slug


def next_number(target_dir: Path) -> int:
    max_seen = 0
    if target_dir.exists():
        for path in target_dir.glob("*.md"):
            match = FILENAME_RE.match(path.name)
            if match:
                max_seen = max(max_seen, int(match.group(1)))
    return max_seen + 1


def yaml_list(value: str) -> str:
    value = value.strip()
    return value if value else "TBD"


def bullet_lines(values: list[str], fallback: list[str]) -> str:
    items = values or fallback
    return "\n".join(f"* {item}" for item in items)


def frontmatter(args: argparse.Namespace) -> str:
    lines = [
        "---",
        f"status: {args.status}",
        f"date: {args.date}",
        f"decision-makers: {yaml_list(args.decision_makers)}",
        f"consulted: {yaml_list(args.consulted)}",
        f"informed: {yaml_list(args.informed)}",
        "---",
        "",
    ]
    return "\n".join(lines) + "\n"


def render_full(args: argparse.Namespace) -> str:
    options = args.option or ["Option A", "Option B"]
    chosen = options[0]
    drivers = bullet_lines(
        args.driver,
        ["TBD quality attribute, constraint, force, or risk"],
    )
    option_list = bullet_lines(options, [])
    option_sections = "\n\n".join(
        (
            f"### {option}\n\n"
            "TBD description or supporting link.\n\n"
            "* Good, because TBD benefit\n"
            "* Bad, because TBD cost or risk"
        )
        for option in options
    )

    return (
        frontmatter(args)
        + f"# {args.title}\n\n"
        "## Context and Problem Statement\n\n"
        "TBD architecture context and decision question.\n\n"
        "## Decision Drivers\n\n"
        f"{drivers}\n\n"
        "## Considered Options\n\n"
        f"{option_list}\n\n"
        "## Decision Outcome\n\n"
        f'Chosen option: "{chosen}", because TBD rationale.\n\n'
        "### Consequences\n\n"
        "* Good, because TBD positive consequence\n"
        "* Bad, because TBD negative consequence\n"
        "* Neutral, because TBD neutral consequence\n\n"
        "### Confirmation\n\n"
        "TBD fitness function, review, test, or operational check.\n\n"
        "## Pros and Cons of the Options\n\n"
        f"{option_sections}\n\n"
        "## More Information\n\n"
        "TBD links, evidence, revisit trigger, or review notes.\n"
    )


def render_minimal(args: argparse.Namespace) -> str:
    options = args.option or ["Option A", "Option B"]
    chosen = options[0]
    return (
        f"# {args.title}\n\n"
        "## Context and Problem Statement\n\n"
        "TBD architecture context and decision question.\n\n"
        "## Considered Options\n\n"
        f"{bullet_lines(options, [])}\n\n"
        "## Decision Outcome\n\n"
        f'Chosen option: "{chosen}", because TBD rationale.\n\n'
        "### Consequences\n\n"
        "* Good, because TBD positive consequence\n"
        "* Bad, because TBD negative consequence\n"
    )


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Create a MADR-style Markdown Architecture Decision Record.",
    )
    parser.add_argument("--title", required=True, help="ADR title")
    parser.add_argument("--dir", default="docs/decisions", help="Decision directory")
    parser.add_argument("--status", default="proposed", help="ADR status")
    parser.add_argument(
        "--date",
        default=dt.date.today().isoformat(),
        help="ADR date in YYYY-MM-DD form",
    )
    parser.add_argument(
        "--decision-makers",
        default="",
        help="Decision makers for YAML metadata",
    )
    parser.add_argument("--consulted", default="", help="Consulted stakeholders")
    parser.add_argument("--informed", default="", help="Informed stakeholders")
    parser.add_argument(
        "--driver",
        action="append",
        default=[],
        help="Decision driver; repeat for multiple drivers",
    )
    parser.add_argument(
        "--option",
        action="append",
        default=[],
        help="Considered option; repeat for multiple options",
    )
    parser.add_argument(
        "--template",
        choices=("full", "minimal"),
        default="full",
        help="Template variant",
    )
    parser.add_argument("--dry-run", action="store_true", help="Print without writing")
    return parser


def main(argv: list[str] | None = None) -> int:
    args = build_parser().parse_args(argv)
    target_dir = Path(args.dir)
    number = next_number(target_dir)
    target = target_dir / f"{number:04d}-{slugify(args.title)}.md"
    content = render_full(args) if args.template == "full" else render_minimal(args)

    if args.dry_run:
        print(f"# Target: {target}")
        print(content, end="")
        return 0

    target_dir.mkdir(parents=True, exist_ok=True)
    if target.exists():
        print(f"error: refusing to overwrite {target}", file=sys.stderr)
        return 1
    target.write_text(content, encoding="utf-8", newline="\n")
    print(target)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
