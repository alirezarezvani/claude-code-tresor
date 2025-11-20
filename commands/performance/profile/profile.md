---
name: profile
description: Comprehensive performance profiling with bottleneck identification and optimization recommendations
argument-hint: [--layers frontend,backend,database,all] [--depth quick,standard,deep] [--threshold 500ms]
allowed-tools: Task, Read, Write, Edit, Bash, Glob, Grep, SlashCommand, AskUserQuestion
model: inherit
enabled: true
---

# Performance Profiling - Comprehensive Bottleneck Analysis

You are an expert performance orchestrator managing comprehensive performance profiling using Tresor's specialized performance agents. Your goal is to identify bottlenecks, analyze root causes, and provide actionable optimization recommendations.

## Command Purpose

Perform comprehensive performance profiling with:
- **Multi-layer profiling** - Frontend, backend, database, network, infrastructure
- **Bottleneck identification** - CPU, memory, I/O, network hotspots
- **Root cause analysis** - Why is it slow?
- **Optimization recommendations** - Specific, measurable improvements
- **Baseline establishment** - Performance metrics for tracking
- **Comparative analysis** - Before/after optimization

---

## Execution Flow

### Phase 0: Profiling Planning

**Step 1: Parse Arguments**
```javascript
const args = parseArguments($ARGUMENTS);
// --layers: frontend, backend, database, network, infrastructure, all (default: all)
// --depth: quick, standard, deep (default: standard)
// --threshold: Performance threshold in ms (default: 500ms for APIs, 3s for page load)
```

**Step 2: Detect Tech Stack & Performance Targets**

Analyze codebase to determine what to profile:
```javascript
const perfTargets = await detectPerformanceTargets();

// Frontend detection:
// - React/Vue/Angular → Component render performance
// - Webpack/Vite → Bundle size analysis
// - Browser → Page load, FCP, LCP, TTI, CLS

// Backend detection:
// - Express/FastAPI/Spring → API response times
// - Node.js → Event loop lag, garbage collection
// - Python → CPU-bound operations
// - Java → JVM metrics, thread pools

// Database detection:
// - PostgreSQL/MySQL → Query performance, index usage
// - MongoDB → Aggregation pipeline performance
// - Redis → Cache hit rates

// Infrastructure detection:
// - Docker/Kubernetes → Container resource usage
// - AWS/GCP/Azure → Cloud service metrics
// - CDN → Static asset delivery

// Example output:
{
  frontend: {
    framework: 'react',
    bundler: 'webpack',
    targets: ['page-load-time', 'component-render', 'bundle-size']
  },
  backend: {
    framework: 'express',
    runtime: 'node.js',
    targets: ['api-response-time', 'event-loop-lag', 'memory-usage']
  },
  database: {
    type: 'postgresql',
    targets: ['query-performance', 'connection-pool', 'index-usage']
  },
  infrastructure: {
    platform: 'aws',
    targets: ['ec2-cpu', 'rds-iops', 'cloudfront-latency']
  }
}
```

**Step 3: Select Performance Profilers**

Based on detected tech stack and layers:

```javascript
function selectProfilers(techStack, layers, depth) {
  const profilers = {
    // Phase 1: Parallel Profiling (max 3 agents)
    phase1: {
      conditional: [
        layers.includes('frontend') ? '@frontend-performance-expert' : null,
        layers.includes('backend') ? '@backend-performance-tuner' : null,
        layers.includes('database') ? '@database-optimizer' : null,
      ].filter(Boolean),

      // Always include core performance tuner
      base: ['@performance-tuner'],

      max: 3, // Parallel limit
    },

    // Phase 2: Deep Bottleneck Analysis (sequential)
    phase2: {
      required: depth !== 'quick' ? [
        '@root-cause-analyzer',  // Why is it slow?
      ] : [],

      conditional: [
        hasSlowQueries ? '@database-query-optimizer' : null,
        hasMemoryLeaks ? '@memory-leak-detector' : null,
        hasHighCPU ? '@cpu-profiler' : null,
      ].filter(Boolean),

      max: 2,
    },

    // Phase 3: Optimization Recommendations (sequential)
    phase3: {
      required: [
        '@performance-optimization-specialist',
      ],

      conditional: [
        techStack.frontend ? '@frontend-optimization-expert' : null,
        techStack.backend ? '@backend-optimization-expert' : null,
      ].filter(Boolean),

      max: 2,
    },
  };

  return selectOptimalAgents(profilers);
}
```

**Step 4: User Confirmation**

```javascript
await AskUserQuestion({
  questions: [{
    question: "Performance profiling plan ready. Proceed?",
    header: "Confirm Profile",
    multiSelect: false,
    options: [
      {
        label: "Execute profiling",
        description: `${layers.join(', ')} profiling, ${depth} depth, ${agents} agents`
      },
      {
        label: "Adjust threshold",
        description: `Current: ${threshold}ms (APIs), ${pageThreshold}s (page load)`
      },
      {
        label: "Change depth",
        description: "Quick (15min), Standard (45min), Deep (2hr)"
      },
      {
        label: "Cancel",
        description: "Exit without profiling"
      }
    ]
  }]
});
```

---

### Phase 1: Parallel Performance Profiling (3 agents max)

**Agents** (up to 3 based on layers):
- `@frontend-performance-expert` (if frontend layer)
- `@backend-performance-tuner` (if backend layer)
- `@database-optimizer` (if database layer)

**Execution**:
```javascript
const phase1Results = await Promise.all([
  // Agent 1: Frontend Profiling
  layers.includes('frontend') ? Task({
    subagent_type: 'frontend-performance-expert',
    description: 'Frontend performance profiling',
    prompt: `
# Performance Profile - Phase 1: Frontend Analysis

## Context
- Framework: ${techStack.frontend.framework}
- Bundler: ${techStack.frontend.bundler}
- Threshold: ${pageThreshold}s page load
- Profile ID: profile-${timestamp}

## Your Task
Profile frontend performance and identify bottlenecks:

### 1. Page Load Performance

**Core Web Vitals:**
- [ ] **LCP** (Largest Contentful Paint) - Target: < 2.5s
- [ ] **FID** (First Input Delay) - Target: < 100ms
- [ ] **CLS** (Cumulative Layout Shift) - Target: < 0.1
- [ ] **FCP** (First Contentful Paint) - Target: < 1.8s
- [ ] **TTI** (Time to Interactive) - Target: < 3.8s
- [ ] **TBT** (Total Blocking Time) - Target: < 200ms

**Analysis Method:**
\`\`\`javascript
// Use Lighthouse, WebPageTest, or Chrome DevTools
// Simulate: Desktop, Mobile (3G, 4G, WiFi)
// Metrics to capture:
// - Initial page load
// - Time to first byte (TTFB)
// - Resource loading waterfall
// - Main thread work breakdown
\`\`\`

### 2. Bundle Analysis

**JavaScript Bundles:**
\`\`\`bash
# Analyze bundle size
npx webpack-bundle-analyzer dist/stats.json

# Check for:
# - Large dependencies (> 100KB)
# - Duplicate dependencies
# - Unused code (tree-shaking opportunities)
# - Code splitting opportunities
\`\`\`

**Findings to Report:**
- Total bundle size (target: < 200KB initial, < 500KB total)
- Largest dependencies
- Duplicate packages
- Optimization opportunities (lazy loading, code splitting)

### 3. Render Performance

**Component Profiling:**
\`\`\`javascript
// Use React DevTools Profiler or equivalent
// Identify:
// - Slow rendering components (> 16ms for 60fps)
// - Unnecessary re-renders
// - Expensive computations in render
// - Large list rendering without virtualization
\`\`\`

**Hot Spots to Check:**
- Component mount time
- Update time
- Render count (unnecessary re-renders)
- Props drilling depth

### 4. Network Performance

**API Calls:**
- Count of API calls per page load
- API response times (target: < ${apiThreshold}ms)
- Waterfall analysis (sequential vs parallel)
- Failed requests / retry logic

**Static Assets:**
- Image optimization (format, size, compression)
- Font loading strategy
- CSS delivery (inline critical, defer non-critical)
- JavaScript loading (defer, async, module)

### 5. Memory Profiling

**Memory Leaks:**
\`\`\`javascript
// Chrome DevTools Memory Profiler
// Check for:
// - Detached DOM nodes
// - Event listener leaks
// - Closure memory retention
// - Growing heap over time
\`\`\`

### 6. Third-Party Impact

**External Services:**
- Analytics (Google Analytics, Mixpanel)
- Ads / Marketing pixels
- Chat widgets (Intercom, etc.)
- Social media embeds

**For Each:**
- Load time impact
- Main thread blocking time
- Necessity (can it be deferred/removed?)

### Output Requirements
1. Write findings to: .tresor/profile-${timestamp}/phase-1-frontend.md
2. Use structured performance report format
3. For each issue > threshold: Call /todo-add immediately
4. Include screenshots/traces from profiling tools

### Report Structure
\`\`\`markdown
# Frontend Performance Report

## Core Web Vitals
- LCP: 3.2s ⚠️ (Target: < 2.5s, Delta: +0.7s)
- FID: 85ms ✓ (Target: < 100ms)
- CLS: 0.15 ✗ (Target: < 0.1, Delta: +0.05)

## Bottlenecks Identified

### 1. Slow Initial Page Load (3.2s LCP)
- **Root Cause**: Large JavaScript bundle (850KB uncompressed)
- **Impact**: Users wait 3.2s to see content
- **Solution**: Code splitting, lazy loading, tree shaking
- **Expected Improvement**: 3.2s → 1.8s (-1.4s, -44%)

### 2. Unnecessary Re-renders (UserProfile component)
- **Root Cause**: Props object recreation on every parent render
- **Impact**: 45ms render time (should be < 16ms)
- **Solution**: Memoize props with useMemo
- **Expected Improvement**: 45ms → 8ms (-37ms, -82%)

[... more bottlenecks ...]

## Optimization Priority
1. CRITICAL: Reduce bundle size (850KB → 200KB)
2. HIGH: Fix CLS issues (layout shifts)
3. HIGH: Optimize UserProfile re-renders
4. MEDIUM: Lazy load below-fold content
5. MEDIUM: Optimize images (WebP conversion)

## Metrics Baseline
- Bundle size: 850KB (gzipped: 280KB)
- Page load: 3.2s
- TTI: 4.5s
- API calls per page: 12
- Largest dependency: moment.js (231KB)
\`\`\`

Begin frontend performance profiling.
    `
  }) : null,

  // Agent 2: Backend Profiling
  layers.includes('backend') ? Task({
    subagent_type: 'backend-performance-tuner',
    description: 'Backend performance profiling',
    prompt: `
# Performance Profile - Phase 1: Backend Analysis

## Context
- Framework: ${techStack.backend.framework}
- Runtime: ${techStack.backend.runtime}
- Threshold: ${apiThreshold}ms API response
- Profile ID: profile-${timestamp}

## Your Task
Profile backend performance and identify bottlenecks:

### 1. API Response Times

**Endpoint Analysis:**
\`\`\`bash
# Analyze API endpoints
# For each endpoint:
# - Average response time
# - P50, P95, P99 latency
# - Throughput (req/sec)
# - Error rate

# Example:
GET  /api/users         - 45ms (P95: 120ms) ✓
GET  /api/users/:id     - 32ms (P95: 80ms)  ✓
POST /api/users         - 850ms (P95: 1.2s) ✗ SLOW
GET  /api/dashboard     - 1.5s (P95: 2.8s)  ✗ VERY SLOW
\`\`\`

**Slow Endpoints (> ${apiThreshold}ms):**
For each slow endpoint:
1. Profile with APM tool (New Relic, Datadog, etc.)
2. Break down time: (DB queries + external APIs + compute)
3. Identify bottleneck component

### 2. Database Query Performance

**Slow Queries:**
\`\`\`sql
-- Find slow queries (PostgreSQL)
SELECT query, mean_exec_time, calls
FROM pg_stat_statements
WHERE mean_exec_time > ${dbThreshold}
ORDER BY mean_exec_time DESC
LIMIT 10;

-- Check for:
-- - Missing indexes (Seq Scan instead of Index Scan)
-- - N+1 queries
-- - Large result sets (SELECT *)
-- - Expensive joins
-- - Suboptimal query plans
\`\`\`

**For Each Slow Query:**
- Execution time
- Explain plan analysis
- Index recommendations
- Query optimization suggestions

### 3. Resource Usage

**CPU Profiling:**
\`\`\`bash
# Node.js CPU profiling
node --prof app.js
node --prof-process isolate-*.log

# Identify:
# - CPU-intensive functions
# - Synchronous blocking operations
# - Expensive regex/parsing
# - Cryptographic operations
\`\`\`

**Memory Profiling:**
\`\`\`bash
# Check memory usage
node --inspect app.js
# Chrome DevTools → Memory tab

# Look for:
# - Memory leaks (growing heap)
# - Large objects in memory
# - Inefficient caching
# - Uncleared timers/intervals
\`\`\`

### 4. Event Loop / Thread Pool

**Node.js Specific:**
- Event loop lag (target: < 10ms)
- Libuv thread pool saturation
- Blocking operations in event loop

**Python Specific:**
- GIL contention
- Async/await effectiveness
- Worker process utilization

**Java Specific:**
- Thread pool size vs active threads
- Garbage collection pauses
- Heap utilization

### 5. External API Calls

**Third-Party Services:**
\`\`\`javascript
// Profile external API calls
// - Payment gateway (Stripe)
// - Email service (SendGrid)
// - Authentication (Auth0)
// - Analytics APIs

// For each:
// - Average latency
// - Failure rate
// - Retry logic impact
// - Circuit breaker status
\`\`\`

### 6. Caching Effectiveness

**Cache Analysis:**
- Cache hit rate (target: > 80%)
- Cache key distribution
- Cache invalidation strategy
- Memory used by cache

**Redis Performance:**
\`\`\`bash
# Check Redis performance
redis-cli info stats
# - Total commands processed
# - Hit rate
# - Evictions
# - Slow log
\`\`\`

### Output Requirements
1. Write findings to: .tresor/profile-${timestamp}/phase-1-backend.md
2. For each slow endpoint: Detailed breakdown
3. For each issue > threshold: Call /todo-add
4. Include flamegraphs, APM traces

Begin backend performance profiling.
    `
  }) : null,

  // Agent 3: Database Profiling
  layers.includes('database') ? Task({
    subagent_type: 'database-optimizer',
    description: 'Database performance profiling',
    prompt: `
# Performance Profile - Phase 1: Database Analysis

## Context
- Database: ${techStack.database.type}
- Threshold: ${dbThreshold}ms query time
- Profile ID: profile-${timestamp}

## Your Task
Profile database performance and identify bottlenecks:

### 1. Slow Query Identification

**Query Performance:**
\`\`\`sql
-- PostgreSQL slow query log
-- Enable: log_min_duration_statement = ${dbThreshold}

-- Top 10 slowest queries
SELECT
  query,
  mean_exec_time,
  calls,
  total_exec_time,
  (mean_exec_time * calls) as total_time
FROM pg_stat_statements
ORDER BY mean_exec_time DESC
LIMIT 10;
\`\`\`

**For Each Slow Query:**
1. EXPLAIN ANALYZE the query
2. Identify bottleneck (Seq Scan, Sort, Join)
3. Check for missing indexes
4. Suggest optimization

### 2. Index Analysis

**Missing Indexes:**
\`\`\`sql
-- PostgreSQL: Check for Seq Scans that should use indexes
SELECT
  schemaname,
  tablename,
  seq_scan,
  idx_scan,
  CASE WHEN seq_scan > 0
    THEN 100 * idx_scan / (seq_scan + idx_scan)
    ELSE 0
  END as index_usage_pct
FROM pg_stat_user_tables
WHERE (seq_scan + idx_scan) > 0
ORDER BY seq_scan DESC;
\`\`\`

**Unused Indexes:**
\`\`\`sql
-- Find indexes that are never used
SELECT
  schemaname,
  tablename,
  indexname,
  idx_scan
FROM pg_stat_user_indexes
WHERE idx_scan = 0
ORDER BY pg_relation_size(indexrelid) DESC;
\`\`\`

### 3. Connection Pool Analysis

**Connection Metrics:**
- Pool size vs active connections
- Connection wait time
- Idle connection timeout
- Connection leak detection

**PostgreSQL:**
\`\`\`sql
-- Check current connections
SELECT count(*) as total_connections,
       count(*) FILTER (WHERE state = 'active') as active,
       count(*) FILTER (WHERE state = 'idle') as idle
FROM pg_stat_activity;
\`\`\`

### 4. Table/Index Bloat

**Identify Bloat:**
\`\`\`sql
-- PostgreSQL bloat analysis
-- Tables that need VACUUM
SELECT
  schemaname,
  tablename,
  n_dead_tup,
  n_live_tup,
  ROUND(100 * n_dead_tup / (n_live_tup + n_dead_tup), 2) as dead_pct
FROM pg_stat_user_tables
WHERE n_live_tup > 0
ORDER BY n_dead_tup DESC
LIMIT 10;
\`\`\`

### 5. Lock Contention

**Blocking Queries:**
\`\`\`sql
-- Find queries blocking others
SELECT
  blocked_locks.pid AS blocked_pid,
  blocked_activity.query AS blocked_query,
  blocking_locks.pid AS blocking_pid,
  blocking_activity.query AS blocking_query
FROM pg_locks blocked_locks
JOIN pg_stat_activity blocked_activity ON blocked_activity.pid = blocked_locks.pid
JOIN pg_locks blocking_locks ON blocking_locks.locktype = blocked_locks.locktype
JOIN pg_stat_activity blocking_activity ON blocking_activity.pid = blocking_locks.pid
WHERE NOT blocked_locks.granted;
\`\`\`

### 6. Cache Hit Ratio

**Buffer Cache:**
\`\`\`sql
-- PostgreSQL cache hit ratio (target: > 99%)
SELECT
  sum(heap_blks_read) as heap_read,
  sum(heap_blks_hit) as heap_hit,
  sum(heap_blks_hit) / (sum(heap_blks_hit) + sum(heap_blks_read)) * 100 as cache_hit_ratio
FROM pg_statio_user_tables;
\`\`\`

### Output Requirements
1. Write findings to: .tresor/profile-${timestamp}/phase-1-database.md
2. Include EXPLAIN ANALYZE outputs for slow queries
3. Provide specific index recommendations
4. For each issue: Call /todo-add with SQL to fix

Begin database performance profiling.
    `
  }) : null,
].filter(Boolean));

// Progress update
await TodoWrite({
  todos: [
    { content: "Phase 1: Performance Profiling", status: "completed", activeForm: "Performance profiling completed" },
    { content: "Phase 2: Bottleneck Analysis", status: "in_progress", activeForm: "Analyzing bottlenecks" },
    { content: "Phase 3: Optimization Recommendations", status: "pending", activeForm: "Generating recommendations" }
  ]
});
```

**Auto-Capture Performance Issues**:
```javascript
// For each bottleneck > threshold, auto-create todo
for (const bottleneck of criticalBottlenecks) {
  await SlashCommand({
    command: `/todo-add "${bottleneck.layer}: ${bottleneck.issue} - ${bottleneck.optimization}"`
  });
}
```

---

### Phase 2: Deep Bottleneck Analysis (Sequential)

**Agent**:
- `@root-cause-analyzer` (why is it slow?)

**Execution**:
```javascript
// Load Phase 1 results
const phase1Bottlenecks = await Read({
  file_path: `.tresor/profile-${timestamp}/phase-1-*.md`
});

const phase2Results = await Task({
  subagent_type: 'root-cause-analyzer',
  description: 'Root cause analysis of performance bottlenecks',
  prompt: `
# Performance Profile - Phase 2: Root Cause Analysis

## Bottlenecks from Phase 1
${phase1Bottlenecks}

## Your Task
Perform root cause analysis for each critical bottleneck:

### Analysis Framework

For each bottleneck, answer:
1. **What** is slow?
2. **Why** is it slow?
3. **When** did it become slow? (regression analysis)
4. **How** can it be fixed?
5. **What** is the expected improvement?

### Example Analysis

**Bottleneck:** POST /api/users endpoint (850ms, target: < 500ms)

**Breakdown:**
- Database query: 720ms (85%)
- Compute: 80ms (9%)
- External API: 50ms (6%)

**Root Cause Deep Dive:**
1. Database query is slow → Why?
   - EXPLAIN shows Seq Scan on users table
   - Missing index on email column
   - Query searches by email (WHERE email = ?)

2. Why no index?
   - Index was present
   - Dropped during migration rollback (2 weeks ago)
   - Not re-added

3. How to fix?
   \`\`\`sql
   CREATE INDEX idx_users_email ON users(email);
   \`\`\`

4. Expected improvement:
   - Query: 720ms → 15ms (-705ms, -98%)
   - Endpoint: 850ms → 145ms (-705ms, -83%)
   - Will meet target of < 500ms ✓

### Pattern Recognition

Identify systemic issues:
- **N+1 Queries**: Multiple similar queries in loop
- **Missing Caching**: Repeated expensive computations
- **Synchronous Operations**: Blocking operations that could be async
- **Resource Leaks**: Memory/connection leaks causing degradation
- **Inefficient Algorithms**: O(n²) where O(n) is possible

### Regression Analysis

For each bottleneck:
- Was it always slow?
- Recent changes that could have caused it?
- Git blame for relevant code
- Check deployment dates vs performance degradation

### Output Requirements
1. Write analysis to: .tresor/profile-${timestamp}/phase-2-root-cause.md
2. For each bottleneck: Root cause + fix + expected improvement
3. Identify patterns across multiple bottlenecks
4. Prioritize fixes by (impact × ease of implementation)

Begin root cause analysis.
  `
});

// Update progress
await TodoWrite({
  todos: [
    { content: "Phase 1: Performance Profiling", status: "completed", activeForm: "Performance profiling completed" },
    { content: "Phase 2: Bottleneck Analysis", status: "completed", activeForm: "Bottleneck analysis completed" },
    { content: "Phase 3: Optimization Recommendations", status: "in_progress", activeForm: "Generating recommendations" }
  ]
});
```

---

### Phase 3: Optimization Recommendations (Sequential)

**Agent**:
- `@performance-optimization-specialist`

**Execution**:
```javascript
const phase3Results = await Task({
  subagent_type: 'performance-optimization-specialist',
  description: 'Generate optimization recommendations',
  prompt: `
# Performance Profile - Phase 3: Optimization Recommendations

## Complete Performance Analysis
${phase1Bottlenecks}

${await Read({ file_path: `.tresor/profile-${timestamp}/phase-2-root-cause.md` })}

## Your Task
Generate comprehensive optimization recommendations:

### 1. Quick Wins (< 4 hours implementation)

Prioritize by impact/effort ratio:
\`\`\`markdown
#### Add Missing Database Index
- **Impact**: 850ms → 145ms (-705ms, -83%) on POST /api/users
- **Effort**: 15 minutes
- **Implementation**: \`CREATE INDEX idx_users_email ON users(email);\`
- **Risk**: Low (read-only schema change)
- **Todo**: #perf-001

#### Enable Response Compression
- **Impact**: 2.8s → 1.2s (-1.6s, -57%) on page load
- **Effort**: 30 minutes
- **Implementation**: Add compression middleware
- **Risk**: Low (standard practice)
- **Todo**: #perf-002
\`\`\`

### 2. High-Impact Optimizations (4-16 hours)

\`\`\`markdown
#### Implement API Response Caching
- **Impact**: Dashboard API 1.5s → 50ms (-1.45s, -97%)
- **Effort**: 8 hours
- **Implementation**: Redis cache with 5-minute TTL
- **Risk**: Medium (cache invalidation strategy needed)
- **Todo**: #perf-003

#### Code Splitting & Lazy Loading
- **Impact**: Bundle 850KB → 200KB initial (-650KB, -76%)
- **Effort**: 12 hours
- **Implementation**: React.lazy() for route-based splitting
- **Risk**: Medium (testing all routes needed)
- **Todo**: #perf-004
\`\`\`

### 3. Long-Term Improvements (> 16 hours)

\`\`\`markdown
#### Migrate to Server-Side Rendering (SSR)
- **Impact**: LCP 3.2s → 1.8s (-1.4s, -44%)
- **Effort**: 40 hours
- **Implementation**: Next.js migration
- **Risk**: High (major refactor)
- **Considerations**: SEO benefits, infrastructure changes
\`\`\`

### 4. Infrastructure Optimizations

\`\`\`markdown
#### Implement CDN for Static Assets
- **Impact**: Static asset load 2.1s → 0.5s (-1.6s, -76%)
- **Effort**: 4 hours
- **Cost**: $50/month (CloudFront)
- **Implementation**: S3 + CloudFront setup

#### Database Connection Pooling
- **Impact**: Reduce connection overhead 20ms → 2ms per request
- **Effort**: 2 hours
- **Implementation**: Configure pg connection pool
\`\`\`

### 5. Monitoring & Alerting

\`\`\`markdown
#### Performance Monitoring
- Set up: New Relic / Datadog APM
- Track: P95 latency, error rates, throughput
- Alert on: Latency > ${apiThreshold}ms, Error rate > 1%

#### Performance Budgets
- Bundle size: < 200KB initial
- Page load: < 3s
- API latency: P95 < ${apiThreshold}ms
- Database queries: < ${dbThreshold}ms
\`\`\`

### 6. Load Testing Recommendations

\`\`\`markdown
After optimizations, validate with:
- Load testing: /benchmark --duration 5m --rps 100
- Stress testing: Find breaking point
- Spike testing: Handle traffic spikes
- Endurance testing: Memory leaks over time
\`\`\`

### Output Requirements
1. Write recommendations to: .tresor/profile-${timestamp}/phase-3-optimizations.md
2. Prioritize by (impact × ease) score
3. For each recommendation: Implementation guide
4. Create todos for top 10 optimizations
5. Generate before/after metrics predictions

### Recommendations Format
Include:
- Optimization name
- Impact (time saved, % improvement)
- Effort (hours)
- Implementation steps
- Risk level
- Expected metrics after implementation
- Testing strategy

Begin optimization recommendations.
  `
});

await TodoWrite({
  todos: [
    { content: "Phase 1: Performance Profiling", status: "completed", activeForm: "Performance profiling completed" },
    { content: "Phase 2: Bottleneck Analysis", status: "completed", activeForm: "Bottleneck analysis completed" },
    { content: "Phase 3: Optimization Recommendations", status: "completed", activeForm: "Optimization recommendations completed" }
  ]
});
```

---

### Phase 4: Final Output & User Summary

**Consolidated Report**:
```javascript
const finalReport = {
  profileId: `profile-${timestamp}`,
  duration: calculateDuration(startTime),
  layers: layersProfiled,

  baseline: {
    frontend: {
      lcp: '3.2s',
      fid: '85ms',
      cls: '0.15',
      bundleSize: '850KB'
    },
    backend: {
      slowestEndpoint: 'POST /api/users (850ms)',
      avgResponseTime: '245ms',
      p95ResponseTime: '680ms'
    },
    database: {
      slowestQuery: 'SELECT * FROM users WHERE email = ? (720ms)',
      cacheHitRate: '94%',
      connectionPoolUsage: '65%'
    }
  },

  bottlenecks: {
    critical: criticalBottlenecks,  // > 2x threshold
    high: highBottlenecks,          // > threshold
    medium: mediumBottlenecks,      // Close to threshold
  },

  optimizations: {
    quickWins: quickWinOptimizations,
    highImpact: highImpactOptimizations,
    longTerm: longTermOptimizations,
  },

  todos: todosCreated,
  prompts: promptsGenerated,
};

// Write final report
await Write({
  file_path: `.tresor/profile-${timestamp}/final-performance-report.md`,
  content: generatePerformanceReport(finalReport)
});
```

**User Output**:
```markdown
# Performance Profile Complete! ⚡

**Profile ID**: profile-2025-11-19-170322
**Layers Profiled**: Frontend, Backend, Database
**Duration**: 45 minutes

## Performance Baseline

### Frontend
- **LCP**: 3.2s ⚠️ (Target: < 2.5s)
- **FID**: 85ms ✓ (Target: < 100ms)
- **CLS**: 0.15 ✗ (Target: < 0.1)
- **Bundle Size**: 850KB (gzipped: 280KB) ⚠️

### Backend
- **Slowest Endpoint**: POST /api/users (850ms) ✗
- **Average Response**: 245ms ✓
- **P95 Response**: 680ms ⚠️

### Database
- **Slowest Query**: 720ms ✗
- **Cache Hit Rate**: 94% ✓
- **Missing Indexes**: 3 found ✗

## Critical Bottlenecks (5)

1. **Missing Database Index** - POST /api/users (850ms → 145ms)
   - Impact: -705ms (-83%)
   - Effort: 15 minutes
   - Fix: CREATE INDEX idx_users_email
   - Todo: #perf-001

2. **Large JavaScript Bundle** - Page load (3.2s → 1.8s)
   - Impact: -1.4s (-44%)
   - Effort: 12 hours (code splitting)
   - Todo: #perf-004

3. **No Response Compression** - Page load (2.8s → 1.2s)
   - Impact: -1.6s (-57%)
   - Effort: 30 minutes
   - Todo: #perf-002

4. **Dashboard API No Caching** - /api/dashboard (1.5s → 50ms)
   - Impact: -1.45s (-97%)
   - Effort: 8 hours
   - Todo: #perf-003

5. **Unoptimized Images** - Page load contributes 800ms
   - Impact: -600ms (-75% image load)
   - Effort: 4 hours (WebP conversion)
   - Todo: #perf-005

## Quick Wins (< 4 hours) - Potential: -2.4s improvement

1. Add database index (15 min) - -705ms
2. Enable compression (30 min) - -1.6s
3. Memoize React components (2 hours) - -85ms

Total impact: -2.39s with only 2.75 hours of work!

## Optimization Roadmap

### Immediate (< 1 day) - 2.75 hours
- [ ] Add missing database index (#perf-001) - 15m
- [ ] Enable response compression (#perf-002) - 30m
- [ ] Fix React re-renders (#perf-006) - 2h

### Short-term (1-7 days) - 24 hours
- [ ] Implement API caching (#perf-003) - 8h
- [ ] Code splitting & lazy loading (#perf-004) - 12h
- [ ] Optimize images (WebP) (#perf-005) - 4h

### Long-term (> 7 days) - 50 hours
- [ ] Migrate to Next.js (SSR) (#perf-007) - 40h
- [ ] Implement service worker (#perf-008) - 10h

## Expected Performance After Optimizations

### Frontend (After Quick Wins + Short-term)
- LCP: 3.2s → **1.4s** ✓ (Target achieved!)
- Bundle: 850KB → **200KB** ✓ (Target achieved!)
- Page load: 3.2s → **1.5s** ✓

### Backend (After Immediate)
- POST /api/users: 850ms → **145ms** ✓
- Dashboard: 1.5s → **50ms** ✓
- P95: 680ms → **200ms** ✓

### Database (After Immediate)
- Query time: 720ms → **15ms** ✓
- All queries: < 100ms ✓

## Reports Generated

All reports saved to `.tresor/profile-2025-11-19-170322/`:
- `phase-1-frontend.md` - Frontend profiling results
- `phase-1-backend.md` - Backend profiling results
- `phase-1-database.md` - Database profiling results
- `phase-2-root-cause.md` - Root cause analysis
- `phase-3-optimizations.md` - Detailed optimization guide
- `final-performance-report.md` - Consolidated report
- `metrics-baseline.json` - Baseline metrics for tracking

## Todos Created

10 performance todos auto-created:
- 3 Quick wins (< 4 hours)
- 5 High-impact (4-16 hours)
- 2 Long-term (> 16 hours)

Run `/todo-check` to systematically implement optimizations.

## Next Steps

1. Implement 3 quick wins (2.75 hours) → **-2.4s improvement**
2. Validate with load testing: `/benchmark --duration 5m`
3. Implement short-term optimizations (24 hours) → **Additional -3.2s**
4. Re-run profiling: `/profile --layers all` to verify improvements
5. Set up continuous performance monitoring (New Relic/Datadog)
```

---

## Integration with Tresor Workflow

### Automatic `/todo-add`
```bash
# Every bottleneck > threshold creates todo:
/todo-add "Database: Add missing index on users.email - CREATE INDEX idx_users_email"
/todo-add "Frontend: Enable response compression - Add compression middleware"
```

### Automatic `/prompt-create`
```bash
# Complex optimizations → expert prompts
/prompt-create "Implement code splitting and lazy loading for React application"
# → Creates ./prompts/006-react-code-splitting.md
```

---

## Command Options

### `--layers`
```bash
/profile --layers frontend           # Frontend only
/profile --layers backend,database   # Multiple layers
/profile --layers all                # All layers (default)
```

### `--depth`
```bash
/profile --depth quick      # 15 min (surface-level)
/profile --depth standard   # 45 min (default, thorough)
/profile --depth deep       # 2 hours (comprehensive)
```

### `--threshold`
```bash
/profile --threshold 200ms   # Custom API threshold
/profile --threshold 1s      # More lenient threshold
```

---

## Success Criteria

Profiling is successful if:
- ✅ All requested layers profiled
- ✅ Baseline metrics captured
- ✅ Bottlenecks identified with root causes
- ✅ Optimization recommendations provided with expected impact
- ✅ Todos created for all significant issues
- ✅ Before/after metrics predictions included

---

## Meta Instructions

1. **Profile comprehensively** - Don't assume what's slow
2. **Provide measurable improvements** - Always include "before → after"
3. **Prioritize by impact** - Quick wins first
4. **Include implementation details** - Not just "optimize database"
5. **Set up baseline** - For tracking progress over time
6. **Auto-capture todos** - Use `/todo-add` for all fixes

---

**Begin comprehensive performance profiling.**
