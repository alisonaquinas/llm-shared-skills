#!/usr/bin/env python3
"""Lint MADR-style Architecture Decision Records."""

from __future__ import annotations

import argparse
import re
from dataclasses import dataclass
from pathlib import Path

FILENAME_RE = re.compile(r"^\d{4}-[a-z0-9]+(?:-[a-z0-9]+)*\.md$")
H1_RE = re.compile(r"^# (?!#)(.+)$", re.MULTILINE)
HEADING_RE = re.compile(r"^(#{2,3}) (.+)$", re.MULTILINE)
PLACEHOLDER_RE = re.compile(r"(\{[^}\n]+\}|TBD|\.\.\.)", re.IGNORECASE)
STATUS_RE = re.compile(r"^status:\s*(.+)$", re.MULTILINE)

REQUIRED_H2 = [
    "Context and Problem Statement",
    "Considered Options",
    "Decision Outcome",
]

KNOWN_STATUSES = {
    "proposed",
    "rejected",
    "accepted",
    "deprecated",
}


@dataclass
class Finding:
    level: str
    path: Path
    message: str


def iter_markdown_targets(path: Path) -> list[Path]:
    if path.is_file():
        return [path]
    if path.is_dir():
        return sorted(p for p in path.rglob("*.md") if p.is_file())
    raise SystemExit(f"error: path does not exist: {path}")


def has_bullets_after(text: str, heading: str) -> bool:
    pattern = re.compile(
        rf"^## {re.escape(heading)}\s*\n(?P<body>.*?)(?=^## |\Z)",
        re.MULTILINE | re.DOTALL,
    )
    match = pattern.search(text)
    return bool(match and re.search(r"^\s*[*-]\s+\S+", match.group("body"), re.MULTILINE))


def lint_file(path: Path) -> list[Finding]:
    text = path.read_text(encoding="utf-8")
    findings: list[Finding] = []

    if not FILENAME_RE.match(path.name):
        findings.append(
            Finding("WARN", path, "filename should match NNNN-title-with-dashes.md"),
        )

    h1s = H1_RE.findall(text)
    if len(h1s) != 1:
        findings.append(Finding("ERROR", path, f"expected exactly one H1, found {len(h1s)}"))

    headings = [match.group(2).strip() for match in HEADING_RE.finditer(text)]
    for heading in REQUIRED_H2:
        if heading not in headings:
            findings.append(Finding("ERROR", path, f"missing required section: {heading}"))

    if "Considered Options" in headings and not has_bullets_after(text, "Considered Options"):
        findings.append(Finding("ERROR", path, "Considered Options must include bullets"))

    outcome_match = re.search(
        r"^## Decision Outcome\s*\n(?P<body>.*?)(?=^## |\Z)",
        text,
        re.MULTILINE | re.DOTALL,
    )
    if outcome_match:
        outcome = outcome_match.group("body").lower()
        if not any(token in outcome for token in ("chosen option", "rejected", "deferred")):
            findings.append(
                Finding(
                    "ERROR",
                    path,
                    "Decision Outcome must record a chosen, rejected, or deferred result",
                ),
            )

    status_match = STATUS_RE.search(text)
    if status_match:
        status = status_match.group(1).strip().strip('"').split()[0].lower()
        if status not in KNOWN_STATUSES and "superseded" not in status:
            findings.append(Finding("WARN", path, f"unusual status value: {status_match.group(1)}"))

    if PLACEHOLDER_RE.search(text):
        findings.append(Finding("WARN", path, "record still contains placeholders"))

    return findings


def build_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Check MADR-style Markdown Architecture Decision Records.",
    )
    parser.add_argument("path", nargs="?", default="docs/decisions")
    parser.add_argument("--strict", action="store_true", help="Treat warnings as failures")
    return parser


def main(argv: list[str] | None = None) -> int:
    args = build_parser().parse_args(argv)
    paths = iter_markdown_targets(Path(args.path))
    findings = [finding for path in paths for finding in lint_file(path)]

    for finding in findings:
        print(f"{finding.level}: {finding.path}: {finding.message}")

    errors = [f for f in findings if f.level == "ERROR"]
    warnings = [f for f in findings if f.level == "WARN"]
    if errors or (args.strict and warnings):
        return 1
    print(f"Checked {len(paths)} ADR file(s); no blocking issues.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
