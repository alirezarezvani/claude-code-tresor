# Claude Code Tresor v2.8.0 - Reliable Installation

**Released:** November 10, 2026

This release makes the installer deliver exactly what the documentation describes. It also brings everything from v2.7.0, which was merged in December 2025 but never published as a release here.

## How to get it

New installation:

```bash
git clone https://github.com/alirezarezvani/claude-code-tresor.git
cd claude-code-tresor
./scripts/install.sh
```

Already installed (any earlier version):

```bash
cd claude-code-tresor
git pull origin main
./scripts/install.sh
```

That is all. The installer cleans up what older versions left behind.

## What was wrong, and is fixed now

| Problem | Now |
|---|---|
| `/scaffold`, `/test-gen` and `/docs-gen` were not installed at all | All 19 commands are installed |
| Commands appeared under long names such as `/workflow-review:review` | Commands have the documented names: `/review`, `/audit`, `/scaffold`, ... |
| Every command folder added a useless `README` command | Only real commands are installed |
| Installing or updating twice created duplicate copies of commands, skills and agents | Running the scripts again is safe |
| `update.sh` removed your own commands and agents from `~/.claude/` | Only Tresor's own files are replaced |
| `update.sh` did not update skills, and `--rollback` never worked | Both work |
| `--skills`, `--agents` and `--commands` were rejected, although guides used them | Accepted, next to the `--*-only` spellings |
| Some commands did not load in GitHub Copilot CLI 1.0.65 and newer ([#60](https://github.com/alirezarezvani/claude-code-tresor/issues/60)) | Fixed |

## What you should know when upgrading

- **Command names:** if you typed the long names (`/workflow-review:review`), use the short ones (`/review`).
- **Your own files:** if you have a personal command with the same name as a Tresor command, the installer keeps your version next to it as `<name>.md.bak`.
- **Old workflow command names** (`/create-prompt`, `/run-prompt`, `/add-to-todos`, `/check-todos`, `/whats-next`) still work. They will be removed in v3.0.0. The current names are `/prompt-create`, `/prompt-run`, `/todo-add`, `/todo-check` and `/handoff-create`.

## New since v2.6.0 (from v2.7.0)

If your last version was v2.6.0, you also get:

- **10 orchestration commands**: `/audit`, `/vulnerability-scan`, `/compliance-check`, `/profile`, `/benchmark`, `/deploy-validate`, `/health-check`, `/incident-response`, `/code-health`, `/debt-analysis`
- **Tresor Workflow Framework**: `/prompt-create`, `/prompt-run`, `/todo-add`, `/todo-check`, `/handoff-create`
- **One place for all 133 agents**: the `subagents/` folder

Details: [RELEASE-NOTES-v2.7.0.md](https://github.com/alirezarezvani/claude-code-tresor/blob/main/RELEASE-NOTES-v2.7.0.md)

## For contributors

- Every pull request is now checked automatically: file headers, `@agent` mentions, counts in the docs, shell scripts, internal links, and a full test run of the installer.
- Pull requests go to the `dev` branch. See [the Git workflow guide](https://github.com/alirezarezvani/claude-code-tresor/blob/main/documentation/workflows/git-workflow.md).
- `CLAUDE.md` was rewritten and now matches the repository.

## Thank you

- @dajiaohuang for correcting the install documentation ([#62](https://github.com/alirezarezvani/claude-code-tresor/pull/62))
- @thejesh23 for reporting and fixing the `argument-hint` problem ([#60](https://github.com/alirezarezvani/claude-code-tresor/issues/60), [#61](https://github.com/alirezarezvani/claude-code-tresor/pull/61))
- @jpDxsolo for reporting the mismatch between documented and installed command names ([#54](https://github.com/alirezarezvani/claude-code-tresor/issues/54))
- @D-EFFCON for asking where v2.7 was ([#56](https://github.com/alirezarezvani/claude-code-tresor/issues/56))

**Full list of changes:** [CHANGELOG.md](https://github.com/alirezarezvani/claude-code-tresor/blob/main/CHANGELOG.md)
