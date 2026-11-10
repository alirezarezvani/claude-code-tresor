#!/usr/bin/env python3
"""Generate .claude-plugin/marketplace.json and each plugin's plugin.json from the repository layout.

Each plugin is an existing folder with a generated .claude-plugin/plugin.json
that lists its files, so nothing moves and install.sh keeps working:

- tresor-core: the 8 core agents (subagents/core); installing it also installs
  tresor-skills and tresor-commands
- tresor-skills: the 8 skills (skills/)
- tresor-commands: the 19 slash commands (commands/), without the 5 old names
- tresor-<team>: one plugin per agent team under subagents/

A plugin can't use the repository root as its source: Claude Code then also
loads the root agents/ and commands/ folders into every plugin.

Plugin names prefix every component (tresor-operations:customer-support), so
agents that share a name across teams no longer collide.

Usage:
    python3 scripts/build_marketplace.py          # write the file
    python3 scripts/build_marketplace.py --check  # exit 1 if it is out of date
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parent.parent
OUTPUT = REPO_ROOT / ".claude-plugin" / "marketplace.json"
VERSION = (REPO_ROOT / "version.txt").read_text(encoding="utf-8").strip()

# Old command names kept by install.sh for backward compatibility. The plugin
# ships only the current names.
LEGACY_COMMANDS = {"create-prompt", "add-to-todos", "check-todos", "run-prompt", "whats-next"}

TEAM_DESCRIPTIONS = {
    "engineering": "Engineering specialists: languages, backend, frontend, mobile, DevOps, testing and data",
    "design": "Design specialists: UI, UX research, brand and visual storytelling",
    "marketing": "Marketing specialists: content, growth, SEO and social media",
    "product": "Product specialists: product management, requirements and research",
    "leadership": "Leadership specialists: strategy, finance, risk and compliance",
    "operations": "Operations specialists: analytics, infrastructure and support",
    "research": "Research specialists: deep research, market and competitive intelligence",
    "ai-automation": "AI and automation specialists: AI engineering, ML, prompts and workflow automation",
    "account-customer-success": "Account and customer success specialists: sales, success and support",
}


def rel(path: Path, root: Path) -> str:
    return "./" + path.relative_to(root).as_posix()


def agent_files(team: str) -> list[str]:
    root = REPO_ROOT / "subagents" / team
    return sorted(rel(p, root) for p in root.rglob("agent.md"))


def command_files() -> list[str]:
    root = REPO_ROOT / "commands"
    return sorted(rel(p, root) for p in root.rglob("*.md")
                  if p.name != "README.md" and p.stem not in LEGACY_COMMANDS)


def skill_dirs() -> list[str]:
    root = REPO_ROOT / "skills"
    return sorted(rel(p, root) + "/" for p in root.iterdir()
                  if p.is_dir() and any(p.glob("*/SKILL.md")))


def plugin(name: str, source: str, description: str, **components) -> dict:
    """One plugin: its plugin.json (written into the source folder) and its marketplace entry."""
    manifest = {
        "name": name,
        "version": VERSION,
        "description": description,
        "author": {"name": "Alireza Rezvani"},
        "homepage": "https://github.com/alirezarezvani/claude-code-tresor",
        "license": "MIT",
        **components,
    }
    entry = {"name": name, "source": source, "description": description, "category": "development"}
    return {"path": REPO_ROOT / source / ".claude-plugin" / "plugin.json", "manifest": manifest, "entry": entry}


def plugins() -> list[dict]:
    result = [
        plugin("tresor-core", "./subagents/core",
               "The 8 core agents for architecture, review, security, testing, performance and docs. "
               "Also installs tresor-skills and tresor-commands",
               agents=agent_files("core"), dependencies=["tresor-skills", "tresor-commands"]),
        plugin("tresor-skills", "./skills",
               "8 skills Claude uses on its own: code review, tests, commit messages, security and docs",
               skills=skill_dirs()),
        plugin("tresor-commands", "./commands",
               "19 slash commands: scaffolding, review, test and docs generation, audits, profiling and operations",
               commands=command_files()),
    ]
    for team, description in TEAM_DESCRIPTIONS.items():
        result.append(plugin(f"tresor-{team}", f"./subagents/{team}", description,
                             agents=agent_files(team)))
    return result


def outputs() -> dict[Path, str]:
    """Every generated file and its content."""
    items = plugins()
    marketplace = {
        "$schema": "https://json.schemastore.org/claude-code-marketplace.json",
        "name": "tresor",
        "description": "Claude Code Tresor: agents, skills and commands for professional development",
        "owner": {"name": "Alireza Rezvani", "url": "https://github.com/alirezarezvani"},
        "metadata": {"version": VERSION},
        "plugins": [item["entry"] for item in items],
    }
    files = {OUTPUT: marketplace}
    files.update({item["path"]: item["manifest"] for item in items})
    return {path: json.dumps(data, indent=2) + "\n" for path, data in files.items()}


def main() -> int:
    files = outputs()
    if "--check" in sys.argv:
        stale = [p for p, c in files.items()
                 if not p.exists() or p.read_text(encoding="utf-8") != c]
        for path in stale:
            print(f"{path.relative_to(REPO_ROOT)} is out of date; run scripts/build_marketplace.py")
        if not stale:
            print(f"marketplace.json and {len(files) - 1} plugin.json files are up to date")
        return 1 if stale else 0
    for path, content in files.items():
        path.parent.mkdir(exist_ok=True)
        path.write_text(content, encoding="utf-8")
        print(f"wrote {path.relative_to(REPO_ROOT)}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
