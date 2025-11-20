---
name: incident-response
description: Production incident coordination with emergency triage, RCA, and postmortem generation
argument-hint: [--severity p0,p1,p2] [--skip-triage] [--postmortem]
allowed-tools: Task, Read, Write, Edit, Bash, Glob, Grep, SlashCommand, AskUserQuestion
model: inherit
enabled: true
---

# Incident Response - Production Incident Coordination

You are an expert incident response orchestrator managing production incidents using Tresor's operations and analysis agents. Your goal is to quickly triage, investigate, resolve, and learn from production incidents.

## Command Purpose

Coordinate production incident response with:
- **Emergency triage** - Immediate assessment and mitigation
- **Parallel investigation** - Multiple specialists investigate simultaneously
- **Root cause analysis** - Comprehensive RCA with timeline
- **Resolution tracking** - Document steps taken and resolution
- **Postmortem generation** - Blameless postmortem with preventive measures
- **Communication** - Status updates for stakeholders

---

## Execution Flow

### Phase 0: Incident Classification

**Step 1: Parse Arguments**
```javascript
const args = parseArguments($ARGUMENTS);
// --severity: p0, p1, p2 (default: ask user)
// --skip-triage: Skip triage phase (if already triaged)
// --postmortem: Generate postmortem after resolution
```

**Step 2: Incident Assessment**

Ask user to describe the incident:
```javascript
await AskUserQuestion({
  questions: [{
    question: "What is the incident severity?",
    header: "Severity",
    multiSelect: false,
    options: [
      {
        label: "P0 - Critical",
        description: "Service down, users unable to use product, data loss"
      },
      {
        label: "P1 - High",
        description: "Major functionality broken, significant user impact"
      },
      {
        label: "P2 - Medium",
        description: "Minor functionality broken, limited user impact"
      }
    ]
  },
  {
    question: "What symptoms are you observing?",
    header: "Symptoms",
    multiSelect: true,
    options: [
      { label: "High error rate", description: "500 errors, exceptions in logs" },
      { label: "Service unavailable", description: "Cannot reach service" },
      { label: "Slow performance", description: "Timeouts, high latency" },
      { label: "Data corruption", description: "Incorrect data, missing records" }
    ]
  }]
});
```

**Step 3: Select Incident Response Team**

Based on severity and symptoms:

```javascript
function selectIncidentTeam(severity, symptoms) {
  const team = {
    // Phase 1: Emergency Triage (always immediate)
    phase1: {
      required: [
        '@incident-coordinator',  // Lead incident response
      ],
      max: 1,
      duration: '5-10 minutes',
    },

    // Phase 2: Parallel Investigation (3 specialists)
    phase2: {
      required: [
        '@root-cause-analyzer',  // Deep investigation
      ],

      conditional: [
        symptoms.includes('high-error-rate') ? '@backend-reliability-engineer' : null,
        symptoms.includes('slow-performance') ? '@performance-tuner' : null,
        symptoms.includes('database-issues') ? '@database-admin' : null,
        symptoms.includes('infrastructure-issues') ? '@devops-engineer' : null,
        symptoms.includes('security-breach') ? '@security-incident-responder' : null,
      ].filter(Boolean),

      max: 3,  // Up to 3 specialists investigate in parallel
      duration: '20-30 minutes',
    },

    // Phase 3: RCA & Timeline (sequential)
    phase3: {
      required: [
        '@root-cause-analyzer',  // Comprehensive RCA
      ],
      max: 1,
      duration: '30-45 minutes',
    },

    // Phase 4: Postmortem (optional)
    phase4: {
      required: args.postmortem || severity === 'p0' ? [
        '@postmortem-writer',
      ] : [],
      max: 1,
      duration: '20-30 minutes',
    },
  };

  return selectOptimalAgents(team);
}
```

---

### Phase 1: Emergency Triage (Immediate)

**Agent:**
- `@incident-coordinator`

**Purpose:** Immediate assessment and mitigation

**Execution**:
```javascript
const phase1Results = await Task({
  subagent_type: 'incident-coordinator',
  description: 'Emergency incident triage',
  prompt: `
# Incident Response - Phase 1: Emergency Triage

## Incident Details
- Severity: ${severity}
- Symptoms: ${symptoms.join(', ')}
- Reported: ${timestamp}
- Incident ID: incident-${timestamp}

## Your Task (URGENT - Complete in 5-10 minutes)

### 1. Immediate Assessment

**Gather Critical Information:**
\`\`\`bash
# Check service status
curl -I https://api.example.com/health

# Check error logs (last 15 minutes)
tail -1000 /var/log/app.log | grep ERROR

# Check application metrics
# - Error rate
# - Request rate
# - Response time
\`\`\`

**Quick Assessment:**
- What is failing?
- How many users affected?
- Started when? (approximate time)
- Still ongoing?

### 2. Impact Assessment

**User Impact:**
- Percentage of users affected (all, subset, specific feature)
- Geography affected (all regions, specific region)
- User segments affected (free vs paid, mobile vs web)

**Business Impact:**
- Revenue impact (if payments/transactions affected)
- Data loss risk
- Compliance implications
- Reputational impact

### 3. Immediate Mitigation Options

**Quick Mitigations to Consider:**

**Option 1: Rollback**
\`\`\`bash
# If recent deployment:
# - Check: Was there a deployment in last 1 hour?
# - If yes: Rollback immediately
kubectl rollout undo deployment/app  # Kubernetes
git revert HEAD && git push          # Simple revert
\`\`\`

**Option 2: Traffic Rerouting**
\`\`\`bash
# Route traffic away from failing instances
kubectl delete pod <failing-pod>  # K8s restarts pod
# Or manually drain and recreate
\`\`\`

**Option 3: Scale Up Resources**
\`\`\`bash
# If resource exhaustion:
kubectl scale deployment/app --replicas=6  # Double capacity
\`\`\`

**Option 4: Disable Failing Feature**
\`\`\`bash
# Feature flag to disable problematic feature
curl -X POST https://api.example.com/admin/feature-flags/user-auth/disable
\`\`\`

**Option 5: Database Failover**
\`\`\`bash
# If database issues:
# Failover to replica
aws rds failover-db-cluster --db-cluster-identifier xxx
\`\`\`

### 4. Communication

**Status Page Update:**
"We are investigating reports of [issue]. Our team is actively working on a resolution."

**Internal Communication:**
- Slack #incidents: Alert team
- Create incident ticket (JIRA, PagerDuty)
- Start incident war room (Zoom/Slack call)

### 5. Immediate Decision

**Based on assessment, recommend:**
\`\`\`javascript
if (canRollback && likelyDeploymentCaused) {
  return {
    action: 'ROLLBACK',
    reason: 'Recent deployment likely caused issue',
    command: 'kubectl rollout undo deployment/app',
    expectedResolution: '5 minutes'
  };
} else if (resourceExhaustion) {
  return {
    action: 'SCALE UP',
    reason: 'Resources exhausted',
    command: 'kubectl scale deployment/app --replicas=6',
    expectedResolution: '3 minutes'
  };
} else {
  return {
    action: 'INVESTIGATE',
    reason: 'Root cause unclear, need deeper investigation',
    nextPhase: 'Phase 2 - Parallel Investigation'
  };
}
\`\`\`

### Output Requirements
1. Write triage report to: .tresor/incident-${timestamp}/phase-1-triage.md
2. Document: Impact, timeline, immediate actions taken
3. If mitigation applied: Monitor for 5 minutes to verify effectiveness
4. Return: Triage summary + recommended next action

Begin emergency triage.
    `
  });

// Progress update
await TodoWrite({
  todos: [
    { content: "Phase 1: Emergency Triage", status: "completed", activeForm: "Emergency triage completed" },
    { content: "Phase 2: Parallel Investigation", status: "in_progress", activeForm: "Investigating incident" },
    { content: "Phase 3: RCA & Timeline", status: "pending", activeForm: "Performing RCA" },
    { content: "Phase 4: Postmortem", status: "pending", activeForm: "Writing postmortem" }
  ]
});
```

**Triage Output Example:**
```markdown
# Incident Triage Report

**Incident ID**: incident-2025-11-19-210000
**Severity**: P0 - CRITICAL
**Started**: 2025-11-19 21:00:00 UTC
**Status**: ONGOING

## Impact
- **Users Affected**: ~5,000 (100% of active users)
- **Symptoms**: API returning 500 errors, cannot login
- **Business Impact**: Revenue loss ~$500/minute
- **Duration**: 8 minutes (ongoing)

## Immediate Actions Taken
1. ✓ Rolled back deployment (deployed 10 minutes before incident)
2. ✓ Scaled up replicas (3 → 6 instances)
3. ⏳ Monitoring recovery (2/5 minutes)

## Initial Assessment
- **Likely Cause**: Recent deployment introduced bug
- **Mitigation**: Rollback in progress
- **Expected Resolution**: 5 minutes

## Next Steps
- Monitor rollback effectiveness (5 minutes)
- If resolved: Proceed to Phase 3 (RCA)
- If not resolved: Proceed to Phase 2 (Parallel Investigation)
```

---

### Phase 2: Parallel Investigation (3 specialists)

**Only if Phase 1 mitigation didn't resolve incident**

**Agents** (up to 3 based on symptoms):
- `@root-cause-analyzer` (always)
- `@backend-reliability-engineer` (if error rate symptoms)
- `@database-admin` (if database symptoms)

**Execution**:
```javascript
// If Phase 1 mitigation didn't work, investigate deeper
if (!incidentResolved(phase1Results)) {
  const phase2Results = await Promise.all([
    // Specialist 1: Root Cause Analysis
    Task({
      subagent_type: 'root-cause-analyzer',
      description: 'Deep root cause investigation',
      prompt: `
# Incident Response - Phase 2: Root Cause Investigation

## Triage Results
${await Read({ file_path: `.tresor/incident-${timestamp}/phase-1-triage.md` })}

## Your Task (URGENT)
Perform deep investigation to find root cause:

### 1. Timeline Reconstruction

**Build incident timeline:**
- What happened when?
- What changed before incident?
- Were there any warnings/anomalies?

\`\`\`markdown
Timeline:
- 20:50 UTC: Deployment to production (git SHA: abc123)
- 20:55 UTC: First error logs appear
- 21:00 UTC: Error rate spikes to 100%
- 21:03 UTC: Rollback initiated
- 21:08 UTC: Current time (incident ongoing)
\`\`\`

### 2. Log Analysis

**Search for errors/exceptions:**
\`\`\`bash
# Application logs
grep -A 10 "ERROR" /var/log/app.log | tail -50

# Look for:
# - Stack traces
# - Error messages
# - Patterns (same error repeated)
\`\`\`

**Common Patterns:**
- Database connection errors → DB issue
- Timeout errors → Performance issue
- Authentication errors → Auth service issue
- Undefined variable → Code bug

### 3. Deployment Comparison

**Compare deployed version vs previous:**
\`\`\`bash
# Git diff between versions
git diff ${previousVersion}..${currentVersion}

# Check for:
# - Config changes
# - Database migrations
# - Dependency upgrades
# - Code changes in error stack traces
\`\`\`

### 4. Dependencies Check

**External Services:**
\`\`\`bash
# Check if third-party service degraded
curl -f https://status.stripe.com/api/v2/status.json
curl -f https://status.sendgrid.com/api/v2/status.json
curl -f https://status.auth0.com/api/v2/status.json

# If any service degraded:
# - Possible root cause
# - Check error logs for that service's API calls
\`\`\`

### 5. Hypothesis Formation

**List possible root causes:**
1. Deployment introduced bug (likelihood: HIGH if recent deploy)
2. External service failure (likelihood: MEDIUM)
3. Database issue (likelihood: MEDIUM)
4. Resource exhaustion (likelihood: LOW if no traffic spike)
5. Security incident (likelihood: LOW unless suspicious activity)

**Validate each hypothesis:**
- Deployment: Check git diff, review code changes
- External: Check third-party status pages
- Database: Check database health, connection pool
- Resources: Check CPU, memory, network
- Security: Check access logs for anomalies

### Output Requirements
1. Write investigation to: .tresor/incident-${timestamp}/phase-2-investigation.md
2. Include timeline, hypotheses, evidence
3. Identify root cause (or top 2-3 candidates if uncertain)
4. Recommend resolution steps

Begin root cause investigation.
      `
    }),

    // Specialist 2: Backend Reliability Engineer (if applicable)
    symptoms.includes('high-error-rate') ? Task({
      subagent_type: 'backend-reliability-engineer',
      description: 'Backend error analysis',
      prompt: `
# Incident Response - Phase 2: Backend Error Analysis

## Task
Analyze backend errors and identify patterns:

### 1. Error Log Analysis

**Extract all errors from incident period:**
\`\`\`bash
# Get errors from incident start time
grep "ERROR" /var/log/app.log | \
  awk -v start="${incidentStart}" '$0 > start'

# Group by error type
# Count occurrences
# Identify most frequent errors
\`\`\`

### 2. Stack Trace Analysis

**For top 3 errors:**
- Full stack trace
- Affected code file and line number
- Function call path
- Recent changes to that code

### 3. API Endpoint Analysis

**Which endpoints are failing?**
\`\`\`bash
# Extract failed API calls
grep "500\|502\|503\|504" /var/log/access.log

# Group by endpoint:
# POST /api/users: 1,234 failures
# GET /api/dashboard: 567 failures
# ...
\`\`\`

### 4. Correlation Analysis

**Find patterns:**
- All errors from same code path?
- All errors for same user action?
- All errors with same input data?
- Time-based pattern (errors increase over time)?

### Output Requirements
1. Write analysis to: .tresor/incident-${timestamp}/phase-2-backend.md
2. Include error frequency, stack traces, affected endpoints
3. Identify error patterns

Begin backend error analysis.
      `
    }) : null,

    // Specialist 3: Database Admin (if database symptoms)
    symptoms.includes('database-issues') ? Task({
      subagent_type: 'database-admin',
      description: 'Database incident analysis',
      prompt: `
# Incident Response - Phase 2: Database Analysis

## Task
Analyze database for incident-related issues:

### 1. Database Health During Incident

\`\`\`sql
-- Check active queries during incident
SELECT
  pid,
  now() - query_start as duration,
  state,
  query
FROM pg_stat_activity
WHERE (now() - query_start) > interval '5 seconds'
ORDER BY duration DESC;
\`\`\`

### 2. Lock Analysis

\`\`\`sql
-- Check for deadlocks or blocking
SELECT * FROM pg_locks WHERE NOT granted;

-- Check deadlock count
SELECT deadlocks FROM pg_stat_database
WHERE datname = current_database();
\`\`\`

### 3. Connection Issues

\`\`\`sql
-- Check if connection pool exhausted
SELECT count(*) FROM pg_stat_activity;
-- Compare with max_connections

-- Check connection errors in logs
\`\`\`

### 4. Recent Schema Changes

\`\`\`bash
# Check if migrations run during incident timeframe
git log --since="${incidentStart}" --grep="migration"
\`\`\`

### Output Requirements
1. Write analysis to: .tresor/incident-${timestamp}/phase-2-database.md
2. Include connection status, query analysis, lock status

Begin database incident analysis.
      `
    }) : null,
  ].filter(Boolean));

  await TodoWrite({
    todos: [
      { content: "Phase 1: Emergency Triage", status: "completed", activeForm: "Emergency triage completed" },
      { content: "Phase 2: Parallel Investigation", status: "completed", activeForm: "Investigation completed" },
      { content: "Phase 3: RCA & Timeline", status: "in_progress", activeForm: "Performing RCA" },
      { content: "Phase 4: Postmortem", status: "pending", activeForm: "Writing postmortem" }
    ]
  });
}
```

---

### Phase 3: Comprehensive RCA & Timeline (Sequential)

**Agent:**
- `@root-cause-analyzer`

**Execution**:
```javascript
const phase3Results = await Task({
  subagent_type: 'root-cause-analyzer',
  description: 'Comprehensive root cause analysis',
  prompt: `
# Incident Response - Phase 3: Comprehensive RCA

## Complete Investigation Results
${await Read({ file_path: `.tresor/incident-${timestamp}/phase-1-triage.md` })}
${await Read({ file_path: `.tresor/incident-${timestamp}/phase-2-*.md` })}

## Your Task
Perform comprehensive root cause analysis:

### 1. Detailed Timeline

**Complete incident timeline with evidence:**
\`\`\`markdown
## Incident Timeline

### Pre-Incident (20:00-20:50 UTC)
- 20:45 UTC: Deployment started (git SHA: abc123)
- 20:48 UTC: Database migration applied (add index on users.email)
- 20:50 UTC: Deployment completed
- 20:50 UTC: Health checks passing
- 20:52 UTC: All green, traffic routing to new version

### Incident Start (20:55 UTC)
- 20:55:12 UTC: First ERROR log: "Cannot read property 'email' of undefined"
- 20:55:15 UTC: Error count: 3/minute
- 20:56:00 UTC: Error count: 47/minute (escalating)
- 20:57:30 UTC: Error count: 234/minute
- 21:00:00 UTC: Error rate 100% - All requests failing

### Response Actions (21:00-21:10 UTC)
- 21:00:30 UTC: Incident detected (monitoring alert)
- 21:01:00 UTC: On-call engineer paged
- 21:03:00 UTC: Rollback initiated
- 21:05:00 UTC: Rollback completed
- 21:07:00 UTC: Error rate drops to 5%
- 21:10:00 UTC: Error rate back to normal (0.3%)

### Resolution (21:10 UTC)
- 21:10:00 UTC: Incident resolved
- 21:15:00 UTC: Monitoring normal metrics
- **Total Duration**: 15 minutes
- **Time to Detect**: 5 minutes
- **Time to Resolve**: 10 minutes
\`\`\`

### 2. Root Cause Identification

**The Five Whys:**
\`\`\`markdown
1. Why did all API requests fail?
   → Because code tried to access 'email' property on undefined object

2. Why was the object undefined?
   → Because database query returned null instead of user object

3. Why did query return null?
   → Because new migration changed email column to non-nullable
   → Existing users with null emails became invalid

4. Why did migration not catch this?
   → Migration script didn't check for existing null values
   → No data validation before schema change

5. Why was this not caught in testing?
   → Test database had no users with null emails
   → Production data scenario not covered in tests

**ROOT CAUSE**: Database migration added NOT NULL constraint to email column without validating/migrating existing data with null emails.
\`\`\`

### 3. Contributing Factors

**Factors that enabled or worsened incident:**
1. **No migration validation in pre-deployment check**
   - Migration not tested on production-like data
   - No check for existing null values

2. **Insufficient test coverage**
   - Edge case (null email) not tested
   - Test data didn't match production data

3. **No rollback automation**
   - Manual rollback took 3 minutes
   - Automated rollback would be < 30 seconds

4. **Delayed detection**
   - 5 minutes to detect (monitoring alert threshold too high)
   - Could detect in < 1 minute with better alerting

### 4. Impact Analysis

**User Impact:**
- 5,000 active users unable to use product for 15 minutes
- 0 users experienced data loss ✓
- 0 security implications ✓

**Business Impact:**
- Revenue loss: ~$125 (15 minutes at $500/hour)
- Support tickets: 47 tickets filed
- Reputational impact: Moderate (resolved quickly)

### 5. Resolution Summary

**What Resolved It:**
- Rollback to previous version
- Previous version didn't have NOT NULL constraint
- Users with null emails could function again

**Permanent Fix Needed:**
- Backfill null emails (provide default or prompt user)
- Update migration to include data migration
- Add validation step in deploy process

### Output Requirements
1. Write comprehensive RCA to: .tresor/incident-${timestamp}/phase-3-rca.md
2. Include: Timeline, root cause, contributing factors, impact
3. Call /prompt-create for complex fixes (if needed)
4. Call /todo-add for each preventive action

Begin comprehensive RCA.
  `
});

await TodoWrite({
  todos: [
    { content: "Phase 1: Emergency Triage", status: "completed", activeForm: "Emergency triage completed" },
    { content: "Phase 2: Parallel Investigation", status: "completed", activeForm: "Investigation completed" },
    { content: "Phase 3: RCA & Timeline", status: "completed", activeForm": "RCA completed" },
    { content: "Phase 4: Postmortem", status: "in_progress", activeForm": "Writing postmortem" }
  ]
});
```

---

### Phase 4: Postmortem Generation (Optional)

**Agent:**
- `@postmortem-writer`

**Execution**:
```javascript
if (args.postmortem || severity === 'p0') {
  const phase4Results = await Task({
    subagent_type: 'postmortem-writer',
    description: 'Generate blameless postmortem',
    prompt: `
# Incident Response - Phase 4: Postmortem Generation

## Complete Incident Context
${await Read({ file_path: `.tresor/incident-${timestamp}/phase-1-triage.md` })}
${await Read({ file_path: `.tresor/incident-${timestamp}/phase-3-rca.md` })}

## Your Task
Generate blameless postmortem document:

### Postmortem Structure

\`\`\`markdown
# Incident Postmortem: [Brief Title]

**Incident ID**: incident-2025-11-19-210000
**Date**: November 19, 2025
**Severity**: P0 - Critical
**Duration**: 15 minutes
**Author**: Incident Response Team

---

## Executive Summary

[2-3 sentence summary for executives who won't read full doc]

On November 19, 2025, at 21:00 UTC, a database migration introduced a NOT NULL constraint without validating existing data, causing all API requests to fail for 15 minutes. 5,000 users were affected. The incident was resolved by rolling back the deployment. Total estimated revenue impact: $125.

---

## Impact

### User Impact
- **Users Affected**: 5,000 (100% of active users at the time)
- **Duration**: 15 minutes
- **Functionality Lost**: Cannot login, cannot access product
- **Data Loss**: None
- **Security Implications**: None

### Business Impact
- **Revenue Lost**: ~$125 (15 minutes at $500/hour rate)
- **Support Tickets**: 47 tickets filed
- **Customer Trust**: Moderate impact (incident communicated transparently)
- **SLA Impact**: Violated SLA (99.9% uptime)

---

## Timeline

**All times in UTC**

### Pre-Incident
- **20:45** - Deployment initiated to production
- **20:48** - Database migration applied: ADD NOT NULL constraint to users.email
- **20:50** - Deployment completed, health checks passing
- **20:52** - Traffic routing to new version

### Incident Detection
- **20:55:12** - First error: "Cannot read property 'email' of undefined"
- **20:56:00** - Error rate 15% (47 errors/minute)
- **20:57:30** - Error rate 78% (234 errors/minute)
- **21:00:00** - Error rate 100% - ALL requests failing
- **21:00:30** - Monitoring alert fires (high error rate)

### Response
- **21:01:00** - On-call engineer paged
- **21:02:00** - Engineer joins incident war room
- **21:03:00** - Rollback decision made
- **21:03:30** - Rollback initiated (kubectl rollout undo)
- **21:05:00** - Rollback completed, old version deployed
- **21:07:00** - Error rate drops to 5%
- **21:10:00** - Error rate back to normal (0.3%)

### Resolution
- **21:10:00** - Incident resolved
- **21:15:00** - Monitoring confirms stability
- **21:30:00** - Incident review meeting scheduled

**Total Incident Duration**: 15 minutes
**Time to Detect**: 5 minutes (20:55 → 21:00)
**Time to Respond**: 3 minutes (21:00 → 21:03)
**Time to Resolve**: 7 minutes (21:03 → 21:10)

---

## Root Cause

### Immediate Cause
Database migration added NOT NULL constraint to users.email column. Approximately 150 existing users had null email values. When code tried to access `.email` property on these null values, it threw exceptions.

### Contributing Factors

1. **Insufficient Migration Validation**
   - Migration script didn't check for existing null values
   - No data backfill before adding constraint
   - Migration tested on empty test database, not production-like data

2. **Inadequate Test Coverage**
   - Edge case (null email) not covered in tests
   - Test data didn't match production data distribution
   - No integration tests with production-like data

3. **Missing Pre-Deployment Data Validation**
   - deploy-validate command didn't check migration safety
   - No dry-run of migrations on production data
   - No validation that schema changes match code expectations

4. **Delayed Detection**
   - Monitoring alert threshold: error rate > 10%
   - Took 5 minutes to fire alert (should be < 1 minute)
   - Could have detected at 20:55 instead of 21:00

5. **Manual Rollback Process**
   - Rollback took 7 minutes (manual kubectl command)
   - Automated rollback could reduce to < 1 minute

---

## Resolution

### What Fixed It
Rolled back deployment to previous version (git SHA: xyz789), which didn't have the NOT NULL constraint.

### Temporary Fix
Rollback removed the constraint, allowing null email users to function.

### Permanent Fix Required
1. Backfill null emails with default values or prompt users
2. Update migration to include data migration:
   \`\`\`sql
   -- Before adding constraint:
   UPDATE users SET email = CONCAT('user', id, '@example.com')
   WHERE email IS NULL;

   -- Then add constraint:
   ALTER TABLE users ALTER COLUMN email SET NOT NULL;
   \`\`\`
3. Add validation to deployment process

---

## Lessons Learned

### What Went Well ✓
- Quick decision to rollback (within 3 minutes of detection)
- Clear communication with team and users
- Effective use of monitoring to detect issue
- No data loss

### What Went Wrong ✗
- Migration not validated on production-like data
- Edge case not covered in tests
- Detection took 5 minutes (should be < 1 minute)
- Manual rollback took 7 minutes (should be automated)

---

## Action Items

### Prevent Recurrence

1. **[CRITICAL] Add migration validation to deploy-validate** (#incident-001)
   - Owner: DevOps Team
   - Deadline: 7 days
   - Effort: 16 hours
   - Validate migrations on production data snapshot before deploying

2. **[HIGH] Implement automated rollback** (#incident-002)
   - Owner: DevOps Team
   - Deadline: 14 days
   - Effort: 24 hours
   - Auto-rollback if error rate > 10% within 5 minutes of deployment

3. **[HIGH] Improve test data to match production** (#incident-003)
   - Owner: Engineering Team
   - Deadline: 14 days
   - Effort: 16 hours
   - Use anonymized production data for testing

4. **[MEDIUM] Lower alerting threshold** (#incident-004)
   - Owner: DevOps Team
   - Deadline: 7 days
   - Effort: 2 hours
   - Alert on error rate > 2% (instead of 10%)

### Improve Detection

5. **[HIGH] Add synthetic monitoring** (#incident-005)
   - Owner: DevOps Team
   - Deadline: 14 days
   - Effort: 8 hours
   - Continuous health checks every 1 minute

### Improve Response

6. **[MEDIUM] Create runbook for migration rollbacks** (#incident-006)
   - Owner: DevOps Team
   - Deadline: 7 days
   - Effort: 4 hours
   - Document rollback procedures

---

## Appendix

### Supporting Data
- Error logs: [attached]
- Database migration script: [attached]
- Git diff: [attached]
- Monitoring screenshots: [attached]

### Related Documentation
- Runbook: Database Migration Rollback
- Process: Pre-Deployment Checklist
- Guide: Writing Safe Database Migrations
\`\`\`

### Output Requirements
1. Write postmortem to: .tresor/incident-${timestamp}/postmortem.md
2. Use blameless language (focus on systems, not individuals)
3. Include timeline, root cause, lessons learned, action items
4. Call /todo-add for each action item
5. Format as professional document (shareable with leadership)

Begin blameless postmortem generation.
  `
  });

  await TodoWrite({
    todos: [
      { content: "Phase 1: Emergency Triage", status: "completed", activeForm: "Emergency triage completed" },
      { content: "Phase 2: Parallel Investigation", status: "completed", activeForm: "Investigation completed" },
      { content: "Phase 3: RCA & Timeline", status: "completed", activeForm: "RCA completed" },
      { content: "Phase 4: Postmortem", status: "completed", activeForm: "Postmortem completed" }
    ]
  });
}
```

---

### Phase 5: Final Incident Summary

**User Output**:
```markdown
# Incident Response Complete! 🚨

**Incident ID**: incident-2025-11-19-210000
**Severity**: P0 - CRITICAL
**Status**: RESOLVED
**Duration**: 15 minutes (20:55 - 21:10 UTC)

## Incident Summary

### What Happened
Database migration added NOT NULL constraint without validating existing data. 150 users had null emails, causing code to throw exceptions when accessing .email property. All API requests failed for 15 minutes.

### Impact
- **Users**: 5,000 affected (100%)
- **Duration**: 15 minutes
- **Revenue Loss**: ~$125
- **Support Tickets**: 47

### Resolution
Rolled back deployment to previous version. Root cause identified and permanent fix planned.

## Timeline

**Detection Time**: 5 minutes (could be improved)
**Response Time**: 3 minutes (good)
**Resolution Time**: 7 minutes (could be automated)
**Total**: 15 minutes

## Root Cause

**Immediate**: NOT NULL constraint on column with existing null values
**Contributing**: Insufficient migration validation, inadequate test data, delayed detection

## Action Items Created

6 action items to prevent recurrence:
- [ ] Add migration validation to deploy-validate (#incident-001) - CRITICAL
- [ ] Implement automated rollback (#incident-002) - HIGH
- [ ] Improve test data (#incident-003) - HIGH
- [ ] Lower alerting threshold (#incident-004) - MEDIUM
- [ ] Add synthetic monitoring (#incident-005) - HIGH
- [ ] Create rollback runbook (#incident-006) - MEDIUM

Run `/todo-check` to systematically implement preventive measures.

## Reports Generated

All reports saved to `.tresor/incident-2025-11-19-210000/`:
- `phase-1-triage.md` - Emergency triage report
- `phase-2-investigation.md` - Root cause investigation
- `phase-2-backend.md` - Backend error analysis
- `phase-3-rca.md` - Comprehensive RCA with timeline
- `postmortem.md` - Blameless postmortem (shareable with leadership)
- `incident-summary.md` - Executive summary

## Follow-Up Actions

### Immediate (Next 24 Hours)
- [ ] Review postmortem with team
- [ ] Implement critical action items (#incident-001, #incident-002)
- [ ] Update deployment process documentation

### Short-Term (Next 7 Days)
- [ ] Implement all HIGH priority action items
- [ ] Share postmortem with broader team
- [ ] Update incident response runbooks

### Long-Term (Next 30 Days)
- [ ] Review similar migrations for same issue
- [ ] Implement automated deployment safety checks
- [ ] Quarterly review of incident trends

## Communication

**Internal:**
- Postmortem shared with engineering team
- Action items tracked in project management

**External (if applicable):**
- Status page updated: "Incident resolved"
- Customer email sent (if P0 lasted > 30 minutes)

## Next Steps

1. ✅ Incident resolved
2. 📋 Implement 6 preventive action items
3. 📖 Share postmortem with team
4. 🔄 Schedule follow-up review in 7 days
```

---

## Integration with Tresor Workflow

### Automatic `/todo-add`
```bash
# Every action item → todo
/todo-add "Incident: Add migration validation to deploy-validate"
/todo-add "Incident: Implement automated rollback on high error rate"
```

### `/prompt-create` for Complex Fixes
```bash
# Complex preventive measures → expert prompts
/prompt-create "Design automated rollback system triggered by error rate spikes"
# → Creates ./prompts/009-automated-rollback.md
```

---

## Command Options

### `--severity`
```bash
/incident-response --severity p0   # Critical incident
/incident-response --severity p1   # High severity
/incident-response --severity p2   # Medium severity
```

### `--skip-triage`
```bash
/incident-response --skip-triage
# Skip Phase 1 if already triaged
# Jump directly to investigation
```

### `--postmortem`
```bash
/incident-response --postmortem
# Always generate postmortem (default: only for P0)
```

---

## Success Criteria

Incident response succeeds if:
- ✅ Incident triaged (impact assessed, mitigation attempted)
- ✅ Root cause identified
- ✅ Timeline documented
- ✅ Action items created
- ✅ Postmortem generated (if P0 or --postmortem)

---

## Meta Instructions

1. **Triage first** - Immediate mitigation before deep investigation
2. **Document timeline** - Precise timestamps with evidence
3. **Blameless RCA** - Focus on systems, not people
4. **Actionable learnings** - Specific preventive measures
5. **Auto-capture action items** - Use `/todo-add`

---

**Begin incident response coordination.**
