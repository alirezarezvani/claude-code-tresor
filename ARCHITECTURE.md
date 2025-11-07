# Architecture Guide

> **Understanding the 3-tier system: Skills → Sub-Agents → Commands**

Claude Code Tresor uses a carefully designed 3-tier architecture that provides the right tool for every task, from automatic background checks to complex multi-step workflows.

---

## Overview

```
┌─────────────────────────────────────────────────────────────┐
│                     Your Development Flow                    │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
        ┌──────────────────────────────────────────┐
        │          Tier 1: SKILLS                  │
        │      (Contextual Conversation Helpers)    │
        │  • Invoked by Claude automatically       │
        │  • Context-aware activation              │
        │  • Quick checks                          │
        │  • Proactive suggestions                 │
        └──────────────────────────────────────────┘
                              │
                              ▼ (User decides to investigate)
        ┌──────────────────────────────────────────┐
        │          Tier 2: SUB-AGENTS              │
        │        (Manual Expert Analysis)          │
        │  • Invoked by you (@agent)               │
        │  • Deep analysis                         │
        │  • Separate context                      │
        │  • Expert recommendations                │
        └──────────────────────────────────────────┘
                              │
                              ▼ (User runs workflow)
        ┌──────────────────────────────────────────┐
        │          Tier 3: COMMANDS                │
        │      (Multi-Agent Orchestration)         │
        │  • Complex workflows (/command)          │
        │  • Coordinates multiple agents           │
        │  • Automates repetitive tasks            │
        │  • End-to-end processes                  │
        └──────────────────────────────────────────┘
```

---

## Tier 1: Skills (Contextual Helpers)

### What Are Skills?

Skills are **lightweight, contextual helpers** that Claude invokes automatically during conversations when they're relevant to your discussion or task.

**Key characteristics:**
- ✅ **Claude-invoked** - Claude decides when to activate based on conversation context
- ✅ **Shared context** - See your current conversation and understand the discussion
- ✅ **Limited tools** - Restricted to safe operations (Read, Write, Edit, Grep, Glob, Bash)
- ✅ **Single-purpose** - Each skill has one clear responsibility
- ✅ **Non-blocking** - Provide suggestions without interrupting flow

### How Skills Activate

Skills are invoked by Claude based on **conversation relevance** and their description:

```yaml
---
name: code-reviewer
description: Use when discussing code quality, reviewing files, or analyzing patterns...
---
```

**Invocation examples:**
- You ask "Review this code" → `code-reviewer` is invoked
- You discuss new function testing → `test-generator` is invoked
- You ask about API documentation → `api-documenter` is invoked
- You discuss commit messages → `git-commit-helper` is invoked

### Skills in Action

```javascript
// You write this code:
function getUser(id) {
  return db.query('SELECT * FROM users WHERE id = ' + id)
}

// Immediately, multiple skills activate:

// 1. code-reviewer skill:
// ⚠️ Missing error handling
// 💡 Consider adding try-catch

// 2. security-auditor skill:
// 🚨 SQL Injection vulnerability
// 🔧 Use parameterized queries

// 3. test-generator skill:
// 📋 Missing tests for getUser()
// 💡 Suggest 3 basic tests

// You see all suggestions at once
```

### Available Skills (8 Core)

| Skill | Purpose | Triggers On |
|-------|---------|-------------|
| **code-reviewer** | Code quality checks | File edits, saves |
| **test-generator** | Suggest missing tests | New functions, untested code |
| **git-commit-helper** | Generate commit messages | Git diff, "commit" mentioned |
| **security-auditor** | Vulnerability scanning | Auth code, API endpoints |
| **secret-scanner** | Detect exposed secrets | Pre-commit, API keys in code |
| **dependency-auditor** | Check for CVEs | package.json changes |
| **api-documenter** | Generate OpenAPI specs | API routes added |
| **readme-updater** | Keep README current | Project changes, features added |

**Design principle:** Skills are like **spell-checker in your editor** - always on, always helping, never intrusive.

---

## Tier 2: Sub-Agents (Manual Experts)

### What Are Sub-Agents?

Sub-agents are **manually-invoked specialists** that provide deep, comprehensive analysis when you explicitly request it.

**Key characteristics:**
- ✅ **User-invoked** - You explicitly call them (`@agent`)
- ✅ **Separate context** - Dedicated focus on the task
- ✅ **Full tool access** - Can use Read, Write, Edit, Bash, Grep, Glob, Task, WebFetch
- ✅ **Expert depth** - Comprehensive analysis and recommendations
- ✅ **Task-oriented** - Complete a specific analysis task

### How Sub-Agents Work

You invoke sub-agents when you need **deep analysis** that goes beyond quick skill suggestions:

```bash
# General syntax
@agent-name [task description] [--flags]

# Examples
@code-reviewer Analyze this component for React best practices
@test-engineer Create comprehensive test suite with edge cases
@docs-writer Generate user guide with troubleshooting section
@architect Evaluate this microservices design
@debugger Analyze this stack trace and suggest fixes
```

### Sub-Agents in Action

```javascript
// After skill detected issue:
// skill: "⚠️ Potential security issue in authentication"

// You invoke expert:
You: @code-reviewer --focus security

// Sub-agent provides deep analysis:
@code-reviewer:

📋 SECURITY ANALYSIS: Authentication Module

🚨 CRITICAL ISSUES (2)
1. Line 45: Hardcoded JWT secret
   - Risk: Secret exposure in version control
   - Fix: Move to environment variable
   - Example: process.env.JWT_SECRET

2. Line 67: No rate limiting on login endpoint
   - Risk: Brute force attacks
   - Fix: Implement express-rate-limit
   - Config: 5 attempts per 15 minutes

⚠️ MEDIUM ISSUES (3)
[detailed analysis...]

📖 RECOMMENDATIONS
[architectural improvements...]

✅ GOOD PRACTICES FOUND
[positive feedback...]
```

### Available Sub-Agents (8 Core)

| Agent | Expertise | When to Use |
|-------|-----------|-------------|
| **@code-reviewer** | Code quality, patterns, security | PR reviews, refactoring validation |
| **@test-engineer** | Test suite creation, coverage | Comprehensive testing needs |
| **@docs-writer** | User guides, API docs, tutorials | Documentation site creation |
| **@architect** | System design, architecture | Design reviews, technical decisions |
| **@debugger** | Root cause analysis, debugging | Production issues, complex bugs |
| **@security-auditor** | Vulnerability analysis, compliance | Security audits, penetration testing prep |
| **@performance-tuner** | Performance optimization | Slow queries, memory leaks |
| **@refactor-expert** | Code restructuring, patterns | Technical debt, legacy code |

**Design principle:** Sub-agents are like **consulting an expert** - you schedule time when you need deep help.

---

## Tier 3: Commands (Orchestration)

### What Are Commands?

Commands are **multi-agent workflows** that orchestrate skills and sub-agents to complete complex, end-to-end processes.

**Key characteristics:**
- ✅ **User-triggered** - You explicitly run them (`/command`)
- ✅ **Multi-step workflows** - Coordinate multiple tools
- ✅ **Agent orchestration** - Invoke sub-agents in sequence
- ✅ **Batch operations** - Apply across multiple files
- ✅ **Workflow automation** - Eliminate repetitive tasks

### How Commands Work

Commands provide **structured workflows** for common development tasks:

```bash
# General syntax
/command [args] [--options]

# Examples
/scaffold react-component UserProfile --hooks --tests
/review --scope staged --checks all
/test-gen --file utils.js --framework jest --coverage 90
/docs-gen api --format openapi --include-examples
```

### Commands in Action

```bash
# Example: /review command workflow

You: /review --scope staged --checks all

Command orchestrates:

Step 1: Analyze staged changes
├─ skill: code-reviewer (quick scan)
├─ Read: git diff --staged
└─ Parse: Identify modified files

Step 2: Coordinate expert reviews
├─ @code-reviewer    → Code quality analysis
├─ @security-auditor → Vulnerability scan
├─ @performance-tuner→ Performance check
└─ @architect        → Architecture validation

Step 3: Aggregate results
├─ Combine findings from all agents
├─ Prioritize issues (CRITICAL → LOW)
├─ Remove duplicates
└─ Add line numbers and context

Step 4: Generate report
└─ Markdown report with:
    - Executive summary
    - Issue breakdown by severity
    - Actionable recommendations
    - Code examples with fixes

Total time: 3-5 minutes
Manual equivalent: 30-45 minutes
```

### Available Commands (4 Core)

| Command | Purpose | What It Orchestrates |
|---------|---------|----------------------|
| **/scaffold** | Generate boilerplate | Creates files, adds tests, docs |
| **/review** | Comprehensive code review | @code-reviewer + @security-auditor + @performance-tuner + @architect |
| **/test-gen** | Generate test suites | @test-engineer + test-generator skill |
| **/docs-gen** | Generate documentation | @docs-writer + api-documenter + readme-updater |

**Design principle:** Commands are like **running a script** - automate complex multi-step processes.

---

## Integration Patterns

### Pattern 1: Skill → User → Sub-Agent

**Flow:** Skill detects → User investigates → Sub-agent analyzes

```
┌──────────────┐
│ Skill alerts │  "⚠️ Potential memory leak"
└──────┬───────┘
       │
       ▼
┌──────────────┐
│ User decides │  "Let me investigate"
└──────┬───────┘
       │
       ▼
┌──────────────────┐
│ Sub-agent deep   │  @debugger Analyze memory usage in this module
│ analysis         │  → Comprehensive report with stack traces
└──────────────────┘
```

**Example:**
```javascript
// 1. Skill: "⚠️ test-generator: Missing tests for calculateDiscount()"
// 2. You: "This is critical, needs comprehensive testing"
// 3. You invoke: @test-engineer Create full test suite with edge cases
// 4. Sub-agent: Generates 15 tests covering all scenarios
```

---

### Pattern 2: User → Command → Multi-Agent

**Flow:** User triggers → Command orchestrates → Agents execute

```
┌──────────────┐
│ User runs    │  /review --scope staged
│ command      │
└──────┬───────┘
       │
       ▼
┌────────────────────────────┐
│ Command coordinates:       │
│  1. @code-reviewer         │
│  2. @security-auditor      │
│  3. @performance-tuner     │
│  4. @architect             │
└────────┬───────────────────┘
         │
         ▼
┌────────────────────────────┐
│ Aggregated results with    │
│ prioritized recommendations│
└────────────────────────────┘
```

**Example:**
```bash
# You: /review --scope pr --checks all
# Command runs all agents in parallel, combines results
# Output: Single comprehensive report in 5 minutes
```

---

### Pattern 3: Multiple Skills Collaborate

**Flow:** Multiple skills detect different aspects simultaneously

```
┌────────────────┐       ┌────────────────┐       ┌────────────────┐
│ code-reviewer  │       │ security-      │       │ test-generator │
│ skill          │       │ auditor skill  │       │ skill          │
└────────┬───────┘       └────────┬───────┘       └────────┬───────┘
         │                        │                        │
         ▼                        ▼                        ▼
    "Code smell"          "SQL injection"         "Missing tests"
         │                        │                        │
         └────────────────────────┴────────────────────────┘
                                  │
                                  ▼
                        User sees all suggestions
```

**Example:**
```javascript
// You write function with multiple issues:
function login(username, password) {
  const query = 'SELECT * FROM users WHERE name = ' + username  // Issue 1
  const user = db.query(query)  // Issue 2
  if (user.password === password) return user  // Issue 3
}

// Multiple skills activate simultaneously:
// • code-reviewer: "No error handling, missing types"
// • security-auditor: "SQL injection (line 2), plaintext password (line 4)"
// • test-generator: "Missing tests - suggest 4 tests"

// You see comprehensive feedback immediately
```

---

### Pattern 4: Continuous Development Cycle

**Flow:** Skills monitor → Commands execute → Sub-agents deep-dive

```
┌─────────────────────────────────────────────────────────┐
│                   DEVELOPMENT CYCLE                     │
└─────────────────────────────────────────────────────────┘

1. WRITE CODE
   └─→ Skills monitor continuously
       • code-reviewer checks quality
       • security-auditor scans for vulnerabilities
       • test-generator suggests tests

2. STAGE CHANGES
   └─→ git add .
       • secret-scanner prevents exposed secrets
       • git-commit-helper suggests commit message

3. RUN WORKFLOW
   └─→ /review --scope staged
       • Command orchestrates all agents
       • Comprehensive validation

4. DEEP ANALYSIS (if needed)
   └─→ @architect Review this design pattern
       • Expert analysis for complex issues

5. COMMIT & DEPLOY
   └─→ Skills updated documentation automatically
       • readme-updater keeps README current
       • api-documenter updates OpenAPI specs
```

---

## Decision Tree: Which Tool to Use?

```
                    START: I need help with...
                              │
                              ▼
                    ┌─────────────────────┐
                    │ What type of help?  │
                    └─────────────────────┘
                              │
                 ┌────────────┼────────────┐
                 ▼            ▼            ▼
          AUTOMATIC      MANUAL       WORKFLOW
               │             │            │
               ▼             ▼            ▼
        ┌───────────┐  ┌────────┐  ┌─────────┐
        │  SKILLS   │  │ SUB-   │  │COMMANDS │
        │           │  │ AGENTS │  │         │
        └───────────┘  └────────┘  └─────────┘

Use SKILLS when:                Use SUB-AGENTS when:           Use COMMANDS when:
• You want continuous           • You need expert analysis      • You need multi-step
  monitoring                    • Issue requires deep dive        workflow
• Quick checks needed           • Manual investigation          • Orchestrating multiple
• Real-time suggestions         • Complex problem                 tools
• No explicit invocation        • Dedicated focus               • Batch operations
                                                                • Automation

Examples:                       Examples:                       Examples:
• Code quality while            • @code-reviewer                • /scaffold new component
  typing                          Deep security review          • /review entire PR
• Detect untested code          • @architect                    • /test-gen for file
• Security scans                  System design validation      • /docs-gen API docs
• README updates                • @debugger
                                  Root cause analysis
```

---

## Performance Characteristics

### Skills (Tier 1)

**Activation time:** Instant (< 100ms)
**Tool restrictions:** Read, Write, Edit, Grep, Glob, Bash (safe operations)
**Context size:** Shared (efficient)
**Parallelization:** Automatic (multiple skills run simultaneously)
**Use case:** Continuous background monitoring

**Optimization:**
- Lightweight by design
- Limited tool set prevents expensive operations
- Shared context reduces memory footprint

---

### Sub-Agents (Tier 2)

**Invocation time:** 30 seconds - 5 minutes (depending on task)
**Tool access:** Full (Read, Write, Edit, Bash, Grep, Glob, Task, WebFetch)
**Context size:** Dedicated (comprehensive analysis)
**Parallelization:** Manual (user decides)
**Use case:** Deep, focused analysis

**Optimization:**
- Separate context enables focused work
- Full tool access for comprehensive analysis
- Task tool allows recursive problem-solving

---

### Commands (Tier 3)

**Execution time:** 3-15 minutes (depending on workflow)
**Coordination:** Orchestrates skills + sub-agents
**Parallelization:** Intelligent (runs independent agents in parallel)
**Context management:** Aggregates results from multiple sources
**Use case:** End-to-end workflows

**Optimization:**
- Parallel agent execution where possible
- Result aggregation and deduplication
- Prioritized output (CRITICAL → LOW)

---

## Best Practices

### For Skills

1. **Let them run** - Skills are designed to be non-intrusive
2. **Review suggestions** - Skills detect, you decide
3. **Use as early warning** - Catch issues before they grow
4. **Customize triggers** - Adjust for your workflow
5. **Don't disable unnecessarily** - They're lightweight

### For Sub-Agents

1. **Be specific** - "Analyze security" vs "Check this file"
2. **Use flags** - `@code-reviewer --focus performance`
3. **One task at a time** - Sub-agents work best with clear goals
4. **Read full output** - Expert recommendations are valuable
5. **Iterate** - Re-invoke with refined questions

### For Commands

1. **Use for repetitive tasks** - Automate what you do often
2. **Combine with flags** - `/review --scope staged --checks security`
3. **Let it finish** - Commands orchestrate multiple steps
4. **Review results** - Commands surface prioritized issues
5. **Customize workflows** - Fork and modify for your team

---

## Extending the Architecture

### Custom Skills

Create custom skills for team-specific needs:

```yaml
---
name: company-security-scanner
description: Company security policy enforcement. Use when auth code modified...
allowed-tools: Read, Grep, Bash
---
```

**See:** [skills/TEMPLATES.md](skills/TEMPLATES.md)

---

### Custom Sub-Agents

Add specialized sub-agents for domain expertise:

```json
{
  "name": "mobile-performance-expert",
  "description": "React Native performance optimization specialist",
  "allowed-tools": ["Read", "Bash", "Grep", "Task", "WebFetch"]
}
```

**See:** [agents/README.md](agents/README.md)

---

### Custom Commands

Build workflows specific to your process:

```json
{
  "name": "deploy-check",
  "description": "Pre-deployment validation workflow",
  "agents": ["@security-auditor", "@test-engineer", "@performance-tuner"]
}
```

**See:** [commands/README.md](commands/README.md)

---

## Real-World Workflow Example

### Scenario: Implementing a new feature

```bash
# 1. Start coding (Skills monitor automatically)
vim src/features/user-profile.tsx

  # → code-reviewer: "Consider useCallback for event handlers"
  # → test-generator: "Suggest 3 tests for UserProfile"

# 2. Stage changes
git add src/features/user-profile.tsx

  # → secret-scanner: Checks for exposed secrets
  # → git-commit-helper: Suggests "feat(profile): add user profile component"

# 3. Run comprehensive review
/review --scope staged --checks all

  # → Orchestrates 4 sub-agents in parallel:
  #   • @code-reviewer: React best practices
  #   • @security-auditor: XSS vulnerabilities
  #   • @performance-tuner: Render optimization
  #   • @architect: Component architecture

# 4. Deep-dive on specific issue (if needed)
@code-reviewer --focus performance Analyze re-render behavior

  # → Detailed analysis with profiling recommendations

# 5. Generate tests
/test-gen --file src/features/user-profile.tsx --coverage 90

  # → Creates comprehensive test suite

# 6. Update docs automatically
# (Skills do this in background)
  # → api-documenter: Updates OpenAPI if API changed
  # → readme-updater: Adds feature to README

# 7. Commit
git commit -m "feat(profile): add user profile component"

Total time with tools: 30-40 minutes
Total time without: 3-4 hours
```

---

## Architecture Philosophy

### Design Principles

1. **Right tool for the job** - Skills for detection, sub-agents for analysis, commands for workflows
2. **Progressive disclosure** - Simple → Deep → Complex
3. **Non-blocking** - Never interrupt developer flow
4. **Composable** - Tools work together seamlessly
5. **Customizable** - Extend for team needs

### Why 3 Tiers?

**Problem:** Traditional AI assistants are either:
- Too passive (only respond when asked) OR
- Too aggressive (interrupt constantly)

**Solution:** 3-tier architecture provides:
- **Skills:** Continuous passive monitoring (non-intrusive)
- **Sub-Agents:** Deep analysis on demand (focused)
- **Commands:** Workflow automation (efficient)

**Result:** Help when you need it, silent when you don't.

---

## Next Steps

- **Get Started:** [GETTING-STARTED.md](GETTING-STARTED.md) - 5-minute quick start
- **Skills Guide:** [skills/README.md](skills/README.md) - Deep-dive on skills
- **Templates:** [skills/TEMPLATES.md](skills/TEMPLATES.md) - Create custom tools
- **Migration:** [MIGRATION-GUIDE.md](MIGRATION-GUIDE.md) - Upgrade from older versions
- **Examples:** [examples/workflows/](examples/workflows/) - Real-world patterns

---

**Created:** October 24, 2025
**Author:** Alireza Rezvani
**License:** MIT
