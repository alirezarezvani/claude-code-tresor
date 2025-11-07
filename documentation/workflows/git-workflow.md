# Branching Strategy

**Date**: November 5, 2025
**Status**: Active
**Workflow**: Git Flow (dev → main)

---

## Overview

Claude Code Tresor uses a **Git Flow** branching strategy with two main branches:

- **`main`** - Production-ready code, released versions only
- **`dev`** - Integration branch, latest development changes

All feature work happens in feature branches that merge into `dev`. When `dev` is stable, we create a PR to merge into `main`.

---

## Branch Structure

```
main (protected)
└── dev (protected)
    ├── feat/new-feature
    ├── fix/bug-fix
    ├── docs/update-readme
    ├── chore/refactor-code
    └── test/add-tests
```

---

## Branch Types

| Prefix | Purpose | Example | Merges To |
|--------|---------|---------|-----------|
| `feat/` | New features | `feat/add-skills-layer` | `dev` |
| `fix/` | Bug fixes | `fix/issue-4-install-instructions` | `dev` |
| `docs/` | Documentation only | `docs/update-getting-started` | `dev` |
| `chore/` | Maintenance, refactoring | `chore/cleanup-deprecated-code` | `dev` |
| `test/` | Test additions | `test/add-e2e-tests` | `dev` |
| `ci/` | CI/CD changes | `ci/update-workflows` | `dev` |
| `perf/` | Performance improvements | `perf/optimize-install-script` | `dev` |
| `style/` | Code style, formatting | `style/eslint-cleanup` | `dev` |
| `refactor/` | Code refactoring | `refactor/modularize-agents` | `dev` |
| `revert/` | Revert previous commit | `revert/pr-123` | `dev` |
| `hotfix/` | Emergency production fix | `hotfix/critical-security-patch` | `main` (then backport to `dev`) |

---

## Workflow

### 1. Create Feature Branch from `dev`

```bash
# Make sure dev is up to date
git checkout dev
git pull origin dev

# Create feature branch
git checkout -b feat/your-feature-name

# Work on your feature
# ... make changes ...

git add .
git commit -m "feat: add your feature

Detailed description of what changed.

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
```

**Branch naming rules:**
- Use lowercase
- Use hyphens for spaces
- Be descriptive: `feat/add-oauth-login` ✅ not `feat/login` ❌
- Follow pattern: `<type>/<description>`

---

### 2. Push and Create PR to `dev`

```bash
# Push feature branch
git push -u origin feat/your-feature-name

# Create PR targeting dev
gh pr create --base dev --head feat/your-feature-name \
  --title "feat: add your feature" \
  --body "## Summary

Description of changes

## Testing
- [ ] Tested locally
- [ ] Workflows pass

## Related Issues
Closes #123"
```

**PR Requirements (enforced by branch protection):**
- ✅ All status checks must pass:
  - CI Quality Gate (YAML lint, schema validation, frontmatter)
  - Security Audit (OWASP Top 10)
- ✅ All conversations resolved
- ✅ PR approved (if approvals required)

---

### 3. Merge to `dev`

```bash
# Option 1: Via GitHub UI (recommended)
# - Review PR checks
# - Click "Squash and merge" or "Merge pull request"
# - Branch auto-deletes after merge

# Option 2: Via CLI
gh pr merge <PR-NUMBER> --squash --delete-branch
```

**After merge:**
- ✅ Feature branch automatically deleted (GitHub setting enabled)
- ✅ `dev` branch updated
- ✅ Workflows run on `dev` branch

---

### 4. Release to `main`

When `dev` is stable and ready for release:

```bash
# Make sure dev is up to date
git checkout dev
git pull origin dev

# Create PR from dev to main
gh pr create --base main --head dev \
  --title "chore(release): merge dev to main (vX.Y.Z)" \
  --body "## Release Summary

Merging stable dev changes to main for version X.Y.Z

### Changes Included
- feat: Feature A (#PR1)
- fix: Bug fix B (#PR2)
- docs: Documentation C (#PR3)

### Testing
- ✅ All CI checks passing
- ✅ Manual testing completed
- ✅ Security audit passed

### Changelog
See CHANGELOG.md for full details"
```

**Release PR Requirements:**
- ✅ All status checks pass (same as feature PRs)
- ✅ Manual review and approval recommended
- ✅ Changelog updated
- ✅ Version bumped (if applicable)

**After merging to main:**
```bash
# Tag the release
git checkout main
git pull origin main
git tag -a v1.2.3 -m "Release version 1.2.3"
git push origin v1.2.3

# Or use GitHub Release Orchestrator workflow
# (manual trigger from Actions tab)
```

---

## Special Cases

### Hotfix (Emergency Production Fix)

For critical bugs in production that can't wait for the normal cycle:

```bash
# Create hotfix branch from main
git checkout main
git pull origin main
git checkout -b hotfix/critical-security-patch

# Make the fix
# ... fix the issue ...

git add .
git commit -m "fix: critical security patch

Details of the security issue and fix.

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"

# Push and create PR to main
git push -u origin hotfix/critical-security-patch
gh pr create --base main --head hotfix/critical-security-patch \
  --title "[HOTFIX] fix: critical security patch" \
  --body "## Emergency Hotfix

Critical security vulnerability requiring immediate fix.

## Impact
High - affects all users

## Testing
- [x] Tested fix locally
- [x] Security audit passed"

# After merging to main, backport to dev
git checkout dev
git pull origin dev
git merge main
git push origin dev
```

---

## Branch Protection Rules

### `main` Branch
- ✅ Require pull request before merging
- ✅ Require status checks: CI Quality Gate, Security Audit
- ✅ Require conversation resolution
- ❌ No direct pushes (admins bypassed with warning)
- ❌ No force pushes
- ❌ No deletions

### `dev` Branch
- ✅ Require pull request before merging
- ✅ Require status checks: CI Quality Gate, Security Audit
- ✅ Require conversation resolution
- ⚠️ Allow force pushes (for history cleanup)
- ❌ No deletions

---

## Commit Message Convention

All commits must follow **Conventional Commits** format:

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style (formatting, no logic change)
- `refactor`: Code refactoring
- `perf`: Performance improvements
- `test`: Test additions or fixes
- `build`: Build system changes
- `ci`: CI/CD changes
- `chore`: Maintenance tasks
- `revert`: Revert previous commit

**Examples:**
```bash
feat(skills): add code-reviewer skill

Implements automatic code review skill with ESLint integration.

Closes #42

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

```bash
fix(install): resolve --skills-only flag issue

The install.sh script now properly handles the --skills-only flag.
Updated documentation to match actual flags.

Closes #4

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

---

## Quick Reference

### Daily Workflow
```bash
# 1. Start new work
git checkout dev && git pull origin dev
git checkout -b feat/your-feature

# 2. Make changes
git add . && git commit -m "feat: your change"

# 3. Create PR to dev
git push -u origin feat/your-feature
gh pr create --base dev --head feat/your-feature

# 4. After merge, branch auto-deletes
```

### Release Workflow
```bash
# 1. Prepare dev for release
git checkout dev && git pull origin dev

# 2. Create release PR
gh pr create --base main --head dev \
  --title "chore(release): v1.2.3"

# 3. After merge, tag release
git checkout main && git pull origin main
git tag -a v1.2.3 -m "Release 1.2.3"
git push origin v1.2.3
```

---

## CI/CD Integration

### Workflows Triggered on PRs to `dev`
- ✅ **CI Quality Gate** - YAML lint, schema validation, frontmatter checks
- ✅ **Commit & Branch Guard** - Conventional commits, branch naming
- ✅ **Security Audit** - OWASP Top 10 scanning
- ✅ **Claude Code Review** - AI-powered code review (if quota available)

### Workflows Triggered on PRs to `main`
- ✅ Same as dev, plus:
- ✅ **Release Orchestrator** - Available for manual triggering after merge

---

## Troubleshooting

### "Branch protection prevents push"
**Solution**: You must create a PR, cannot push directly to protected branches.

### "Status checks required"
**Solution**: Wait for CI workflows to complete and pass before merging.

### "Conversations not resolved"
**Solution**: Resolve all PR review comments before merging.

### "Diverged branches"
**Solution**:
```bash
git checkout dev
git pull origin dev
git checkout your-branch
git merge dev  # or git rebase dev
git push origin your-branch --force-with-lease
```

---

## Resources

- [Git Flow Documentation](https://nvie.com/posts/a-successful-git-branching-model/)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [GitHub Flow Guide](https://docs.github.com/en/get-started/quickstart/github-flow)
- Repository: https://github.com/alirezarezvani/claude-code-tresor
- Issues: https://github.com/alirezarezvani/claude-code-tresor/issues

---

**Status**: ✅ Active
**Last Updated**: November 5, 2025
**Owner**: Reza Rezvani
