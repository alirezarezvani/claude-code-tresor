# Agent Dependencies & Relationships

> **Mapping agent coordination patterns, dependencies, and workflows**
>
> **Last Updated**: November 15, 2025 | **Version**: 2.5.0

---

## Table of Contents

1. [Overview](#overview)
2. [Dependency Patterns](#dependency-patterns)
3. [Skill Coordination](#skill-coordination)
4. [Agent-to-Agent Workflows](#agent-to-agent-workflows)
5. [Dependency Map](#dependency-map)
6. [Workflow Examples](#workflow-examples)
7. [Best Practices](#best-practices)

---

## Overview

### Types of Dependencies

Claude Code Tresor implements a **three-tier agent system**:

1. **Skills** (Autonomous Background Helpers)
   - Lightweight, automatic activation
   - Limited tool access (Read, Grep, Glob, Edit)
   - Quick checks and suggestions (3-5 items)
   - Examples: security-auditor skill, test-generator skill

2. **Sub-Agents** (Specialized Experts)
   - Manual invocation via `@agent-name`
   - Full tool access (configured via frontmatter)
   - Comprehensive analysis and implementation
   - Examples: code-reviewer, test-engineer, architect

3. **Commands** (Workflow Orchestrators)
   - Manual invocation via `/command`
   - Coordinates multiple agents and skills
   - End-to-end workflows
   - Examples: /review, /test-gen, /scaffold

---

### Coordination Patterns

```
┌────────────────────────────────────────────────────┐
│           AGENT COORDINATION PATTERNS              │
├────────────────────────────────────────────────────┤
│                                                    │
│  Pattern 1: Skill → Agent (Most Common)           │
│  ┌─────────┐    invokes    ┌───────────┐         │
│  │  Agent  │ ───────────→   │   Skill   │         │
│  │ (Expert)│                │(Auto-scan)│         │
│  └────┬────┘                └─────┬─────┘         │
│       │  builds on findings       │               │
│       └───────────────────────────┘               │
│       Comprehensive analysis                       │
│                                                    │
│  Pattern 2: Agent → Agent (Task Tool)             │
│  ┌─────────┐    delegates   ┌───────────┐        │
│  │ Agent A │ ───────────→    │  Agent B  │        │
│  │         │   (Task tool)   │           │        │
│  └─────────┘                 └───────────┘        │
│                                                    │
│  Pattern 3: Command → Agents (Orchestration)      │
│  ┌─────────┐    invokes     ┌───────────┐        │
│  │ Command │ ───────────→    │ Agent 1   │        │
│  │         │ ───────────→    │ Agent 2   │        │
│  │         │ ───────────→    │ Agent 3   │        │
│  └─────────┘                 └───────────┘        │
│                                                    │
└────────────────────────────────────────────────────┘
```

---

## Dependency Patterns

### Pattern 1: Skill-Agent Coordination (Primary Pattern)

**Core agents/** use this pattern extensively:

#### code-reviewer Dependencies

**Invokes Skills**:
- `security-auditor skill` - Quick OWASP Top 10 scan
- `test-generator skill` - Test coverage analysis
- `secret-scanner skill` - Credential detection (implicit via security-auditor)
- `dependency-auditor skill` - CVE checking (implicit via security-auditor)

**Workflow**:
```
1. User invokes: @code-reviewer Review this PR
2. code-reviewer agent:
   a. [Invoke security-auditor skill for initial scan]
   b. [Invoke test-generator skill to check coverage]
3. Skills return findings:
   - security-auditor: "Found SQL injection at line 45"
   - test-generator: "Coverage: 45% (target: 80%)"
4. code-reviewer builds on findings:
   - Contextual analysis of SQL injection impact
   - Review architecture for other similar vulnerabilities
   - Test coverage gaps with recommended tests
   - Strategic recommendations
```

---

#### test-engineer Dependencies

**Invokes Skills**:
- `code-reviewer skill` - Testability analysis
- `test-generator skill` - Basic test scaffolding

**Workflow**:
```
1. User invokes: @test-engineer Create tests for UserService
2. test-engineer agent:
   a. [Invoke code-reviewer skill for testability check]
   b. [Invoke test-generator skill for basic structure]
3. Skills return findings:
   - code-reviewer: "Code has tight coupling, needs refactoring"
   - test-generator: "Generated 15 test stubs"
4. test-engineer builds on findings:
   - Comprehensive test strategy (unit, integration, e2e)
   - Test pyramid approach
   - Mock/stub recommendations
   - Edge cases and property-based tests
```

---

#### security-auditor Dependencies

**Invokes Skills**:
- `security-auditor skill` - OWASP pattern detection
- `secret-scanner skill` - Hardcoded credentials
- `dependency-auditor skill` - Known CVEs

**Workflow**:
```
1. User invokes: @security-auditor Audit authentication system
2. security-auditor agent:
   a. [Invoke security-auditor skill for OWASP scan]
   b. [Invoke secret-scanner skill for credential check]
   c. [Invoke dependency-auditor skill for CVE check]
3. Skills return findings:
   - security-auditor: "3 OWASP violations found"
   - secret-scanner: "API key exposed in config.js"
   - dependency-auditor: "JWT library has CVE-2024-1234"
4. security-auditor builds on findings:
   - Strategic security architecture review
   - Threat modeling for authentication flows
   - Compliance assessment (OWASP, PCI-DSS, etc.)
   - Remediation roadmap with priorities
```

---

#### refactor-expert Dependencies

**Invokes Skills**:
- `code-reviewer skill` - Code smell detection
- `test-generator skill` - Coverage verification (critical!)

**Workflow**:
```
1. User invokes: @refactor-expert Refactor legacy payment module
2. refactor-expert agent:
   a. [Invoke code-reviewer skill for code smell scan]
   b. [Invoke test-generator skill to verify coverage]
3. Skills return findings:
   - code-reviewer: "God class detected, 15 code smells"
   - test-generator: "Coverage: 30% - RISKY for refactoring!"
4. refactor-expert builds on findings:
   - FIRST increase test coverage to 80%+
   - Then systematic refactoring strategy
   - SOLID principles application
   - Design pattern recommendations
```

---

#### performance-tuner Dependencies

**Invokes Skills**:
- `code-reviewer skill` - Performance anti-pattern detection

**Workflow**:
```
1. User invokes: @performance-tuner Optimize database queries
2. performance-tuner agent:
   a. [Invoke code-reviewer skill for anti-pattern scan]
3. Skills return findings:
   - code-reviewer: "N+1 query detected, missing indexes"
4. performance-tuner builds on findings:
   - Profiling strategy (CPU, memory, I/O)
   - Bottleneck identification
   - Optimization roadmap
   - Measurement and verification plan
```

---

#### docs-writer Dependencies

**Invokes Skills**:
- `api-documenter skill` - OpenAPI spec generation
- `readme-updater skill` - README currency check

**Workflow**:
```
1. User invokes: @docs-writer Create API documentation
2. docs-writer agent:
   a. [Invoke api-documenter skill for OpenAPI structure]
   b. [Invoke readme-updater skill for README check]
3. Skills return findings:
   - api-documenter: "Generated OpenAPI 3.0 spec with 25 endpoints"
   - readme-updater: "README outdated, missing 10 new features"
4. docs-writer builds on findings:
   - Comprehensive user guides
   - Architecture documentation
   - Tutorial content
   - Interactive API documentation setup
```

---

#### debugger Dependencies

**Invokes**: NONE (standalone investigation agent)

**Note**: debugger uses investigation tools (Read, Bash, Grep) but doesn't invoke other agents/skills. It's a primary investigator.

**Workflow**:
```
1. User invokes: @debugger Fix production API timeout
2. debugger agent:
   - Hypothesis generation
   - Systematic investigation (logs, metrics, traces)
   - Root cause analysis
   - Minimal-impact fix
   - Prevention strategy
(No skill/agent coordination)
```

---

#### architect Dependencies

**Can invoke**: Multiple agents via Task tool (but not skills)

**Note**: architect is a strategic agent that may coordinate with other specialists:

**Workflow**:
```
1. User invokes: @architect Design system for 100k concurrent users
2. architect agent may coordinate:
   - performance-tuner (scalability analysis)
   - security-auditor (security architecture)
   - backend-architect (API design)
   (Uses Task tool for coordination, not Skill tool)
```

---

### Pattern 2: Agent-to-Agent Coordination

**sources/agents/** have minimal cross-agent coordination (mostly standalone).

**Exceptions**:
- Some agents mention "coordinate with" but don't use explicit `@agent-name` syntax
- No Task tool invocations found in sources/agents/

**Conclusion**: sources/agents/ are **standalone specialists** without built-in coordination patterns.

---

### Pattern 3: Command-to-Agent Orchestration

**Commands in /commands/** orchestrate multiple agents:

#### /review Command Dependencies

**Invokes**:
1. `@code-reviewer` - Configuration safety analysis
2. `@security-auditor` - Security vulnerability scan
3. `@performance-tuner` - Performance optimization check
4. `@test-engineer` - Test coverage verification (optional)

**Workflow**:
```
User: /review --scope staged --checks security,performance,configuration

Command orchestrates:
1. git diff to identify changed files
2. @code-reviewer for configuration safety
3. @security-auditor for vulnerabilities
4. @performance-tuner for bottlenecks
5. Aggregate findings into prioritized report
```

---

#### /test-gen Command Dependencies

**Invokes**:
1. `@test-engineer` - Comprehensive test strategy
2. `@code-reviewer` - Testability assessment (implicit via test-engineer)

**Workflow**:
```
User: /test-gen --file utils.js --framework jest --coverage 90

Command orchestrates:
1. @test-engineer creates test suite
2. Generates test files
3. Runs coverage report
4. Iterates until target coverage reached
```

---

#### /scaffold Command Dependencies

**Invokes**:
- Specialized agents based on scaffold type
- Examples: backend-architect, frontend-developer, test-engineer

**Workflow**:
```
User: /scaffold react-component UserProfile --hooks --tests

Command orchestrates:
1. frontend-developer creates component
2. test-engineer creates test file
3. docs-writer creates usage documentation
```

---

## Skill Coordination

### Available Skills (Autonomous Background Helpers)

#### Security Skills
| Skill Name | Purpose | Triggers | Output |
|------------|---------|----------|--------|
| **security-auditor** | OWASP Top 10 scanning | File saves, commits, agent invocation | 3-5 vulnerability findings |
| **secret-scanner** | Credential detection | File saves, commits | Exposed API keys, passwords |
| **dependency-auditor** | CVE checking | package.json/requirements.txt changes | Known vulnerabilities in deps |

#### Development Skills
| Skill Name | Purpose | Triggers | Output |
|------------|---------|----------|--------|
| **code-reviewer** | Code quality checks | File saves, commits | 3-5 code smell findings |
| **test-generator** | Test scaffolding | New code without tests | Test stub suggestions |
| **git-commit-helper** | Commit message generation | Pre-commit | Conventional commit message |

#### Documentation Skills
| Skill Name | Purpose | Triggers | Output |
|------------|---------|----------|--------|
| **api-documenter** | OpenAPI generation | API route changes | OpenAPI spec updates |
| **readme-updater** | README maintenance | Feature additions | README update suggestions |

---

### Skill Invocation Syntax

**From Agent Definitions** (markdown convention):
```markdown
[Invoke security-auditor skill for initial scan]
[Invoke test-generator skill to check coverage]
[Invoke api-documenter skill for OpenAPI spec]
```

**Expected Behavior**:
1. Skill runs lightweight check (Read, Grep, Glob, Edit tools only)
2. Returns 3-5 quick findings
3. Agent builds on findings with comprehensive analysis

---

## Agent-to-Agent Workflows

### Common Coordination Scenarios

#### Scenario 1: Comprehensive Code Review

```
User request: "Review this PR for production readiness"

Workflow:
1. @code-reviewer (primary)
   ├─ [Invoke security-auditor skill]
   ├─ [Invoke test-generator skill]
   └─ Comprehensive review
2. If critical security issues found:
   └─ @security-auditor (Task tool delegation)
      └─ Deep security architecture review
3. If performance concerns identified:
   └─ @performance-tuner (Task tool delegation)
      └─ Profiling and optimization strategy
```

---

#### Scenario 2: Legacy Code Modernization

```
User request: "Modernize this legacy authentication module"

Workflow:
1. @security-auditor (first - safety check)
   ├─ [Invoke security-auditor skill]
   ├─ [Invoke secret-scanner skill]
   └─ Identify security vulnerabilities
2. @test-engineer (second - safety net)
   ├─ [Invoke code-reviewer skill]
   ├─ [Invoke test-generator skill]
   └─ Create comprehensive test coverage
3. @refactor-expert (third - modernization)
   ├─ [Invoke code-reviewer skill]
   ├─ [Invoke test-generator skill - verify coverage!]
   └─ Systematic refactoring with tests
4. @performance-tuner (fourth - optimization)
   └─ Performance profiling and optimization
```

---

#### Scenario 3: New Feature Development

```
User request: "Build new payment processing feature"

Workflow:
1. @architect (design)
   └─ System design, technology choices, scalability
2. @security-auditor (security design)
   └─ Threat modeling, security requirements
3. @backend-architect (implementation design)
   └─ API design, database schema, microservices
4. @test-engineer (test strategy)
   └─ Test pyramid, coverage targets, test types
5. @docs-writer (documentation)
   └─ API docs, user guides, architecture diagrams
```

---

#### Scenario 4: Production Incident Response

```
User request: "Production API is timing out, fix immediately"

Workflow:
1. @debugger (investigation)
   └─ Root cause analysis, minimal fix
2. @performance-tuner (optimization)
   └─ Performance profiling, bottleneck resolution
3. @code-reviewer (post-mortem)
   └─ Code review, prevention strategies
4. @docs-writer (runbook)
   └─ Incident documentation, runbook updates
```

---

## Dependency Map

### Core Agent Dependencies (agents/)

```
code-reviewer
 ├─ Invokes: security-auditor skill, test-generator skill
 └─ Invoked by: refactor-expert, debugger, performance-tuner

test-engineer
 ├─ Invokes: code-reviewer skill, test-generator skill
 └─ Invoked by: All agents for test creation

security-auditor
 ├─ Invokes: security-auditor skill, secret-scanner skill, dependency-auditor skill
 └─ Invoked by: code-reviewer, architect, debugger

architect
 ├─ Invokes: No skills (strategic agent)
 └─ Invoked by: All agents for design decisions

debugger
 ├─ Invokes: None (standalone investigator)
 └─ Invoked by: All agents when issues found

docs-writer
 ├─ Invokes: api-documenter skill, readme-updater skill
 └─ Invoked by: All agents for documentation

refactor-expert
 ├─ Invokes: code-reviewer skill, test-generator skill
 └─ Invoked by: code-reviewer, architect

performance-tuner
 ├─ Invokes: code-reviewer skill
 └─ Invoked by: code-reviewer, architect, debugger
```

---

### Sources Agent Dependencies (sources/agents/)

**Note**: Most sources/agents/ are **standalone** with no explicit dependencies.

**Exceptions** (implicit coordination mentioned in descriptions):
- senior-software-engineer: May coordinate with specialists
- product-manager-orchestrator: Coordinates product workflows
- systems-architect: May consult specialists

**No explicit `@agent-name` invocations found in sources/agents/.**

---

### Skill Dependencies

```
Skills (8 total):

security-auditor skill
 └─ Used by: code-reviewer, security-auditor, refactor-expert

test-generator skill
 └─ Used by: code-reviewer, test-engineer, refactor-expert

secret-scanner skill
 └─ Used by: security-auditor

dependency-auditor skill
 └─ Used by: security-auditor

code-reviewer skill
 └─ Used by: test-engineer, refactor-expert, performance-tuner

git-commit-helper skill
 └─ Used by: (auto-invoked on pre-commit)

api-documenter skill
 └─ Used by: docs-writer

readme-updater skill
 └─ Used by: docs-writer
```

---

## Workflow Examples

### Example 1: Full Code Review Workflow

```
User: @code-reviewer Review this PR for security and performance

code-reviewer workflow:
1. Read PR description and context
2. [Invoke security-auditor skill for quick scan]
   └─ Skill finds: SQL injection, XSS vulnerability
3. [Invoke test-generator skill to check coverage]
   └─ Skill finds: Coverage 45% (target 80%)
4. Code analysis:
   - SQL injection: Critical, full database access risk
   - XSS: High, user data exposure
   - Missing tests: High risk for refactoring
5. Building on skill findings:
   - Detailed exploit analysis for SQL injection
   - Architecture review for similar vulnerabilities
   - Test strategy to reach 80% coverage
6. Recommendations:
   - CRITICAL: Fix SQL injection with parameterized queries
   - HIGH: Add input validation and XSS prevention
   - HIGH: Increase test coverage before merging
   - MEDIUM: Consider ORM to prevent future SQL issues

Result: Comprehensive review with prioritized action items
```

---

### Example 2: Legacy Modernization Workflow

```
User: @refactor-expert Modernize this 5000-line legacy module

refactor-expert workflow:
1. [Invoke code-reviewer skill for code smell scan]
   └─ Skill finds: God class, tight coupling, 25 code smells
2. [Invoke test-generator skill to verify coverage]
   └─ Skill finds: Coverage 15% - DANGEROUS for refactoring!
3. Decision: STOP - Coverage too low, refactoring is unsafe
4. Recommendation to user:
   "⚠️ CRITICAL: Test coverage is only 15%. Refactoring without tests
   is extremely risky and could introduce bugs.

   Recommended approach:
   1. FIRST: @test-engineer Create comprehensive test suite (target 80%)
   2. THEN: Verify all tests pass
   3. ONLY THEN: Proceed with refactoring safely

   Would you like me to invoke @test-engineer to create tests first?"
5. User: "Yes, create tests first"
6. refactor-expert: Uses Task tool to invoke @test-engineer
7. @test-engineer creates comprehensive tests
8. refactor-expert: Verifies coverage reaches 80%
9. refactor-expert: NOW proceeds with safe, test-driven refactoring
   - Extract god class into smaller classes
   - Apply SOLID principles
   - Remove code smells systematically
   - Verify tests pass after each change

Result: Safe, systematic modernization with test safety net
```

---

### Example 3: Security Audit Workflow

```
User: @security-auditor Full security audit of authentication system

security-auditor workflow:
1. [Invoke security-auditor skill for OWASP scan]
   └─ Skill finds: Weak password hashing, missing CSRF, insecure sessions
2. [Invoke secret-scanner skill for credential check]
   └─ Skill finds: Hardcoded JWT secret in config.js
3. [Invoke dependency-auditor skill for CVE check]
   └─ Skill finds: JWT library has critical CVE-2024-1234
4. Building on skill findings:
   - Strategic security architecture review
   - Threat modeling for authentication flows
   - Attack vector analysis (credential stuffing, session hijacking, etc.)
   - Compliance assessment (OWASP, PCI-DSS if payment system)
5. Comprehensive audit report:
   - CRITICAL: CVE in JWT library - immediate upgrade required
   - CRITICAL: Hardcoded secret - rotate and use environment variables
   - HIGH: Weak password hashing - migrate to bcrypt with cost 12+
   - HIGH: Missing CSRF protection - implement token-based protection
   - MEDIUM: Session management - implement secure session handling
6. Remediation roadmap with timeline:
   - Week 1: Fix critical issues (CVE, hardcoded secret)
   - Week 2: Upgrade password hashing (with migration strategy)
   - Week 3: Implement CSRF protection
   - Week 4: Improve session management

Result: Strategic security audit with prioritized remediation plan
```

---

## Best Practices

### 1. Skill-Agent Coordination

**DO**:
- ✅ Invoke skills at the START of agent analysis
- ✅ Build on skill findings with expert context
- ✅ Acknowledge skill findings in final report
- ✅ Use skills for quick automated checks
- ✅ Use agents for comprehensive strategic analysis

**DON'T**:
- ❌ Skip skill invocation for multi-file reviews
- ❌ Duplicate what skills already do
- ❌ Ignore skill findings
- ❌ Use skills for deep analysis (that's the agent's job)

---

### 2. Agent-to-Agent Coordination

**DO**:
- ✅ Use Task tool for agent delegation
- ✅ Provide clear context when delegating
- ✅ Specify what you need from the other agent
- ✅ Coordinate for complex multi-domain tasks

**DON'T**:
- ❌ Chain too many agents (complexity overhead)
- ❌ Delegate simple tasks
- ❌ Create circular dependencies

---

### 3. Workflow Design

**DO**:
- ✅ Start with safety checks (security, tests)
- ✅ Proceed systematically (design → implement → test → document)
- ✅ Verify coverage before refactoring
- ✅ Use correct specialist for each step

**DON'T**:
- ❌ Skip safety checks (security, tests)
- ❌ Refactor without test coverage
- ❌ Use generalist when specialist exists

---

## Summary

### Coordination Patterns

1. **Skill → Agent**: Primary pattern in core agents/
2. **Agent → Agent**: Via Task tool for complex coordination
3. **Command → Agents**: Orchestration for end-to-end workflows
4. **Standalone**: Most sources/agents/ work independently

### Key Dependencies

- **code-reviewer**: security-auditor skill, test-generator skill
- **test-engineer**: code-reviewer skill, test-generator skill
- **security-auditor**: security-auditor skill, secret-scanner skill, dependency-auditor skill
- **refactor-expert**: code-reviewer skill, test-generator skill
- **performance-tuner**: code-reviewer skill
- **docs-writer**: api-documenter skill, readme-updater skill
- **debugger**: None (standalone investigator)
- **architect**: None (strategic coordinator)

### Workflow Principles

1. **Skills first**: Quick automated checks
2. **Agents second**: Expert comprehensive analysis
3. **Commands third**: Orchestrated workflows
4. **Safety always**: Security and test checks before changes

---

**See Also**:
- [Agent Inventory](AGENT-INVENTORY.md)
- [Agent Categorization](AGENT-CATEGORIZATION.md)
- [Duplicate Analysis](DUPLICATE-ANALYSIS.md)
- [Sub-Agent Structure](SUB-AGENT-STRUCTURE.md)
