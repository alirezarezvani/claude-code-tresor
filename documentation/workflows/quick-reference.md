# Quick Reference — Git Workflow

**Strategy**: Git Flow — feature → `dev` → `main`

## Start a feature branch

```bash
git checkout dev && git pull
git checkout -b feat/your-feature
```

Allowed prefixes: `feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `build`, `ci`, `perf`, `style`, `hotfix`, `release`, `claude`, `dependabot`, `renovate`.

## Commit (Conventional Commits)

```bash
git commit -m "feat(skills): add code-coverage skill"
```

| Type            | Version bump |
| --------------- | ------------ |
| `fix:`          | patch        |
| `feat:`         | minor        |
| `feat!:` or `BREAKING CHANGE:` in body | major |
| `docs:`, `chore:`, `test:`, `ci:`, `refactor:`, `perf:`, `build:`, `style:` | none |

## Open the feature PR (against `dev`)

```bash
git push -u origin feat/your-feature
gh pr create --base dev --title "feat: your feature"
```

CI runs the `Validate` job and merges the PR automatically once it is green (owner and bot PRs only). Drafts merge after "Ready for review" or with the label `automerge`. Add the label `hold` to stop an automatic merge.

## Releases

Nothing to do. After each merge into `dev`, release-please updates the PR `chore(dev): release X.Y.Z`; it is merged automatically, then `release.yml` tags the version, publishes the GitHub release and moves `main` to it.

To review releases before they go out, set the repository variable `AUTO_RELEASE` to `false` and merge the release PR yourself.

## On-demand AI

In any PR or issue, comment `@claude review this for security` (or any prompt). Handled by `claude.yml`.

## Emergency stop

```bash
# .github/WORKFLOW_KILLSWITCH
STATUS: DISABLED
```

Stops automatic merges and releases. CI checks keep running.
