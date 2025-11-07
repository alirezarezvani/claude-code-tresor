# Quick Reference - Git Workflow

**Branching Strategy**: Git Flow (dev → main)

---

## 🚀 Start New Feature

```bash
git checkout dev && git pull origin dev
git checkout -b feat/your-feature-name
```

---

## 💾 Commit Changes

```bash
git add .
git commit -m "feat: your change

Details here.

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>"
```

**Commit types**: `feat`, `fix`, `docs`, `chore`, `test`, `ci`, `perf`, `style`, `refactor`, `revert`

---

## 📤 Create PR to `dev`

```bash
git push -u origin feat/your-feature-name
gh pr create --base dev --head feat/your-feature-name \
  --title "feat: your feature" \
  --body "## Summary
Your description here"
```

---

## ✅ Merge PR

```bash
# Via CLI
gh pr merge <PR-NUMBER> --squash --delete-branch

# Via GitHub UI (recommended)
# Click "Squash and merge"
# Branch auto-deletes
```

---

## 🎉 Release to `main`

```bash
git checkout dev && git pull origin dev
gh pr create --base main --head dev \
  --title "chore(release): v1.2.3" \
  --body "## Release Summary
Changes included..."

# After merge
git checkout main && git pull origin main
git tag -a v1.2.3 -m "Release 1.2.3"
git push origin v1.2.3
```

---

## 🔥 Hotfix (Emergency)

```bash
git checkout main && git pull origin main
git checkout -b hotfix/critical-fix

# Make fix
git add . && git commit -m "fix: critical issue"

gh pr create --base main --head hotfix/critical-fix \
  --title "[HOTFIX] fix: critical issue"

# After merge to main, backport to dev
git checkout dev && git merge main && git push origin dev
```

---

## 📋 Branch Naming

- `feat/` - New features
- `fix/` - Bug fixes
- `docs/` - Documentation
- `chore/` - Maintenance
- `test/` - Tests
- `ci/` - CI/CD changes
- `hotfix/` - Emergency fixes

---

## 🛡️ Branch Protection

### `main` (production)
- ✅ Require PR
- ✅ Require checks: CI Quality Gate, Security Audit
- ✅ Require conversation resolution
- ❌ No direct pushes

### `dev` (integration)
- ✅ Require PR
- ✅ Require checks: CI Quality Gate, Security Audit
- ✅ Require conversation resolution
- ⚠️ Force push allowed (for cleanup)

---

## 🐛 Troubleshooting

**Can't push to dev/main?**
→ Create PR, protected branches don't allow direct pushes

**Checks failing?**
→ Wait for CI to pass or fix issues

**Branch diverged?**
```bash
git checkout dev && git pull origin dev
git checkout your-branch && git merge dev
git push origin your-branch --force-with-lease
```

---

**Full Guide**: [BRANCHING-STRATEGY.md](BRANCHING-STRATEGY.md)
