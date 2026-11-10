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

The release PR that release-please opens (`release-please--branches--dev--...`) is also allowed.

## Commit messages

[Conventional Commits](https://www.conventionalcommits.org/) on feature PRs. release-please uses these to decide version bumps:

| Type           | Bump  | Example                                            |
| -------------- | ----- | -------------------------------------------------- |
| `fix:`         | patch | `fix: stop install.sh from recursing into backup`  |
| `feat:`        | minor | `feat: add code-health command`                    |
| `feat!:` / `BREAKING CHANGE:` | major | `feat!: rename core agents`           |
| `docs:` / `chore:` / `test:` / `ci:` / `refactor:` | none | n/a |

commitlint is skipped for Dependabot PRs and for `dev → main` PRs, whose commits were already checked on the way into `dev`.

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

The `automerge` job then merges the PR into `dev`. Rules (in `.github/scripts/automerge.sh`):

| Pull request | Merged automatically? |
| --- | --- |
| From the repository owner, `github-actions[bot]` or `dependabot[bot]` | Yes, once CI passes |
| Draft | Only after "Ready for review", or with the label `automerge` |
| Label `hold` | Never |
| From anyone else, or from a fork | No, a maintainer merges it |
| release-please release PR | Yes, unless the repository variable `AUTO_RELEASE` is `false` |

## Release workflow

Fully automated by `release.yml`, which runs on every push to `dev`:

1. **Validate**: runs the whole of `ci.yml` on the pushed commit.
2. **Release**:
   - If `version.txt` holds a version that has no tag yet (a version raised by hand), it publishes `v<version>` right away. The text comes from `RELEASE-NOTES-v<version>.md` when that file exists, otherwise from generated notes.
   - release-please opens or updates one PR titled `chore(dev): release X.Y.Z` with the next version (from the conventional commits), the `CHANGELOG.md` entry, and updated `version.txt` and `.release-please-manifest.json`. Once that PR is merged, release-please tags `vX.Y.Z` and publishes the GitHub release.
3. **Promote**: fast-forwards `main` to the released commit. `main` therefore always equals the latest release, and there are no merge commits to bring back into `dev`. If `main` ever has commits that `dev` lacks, the job opens a `dev → main` PR and fails so someone resolves it.

The workflows need a repository secret `RELEASE_PAT` (a fine-grained token for this repository with read and write access to Contents, Pull requests and Workflows). Without it, merges and release PRs made by the default token do not start the next workflow, and pushing workflow changes to `main` is refused.

## On-demand AI

In any PR or issue, comment `@claude review this for security` (or any prompt). The `claude.yml` workflow picks it up. There is no per-PR auto-review — keeps Claude API spend explicit.

## Emergency stop

Set `.github/WORKFLOW_KILLSWITCH` to:

```
STATUS: DISABLED
```

Automatic merges (`ci.yml`) and releases (`release.yml`) stop until you flip it back. CI checks keep running.

## See also

- [Conventional Commits](https://www.conventionalcommits.org/)
- [release-please](https://github.com/googleapis/release-please)
