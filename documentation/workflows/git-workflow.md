# Branching Strategy

**Workflow**: Git Flow — feature → `dev` → `main`

## Overview

Claude Code Tresor uses two long-lived branches:

- **`main`** — production. Only ever receives merges from `dev`.
- **`dev`** — integration. All feature work targets `dev`.

All other branches are short-lived feature/fix branches. Every PR opens against `dev`. When `dev` is ready to ship, a single `dev → main` PR carries the changes into production.

## Branch naming

CI enforces this pattern on feature branches:

```
^(feat|fix|docs|chore|refactor|test|build|ci|perf|style|hotfix|release|claude|dependabot|renovate)/[a-z0-9][a-z0-9._/-]*$
```

Examples: `feat/orchestration-rollback`, `fix/install-backup-recursion`, `ci/trunk-based-cleanup`, `claude/<auto-slug>`, `dependabot/...`.

Release PRs (`dev → main`) bypass branch-name validation because the head branch is literally `dev`.

## Commit messages

[Conventional Commits](https://www.conventionalcommits.org/) on feature PRs. release-please uses these to decide version bumps:

| Type           | Bump  | Example                                            |
| -------------- | ----- | -------------------------------------------------- |
| `fix:`         | patch | `fix: stop install.sh from recursing into backup`  |
| `feat:`        | minor | `feat: add code-health command`                    |
| `feat!:` / `BREAKING CHANGE:` | major | `feat!: rename core agents`           |
| `docs:` / `chore:` / `test:` / `ci:` / `refactor:` | none | n/a |

Release PRs are squash-merged with a single clean title; commitlint is skipped for them.

## Feature workflow

```bash
# 1. Branch from dev
git checkout dev && git pull
git checkout -b feat/my-thing

# 2. Commit (conventional)
git commit -m "feat(skills): add code-coverage skill"

# 3. Push and open PR against dev
git push -u origin feat/my-thing
gh pr create --base dev
```

CI runs the `Validate` job on every PR: branch name, commit messages, frontmatter schemas, cross-references, doc-count drift, shellcheck, install smoke test, internal markdown links.

Merge once green.

## Release workflow

Two automated stages.

**Stage 1 — version bump on `dev`** (handled by `release-please.yml`):

After every merge into `dev`, release-please opens or updates a single PR titled `chore(dev): release X.Y.Z`. The PR contains:

- The next version (calculated from conventional-commit history)
- A CHANGELOG.md entry
- An updated `version.txt` and `.release-please-manifest.json`

Merge that PR when you're ready to cut a version. `dev` now has the bumped version committed but no tag yet.

**Stage 2 — tag on `main`** (handled by `release-tag.yml`):

Open a release PR: `dev → main`. The `Main Branch Protection Guard` workflow enforces that the head branch is literally `dev`. Once that PR merges:

- `release-tag.yml` reads `version.txt`, creates an annotated tag `vX.Y.Z`, and drafts a GitHub Release with auto-generated notes.
- Idempotent — re-runs are safe.

## On-demand AI

In any PR or issue, comment `@claude review this for security` (or any prompt). The `claude.yml` workflow picks it up. There is no per-PR auto-review — keeps Claude API spend explicit.

## Emergency stop

Set `.github/WORKFLOW_KILLSWITCH` to:

```
STATUS: DISABLED
```

All workflows that consult this file (`ci.yml`, `release-please.yml`, `release-tag.yml`) short-circuit until you flip it back.

## See also

- [Conventional Commits](https://www.conventionalcommits.org/)
- [release-please](https://github.com/googleapis/release-please)
