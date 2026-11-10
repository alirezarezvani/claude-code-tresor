# CLAUDE.md - Development Guide

> For Claude Code instances working in the Claude Code Tresor repository.

**Author**: Alireza Rezvani | **License**: MIT | **Version**: 2.8.0 | **Updated**: November 10, 2026

## What this repository is

Claude Code Tresor is a collection of ready-to-use utilities for Claude Code. It ships content (Markdown files) plus two shell scripts that copy that content into a user's `~/.claude/` folder. There is no application code and no build step.

What it contains:

- **8 Autonomous Skills** - background helpers Claude picks up on its own
- **8 Core Agents** - the main expert agents, installed and ready to use
- **133 Agents** in total - the 8 core agents plus 125 specialized agents, organized by team
- **19 Slash Commands** - 4 development, 5 workflow, 10 orchestration
- Prompt templates, development standards, and example workflows

## Repository layout

```
claude-code-tresor/
├── skills/                  # 8 skills: <category>/<skill-name>/SKILL.md
│   ├── development/         # code-reviewer, test-generator, git-commit-helper
│   ├── security/            # security-auditor, secret-scanner, dependency-auditor
│   └── documentation/       # api-documenter, readme-updater
├── subagents/               # 133 agents: <team>/.../<agent-name>/agent.md
│   ├── core/                # the 8 core agents (source of truth)
│   └── <team>/              # engineering, design, marketing, product, leadership,
│                            # operations, research, ai-automation, account-customer-success
├── agents/                  # old location of the core agents, kept so old links work
├── commands/                # 19 slash commands + 5 old command names
│   ├── development/         # scaffold
│   ├── testing/             # test-gen
│   ├── documentation/       # docs-gen
│   ├── workflow/            # review, prompt-create, prompt-run, todo-add,
│   │                        # todo-check, handoff-create (+ 5 old names)
│   ├── security/            # audit, vulnerability-scan, compliance-check
│   ├── performance/         # profile, benchmark
│   ├── operations/          # deploy-validate, health-check, incident-response
│   └── quality/             # code-health, debt-analysis
├── prompts/                 # prompt templates
├── standards/               # style guides, Git workflows, templates
├── examples/                # example workflows and case studies
├── documentation/           # user guides, reference, workflows
├── scripts/                 # install.sh, update.sh and the validation scripts
├── validation/              # JSON schemas and the list of known unresolved references
├── version.txt              # the release version (single source of truth)
└── CHANGELOG.md             # release history
```

Edit core agents in `subagents/core/`. The files in `agents/` are the old location: `agents/<name>/agent.md` points to `subagents/core/` automatically, but `agents/<name>.md` is a separate copy that is not installed.

## The three building blocks

| | Skills | Agents | Commands |
|---|---|---|---|
| **Started by** | Claude, automatically | The user, with `@agent-name` | The user, with `/command-name` |
| **File** | `SKILL.md` | `agent.md` | `<command-name>.md` |
| **Best for** | Quick checks | Deep analysis | Multi-step workflows |

The 8 core agents are: @systems-architect, @config-safety-reviewer, @root-cause-analyzer, @security-auditor, @test-engineer, @performance-tuner, @refactor-expert, @docs-writer.

### File formats

Each file starts with a YAML header between two `---` lines. CI checks these headers against the schemas in `validation/schemas/`.

- **Skill** (`skills/<category>/<name>/SKILL.md`): `name`, `description`, `allowed-tools`. A `README.md` sits next to it.
- **Agent** (`subagents/<team>/.../<name>/agent.md`): `name`, `description`, `tools`, `model`, `enabled`, plus Tresor's own fields such as `category`, `team`, `color` and `capabilities`. The installer removes Tresor's own fields for the core agents, because Claude Code does not know them.
- **Command** (`commands/<category>/.../<name>.md`): `description`, `allowed-tools` and `model` are required. `argument-hint` must be wrapped in double quotes when it starts with `[`, otherwise other tools read it as a list instead of text.

The file name of a command is its name: `review.md` becomes `/review`. Do not rename command files without updating the docs.

### Old command names

Five workflow commands were renamed in v2.7.0. The old names are still shipped as copies and will be removed in v3.0.0:

| Old name | Current name |
|---|---|
| `/create-prompt` | `/prompt-create` |
| `/run-prompt` | `/prompt-run` |
| `/add-to-todos` | `/todo-add` |
| `/check-todos` | `/todo-check` |
| `/whats-next` | `/handoff-create` |

When you change one of these commands, apply the same change to its copy.

## Installation scripts

```bash
./scripts/install.sh                   # install everything (recommended)
./scripts/install.sh --skills-only     # the 8 skills
./scripts/install.sh --agents-only     # core agents + the agent library
./scripts/install.sh --commands-only   # all commands
./scripts/install.sh --orchestration   # only the 10 orchestration commands
./scripts/install.sh --resources-only  # prompts, standards, examples
./scripts/update.sh                    # pull the latest version and refresh
./scripts/update.sh --rollback         # restore the backup from the last update
```

Use one "only" option per run. They cannot be combined.

Where things end up:

| Content | Installed to | Notes |
|---|---|---|
| Skills | `~/.claude/skills/<name>/` | Category folder is removed |
| Core agents | `~/.claude/agents/<name>.md` | One file per agent |
| All 133 agents | `~/.claude/subagents/` | A library to browse. Claude Code does not load it. Users copy what they need into `~/.claude/agents/` |
| Commands | `~/.claude/commands/<name>.md` | One file per command, so the name is `/<name>` |
| Prompts, standards, examples | `~/.claude/tresor-resources/` | For reference |

Rules for changing the scripts:

- The installer downloads the repository from GitHub (`main`) into `~/.claude/tresor/` and installs from there, not from the local folder.
- Running a script twice must give the same result as running it once.
- Only replace Tresor's own files. Never delete a user's own commands, agents or skills.
- `install.sh` and `update.sh` contain the same copy logic. Change both.

## Checks to run before committing

CI runs these on every pull request. Run them locally first:

```bash
python3 scripts/validate_frontmatter.py all   # YAML headers of skills, agents, commands
python3 scripts/check_agent_references.py     # every @agent mention points to a real agent
python3 scripts/check_doc_counts.py           # counts in the docs match the files
bash scripts/smoke_install.sh                 # install, re-install, update and rollback
shellcheck --severity=error scripts/install.sh scripts/update.sh scripts/smoke_install.sh
```

If you add or remove a skill, agent or command, update the counts in this file and in `README.md`. CI also checks the links in `README.md`, `CLAUDE.md` and `NAVIGATION.md`.

## Git workflow and releases

Full description: [documentation/workflows/git-workflow.md](documentation/workflows/git-workflow.md).

- Two permanent branches: `main` (released) and `dev` (work in progress).
- Every change goes into `dev` through a pull request. Only `dev` may be merged into `main`. CI rejects any other pull request to `main`.
- Branch names must start with one of: `feat/`, `fix/`, `docs/`, `chore/`, `refactor/`, `test/`, `build/`, `ci/`, `perf/`, `style/`, `hotfix/`, `release/`, `claude/`.
- Commit messages follow Conventional Commits, for example `fix: stop installer from nesting folders`. CI checks this.

Releasing a version:

1. Set the new version in `version.txt` and `.release-please-manifest.json`, and add the entry to `CHANGELOG.md`. The `release-please` workflow is meant to prepare this as a pull request on `dev`.
2. Optionally add `RELEASE-NOTES-v<version>.md`. If the file exists, it becomes the text of the GitHub release.
3. Open a pull request from `dev` to `main` and merge it.
4. The `release-tag` workflow reads `version.txt`, creates the tag `v<version>` and publishes the GitHub release.
5. Merge `main` back into `dev`.

## Safety guidelines

1. **Installer changes**: test with `scripts/smoke_install.sh`. These scripts write into a user's home folder.
2. **Secrets**: never commit keys, tokens or passwords.
3. **Renames**: renaming a command, agent or skill breaks user habits and links. Keep the old name working for one major version and document it in `MIGRATION.md`.
4. **Counts and versions**: do not write numbers into docs that you have not checked against the files.

## Where to find more

- [README.md](README.md) - overview and the full command list
- [NAVIGATION.md](NAVIGATION.md) - where everything is
- [GETTING-STARTED.md](GETTING-STARTED.md) - first steps for users
- [documentation/README.md](documentation/README.md) - index of all guides
- [subagents/README.md](subagents/README.md) - the agent catalog
- [CONTRIBUTING.md](CONTRIBUTING.md) - how to contribute
- [MIGRATION.md](MIGRATION.md) - upgrade notes
- [GitHub Issues](https://github.com/alirezarezvani/claude-code-tresor/issues) - bugs and feature requests

## COMMUNICATION STANDARDS & BEHAVIOR

### Core Requirements:
- **Absolute Honesty**: Direct assessments without diplomatic cushioning
- **Zero Fluff**: Eliminate vague statements and buzzwords
- **Pragmatic Focus**: Every suggestion must be immediately actionable
- **Critical Analysis**: Challenge assumptions and identify flaws before responding
- **Always Ask for Clarification**: Never assume or fill gaps with generic advice

### Solution Standards:
- **Strict Adherence**: Follow user instructions exactly as specified
- **File Economy**: Edit existing files instead of creating new ones when possible
- **Code Limits**: Maximum 300 lines per file - split larger files into logical modules
- **Maintainability First**: Prioritize readable, maintainable code over technical complexity
- **Anti-Overengineering**: Choose simple, direct solutions over elaborate architectures

### Response Protocol:
1. **Pre-Response Check**: Verify answer is specific and actionable
2. **Critical Review**: Identify and address solution weaknesses
3. **Implementation Reality**: Confirm feasibility within stated constraints

### Documentation Requirements:
- **Bug Fix Records**: Document each bug and its solution methodology
- **Solution Rationale**: Explain why specific approach was chosen
- **Maintenance Notes**: Include future modification considerations

### Prohibited Responses:
- Generic praise without technical analysis
- Vague suggestions without clear reasoning
- Advice without implementation details
- Assumptions when requirements are unclear
- Over-engineered solutions for simple problems

### Standard Structure:
1. Direct assessment following user specifications
2. Critical analysis with potential issues
3. Step-by-step recommendations (edit vs. create approach)
4. Resource requirements and code organization
5. Documentation and maintenance considerations

---

**Remember**: This repository provides utilities TO users, not a development project itself. Focus on helping users implement, customize, and extend these utilities for their own projects. Provide brutally honest, technically sound guidance that prevents costly mistakes while maintaining code simplicity and readability. No technical jargon that is complicated for the user. Always use the current date, even when you create files or examples.
