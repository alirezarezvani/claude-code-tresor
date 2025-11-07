# Agents Reference

Complete reference for all Claude Code Tresor agents.

## Overview

Agents are **specialized experts** invoked manually for deep analysis and complex tasks. Unlike skills, agents have full tool access and work in separate conversation contexts.

**Key Characteristics:**
- ✅ **Manual invocation** - Use `@agent-name` syntax
- ✅ **Full tool access** - Can use all tools including Bash and Task
- ✅ **Deep analysis** - Comprehensive examination and solutions
- ✅ **Separate context** - Independent conversation thread

---

## Agent Configuration Specification

### YAML Frontmatter Schema

```yaml
---
name: "agent-name"                   # Required: Unique identifier
description: "Agent expertise"        # Required: What agent specializes in
tools:                               # Required: Available tools
  - "Read"
  - "Write"
  - "Edit"
  - "Grep"
  - "Glob"
  - "Bash"
  - "Task"
model: "claude-opus-4"               # Optional: Default is opus for agents
enabled: true                        # Optional: Default is true
capabilities:                        # Optional: Specialized capabilities
  - "capability1"
  - "capability2"
max_iterations: 50                   # Optional: Maximum tool use iterations
---
```

---

## Field Reference

### name (required)
**Type:** String
**Format:** lowercase-with-dashes
**Example:** `"code-reviewer"`

Unique identifier used with `@agent-name` invocation.

---

### description (required)
**Type:** String
**Length:** 50-300 characters
**Example:** `"Expert code quality analyst specializing in security and performance"`

Describes agent's expertise and specialization.

---

### tools (required)
**Type:** Array of strings
**All available tools:**
- `"Read"` - Read files
- `"Write"` - Create/overwrite files
- `"Edit"` - Modify existing files
- `"Grep"` - Search file contents
- `"Glob"` - Find files by pattern
- `"Bash"` - Execute shell commands
- `"Task"` - Invoke other agents

**Example:**
```yaml
tools:
  - "Read"
  - "Write"
  - "Edit"
  - "Grep"
  - "Glob"
  - "Bash"
  - "Task"
```

---

### model (optional)
**Type:** String
**Default:** `"claude-opus-4"` (agents use Opus by default)
**Allowed values:**
- `"claude-opus-4"` - Most capable (recommended for agents)
- `"claude-sonnet-4"` - Faster, less capable

**Example:**
```yaml
model: "claude-opus-4"
```

---

### enabled (optional)
**Type:** Boolean
**Default:** `true`

---

### capabilities (optional)
**Type:** Array of strings
**Example:**
```yaml
capabilities:
  - "code-analysis"
  - "security-review"
  - "performance-optimization"
  - "refactoring"
```

---

### max_iterations (optional)
**Type:** Number
**Default:** `50`
**Range:** 1-200

Maximum number of tool use iterations before agent times out.

**Example:**
```yaml
max_iterations: 75  # For complex tasks
```

---

## Development Agents

### @code-reviewer

**Expertise:** Code quality analysis, best practices, architecture review

**Specializations:**
- Code quality assessment
- Best practices validation
- Architecture review
- Maintainability analysis
- Code smell detection

**Best For:**
- Pre-commit reviews
- Pull request analysis
- Architecture decisions
- Code quality audits
- Team code standards

**Invocation Examples:**

**Basic:**
```
@code-reviewer analyze src/components/UserProfile.tsx
```

**Specific Focus:**
```
@code-reviewer analyze src/api/auth.controller.ts for:
1. Security vulnerabilities
2. Error handling
3. Input validation
4. Best practices
```

**Architecture Review:**
```
@code-reviewer review the architecture of src/services/ directory
Focus on:
- Service boundaries
- Dependency management
- Testability
- Scalability
```

**Example Response:**
```
Code Quality Analysis: src/api/auth.controller.ts

✅ Strengths:
- Well-structured with clear separation of concerns
- Good error handling with try-catch blocks
- Input validation present

⚠️ Issues Detected:

1. Security (High Priority):
   Line 45: Password not hashed before storage
   Fix: Use bcrypt.hash() before saving to database

2. Error Handling (Medium Priority):
   Line 67: Generic error message exposes internal details
   Fix: Return user-friendly message, log details separately

3. Code Quality (Low Priority):
   Line 89: Complex conditional - consider extracting to helper
   Fix: Create isValidAuthRequest() helper function

🔧 Recommended Changes:
[Detailed code examples for each fix]
```

**Configuration:**
```yaml
---
name: "code-reviewer"
description: "Expert code quality analyst"
tools:
  - "Read"
  - "Write"
  - "Edit"
  - "Grep"
  - "Glob"
  - "Bash"
  - "Task"
model: "claude-opus-4"
enabled: true
capabilities:
  - "code-analysis"
  - "architecture-review"
  - "best-practices"
  - "refactoring-suggestions"
max_iterations: 75
---
```

**[Full Documentation →](../../agents/code-reviewer/SKILL.md)**

---

### @test-engineer

**Expertise:** Test strategy, test generation, coverage analysis

**Specializations:**
- Test case design
- Test coverage analysis
- Testing strategy
- Test framework selection
- Property-based testing

**Best For:**
- Generating comprehensive tests
- Improving test coverage
- Testing strategy planning
- Complex test scenarios
- Edge case identification

**Invocation Examples:**

**Generate Tests:**
```
@test-engineer create comprehensive tests for src/utils/validation.ts
```

**Coverage Analysis:**
```
@test-engineer analyze test coverage for src/services/payment.service.ts
Identify:
1. Untested code paths
2. Missing edge cases
3. Integration test opportunities
```

**Test Strategy:**
```
@test-engineer design testing strategy for new authentication system
Include:
- Unit tests
- Integration tests
- E2E tests
- Security tests
```

**Configuration:**
```yaml
---
name: "test-engineer"
description: "Testing specialist and test generation expert"
tools:
  - "Read"
  - "Write"
  - "Edit"
  - "Grep"
  - "Glob"
  - "Bash"
model: "claude-opus-4"
capabilities:
  - "test-generation"
  - "coverage-analysis"
  - "test-strategy"
  - "edge-case-identification"
---
```

**[Full Documentation →](../../agents/test-engineer/SKILL.md)**

---

### @docs-writer

**Expertise:** Technical documentation, API docs, user guides

**Specializations:**
- API documentation
- User guides
- Architecture documentation
- README generation
- Code comments

**Best For:**
- Creating API documentation
- Writing user guides
- Documenting architecture
- Updating README files
- Complex documentation tasks

**Invocation Examples:**

**API Documentation:**
```
@docs-writer create API documentation for src/api/users.controller.ts
Include:
- OpenAPI specification
- Request/response examples
- Authentication requirements
- Error responses
```

**User Guide:**
```
@docs-writer create user guide for authentication feature
Target audience: Developers integrating our API
Include:
- Setup instructions
- Code examples
- Common issues
- Troubleshooting
```

**Architecture Documentation:**
```
@docs-writer document the microservices architecture in src/services/
Include:
- Service boundaries
- Communication patterns
- Data flow diagrams
- Deployment topology
```

**Configuration:**
```yaml
---
name: "docs-writer"
description: "Technical documentation expert"
tools:
  - "Read"
  - "Write"
  - "Edit"
  - "Grep"
  - "Glob"
model: "claude-opus-4"
capabilities:
  - "api-documentation"
  - "user-guides"
  - "architecture-docs"
  - "technical-writing"
---
```

**[Full Documentation →](../../agents/docs-writer/SKILL.md)**

---

## Architecture & Design Agents

### @architect

**Expertise:** System design, architecture patterns, scalability

**Specializations:**
- System architecture design
- Architecture pattern selection
- Scalability planning
- Technology stack selection
- Microservices design

**Best For:**
- Designing new systems
- Architecture reviews
- Scalability planning
- Technology decisions
- Migration planning

**Invocation Examples:**

**System Design:**
```
@architect design a scalable e-commerce platform
Requirements:
- 10k concurrent users
- Real-time inventory
- Payment processing
- Order management
Include architecture diagrams and technology recommendations
```

**Architecture Review:**
```
@architect review current architecture in src/
Assess:
- Scalability bottlenecks
- Single points of failure
- Performance issues
- Security concerns
```

**Migration Planning:**
```
@architect plan migration from monolith to microservices
Current: Single Rails application
Target: Node.js microservices
Include: phased approach, risk mitigation, rollback plan
```

**Configuration:**
```yaml
---
name: "architect"
description: "System design and architecture expert"
tools:
  - "Read"
  - "Write"
  - "Edit"
  - "Grep"
  - "Glob"
  - "Bash"
  - "Task"
model: "claude-opus-4"
capabilities:
  - "system-design"
  - "architecture-patterns"
  - "scalability-planning"
  - "technology-selection"
max_iterations: 100
---
```

**[Full Documentation →](../../agents/architect/SKILL.md)**

---

## Debugging & Optimization Agents

### @debugger

**Expertise:** Bug analysis, root cause identification, debugging strategies

**Specializations:**
- Bug reproduction
- Root cause analysis
- Debugging strategies
- Error trace analysis
- Production debugging

**Best For:**
- Complex bugs
- Production issues
- Performance problems
- Intermittent failures
- Multi-component issues

**Invocation Examples:**

**Bug Analysis:**
```
@debugger analyze this bug:

Error: TypeError: Cannot read property 'user' of undefined
Location: src/components/Profile.tsx:45
Reproduction: Occurs when refreshing profile page

Provide:
1. Root cause analysis
2. Step-by-step debugging approach
3. Fix with explanation
```

**Production Issue:**
```
@debugger investigate production crash
Symptoms: API timeouts after 30 seconds
Frequency: Every 2-3 hours
Logs: [paste relevant logs]

Analyze:
- Potential causes
- Debug approach
- Monitoring to add
- Prevention strategy
```

**Configuration:**
```yaml
---
name: "debugger"
description: "Debugging specialist and root cause analyst"
tools:
  - "Read"
  - "Grep"
  - "Glob"
  - "Bash"
model: "claude-opus-4"
capabilities:
  - "bug-analysis"
  - "root-cause-identification"
  - "debugging-strategies"
  - "error-trace-analysis"
---
```

**[Full Documentation →](../../agents/debugger/SKILL.md)**

---

### @performance-tuner

**Expertise:** Performance optimization, profiling, bottleneck identification

**Specializations:**
- Performance profiling
- Bottleneck identification
- Query optimization
- Caching strategies
- Load testing

**Best For:**
- Performance optimization
- Scalability issues
- Database optimization
- Frontend performance
- API optimization

**Invocation Examples:**

**Performance Analysis:**
```
@performance-tuner analyze performance of src/api/products.controller.ts
Issues:
- API response time: 3 seconds (should be <500ms)
- Database queries: 50+ per request

Optimize for:
- Response time
- Database efficiency
- Memory usage
```

**Frontend Optimization:**
```
@performance-tuner optimize React component src/components/ProductList.tsx
Issues:
- Re-renders on every state change
- Large bundle size
- Slow initial load

Provide:
- Memoization strategy
- Code splitting approach
- Bundle optimization
```

**Configuration:**
```yaml
---
name: "performance-tuner"
description: "Performance optimization specialist"
tools:
  - "Read"
  - "Write"
  - "Edit"
  - "Grep"
  - "Bash"
model: "claude-opus-4"
capabilities:
  - "performance-profiling"
  - "bottleneck-identification"
  - "query-optimization"
  - "caching-strategies"
---
```

**[Full Documentation →](../../agents/performance-tuner/SKILL.md)**

---

## Security Agents

### @security-auditor

**Expertise:** Security analysis, vulnerability assessment, OWASP Top 10

**Specializations:**
- Security vulnerability scanning
- OWASP Top 10 assessment
- Authentication/authorization review
- Secure coding practices
- Penetration testing guidance

**Best For:**
- Security audits
- Vulnerability assessment
- Pre-deployment security review
- Security architecture review
- Compliance validation

**Invocation Examples:**

**Security Audit:**
```
@security-auditor conduct security audit of src/api/
Focus on:
1. OWASP Top 10 vulnerabilities
2. Authentication/authorization flaws
3. Input validation
4. Secure data handling
```

**Authentication Review:**
```
@security-auditor review authentication implementation
Files: src/auth/
Check for:
- Secure password handling
- JWT token security
- Session management
- Rate limiting
- CSRF protection
```

**Configuration:**
```yaml
---
name: "security-auditor"
description: "Security expert specializing in vulnerability assessment"
tools:
  - "Read"
  - "Grep"
  - "Glob"
  - "Bash"
model: "claude-opus-4"
capabilities:
  - "vulnerability-scanning"
  - "owasp-top-10"
  - "security-architecture"
  - "penetration-testing"
max_iterations: 100
---
```

**[Full Documentation →](../../agents/security-auditor/SKILL.md)**

---

## Refactoring Agents

### @refactor-expert

**Expertise:** Code refactoring, technical debt reduction, modernization

**Specializations:**
- Code refactoring
- Technical debt reduction
- Design pattern implementation
- Code modernization
- Dependency updates

**Best For:**
- Large refactoring tasks
- Technical debt cleanup
- Code modernization
- Design pattern application
- Legacy code improvement

**Invocation Examples:**

**Refactoring:**
```
@refactor-expert refactor src/services/legacy-payment.service.ts
Goals:
- Modern TypeScript patterns
- Improved testability
- Better error handling
- Separation of concerns
Maintain: Backward compatibility
```

**Technical Debt:**
```
@refactor-expert analyze technical debt in src/
Prioritize:
1. High-impact, low-effort fixes
2. Security-related debt
3. Performance improvements

Provide: Phased refactoring plan
```

**Configuration:**
```yaml
---
name: "refactor-expert"
description: "Code refactoring and modernization specialist"
tools:
  - "Read"
  - "Write"
  - "Edit"
  - "Grep"
  - "Glob"
  - "Bash"
model: "claude-opus-4"
capabilities:
  - "code-refactoring"
  - "technical-debt-reduction"
  - "design-patterns"
  - "code-modernization"
max_iterations: 75
---
```

**[Full Documentation →](../../agents/refactor-expert/SKILL.md)**

---

## Agent Coordination

Agents can invoke other agents using the Task tool:

```
@architect design authentication system
[Invokes @security-auditor for security review]
[Invokes @performance-tuner for optimization]
```

**Coordination Patterns:**

**Sequential:**
```
@code-reviewer → @test-engineer → @security-auditor
```

**Parallel (through command):**
```
/review → @code-reviewer + @security-auditor + @performance-tuner
```

---

## Best Practices

### 1. Provide Context

**Bad:**
```
@code-reviewer review this
```

**Good:**
```
@code-reviewer review src/api/payment.controller.ts

Context:
- Production API serving 5k req/min
- Payment processing with Stripe
- PCI compliance required

Focus on:
1. Security (OWASP Top 10)
2. Error handling and recovery
3. Transaction safety
4. Rate limiting
```

---

### 2. Be Specific

**Bad:**
```
@architect design something scalable
```

**Good:**
```
@architect design scalable notification system

Requirements:
- 100k notifications/day
- Email, SMS, push
- Priority queuing
- Delivery tracking
- Retry logic

Constraints:
- Budget: $500/month
- Team: 2 developers
- Timeline: 4 weeks
```

---

### 3. Break Down Complex Tasks

**Instead of:**
```
@code-reviewer analyze entire codebase
```

**Do:**
```
@code-reviewer analyze src/api/users.controller.ts
@code-reviewer analyze src/api/products.controller.ts
@code-reviewer analyze src/api/orders.controller.ts
```

---

### 4. Combine Skills and Agents

```
Workflow:
1. Skill detects issue (automatic)
2. Review skill suggestion
3. Invoke agent for deep analysis: @agent-name
4. Implement fix
5. Verify with /review command
```

---

## Troubleshooting

### Agent Not Found

```bash
# Check agent exists
ls ~/.claude/agents/code-reviewer/

# Verify configuration
cat ~/.claude/agents/code-reviewer/SKILL.md

# Check enabled field
---
enabled: true
---
```

**[Complete troubleshooting →](../guides/troubleshooting.md#agent-issues)**

---

## Custom Agent Development

**[Contributing Guide →](../guides/contributing.md#creating-an-agent)**

---

## See Also

- **[Getting Started →](../guides/getting-started.md)** - Learn how agents work
- **[Configuration Guide →](../guides/configuration.md)** - Advanced configuration
- **[Skills Reference →](skills-reference.md)** - Automatic helpers
- **[Commands Reference →](commands-reference.md)** - Workflow automation

---

**Last Updated:** November 7, 2025 | **Version:** 2.0.0
