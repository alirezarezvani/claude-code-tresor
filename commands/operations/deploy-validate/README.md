# `/deploy-validate` - Pre-Deployment Validation

> Comprehensive deployment safety checks to prevent production outages

**Version:** 2.7.0
**Category:** Operations / Deployment
**Type:** Orchestration Command
**Estimated Duration:** 10-20 minutes

---

## Overview

The `/deploy-validate` command performs comprehensive pre-deployment validation to prevent production outages. It validates tests, configuration safety, security, environment readiness, and provides a go/no-go deployment decision with risk assessment.

### Why Pre-Deployment Validation?

**Common Deployment Failures Prevented:**
- ❌ Tests passing locally but failing in production
- ❌ Configuration errors causing immediate crashes
- ❌ Database migrations causing downtime
- ❌ Dependency conflicts in production
- ❌ Insufficient resource capacity
- ❌ External service unavailability

**This command catches these issues BEFORE deployment.**

---

## Key Features

- ✅ **Comprehensive Test Execution** - Unit, integration, E2E tests
- ✅ **Configuration Safety Review** - Prevent config-related outages
- ✅ **Security Pre-Deployment Scan** - No critical vulnerabilities
- ✅ **Environment Readiness Check** - Infrastructure health, capacity, dependencies
- ✅ **Database Migration Validation** - Safe schema changes
- ✅ **Risk Assessment** - Quantified deployment risk score
- ✅ **Go/No-Go Decision** - Clear approval or blocking with rationale
- ✅ **Rollback Plan Verification** - Ensure safe recovery path

---

## Quick Start

### Basic Usage

```bash
# Auto-detect environment and validate
/deploy-validate

# Specify target environment
/deploy-validate --env production
/deploy-validate --env staging

# Quick validation (skip E2E tests)
/deploy-validate --quick
```

### Advanced Usage

```bash
# Skip tests (if already run in CI/CD)
/deploy-validate --skip-tests --env production

# Staging deployment (less strict)
/deploy-validate --env staging --quick
```

---

## How It Works

### Phase 0: Deployment Planning

**Context Detection:**
```
Analyzing deployment context...

Git Context:
- Current branch: feature/user-authentication
- Target branch: main → production
- Commits: 15 since last deployment
- Changed files: 47 (23 backend, 18 frontend, 6 config)

Deployment Scope:
- Backend changes: ✓ (API endpoints modified)
- Frontend changes: ✓ (React components updated)
- Database migrations: ✓ (2 pending migrations)
- Infrastructure: ✗ (no infra changes)

Target Environment: Production
- Infrastructure: Kubernetes on AWS
- Database: PostgreSQL RDS
- Current health: Healthy

Validation Plan:
Phase 1 (Parallel - 3 agents):
  ✓ @test-engineer - Run complete test suite
  ✓ @config-safety-reviewer - Configuration safety
  ✓ @security-auditor - Security pre-deployment scan

Phase 2 (Sequential):
  → @devops-engineer - Environment readiness validation

Phase 3 (Sequential, Production only):
  → @deployment-safety-officer - Final go/no-go decision

Estimated Duration: 15 minutes

Proceed? (y/n)
```

---

### Phase 1: Pre-Deployment Validation (Parallel)

**3 Agents Run Simultaneously:**

**Agent 1: Test Engineer**
```
Running test suite...

Unit Tests:
✓ 247 tests passed
✗ 0 tests failed
⏭ 0 tests skipped
Coverage: 84% (baseline: 82%) ✓

Integration Tests:
✓ 45 tests passed
✗ 0 tests failed
Duration: 3m 45s

E2E Tests:
✓ 12 tests passed
✗ 0 tests failed
Duration: 8m 12s

Test Results: PASS ✓
```

**Agent 2: Config Safety Reviewer**
```
Reviewing configuration changes...

Changed Config Files:
- config/database.js (connection pool: 10 → 20)
- config/api.js (timeout: 30s → 60s)
- .env.production (3 variables updated)

Configuration Safety Analysis:

1. Database Config:
   - pool.max: 20 ⚠️
     Issue: Recommended 50 for production workload
     Impact: May hit connection limits at 200 RPS
     Severity: WARNING (not blocking)
     Recommendation: Increase to 50
     Todo: #deploy-001

2. API Config:
   - timeout: 60s ⚠️
     Issue: Very high timeout (was 30s)
     Impact: Slow requests will hold resources longer
     Severity: WARNING
     Recommendation: Use 30s, optimize slow endpoints
     Todo: #deploy-002

3. Environment Variables:
   - DATABASE_URL: ✓ Production RDS endpoint
   - API_KEY: ✓ Production key (not test key)
   - REDIS_URL: ✓ Production Redis

Configuration Safety: PASS (2 warnings, 0 critical)
```

**Agent 3: Security Auditor**
```
Running security pre-deployment scan...

Critical Vulnerabilities: 0 ✓

High Vulnerabilities: 1 ⚠️
- lodash@4.17.20 (CVE-2024-12345)
  Severity: HIGH (non-critical)
  Exploitable: No (internal use only)
  Can deploy: Yes (fix post-deployment)
  Todo: #deploy-003

Secret Scanning:
- No exposed API keys ✓
- No hardcoded credentials ✓
- No .env files in git ✓

Authentication Changes:
- JWT signing key: From environment variable ✓
- Password hashing: bcrypt (unchanged) ✓
- Session config: No changes ✓

Security: PASS (1 high non-critical vuln)
```

**Output:**
```
Phase 1 Complete (12 minutes)
- @test-engineer: PASS (all tests passed)
- @config-safety-reviewer: PASS (2 warnings)
- @security-auditor: PASS (1 high vuln, non-blocking)

Status: PASS (proceed to Phase 2)
Todos Created: 3 post-deployment fixes
```

---

### Phase 2: Environment Readiness

**Agent:** `@devops-engineer`

**Validation:**
```
Checking environment readiness...

Infrastructure Health:
- Kubernetes nodes: 3/3 Ready ✓
- Pods: 12/12 Running ✓
- CPU usage: 45% ✓
- Memory usage: 60% ✓
- Disk usage: 55% ✓

Database:
- PostgreSQL RDS: Available ✓
- Connection test: Success (12ms) ✓
- Migrations pending: 2 found
  1. Add index on users.email
  2. Add consent_log table
- Migration dry-run: Success ✓
- Estimated migration time: 15 seconds ✓
- Backup status: Latest backup 2 hours ago ✓

External Dependencies:
- Stripe API: Healthy (97ms) ✓
- SendGrid API: Healthy (45ms) ✓
- Auth0: Healthy (132ms) ✓
- Redis: Healthy ✓

Resource Capacity:
- CPU headroom: 55% ✓ (sufficient for deployment)
- Memory headroom: 40% ✓
- Database connections: 12/100 (12% used) ✓

Recent Incidents:
- Last 24 hours: No incidents ✓
- Last 7 days: 1 incident (resolved) ⚠️

Environment: READY ✓
```

**Output:**
```
Phase 2 Complete (2 minutes)
- Infrastructure: Healthy
- Database: Ready (2 migrations to apply)
- Dependencies: All reachable
- Capacity: Sufficient

Status: READY (proceed to Phase 3)
```

---

### Phase 3: Final Go/No-Go Decision

**Agent:** `@deployment-safety-officer` (Production only)

**Decision:**
```
Final Safety Check...

Risk Assessment:
┌─────────────────────────┬────────┬────────┐
│ Check                   │ Status │ Risk   │
├─────────────────────────┼────────┼────────┤
│ Tests                   │ PASS   │ 0      │
│ Config Critical Issues  │ 0      │ 0      │
│ Config Warnings         │ 2      │ +10    │
│ Security Critical       │ 0      │ 0      │
│ Security High           │ 1      │ +5     │
│ Changed Files (47)      │ -      │ +15    │
│ DB Migrations (2)       │ Safe   │ +5     │
│ Environment Health      │ Good   │ 0      │
│ Recent Incidents        │ 1      │ +5     │
├─────────────────────────┼────────┼────────┤
│ **Total Risk Score**    │        │ **35** │
└─────────────────────────┴────────┴────────┘

Risk Level: MEDIUM (21-50 range)

Decision: ✅ **GO WITH CAUTION**

Rationale:
- All critical checks passed ✓
- Minor warnings don't block deployment
- Non-critical security issue (can fix post-deploy)
- Environment is healthy and ready
- Rollback plan verified

Conditions:
- Enhanced monitoring for 2 hours
- Team on standby
- Address 3 post-deployment todos within 1 week
```

**Output:**
```
Phase 3 Complete (1 minute)
- Risk score: 35 / 100 (MEDIUM)
- Decision: GO WITH CAUTION
- Confidence: Medium

Status: APPROVED FOR DEPLOYMENT
```

---

## Example Workflows

### Workflow 1: Standard Production Deployment

```bash
# Step 1: Run full deployment validation
/deploy-validate --env production

# Result: GO WITH CAUTION (risk: 35)

# Step 2: Review findings
cat .tresor/deploy-*/phase-3-go-no-go.md

# Step 3: Deploy
kubectl apply -f k8s/production/

# Step 4: Monitor (first 30 minutes)
kubectl logs -f deployment/app
# Watch for errors, latency spikes

# Step 5: Verify deployment health
/health-check

# Step 6: Address post-deployment todos
/todo-check
# → Fix config warnings
# → Upgrade vulnerable dependency
```

---

### Workflow 2: Deployment Blocked by Critical Issues

```bash
# Step 1: Run deployment validation
/deploy-validate --env production

# Result: ❌ NO-GO (risk: 120)
# Blocking Issues:
# - 3 test failures
# - Critical config issue (database URL points to localhost)
# - Critical vulnerability (SQL injection)

# Step 2: Fix blocking issues
/todo-check
# → 3 critical todos created
# → Fix each issue

# Step 3: Re-validate
/deploy-validate --env production

# Result: ✅ GO (risk: 15)

# Step 4: Deploy safely
```

---

### Workflow 3: Hotfix Deployment

```bash
# Critical production bug needs immediate fix

# Step 1: Quick validation (skip E2E)
/deploy-validate --env production --quick

# Result: GO (risk: 20)
# - Unit tests: PASS
# - Config: No changes
# - Security: No new issues

# Step 2: Deploy hotfix
git push origin main

# Step 3: Monitor closely
# [Watch for 1 hour]

# Step 4: Run full validation post-deployment
/deploy-validate --env production
# Ensure nothing regressed
```

---

## Integration with Tresor Workflow

### Automatic `/todo-add`
```bash
# Post-deployment fixes → todos
/todo-add "Deploy: Increase database connection pool to 50"
/todo-add "Deploy: Restrict CORS to specific domains"
```

### Integration with `/health-check`
```bash
# After deployment:
/deploy-validate --env production
# → GO decision

# Deploy...

# Verify health post-deployment:
/health-check --env production
# → Confirms deployment succeeded
```

---

## FAQ

### Q: Should I run this for every deployment?

**A:**
- **Production:** YES, ALWAYS (prevent outages)
- **Staging:** YES (catch issues early)
- **Development:** Optional (if team prefers)

### Q: What if tests are already run in CI/CD?

**A:**
```bash
# Skip test execution if CI/CD already ran them
/deploy-validate --skip-tests --env production

# Validation will still check:
# - Configuration safety
# - Security
# - Environment readiness
```

### Q: How long does validation take?

**A:**
- **Quick:** 5-10 minutes (--quick flag)
- **Standard:** 10-15 minutes (default)
- **Comprehensive:** 15-20 minutes (production with E2E)

### Q: What if validation blocks deployment but I need to deploy anyway?

**A:** **NOT RECOMMENDED**, but if absolutely necessary:
```bash
# Review blocking issues first
cat .tresor/deploy-*/phase-3-go-no-go.md

# If you understand the risks:
# Fix critical issues, then re-validate
# Never deploy with failing tests or critical config issues
```

---

## Troubleshooting

### Issue: "Tests failing in validation but pass locally"

**Cause:** Environment differences

**Solution:**
- Check Node.js/Python version
- Verify dependencies installed
- Check environment variables
- Run tests in same environment as validation

---

### Issue: "Environment readiness check fails"

**Cause:** Infrastructure not healthy

**Solution:**
```bash
# Check specific failures:
kubectl get pods  # Kubernetes
aws ecs describe-services  # ECS

# Fix infrastructure issues before deploying
```

---

### Issue: "Validation takes too long"

**Cause:** Comprehensive E2E tests

**Solution:**
```bash
# Use quick validation for staging
/deploy-validate --env staging --quick

# Or skip E2E tests
/deploy-validate --skip-e2e
```

---

## See Also

- **[/health-check Command](../health-check/)** - Post-deployment health verification
- **[/audit Command](../../security/audit/)** - Security audit
- **[Config Safety Reviewer Agent](../../../subagents/core/config-safety-reviewer/)** - Configuration expert

---

**Version:** 2.7.0
**Last Updated:** November 19, 2025
**Category:** Operations / Deployment
**License:** MIT
**Author:** Alireza Rezvani
