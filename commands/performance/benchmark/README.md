# `/benchmark` - Load Testing & Performance Benchmarking

> Intelligent load testing with scenario generation, breaking point analysis, and capacity planning

**Version:** 2.7.0
**Category:** Performance
**Type:** Orchestration Command
**Estimated Duration:** 5-30 minutes (depending on pattern)

---

## Overview

The `/benchmark` command performs comprehensive load testing to validate system performance under various traffic patterns. It automatically generates realistic test scenarios, executes load tests, identifies breaking points, and provides capacity planning recommendations.

### `/profile` vs `/benchmark`

| Aspect | `/profile` | `/benchmark` |
|--------|-----------|--------------|
| **Purpose** | Find what's slow | Validate under load |
| **Measures** | Bottlenecks, latency | Throughput, scalability |
| **Load** | No load (profiling) | Simulated traffic |
| **Output** | Optimization roadmap | Capacity limits |
| **Duration** | 15 min - 2 hours | 5-30 minutes |
| **When to Use** | Before optimization | After optimization |

**Recommended Workflow:**
1. **`/profile`** - Find and fix bottlenecks
2. **`/benchmark`** - Validate fixes under load
3. **Repeat** - Continuous improvement

---

## Key Features

- ✅ **Intelligent Scenario Generation** - Auto-detects API endpoints and creates realistic user flows
- ✅ **Multiple Test Patterns** - Baseline, stress, spike, soak, scalability testing
- ✅ **Multi-Tool Support** - Locust, Artillery, k6, JMeter (auto-selected)
- ✅ **Breaking Point Detection** - Find system capacity limits
- ✅ **Resource Monitoring** - Track CPU, memory, database connections during tests
- ✅ **Capacity Planning** - Answers: "How many users can we handle?"
- ✅ **Regression Detection** - Compare with previous benchmarks

---

## Quick Start

### Basic Usage

```bash
# Baseline test (current traffic level, 5 minutes)
/benchmark

# Stress test (find breaking point)
/benchmark --pattern stress

# Quick 1-minute test
/benchmark --duration 1m --rps 50

# High-load test
/benchmark --duration 10m --rps 500
```

### Advanced Usage

```bash
# Spike test (Black Friday simulation)
/benchmark --pattern spike --rps 1000

# Soak test (memory leak detection)
/benchmark --pattern soak --duration 2h

# Custom tool selection
/benchmark --tool k6 --rps 500
```

---

## How It Works

### Phase 0: Benchmark Planning

**API Endpoint Detection:**
```
Detecting API endpoints...

Found 15 endpoints:
- GET /api/users (auth required, 45ms avg)
- GET /api/users/:id (auth required, 32ms avg)
- POST /api/users (public, 850ms avg) ← SLOW
- GET /api/dashboard (auth required, 1500ms avg) ← VERY SLOW
- GET /api/products (public, 180ms avg)
... 10 more endpoints

Traffic Pattern Analysis:
- Read/Write Ratio: 80/20
- Auth Required: 60%
- Average Latency: 245ms
- Current RPS: 50

Recommended Test:
- Pattern: Baseline (validate current capacity)
- Duration: 5 minutes
- Target RPS: 100 (2x current traffic)
- Tool: Artillery (fast, JavaScript-friendly)

Proceed? (y/n/adjust)
```

---

### Phase 1: Test Scenario Generation

**Generated Scenarios:**

**Scenario 1: Typical User Flow (70% of traffic)**
```yaml
- name: "Browse and purchase"
  weight: 70
  flow:
    - get: "/api/products"          # 100% do this
    - think: 2                       # Wait 2 seconds
    - get: "/api/products/{{id}}"   # 50% view details
    - think: 5
    - post: "/api/cart/add"         # 30% add to cart
    - think: 3
    - post: "/api/checkout"         # 10% complete purchase
```

**Scenario 2: Power User Flow (20% of traffic)**
```yaml
- name: "Dashboard analytics"
  weight: 20
  flow:
    - post: "/api/login"
    - get: "/api/dashboard"
    - get: "/api/analytics"
    - post: "/api/reports"
```

**Scenario 3: Anonymous Browse (10% of traffic)**
```yaml
- name: "Anonymous browsing"
  weight: 10
  flow:
    - get: "/api/products"
    - get: "/api/products/featured"
```

**Output:**
```
Phase 1 Complete (5 minutes)
- Endpoints analyzed: 15
- Scenarios generated: 3 (typical, power, anonymous)
- Test script created: .tresor/benchmark-*/load-test.yml

Reports: .tresor/benchmark-2025-11-19/test-scenarios.md
```

---

### Phase 2: Load Test Execution

**Running Load Test...**
```bash
# Artillery execution
artillery run load-test.yml --output results.json

# Real-time output:
Summary report @ 14:32:05
  Scenarios launched:  300
  Scenarios completed: 297
  Requests completed:  1485
  RPS sent: 99
  Request latency:
    min: 12
    max: 1230
    median: 98
    p95: 340
    p99: 850
  Scenario duration:
    min: 1230
    max: 8970
    median: 4560
    p95: 7240
    p99: 8450
  Errors:
    ETIMEDOUT: 3
    500: 5
```

**Resource Monitoring (Concurrent):**
```
Monitoring system resources during load test...

CPU Usage:
- Min: 45%
- Max: 85%
- Avg: 65% ✓

Memory:
- Used: 1.4GB / 2GB (70%) ✓
- Growth rate: +50MB/min ⚠️ (possible leak)

Database Connections:
- Active: 18 / 20 (90%) ⚠️ NEAR LIMIT
- Wait time: Avg 15ms ⚠️

Network:
- Inbound: 45 Mbps
- Outbound: 23 Mbps
```

**Output:**
```
Phase 2 Complete (5 minutes)
- Requests: 1485 total (98% success rate)
- Latency: P95 = 340ms, P99 = 850ms
- Errors: 8 total (0.5% rate)
- Bottleneck: Database connection pool near saturation

Reports: .tresor/benchmark-2025-11-19/phase-2-results.json
```

---

### Phase 3: Results Analysis

**Performance Analysis:**
```
Analyzing benchmark results...

## Latency Breakdown by Endpoint

Slowest Endpoints Under Load:
1. POST /api/users - P95: 1.2s (+41% degradation) ✗
2. GET /api/dashboard - P95: 2.8s (+87% degradation) ✗
3. GET /api/products - P95: 250ms (+39% degradation) ⚠️

## Breaking Point Analysis

Performance Degradation Timeline:
- 0-50 RPS: Linear scaling ✓
- 50-100 RPS: Slight degradation (acceptable) ✓
- 100-150 RPS: Moderate degradation ⚠️
- 150+ RPS: Connection pool saturates ✗

Breaking Point: **150-180 RPS**
- At 150 RPS: P95 crosses 1s threshold
- At 180 RPS: Connection pool exhausted
- At 200 RPS: Error rate > 5%

## Capacity Recommendations

Current Safe Capacity: **100 RPS**
- P95 < 500ms ✓
- Error rate < 1% ✓
- Resource usage < 80% ✓

To Reach 500 RPS:
1. Increase connection pool (20 → 50) → Supports 250 RPS
2. Add 2 more servers + LB → Supports 750 RPS
3. Implement caching → Supports 2000+ RPS

## Cost-Benefit Analysis

**Infrastructure Costs:**
- Current: 1 server ($100/month)
- 3 servers + LB: $350/month (+$250/month)
- + Redis: $50/month
- **Total: $400/month (+$300/month for 20x capacity)**

**ROI:**
- Cost per additional 100 RPS: $30/month
- Supports 10x growth without performance degradation
```

**Output:**
```
Phase 3 Complete (5 minutes)
- Breaking point: 150-180 RPS
- Current safe capacity: 100 RPS
- Scalability recommendations: 5 provided
- Cost analysis: $300/month for 20x capacity

Todos Created: 5
Reports: .tresor/benchmark-2025-11-19/final-benchmark-report.md
```

---

## Test Patterns

### 1. Baseline Test (Default)
```bash
/benchmark
```
**What:** Validate current capacity at expected traffic levels
**Load:** 2x current traffic (e.g., 50 RPS → 100 RPS test)
**Duration:** 5 minutes
**Goal:** Confirm system handles normal traffic

**Use When:**
- Weekly validation
- After deployments
- Regression detection

---

### 2. Stress Test
```bash
/benchmark --pattern stress
```
**What:** Find breaking point by gradually increasing load
**Load:** 1x → 5x → 10x → 20x current traffic
**Duration:** 15-20 minutes
**Goal:** Know your limits

**Use When:**
- Capacity planning
- Before major launches
- Scalability analysis

**Example Results:**
```
Breaking Point Analysis:
- 50 RPS: P95 = 120ms ✓
- 200 RPS: P95 = 340ms ✓ (Acceptable)
- 500 RPS: P95 = 1.2s ⚠️ (Degrading)
- 1000 RPS: Error rate > 10% ✗ (BREAKING)

Breaking Point: 800-1000 RPS
```

---

### 3. Spike Test
```bash
/benchmark --pattern spike --rps 1000
```
**What:** Sudden traffic surge (normal → 10x → normal)
**Duration:** 5 minutes
**Goal:** Validate burst capacity

**Use When:**
- Black Friday preparation
- Product launch
- Viral content scenarios
- Auto-scaling validation

**Example Results:**
```
Spike Test (50 → 1000 → 50 RPS):
- Normal period: P95 = 120ms ✓
- Spike starts: P95 jumps to 2.5s ✗
- During spike: Error rate 15% ✗
- Recovery: 45 seconds to return to normal ⚠️

Issue: Auto-scaling too slow (3-minute scale-up time)
Recommendation: Pre-warm instances or reduce scale-up time
```

---

### 4. Soak Test
```bash
/benchmark --pattern soak --duration 2h
```
**What:** Sustained load over extended period
**Load:** 2x current traffic
**Duration:** 1-2 hours
**Goal:** Detect memory leaks, connection leaks

**Use When:**
- Pre-production validation
- After major refactors
- Memory leak investigation

**Example Results:**
```
Soak Test (100 RPS for 2 hours):
- Latency over time:
  - 0-30 min: P95 = 340ms ✓
  - 30-60 min: P95 = 450ms ⚠️ (degrading)
  - 60-90 min: P95 = 680ms ✗ (degrading)
  - 90-120 min: P95 = 1.2s ✗ (severe degradation)

Memory Usage:
- Start: 1.2GB
- After 2h: 1.8GB (+50%) ⚠️ MEMORY LEAK DETECTED

Recommendation: Investigate memory leak, check for:
- Event listener accumulation
- Unclosed database connections
- Growing cache without eviction
```

---

## Example Workflows

### Workflow 1: Validate Optimizations

```bash
# Before optimization
/benchmark --duration 5m --rps 100
# → P95 = 680ms, 98% success rate

# Implement optimizations
# [Add database index, enable caching]

# After optimization
/benchmark --duration 5m --rps 100
# → P95 = 200ms (-70%), 99.5% success rate

# Improvement validated! ✓
```

---

### Workflow 2: Capacity Planning for Growth

```bash
# Current traffic: 50 RPS
# Projected 6-month growth: 4x (200 RPS)

# Test current capacity
/benchmark --rps 50
# → P95 = 120ms ✓ (Good)

# Test projected capacity
/benchmark --rps 200
# → P95 = 850ms ✗ (Unacceptable)
# → Breaking point: 150 RPS

# Conclusion: Need to scale before reaching 200 RPS

# Test with scaling plan (3 servers)
# [Add 2 more servers]
/benchmark --rps 500
# → P95 = 180ms ✓ (Good)
# → Can handle 3x projected growth
```

---

### Workflow 3: Black Friday Preparation

```bash
# Current: 100 RPS average
# Expected Black Friday: 2000 RPS (20x spike)

# Test spike handling
/benchmark --pattern spike --rps 2000

# Results:
# - Spike starts: Error rate jumps to 45% ✗
# - Auto-scaling: Takes 3 minutes to provision instances
# - During 3-min window: Most requests fail

# Recommendations:
# 1. Pre-warm instances before Black Friday
# 2. Implement queue for write operations
# 3. Add CDN for static assets
# 4. Increase connection pool before event

# Implement recommendations
# [Apply optimizations]

# Re-test spike
/benchmark --pattern spike --rps 2000
# → Error rate < 2% ✓ (Acceptable)
# → Auto-scaling completes in 30s ✓
```

---

## Command Options

### `--duration`
```bash
/benchmark --duration 1m    # Quick test
/benchmark --duration 5m    # Standard (default)
/benchmark --duration 10m   # Thorough
/benchmark --duration 30m   # Extensive
```

### `--rps` (Requests Per Second)
```bash
/benchmark --rps 50     # Light load
/benchmark --rps 100    # Moderate (default: 2x current)
/benchmark --rps 500    # Heavy load
/benchmark --rps 1000   # Stress test
```

### `--pattern`
```bash
/benchmark --pattern baseline     # Steady load (default)
/benchmark --pattern stress       # Gradual increase to breaking point
/benchmark --pattern spike        # Sudden surge
/benchmark --pattern soak         # Long duration (memory leaks)
/benchmark --pattern scalability  # Test with scaling
```

### `--tool`
```bash
/benchmark --tool artillery  # Fast, YAML config (default)
/benchmark --tool locust     # Python, complex scenarios
/benchmark --tool k6         # High performance, Grafana integration
/benchmark --tool jmeter     # Enterprise, GUI
```

---

## Load Testing Tools Comparison

### Artillery (Default)

**Best For:** Quick tests, CI/CD, JavaScript projects
**Pros:**
- Fast setup (YAML config)
- Built-in metrics
- Easy to use

**Cons:**
- Less flexible than Locust
- Lower max RPS than k6

**Example:**
```yaml
config:
  target: 'https://api.example.com'
  phases:
    - duration: 300
      arrivalRate: 100
scenarios:
  - flow:
      - get:
          url: "/api/products"
```

---

### Locust

**Best For:** Complex scenarios, distributed testing, Python projects
**Pros:**
- Python-based (very flexible)
- Real browser simulation
- Distributed load generation

**Cons:**
- Requires Python
- More setup than Artillery

**Example:**
```python
from locust import HttpUser, task, between

class WebsiteUser(HttpUser):
    wait_time = between(1, 5)

    @task
    def index(self):
        self.client.get("/api/products")

    @task(3)
    def view_product(self):
        product_id = random.randint(1, 100)
        self.client.get(f"/api/products/{product_id}")
```

---

### k6

**Best For:** High RPS, cloud-native, Grafana dashboards
**Pros:**
- Very high performance (10k+ RPS single instance)
- JavaScript DSL
- Grafana Cloud integration

**Cons:**
- Less mature ecosystem
- Commercial features in cloud version

**Example:**
```javascript
import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  stages: [
    { duration: '5m', target: 100 },
  ],
};

export default function () {
  const res = http.get('https://api.example.com/api/products');
  check(res, { 'status is 200': (r) => r.status === 200 });
  sleep(1);
}
```

---

## Integration with Tresor Workflow

### Recommended: `/profile` → Optimize → `/benchmark`

```bash
# Step 1: Profile to find bottlenecks
/profile
# → Found: Database index missing, no caching

# Step 2: Fix bottlenecks
# [Implement optimizations]

# Step 3: Validate with benchmark
/benchmark --rps 100
# → Before: P95 = 680ms
# → After: P95 = 200ms ✓ (-70% improvement)

# Step 4: Find new limits
/benchmark --pattern stress
# → Breaking point improved from 150 RPS → 800 RPS
```

### Automatic `/todo-add`
```bash
# Capacity/scaling issues → todos
/todo-add "Scaling: Increase connection pool to handle 500 RPS"
/todo-add "Performance: Dashboard API fails under load - implement caching"
```

### Automatic `/prompt-create`
```bash
# Complex scaling work → expert prompts
/prompt-create "Design horizontal scaling architecture with load balancer"
# → Creates ./prompts/008-horizontal-scaling.md
```

---

## FAQ

### Q: How is this different from `/profile`?

**A:**
- **`/profile`**: No load, identifies what's slow at normal traffic
- **`/benchmark`**: Under load, identifies capacity limits and breaking points

Use both: `/profile` to find bottlenecks, `/benchmark` to validate fixes.

### Q: What RPS should I test with?

**A:**
- **Current traffic**: Check analytics (e.g., 50 RPS)
- **Test with:** 2-5x current traffic (100-250 RPS)
- **Stress test:** 10-20x current traffic (500-1000 RPS)

### Q: How long should tests run?

**A:**
- **Quick validation**: 1-2 minutes
- **Standard benchmark**: 5-10 minutes
- **Stress test**: 15-20 minutes (gradual ramp-up)
- **Soak test**: 1-2 hours (memory leaks)

### Q: Can I run benchmarks in production?

**A:** **NOT RECOMMENDED** - Load testing can impact real users

**Instead:**
- Test in staging environment
- Use production-like data and infrastructure
- Or use canary/shadow traffic in production

---

## Troubleshooting

### Issue: "Test causes production outage"

**Cause:** Running benchmark against production

**Solution:**
```bash
# ALWAYS test against staging
/benchmark --target https://staging.example.com
```

---

### Issue: "Results show 100% errors"

**Cause:** Authentication not configured

**Solution:**
- Ensure test users are created
- Provide valid auth tokens
- Check API authentication requirements

---

### Issue: "Benchmark takes too long"

**Cause:** Soak test or long duration

**Solution:**
```bash
# Use shorter duration
/benchmark --duration 1m

# Or quick baseline
/benchmark --pattern baseline --duration 2m
```

---

## See Also

- **[/profile Command](../profile/)** - Performance profiling
- **[Performance Tuner Agent](../../../subagents/core/performance-tuner/)** - Performance optimization
- **[API Tester Agent](../../../subagents/engineering/testing/api-tester/)** - API testing specialist

---

**Version:** 2.7.0
**Last Updated:** November 19, 2025
**Category:** Performance
**License:** MIT
**Author:** Alireza Rezvani
