# `/profile` - Comprehensive Performance Profiling

> Multi-layer performance analysis with bottleneck identification and optimization roadmap

**Version:** 2.7.0
**Category:** Performance
**Type:** Orchestration Command
**Estimated Duration:** 15 minutes - 2 hours (depending on depth)

---

## Overview

The `/profile` command performs comprehensive performance profiling across all application layers (frontend, backend, database, network, infrastructure). It identifies bottlenecks, performs root cause analysis, and provides prioritized optimization recommendations with measurable impact predictions.

### Key Differences from Other Commands

| Feature | `/profile` | `/benchmark` | `/audit` |
|---------|-----------|--------------|----------|
| **Focus** | Performance analysis | Load testing | Security assessment |
| **What It Measures** | Bottlenecks, latency, resource usage | Throughput, scalability | Vulnerabilities, compliance |
| **Duration** | 15 min - 2 hours | 5-30 minutes | 2-4 hours |
| **Best For** | Identifying what's slow | Validating optimizations | Security audits |
| **Output** | Optimization roadmap | Load test report | Security findings |

**Usage Pattern:**
1. **`/profile`** - Find what's slow
2. **Optimize** - Fix identified bottlenecks
3. **`/benchmark`** - Validate improvements

---

## Key Features

- ✅ **Multi-Layer Profiling** - Frontend, backend, database, network, infrastructure
- ✅ **Intelligent Agent Selection** - Based on detected tech stack
- ✅ **Root Cause Analysis** - Not just "what" is slow, but "why"
- ✅ **Impact Predictions** - Before/after metrics for each optimization
- ✅ **Quick Wins Prioritization** - High impact, low effort fixes first
- ✅ **Baseline Establishment** - Metrics for tracking improvement over time
- ✅ **Comparative Analysis** - Track progress across multiple profiling runs

---

## Quick Start

### Basic Usage

```bash
# Profile all layers (comprehensive)
/profile

# Profile specific layers
/profile --layers frontend
/profile --layers backend,database

# Quick profiling (15 minutes)
/profile --depth quick

# Deep profiling (2 hours)
/profile --depth deep
```

### Advanced Usage

```bash
# Custom performance threshold
/profile --threshold 200ms

# API-focused profiling
/profile --layers backend,database --depth standard
```

---

## How It Works

### Phase 0: Profiling Planning

**Tech Stack Detection:**
```
Detecting performance targets...

Frontend:
- Framework: React 18
- Bundler: Webpack 5
- Targets: Core Web Vitals, bundle size, component render

Backend:
- Framework: Express.js
- Runtime: Node.js 18
- Targets: API latency, event loop lag, memory

Database:
- Type: PostgreSQL 14
- Targets: Query performance, index usage, connection pool

Infrastructure:
- Platform: AWS (EC2, RDS, CloudFront)
- Targets: CPU, memory, network, disk I/O

Selected Profilers:
Phase 1 (Parallel - 3 agents):
  ✓ @frontend-performance-expert (Core Web Vitals, bundle analysis)
  ✓ @backend-performance-tuner (API profiling, Node.js metrics)
  ✓ @database-optimizer (Query performance, index analysis)

Phase 2 (Sequential):
  → @root-cause-analyzer (Why are bottlenecks slow?)

Phase 3 (Sequential):
  → @performance-optimization-specialist (Optimization roadmap)

Estimated Duration: 45 minutes (standard depth)
Performance Threshold: 500ms (APIs), 3s (page load)

Proceed? (y/n/adjust)
```

---

### Phase 1: Parallel Profiling

**3 Agents Run Simultaneously:**

**Agent 1: Frontend Profiling**
```
Profiling frontend performance...

Core Web Vitals:
- LCP: 3.2s ⚠️ (Target: < 2.5s, Delta: +0.7s)
- FID: 85ms ✓ (Target: < 100ms)
- CLS: 0.15 ✗ (Target: < 0.1, Delta: +0.05)
- FCP: 1.8s ✓
- TTI: 4.5s ⚠️

Bundle Analysis:
- Total size: 850KB (gzipped: 280KB) ⚠️
- Initial bundle: 650KB
- Lazy loaded: 200KB
- Largest dependency: moment.js (231KB) ← Can replace with date-fns
- Duplicate packages: 3 (lodash versions: 4.17.15, 4.17.21)

Component Render Performance:
- UserProfile: 45ms ⚠️ (Target: < 16ms for 60fps)
- Dashboard: 12ms ✓
- ProductList: 78ms ✗ (Renders 500 items without virtualization)

Bottlenecks:
1. CRITICAL: Large bundle (850KB) - Code splitting needed
2. HIGH: UserProfile re-renders - Memoization needed
3. HIGH: ProductList renders 500 items - Virtualization needed
4. MEDIUM: CLS from lazy-loaded images
```

**Agent 2: Backend Profiling**
```
Profiling backend performance...

API Response Times:
- GET  /api/users       - 45ms (P95: 120ms) ✓
- GET  /api/users/:id   - 32ms (P95: 80ms)  ✓
- POST /api/users       - 850ms (P95: 1.2s) ✗ CRITICAL
- GET  /api/dashboard   - 1.5s (P95: 2.8s)  ✗ CRITICAL
- GET  /api/products    - 180ms (P95: 340ms) ⚠️

Slow Endpoints (> 500ms): 2 found

CPU Profiling:
- Event loop lag: 8ms ✓
- CPU usage: 45% average
- Hot functions:
  1. bcrypt.hash() - 680ms per call (password hashing)
  2. JSON.parse() on large payloads - 120ms
  3. Data transformation loops - 85ms

Memory Profiling:
- Heap used: 1.2GB / 2GB ✓
- Memory growth: Stable (no leaks detected)
- Largest objects: In-memory cache (450MB)

Bottlenecks:
1. CRITICAL: POST /api/users slow (850ms) - Database query
2. CRITICAL: Dashboard API slow (1.5s) - No caching
3. HIGH: bcrypt causing latency - Consider async operations
4. MEDIUM: Large in-memory cache - Consider Redis
```

**Agent 3: Database Profiling**
```
Profiling database performance...

Slow Queries (> 100ms): 5 found

Top 3 Slowest:
1. SELECT * FROM users WHERE email = ? (720ms) ✗
   - Explain: Seq Scan on users (cost=0..1250)
   - Issue: Missing index on email column
   - Fix: CREATE INDEX idx_users_email ON users(email);
   - Expected: 720ms → 15ms (-98%)

2. Dashboard aggregation query (650ms) ⚠️
   - Multiple JOINs + GROUP BY
   - Could be cached (data updates hourly)
   - Fix: Redis cache with 1-hour TTL
   - Expected: 650ms → 5ms (-99%)

3. Product search query (320ms) ⚠️
   - Full-text search without index
   - Fix: CREATE INDEX with GIN on product name/description
   - Expected: 320ms → 25ms (-92%)

Index Analysis:
- Total indexes: 18
- Unused indexes: 2 (wasting 150MB)
- Missing indexes: 3 (causing Seq Scans)

Connection Pool:
- Pool size: 20 connections
- Active: 13 average (65% usage) ✓
- Wait time: 0ms ✓
- Idle connections: 7

Cache Hit Ratio:
- Buffer cache: 94% ✓
- Should be > 95% for production

Bottlenecks:
1. CRITICAL: Missing index on users.email (720ms query)
2. HIGH: Dashboard query not cached (650ms)
3. MEDIUM: Product search needs full-text index
```

**Output:**
```
Phase 1 Complete (25 minutes)
- @frontend-performance-expert: 5 bottlenecks found
- @backend-performance-tuner: 4 bottlenecks found
- @database-optimizer: 3 bottlenecks found

Total Bottlenecks: 12 (3 critical, 6 high, 3 medium)
Todos Created: 12
Reports: .tresor/profile-2025-11-19/phase-1-*.md
```

---

### Phase 2: Root Cause Analysis

**Agent:**
- `@root-cause-analyzer`

**Analysis:**
```
Analyzing root causes of 12 bottlenecks...

Systemic Issues Identified:

1. **Missing Caching Strategy** (affects 3 bottlenecks)
   - Dashboard API: No caching (1.5s)
   - Product API: No caching (180ms)
   - Database cache hit: 94% (should be > 99%)

   Root Cause: No application-level caching implemented
   Solution: Implement Redis caching layer
   Expected Impact: -2.1s total improvement

2. **N+1 Query Pattern** (affects 2 bottlenecks)
   - User profile loads: 15 queries for 1 page
   - Product list: Query per product for related data

   Root Cause: ORM lazy loading, no eager loading
   Solution: Use JOIN or eager loading
   Expected Impact: -450ms per affected endpoint

3. **Unoptimized Database Schema** (affects 3 bottlenecks)
   - Missing indexes: 3 found
   - Unused indexes: 2 found (wasting space)

   Root Cause: Schema evolved without index optimization
   Solution: Add 3 indexes, drop 2 unused indexes
   Expected Impact: -1.1s total improvement

4. **Large Frontend Bundle** (affects page load)
   - Moment.js: 231KB (can use date-fns 33KB)
   - No code splitting: Everything in one bundle
   - Duplicate lodash versions

   Root Cause: No bundle optimization strategy
   Solution: Code splitting, dependency replacement
   Expected Impact: -1.4s page load improvement

5. **Synchronous Password Hashing** (affects auth)
   - bcrypt.hash() blocks event loop: 680ms

   Root Cause: Using sync method instead of async
   Solution: Use bcrypt.hash() instead of bcrypt.hashSync()
   Expected Impact: -680ms, no event loop blocking
```

**Output:**
```
Phase 2 Complete (10 minutes)
- Systemic issues: 5 patterns identified
- Root causes: All bottlenecks traced to root cause
- Quick wins: 3 identified (< 4 hours, high impact)

Reports: .tresor/profile-2025-11-19/phase-2-root-cause.md
```

---

### Phase 3: Optimization Recommendations

**Agent:**
- `@performance-optimization-specialist`

**Recommendations:**
```
Generating optimization roadmap...

## Quick Wins (< 4 hours) - Total Impact: -2.39s

### 1. Add Database Index (15 minutes)
**Implementation:**
\`\`\`sql
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_products_name_gin ON products USING GIN(to_tsvector('english', name));
\`\`\`
**Impact:**
- POST /api/users: 850ms → 145ms (-705ms)
- Product search: 320ms → 25ms (-295ms)
**Risk:** Low
**Testing:** Run queries before/after, verify performance
**Todo:** #perf-001

### 2. Enable Response Compression (30 minutes)
**Implementation:**
\`\`\`javascript
// Add compression middleware
const compression = require('compression');
app.use(compression());
\`\`\`
**Impact:** Page load: 2.8s → 1.2s (-1.6s)
**Risk:** Low
**Testing:** Check network tab, verify compressed responses
**Todo:** #perf-002

### 3. Fix Synchronous bcrypt (2 hours)
**Implementation:**
\`\`\`javascript
// Before:
const hash = bcrypt.hashSync(password, 10);  // 680ms blocking

// After:
const hash = await bcrypt.hash(password, 10);  // 680ms non-blocking
\`\`\`
**Impact:** No event loop blocking, better concurrency
**Risk:** Low (change sync → async)
**Testing:** Load test with concurrent requests
**Todo:** #perf-006

**Total Quick Wins Impact:** -2.4s improvement in 2.75 hours

## High-Impact Optimizations (4-16 hours)

### 4. Implement Redis Caching (8 hours)
**Target:** Dashboard API (1.5s → 50ms)
**Implementation:**
\`\`\`javascript
// Cache expensive dashboard query
const cacheKey = \`dashboard:\${userId}\`;
const cached = await redis.get(cacheKey);
if (cached) return JSON.parse(cached);

const data = await db.query(expensiveQuery);
await redis.setex(cacheKey, 3600, JSON.stringify(data)); // 1-hour TTL
return data;
\`\`\`
**Impact:** -1.45s (-97%)
**Risk:** Medium (cache invalidation strategy needed)
**Todo:** #perf-003

### 5. Code Splitting (12 hours)
**Target:** Bundle size (850KB → 200KB initial)
**Implementation:**
\`\`\`javascript
// Route-based code splitting
const Dashboard = React.lazy(() => import('./pages/Dashboard'));
const Profile = React.lazy(() => import('./pages/Profile'));
const Settings = React.lazy(() => import('./pages/Settings'));
\`\`\`
**Impact:** Page load: 3.2s → 1.8s (-1.4s)
**Risk:** Medium (testing all routes needed)
**Todo:** #perf-004

### 6. Image Optimization (4 hours)
**Implementation:**
- Convert images to WebP
- Implement lazy loading
- Use responsive images (srcset)
- Add blur placeholder
**Impact:** Image load: 800ms → 200ms (-600ms)
**Risk:** Low
**Todo:** #perf-005

## Long-Term Improvements (> 16 hours)

### 7. Server-Side Rendering (40 hours)
**Target:** LCP 3.2s → 1.4s
**Implementation:** Migrate to Next.js or Remix
**Impact:** Better SEO, faster initial page load
**Risk:** High (major refactor)

### 8. Database Read Replicas (16 hours)
**Target:** Distribute read load, reduce primary DB load
**Implementation:** Set up read replicas, route SELECT to replicas
**Impact:** 30% reduction in database latency
**Risk:** Medium (complexity in routing)

## Performance Monitoring Setup

### Recommended Tools:
- **APM:** New Relic, Datadog, AppDynamics
- **Frontend:** Lighthouse CI, SpeedCurve, Calibre
- **Database:** pg_stat_statements, slow query log
- **Infrastructure:** CloudWatch, Prometheus, Grafana

### Performance Budgets:
\`\`\`javascript
// Set performance budgets
{
  "budgets": [
    {
      "resourceType": "script",
      "budget": 200  // 200KB max
    },
    {
      "metric": "interactive",
      "budget": 3800  // 3.8s max TTI
    },
    {
      "metric": "api-latency-p95",
      "budget": 500  // 500ms max P95
    }
  ]
}
\`\`\`

### Alerting:
- Alert on: P95 latency > 500ms
- Alert on: Error rate > 1%
- Alert on: LCP > 3s
```

**Output:**
```
Phase 3 Complete (10 minutes)
- Quick wins: 3 optimizations (2.75 hours, -2.4s improvement)
- High-impact: 3 optimizations (24 hours, -3.5s improvement)
- Long-term: 2 optimizations (56 hours, -40% latency reduction)
- Monitoring setup: Recommended tools and budgets

Todos Created: 8 (total: 20)
Reports: .tresor/profile-2025-11-19/phase-3-optimizations.md
```

---

## Final Output

### Performance Report

**Location:** `.tresor/profile-2025-11-19-170322/final-performance-report.md`

```markdown
# Performance Profile Report

**Profile ID**: profile-2025-11-19-170322
**Layers**: Frontend, Backend, Database
**Depth**: Standard
**Duration**: 45 minutes

## Executive Summary

- **Bottlenecks Found**: 12 (3 critical, 6 high, 3 medium)
- **Potential Improvement**: -5.9s total (-71% latency reduction)
- **Quick Wins Available**: 3 optimizations (2.75 hours, -2.4s)
- **Estimated ROI**: -2.4s improvement per hour of work

## Performance Baseline

### Frontend
- **Page Load**: 3.2s (Target: < 3s) ⚠️
- **LCP**: 3.2s (Target: < 2.5s) ⚠️
- **FID**: 85ms ✓
- **CLS**: 0.15 ✗
- **Bundle Size**: 850KB ⚠️

### Backend
- **Average API Latency**: 245ms ✓
- **P95 Latency**: 680ms ⚠️
- **Slowest Endpoint**: POST /api/users (850ms) ✗
- **Event Loop Lag**: 8ms ✓

### Database
- **Slowest Query**: 720ms ✗
- **Cache Hit Rate**: 94% ⚠️ (Target: > 99%)
- **Connection Pool**: 65% usage ✓
- **Missing Indexes**: 3 ✗

## Critical Bottlenecks (3)

### 1. Missing Database Index on users.email
- **Current**: POST /api/users takes 850ms
- **Breakdown**: Database query 720ms (85% of time)
- **Root Cause**: Seq Scan on users table, no index on email
- **Fix**: CREATE INDEX idx_users_email ON users(email);
- **After**: 850ms → 145ms (-705ms, -83%)
- **Effort**: 15 minutes
- **Todo**: #perf-001

### 2. Dashboard API No Caching
- **Current**: GET /api/dashboard takes 1.5s
- **Breakdown**: Complex aggregation query (650ms) + data transformation (850ms)
- **Root Cause**: No caching, data updates hourly but query runs every request
- **Fix**: Redis cache with 1-hour TTL
- **After**: 1.5s → 50ms (-1.45s, -97%)
- **Effort**: 8 hours
- **Todo**: #perf-003

### 3. Large JavaScript Bundle
- **Current**: Page load 3.2s, bundle 850KB
- **Root Cause**: No code splitting, all routes in one bundle
- **Fix**: Route-based code splitting with React.lazy()
- **After**: 850KB → 200KB initial (-650KB), page load 3.2s → 1.8s (-1.4s)
- **Effort**: 12 hours
- **Todo**: #perf-004

## Optimization Roadmap

### Week 1 (Quick Wins) - 2.75 hours, -2.39s improvement
- [ ] Add missing database indexes (15m) - #perf-001
- [ ] Enable response compression (30m) - #perf-002
- [ ] Fix synchronous bcrypt (2h) - #perf-006

**Expected After Week 1:**
- POST /api/users: 850ms → 145ms ✓
- Page load: 3.2s → 1.6s ✓
- P95 latency: 680ms → 200ms ✓

### Week 2-4 (High-Impact) - 24 hours, -3.5s improvement
- [ ] Implement Redis caching (8h) - #perf-003
- [ ] Code splitting & lazy loading (12h) - #perf-004
- [ ] Image optimization (4h) - #perf-005

**Expected After Week 4:**
- Dashboard API: 1.5s → 50ms ✓
- Page load: 1.6s → 1.2s ✓
- Bundle: 850KB → 200KB ✓

### Month 2-3 (Long-Term) - 56 hours
- [ ] Server-side rendering (40h) - #perf-007
- [ ] Database read replicas (16h) - #perf-008

**Expected After Month 3:**
- LCP: 1.2s → 0.9s ✓
- API latency: -30% overall ✓

## Performance Metrics Tracking

\`\`\`javascript
// Baseline (Before Optimizations)
{
  "frontend": {
    "lcp": "3.2s",
    "bundleSize": "850KB",
    "pageLoad": "3.2s"
  },
  "backend": {
    "p95Latency": "680ms",
    "slowestEndpoint": "850ms"
  },
  "database": {
    "slowestQuery": "720ms",
    "cacheHitRate": "94%"
  }
}

// Target (After All Optimizations)
{
  "frontend": {
    "lcp": "1.2s",         // -2.0s (-63%)
    "bundleSize": "200KB",  // -650KB (-76%)
    "pageLoad": "1.2s"      // -2.0s (-63%)
  },
  "backend": {
    "p95Latency": "150ms",     // -530ms (-78%)
    "slowestEndpoint": "50ms"   // -800ms (-94%)
  },
  "database": {
    "slowestQuery": "15ms",     // -705ms (-98%)
    "cacheHitRate": "99%"       // +5%
  }
}
\`\`\`

## Next Steps

1. **Immediate**: Implement 3 quick wins (2.75 hours)
2. **Validate**: Run /benchmark to measure improvement
3. **Short-term**: Implement high-impact optimizations (24 hours)
4. **Re-profile**: Run /profile to verify improvements
5. **Monitor**: Set up continuous performance monitoring
```

---

## Integration with Tresor Workflow

### Automatic `/todo-add`
```bash
# Every bottleneck creates a structured todo:
/todo-add "Database: Add index on users.email - CREATE INDEX idx_users_email"
/todo-add "Backend: Implement Redis caching for dashboard API"
/todo-add "Frontend: Code splitting for route-based lazy loading"
```

### Automatic `/prompt-create`
```bash
# Complex optimizations → expert prompts
/prompt-create "Migrate React app to Next.js for server-side rendering"
# → Creates ./prompts/007-nextjs-migration.md
# → Suggests @frontend-architect, @performance-tuner
```

### `/benchmark` Integration
```bash
# After optimizations, validate with load testing:
/benchmark --duration 5m --rps 100
# → Measure throughput, latency under load
# → Compare with pre-optimization baseline
```

---

## Depth Levels

### Quick (15 minutes)
```bash
/profile --depth quick
```
- Surface-level profiling only
- No deep analysis
- Suitable for: Daily checks, CI/CD

**Includes:**
- API response times (basic)
- Page load metrics (Lighthouse)
- Database slow query log

**Excludes:**
- Root cause analysis
- Memory profiling
- CPU profiling

---

### Standard (45 minutes) - DEFAULT
```bash
/profile --depth standard
```
- Comprehensive profiling
- Root cause analysis
- Optimization recommendations

**Includes:**
- All layers (frontend, backend, database)
- Core Web Vitals
- API profiling with APM
- Database query analysis
- Root cause analysis
- Optimization roadmap

**Excludes:**
- Infrastructure deep-dive
- Load testing
- Memory leak detection

---

### Deep (2 hours)
```bash
/profile --depth deep
```
- Exhaustive profiling
- Infrastructure analysis
- Memory/CPU deep-dive

**Includes:**
- Everything in Standard
- Infrastructure metrics (EC2, RDS, CloudFront)
- Memory leak detection
- CPU profiling with flamegraphs
- Network latency analysis
- Third-party service impact

---

## Example Workflows

### Workflow 1: Performance Investigation

```bash
# User complaint: "App is slow"

# Step 1: Profile to find bottlenecks
/profile --depth standard

# Output: 12 bottlenecks found
# - 3 critical (> 2x threshold)
# - 6 high (> threshold)
# - 3 medium

# Step 2: Review findings
cat .tresor/profile-*/final-performance-report.md

# Step 3: Implement quick wins (2.75 hours)
/todo-check
# → Select #perf-001: Add database index
# → Select #perf-002: Enable compression
# → Select #perf-006: Fix async bcrypt

# Step 4: Validate improvements
/benchmark --duration 5m --rps 50
# → Before: P95 = 680ms
# → After: P95 = 200ms (-70% improvement)

# Step 5: Re-profile to verify
/profile --layers backend,database --depth quick
# → Confirms improvements, no new bottlenecks
```

---

### Workflow 2: Continuous Performance Optimization

```bash
# Month 1: Initial baseline
/profile --depth deep
# → Baseline: P95 = 680ms, Page load = 3.2s

# Month 2: Implement quick wins
# [Work on todos from profiling]
/profile --depth quick
# → Improved: P95 = 200ms, Page load = 1.6s

# Month 3: Implement high-impact optimizations
# [Redis caching, code splitting]
/profile --depth standard
# → Improved: P95 = 150ms, Page load = 1.2s

# Track progress over time:
# Month 1: 680ms → Month 2: 200ms → Month 3: 150ms
```

---

### Workflow 3: Pre-Launch Performance Validation

```bash
# Before launching new feature:

# Step 1: Profile current performance
/profile --layers all --depth standard
# → Baseline: P95 = 200ms

# Step 2: Deploy new feature

# Step 3: Re-profile
/profile --layers all --depth standard
# → After: P95 = 250ms (+50ms regression)

# Step 4: If regression detected, investigate
/profile --layers backend --depth deep
# → Find: New feature has N+1 query

# Step 5: Fix regression
# [Optimize new feature]

# Step 6: Validate fix
/profile --layers backend --depth quick
# → Confirmed: P95 = 200ms (back to baseline)
```

---

## FAQ

### Q: How often should I run profiling?

**A:**
- **Daily/CI-CD:** `/profile --depth quick` (15 min)
- **Weekly:** `/profile --depth standard` (45 min)
- **Pre-release:** `/profile --depth deep` (2 hours)
- **After optimizations:** Re-profile to verify improvements

### Q: What's a good performance threshold?

**A:**
- **APIs:** < 200ms average, < 500ms P95
- **Page Load:** < 3s (< 2s for e-commerce)
- **LCP:** < 2.5s
- **Database Queries:** < 100ms

Adjust based on your use case (real-time vs batch).

### Q: Should I profile in production or development?

**A:** Both!
- **Development:** Find obvious bottlenecks with profiling tools
- **Production:** Real user metrics, APM tools (New Relic, Datadog)

Use production data for realistic profiling when possible.

### Q: How do I validate optimizations?

**A:**
1. Profile before optimizations: `/profile`
2. Implement fixes
3. Run load test: `/benchmark`
4. Profile after: `/profile --depth quick`
5. Compare before/after metrics

---

## Troubleshooting

### Issue: "Cannot detect frontend framework"

**Cause:** Framework not in expected location

**Solution:**
```bash
# Manually specify in prompt or adjust framework detection
```

---

### Issue: "Database profiling failed"

**Cause:** Insufficient database permissions

**Solution:**
```bash
# Grant pg_stat_statements permissions (PostgreSQL):
CREATE EXTENSION pg_stat_statements;
GRANT pg_read_all_stats TO your_user;
```

---

### Issue: "Profiling takes too long"

**Cause:** Deep profiling on large codebase

**Solution:**
```bash
# Use quick mode:
/profile --depth quick --layers backend

# Or profile one layer at a time:
/profile --layers frontend --depth standard
```

---

## See Also

- **[/benchmark Command](../../performance/benchmark/)** - Load testing
- **[Performance Tuner Agent](../../../subagents/core/performance-tuner/)** - Performance optimization
- **[Database Optimizer Agent](../../../subagents/engineering/database/database-optimizer/)** - Database performance
- **[Frontend Performance Expert](../../../subagents/engineering/frontend/frontend-performance-expert/)** - Frontend optimization

---

**Version:** 2.7.0
**Last Updated:** November 19, 2025
**Category:** Performance
**License:** MIT
**Author:** Alireza Rezvani
