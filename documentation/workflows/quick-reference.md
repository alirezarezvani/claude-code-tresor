# Quick Reference — Git Workflow

**Strategy**: Trunk-based (PRs → `main`)

## Start a branch

```bash
git checkout main && git pull
git checkout -b feat/your-feature
```

Allowed prefixes: `feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `build`, `ci`, `perf`, `style`, `hotfix`, `release`, `claude`, `dependabot`, `renovate`.

## Commit (Conventional Commits)

```bash
git commit -m "feat(skills): add code-coverage skill"
```

Types and what they do to the release:

| Type            | Version bump |
| --------------- | ------------ |
| `fix:`          | patch        |
| `feat:`         | minor        |
| `feat!:` or `BREAKING CHANGE:` in body | major |
| `docs:`, `chore:`, `test:`, `ci:`, `refactor:`, `perf:`, `build:`, `style:` | none |

## Open the PR

```bash
git push -u origin feat/your-feature
gh pr create --base main --title "feat: your feature"
```

CI runs automatically. Merge once green.

## Releases

Automated by release-please. After merging to `main`, look for the open PR titled `chore(main): release X.Y.Z`. Merge it to cut the tag.

## On-demand AI review

In any PR or issue, comment `@claude review this for security` (or any prompt). The `claude.yml` workflow picks it up.

## Emergency stop

```bash
# .github/WORKFLOW_KILLSWITCH
STATUS: DISABLED
```

Disables CI and release workflows until reverted.
