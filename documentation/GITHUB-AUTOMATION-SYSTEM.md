# GitHub Automation System
## Complete CI/CD & Workflow Documentation

**Version**: 1.0.0
**Date**: November 4, 2025
**Project**: Claude Code Tresor
**Source**: Adapted from claude-code-skills-factory

---

## 🎯 Overview

This document describes the complete GitHub Actions automation system for claude-code-tresor, including CI/CD pipelines, quality gates, security audits, release orchestration, and Claude Code integration.

### Automation Goals

1. **Quality Assurance** - Automated testing, linting, security scans
2. **Branch Protection** - Enforce naming conventions and conventional commits
3. **Code Review** - AI-powered review with Claude Code
4. **Release Management** - Automated versioning and release notes
5. **Developer Experience** - Fast feedback, clear errors, bypass mechanisms

---

## 📁 Workflow Catalog

### Core CI/CD Workflows (Required)

#### 1. **Commit & Branch Guard** (`ci-commit-branch-guard.yml`)

**Purpose**: Enforce branch naming conventions and conventional commits

**Triggers**:
- Pull request (opened, synchronize, reopened, ready_for_review)
- Manual dispatch
- Repository dispatch

**What it validates**:
- ✅ Branch naming: `feat/`, `fix/`, `docs/`, `chore/`, `refactor/`, `test/`, `build/`, `ci/`, `perf/`, `style/`, `hotfix/`, `release/`
- ✅ Conventional commits using commitlint
- ✅ Automated branches: `dependabot/`, `renovate/`

**Failure conditions**:
- ❌ Branch name doesn't match pattern
- ❌ Commit messages don't follow conventional commit format

---

#### 2. **CI Quality Gate** (`ci-quality-gate.yml`)

**Purpose**: Comprehensive quality checks before merge

**Triggers**:
- Pull request (opened, synchronize, reopened, ready_for_review)
- Manual dispatch
- Repository dispatch

**Quality checks**:
1. **YAML Linting** - Validates workflow YAML syntax
2. **GitHub Workflow Schema** - Ensures workflows match GitHub schema
3. **Python Syntax** - Compiles Python files
4. **Dependency Audit** - Scans `requirements*.txt` for vulnerabilities (using `safety`)
5. **Markdown Links** - Validates README links

**Timeout**: 25 minutes
**Concurrency**: Cancels previous runs on new commits

---

#### 3. **Security Audit** (`security-audit.yml`)

**Purpose**: AI-powered security review using Claude Code

**Triggers**:
- Pull request (opened, synchronize, reopened, ready_for_review)

**Security focus**:
- 🔒 OWASP Top 10 vulnerabilities
- 🔒 Secrets exposure (API keys, tokens)
- 🔒 Supply chain risks
- 🔒 Dangerous command patterns
- 🔒 LLM agent hardening

**Output**: PR comment with severity summary and actionable findings

**Bypass**: Uses kill switch (`.github/WORKFLOW_KILLSWITCH`)

---

#### 4. **Claude Code Review** (`claude-code-review.yml`)

**Purpose**: Comprehensive code review using Claude Code AI

**Triggers**:
- Pull request (opened, synchronize)

**Review criteria**:
- 💡 Code quality and best practices
- 🐛 Potential bugs or issues
- ⚡ Performance considerations
- 🔐 Security concerns
- 🧪 Test coverage

**Bypass mechanisms**:
1. PR title markers: `[EMERGENCY]`, `[SKIP REVIEW]`, `[HOTFIX]`
2. PR labels: `emergency`, `skip-review`, `hotfix`
3. Kill switch: `.github/WORKFLOW_KILLSWITCH`

**Tools allowed**: `gh` CLI commands for PR comments/viewing

**Fallback**: Posts notice if quota exceeded or timeout

---

#### 5. **Release Orchestrator** (`release-orchestrator.yml`)

**Purpose**: Automated release creation with version tagging

**Triggers**:
- Manual dispatch (workflow_dispatch)
- Repository dispatch

**Inputs**:
- `version` - Semantic version (e.g., v1.4.0)
- `target` - Branch/commit to release from (default: main)

**Process**:
1. **Prepare**: Gather commits since last tag, generate release notes
2. **Publish**: Create annotated git tag, draft GitHub Release

**Outputs**:
- Annotated git tag
- Draft GitHub Release with auto-generated notes
- Release notes include commit history with timestamps

---

### Extended Workflows (Optional)

#### 6. **Git Governance Audit** (`git-governance-audit.yml`)

**Purpose**: Enforce git governance policies

**Features**:
- Force-push detection
- Branch protection verification
- Commit signature validation

---

#### 7. **Workflow Health** (`workflow-health.yml`)

**Purpose**: Monitor workflow system health

**Features**:
- Workflow success rate tracking
- Performance metrics
- Alert on degradation

---

#### 8. **Smart Sync** (`smart-sync.yml`)

**Purpose**: Auto-sync documentation and metadata

**Features**:
- CLAUDE.md → AGENTS.md synchronization
- Documentation freshness checks
- Auto-update mechanisms

---

#### 9. **Issue Triage** (`issue-triage.yml`)

**Purpose**: Automated issue labeling and routing

**Features**:
- Auto-label by keywords
- Assign to appropriate team
- Priority detection

---

#### 10. **PR/Issue Auto-Close** (`pr-issue-auto-close.yml`)

**Purpose**: Auto-close stale PRs and issues

**Features**:
- Configurable staleness period
- Warning before closing
- Exemption labels

---

## 🌳 Branching Strategy

### Branch Hierarchy

```
main (production)
  ↑
dev (development)
  ↑
feature/* (feature branches)
fix/* (bug fixes)
docs/* (documentation)
chore/* (maintenance)
hotfix/* (emergency fixes)
release/* (release preparation)
```

### Branch Rules

#### **main branch**
- 🔒 Protected - requires PR approval
- ✅ All checks must pass
- 🚀 Represents production-ready code
- 📦 All releases tagged from main
- ⛔ Direct commits disabled

#### **dev branch**
- 🔄 Integration branch for features
- ✅ All checks must pass before merge
- 🔀 All feature branches merge here first
- 🚀 Periodically synced to main
- ✅ Allows direct commits (for quick fixes)

#### **Feature branches**
- 📌 Naming: `feat/feature-name`
- 🔀 Branch from: `dev`
- 🎯 Merge to: `dev`
- 🔄 Short-lived (1-2 weeks max)
- 🧪 Must pass all CI checks

#### **Other branches**
- `fix/*` - Bug fixes
- `docs/*` - Documentation updates
- `chore/*` - Maintenance tasks
- `refactor/*` - Code refactoring
- `test/*` - Test additions
- `build/*` - Build system changes
- `ci/*` - CI/CD changes
- `perf/*` - Performance improvements
- `style/*` - Code style changes
- `hotfix/*` - Emergency production fixes
- `release/*` - Release preparation

---

## 🔐 Required Secrets

Configure these in GitHub repository settings:

### 1. **CLAUDE_CODE_OAUTH_TOKEN**
- **Purpose**: Claude Code AI integration
- **Used by**: `claude-code-review.yml`, `security-audit.yml`
- **How to get**:
  1. Run `/install-github-app` in Claude Code CLI
  2. Follow OAuth flow
  3. Copy token to GitHub secrets

### 2. **GITHUB_TOKEN** (automatic)
- **Purpose**: GitHub API access
- **Used by**: All workflows
- **Note**: Automatically provided by GitHub Actions

---

## 📋 Conventional Commit Format

All commits must follow conventional commit format:

### Format
```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types
- `feat` - New feature
- `fix` - Bug fix
- `docs` - Documentation changes
- `style` - Code style changes (formatting, no logic change)
- `refactor` - Code refactoring
- `perf` - Performance improvements
- `test` - Test additions or fixes
- `build` - Build system changes
- `ci` - CI/CD changes
- `chore` - Maintenance tasks
- `revert` - Revert previous commit

### Examples
```bash
feat(skills): add market-opportunity-scanner skill

Add autonomous skill for analyzing market opportunities
with TAM/SAM/SOM calculations and trend analysis.

Closes #123

---

fix(agents): resolve memory leak in llm-engineer agent

The agent was not properly releasing resources after
completion, causing memory to accumulate over time.

---

docs(readme): update installation instructions

Add troubleshooting section for common installation
issues on Windows and macOS.
```

---

## 🚀 Workflow Implementation for Tresor

### Phase 1: Core Workflows (Week 1)

**Priority workflows to implement**:
1. ✅ Commit & Branch Guard
2. ✅ CI Quality Gate
3. ✅ Claude Code Review
4. ✅ Security Audit
5. ✅ Release Orchestrator

**Steps**:
1. Create `.github/workflows/` directory
2. Copy workflow files from skills-factory
3. Adapt for tresor (update repository references)
4. Configure secrets in GitHub
5. Test each workflow
6. Document in README

---

### Phase 2: Extended Workflows (Week 2)

**Optional workflows to add**:
1. Git Governance Audit
2. Workflow Health Monitor
3. Issue Triage Automation
4. Stale PR/Issue Closer

---

## 🔧 Adaptation Checklist

When adapting workflows from skills-factory to tresor:

### Repository-Specific Changes

- [ ] Update `repository` references: `alirezarezvani/claude-code-skills-factory` → `alirezarezvani/claude-code-tresor`
- [ ] Adjust Python paths: `claude-skills-examples generated-skills` → `skills agents commands`
- [ ] Update project name in comments and descriptions
- [ ] Verify directory structure matches (e.g., `.github/workflows/`)
- [ ] Adjust timeout values if needed
- [ ] Update kill switch path if using different location

### Secret Configuration

- [ ] Add `CLAUDE_CODE_OAUTH_TOKEN` to GitHub repository secrets
- [ ] Verify `GITHUB_TOKEN` permissions in workflow files
- [ ] Test OAuth authentication flow

### Branch Protection Rules

- [ ] Configure `main` branch protection (require PR reviews)
- [ ] Configure `dev` branch protection (require status checks)
- [ ] Set up required status checks (CI Quality Gate, Commit Guard)
- [ ] Configure branch naming enforcement

### Testing

- [ ] Create test feature branch: `feat/test-workflows`
- [ ] Make test commit with conventional commit message
- [ ] Open test PR to trigger workflows
- [ ] Verify all workflows execute correctly
- [ ] Check PR comments from Claude Code
- [ ] Test bypass mechanisms
- [ ] Test release process (manual dispatch)

---

## 📊 Workflow Dependency Map

```
Pull Request Created
  ↓
├─ Commit & Branch Guard (validates naming/commits)
├─ CI Quality Gate (lints, tests, audits)
├─ Claude Code Review (AI review)
└─ Security Audit (security scan)
  ↓
All Checks Pass ✅
  ↓
Merge to dev
  ↓
Eventually merge dev → main
  ↓
Release Orchestrator (manual trigger)
  ↓
Tagged Release Published 🚀
```

---

## 🛡️ Kill Switch System

### Purpose
Emergency disable mechanism for workflows

### Implementation

Create `.github/WORKFLOW_KILLSWITCH`:
```
STATUS: ENABLED
REASON: Normal operation
UPDATED: 2025-11-04
```

To disable workflows:
```
STATUS: DISABLED
REASON: Emergency maintenance
UPDATED: 2025-11-04
```

All workflows check this file first and exit cleanly if disabled.

---

## 💡 Best Practices

### For Developers

1. **Always branch from dev**: `git checkout dev && git pull && git checkout -b feat/my-feature`
2. **Use conventional commits**: Follow the format strictly
3. **Keep branches updated**: Regularly merge dev into your feature branch
4. **Small, focused PRs**: Easier to review and faster to merge
5. **Run local checks**: Test before pushing (linting, tests)

### For Maintainers

1. **Review Claude's feedback**: AI reviews catch many issues but aren't perfect
2. **Use bypass sparingly**: Only for true emergencies
3. **Keep workflows updated**: Regularly update actions to latest versions
4. **Monitor workflow health**: Check success rates and fix failures
5. **Document changes**: Update this file when modifying workflows

---

## 🐛 Troubleshooting

### Workflow Not Triggering

**Problem**: Workflow doesn't run on PR
**Solutions**:
- Check kill switch status
- Verify workflow file syntax (YAML valid)
- Check branch naming matches required pattern
- Ensure PR is not in draft mode (for `ready_for_review` trigger)

### Claude Code Review Failing

**Problem**: Claude review times out or fails
**Solutions**:
- Check `CLAUDE_CODE_OAUTH_TOKEN` secret is set
- Verify token hasn't expired (re-run `/install-github-app`)
- Check Claude Code service status
- Retry workflow manually if quota exceeded

### Commit Validation Failing

**Problem**: Conventional commit check fails
**Solutions**:
- Verify commit message format: `type(scope): message`
- Use valid types only (feat, fix, docs, etc.)
- Don't use uppercase in type/scope
- Check for typos in commit message

### Quality Gate Failing

**Problem**: CI Quality Gate fails
**Solutions**:
- Check Python syntax errors
- Run `yamllint .github/workflows/` locally
- Verify all dependency files are valid
- Check markdown links in README

---

## 📝 Workflow File Locations

All workflow files in: `.github/workflows/`

**Core workflows**:
- `ci-commit-branch-guard.yml`
- `ci-quality-gate.yml`
- `claude-code-review.yml`
- `security-audit.yml`
- `release-orchestrator.yml`

**Extended workflows**:
- `git-governance-audit.yml`
- `workflow-health.yml`
- `smart-sync.yml`
- `issue-triage.yml`
- `pr-issue-auto-close.yml`

---

## 🎯 Success Metrics

**Measure automation effectiveness**:

1. **PR Cycle Time**: Time from PR open to merge (target: < 4 hours)
2. **Bug Escape Rate**: Bugs found in production vs caught in CI (target: < 5%)
3. **Workflow Success Rate**: % of workflows that pass first try (target: > 90%)
4. **Review Coverage**: % of PRs reviewed by Claude Code (target: 100%)
5. **Security Issues Found**: Security vulnerabilities caught pre-merge

---

## 🔄 Maintenance Schedule

**Weekly**:
- Review failed workflows
- Check for workflow updates

**Monthly**:
- Update GitHub Actions to latest versions
- Review and update branch protection rules
- Audit workflow performance metrics

**Quarterly**:
- Review and update automation strategy
- Add new workflows based on team needs
- Optimize workflow execution times

---

## 📚 References

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Claude Code GitHub Actions](https://docs.claude.com/en/docs/claude-code/github-actions)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Commitlint](https://commitlint.js.org/)
- [Semantic Versioning](https://semver.org/)

---

**Status**: Ready for implementation
**Next Action**: Create workflows in `.github/workflows/` directory
**Owner**: Reza Rezvani
