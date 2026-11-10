#!/usr/bin/env python3
"""Verify every @agent-name reference in commands/skills/docs resolves to a real
agent or skill.

Scans .md prose (skipping fenced code blocks) for @kebab-case-name tokens and
checks each against the union of agent and skill names. Tokens that match a
denylist (placeholders, author handles, doc keywords) are ignored.

A baseline file (validation/known-unresolved-refs.txt) snapshots refs that are
currently broken — typically aspirational agent names in orchestration command
docs. CI fails only if a NEW unresolved ref appears, so this surfaces drift
without blocking on the existing cleanup backlog.
"""
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
SUBAGENTS = REPO_ROOT / "subagents"
SKILLS = REPO_ROOT / "skills"
BASELINE_FILE = REPO_ROOT / "validation" / "known-unresolved-refs.txt"

SCAN_ROOTS = [REPO_ROOT / "commands", REPO_ROOT / "skills"]
SCAN_FILES = [REPO_ROOT / "CLAUDE.md", REPO_ROOT / "README.md", REPO_ROOT / "NAVIGATION.md"]

# Tokens that look like @agent but aren't:
# - generic placeholders used in examples ("@agent-name", "@your-agent")
# - GitHub author handles ("@alirezarezvani")
# - doc/jsdoc/code keywords ("@param", "@returns")
# - test-framework or library tokens ("@jest", "@types")
DENYLIST = {
    "agent", "agent-name", "agents", "your-agent", "any-agent",
    "alirezarezvani", "anthropic", "anthropic-ai", "claude", "me", "you",
    "v1", "v2", "v3", "latest",
    "param", "returns", "throws", "author", "deprecated", "example",
    "see", "todo", "types", "import", "export",
    "given", "when", "then", "factory", "jest", "pytest",
    "app", "the",
}

# Match @kebab-name that is NOT a path (@src/foo) or filename (@package.json)
REF_RE = re.compile(r"(?<![\w/.])@([a-z][a-z0-9-]{2,})(?![\w./-])")


def collect_known() -> set[str]:
    names: set[str] = set()
    for agent_md in SUBAGENTS.rglob("agent.md"):
        names.add(agent_md.parent.name)
    for skill_md in SKILLS.rglob("SKILL.md"):
        names.add(skill_md.parent.name)
    return names


def iter_scan_files() -> list[Path]:
    files: list[Path] = []
    for root in SCAN_ROOTS:
        if root.exists():
            files.extend(p for p in root.rglob("*.md"))
    files.extend(p for p in SCAN_FILES if p.exists())
    return files


def find_unresolved(known: set[str]) -> dict[str, list[str]]:
    missing: dict[str, list[str]] = {}
    for path in iter_scan_files():
        try:
            text = path.read_text(encoding="utf-8")
        except UnicodeDecodeError:
            continue
        rel = path.relative_to(REPO_ROOT).as_posix()
        in_code = False
        for line_no, line in enumerate(text.splitlines(), start=1):
            stripped = line.lstrip()
            if stripped.startswith("```"):
                in_code = not in_code
                continue
            if in_code:
                continue
            for match in REF_RE.finditer(line):
                name = match.group(1)
                if name in DENYLIST or name in known:
                    continue
                missing.setdefault(name, []).append(f"{rel}:{line_no}")
    return missing


def load_baseline() -> set[str]:
    if not BASELINE_FILE.exists():
        return set()
    return {
        line.strip()
        for line in BASELINE_FILE.read_text(encoding="utf-8").splitlines()
        if line.strip() and not line.startswith("#")
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--update-baseline",
        action="store_true",
        help="Rewrite the baseline file with the current set of unresolved refs.",
    )
    parser.add_argument(
        "--strict",
        action="store_true",
        help="Fail on any unresolved reference, ignoring the baseline.",
    )
    args = parser.parse_args()

    known = collect_known()
    if not known:
        print("::error::no agents or skills found under subagents/ or skills/")
        return 1

    missing = find_unresolved(known)

    if args.update_baseline:
        names = sorted(missing)
        BASELINE_FILE.parent.mkdir(parents=True, exist_ok=True)
        BASELINE_FILE.write_text(
            "# Agent/skill names referenced via @name in docs but not present.\n"
            "# Maintained by scripts/check_agent_references.py.\n"
            "# CI fails on any NEW name not in this list.\n"
            + "\n".join(names) + ("\n" if names else ""),
            encoding="utf-8",
        )
        print(f"baseline updated: {len(names)} unresolved name(s)")
        return 0

    baseline = set() if args.strict else load_baseline()
    new_breakage = {n: refs for n, refs in missing.items() if n not in baseline}
    fixed_in_baseline = baseline - set(missing)

    if not new_breakage and not fixed_in_baseline:
        total = sum(len(r) for r in missing.values())
        print(
            f"agent references: scanned against {len(known)} known names, "
            f"{len(missing)} baselined unresolved name(s) covering {total} refs"
        )
        return 0

    for name, refs in sorted(new_breakage.items()):
        for ref in refs[:5]:
            file, line = ref.split(":", 1)
            print(f"::error file={file},line={line}::@{name}: no agent or skill "
                  f"with this name (not in baseline)")
        if len(refs) > 5:
            print(f"  (and {len(refs) - 5} more references to @{name})")

    if fixed_in_baseline:
        print(
            f"::notice::{len(fixed_in_baseline)} baselined name(s) now resolve. "
            f"Run with --update-baseline to refresh: "
            + ", ".join(sorted(fixed_in_baseline))
        )

    return 1 if new_breakage else 0


if __name__ == "__main__":
    sys.exit(main())
