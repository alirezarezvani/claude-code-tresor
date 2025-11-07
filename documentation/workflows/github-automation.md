# GitHub Automation System

> **Complete CI/CD & workflow automation for Claude Code Tresor**

**Version:** 1.0.0
**Created:** November 4, 2025
**Status:** Production Ready ✅

---

## Overview

Claude Code Tresor uses a comprehensive GitHub Actions automation system for quality assurance, branch protection, AI-powered code review, security audits, and release management.

### Automation Goals

1. **Quality Assurance** - Automated testing, linting, security scans
2. **Branch Protection** - Enforce naming conventions and conventional commits
3. **Code Review** - AI-powered review with Claude Code
4. **Release Management** - Automated versioning and release notes
5. **Developer Experience** - Fast feedback, clear errors, bypass mechanisms

---

## Core Workflows

### 1. Commit & Branch Guard

**File:** `.github/workflows/ci-commit-branch-guard.yml`

**Purpose:** Enforce branch naming conventions and conventional commits

**Triggers:**
- Pull request (opened, synchronize, reopened, ready_for_review)
- Manual dispatch

**Validates:**
- ✅ Branch naming: `feat/`, `fix/`, `docs/`, `chore/`, `refactor/`, `test/`, `build/`, `ci/`, `perf/`, `style/`, `hotfix/`, `release/`
- ✅ Conventional commits using commitlint
- ✅ Automated branches: `dependabot/`, `renovate/`

**Failure conditions:**
- ❌ Branch name doesn't match pattern
- ❌ Commit messages don't follow conventional commit format

---

### 2. CI Quality Gate

**File:** `.github/workflows/ci-quality-gate.yml`

**Purpose:** Comprehensive quality checks before merge

**Triggers:**
- Pull request (opened, synchronize, reopened, ready_for_review)
- Manual dispatch

**Quality checks:**
1. **YAML Linting** - Validates workflow YAML syntax
2. **GitHub Workflow Schema** - Ensures workflows match GitHub schema
3. **YAML Frontmatter** - Validates SKILL.md and agent .md frontmatter
4. **Markdown Links** - Validates README links

**Timeout:** 25 minutes
**Concurrency:** Cancels previous runs on new commits

---

### 3. Claude Code Review

**File:** `.github/workflows/claude-code-review.yml`

**Purpose:** AI-powered code review using Claude Code

**Triggers:**
- Pull request (opened, synchronize)

**Review criteria:**
- 💡 Code quality and best practices
- 🐛 Potential bugs or issues
- ⚡ Performance considerations
- 🔐 Security concerns
- 🧪 Test coverage

**Bypass mechanisms:**
1. PR title markers: `[EMERGENCY]`, `[SKIP REVIEW]`, `[HOTFIX]`
2. PR labels: `emergency`, `skip-review`, `hotfix`
3. Kill switch: `.github/WORKFLOW_KILLSWITCH`

**Fallback:** Posts notice if quota exceeded or timeout

---

### 4. Security Audit

**File:** `.github/workflows/security-audit.yml`

**Purpose:** AI-powered security review using Claude Code

**Triggers:**
- Pull request (opened, synchronize, reopened, ready_for_review)

**Security focus:**
- 🔒 OWASP Top 10 vulnerabilities
- 🔒 Secrets exposure (API keys, tokens)
- 🔒 Supply chain risks
- 🔒 Dangerous command patterns
- 🔒 LLM agent hardening

**Output:** PR comment with severity summary and actionable findings

**Bypass:** Uses kill switch (`.github/WORKFLOW_KILLSWITCH`)

---

### 5. Release Orchestrator

**File:** `.github/workflows/release-orchestrator.yml`

**Purpose:** Automated release creation with version tagging

**Triggers:**
- Manual dispatch (workflow_dispatch)

**Inputs:**
- `version` - Semantic version (e.g., v1.4.0)
- `target` - Branch/commit to release from (default: main)

**Process:**
1. **Prepare:** Gather commits since last tag, generate release notes
2. **Publish:** Create annotated git tag, draft GitHub Release

**Outputs:**
- Annotated git tag
- Draft GitHub Release with auto-generated notes
- Release notes include commit history with timestamps

---

## Branching Strategy

### Branch Hierarchy

```
main (production) - Protected, requires PR approval
  ↑
dev (development) - Protected, requires status checks
  ↑
feature/* (feature branches) - Follows naming conventions
```

### Branch Naming Rules

**Allowed prefixes:**
- `feat/` - New features
- `fix/` - Bug fixes
- `docs/` - Documentation
- `chore/` - Maintenance
- `refactor/` - Code refactoring
- `test/` - Tests
- `build/` - Build system
- `ci/` - CI/CD changes
- `perf/` - Performance
- `style/` - Code style
- `hotfix/` - Emergency fixes
- `release/` - Release prep

**Automated branches:**
- `dependabot/` - Dependabot PRs
- `renovate/` - Renovate PRs

---

## Conventional Commits

### Required Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

### Valid Types

- `feat` - New feature
- `fix` - Bug fix
- `docs` - Documentation
- `style` - Formatting
- `refactor` - Refactoring
- `perf` - Performance
- `test` - Tests
- `build` - Build system
- `ci` - CI/CD
- `chore` - Maintenance
- `revert` - Revert

### Examples

```bash
feat(workflows): add GitHub Actions automation system

Implement 5 core workflows: branch guard, quality gate,
Claude code review, security audit, and release orchestrator.

Based on claude-code-skills-factory proven patterns.
```

```bash
fix(quality-gate): validate YAML frontmatter in skills and agents

Add Python YAML validation for SKILL.md and agent .md files
to catch syntax errors before merge.
```

```bash
docs(automation): add comprehensive GitHub automation guide

Document all workflows, branching strategy, conventional commits,
and troubleshooting procedures.
```

---

## Required Configuration

### GitHub Secrets

**1. CLAUDE_CODE_OAUTH_TOKEN**
- **Status:** Required for AI workflows
- **Purpose:** Claude Code AI integration
- **How to get:**
  ```bash
  # In Claude Code CLI:
  /install-github-app

  # Follow OAuth flow
  # Copy token to: GitHub → Settings → Secrets → Actions → New repository secret
  ```

**2. GITHUB_TOKEN**
- **Status:** Automatic
- **Purpose:** GitHub API access
- **Note:** Provided automatically by GitHub Actions

---

### Kill Switch

**File:** `.github/WORKFLOW_KILLSWITCH`

```
STATUS: ENABLED
REASON: Normal operations
LAST_UPDATED: 2025-11-04
```

**To disable workflows:**
```
STATUS: DISABLED
REASON: Testing kill switch
LAST_UPDATED: 2025-11-04
```

Affects: Claude Code Review, Security Audit

---

## Workflow Execution

### On Pull Request

**Automated workflows:**
1. **Branch name validation** - Enforces naming conventions
2. **Commit message validation** - Enforces conventional commits
3. **Quality checks** - YAML linting, schema validation, frontmatter validation
4. **Claude Code review** - AI-powered code review (requires token)
5. **Security audit** - AI-powered security scanning (requires token)

**Execution time:** ~5-10 minutes total (parallel execution)

---

### On Manual Dispatch

**Release Orchestrator:**
1. Navigate to: Actions → Release Orchestrator → Run workflow
2. Enter version: `v3.0.0-beta.1`
3. Enter target branch: `main` (or `dev` for testing)
4. Click "Run workflow"

**Result:**
- Git tag created
- Draft GitHub Release with auto-generated notes

---

## Bypass Mechanisms

### Emergency Situations

**Use when:** Critical hotfix needed immediately

**Methods:**

**1. PR Title Markers:**
```
[EMERGENCY] fix: critical security patch
[HOTFIX] fix: production outage
[SKIP REVIEW] chore: urgent dependency update
```

**2. PR Labels:**
Add label: `emergency`, `hotfix`, or `skip-review`

**3. Kill Switch:**
Edit `.github/WORKFLOW_KILLSWITCH`:
```
STATUS: DISABLED
REASON: Emergency hotfix - restoring service
LAST_UPDATED: 2025-11-04
```

**Result:** Review workflows exit early, post notice, other checks still run

---

## Testing Workflows

### Phase 1: Local Validation

```bash
# 1. Check workflow YAML syntax
yamllint .github/workflows

# 2. Validate workflow schemas
npx check-jsonschema --schema github-workflow .github/workflows/*.yml

# 3. Check SKILL.md YAML frontmatter
find skills -name "SKILL.md" | while read file; do
  python -c "import yaml; yaml.safe_load(open('$file').read().split('---')[1])"
done

# 4. Check commit message format
npx commitlint --from HEAD~1 --to HEAD
```

---

### Phase 2: GitHub Actions Testing

**Test 1: Commit & Branch Guard**
```bash
# Create feature branch with valid name
git checkout -b feat/test-workflows

# Create commit with conventional message
git commit -m "feat(workflows): test GitHub Actions automation

This commit tests the workflow automation system."

# Push and create PR
git push -u origin feat/test-workflows

# Expected: ✅ Branch name passes, ✅ Commit message passes
```

**Test 2: Quality Gate**
```bash
# Quality gate automatically runs on PR
# Check: Actions tab → CI Quality Gate workflow

# Expected checks:
# ✅ YAML linting passes
# ✅ Workflow schema validation passes
# ✅ SKILL.md frontmatter validation passes
# ✅ README markdown links pass
```

**Test 3: Claude Code Review (Requires Token)**
```bash
# Configure CLAUDE_CODE_OAUTH_TOKEN first
# PR automatically triggers Claude review

# Expected:
# ⏳ Claude reviews code
# 💬 Posts review comment on PR
# OR ⚠️ Posts fallback notice if quota exceeded
```

**Test 4: Release Orchestrator**
```bash
# Manual workflow dispatch from Actions tab
# Inputs: version: v3.0.0-beta.1, target: dev

# Expected:
# ✅ Git tag created: v3.0.0-beta.1
# ✅ Release notes generated from commits
# ✅ Draft GitHub Release created
```

---

## Branch Protection Rules

### Main Branch

Configure: Repository → Settings → Branches → Add rule

**Rules:**
- ✅ Require pull request reviews (1 reviewer recommended)
- ✅ Require status checks before merging:
  - CI Quality Gate
  - Commit & Branch Guard
- ✅ Require branches to be up to date before merging
- ✅ Require conversation resolution before merging
- ❌ No force pushes
- ❌ No deletions

---

### Dev Branch

**Rules:**
- ✅ Require pull request reviews (optional)
- ✅ Require status checks before merging:
  - CI Quality Gate
  - Commit & Branch Guard
- ✅ Require branches to be up to date
- ⚠️ Allow force pushes (for cleanup)
- ❌ No deletions

---

## Troubleshooting

### Workflow Fails: Branch Name Invalid

**Error:** `Branch name 'my-feature' doesn't match required pattern`

**Solution:**
```bash
# Rename branch with valid prefix
git branch -m my-feature feat/my-feature
git push origin :my-feature feat/my-feature
```

---

### Workflow Fails: Commit Message Invalid

**Error:** `Commit message doesn't follow conventional commit format`

**Solution:**
```bash
# Amend commit message
git commit --amend -m "feat: add my feature

Detailed description here."

# Force push (only if branch not shared)
git push --force-with-lease
```

---

### Claude Review Skipped: Quota Exceeded

**Message:** `Claude Code review skipped - quota exceeded or API unavailable`

**Solutions:**
1. **Wait for quota reset** (usually daily)
2. **Manual review** - Review code manually
3. **Bypass if urgent** - Use `[EMERGENCY]` in PR title

---

### Kill Switch Not Working

**Problem:** Workflows still running despite kill switch set to DISABLED

**Check:**
1. Verify `.github/WORKFLOW_KILLSWITCH` file exists
2. Check STATUS line is exactly: `STATUS: DISABLED`
3. Commit and push kill switch file
4. Create new PR to test

---

### Quality Gate Fails: YAML Frontmatter

**Error:** `YAML frontmatter validation failed for skills/code-reviewer/SKILL.md`

**Solutions:**
```bash
# Check YAML syntax manually
python -c "
import yaml
content = open('skills/code-reviewer/SKILL.md').read()
yaml_part = content.split('---')[1]
try:
    yaml.safe_load(yaml_part)
    print('✅ Valid YAML')
except yaml.YAMLError as e:
    print(f'❌ YAML Error: {e}')
"

# Common issues:
# - Incorrect indentation (use 2 spaces)
# - Missing quotes around special characters
# - Extra spaces after colons
```

---

## Implementation Summary

### Files Created

**Workflow Files (`.github/workflows/`):**
1. ✅ ci-commit-branch-guard.yml (79 lines)
2. ✅ ci-quality-gate.yml (88 lines)
3. ✅ claude-code-review.yml (134 lines)
4. ✅ security-audit.yml (85 lines)
5. ✅ release-orchestrator.yml (121 lines)

**Configuration Files:**
6. ✅ commitlint.config.js
7. ✅ .github/WORKFLOW_KILLSWITCH

**Documentation:**
8. ✅ documentation/workflows/github-automation.md (this file)

---

## Benefits Achieved

### Developer Experience
✅ **Automated quality checks** - Catch issues before merge
✅ **AI-powered reviews** - Claude Code provides expert feedback
✅ **Security scanning** - Proactive vulnerability detection
✅ **Consistent commits** - Enforced conventional commit format
✅ **Easy releases** - One-click version tagging

### Code Quality
✅ **YAML validation** - No syntax errors in skills/agents
✅ **Schema compliance** - Workflows match GitHub requirements
✅ **Documentation checks** - Valid markdown links
✅ **Security first** - OWASP and LLM-specific checks

### Team Efficiency
✅ **Fast feedback** - Workflows run in parallel (<10 min total)
✅ **Clear errors** - Actionable error messages
✅ **Emergency bypasses** - No blockers in critical situations
✅ **Automated releases** - Consistent versioning

---

## Related Documentation

- [Git Workflow Guide →](git-workflow.md) - Complete branching strategy
- [Quick Reference →](quick-reference.md) - Git workflow cheat sheet
- [Getting Started →](../guides/getting-started.md) - Installation and setup

---

**Last Updated:** November 7, 2025 | **Version:** 2.0.0
