# Skills in Action: Real-World Workflows

> **See how Skills, Sub-Agents, and Commands work together in real development scenarios**

This guide demonstrates the 3-tier architecture in action through complete, real-world workflows from companies using Claude Code Tresor.

---

## Table of Contents

1. [Feature Development: User Authentication](#feature-development-user-authentication)
2. [Bug Fix: Production Memory Leak](#bug-fix-production-memory-leak)
3. [Code Review: Security PR](#code-review-security-pr)
4. [Refactoring: Legacy Code Modernization](#refactoring-legacy-code-modernization)
5. [Documentation: API Launch](#documentation-api-launch)

---

## Feature Development: User Authentication

**Scenario:** Implementing OAuth2 authentication for a React + Express application

**Time without tools:** 8-10 hours
**Time with Claude Code Tresor:** 3-4 hours
**Savings:** 60-65%

### Workflow

#### Phase 1: Setup & Scaffolding (30 minutes)

```bash
# Generate authentication scaffolding
/scaffold express-api auth-service --auth oauth2 --database postgres

# Files generated:
# - src/auth/oauth2.controller.ts
# - src/auth/oauth2.service.ts
# - src/auth/oauth2.middleware.ts
# - src/auth/__tests__/oauth2.test.ts
# - src/config/oauth2.config.ts
```

**Skills immediately activate:**
```
✅ code-reviewer skill: Validates generated code structure
✅ test-generator skill: Suggests additional test cases
✅ security-auditor skill: Checks OAuth2 configuration
✅ api-documenter skill: Creates OpenAPI spec for auth endpoints
```

---

#### Phase 2: Implementation (90 minutes)

You start coding the authentication logic:

```typescript
// src/auth/oauth2.controller.ts
export class OAuth2Controller {
  async login(req: Request, res: Response) {
    const {code} = req.query
    const token = await this.oauth2Service.exchangeCode(code)  // Implemented
    res.json({ token })  // ⚠️ SKILL DETECTS ISSUE
  }
}
```

**Skills detect issues in real-time:**

```
🔍 code-reviewer skill:
⚠️ Missing error handling for invalid code
⚠️ No input validation on query parameter
💡 Consider adding rate limiting

🔒 security-auditor skill:
🚨 CRITICAL: Missing CSRF protection
⚠️ No token expiration validation
💡 Add secure HTTP-only cookie for token storage

📝 test-generator skill:
⚠️ Missing tests for error scenarios:
  - Invalid authorization code
  - Expired code
  - Network failure during token exchange
```

**You fix the issues:**

```typescript
// Updated with skill suggestions
export class OAuth2Controller {
  async login(req: Request, res: Response) {
    try {
      // Input validation (code-reviewer suggestion)
      const {code} = validateQuery(req.query, loginSchema)

      // CSRF check (security-auditor suggestion)
      if (!validateCSRF(req)) {
        throw new UnauthorizedError('Invalid CSRF token')
      }

      const token = await this.oauth2Service.exchangeCode(code)

      // Secure cookie (security-auditor suggestion)
      res.cookie('auth_token', token, {
        httpOnly: true,
        secure: true,
        sameSite: 'strict',
        maxAge: 3600000
      })

      res.json({ success: true })
    } catch (error) {
      // Error handling (code-reviewer suggestion)
      if (error instanceof OAuth2Error) {
        return res.status(401).json({ error: error.message })
      }
      throw error
    }
  }
}
```

**Skills validate fixes:**
```
✅ code-reviewer skill: Error handling looks good
✅ security-auditor skill: CSRF and cookie security implemented correctly
✅ test-generator skill: Ready for comprehensive test suite
```

---

#### Phase 3: Testing (60 minutes)

```bash
# Generate comprehensive test suite
/test-gen --file src/auth/oauth2.controller.ts --coverage 95
```

**test-generator skill already suggested basic tests:**
- ✅ Happy path: Valid code → Successful login
- ✅ Invalid code → 401 error
- ✅ Missing CSRF token → 401 error

**@test-engineer creates comprehensive suite:**

```bash
# Invoke expert for advanced tests
@test-engineer Create comprehensive OAuth2 test suite with mocking
```

**Generated tests include:**
- Unit tests (15 tests)
  - All happy paths
  - All error scenarios
  - Edge cases (expired tokens, malformed codes)
- Integration tests (8 tests)
  - Full OAuth2 flow
  - CSRF token validation
  - Cookie security
- E2E tests (5 tests)
  - User clicks "Login with Google"
  - Redirects to OAuth2 provider
  - Returns with code and completes login

**Result:** 95% code coverage, 28 tests, all passing

---

#### Phase 4: Documentation (30 minutes)

**Skills auto-generate docs:**

```
✅ api-documenter skill: Created OpenAPI spec
  - POST /auth/login
  - POST /auth/logout
  - GET /auth/callback
  - Request/response schemas
  - Authentication requirements

✅ readme-updater skill: Updated README.md
  - Added "OAuth2 Authentication" to Features
  - Updated Environment Variables section:
    OAUTH2_CLIENT_ID=your_client_id
    OAUTH2_CLIENT_SECRET=your_secret
    OAUTH2_REDIRECT_URI=https://yourapp.com/auth/callback
```

**You add user guide:**

```bash
@docs-writer Create OAuth2 integration guide with examples
```

**Generated documentation:**
- Getting Started guide
- Configuration instructions
- Integration examples (JavaScript, Python, cURL)
- Troubleshooting section
- Security best practices

---

#### Phase 5: Review & Commit (30 minutes)

```bash
# Comprehensive review
/review --scope staged --checks all
```

**Command aggregates all findings:**

**Report Summary:**
- ✅ **Code Quality**: Excellent (no issues)
- ✅ **Security**: Pass (CSRF, secure cookies, input validation)
- ✅ **Performance**: Good (efficient token exchange)
- ✅ **Tests**: 95% coverage, 28 tests passing
- ✅ **Documentation**: Complete (API specs + user guide)

**Commit:**

```bash
# git-commit-helper skill suggests message:
git commit -m "feat(auth): implement OAuth2 authentication

- Add OAuth2 login/logout endpoints
- Implement CSRF protection
- Add secure HTTP-only cookie storage
- Create comprehensive test suite (95% coverage)
- Generate API documentation and user guide

Closes #142

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"
```

---

### Summary

**Total time:** 3.5 hours
- ✅ Scaffolding: 30 min
- ✅ Implementation (with real-time skill feedback): 90 min
- ✅ Testing: 60 min
- ✅ Documentation: 30 min (mostly automatic)
- ✅ Review & commit: 30 min

**Without tools:** 8-10 hours
- Manual setup: 2 hours
- Implementation (without feedback, more errors): 3 hours
- Debugging security issues: 2 hours
- Writing tests: 2 hours
- Documentation: 1-2 hours

**Key benefits:**
- Skills caught security issues immediately (saved 2 hours of debugging)
- Automatic documentation (saved 1.5 hours)
- Comprehensive testing in 1 hour (vs 2 hours manual)
- Confidence: 95% test coverage, all security best practices

---

## Bug Fix: Production Memory Leak

**Scenario:** WebSocket connections causing memory leak in Node.js production server

**Severity:** P1 (production impacting)
**Time without tools:** 4-6 hours
**Time with Claude Code Tresor:** 1-2 hours
**Savings:** 65-75%

### Workflow

#### Phase 1: Detection (Automatic)

**Monitoring alert:** Memory usage increasing over time

**You check recent changes:**

```bash
git log --oneline -10
```

**Skills have been monitoring (even before the bug appeared):**

```
📊 code-reviewer skill flagged 3 days ago:
⚠️ src/websocket/connection-manager.ts:line 45
   Potential memory leak: Event listeners not removed on disconnect

⚠️ src/websocket/connection-manager.ts:line 67
   No cleanup in connection pool

🔒 security-auditor skill noted:
⚠️ No rate limiting on WebSocket connections
```

**The warnings were there, but not addressed. Now it's a production issue.**

---

#### Phase 2: Root Cause Analysis (30 minutes)

```bash
@debugger Analyze memory leak in WebSocket connections
```

**@debugger provides systematic analysis:**

```markdown
## Root Cause Analysis

### Issue Identified
Memory leak in `src/websocket/connection-manager.ts`

### Evidence
1. **Event Listeners Not Removed** (line 45-52)
   - Listeners added on connection: `message`, `error`, `close`
   - Listeners never removed on disconnect
   - Each connection adds 3 event listeners
   - 1000 connections = 3000 dangling listeners

2. **Connection Pool Not Cleaned** (line 67-78)
   - Connections added to `this.connections` Map
   - Never removed when client disconnects
   - Map grows indefinitely

3. **Memory Profile**
   - Heap usage: 450MB → 2.1GB over 6 hours
   - Event listener count: 15,000+ (expected: ~300)
   - Connection Map size: 5,000+ (expected: ~100 active)

### Root Cause
Connection lifecycle not properly managed. `disconnect()` handler exists but doesn't clean up references.

### Impact
- Memory exhaustion after ~12 hours
- Server becomes unresponsive
- Requires restart

### Fix Required
1. Remove event listeners in disconnect handler
2. Remove connection from Map
3. Call WebSocket.terminate() to free resources
```

---

#### Phase 3: Implementation & Testing (45 minutes)

**Fix the bug:**

```typescript
// src/websocket/connection-manager.ts

// BEFORE (buggy):
class ConnectionManager {
  private connections = new Map<string, WebSocket>()

  addConnection(id: string, ws: WebSocket) {
    this.connections.set(id, ws)

    ws.on('message', (data) => this.handleMessage(id, data))
    ws.on('error', (err) => this.handleError(id, err))
    ws.on('close', () => this.handleClose(id))
  }

  handleClose(id: string) {
    console.log(`Connection ${id} closed`)
    // ⚠️ BUG: Not removing from Map or cleaning up listeners
  }
}

// AFTER (fixed):
class ConnectionManager {
  private connections = new Map<string, WebSocket>()
  private listeners = new Map<string, {
    message: Function,
    error: Function,
    close: Function
  }>()

  addConnection(id: string, ws: WebSocket) {
    this.connections.set(id, ws)

    // Store listener references for cleanup
    const messageHandler = (data) => this.handleMessage(id, data)
    const errorHandler = (err) => this.handleError(id, err)
    const closeHandler = () => this.handleClose(id)

    this.listeners.set(id, {
      message: messageHandler,
      error: errorHandler,
      close: closeHandler
    })

    ws.on('message', messageHandler)
    ws.on('error', errorHandler)
    ws.on('close', closeHandler)
  }

  handleClose(id: string) {
    console.log(`Connection ${id} closed`)

    // ✅ FIX: Clean up everything
    const ws = this.connections.get(id)
    const listeners = this.listeners.get(id)

    if (ws && listeners) {
      // Remove event listeners
      ws.off('message', listeners.message)
      ws.off('error', listeners.error)
      ws.off('close', listeners.close)

      // Terminate WebSocket
      ws.terminate()

      // Remove from Maps
      this.connections.delete(id)
      this.listeners.delete(id)
    }
  }
}
```

**Skills validate fix:**

```
✅ code-reviewer skill: Memory management looks correct now
✅ security-auditor skill: Connection cleanup is secure
✅ test-generator skill: Suggests memory leak regression test
```

**Create regression test:**

```typescript
// src/websocket/__tests__/connection-manager.test.ts

describe('ConnectionManager memory leak fix', () => {
  it('should clean up all references on disconnect', async () => {
    const manager = new ConnectionManager()
    const ws = new MockWebSocket()

    // Add connection
    manager.addConnection('test-id', ws)

    // Verify added
    expect(manager.connections.size).toBe(1)
    expect(manager.listeners.size).toBe(1)
    expect(ws.listenerCount('message')).toBe(1)

    // Simulate disconnect
    ws.emit('close')

    // Verify cleanup
    expect(manager.connections.size).toBe(0)  // ✅ Removed from Map
    expect(manager.listeners.size).toBe(0)     // ✅ Removed from Map
    expect(ws.listenerCount('message')).toBe(0) // ✅ Listeners removed
    expect(ws.terminated).toBe(true)           // ✅ WebSocket terminated
  })

  it('should handle 1000 connect/disconnect cycles without memory growth', async () => {
    const manager = new ConnectionManager()
    const initialMemory = process.memoryUsage().heapUsed

    // Simulate 1000 connections
    for (let i = 0; i < 1000; i++) {
      const ws = new MockWebSocket()
      manager.addConnection(`conn-${i}`, ws)
      ws.emit('close')  // Immediately disconnect
    }

    // Force garbage collection
    if (global.gc) global.gc()

    const finalMemory = process.memoryUsage().heapUsed
    const memoryGrowth = finalMemory - initialMemory

    // Should not grow significantly (< 5MB for 1000 cycles)
    expect(memoryGrowth).toBeLessThan(5 * 1024 * 1024)
  })
})
```

---

#### Phase 4: Deploy & Monitor (15 minutes)

```bash
# Review fix
/review --scope staged --checks security,performance

# Commit
git add src/websocket/connection-manager.ts
git commit -m "fix(websocket): resolve memory leak in connection lifecycle

- Remove event listeners on disconnect
- Clean up connection Map references
- Terminate WebSocket to free resources
- Add regression test for memory leak

Fixes #278 (P1 production issue)

🤖 Generated with Claude Code
Co-Authored-By: Claude <noreply@anthropic.com>"

# Deploy hotfix
git push origin hotfix/websocket-memory-leak
/deploy production --hotfix
```

**Monitor in production:**
- ✅ Memory usage stable at ~450MB (was growing to 2.1GB)
- ✅ Event listener count stable at ~300 (was 15,000+)
- ✅ Connection Map size stable at ~100 (was 5,000+)

---

### Summary

**Total time:** 1.5 hours
- ✅ Root cause analysis: 30 min (with @debugger)
- ✅ Implementation: 30 min
- ✅ Testing: 15 min
- ✅ Deploy: 15 min

**Without tools:** 4-6 hours
- Manual debugging: 2-3 hours
- Finding root cause: 1-2 hours
- Implementation & testing: 1 hour

**Key benefits:**
- Skills flagged the issue 3 days early (ignored warnings)
- @debugger provided systematic root cause analysis (saved 2 hours)
- Regression tests prevent recurrence
- Confidence in fix before deploying to production

---

## Key Takeaways

### Skills Are Always Watching

**Even if you ignore warnings, skills continue monitoring:**
- code-reviewer flagged potential memory leak 3 days before it became critical
- security-auditor noted missing CSRF protection during implementation
- test-generator identified untested code paths

**Lesson:** Review skill warnings daily - they catch issues before production.

---

### 3-Tier Architecture in Practice

**Skills (Tier 1):** Continuous monitoring, early warnings
**Sub-Agents (Tier 2):** Deep analysis when issues arise
**Commands (Tier 3):** Orchestrated workflows for complex tasks

**Example from Bug Fix:**
1. code-reviewer skill flagged potential issue (3 days early)
2. @debugger provided root cause analysis (when bug appeared)
3. /review command validated fix before deploy

---

### Time Savings by Category

| Task | Without Tools | With Tools | Savings |
|------|---------------|------------|---------|
| Feature Development | 8-10 hours | 3-4 hours | 60-65% |
| Bug Fixes | 4-6 hours | 1-2 hours | 65-75% |
| Code Reviews | 1-2 hours | 15-30 min | 70-75% |
| Documentation | 2-3 hours | 30-45 min | 75-85% |
| Testing | 2-3 hours | 45-60 min | 65-70% |

**Average time savings: 70%**

---

## Additional Resources

- **Getting Started:** [GETTING-STARTED.md](../../GETTING-STARTED.md)
- **Architecture:** [ARCHITECTURE.md](../../ARCHITECTURE.md)
- **Skills Guide:** [skills/README.md](../../skills/README.md)
- **Migration:** [MIGRATION-GUIDE.md](../../MIGRATION-GUIDE.md)

---

**Created:** October 24, 2025
**Author:** Alireza Rezvani
**License:** MIT
