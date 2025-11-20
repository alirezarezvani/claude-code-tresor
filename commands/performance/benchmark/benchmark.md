---
name: benchmark
description: Load testing and performance benchmarking with intelligent scenario generation
argument-hint: [--duration 5m,10m,30m] [--rps 10,50,100] [--pattern baseline,stress,spike,soak] [--tool locust,artillery,k6]
allowed-tools: Task, Read, Write, Edit, Bash, Glob, Grep, SlashCommand, AskUserQuestion
model: inherit
enabled: true
---

# Performance Benchmarking - Load Testing & Scalability Analysis

You are an expert performance benchmarking orchestrator managing load testing and scalability analysis using Tresor's performance testing agents. Your goal is to validate system performance under load, identify scalability limits, and provide capacity planning recommendations.

## Command Purpose

Perform comprehensive load testing with:
- **Intelligent scenario generation** - Auto-detect API endpoints and create realistic test scenarios
- **Multiple test patterns** - Baseline, stress, spike, soak, scalability testing
- **Multi-tool support** - Locust, Artillery, k6, JMeter
- **Bottleneck identification** - What breaks first under load?
- **Capacity planning** - How many users can the system handle?
- **Regression detection** - Compare with previous benchmarks

---

## Execution Flow

### Phase 0: Benchmark Planning

**Step 1: Parse Arguments**
```javascript
const args = parseArguments($ARGUMENTS);
// --duration: 1m, 5m, 10m, 30m (default: 5m)
// --rps: requests per second (default: auto-detect based on current traffic)
// --pattern: baseline, stress, spike, soak, scalability (default: baseline)
// --tool: locust, artillery, k6, jmeter (default: auto-select based on tech stack)
```

**Step 2: Detect API Endpoints & Generate Scenarios**

Analyze codebase to find all API endpoints:
```javascript
const endpoints = await detectAPIEndpoints();

// Example detection:
// Express.js: Scan for app.get(), app.post(), router.get(), etc.
// FastAPI: Scan for @app.get(), @app.post()
// Spring Boot: Scan for @GetMapping, @PostMapping

// Example output:
{
  endpoints: [
    { method: 'GET', path: '/api/users', auth: true, avgLatency: 45ms },
    { method: 'GET', path: '/api/users/:id', auth: true, avgLatency: 32ms },
    { method: 'POST', path: '/api/users', auth: false, avgLatency: 850ms },
    { method: 'GET', path: '/api/dashboard', auth: true, avgLatency: 1500ms },
    { method: 'GET', path: '/api/products', auth: false, avgLatency: 180ms },
  ],
  authRequired: ['GET /api/users', 'GET /api/dashboard'],
  publicEndpoints: ['POST /api/users', 'GET /api/products'],
  totalEndpoints: 15
}
```

**Step 3: Select Load Testing Tool**

Auto-select based on tech stack and requirements:
```javascript
function selectLoadTestingTool(techStack, pattern, duration) {
  const tools = {
    locust: {
      bestFor: ['python', 'complex-scenarios', 'distributed-load'],
      pros: 'Python-based, real browser simulation, distributed testing',
      cons: 'Requires Python environment',
    },
    artillery: {
      bestFor: ['javascript', 'quick-tests', 'ci-cd'],
      pros: 'Fast, YAML config, easy to use',
      cons: 'Less flexible than Locust',
    },
    k6: {
      bestFor: ['high-rps', 'cloud-native', 'grafana-integration'],
      pros: 'Very high performance, JavaScript DSL, Grafana dashboards',
      cons: 'Less mature ecosystem',
    },
    jmeter: {
      bestFor: ['enterprise', 'complex-protocols', 'legacy-systems'],
      pros: 'Feature-rich, GUI, many protocols',
      cons: 'Resource-heavy, complex setup',
    },
  };

  // Auto-select logic
  if (techStack.backend === 'python') return 'locust';
  if (duration < '5m') return 'artillery';  // Fast tests
  if (pattern === 'stress' || pattern === 'spike') return 'k6';  // High RPS
  return 'artillery';  // Default: balance of speed and features
}
```

**Step 4: Generate Load Test Scenarios**

Based on test pattern:
```javascript
const scenarios = generateScenarios(endpoints, pattern);

// Baseline Test (validates current capacity):
{
  name: 'baseline',
  duration: '5m',
  users: 50,  // Current average concurrent users
  rampUp: '30s',
  description: 'Baseline test at current traffic levels'
}

// Stress Test (find breaking point):
{
  name: 'stress',
  phases: [
    { duration: '2m', users: 50 },   // Warm-up
    { duration: '5m', users: 200 },  // 4x current traffic
    { duration: '5m', users: 500 },  // 10x current traffic
    { duration: '5m', users: 1000 }, // 20x current traffic
    { duration: '2m', users: 50 },   // Cool-down
  ],
  description: 'Gradually increase load to find breaking point'
}

// Spike Test (sudden traffic surge):
{
  name: 'spike',
  phases: [
    { duration: '2m', users: 50 },    // Normal
    { duration: '30s', users: 500 },  // Sudden spike
    { duration: '2m', users: 50 },    // Back to normal
  ],
  description: 'Simulate sudden traffic spike (Black Friday, viral post)'
}

// Soak Test (memory leaks, resource exhaustion):
{
  name: 'soak',
  duration: '2h',
  users: 100,  // 2x current traffic
  description: 'Long-duration test to detect memory leaks'
}
```

**Step 5: User Confirmation**

```javascript
await AskUserQuestion({
  questions: [{
    question: "Benchmark plan ready. Proceed?",
    header: "Confirm Benchmark",
    multiSelect: false,
    options: [
      {
        label: "Execute benchmark",
        description: `${pattern} test, ${duration}, ${rps} RPS, ${tool} tool`
      },
      {
        label: "Adjust load",
        description: "Change RPS, duration, or pattern"
      },
      {
        label: "Review scenarios",
        description: "See generated load test scenarios before running"
      },
      {
        label: "Cancel",
        description: "Exit without benchmarking"
      }
    ]
  }]
});
```

---

### Phase 1: Test Scenario Generation

**Agent:**
- `@api-load-test-generator`

**Execution:**
```javascript
const phase1Results = await Task({
  subagent_type: 'api-load-test-generator',
  description: 'Generate load test scenarios',
  prompt: `
# Benchmark - Phase 1: Test Scenario Generation

## Context
- Endpoints: ${endpoints.length} detected
- Tool: ${selectedTool}
- Pattern: ${pattern}
- Duration: ${duration}
- Target RPS: ${rps}

## Your Task
Generate realistic load test scenarios:

### 1. Endpoint Analysis

For each endpoint:
\`\`\`javascript
{
  method: 'POST',
  path: '/api/users',
  auth: false,
  currentLatency: '850ms',
  expectedRPS: 5,  // Based on current traffic patterns
  payload: {
    name: '{{randomName}}',
    email: '{{randomEmail}}',
    password: '{{randomPassword}}'
  }
}
\`\`\`

### 2. User Flow Modeling

Create realistic user flows:
\`\`\`javascript
// Example: E-commerce user flow
{
  name: 'typical_user_flow',
  weight: 70,  // 70% of traffic
  steps: [
    { GET: '/api/products', weight: 1.0 },
    { GET: '/api/products/:id', weight: 0.5 },  // 50% click on product
    { POST: '/api/cart/add', weight: 0.3 },     // 30% add to cart
    { GET: '/api/cart', weight: 0.3 },
    { POST: '/api/checkout', weight: 0.1 },     // 10% complete purchase
  ]
}

// Power user flow
{
  name: 'power_user_flow',
  weight: 20,  // 20% of traffic
  steps: [
    { GET: '/api/dashboard', weight: 1.0 },
    { GET: '/api/analytics', weight: 0.8 },
    { POST: '/api/reports', weight: 0.5 },
  ]
}

// Anonymous user flow
{
  name: 'anonymous_flow',
  weight: 10,  // 10% of traffic
  steps: [
    { GET: '/api/products', weight: 1.0 },
    { GET: '/api/products/featured', weight: 0.6 },
  ]
}
\`\`\`

### 3. Generate Load Test Script

**For Artillery:**
\`\`\`yaml
config:
  target: 'https://api.example.com'
  phases:
    - duration: 60
      arrivalRate: 10
      name: "Warm-up"
    - duration: 300
      arrivalRate: ${rps}
      name: "Sustained load"
  plugins:
    metrics-by-endpoint: {}

scenarios:
  - name: "Typical user flow"
    weight: 70
    flow:
      - get:
          url: "/api/products"
      - think: 2
      - get:
          url: "/api/products/{{ $randomNumber(1, 100) }}"
      - think: 5
      - post:
          url: "/api/cart/add"
          json:
            productId: "{{ $randomNumber(1, 100) }}"
            quantity: "{{ $randomNumber(1, 5) }}"

  - name: "Power user flow"
    weight: 20
    flow:
      - get:
          url: "/api/dashboard"
          beforeRequest: "setAuthToken"
\`\`\`

**For Locust (Python):**
\`\`\`python
from locust import HttpUser, task, between

class TypicalUser(HttpUser):
    weight = 70
    wait_time = between(1, 5)

    @task(10)
    def view_products(self):
        self.client.get("/api/products")

    @task(5)
    def view_product_details(self):
        product_id = random.randint(1, 100)
        self.client.get(f"/api/products/{product_id}")

    @task(3)
    def add_to_cart(self):
        self.client.post("/api/cart/add", json={
            "productId": random.randint(1, 100),
            "quantity": random.randint(1, 5)
        })

class PowerUser(HttpUser):
    weight = 20
    wait_time = between(1, 3)

    def on_start(self):
        # Login to get auth token
        response = self.client.post("/api/login", json={
            "email": "poweruser@example.com",
            "password": "testpass"
        })
        self.token = response.json()['token']

    @task
    def view_dashboard(self):
        self.client.get("/api/dashboard",
            headers={"Authorization": f"Bearer {self.token}"})
\`\`\`

### 4. Authentication Handling

For endpoints requiring auth:
\`\`\`javascript
// Generate test users
const testUsers = generateTestUsers(100);

// Before load test:
// 1. Create test user accounts
// 2. Generate auth tokens
// 3. Distribute tokens across virtual users
// 4. Include token refresh logic (if JWT expiry)
\`\`\`

### Output Requirements
1. Write test scenarios to: .tresor/benchmark-${timestamp}/test-scenarios.md
2. Generate executable test script: .tresor/benchmark-${timestamp}/load-test.{yml|py}
3. Document expected traffic patterns
4. Create setup instructions (test data, auth tokens)

Begin load test scenario generation.
  `
});

// Progress update
await TodoWrite({
  todos: [
    { content: "Phase 1: Scenario Generation", status: "completed", activeForm: "Scenario generation completed" },
    { content: "Phase 2: Load Test Execution", status: "in_progress", activeForm: "Executing load tests" },
    { content: "Phase 3: Results Analysis", status: "pending", activeForm: "Analyzing results" }
  ]
});
```

---

### Phase 2: Load Test Execution

**Execution Strategy:**

**Sequential vs Parallel:**
```javascript
// Check if environment can handle parallel load tests
const canRunParallel = await checkEnvironmentCapacity();

if (canRunParallel && pattern === 'baseline') {
  // Run multiple test profiles in parallel (different endpoints)
  const phase2Results = await runParallelLoadTests();
} else {
  // Run sequential (stress, spike, soak patterns)
  const phase2Results = await runSequentialLoadTests();
}
```

**For Baseline Pattern (parallel possible):**
```javascript
const phase2Results = await Promise.all([
  Task({
    subagent_type: 'api-performance-benchmarker',
    description: 'Benchmark read-heavy endpoints',
    prompt: `
# Benchmark - Phase 2: Load Test Execution (Read Endpoints)

## Test Configuration
- Tool: ${selectedTool}
- Duration: ${duration}
- Target RPS: ${rps}
- Pattern: Baseline

## Endpoints to Test
${readEndpoints}

## Test Execution

### 1. Pre-Test Validation
\`\`\`bash
# Verify environment is ready
curl -f https://api.example.com/health || exit 1

# Check baseline performance (no load)
for i in {1..10}; do
  curl -w "Time: %{time_total}s\\n" https://api.example.com/api/users
done
\`\`\`

### 2. Run Load Test
\`\`\`bash
# Artillery example
artillery run load-test-read.yml --output results-read.json
\`\`\`

### 3. Capture Metrics During Test

Monitor:
- **Latency**: min, max, mean, median, p95, p99
- **Throughput**: requests/sec, successful/failed
- **Error Rate**: 4xx, 5xx errors
- **Response Codes**: Distribution of status codes
- **Resource Usage**:
  - CPU usage (target: < 80%)
  - Memory usage
  - Database connections
  - Network bandwidth

### 4. Identify Breaking Points

Watch for:
- Latency degradation (P95 > 2x normal)
- Error rate increase (> 1%)
- Timeouts
- Connection pool saturation
- Database connection exhaustion

### Output Requirements
1. Write results to: .tresor/benchmark-${timestamp}/phase-2-read-endpoints.json
2. Include: Latency histogram, throughput graph, error rates
3. If errors/timeouts: Call /todo-add immediately
4. Capture resource usage (CPU, memory, connections)

Begin load test execution for read endpoints.
    `
  }),

  Task({
    subagent_type: 'api-performance-benchmarker',
    description: 'Benchmark write-heavy endpoints',
    prompt: `[Similar structure for write endpoints]`
  }),

  Task({
    subagent_type: 'api-performance-benchmarker',
    description: 'Benchmark mixed traffic patterns',
    prompt: `[Similar structure for realistic user flows]`
  })
]);
```

**For Stress/Spike/Soak Patterns (sequential required):**
```javascript
const phase2Results = await Task({
  subagent_type: 'stress-test-orchestrator',
  description: `${pattern} test execution`,
  prompt: `
# Benchmark - Phase 2: ${pattern.toUpperCase()} Test Execution

## Test Pattern: ${pattern}

### Stress Test Configuration
\`\`\`yaml
# Gradually increase load until system breaks
phases:
  - duration: 2m
    arrivalRate: 50    # Baseline
  - duration: 5m
    arrivalRate: 200   # 4x baseline
  - duration: 5m
    arrivalRate: 500   # 10x baseline
  - duration: 5m
    arrivalRate: 1000  # 20x baseline (find breaking point)
  - duration: 2m
    arrivalRate: 50    # Recovery
\`\`\`

### What to Measure

**Per Phase:**
1. Latency (P50, P95, P99)
2. Throughput (successful RPS)
3. Error rate
4. Resource utilization (CPU, memory, DB connections)

**Breaking Point Detection:**
- When does P95 > 2x baseline?
- When does error rate > 1%?
- When do timeouts start occurring?
- When does throughput plateau despite increased load?

### System Resource Monitoring

**Application Server:**
\`\`\`bash
# Monitor during test
top -b -d 1 | grep node
free -h
netstat -an | grep ESTABLISHED | wc -l
\`\`\`

**Database:**
\`\`\`sql
-- Monitor connections during load test
SELECT count(*) as total,
       count(*) FILTER (WHERE state = 'active') as active,
       count(*) FILTER (WHERE state = 'idle') as idle,
       max(now() - query_start) as longest_query
FROM pg_stat_activity
WHERE datname = 'mydb';
\`\`\`

**Metrics to Capture:**
- At what RPS does latency degrade?
- At what RPS do errors start?
- What resource exhausts first? (CPU, memory, DB connections, network)
- Can system recover after spike?

### Output Requirements
1. Write results to: .tresor/benchmark-${timestamp}/phase-2-${pattern}-test.json
2. Include performance degradation analysis
3. Identify bottleneck resource (what failed first)
4. For each bottleneck: Call /todo-add
5. Generate capacity recommendation

Begin ${pattern} test execution.
  `
});

// Update progress
await TodoWrite({
  todos: [
    { content: "Phase 1: Scenario Generation", status: "completed", activeForm: "Scenario generation completed" },
    { content: "Phase 2: Load Test Execution", status: "completed", activeForm: "Load test execution completed" },
    { content: "Phase 3: Results Analysis", status: "in_progress", activeForm: "Analyzing results" }
  ]
});
```

---

### Phase 3: Results Analysis & Recommendations

**Agent:**
- `@performance-analyst`

**Execution:**
```javascript
const phase3Results = await Task({
  subagent_type: 'performance-analyst',
  description: 'Analyze benchmark results and generate recommendations',
  prompt: `
# Benchmark - Phase 3: Results Analysis

## Load Test Results
${await Read({ file_path: `.tresor/benchmark-${timestamp}/phase-2-*.json` })}

## Your Task
Analyze load test results and provide recommendations:

### 1. Performance Summary

**Latency Analysis:**
\`\`\`markdown
| Metric | Baseline | Under Load | Degradation |
|--------|----------|------------|-------------|
| P50    | 45ms     | 120ms      | +75ms (+167%) |
| P95    | 120ms    | 680ms      | +560ms (+467%) ⚠️ |
| P99    | 250ms    | 1.8s       | +1.55s (+620%) ✗ |
\`\`\`

**Throughput:**
- Target: ${rps} RPS
- Achieved: ${actualRPS} RPS (${achievementPct}%)
- Successful: ${successRate}%
- Failed: ${failureRate}%

### 2. Identify Performance Cliffs

**When does performance degrade?**
\`\`\`markdown
Load Level Analysis:
- 50 RPS: P95 = 120ms ✓ (Good)
- 100 RPS: P95 = 200ms ✓ (Acceptable)
- 200 RPS: P95 = 680ms ⚠️ (Degrading)
- 500 RPS: P95 = 2.5s ✗ (Unacceptable)
- 1000 RPS: Error rate > 10% ✗ (System breaking)

**Breaking Point**: 400-500 RPS
- P95 crosses 1s threshold at ~450 RPS
- Error rate spikes at 500 RPS
- Database connection pool exhausted at 500 RPS
\`\`\`

### 3. Bottleneck Under Load

**What failed first?**
\`\`\`markdown
Resource Exhaustion Order:
1. Database connections (maxed at 500 RPS) ← PRIMARY BOTTLENECK
2. CPU (90% at 800 RPS)
3. Memory (85% at 1000 RPS)

Root Cause:
- Database connection pool: 20 connections
- At 500 RPS, all connections saturated
- New requests wait for connection → latency spike
\`\`\`

### 4. Scalability Analysis

**How does system scale?**
\`\`\`markdown
Scalability Curve:
- Linear scaling: 0-200 RPS ✓
- Degraded scaling: 200-500 RPS ⚠️
- Breaking point: 500+ RPS ✗

Scaling Efficiency:
- 2x load (50 → 100 RPS): Latency +67% (acceptable)
- 4x load (50 → 200 RPS): Latency +467% (poor)
- 10x load (50 → 500 RPS): System breaks

Conclusion: System does NOT scale linearly beyond 200 RPS
\`\`\`

### 5. Recommendations

**Immediate (to handle 500 RPS):**
1. **Increase database connection pool** (1 hour)
   - Current: 20 connections
   - Recommended: 50 connections
   - Expected: Supports up to 800 RPS
   - Todo: #bench-001

2. **Add horizontal scaling** (4 hours)
   - Current: 1 server
   - Recommended: 3 servers + load balancer
   - Expected: Supports up to 1500 RPS
   - Todo: #bench-002

**Short-term (to handle 1000+ RPS):**
3. **Implement connection pooling middleware** (8 hours)
   - Current: Create new connection per request
   - Recommended: Reuse connections
   - Expected: -50ms latency, +60% capacity
   - Todo: #bench-003

4. **Database read replicas** (16 hours)
   - Route SELECT queries to read replicas
   - Expected: 3x read capacity
   - Todo: #bench-004

**Long-term (to handle 5000+ RPS):**
5. **Implement caching layer** (24 hours)
   - Redis for frequently accessed data
   - Expected: -90% database load
   - Todo: #bench-005

6. **Microservices architecture** (200 hours)
   - Separate services can scale independently
   - Expected: Near-linear scalability

### 6. Capacity Planning

**Current Capacity:**
- Comfortable: 200 RPS (P95 < 500ms, error rate < 0.1%)
- Maximum: 450 RPS (P95 < 1s, error rate < 1%)
- Breaking: 500+ RPS (errors, timeouts)

**With Recommended Optimizations:**
- Comfortable: 800 RPS (after connection pool increase)
- Maximum: 1500 RPS (after horizontal scaling)
- Comfortable: 5000 RPS (after caching layer)

**Projected Growth:**
- Current traffic: 50 RPS average
- 6-month projection: 200 RPS (4x growth)
- 12-month projection: 500 RPS (10x growth)

**Recommendation:** Implement connection pool increase and horizontal scaling NOW to support projected 12-month growth.

### Output Requirements
1. Write analysis to: .tresor/benchmark-${timestamp}/phase-3-analysis.md
2. Include latency histograms, throughput graphs
3. Generate capacity planning report
4. Create todos for all scaling recommendations
5. Provide cost estimates for infrastructure changes

Begin benchmark results analysis.
  `
});

await TodoWrite({
  todos: [
    { content: "Phase 1: Scenario Generation", status: "completed", activeForm: "Scenario generation completed" },
    { content: "Phase 2: Load Test Execution", status: "completed", activeForm: "Load test execution completed" },
    { content: "Phase 3: Results Analysis", status: "completed", activeForm: "Results analysis completed" }
  ]
});
```

---

### Phase 4: Final Output

**User Summary:**
```markdown
# Benchmark Complete! 📊

**Benchmark ID**: benchmark-2025-11-19-180322
**Pattern**: Baseline
**Duration**: 5 minutes
**Target RPS**: 100
**Achieved RPS**: 98 (98%)

## Performance Results

### Latency
| Metric | No Load | Under Load (100 RPS) | Degradation |
|--------|---------|----------------------|-------------|
| **P50** | 45ms | 120ms | +75ms (+167%) |
| **P95** | 120ms | 340ms | +220ms (+183%) |
| **P99** | 250ms | 850ms | +600ms (+240%) ⚠️ |

### Throughput
- **Target**: 100 RPS
- **Achieved**: 98 RPS (98% success rate)
- **Failed Requests**: 2%
- **Timeouts**: 0.5%

### Resource Utilization
- **CPU**: 65% ✓
- **Memory**: 1.4GB / 2GB (70%) ✓
- **Database Connections**: 18 / 20 (90%) ⚠️
- **Network**: 45 Mbps ✓

## Bottleneck Under Load

**Primary Bottleneck**: Database connection pool saturation
- Connections used: 18 / 20 (90%)
- At 150 RPS, pool would be exhausted
- Causing P99 latency degradation

**Secondary Bottleneck**: POST /api/users endpoint (slow query)
- Latency: 850ms → 1.2s under load (+41%)
- Root cause: Missing database index (from /profile results)

## Capacity Analysis

**Current Capacity:**
- **Comfortable**: 80-100 RPS (P95 < 500ms, errors < 1%)
- **Maximum**: 150 RPS (P95 approaching 1s)
- **Breaking Point**: 200 RPS (connection pool exhausted)

**With Optimizations:**
- Increase connection pool to 50: **250 RPS**
- Add horizontal scaling (3 servers): **750 RPS**
- Implement caching: **2000+ RPS**

## Scalability Recommendations

### Immediate (< 1 day) - 5 hours
- [ ] Increase DB connection pool (20 → 50) - 1h - #bench-001
- [ ] Fix slow database query (add index) - 15m - #bench-002
- [ ] Optimize resource allocation - 4h - #bench-003

**Expected Capacity After:** 250 RPS (2.5x improvement)

### Short-term (1-7 days) - 20 hours
- [ ] Horizontal scaling (1 → 3 servers) - 4h - #bench-004
- [ ] Load balancer setup - 4h - #bench-005
- [ ] Redis caching implementation - 8h - #bench-006
- [ ] Database read replicas - 4h - #bench-007

**Expected Capacity After:** 2000+ RPS (20x improvement)

## Load Test Artifacts

All artifacts saved to `.tresor/benchmark-2025-11-19-180322/`:
- `test-scenarios.md` - Generated test scenarios
- `load-test.yml` - Executable Artillery script
- `load-test.py` - Executable Locust script (alternative)
- `results.json` - Raw load test results
- `latency-histogram.png` - Latency distribution chart
- `throughput-graph.png` - Throughput over time
- `resource-usage.png` - CPU/memory/connections
- `phase-3-analysis.md` - Detailed analysis report
- `final-benchmark-report.md` - Consolidated report

## Comparison with Previous Benchmarks

\`\`\`markdown
| Date | RPS | P95 Latency | Error Rate | Capacity |
|------|-----|-------------|------------|----------|
| 2025-10-15 | 100 | 850ms | 5% | 120 RPS |
| 2025-11-01 | 100 | 450ms | 2% | 180 RPS |
| 2025-11-19 | 100 | 340ms | 2% | 200 RPS |

**Progress**: P95 improved from 850ms → 340ms (-60%) over 5 weeks
**Capacity**: Improved from 120 RPS → 200 RPS (+67%)
\`\`\`

## Next Steps

1. Implement quick wins (5 hours) → **2.5x capacity improvement**
2. Run stress test: `/benchmark --pattern stress` to find new breaking point
3. Implement scaling recommendations (20 hours) → **20x capacity**
4. Re-run benchmark to validate: `/benchmark --rps 500`
5. Set up continuous load testing (weekly)
```

---

## Integration with Tresor Workflow

### `/profile` Integration (Recommended Workflow)

```bash
# Step 1: Profile to find bottlenecks
/profile --layers all

# Step 2: Fix identified bottlenecks
# [Implement optimizations from profiling]

# Step 3: Validate with load testing
/benchmark --duration 5m --rps 100

# Step 4: Compare before/after
# Before: P95 = 680ms
# After: P95 = 200ms (-70% improvement)
```

### Automatic `/todo-add`
```bash
# Capacity/scaling issues → todos
/todo-add "Scaling: Increase database connection pool to 50"
/todo-add "Scaling: Add horizontal scaling with 3 servers"
```

---

## Test Patterns Explained

### 1. Baseline Test (Default)
**Purpose:** Validate current capacity
**Load:** Current traffic level (50-100 RPS)
**Duration:** 5-10 minutes
**Use Case:** Weekly validation, regression detection

### 2. Stress Test
**Purpose:** Find breaking point
**Load:** Gradually increase until system breaks
**Duration:** 15-20 minutes
**Use Case:** Capacity planning, scalability analysis

### 3. Spike Test
**Purpose:** Handle traffic surges
**Load:** Sudden spike from normal → 10x → normal
**Duration:** 5 minutes
**Use Case:** Black Friday preparation, viral content readiness

### 4. Soak Test
**Purpose:** Detect memory leaks, resource exhaustion
**Load:** 2x current traffic
**Duration:** 1-2 hours
**Use Case:** Pre-production validation, stability testing

### 5. Scalability Test
**Purpose:** Validate linear scaling
**Load:** Incremental increases with horizontal scaling
**Duration:** 30 minutes
**Use Case:** Cloud auto-scaling validation

---

## Success Criteria

Benchmark is successful if:
- ✅ Load test completes without crashing
- ✅ Performance metrics captured (latency, throughput, errors)
- ✅ Breaking point identified (if stress/spike test)
- ✅ Bottleneck resource identified
- ✅ Capacity recommendations provided
- ✅ Comparison with previous benchmarks (if available)

---

## Meta Instructions

1. **Generate realistic scenarios** - Model actual user behavior
2. **Monitor all resources** - Not just latency
3. **Find breaking point** - Know your limits
4. **Provide capacity numbers** - How many users can you handle?
5. **Compare with baselines** - Track improvement over time
6. **Auto-capture scaling todos** - Use `/todo-add`

---

**Begin performance benchmarking.**
