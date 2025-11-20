---
name: health-check
description: Comprehensive system health verification for production monitoring and incident detection
argument-hint: [--env staging,production] [--comprehensive] [--alert]
allowed-tools: Task, Read, Write, Edit, Bash, Glob, Grep, SlashCommand, AskUserQuestion
model: inherit
enabled: true
---

# Health Check - System Health Verification

You are an expert systems monitoring orchestrator managing comprehensive health checks using Tresor's operations and reliability agents. Your goal is to verify system health, detect anomalies, and alert on issues before they become outages.

## Command Purpose

Perform comprehensive health verification with:
- **Application health** - All services responding correctly
- **Database health** - Queries executing, connections available
- **Infrastructure health** - CPU, memory, disk, network within limits
- **External dependencies** - Third-party services reachable
- **Business metrics** - Key functionality working (signups, payments, etc.)
- **Anomaly detection** - Detect unusual patterns or degradation
- **Alert generation** - Notify on critical issues

---

## Execution Flow

### Phase 0: Health Check Planning

**Step 1: Parse Arguments**
```javascript
const args = parseArguments($ARGUMENTS);
// --env: staging, production (default: detect)
// --comprehensive: Include business metrics and deep checks (default: false)
// --alert: Generate alerts for issues (default: true)
```

**Step 2: Detect System Components**

Analyze deployed system:
```javascript
const systemComponents = await detectSystemComponents();

// Application:
// - Services running (API, worker, scheduler)
// - Health endpoints
// - Version deployed

// Database:
// - PostgreSQL, MySQL, MongoDB, Redis
// - Connection pools
// - Replication status

// Infrastructure:
// - Kubernetes, ECS, EC2
// - Load balancer
// - CDN

// External:
// - Payment gateway (Stripe)
// - Email service (SendGrid)
// - Auth provider (Auth0)
// - Analytics, monitoring

// Example output:
{
  application: {
    services: ['api', 'worker', 'scheduler'],
    healthEndpoints: ['/health', '/ready'],
    version: 'v2.7.0'
  },
  database: {
    primary: 'postgresql',
    cache: 'redis',
    replication: true
  },
  infrastructure: {
    platform: 'kubernetes',
    loadBalancer: 'aws-alb',
    cdn: 'cloudfront'
  },
  external: {
    payment: 'stripe',
    email: 'sendgrid',
    auth: 'auth0',
    monitoring: 'datadog'
  }
}
```

**Step 3: Select Health Check Agents**

Based on detected components:

```javascript
function selectHealthCheckers(components, comprehensive) {
  const checkers = {
    // Phase 1: Parallel Health Checks (max 3 agents)
    phase1: {
      required: [
        '@backend-reliability-engineer',  // Application health
        '@database-admin',                // Database health
      ],

      conditional: [
        components.infrastructure === 'kubernetes' ? '@kubernetes-sre' : null,
        components.infrastructure === 'aws' ? '@aws-reliability-engineer' : null,
        comprehensive ? '@business-metrics-analyst' : null,
      ].filter(Boolean),

      max: 3,
    },

    // Phase 2: Anomaly Detection (sequential, if comprehensive)
    phase2: {
      required: comprehensive ? [
        '@anomaly-detection-specialist',
      ] : [],

      max: 1,
    },

    // Phase 3: Alert Generation (sequential, if issues found)
    phase3: {
      required: args.alert && hasIssues ? [
        '@incident-coordinator',
      ] : [],

      max: 1,
    },
  };

  return selectOptimalAgents(checkers);
}
```

---

### Phase 1: Parallel Health Verification (3 agents max)

**Agents:**
- `@backend-reliability-engineer` - Application health
- `@database-admin` - Database health
- `@devops-engineer` - Infrastructure health

**Execution**:
```javascript
const phase1Results = await Promise.all([
  // Agent 1: Application Health
  Task({
    subagent_type: 'backend-reliability-engineer',
    description: 'Application health verification',
    prompt: `
# Health Check - Phase 1: Application Health

## Context
- Environment: ${env}
- Services: ${services}
- Health Check ID: health-${timestamp}

## Your Task
Verify application health across all services:

### 1. Health Endpoint Checks

**For Each Service:**
\`\`\`bash
# Check health endpoints
curl -f https://${env}.example.com/health
curl -f https://${env}.example.com/ready

# Expected response:
{
  "status": "healthy",
  "version": "v2.7.0",
  "uptime": "7d 14h 23m",
  "checks": {
    "database": "healthy",
    "redis": "healthy",
    "external_apis": "healthy"
  }
}
\`\`\`

**Verify:**
- [ ] HTTP 200 response
- [ ] Response time < 1s
- [ ] All sub-checks healthy
- [ ] No degraded services

### 2. Service Availability

**Check all services responding:**
\`\`\`bash
# API service
curl -I https://${env}.example.com/api/users

# Worker service
# Check background job processing:
# - Jobs being processed
# - No stuck jobs
# - Queue depth reasonable

# Scheduler service
# Check cron jobs running:
# - Last execution time
# - No failed jobs
\`\`\`

### 3. Error Rate Monitoring

**Check application logs:**
\`\`\`bash
# Last 15 minutes error rate
error_count=$(grep "ERROR" /var/log/app.log | wc -l)
total_requests=$(grep "Request" /var/log/app.log | wc -l)
error_rate=$((error_count * 100 / total_requests))

# Threshold: < 1%
if [ $error_rate -gt 1 ]; then
  echo "⚠️ High error rate: ${error_rate}%"
fi
\`\`\`

### 4. Response Time Metrics

**Check P95/P99 latency:**
\`\`\`bash
# From APM tool (Datadog, New Relic) or logs
p95_latency=$(get_p95_latency_last_15min)
p99_latency=$(get_p99_latency_last_15min)

# Thresholds:
# P95 < 500ms ✓
# P99 < 1s ✓
\`\`\`

### 5. Memory & CPU Usage

**Application Resources:**
\`\`\`bash
# Check resource usage
ps aux | grep node
free -h
df -h

# Verify:
# - CPU < 80%
# - Memory < 85%
# - Disk < 85%
# - No memory leaks (stable over time)
\`\`\`

### 6. Background Jobs Health

**Worker Health:**
- Queue depth reasonable (< 1000 pending jobs)
- No stuck jobs (> 1 hour processing)
- Workers processing jobs (not idle)
- No repeated failures

### Issues to Alert On

**Critical (immediate alert):**
- Service unreachable (HTTP 500/503)
- Error rate > 5%
- CPU > 95%
- Memory > 95%
- Disk > 95%

**Warning (monitor):**
- Error rate > 1%
- P95 latency > 500ms
- CPU > 80%
- Memory > 85%
- Queue depth > 500

### Output Requirements
1. Write findings to: .tresor/health-${timestamp}/phase-1-application.md
2. For each critical issue: Call /todo-add
3. Generate health status summary
4. Exit code: 0 (healthy), 1 (degraded), 2 (critical)

Begin application health verification.
    `
  }),

  // Agent 2: Database Health
  Task({
    subagent_type: 'database-admin',
    description: 'Database health verification',
    prompt: `
# Health Check - Phase 1: Database Health

## Context
- Database: ${database}
- Environment: ${env}
- Health Check ID: health-${timestamp}

## Your Task
Verify database health and performance:

### 1. Connection Test

\`\`\`bash
# Test connectivity
psql -h ${DB_HOST} -U ${DB_USER} -d ${DB_NAME} -c "SELECT 1;"

# Verify:
# - Connection succeeds
# - Response time < 100ms
# - Authentication works
\`\`\`

### 2. Connection Pool Status

\`\`\`sql
-- PostgreSQL: Check active connections
SELECT
  count(*) as total_connections,
  count(*) FILTER (WHERE state = 'active') as active,
  count(*) FILTER (WHERE state = 'idle') as idle,
  count(*) FILTER (WHERE state = 'idle in transaction') as idle_in_transaction
FROM pg_stat_activity
WHERE datname = current_database();

-- Thresholds:
-- total < 80% of max_connections ✓
-- idle_in_transaction = 0 ✓ (indicates connection leaks)
-- active connections reasonable for current traffic
\`\`\`

### 3. Query Performance

\`\`\`sql
-- Check for long-running queries
SELECT
  pid,
  now() - query_start as duration,
  state,
  query
FROM pg_stat_activity
WHERE (now() - query_start) > interval '30 seconds'
  AND state != 'idle'
ORDER BY duration DESC;

-- Alert if:
-- - Any query > 5 minutes (possible deadlock)
-- - Multiple queries > 1 minute (performance issue)
\`\`\`

### 4. Replication Lag

**For Read Replicas:**
\`\`\`sql
-- PostgreSQL: Check replication lag
SELECT
  client_addr,
  state,
  sent_lsn,
  write_lsn,
  flush_lsn,
  replay_lsn,
  sync_state,
  pg_wal_lsn_diff(sent_lsn, replay_lsn) as lag_bytes
FROM pg_stat_replication;

-- Threshold: lag < 10MB ✓
-- Alert if: lag > 100MB (replica falling behind)
\`\`\`

### 5. Database Performance Metrics

**Cache Hit Ratio:**
\`\`\`sql
-- Should be > 99% for production
SELECT
  sum(heap_blks_hit) / (sum(heap_blks_hit) + sum(heap_blks_read)) * 100 as cache_hit_ratio
FROM pg_statio_user_tables;
\`\`\`

**Lock Contention:**
\`\`\`sql
-- Check for blocking queries
SELECT blocked_pid, blocking_pid, blocked_query, blocking_query
FROM [blocking_queries_view];

-- Alert if: Any queries blocked for > 5 seconds
\`\`\`

**Deadlocks:**
\`\`\`sql
-- Check recent deadlocks
SELECT deadlocks FROM pg_stat_database WHERE datname = current_database();

-- Alert if: Deadlocks in last 15 minutes
\`\`\`

### 6. Disk Space

\`\`\`sql
-- Check database size growth
SELECT
  pg_size_pretty(pg_database_size(current_database())) as size;

-- Compare with last health check
-- Alert if: > 80% of disk capacity
-- Alert if: Growth > 10% per day (unusual)
\`\`\`

### 7. Backup Status

\`\`\`bash
# Verify recent backup exists
aws rds describe-db-snapshots --db-instance-identifier mydb \
  --query 'reverse(sort_by(DBSnapshots, &SnapshotCreateTime))[0]'

# Verify:
# - Latest backup < 24 hours old
# - Backup status: available
# - Backup size reasonable
\`\`\`

### Issues to Alert On

**Critical:**
- Cannot connect to database
- Replication lag > 100MB
- Connection pool > 95%
- Disk > 90%
- Long-running queries > 10 minutes

**Warning:**
- Cache hit ratio < 95%
- Connection pool > 80%
- Replication lag > 10MB
- Disk > 80%

### Output Requirements
1. Write findings to: .tresor/health-${timestamp}/phase-1-database.md
2. Include connection pool metrics, cache hit ratio, replication lag
3. For each critical issue: Call /todo-add
4. Exit code: 0 (healthy), 1 (degraded), 2 (critical)

Begin database health verification.
    `
  }),

  // Agent 3: Infrastructure Health
  Task({
    subagent_type: 'devops-engineer',
    description: 'Infrastructure health verification',
    prompt: `
# Health Check - Phase 1: Infrastructure Health

## Context
- Platform: ${infrastructure.platform}
- Environment: ${env}
- Health Check ID: health-${timestamp}

## Your Task
Verify infrastructure health and capacity:

### 1. Container/Pod Health (Kubernetes)

\`\`\`bash
# Check all pods
kubectl get pods --all-namespaces

# Verify:
# - All pods in Running state
# - No CrashLoopBackOff
# - No ImagePullBackOff
# - No pending pods
# - Restart count reasonable (< 5 in last 24h)
\`\`\`

### 2. Node Health

\`\`\`bash
# Check node status
kubectl get nodes

# Verify:
# - All nodes Ready
# - No nodes in NotReady or Unknown state
# - Resource pressure: False (MemoryPressure, DiskPressure)
\`\`\`

### 3. Resource Usage

**CPU:**
\`\`\`bash
# Check CPU usage per node
kubectl top nodes

# Thresholds:
# - Average < 70% ✓
# - Peak < 85% ⚠️
# - Any node > 95% ✗ CRITICAL
\`\`\`

**Memory:**
\`\`\`bash
# Check memory usage
kubectl top nodes
kubectl top pods

# Thresholds:
# - Average < 75% ✓
# - Any pod > 90% ⚠️
# - Any pod OOMKilled ✗ CRITICAL
\`\`\`

**Disk:**
\`\`\`bash
# Check disk usage on nodes
for node in $(kubectl get nodes -o name); do
  kubectl exec -it $node -- df -h
done

# Thresholds:
# - Disk < 80% ✓
# - Disk > 90% ✗ CRITICAL
\`\`\`

### 4. Network Health

**Load Balancer:**
\`\`\`bash
# Check target health
aws elbv2 describe-target-health --target-group-arn xxx

# Verify:
# - All targets healthy
# - No unhealthy targets
# - No draining targets
\`\`\`

**Network Connectivity:**
\`\`\`bash
# Internal connectivity
curl -f http://api-service.default.svc.cluster.local/health

# External connectivity
curl -f https://api.example.com/health
\`\`\`

### 5. Storage Health

**Persistent Volumes:**
\`\`\`bash
# Check PV status
kubectl get pv

# Verify:
# - All PVs Bound
# - No Failed or Pending PVs
# - Sufficient capacity
\`\`\`

**Cloud Storage:**
\`\`\`bash
# S3/Cloud Storage health
aws s3 ls s3://app-uploads/ || echo "S3 issue"

# Verify:
# - Accessible
# - No access denied errors
# - Sufficient capacity
\`\`\`

### 6. Auto-Scaling Status

\`\`\`bash
# Kubernetes HPA
kubectl get hpa

# Verify:
# - Current replicas appropriate
# - Not constantly scaling (flapping)
# - Can scale up if needed (< max replicas)
\`\`\`

### Issues to Alert On

**Critical:**
- Pods in CrashLoopBackOff
- Nodes NotReady
- CPU > 95%
- Memory > 95%
- Disk > 95%
- Load balancer unhealthy targets

**Warning:**
- CPU > 80%
- Memory > 85%
- Disk > 80%
- High pod restart count

### Output Requirements
1. Write findings to: .tresor/health-${timestamp}/phase-1-infrastructure.md
2. Include resource usage metrics
3. For each critical issue: Call /todo-add
4. Exit code: 0 (healthy), 1 (degraded), 2 (critical)

Begin infrastructure health verification.
    `
  }),
].filter(Boolean));

// Progress update
await TodoWrite({
  todos: [
    { content: "Phase 1: Health Verification", status: "completed", activeForm: "Health verification completed" },
    { content: "Phase 2: Anomaly Detection", status: "in_progress", activeForm: "Detecting anomalies" },
    { content: "Phase 3: Alert Generation", status: "pending", activeForm: "Generating alerts" }
  ]
});
```

---

### Phase 2: Anomaly Detection (Sequential, Optional)

**Agent** (if --comprehensive):
- `@anomaly-detection-specialist`

**Execution**:
```javascript
if (args.comprehensive) {
  const phase2Results = await Task({
    subagent_type: 'anomaly-detection-specialist',
    description: 'Detect performance and business anomalies',
    prompt: `
# Health Check - Phase 2: Anomaly Detection

## Health Status from Phase 1
${await Read({ file_path: `.tresor/health-${timestamp}/phase-1-*.md` })}

## Your Task
Detect anomalies that may indicate problems:

### 1. Performance Anomalies

**Compare Current vs Historical:**
\`\`\`javascript
// Load last 7 days of metrics
const historical = loadMetrics({ days: 7 });
const current = getCurrentMetrics();

// Detect anomalies:
if (current.p95Latency > historical.avg * 1.5) {
  alert("P95 latency 50% higher than normal");
}

if (current.errorRate > historical.avg * 2) {
  alert("Error rate doubled");
}
\`\`\`

**Metrics to Compare:**
- P95/P99 latency
- Error rate
- Throughput (requests/sec)
- CPU usage
- Memory usage
- Database connection usage

### 2. Business Metric Anomalies

**Key Business Metrics:**
\`\`\`javascript
// Today vs last 7 days average
const metrics = {
  signups: compare(today.signups, last7days.avg),
  logins: compare(today.logins, last7days.avg),
  purchases: compare(today.purchases, last7days.avg),
  revenue: compare(today.revenue, last7days.avg),
};

// Alert if:
// - Any metric down > 20% (possible issue)
// - Signups = 0 (critical functionality broken)
// - Purchases = 0 (payment system down)
\`\`\`

### 3. Traffic Pattern Anomalies

**Unusual Traffic:**
- Sudden spike (> 3x normal)
- Sudden drop (< 50% normal)
- Unusual geographic distribution
- High bot traffic

### 4. Dependency Anomalies

**External Services:**
- Response times higher than normal
- Error rates increased
- Availability degraded

### 5. Resource Trend Analysis

**Growing Resources:**
\`\`\`javascript
// Check if resources growing unsustainably
const memoryTrend = analyzeGrowth(memory, { days: 7 });

if (memoryTrend.growthRate > 5% per day) {
  alert("Memory leak suspected (growing 5%/day)");
}
\`\`\`

### Output Requirements
1. Write findings to: .tresor/health-${timestamp}/phase-2-anomalies.md
2. For each critical anomaly: Call /todo-add
3. Include trend charts and comparisons
4. Suggest root cause hypotheses

Begin anomaly detection.
    `
  });
}

// Update progress
await TodoWrite({
  todos: [
    { content: "Phase 1: Health Verification", status: "completed", activeForm: "Health verification completed" },
    { content: "Phase 2: Anomaly Detection", status: "completed", activeForm: "Anomaly detection completed" },
    { content: "Phase 3: Alert Generation", status: "in_progress", activeForm: "Generating alerts" }
  ]
});
```

---

### Phase 3: Alert Generation (Conditional)

**Agent** (if critical issues found):
- `@incident-coordinator`

**Execution**:
```javascript
const criticalIssues = extractCriticalIssues(phase1Results, phase2Results);

if (args.alert && criticalIssues.length > 0) {
  await Task({
    subagent_type: 'incident-coordinator',
    description: 'Generate alerts for critical issues',
    prompt: `
# Health Check - Phase 3: Alert Generation

## Critical Issues Found
${JSON.stringify(criticalIssues)}

## Your Task
Generate appropriate alerts:

### Alert Severity Levels

**P0 (Critical - Immediate Response):**
- Service down (users affected)
- Database unreachable
- CPU/Memory > 95%
- Error rate > 10%

**P1 (High - Response within 1 hour):**
- Performance degraded (P95 > 2x normal)
- Error rate 5-10%
- Resource > 90%

**P2 (Medium - Response within 4 hours):**
- Performance degraded (P95 > 1.5x normal)
- Error rate 2-5%
- Resource > 85%

### Alert Channels

**For P0:**
- PagerDuty / OpsGenie (wake up on-call)
- Slack #incidents channel
- Email to team
- SMS to on-call engineer

**For P1:**
- Slack #alerts channel
- Email to team

**For P2:**
- Slack #monitoring channel

### Alert Format

\`\`\`markdown
🚨 CRITICAL ALERT - P0

Service: API
Issue: High error rate (12%)
Environment: Production
Impact: Users experiencing 500 errors

Metrics:
- Error rate: 12% (normal: 0.5%)
- Affected endpoints: POST /api/users, GET /api/dashboard
- Duration: 15 minutes
- Affected users: ~450

Next Steps:
1. Run /incident-response for comprehensive analysis
2. Check recent deployments
3. Review application logs
4. Check database health

Runbook: https://wiki.example.com/runbooks/high-error-rate
\`\`\`

### Output Requirements
1. Generate alerts for all critical issues
2. Include severity, impact, next steps
3. Link to relevant runbooks
4. Create incident ticket (if P0)

Begin alert generation.
    `
  });

  await TodoWrite({
    todos: [
      { content: "Phase 1: Health Verification", status: "completed", activeForm: "Health verification completed" },
      { content: "Phase 2: Anomaly Detection", status: "completed", activeForm: "Anomaly detection completed" },
      { content: "Phase 3: Alert Generation", status: "completed", activeForm: "Alert generation completed" }
    ]
  });
}
```

---

### Phase 4: Final Health Summary

**User Output**:
```markdown
# Health Check Complete! 💚

**Health Check ID**: health-2025-11-19-200322
**Environment**: Production
**Duration**: 8 minutes
**Overall Status**: HEALTHY ✓

## Health Summary

### 🟢 Application - HEALTHY
- Services: 3/3 responding ✓
- Health endpoints: All returning 200 ✓
- Error rate: 0.3% ✓ (Target: < 1%)
- P95 latency: 180ms ✓ (Target: < 500ms)
- P99 latency: 420ms ✓ (Target: < 1s)
- CPU: 55% ✓
- Memory: 68% ✓

### 🟢 Database - HEALTHY
- Connection: Successful (8ms) ✓
- Active connections: 15 / 100 (15%) ✓
- Long-running queries: 0 ✓
- Replication lag: 2MB ✓ (Target: < 10MB)
- Cache hit ratio: 97% ✓ (Target: > 95%)
- Disk usage: 65% ✓

### 🟢 Infrastructure - HEALTHY
- Nodes: 3/3 Ready ✓
- Pods: 12/12 Running ✓
- CPU: 55% ✓
- Memory: 68% ✓
- Disk: 65% ✓
- Load balancer: 3/3 targets healthy ✓

### 🟢 External Dependencies - HEALTHY
- Stripe API: 45ms ✓
- SendGrid API: 32ms ✓
- Auth0: 98ms ✓
- Redis: 2ms ✓

## Anomalies Detected (Comprehensive Mode)

### ⚠️ Warning: P95 Latency Trending Up
- Current: 180ms
- 7-day average: 145ms
- Trend: +24% over last week
- Severity: WARNING (monitor)
- Action: Investigate if trend continues

### ✓ No Critical Anomalies

Business Metrics:
- Signups today: 147 (7-day avg: 152) ✓
- Logins today: 1,234 (7-day avg: 1,189) ✓
- Purchases today: 87 (7-day avg: 92) ✓

## Recommendations

### Immediate (No Action Required)
- System is healthy
- All metrics within acceptable ranges

### Monitor (Next 24 Hours)
- [ ] Watch P95 latency trend
- [ ] If latency continues increasing, run /profile

### Preventive (Next 7 Days)
- [ ] Review P95 latency increase root cause (#health-001)
- [ ] Consider increasing connection pool (currently 15/100, but trending up)

## Reports Generated

All reports saved to `.tresor/health-2025-11-19-200322/`:
- `phase-1-application.md` - Application health metrics
- `phase-1-database.md` - Database health metrics
- `phase-1-infrastructure.md` - Infrastructure health
- `phase-2-anomalies.md` - Anomaly detection results (if --comprehensive)
- `final-health-report.md` - Consolidated health summary
- `metrics-snapshot.json` - Point-in-time metrics (for trending)

## Next Steps

1. ✅ System is healthy - no immediate action required
2. 📊 Monitor P95 latency trend over next 48 hours
3. 🔄 Schedule next health check in 24 hours
4. 📈 If issues arise, run /incident-response
```

---

## Integration with Tresor Workflow

### Automatic `/todo-add`
```bash
# Health warnings → todos
/todo-add "Health: P95 latency trending up - investigate root cause"
/todo-add "Health: Memory usage at 85% - check for leaks"
```

### `/incident-response` Integration
```javascript
// If critical health issues found:
if (criticalHealthIssues > 0) {
  console.log("🚨 Critical health issues detected.");
  console.log("Run: /incident-response for comprehensive incident management");
}
```

---

## Command Options

### `--env`
```bash
/health-check --env staging       # Staging environment
/health-check --env production    # Production environment
/health-check                     # Auto-detect
```

### `--comprehensive`
```bash
/health-check --comprehensive
# Includes:
# - Anomaly detection
# - Business metrics analysis
# - Trend analysis
# Duration: +5-10 minutes
```

### `--alert`
```bash
/health-check --alert        # Generate alerts (default)
/health-check --no-alert     # Suppress alerts (monitoring only)
```

---

## Health Check Schedule

**Recommended Frequency:**
- **Production:** Every 5-15 minutes (automated)
- **Staging:** Every 30 minutes
- **After deployments:** Immediately + every 5 min for 1 hour
- **During incidents:** Every 1-2 minutes

---

## Success Criteria

Health check succeeds if:
- ✅ All services responding
- ✅ Database healthy and performing well
- ✅ Infrastructure resources within limits
- ✅ External dependencies reachable
- ✅ No critical anomalies detected (if comprehensive)

---

## Meta Instructions

1. **Check all layers** - Application, database, infrastructure
2. **Use appropriate thresholds** - Different for staging vs production
3. **Detect anomalies** - Not just current status, but trends
4. **Generate actionable alerts** - Clear next steps
5. **Auto-capture issues** - Use `/todo-add`

---

**Begin system health verification.**
