---
name: deploy-validate
description: Pre-deployment validation with tests, security checks, config safety, and environment readiness verification
argument-hint: [--env staging,production] [--skip-tests] [--quick]
allowed-tools: Task, Read, Write, Edit, Bash, Glob, Grep, SlashCommand, AskUserQuestion
model: inherit
enabled: true
---

# Deploy Validation - Pre-Deployment Safety Checks

You are an expert deployment orchestrator managing comprehensive pre-deployment validation using Tresor's operations and safety agents. Your goal is to prevent production outages by validating all critical aspects before deployment.

## Command Purpose

Perform comprehensive pre-deployment validation with:
- **Test suite execution** - All tests must pass
- **Security validation** - No critical vulnerabilities
- **Configuration safety** - Prevent config-related outages
- **Database migration validation** - Safe schema changes
- **Dependency verification** - No breaking dependency changes
- **Build validation** - Production build succeeds
- **Environment readiness** - Target environment is prepared
- **Rollback plan verification** - Ensure safe rollback path

---

## Execution Flow

### Phase 0: Deployment Planning

**Step 1: Parse Arguments**
```javascript
const args = parseArguments($ARGUMENTS);
// --env: staging, production (default: detect from git branch)
// --skip-tests: Skip test execution (NOT recommended)
// --quick: Fast validation (skip non-critical checks)
```

**Step 2: Detect Deployment Context**

Analyze current deployment:
```javascript
const deployContext = await detectDeploymentContext();

// Git context:
// - Current branch
// - Target branch (main, production, staging)
// - Commits since last deployment
// - Changed files

// Environment context:
// - Target environment (staging, production)
// - Infrastructure (K8s, ECS, EC2, serverless)
// - Database (migration pending?)
// - Dependencies (package changes?)

// Example output:
{
  git: {
    branch: 'feature/user-auth',
    targetBranch: 'main',
    commits: 15,
    changedFiles: 47
  },
  environment: {
    target: 'production',
    infrastructure: 'kubernetes',
    databaseMigrations: 2,  // 2 pending migrations
    dependencyChanges: 3    // 3 packages upgraded
  },
  scope: {
    backend: true,
    frontend: true,
    database: true,
    infrastructure: false
  }
}
```

**Step 3: Select Validation Agents**

Based on deployment scope and environment:

```javascript
function selectValidators(deployContext, env) {
  const validators = {
    // Phase 1: Parallel Pre-Deployment Validation (max 3 agents)
    phase1: {
      required: [
        '@test-engineer',          // Run test suite
        '@config-safety-reviewer', // Validate configs
      ],

      conditional: [
        deployContext.scope.backend ? '@security-auditor' : null,
        deployContext.databaseMigrations > 0 ? '@database-migration-validator' : null,
        env === 'production' ? '@production-readiness-checker' : null,
      ].filter(Boolean),

      max: 3, // Parallel limit
    },

    // Phase 2: Environment Readiness (sequential)
    phase2: {
      required: [
        '@devops-engineer',  // Infrastructure validation
      ],

      conditional: [
        deployContext.infrastructure === 'kubernetes' ? '@kubernetes-deployment-expert' : null,
        deployContext.infrastructure === 'aws' ? '@aws-deployment-specialist' : null,
      ].filter(Boolean),

      max: 2,
    },

    // Phase 3: Final Safety Check (sequential)
    phase3: {
      required: env === 'production' ? [
        '@deployment-safety-officer',  // Final go/no-go decision
      ] : [],

      max: 1,
    },
  };

  return selectOptimalAgents(validators);
}
```

**Step 4: User Confirmation**

```javascript
await AskUserQuestion({
  questions: [{
    question: "Deploy validation plan ready. Proceed?",
    header: "Confirm Validation",
    multiSelect: false,
    options: [
      {
        label: "Execute validation",
        description: `${env} deployment, ${changedFiles} files, ${commits} commits, ${validators} agents`
      },
      {
        label: "Quick validation",
        description: "Skip non-critical checks (faster but less safe)"
      },
      {
        label: "Review changes first",
        description: "See git diff before validating"
      },
      {
        label: "Cancel",
        description: "Exit without validating"
      }
    ]
  }]
});
```

---

### Phase 1: Parallel Pre-Deployment Validation (3 agents max)

**Agents** (up to 3):
- `@test-engineer` (always)
- `@config-safety-reviewer` (always)
- `@security-auditor` (if backend changes)

**Execution**:
```javascript
const phase1Results = await Promise.all([
  // Agent 1: Test Suite Execution
  Task({
    subagent_type: 'test-engineer',
    description: 'Run complete test suite',
    prompt: `
# Deploy Validation - Phase 1: Test Suite Execution

## Context
- Environment: ${env}
- Changed Files: ${changedFiles.length}
- Deploy ID: deploy-${timestamp}

## Your Task
Run complete test suite and verify all tests pass:

### 1. Unit Tests
\`\`\`bash
# Run unit tests
npm test                    # JavaScript
pytest                      # Python
mvn test                    # Java
go test ./...              # Go

# Requirements:
# - ALL tests must pass
# - Coverage must be ≥ 80% (or existing baseline)
# - No new tests skipped
\`\`\`

### 2. Integration Tests
\`\`\`bash
# Run integration tests
npm run test:integration
pytest tests/integration/

# Verify:
# - API endpoints work
# - Database interactions succeed
# - Third-party integrations functional
\`\`\`

### 3. End-to-End Tests
\`\`\`bash
# Run E2E tests (if applicable)
npm run test:e2e
playwright test
cypress run

# Verify critical user flows work end-to-end
\`\`\`

### 4. Regression Tests

Check if changed files have tests:
\`\`\`bash
# For each changed file, verify tests exist
# Example for src/api/users.ts:
# - src/api/users.test.ts should exist
# - Should have tests for modified functions
\`\`\`

### 5. Test Coverage Analysis

\`\`\`bash
# Check coverage hasn't decreased
npm run test:coverage

# Verify:
# - Overall coverage ≥ 80%
# - Changed files have ≥ 80% coverage
# - No coverage regressions
\`\`\`

### Failure Handling

If ANY test fails:
1. **STOP deployment validation immediately**
2. Call /todo-add for each failing test
3. Generate failure report
4. Return status: BLOCKED

### Output Requirements
1. Write results to: .tresor/deploy-${timestamp}/phase-1-tests.md
2. Include: Total tests, passed, failed, coverage %
3. If any failures: Call /todo-add immediately with test details
4. Exit code: 0 (pass) or 1 (fail)

### Success Criteria
- ✅ All unit tests pass
- ✅ All integration tests pass
- ✅ All E2E tests pass (if applicable)
- ✅ Coverage ≥ baseline
- ✅ No new skipped tests

Begin test suite execution.
    `
  }),

  // Agent 2: Configuration Safety Review
  Task({
    subagent_type: 'config-safety-reviewer',
    description: 'Validate configuration changes',
    prompt: `
# Deploy Validation - Phase 1: Configuration Safety Review

## Context
- Environment: ${env}
- Changed Files: ${changedFiles}
- Deploy ID: deploy-${timestamp}

## Your Task
Review ALL configuration changes for production safety:

### 1. Configuration Files to Review

**Application Config:**
- config/database.js, config/database.yml
- config/redis.js, config/cache.yml
- config/api.js, .env.production
- config/auth.js, config/security.yml

**Infrastructure Config:**
- docker-compose.yml
- kubernetes/*.yaml
- terraform/*.tf
- cloudformation/*.yml

**CI/CD Config:**
- .github/workflows/*.yml
- .gitlab-ci.yml
- Jenkinsfile

### 2. Critical Configuration Checks

**Database Configuration:**
\`\`\`javascript
// CRITICAL CHECKS:
// ✓ Connection pool size (min: 10, max: 100)
// ✓ Connection timeout (> 5s, < 30s)
// ✓ Query timeout (> 10s, < 60s)
// ✓ Max connections (< 80% of database max)
// ✓ SSL mode (require, verify-full for production)

// Example review:
{
  pool: {
    min: 10,     // ✓ Good
    max: 20,     // ⚠️ Too low for production (recommend 50)
  },
  connectionTimeoutMillis: 5000,  // ✓ Good
  idleTimeoutMillis: 10000,       // ✓ Good
  ssl: { rejectUnauthorized: true }  // ✓ Good for production
}
\`\`\`

**API Configuration:**
\`\`\`javascript
// CRITICAL CHECKS:
// ✓ Rate limiting enabled
// ✓ CORS configured correctly
// ✓ Request size limits set
// ✓ Timeout values reasonable
// ✗ No hardcoded URLs
// ✗ No magic numbers

// Example issue:
{
  timeout: 30000,  // ⚠️ Magic number (define as TIMEOUT_MS constant)
  maxRequestSize: '10mb',  // ✓ Good
  cors: {
    origin: '*'  // ✗ CRITICAL: Too permissive for production
  }
}
\`\`\`

**Environment Variables:**
\`\`\`bash
# Check .env.production for:
# ✓ No hardcoded secrets
# ✓ All required variables defined
# ✓ No development values
# ✗ No exposed API keys

# Example check:
DATABASE_URL=postgresql://user:pass@localhost:5432/db  # ✗ localhost in production!
API_KEY=sk_test_xxx  # ✗ Test API key in production config!
\`\`\`

### 3. Configuration Changes Analysis

**For each changed config file:**
\`\`\`bash
git diff main...HEAD -- config/

# Analyze each change:
# - Why was this changed?
# - What's the impact?
# - Is the new value safe for ${env}?
# - Does it match infrastructure capacity?
\`\`\`

**Red Flags:**
- Connection pool > database max_connections
- Timeout values too low (< 5s)
- Timeout values too high (> 60s)
- Hardcoded IPs or URLs
- Magic numbers without constants
- Development values in production config
- Disabled security features

### 4. Infrastructure Capacity Validation

**Check configuration matches infrastructure:**
\`\`\`javascript
// Example: Connection pool vs RDS max_connections
const appConfig = { pool: { max: 100 } };
const rdsConfig = { max_connections: 100 };

// ✗ CRITICAL: 100 app connections = 100% of RDS capacity
// ✓ Recommendation: app pool max should be ≤ 80% of RDS max_connections
\`\`\`

### 5. Deployment-Specific Config Validation

**For Production Deployments (env === 'production'):**
- [ ] DEBUG mode disabled
- [ ] Verbose logging disabled (or log level ≥ INFO)
- [ ] Source maps disabled
- [ ] API keys are production keys (not test/dev)
- [ ] Database is production database
- [ ] CORS is restrictive (not '*')
- [ ] HTTPS enforced
- [ ] Security headers enabled

### Failure Handling

If ANY critical config issue found:
1. **BLOCK deployment**
2. Call /todo-add with specific config fix
3. Generate detailed config review report
4. Return status: BLOCKED

### Output Requirements
1. Write findings to: .tresor/deploy-${timestamp}/phase-1-config-safety.md
2. For each critical issue: Call /todo-add
3. Include before/after config values
4. Exit code: 0 (safe) or 1 (blocked)

### Success Criteria
- ✅ No hardcoded secrets or URLs
- ✅ All timeout values reasonable
- ✅ Connection pools match infrastructure
- ✅ Environment-specific configs correct
- ✅ No magic numbers in production
- ✅ Security features enabled

Begin configuration safety review.
    `
  }),

  // Agent 3: Security Pre-Deployment Check
  deployContext.scope.backend ? Task({
    subagent_type: 'security-auditor',
    description: 'Pre-deployment security check',
    prompt: `
# Deploy Validation - Phase 1: Security Pre-Deployment Check

## Context
- Environment: ${env}
- Changed Files: ${changedFiles}
- Deploy ID: deploy-${timestamp}

## Your Task
Quick security validation before deployment:

### 1. Critical Vulnerability Scan

Run fast security scan on changed files only:
\`\`\`bash
# Scan changed files for critical vulnerabilities
git diff --name-only main...HEAD | while read file; do
  # Check for:
  # - Hardcoded credentials
  # - Exposed API keys
  # - SQL injection patterns
  # - XSS vulnerabilities
  # - Insecure dependencies
done
\`\`\`

### 2. Dependency Security

\`\`\`bash
# Check for critical CVEs
npm audit --audit-level=critical
pip-audit --vulnerability-service osv

# If critical vulnerabilities found:
# - BLOCK deployment
# - Call /todo-add for each CVE
\`\`\`

### 3. Secret Scanning

\`\`\`bash
# Scan for exposed secrets
grep -r "api[-_]key.*=.*['\"]sk_" .
grep -r "secret.*=.*['\"][a-zA-Z0-9]{32}" .
grep -r "password.*=.*['\"]" config/

# Check .env files not committed
git diff --name-only | grep -E "^\.env"
\`\`\`

### 4. Authentication/Authorization Changes

If auth code changed:
- [ ] Session configuration safe
- [ ] Password hashing not weakened
- [ ] JWT signing key not hardcoded
- [ ] Token expiration appropriate
- [ ] RBAC changes don't break access

### 5. OWASP Quick Check

Fast scan for critical OWASP issues:
- [ ] No SQL injection (parameterized queries)
- [ ] No XSS (output escaping)
- [ ] No insecure deserialization
- [ ] No XXE (XML parsing)
- [ ] No authentication bypass

### Failure Handling

If critical security issue found:
1. **BLOCK deployment**
2. Call /todo-add for each issue
3. Run full /vulnerability-scan for comprehensive analysis
4. Return status: BLOCKED

### Output Requirements
1. Write findings to: .tresor/deploy-${timestamp}/phase-1-security.md
2. For each CRITICAL issue: Call /todo-add and BLOCK
3. For HIGH issues: Warn but allow deployment (if --force)
4. Exit code: 0 (safe) or 1 (blocked)

Begin security pre-deployment check.
    `
  }) : null,
].filter(Boolean));

// Progress update
await TodoWrite({
  todos: [
    { content: "Phase 1: Pre-Deployment Validation", status: "completed", activeForm: "Pre-deployment validation completed" },
    { content: "Phase 2: Environment Readiness", status: "in_progress", activeForm: "Checking environment readiness" },
    { content: "Phase 3: Final Safety Check", status: "pending", activeForm: "Performing final safety check" }
  ]
});
```

**Auto-Block Deployment if Issues Found**:
```javascript
// If any critical issue in Phase 1
if (hasCriticalIssues(phase1Results)) {
  return {
    status: 'BLOCKED',
    reason: 'Critical issues found',
    issues: criticalIssues,
    message: '❌ Deployment BLOCKED - Fix critical issues before deploying'
  };
}
```

---

### Phase 2: Environment Readiness Validation (Sequential)

**Agent**:
- `@devops-engineer`

**Execution**:
```javascript
// Only proceed if Phase 1 passed
if (phase1Results.status === 'PASS') {
  const phase2Results = await Task({
    subagent_type: 'devops-engineer',
    description: 'Validate environment readiness',
    prompt: `
# Deploy Validation - Phase 2: Environment Readiness

## Context
- Target Environment: ${env}
- Infrastructure: ${deployContext.infrastructure}
- Deploy ID: deploy-${timestamp}

## Your Task
Validate target environment is ready for deployment:

### 1. Infrastructure Health Check

**Application Servers:**
\`\`\`bash
# Check server health
curl -f https://${env}.example.com/health || exit 1

# Verify:
# - All instances healthy
# - CPU < 70%
# - Memory < 80%
# - Disk < 85%
\`\`\`

**Kubernetes (if applicable):**
\`\`\`bash
# Check cluster health
kubectl get nodes
kubectl get pods --all-namespaces

# Verify:
# - All nodes Ready
# - No pods in CrashLoopBackOff
# - Sufficient resources available
\`\`\`

**Load Balancer:**
\`\`\`bash
# Check all targets healthy
aws elb describe-target-health --target-group-arn xxx

# Verify:
# - All targets in service
# - No draining targets
# - Health checks passing
\`\`\`

### 2. Database Readiness

**Connection Test:**
\`\`\`bash
# Test database connectivity
psql -h ${DB_HOST} -U ${DB_USER} -d ${DB_NAME} -c "SELECT 1;"

# Verify:
# - Database accessible
# - Credentials correct
# - Connection pool available
\`\`\`

**Migration Validation:**
\`\`\`bash
# If migrations pending (${deployContext.databaseMigrations} found):
# 1. Dry-run migrations in staging
# 2. Verify no destructive operations (DROP, TRUNCATE)
# 3. Check migration reversibility
# 4. Estimate migration duration
# 5. Verify no downtime required
\`\`\`

**Backup Verification:**
\`\`\`bash
# Ensure recent backup exists
# Before applying migrations:
# - Latest backup < 24 hours old
# - Backup restoration tested
# - Point-in-time recovery available
\`\`\`

### 3. Dependency Availability

**External Services:**
\`\`\`bash
# Verify all external dependencies are up
curl -f https://api.stripe.com/healthcheck
curl -f https://api.sendgrid.com/v3/health
curl -f https://api.auth0.com/.well-known/openid-configuration

# For each service:
# - Must be reachable
# - Response time < 1s
# - No degraded status
\`\`\`

**Third-Party APIs:**
- Check API keys valid for ${env}
- Verify rate limits sufficient
- Confirm service SLA status

### 4. Resource Capacity

**Check sufficient capacity for deployment:**
\`\`\`bash
# CPU capacity
current_cpu=$(get_cpu_usage)
# Require: < 70% before deployment (headroom for traffic spike)

# Memory capacity
current_memory=$(get_memory_usage)
# Require: < 75% before deployment

# Database connections
current_connections=$(get_db_connections)
max_connections=$(get_max_connections)
# Require: < 60% utilization
\`\`\`

### 5. Deployment Window

**For Production:**
- [ ] Deployment during maintenance window?
- [ ] Off-peak hours? (recommended)
- [ ] Team available for monitoring?
- [ ] Rollback plan prepared?

### 6. Recent Incidents

**Check for recent issues:**
\`\`\`bash
# No recent incidents in ${env}?
# - Last 24 hours: No outages
# - Last 7 days: No major incidents
# - No ongoing incidents

# If recent incidents:
# - BLOCK deployment
# - Wait for stability (24-48 hours)
\`\`\`

### Failure Handling

If environment not ready:
1. **BLOCK deployment**
2. List specific readiness issues
3. Provide remediation steps
4. Suggest retry time

### Output Requirements
1. Write findings to: .tresor/deploy-${timestamp}/phase-2-environment.md
2. Include infrastructure health metrics
3. Verify rollback plan exists
4. Exit code: 0 (ready) or 1 (not ready)

Begin environment readiness validation.
    `
  });

  // Update progress
  await TodoWrite({
    todos: [
      { content: "Phase 1: Pre-Deployment Validation", status: "completed", activeForm: "Pre-deployment validation completed" },
      { content: "Phase 2: Environment Readiness", status: "completed", activeForm: "Environment readiness validated" },
      { content: "Phase 3: Final Safety Check", status: "in_progress", activeForm: "Performing final safety check" }
    ]
  });
}
```

---

### Phase 3: Final Safety Check & Go/No-Go Decision (Sequential)

**Agent** (Production only):
- `@deployment-safety-officer`

**Execution**:
```javascript
// Only for production deployments
if (env === 'production') {
  const phase3Results = await Task({
    subagent_type: 'deployment-safety-officer',
    description: 'Final go/no-go decision',
    prompt: `
# Deploy Validation - Phase 3: Final Safety Check

## Complete Validation Results
${await Read({ file_path: `.tresor/deploy-${timestamp}/phase-1-*.md` })}
${await Read({ file_path: `.tresor/deploy-${timestamp}/phase-2-environment.md` })}

## Your Task
Make final go/no-go decision for production deployment:

### 1. Review All Validation Results

**Test Results:**
- Unit tests: ${unitTestResults}
- Integration tests: ${integrationTestResults}
- Coverage: ${coveragePercentage}%

**Configuration Safety:**
- Critical issues: ${configCriticalIssues}
- Warnings: ${configWarnings}

**Security:**
- Critical vulnerabilities: ${criticalVulns}
- High vulnerabilities: ${highVulns}

**Environment Readiness:**
- Infrastructure health: ${infraHealth}
- Resource capacity: ${resourceCapacity}
- External dependencies: ${externalDepsStatus}

### 2. Risk Assessment

**Deployment Risk Level:**
\`\`\`javascript
function calculateRisk() {
  let riskScore = 0;

  // Test failures
  if (failedTests > 0) riskScore += 100;  // CRITICAL

  // Critical config issues
  riskScore += criticalConfigIssues * 50;

  // Critical vulnerabilities
  riskScore += criticalVulns * 50;

  // Changed files
  riskScore += Math.min(changedFiles * 0.5, 20);

  // Database migrations
  riskScore += databaseMigrations * 10;

  // Recent incidents
  if (recentIncidents > 0) riskScore += 30;

  // Environment instability
  if (cpuUsage > 80) riskScore += 20;

  return riskScore;
}

// Risk levels:
// 0-20: LOW (safe to deploy)
// 21-50: MEDIUM (deploy with caution)
// 51-100: HIGH (not recommended)
// 100+: CRITICAL (BLOCK deployment)
\`\`\`

### 3. Rollback Plan Verification

**Ensure safe rollback:**
- [ ] Previous version healthy in ${env}
- [ ] Rollback script exists and tested
- [ ] Database migrations are reversible
- [ ] Zero-downtime rollback possible
- [ ] Rollback can complete in < 5 minutes

**Rollback Test:**
\`\`\`bash
# Verify rollback process
# 1. Can quickly revert to previous deployment
# 2. Database rollback script exists (if migrations)
# 3. No data loss on rollback
\`\`\`

### 4. Deployment Checklist

**Final Pre-Deployment Checklist:**
- [ ] All tests pass ✓
- [ ] No critical config issues ✓
- [ ] No critical security vulnerabilities ✓
- [ ] Environment healthy ✓
- [ ] Sufficient resource capacity ✓
- [ ] Rollback plan prepared ✓
- [ ] Team available for monitoring ✓
- [ ] During approved deployment window ✓

### 5. Go/No-Go Decision

**Decision Matrix:**
\`\`\`javascript
if (riskScore < 20 && allChecksPassed) {
  return {
    decision: 'GO',
    confidence: 'HIGH',
    message: '✅ Safe to deploy'
  };
} else if (riskScore < 50 && noBlockingIssues) {
  return {
    decision: 'GO WITH CAUTION',
    confidence: 'MEDIUM',
    message: '⚠️ Deploy with enhanced monitoring',
    recommendations: ['Monitor closely for 1 hour', 'Have team on standby']
  };
} else {
  return {
    decision: 'NO-GO',
    confidence: 'HIGH',
    message: '❌ BLOCK deployment - Critical issues found',
    blockingIssues: criticalIssues
  };
}
\`\`\`

### Output Requirements
1. Write decision to: .tresor/deploy-${timestamp}/phase-3-go-no-go.md
2. Include risk score and rationale
3. If NO-GO: List all blocking issues
4. If GO: Provide post-deployment monitoring checklist

Begin final safety check and go/no-go decision.
    `
  });

  await TodoWrite({
    todos: [
      { content: "Phase 1: Pre-Deployment Validation", status: "completed", activeForm: "Pre-deployment validation completed" },
      { content: "Phase 2: Environment Readiness", status: "completed", activeForm: "Environment readiness validated" },
      { content: "Phase 3: Final Safety Check", status: "completed", activeForm: "Final safety check completed" }
    ]
  });
}
```

---

### Phase 4: Final Output & Deployment Decision

**User Summary**:
```markdown
# Deploy Validation Complete! 🚀

**Deploy ID**: deploy-2025-11-19-190322
**Environment**: Production
**Changed Files**: 47 files
**Commits**: 15 commits
**Duration**: 15 minutes

## Validation Results

### ✅ Tests - PASS
- Unit tests: 247 passed, 0 failed ✓
- Integration tests: 45 passed, 0 failed ✓
- E2E tests: 12 passed, 0 failed ✓
- Coverage: 84% (baseline: 82%) ✓

### ⚠️ Configuration Safety - WARNINGS
- Critical issues: 0 ✓
- Warnings: 2 ⚠️
  1. Connection pool max = 20 (recommend 50 for production)
  2. CORS origin = '*' (should be restrictive)

### ✅ Security - PASS
- Critical vulnerabilities: 0 ✓
- High vulnerabilities: 1 ⚠️
  - lodash@4.17.20 (non-critical, can deploy)
- Secrets: No exposed secrets ✓

### ✅ Environment - READY
- Infrastructure: All nodes healthy ✓
- Database: Accessible, 2 migrations pending ✓
- External dependencies: All reachable ✓
- Resource capacity: CPU 45%, Memory 60% ✓

### ⚠️ Risk Assessment

**Risk Score**: 35 / 100 (MEDIUM)

**Risk Breakdown:**
- Tests: 0 (all passed)
- Config warnings: +10 (2 non-critical warnings)
- Security: +5 (1 high vuln, non-blocking)
- Changed files: +15 (47 files changed)
- Database migrations: +5 (2 migrations)

**Risk Level**: MEDIUM

## Go/No-Go Decision

### ✅ **GO WITH CAUTION**

**Confidence**: Medium
**Rationale**:
- All critical checks passed ✓
- Minor config warnings can be addressed post-deployment
- Non-critical security issue (lodash) can be upgraded after deployment
- Environment is healthy and ready

**Deployment Approved** with the following conditions:

### Post-Deployment Monitoring Checklist

**First 30 Minutes (Critical Window):**
- [ ] Monitor error rates (target: < 1%)
- [ ] Monitor API latency (P95 < 500ms)
- [ ] Monitor database connection pool
- [ ] Check application logs for errors
- [ ] Verify health endpoints respond

**First 2 Hours:**
- [ ] Monitor Core Web Vitals (LCP, FID, CLS)
- [ ] Check for memory leaks
- [ ] Verify database migrations applied successfully
- [ ] Monitor business metrics (signups, conversions)

**First 24 Hours:**
- [ ] Review aggregated error logs
- [ ] Check for any anomalies
- [ ] Validate all user flows working
- [ ] Monitor third-party integrations

### Rollback Plan

**If Issues Detected:**
\`\`\`bash
# Quick rollback (< 5 minutes):
kubectl rollout undo deployment/app  # Kubernetes
git revert HEAD && git push          # Simple revert

# Database rollback (if migrations applied):
# Run: .tresor/deploy-${timestamp}/migrations/rollback.sql
\`\`\`

**Rollback Triggers:**
- Error rate > 5%
- P95 latency > 2x baseline
- Critical functionality broken
- Database corruption

### Warnings to Address Post-Deployment

Created 2 todos for post-deployment fixes:

1. **Increase connection pool for production** - #deploy-001
   - Current: max = 20
   - Recommended: max = 50
   - Priority: HIGH (before next spike)
   - Effort: 1 hour

2. **Restrict CORS configuration** - #deploy-002
   - Current: origin = '*'
   - Recommended: Whitelist specific domains
   - Priority: MEDIUM
   - Effort: 30 minutes

## Reports Generated

All reports saved to `.tresor/deploy-2025-11-19-190322/`:
- `phase-1-tests.md` - Test execution results
- `phase-1-config-safety.md` - Configuration review
- `phase-1-security.md` - Security pre-deployment check
- `phase-2-environment.md` - Environment readiness
- `phase-3-go-no-go.md` - Final decision rationale
- `deployment-checklist.md` - Pre/post deployment checklist
- `rollback-plan.md` - Detailed rollback instructions

## Deployment Commands

**To proceed with deployment:**
\`\`\`bash
# Production deployment
kubectl apply -f k8s/production/

# Or
git push origin main  # Triggers CI/CD

# Monitor:
kubectl logs -f deployment/app
kubectl get pods -w
\`\`\`

## Next Steps

1. ✅ **Deploy to production** (risk: MEDIUM, approved)
2. ⏱️ **Monitor for 2 hours** (use post-deployment checklist)
3. 📊 **Track metrics** (error rate, latency, business KPIs)
4. 🔧 **Fix post-deployment warnings** (2 todos created)
5. ✅ **Run /health-check** after deployment to verify
```

---

## Integration with Other Commands

### `/vulnerability-scan` Integration
```javascript
// If security issues found, suggest full scan
if (hasSecurityIssues) {
  console.log("⚠️ Security issues detected. For comprehensive analysis:");
  console.log("Run: /vulnerability-scan --depth deep");
}
```

### `/audit` Integration
```javascript
// For production deployments, suggest periodic audits
if (env === 'production' && lastAudit > 90days) {
  console.log("ℹ️ Last security audit was 90+ days ago.");
  console.log("Recommend: /audit after deployment");
}
```

---

## Command Options

### `--env`
```bash
/deploy-validate --env staging       # Staging deployment
/deploy-validate --env production    # Production deployment (stricter)
/deploy-validate                     # Auto-detect from git branch
```

### `--skip-tests`
```bash
/deploy-validate --skip-tests   # ⚠️ NOT RECOMMENDED
# Skips test execution (faster but risky)
# Only use for hotfixes or if tests run in CI/CD
```

### `--quick`
```bash
/deploy-validate --quick
# Fast validation (5-10 minutes):
# - Runs critical checks only
# - Skips E2E tests
# - Skips comprehensive security scan
# - Good for staging deployments
```

---

## Deployment Gates by Environment

### Staging Deployment
- ✅ Unit tests pass
- ✅ Basic config safety
- ⚠️ Security warnings allowed
- ⚠️ Environment health not critical

**Risk Tolerance:** Higher (can deploy with warnings)

---

### Production Deployment
- ✅ ALL tests pass (unit, integration, E2E)
- ✅ Zero critical config issues
- ✅ Zero critical security vulnerabilities
- ✅ Environment 100% healthy
- ✅ Rollback plan verified
- ✅ Team available for monitoring

**Risk Tolerance:** Very low (block on any critical issue)

---

## Success Criteria

Deployment validation succeeds if:
- ✅ All tests pass (or --skip-tests specified)
- ✅ No critical config issues
- ✅ No critical security vulnerabilities
- ✅ Environment is ready
- ✅ Rollback plan exists
- ✅ Go/No-Go decision made with rationale

---

## Meta Instructions

1. **Safety first** - Block deployment on any critical issue
2. **Be thorough** - Check all aspects before production deploy
3. **Provide rationale** - Explain go/no-go decision
4. **Enable rollback** - Always verify rollback plan
5. **Monitor after deployment** - Provide monitoring checklist
6. **Auto-capture issues** - Use `/todo-add` for post-deployment fixes

---

**Begin pre-deployment validation.**
