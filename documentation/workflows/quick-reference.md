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

CI runs the `Validate` job. Merge once green.

## Cut a release

1. **Wait for the release-please PR on `dev`** (auto-opened/updated after every merge). It's titled `chore(dev): release X.Y.Z`. Merge it.
2. **Open a `dev → main` PR**:
   ```bash
   gh pr create --base main --head dev --title "chore(release): vX.Y.Z"
   ```
3. **Merge it.** `release-tag.yml` runs on main, creates the tag, and drafts a GitHub Release.

`main` only ever receives merges from `dev` — enforced by `main-branch-guard.yml`.

## On-demand AI

In any PR or issue, comment `@claude review this for security` (or any prompt). Handled by `claude.yml`.

## Emergency stop

```bash
# .github/WORKFLOW_KILLSWITCH
STATUS: DISABLED
```

Disables CI, release-please, and release-tag workflows.
