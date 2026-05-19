#!/usr/bin/env python3
"""Verify advertised counts of skills/agents/commands in docs match reality.

Reads a small manifest of (file, regex, expected-count-source) tuples and
fails if any documented count drifts from the live count.
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent


def count_skills() -> int:
    return sum(1 for _ in (REPO_ROOT / "skills").rglob("SKILL.md"))


def count_agents() -> int:
    return sum(1 for _ in (REPO_ROOT / "subagents").rglob("agent.md"))


def count_core_agents() -> int:
    return sum(
        1
        for p in (REPO_ROOT / "subagents" / "core").iterdir()
        if p.is_dir() and (p / "agent.md").exists()
    )


def count_command_files() -> int:
    return sum(
        1
        for p in (REPO_ROOT / "commands").rglob("*.md")
        if p.name != "README.md"
    )


COUNTERS = {
    "skills": count_skills,
    "agents": count_agents,
    "core-agents": count_core_agents,
    "command-files": count_command_files,
}

# (doc_path, kind, regex with one numeric capture group, description)
# Regex must capture exactly one integer. The pattern should be narrow enough
# to avoid matching unrelated numbers in the same doc.
CHECKS: list[tuple[str, str, str, str]] = [
    ("CLAUDE.md", "skills", r"\*\*(\d+)\s+Autonomous\s+Skills\*\*", "Skills count"),
    ("CLAUDE.md", "core-agents", r"\*\*(\d+)\s+Core\s+Agents\*\*", "Core agents count"),
    ("CLAUDE.md", "agents",
        r"\*\*(\d+)\s+Extended\s+Agents\*\*", "Extended agents count"),
    ("README.md", "skills", r"(\d+)\s+Autonomous\s+Skills", "README skills count"),
    ("README.md", "core-agents", r"#\s*(\d+)\s+Specialized\s+Agents",
     "README specialized agents count"),
]


def main() -> int:
    errors = 0
    print(f"Live counts: " + ", ".join(f"{k}={v()}" for k, v in COUNTERS.items()))
    for doc, kind, pattern, label in CHECKS:
        path = REPO_ROOT / doc
        if not path.exists():
            print(f"::warning::{doc} not found, skipping '{label}'")
            continue
        if kind not in COUNTERS:
            print(f"::error::unknown counter '{kind}' in check '{label}'")
            errors += 1
            continue
        text = path.read_text(encoding="utf-8")
        matches = re.findall(pattern, text)
        if not matches:
            print(f"::warning file={doc}::no match for '{label}' "
                  f"(pattern: {pattern!r}); update the regex if the doc was reworded")
            continue
        actual = COUNTERS[kind]()
        # Use the first match — docs may quote the count multiple times but the
        # first occurrence is the canonical one in our docs.
        documented = int(matches[0])
        if documented != actual:
            print(f"::error file={doc}::{label}: doc says {documented}, "
                  f"actual is {actual}")
            errors += 1
        else:
            print(f"  ✓ {doc}: {label} = {actual}")

    print(f"doc counts: {errors} drift(s)")
    return 1 if errors else 0


if __name__ == "__main__":
    sys.exit(main())
