#!/usr/bin/env python3
"""Validate YAML frontmatter in skills, agents, and commands against JSON schemas.

Usage:
    python3 scripts/validate_frontmatter.py [skills|agents|commands|all]
"""
from __future__ import annotations

import datetime as dt
import json
import sys
from pathlib import Path
from typing import Any, Iterator

import yaml
from jsonschema import Draft202012Validator

REPO_ROOT = Path(__file__).resolve().parent.parent
SCHEMA_DIR = REPO_ROOT / "validation" / "schemas"

TARGETS = {
    "skills": {
        "schema": SCHEMA_DIR / "skill.schema.json",
        "root": REPO_ROOT / "skills",
        "match": lambda p: p.name == "SKILL.md",
        "name_from": lambda p: p.parent.name,
    },
    "agents": {
        "schema": SCHEMA_DIR / "agent.schema.json",
        "root": REPO_ROOT / "subagents",
        "match": lambda p: p.name == "agent.md",
        "name_from": lambda p: p.parent.name,
    },
    "commands": {
        "schema": SCHEMA_DIR / "command.schema.json",
        "root": REPO_ROOT / "commands",
        "match": lambda p: p.suffix == ".md" and p.name != "README.md",
        "name_from": lambda p: p.stem,
    },
}


def _coerce(value: Any) -> Any:
    """Convert YAML-native dates to ISO strings so JSON Schema can validate them."""
    if isinstance(value, (dt.date, dt.datetime)):
        return value.isoformat()
    if isinstance(value, dict):
        return {k: _coerce(v) for k, v in value.items()}
    if isinstance(value, list):
        return [_coerce(v) for v in value]
    return value


def extract_frontmatter(path: Path) -> dict | None:
    text = path.read_text(encoding="utf-8")
    if not text.startswith("---\n"):
        return None
    end = text.find("\n---", 4)
    if end == -1:
        return None
    block = text[4:end]
    try:
        data = yaml.safe_load(block) or {}
    except yaml.YAMLError as exc:
        raise ValueError(f"YAML parse error: {exc}") from exc
    return _coerce(data)


def find_files(target: str) -> Iterator[Path]:
    cfg = TARGETS[target]
    for path in cfg["root"].rglob("*.md"):
        if cfg["match"](path):
            yield path


def validate_target(target: str) -> int:
    cfg = TARGETS[target]
    schema = json.loads(cfg["schema"].read_text(encoding="utf-8"))
    validator = Draft202012Validator(schema)

    files = list(find_files(target))
    if not files:
        print(f"::error::no {target} files found under {cfg['root']}")
        return 1

    errors = 0
    for path in files:
        rel = path.relative_to(REPO_ROOT)
        try:
            data = extract_frontmatter(path)
        except ValueError as exc:
            print(f"::error file={rel}::{exc}")
            errors += 1
            continue
        if data is None:
            print(f"::error file={rel}::missing YAML frontmatter")
            errors += 1
            continue

        schema_errors = sorted(validator.iter_errors(data), key=lambda e: e.path)
        if schema_errors:
            for err in schema_errors:
                loc = ".".join(str(p) for p in err.path) or "(root)"
                print(f"::error file={rel}::{loc}: {err.message}")
            errors += len(schema_errors)
            continue

        # Name-vs-directory consistency check
        declared = data.get("name")
        expected = cfg["name_from"](path)
        if declared and declared != expected:
            print(
                f"::error file={rel}::name '{declared}' does not match "
                f"directory/file '{expected}'"
            )
            errors += 1

    print(f"{target}: validated {len(files)} files, {errors} errors")
    return 1 if errors else 0


def main() -> int:
    target = sys.argv[1] if len(sys.argv) > 1 else "all"
    if target == "all":
        return max(validate_target(t) for t in TARGETS)
    if target not in TARGETS:
        print(f"unknown target '{target}'. choose: {', '.join(TARGETS)}, all")
        return 2
    return validate_target(target)


if __name__ == "__main__":
    sys.exit(main())
