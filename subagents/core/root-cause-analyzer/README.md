# Debugger Agent 🐛

Expert debugging specialist focused on root cause analysis, systematic problem-solving, and minimal-impact fixes for production issues and complex bugs.

## 🎯 Overview

The **@debugger** agent provides systematic debugging methodology based on scientific investigation. Unlike quick fixes, this agent finds root causes and implements sustainable solutions that prevent recurring issues.

## ✨ Working with Skills (NEW!)

While no skill specifically handles debugging, this agent benefits from skills detecting symptoms:

**Skills Detect Symptoms (Autonomous):**
- code-reviewer skill flags code smells that may cause bugs
- security-auditor skill detects vulnerabilities that lead to failures
- test-generator skill identifies untested code paths

**This Agent (Expert):**
- System-level failure analysis
- Stack trace interpretation
- Performance bottleneck identification
- Complex bug reproduction and isolation

**Complementary Approach:** Skills surface potential issues during development. When failures occur in production or complex bugs appear, this agent provides systematic root cause analysis and sustainable fixes.

**See:** [Skills Guide](../../skills/README.md) for more information

## 🚀 Capabilities

### Root Cause Analysis
- **5 Whys methodology** for systematic investigation
- **Hypothesis testing** with measurable validation
- **Pattern recognition** across similar failures
- **Timeline reconstruction** of events leading to failure
- **Environmental factor** analysis (OS, runtime, dependencies)

### Debugging Techniques
- **Stack trace analysis** and call path reconstruction
- **Memory profiling** for leaks and allocation issues
- **Network debugging** for API and connectivity problems
- **Race condition** detection and resolution
- **State management** debugging
- **Async/await** flow analysis

### Specialized Debugging
- **Production debugging** without disrupting live services
- **Intermittent issues** that are hard to reproduce
- **Performance degradation** over time
- **Memory leaks** in long-running processes
- **Concurrency issues** and deadlocks
- **Integration failures** between services

## 🛠️ Usage Examples

### Production Memory Leak

```bash
@debugger Analyze memory leak in production Node.js server

Context:
- Memory usage growing from 450MB to 2.1GB over 6 hours
- Server becomes unresponsive after ~12 hours
- Heap dump shows 15,000+ event listeners
- Connection Map size: 5,000+ (expected: ~100)
```

**Agent Response:**
```markdown
## Root Cause Analysis 🔍

### Issue Identified
Memory leak in `src/websocket/connection-manager.ts`

### Evidence Trail
1. **Event Listeners Not Removed** (line 45-52)
   - Listeners added: `message`, `error`, `close`
   - Never removed on disconnect
   - 1000 connections = 3000 dangling listeners

2. **Connection Pool Not Cleaned** (line 67-78)
   - Connections added to Map
   - Never removed when client disconnects
   - Map grows indefinitely

### Root Cause
Connection lifecycle not managed. `disconnect()` handler exists but doesn't clean up references.

### Fix Strategy
1. Store listener references for cleanup
2. Remove event listeners in disconnect handler
3. Remove connection from Map
4. Call WebSocket.terminate()

### Implementation
[Detailed fix with code examples]

### Verification
- Add memory leak regression test
- Monitor heap usage in staging
- Set up alerts for event listener count
```

### Intermittent Bug

```bash
@debugger Debug intermittent "TypeError: Cannot read property 'id' of undefined"

Occurs randomly in production (5% of requests)
Stack trace:
  at getUserProfile (/src/api/users.js:45)
  at handleRequest (/src/middleware/router.js:23)
```

**Agent Response:**
```markdown
## Debugging Analysis 🐛

### Hypothesis Formation
Based on "5% of requests" pattern, likely a race condition or timing issue.

### Investigation Steps

#### Step 1: Reproduce Locally
- Added artificial delays
- Simulated concurrent requests
- Result: Reproduced in 8% of concurrent requests

#### Step 2: Identify Race Condition
```javascript
// Line 45 in users.js
const user = await User.findById(req.params.id);
return { id: user.id, name: user.name }; // ⚠️ No null check
```

#### Step 3: Root Cause
User cache invalidation occurs while request is processing:
1. Request A starts: `findById(123)` initiated
2. Admin deletes user 123
3. Cache invalidated
4. Request A completes: `findById(123)` returns null
5. Code tries to access `null.id` → TypeError

### Fix
```javascript
const user = await User.findById(req.params.id);
if (!user) {
  throw new NotFoundError(`User ${req.params.id} not found`);
}
return { id: user.id, name: user.name };
```

### Verification
- Add test for deleted user scenario
- Add metrics for 404 responses
- Monitor error rate in production
```

### Performance Degradation

```bash
@debugger API response time degrading from 50ms to 5000ms over 24 hours

Symptoms:
- Starts fast after deployment
- Gradually slows down
- Requires restart to fix
- Database connections stable
- CPU usage normal
```

**Agent Response:**
```markdown
## Performance Debugging 📊

### Investigation Timeline

#### Hour 0-2: Normal (50ms avg)
- Fresh deployment
- All caches empty
- Memory: 200MB

#### Hour 6-12: Degrading (500ms avg)
- Cache growing
- Memory: 800MB
- Response time increasing linearly

#### Hour 18-24: Critical (5000ms avg)
- Cache size: 2GB
- Memory: 2.2GB (near limit)
- GC pauses: 2-3 seconds

### Root Cause: Unbounded Cache
```javascript
// src/cache/user-cache.js
class UserCache {
  constructor() {
    this.cache = new Map(); // ⚠️ No size limit
  }

  set(key, value) {
    this.cache.set(key, value); // ⚠️ No TTL, no eviction
  }
}
```

### Impact
- Cache grows indefinitely
- Map operations become O(n) at large sizes
- GC struggles with large objects
- Memory pressure causes pauses

### Fix: LRU Cache with TTL
```javascript
const LRU = require('lru-cache');

class UserCache {
  constructor() {
    this.cache = new LRU({
      max: 10000,              // Max 10k entries
      maxAge: 1000 * 60 * 60,  // 1 hour TTL
      updateAgeOnGet: true
    });
  }
}
```

### Verification
- Load test for 24 hours
- Monitor cache size metrics
- Set alerts for cache > 9000 entries
- Profile memory usage over time
```

## 🔧 Debugging Methodology

### 1. Information Gathering
```
- Error message and stack trace
- Reproduction steps (if known)
- Environment details (OS, runtime, versions)
- Recent changes (code, config, infrastructure)
- Frequency and timing patterns
```

### 2. Hypothesis Formation
```
- What could cause this behavior?
- What changed recently?
- Is it timing-dependent?
- Is it environment-specific?
```

### 3. Testing Hypotheses
```
- Design tests to validate/invalidate each hypothesis
- Use minimal reproduction cases
- Eliminate variables systematically
- Measure and record results
```

### 4. Root Cause Identification
```
- Trace back from symptom to cause
- Verify with multiple data points
- Ensure fix addresses root cause, not symptom
```

### 5. Solution Implementation
```
- Minimal-impact fix
- Add regression tests
- Update documentation
- Set up monitoring
```

## 🎯 Best Practices

### When to Invoke

**Good scenarios:**
- Production issues with unclear cause
- Intermittent bugs that are hard to reproduce
- Performance degradation over time
- Complex multi-system failures

**Less suitable:**
- Simple syntax errors (use IDE)
- Obvious bugs with clear fixes
- Issues already diagnosed

### Providing Context

**Essential information:**
```bash
@debugger [Problem description]

Symptoms:
- What's happening
- When it started
- Frequency/pattern

Environment:
- OS, runtime, versions
- Production/staging/local

Recent Changes:
- Code deployments
- Config changes
- Infrastructure updates

Attempted Fixes:
- What you've tried
- Results observed
```

### Follow-Up

After receiving analysis:
1. Implement recommended fix
2. Add regression tests
3. Monitor metrics
4. Report back results
5. Update documentation

## 📊 Debugging Categories

### Application Errors (40%)
- Null pointer exceptions
- Type errors
- Logic errors
- API integration failures

### Performance Issues (25%)
- Memory leaks
- CPU spikes
- Database bottlenecks
- Network latency

### Concurrency Problems (20%)
- Race conditions
- Deadlocks
- Data corruption
- Inconsistent state

### Infrastructure Issues (15%)
- Configuration errors
- Deployment problems
- Resource exhaustion
- Network connectivity

## 🚀 Advanced Debugging

### Debugging Tools
- Chrome DevTools / Node Inspector
- Memory profilers (heapdump, memwatch)
- APM tools (New Relic, Datadog)
- Distributed tracing (Jaeger, Zipkin)
- Log aggregation (ELK, Splunk)

### Production Debugging
- Feature flags for controlled testing
- Canary deployments
- A/B testing for hypothesis validation
- Real-time monitoring and alerting

### Prevention Strategies
- Comprehensive logging
- Proper error handling
- Input validation
- Defensive programming
- Automated testing
- Code reviews

---

**Need systematic debugging? 🐛**

Use `@debugger` with clear problem description, symptoms, and context for expert root cause analysis and sustainable fixes!
