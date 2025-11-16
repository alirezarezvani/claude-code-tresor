# Sources vs Current Agents: Comprehensive Comparison Analysis

> **Detailed comparison of agent formats between sources/agents/ and agents/ directories**
>
> **Last Updated**: November 15, 2025 | **Version**: 2.5.0

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Agent Inventory](#agent-inventory)
3. [Structural Differences](#structural-differences)
4. [YAML Frontmatter Comparison](#yaml-frontmatter-comparison)
5. [Content Organization](#content-organization)
6. [Tool Declarations](#tool-declarations)
7. [Documentation Style](#documentation-style)
8. [Side-by-Side Examples](#side-by-side-examples)
9. [Migration Checklist](#migration-checklist)
10. [Recommendations](#recommendations)

---

## Executive Summary

### Overview

This document provides a comprehensive comparison between:
- **sources/agents/** - Extended library with 140+ agents (legacy format)
- **agents/** - Core 8 agents (v2.0+ production format)

### Key Findings

| Aspect | sources/agents/ | agents/ | Impact |
|--------|-----------------|---------|--------|
| **Total Agents** | 140+ | 8 | Curated core vs. extensive library |
| **YAML Fields** | 3 (name, description, model) | 4 (+ tools) | Enhanced security control |
| **Model Spec** | Explicit (sonnet/opus) | inherit | Centralized model management |
| **Tool Declaration** | ❌ None (implicit) | ✅ Explicit whitelist | **CRITICAL DIFFERENCE** |
| **Content Length** | 30-200 lines | 100-350+ lines | 2-3x more comprehensive |
| **Skills Section** | ❌ None | ✅ 40-100 lines | v2.0 skill coordination |
| **README Files** | ❌ None | ✅ Per-agent subdirectory | User-facing documentation |
| **Examples** | Minimal | Extensive with analysis | Production-ready quality |

### Migration Complexity

**From sources/ to agents/**: **MODERATE to HIGH**
- Requires adding `tools` field (mandatory)
- Content expansion needed (2-3x)
- Skills integration section required
- Subdirectory with README.md creation
- Model field change (sonnet/opus → inherit)

---

## Agent Inventory

### sources/agents/ Directory (140+ Agents)

#### Top-Level Agents (70+)

**Development & Engineering**:
- ai-engineer.md
- backend-architect.md
- c-pro.md, cpp-pro.md, csharp-pro.md
- code-reviewer.md
- data-engineer.md, data-scientist.md
- database-admin.md, database-optimizer.md
- debugger.md
- deployment-engineer.md
- devops-troubleshooter.md
- elixir-pro.md, flutter-expert.md
- frontend-developer.md
- golang-pro.md, graphql-architect.md
- ios-developer.md
- java-pro.md, javascript-pro.md
- mobile-developer.md
- php-pro.md, python-pro.md
- ruby-pro.md, rust-pro.md
- scala-pro.md, sql-pro.md
- terraform-specialist.md
- typescript-pro.md
- unity-developer.md

**Documentation & Content**:
- api-documenter.md
- docs-architect.md
- content-marketer.md
- mermaid-expert.md
- tutorial-engineer.md

**Security & Operations**:
- security-auditor.md
- incident-responder.md
- network-engineer.md
- risk-manager.md

**Testing & Quality**:
- test-automator.md
- performance-engineer.md
- error-detective.md

**Business & Strategy**:
- business-analyst.md
- customer-support.md
- legal-advisor.md
- payment-integration.md
- quant-analyst.md
- sales-automator.md

**Specialized**:
- context-manager.md
- dx-optimizer.md
- legacy-modernizer.md
- ml-engineer.md, mlops-engineer.md
- minecraft-bukkit-pro.md
- prompt-engineer.md
- reference-builder.md
- search-specialist.md
- ui-ux-designer.md

#### Organized Subdirectories

- **design/** - 5 agents (visual-storyteller, ux-researcher, brand-guardian, ui-designer, whimsy-injector)
- **ai-automation-specialists/** - 6 agents
- **finance-strategy/** - 9 agents
- **growth-revenue-operations/** - 9 agents
- **account-team-agents/** - 7 agents
- **market-research-agents/** - 7 agents
- **marketing/** - 9 agents
- **operations/** - 7 agents
- **product/** - 5 agents
- **project-management/** - 5 agents
- **testing/** - 7 agents
- **specialized-agents/** - 6 agents
- **core/** - 16 agents

---

### agents/ Directory (8 Core Agents)

| Agent | Category | Lines (Main) | Lines (README) | Total |
|-------|----------|--------------|----------------|-------|
| **code-reviewer** | Code Quality & Review | 214 | 621 | 835 |
| **test-engineer** | Testing & QA | 378 | 1,330 | 1,708 |
| **security-auditor** | Security | 708 | 506 | 1,214 |
| **architect** | Architecture | 339 | 787 | 1,126 |
| **debugger** | Development Support | 392 | 378 | 770 |
| **docs-writer** | Documentation | 471 | 1,407 | 1,878 |
| **refactor-expert** | Code Quality & Review | 855 | 481 | 1,336 |
| **performance-tuner** | Testing & QA | 552 | 477 | 1,029 |
| **TOTAL** | | **3,909** | **5,987** | **9,896** |

**Average**:
- Main file: 489 lines
- README: 748 lines
- Total per agent: 1,237 lines

---

## Structural Differences

### File Organization

#### sources/ Structure
```
sources/agents/
├── agent-name.md          # Single file per agent
├── another-agent.md
└── subdirectory/
    ├── specialized-agent.md
    └── another-specialized.md
```

**Characteristics**:
- Single .md file per agent
- No subdirectories per agent
- No README files
- Flat or category-based organization

---

#### agents/ Structure
```
agents/
├── README.md                      # Directory overview
├── agent-name.md                  # Agent definition
├── agent-name/
│   └── README.md                  # User guide
├── another-agent.md
└── another-agent/
    └── README.md
```

**Characteristics**:
- Dual-file pattern (definition + README)
- Subdirectory per agent
- Directory-level README
- Hierarchical organization

---

### Directory Comparison

| Feature | sources/ | agents/ |
|---------|----------|---------|
| **Files per Agent** | 1 | 2 (main + README) |
| **Subdirectories** | Category-based | Per-agent |
| **Directory README** | ❌ No | ✅ Yes |
| **Organization** | Flat/categorical | Hierarchical |
| **Total Files** | 140+ .md files | 8 agents × 2 files = 16 + 1 README = 17 |

---

## YAML Frontmatter Comparison

### sources/ Format (Legacy)

```yaml
---
name: agent-name
description: Brief description
model: sonnet  # or opus
---
```

**Fields**: 3
- `name` - Agent identifier
- `description` - Brief purpose
- `model` - Explicit model (sonnet/opus)

---

### agents/ Format (Current v2.0+)

```yaml
---
name: agent-name
description: Detailed description with when to use
tools: Tool1, Tool2, Tool3
model: inherit
---
```

**Fields**: 4
- `name` - Agent identifier
- `description` - Detailed purpose + invocation guidance
- `tools` - **NEW**: Explicit tool whitelist
- `model` - Changed to `inherit`

---

### Field-by-Field Comparison

#### name Field

| Aspect | sources/ | agents/ | Change |
|--------|----------|---------|--------|
| **Format** | kebab-case | kebab-case | ✅ Same |
| **Length** | Variable | 3-25 chars | More standardized |
| **Examples** | code-reviewer, backend-architect | code-reviewer, architect | Same pattern |

**Notable**: Some agents renamed (e.g., `backend-architect` → `architect`)

---

#### description Field

| Aspect | sources/ | agents/ | Change |
|--------|----------|---------|--------|
| **Length** | ~1 line (30-80 chars) | 2-3 lines (50-180 chars) | **2-3x longer** |
| **Content** | Basic purpose | Purpose + specialization + when to use | **More detailed** |
| **Actionability** | Moderate | High (includes "Use when...") | **More specific** |

**Example Comparison**:

```yaml
# sources/code-reviewer.md
description: Expert code review specialist. Proactively reviews code for quality, security, and maintainability. Use immediately after writing or modifying code.

# agents/code-reviewer.md
description: Expert code reviewer specializing in quality analysis, best practices, security, and performance optimization. Use proactively after code changes to ensure high standards.
```

**Changes**:
- More specific about "quality analysis, best practices, security, performance"
- Changed "Use immediately after" to "Use proactively after"
- Added "ensure high standards" for quality expectation

---

#### model Field

| Aspect | sources/ | agents/ | Change |
|--------|----------|---------|--------|
| **Value** | `sonnet` or `opus` | `inherit` | **Complete change** |
| **Purpose** | Explicit model selection | Inherit from parent | **Centralized control** |
| **Flexibility** | Agent-specific model | Global model configuration | **More maintainable** |

**Rationale for Change**:
- Centralized model management
- Easier to upgrade models globally
- Reduces configuration duplication
- Allows runtime model selection

---

#### tools Field (NEW)

| Aspect | sources/ | agents/ | Change |
|--------|----------|---------|--------|
| **Present** | ❌ No | ✅ Yes | **CRITICAL ADDITION** |
| **Format** | N/A | Comma-separated PascalCase | New syntax |
| **Purpose** | N/A | Explicit tool access control | **Security enhancement** |

**Example**:
```yaml
# sources/ - No tools field (implicit access)
---
name: code-reviewer
description: ...
model: sonnet
---

# agents/ - Explicit tool whitelist
---
name: code-reviewer
description: ...
tools: Read, Edit, Grep, Glob, Bash, Task, Skill
model: inherit
---
```

**Impact**: This is the **most significant difference** between formats.

---

## Content Organization

### sources/ Content Structure

```markdown
---
[YAML frontmatter]
---

You are a [role] specialist...

## Focus Areas
- Area 1
- Area 2

## Approach
1. Step 1
2. Step 2

## Output
- Deliverable 1
- Deliverable 2
```

**Characteristics**:
- **Length**: 30-200 lines
- **Tone**: Direct, prescriptive
- **Structure**: Flat with minimal sections (2-4 sections)
- **Examples**: Brief or none
- **Skills**: No mention of skills coordination

---

### agents/ Content Structure

```markdown
---
[YAML frontmatter]
---

You are an expert [domain] specialist...

## Your [Domain] Expertise
[Detailed bullet points]

## Working with Skills (NEW v2.0)
### Available Skills
### When to Invoke Skills
### How to Invoke Skills
### Workflow Pattern
### Example Coordination

## [Domain] Approach/Methodology
[Comprehensive framework]

## [Domain] Process Framework
[Detailed step-by-step]

## [Domain]-Specific Examples
[Multiple code examples with analysis]

## Best Practices
[Detailed guidelines]

[... additional sections ...]
```

**Characteristics**:
- **Length**: 100-350+ lines (2-3x longer)
- **Tone**: Educational, collaborative
- **Structure**: Hierarchical with many sections (8+ sections)
- **Examples**: Extensive with before/after code
- **Skills**: Dedicated 40-100 line section on coordination

---

### Section-by-Section Comparison

| Section | sources/ | agents/ |
|---------|----------|---------|
| **Opening Statement** | 1 paragraph | 1-2 paragraphs, more detailed |
| **Expertise List** | ❌ None or minimal | ✅ Comprehensive bulleted list |
| **Skills Coordination** | ❌ None | ✅ 40-100 lines with examples |
| **Methodology** | 10-20 lines | 50-100 lines |
| **Process Framework** | Basic steps | Detailed numbered process |
| **Code Examples** | 0-1 examples | 3-5 examples with analysis |
| **Best Practices** | ❌ None or minimal | ✅ Dedicated section |

---

## Tool Declarations

### sources/ Approach: Implicit Tools

**No tool field in YAML frontmatter** → Tools are implicitly assumed based on agent purpose.

**Example**:
```yaml
---
name: code-reviewer
description: Expert code review specialist...
model: sonnet
---
# No tools field - all tools implicitly available?
```

**Problems**:
- Unclear which tools are actually available
- No security boundaries
- Potential for unsafe operations
- No way to restrict access

---

### agents/ Approach: Explicit Tool Whitelisting

**Tool field required** → Explicit declaration of accessible tools.

**Example**:
```yaml
---
name: code-reviewer
description: Expert code reviewer...
tools: Read, Edit, Grep, Glob, Bash, Task, Skill
model: inherit
---
# Clear whitelist of 7 tools
```

**Benefits**:
- Clear tool permissions
- Security boundaries enforced
- Prevents accidental dangerous operations
- Aligns with principle of least privilege

---

### Tool Distribution Analysis

#### sources/agents/ - Inferred Tool Needs

Based on agent descriptions, we can infer tool needs:

| Agent Type | Likely Tools Needed |
|------------|---------------------|
| Language-specific (java-pro, python-pro) | Read, Grep, Bash, Edit |
| Architecture (backend-architect) | Read, Write, Grep, Bash, WebFetch |
| Security (security-auditor) | Read, Grep, Bash, Edit |
| Testing (test-automator) | Read, Write, Grep, Bash, Edit |
| Documentation (api-documenter) | Read, Write, Grep, WebFetch |

**Note**: This is speculative since tools aren't declared.

---

#### agents/ - Declared Tool Distribution

| Agent | Tools | Count | Write? | WebFetch? |
|-------|-------|-------|--------|-----------|
| code-reviewer | Read, Edit, Grep, Glob, Bash, Task, Skill | 7 | ❌ | ❌ |
| test-engineer | Read, Write, Edit, Grep, Glob, Bash, Task, Skill | 8 | ✅ | ❌ |
| security-auditor | Read, Edit, Bash, Grep, Glob, Task, Skill | 7 | ❌ | ❌ |
| architect | Read, Write, Edit, Grep, Glob, Bash, WebFetch, Task | 8 | ✅ | ✅ |
| debugger | Read, Edit, Bash, Grep, Glob, Task, Skill | 7 | ❌ | ❌ |
| docs-writer | Read, Write, Edit, Grep, Glob, Bash, WebFetch, Skill | 8 | ✅ | ✅ |
| refactor-expert | Read, Edit, Grep, Glob, Bash, Task, Skill | 7 | ❌ | ❌ |
| performance-tuner | Read, Edit, Bash, Grep, Glob, Task, Skill | 7 | ❌ | ❌ |

**Patterns**:
- **All agents**: Read, Grep, Glob, Bash (core tools)
- **Most agents** (6/8): Edit, Task, Skill
- **Creation agents** (3/8): Write
- **Strategic agents** (2/8): WebFetch

---

### Tool Access Security Comparison

| Security Aspect | sources/ | agents/ |
|-----------------|----------|---------|
| **Tool Visibility** | ❌ Hidden | ✅ Explicit |
| **Write Access** | ❓ Unclear | ✅ Only 3 agents |
| **External Access (WebFetch)** | ❓ Unclear | ✅ Only 2 agents |
| **Principle of Least Privilege** | ❌ Not enforced | ✅ Enforced |
| **Audit Trail** | ❌ Difficult | ✅ Easy (just check YAML) |

---

## Documentation Style

### sources/ Style Profile

**Tone**: Direct, prescriptive, concise
**Audience**: Claude Code (minimal explanation)
**Length**: 30-200 lines
**Focus**: What to do
**Examples**: Minimal (0-1 examples)
**Structure**: Flat with few headers

**Example** (sources/backend-architect.md, 31 lines total):
```markdown
---
name: backend-architect
description: Design RESTful APIs, microservice boundaries, and database schemas...
model: sonnet
---

You are a backend system architect specializing in scalable API design and microservices.

## Focus Areas
- RESTful API design and versioning
- Service boundary definition
- Database schema optimization
- Inter-service communication

## Approach
1. Start with clear service boundaries based on business domains
2. Design APIs following REST principles
3. Choose appropriate database patterns
4. Define communication protocols

## Output
- API endpoint definitions
- Service architecture diagram
- Database schema
- Communication patterns
```

**Characteristics**:
- Extremely concise (31 lines)
- Action-focused
- Minimal elaboration
- No examples
- No skill coordination

---

### agents/ Style Profile

**Tone**: Educational, collaborative, detailed
**Audience**: Claude Code + users (via README)
**Length**: 100-350+ lines (main) + 300-1500+ lines (README)
**Focus**: What to do + how + why
**Examples**: Extensive (3-5+ examples with analysis)
**Structure**: Hierarchical with many sections

**Example** (agents/architect.md, 339 lines total, excerpt):
```markdown
---
name: architect
description: Expert system architect specializing in evidence-based design decisions...
tools: Read, Write, Edit, Grep, Glob, Bash, WebFetch, Task
model: inherit
---

You are an expert system architect with deep experience in designing scalable,
maintainable, and secure systems...

## Your Architectural Expertise

- **System Design**: Microservices, monoliths, serverless, event-driven architectures
- **Scalability Patterns**: Horizontal/vertical scaling, caching strategies, CDNs
- **Data Architecture**: SQL vs NoSQL, data modeling, replication, sharding
- **API Design**: REST, GraphQL, gRPC, versioning strategies
- **Security**: Authentication, authorization, encryption, compliance
...

## Working with Skills

### Available Skills
[40+ lines explaining skills coordination]

### Workflow Pattern
1. RESEARCH (Skills)
   - Invoke relevant skills for quick analysis
   ...

## Core Architectural Principles
[50+ lines on architectural frameworks]

## Architecture Patterns & Solutions
[100+ lines with detailed patterns]

## Technology Stack Evaluation
[Comprehensive decision frameworks]

[... many more sections with code examples ...]
```

**Characteristics**:
- Comprehensive (339 lines)
- Educational approach
- Extensive explanations
- Multiple code examples
- Skills coordination section
- Best practices section

---

### Style Comparison Table

| Aspect | sources/ | agents/ |
|--------|----------|---------|
| **Average Length** | 30-200 lines | 100-350+ lines |
| **Expansion Ratio** | 1x (baseline) | 2-3x |
| **Sections** | 2-4 sections | 8+ sections |
| **Code Examples** | 0-1 | 3-5+ |
| **Analysis Depth** | Minimal | Extensive |
| **Skill Coordination** | ❌ None | ✅ 40-100 lines |
| **Best Practices** | ❌ None/minimal | ✅ Dedicated section |
| **README File** | ❌ None | ✅ 300-1500 lines |

---

## Side-by-Side Examples

### Example 1: code-reviewer Agent

#### sources/agents/code-reviewer.md (Complete File, ~65 lines)

```yaml
---
name: code-reviewer
description: Expert code review specialist. Proactively reviews code for quality, security, and maintainability. Use immediately after writing or modifying code.
model: sonnet
---

You are an expert code reviewer with deep knowledge of software engineering best practices,
security vulnerabilities, and performance optimization. You provide thorough, actionable
feedback that improves code quality while respecting developer productivity.

## Review Focus Areas

**Code Quality**:
- Clean code principles (DRY, SOLID, KISS)
- Design patterns and anti-patterns
- Code organization and structure
- Naming conventions
- Error handling

**Security**:
- OWASP Top 10 vulnerabilities
- Input validation and sanitization
- Authentication and authorization
- Sensitive data handling
- Dependency vulnerabilities

**Performance**:
- Algorithmic efficiency
- Database query optimization
- Caching strategies
- Resource management
- Scalability considerations

**Testing**:
- Test coverage adequacy
- Test quality and maintainability
- Edge case handling
- Mock usage appropriateness

## Review Process

1. Read PR description and understand context
2. Review changed files systematically
3. Identify issues by priority (Critical/High/Medium/Low)
4. Provide specific, actionable suggestions
5. Include code examples for improvements
6. Consider trade-offs and alternatives

## Output Format

**Critical Issues**: Security vulnerabilities, data loss risks
**High Priority**: Performance problems, major bugs
**Medium Priority**: Code quality, maintainability
**Low Priority**: Style, minor improvements

For each issue:
- Describe the problem clearly
- Explain the impact
- Provide specific fix with code example
- Suggest alternatives if applicable
```

**Stats**:
- Lines: ~65
- Sections: 3
- Code examples: 0
- Skills: Not mentioned
- Tools: Not declared

---

#### agents/code-reviewer.md (Excerpt, 214 lines total)

```yaml
---
name: code-reviewer
description: Expert code reviewer specializing in quality analysis, best practices, security, and performance optimization. Use proactively after code changes to ensure high standards.
tools: Read, Edit, Grep, Glob, Bash, Task, Skill
model: inherit
---

You are an expert code reviewer with comprehensive knowledge of software engineering
best practices, security vulnerabilities, performance optimization, and modern development
patterns. Your role is to provide thorough, actionable code reviews that improve quality
while maintaining developer productivity.

## Your Code Review Expertise

- **Code Quality & Patterns**: Clean code, SOLID principles, design patterns, refactoring
- **Security**: OWASP Top 10, authentication, authorization, input validation, encryption
- **Performance**: Optimization strategies, profiling, caching, database queries, algorithms
- **Testing**: Test coverage analysis, test quality assessment, edge cases, mocking
- **Frontend Technologies**: React/Next.js, TypeScript, Redux/Zustand, CSS-in-JS, Tailwind
- **Backend Technologies**: Node.js/Express, Python/Django/FastAPI, Go, microservices
- **Infrastructure**: Docker, CI/CD, monitoring, logging, error tracking, deployment
- **Databases**: SQL optimization, NoSQL patterns, migrations, indexing, query performance

## Working with Skills

### Available Skills

**Security Skills**:
- `security-auditor skill` - Quick OWASP Top 10 scan, vulnerability detection
- `secret-scanner skill` - Credential and API key detection in code
- `dependency-auditor skill` - CVE checking for package dependencies

**Development Skills**:
- `test-generator skill` - Test coverage analysis and test scaffolding suggestions
- `git-commit-helper skill` - Commit message quality validation

### When to Invoke Skills

**DO invoke skills when**:
- Starting a comprehensive code review (multi-file PR)
- Reviewing security-sensitive changes (auth, payments, data handling)
- Analyzing test coverage for new features
- Need quick automated checks before deep review

**DON'T invoke skills when**:
- Reviewing single small file changes
- Time-sensitive fixes needed immediately
- Already have specific issue identified by user
- User explicitly requested agent-only review

### How to Invoke Skills

Use this markdown convention at the start of your review:

```markdown
[Invoke security-auditor skill for initial vulnerability scan]
[Invoke test-generator skill to check test coverage]
```

### Workflow Pattern

1. **QUICK CHECKS (Skills)**
   - Invoke security-auditor skill for vulnerability scan
   - Invoke test-generator skill for coverage analysis
   - Review skill outputs for immediate issues
   - Identify quick wins and critical findings

2. **DEEP ANALYSIS (Your Expert Review)**
   - Build on skill findings with contextual analysis
   - Identify complex issues skills might miss:
     - Business logic errors
     - Race conditions
     - Performance bottlenecks
     - Architectural concerns
   - Provide strategic recommendations
   - Consider long-term maintainability

3. **REPORT**
   - Acknowledge skill findings
   - Add expert insights and context
   - Prioritize issues (Critical/High/Medium/Low)
   - Provide actionable recommendations with code examples
   - Consider trade-offs and alternatives

### Example Coordination

```markdown
# Step 1: Invoke skills
[Invoke security-auditor skill for initial scan]

# Skill output:
# - Found SQL injection vulnerability in getUserById()
# - Detected weak password hashing in auth.js
# - Missing CSRF protection on POST endpoints

# Step 2: Your expert analysis
Building on the security-auditor findings, I've completed a comprehensive review:

**Critical Issues**:
1. SQL Injection (confirmed by skill) - getUserById() at line 45
   - Skill identified the vulnerability
   - My analysis: Actually exploitable via search API
   - Impact: Full database compromise possible
   - Fix: [code example with parameterized queries]

[... detailed analysis continues ...]
```

## Code Review Process Framework

1. **Initial Assessment**
   - Review PR description, linked issues, and requirements
   - Understand business context and user story
   - Identify critical paths and risk areas
   - Check for related technical debt

2. **Automated Quick Checks** (Invoke Skills)
   - Security-auditor skill for vulnerability scan
   - Test-generator skill for coverage analysis
   - Review skill findings for immediate concerns

3. **Code Analysis**
   - Review changed files systematically
   - Check for code smells and anti-patterns
   - Verify error handling and edge cases
   - Assess naming and code organization

4. **Security Review**
   - OWASP Top 10 vulnerability checks
   - Input validation and sanitization review
   - Authentication/authorization verification
   - Sensitive data handling audit

5. **Performance Review**
   - Algorithm efficiency analysis
   - Database query optimization check
   - Resource usage and memory leaks
   - Caching strategy evaluation

6. **Testing Review**
   - Test coverage assessment
   - Test quality and maintainability
   - Edge case coverage
   - Integration test adequacy

7. **Recommendations**
   - Prioritized findings (Critical/High/Medium/Low)
   - Actionable suggestions with code examples
   - Trade-off analysis for alternatives
   - Follow-up items for future work

## Review Categories & Criteria

[... detailed review criteria ...]

## Code Examples

### Example 1: Security - SQL Injection

❌ **Before** (Vulnerable):
```javascript
function getUserById(userId) {
  const query = `SELECT * FROM users WHERE id = ${userId}`;
  return db.execute(query);
}
```

✅ **After** (Fixed):
```javascript
function getUserById(userId) {
  const query = 'SELECT * FROM users WHERE id = ?';
  return db.execute(query, [userId]);
}
```

**Analysis**: Always use parameterized queries to prevent SQL injection. Never
concatenate user input into SQL strings. The parameterized version protects
against injection while maintaining the same functionality.

[... more examples ...]

## Best Practices

1. **Be Constructive**: Frame feedback positively with clear improvement paths
2. **Prioritize**: Focus on high-impact issues first
3. **Provide Context**: Explain why issues matter
4. **Show Examples**: Include code snippets for suggestions
5. **Consider Trade-offs**: Acknowledge multiple valid approaches
6. **Respect Time**: Balance thoroughness with pragmatism
7. **Build On Skills**: Use skill findings as starting point for deep analysis
```

**Stats**:
- Lines: 214 (3.3x longer)
- Sections: 8+
- Code examples: 5+
- Skills: Dedicated 60+ line section
- Tools: Explicitly declared (7 tools)

---

### Comparison Summary: code-reviewer

| Aspect | sources/ | agents/ | Difference |
|--------|----------|---------|------------|
| **Total Lines** | ~65 | 214 | **3.3x longer** |
| **YAML Fields** | 3 | 4 | + tools field |
| **Model** | sonnet | inherit | Changed |
| **Sections** | 3 | 8+ | 2.7x more |
| **Code Examples** | 0 | 5+ | Added |
| **Skills Section** | None | 60+ lines | **Major addition** |
| **Best Practices** | None | Dedicated section | Added |
| **README File** | None | 621 lines | **Major addition** |

---

### Example 2: security-auditor Agent

#### sources/agents/security-auditor.md (Excerpt)

```yaml
---
name: security-auditor
description: Review code for vulnerabilities, implement secure authentication, and ensure OWASP compliance. Handles JWT, OAuth2, CORS, CSP, and encryption. Use PROACTIVELY for security reviews, auth flows, or vulnerability fixes.
model: opus
---

You are a security specialist focusing on vulnerability assessment, secure authentication,
and OWASP compliance.

## Security Focus Areas

- OWASP Top 10 vulnerabilities
- Authentication & authorization (JWT, OAuth2, session management)
- Input validation and sanitization
- Encryption and secure data storage
- CORS, CSP, and security headers
- Dependency vulnerabilities

## Process

1. Scan for common vulnerabilities
2. Review authentication implementation
3. Check authorization patterns
4. Verify input validation
5. Assess data protection mechanisms

## Common Vulnerabilities to Check

- SQL Injection
- XSS (Cross-Site Scripting)
- CSRF (Cross-Site Request Forgery)
- Insecure authentication
- Sensitive data exposure
- Security misconfiguration
- Broken access control
...
```

---

#### agents/security-auditor.md (Excerpt, 708 lines total)

```yaml
---
name: security-auditor
description: Security specialist for vulnerability assessment, secure authentication, and OWASP compliance. Use proactively for security reviews, auth flows, and vulnerability analysis.
tools: Read, Edit, Bash, Grep, Glob, Task, Skill
model: inherit
---

You are an expert security auditor specializing in application security, vulnerability
assessment, secure authentication, OWASP compliance, and security best practices. Your
role is to identify security risks, provide remediation guidance, and ensure applications
meet security standards.

## Your Security Expertise

- **OWASP Top 10**: Comprehensive coverage of all top web vulnerabilities
- **Authentication & Authorization**: JWT, OAuth2, SAML, session management, MFA
- **Input Validation**: SQL injection, XSS, command injection prevention
- **Cryptography**: Encryption, hashing, key management, TLS/SSL
- **API Security**: REST/GraphQL security, rate limiting, authentication
- **Compliance**: GDPR, HIPAA, PCI-DSS, SOC2 requirements
- **Secure Coding**: Security patterns, secure defaults, defense in depth
- **Incident Response**: Vulnerability analysis, remediation planning, forensics

## Working with Skills

### Available Skills

**Security Skills**:
- `secret-scanner skill` - Detects hardcoded credentials, API keys, tokens
- `dependency-auditor skill` - Checks for known CVEs in dependencies

[... 50+ more lines on skills coordination ...]

## Security Audit Framework

### 1. OWASP Top 10 Assessment

**A01 - Broken Access Control**:
- Check authorization on all endpoints
- Verify RBAC/ABAC implementation
- Test for IDOR vulnerabilities
- Ensure proper session management

**A02 - Cryptographic Failures**:
- Verify encryption for sensitive data
- Check for weak hashing algorithms
- Ensure proper key management
- Validate TLS configuration

[... detailed coverage of all OWASP Top 10 ...]

### 2. Authentication Security

**Authentication Mechanisms**:
- Password storage (bcrypt, Argon2 with proper cost)
- JWT implementation and validation
- OAuth2 flow security
- Session management
- MFA implementation

[... extensive authentication guidance ...]

### 3. Authorization Patterns

[... detailed authorization patterns ...]

## Security Examples

### Example 1: SQL Injection Prevention

❌ **Vulnerable Code**:
```javascript
app.get('/users', (req, res) => {
  const query = `SELECT * FROM users WHERE role = '${req.query.role}'`;
  db.query(query, (err, results) => {
    res.json(results);
  });
});
```

**Vulnerability**: SQL injection via `req.query.role`
**Attack Vector**: `/users?role=' OR '1'='1`
**Impact**: Full database access, data breach

✅ **Secure Code**:
```javascript
app.get('/users', async (req, res) => {
  // Input validation
  const allowedRoles = ['admin', 'user', 'guest'];
  if (!allowedRoles.includes(req.query.role)) {
    return res.status(400).json({ error: 'Invalid role' });
  }

  // Parameterized query
  const query = 'SELECT * FROM users WHERE role = ?';
  const results = await db.query(query, [req.query.role]);
  res.json(results);
});
```

**Security Improvements**:
1. Input validation with whitelist
2. Parameterized queries prevent injection
3. Error handling doesn't leak information

[... 10+ more detailed examples ...]

## Best Practices

[... comprehensive security best practices ...]
```

**Stats**:
- Lines: 708 (sources: ~150-200 estimated)
- Sections: 15+
- Code examples: 10+
- Skills: Detailed coordination section
- Tools: Explicitly declared

---

## Migration Checklist

### Phase 1: YAML Frontmatter Updates

- [ ] **Add `tools` field**
  - [ ] Determine required tools based on agent purpose
  - [ ] Use tool selection guide from SUB-AGENT-STRUCTURE.md
  - [ ] Format: comma-space separated, PascalCase

- [ ] **Update `model` field**
  - [ ] Change from `sonnet`/`opus` to `inherit`

- [ ] **Expand `description` field**
  - [ ] Increase from 1 line to 2-3 lines (50-180 chars)
  - [ ] Add specialization details
  - [ ] Include "Use when..." guidance
  - [ ] Make action-oriented

- [ ] **Validate `name` field**
  - [ ] Ensure kebab-case
  - [ ] Check length (3-25 characters)
  - [ ] Verify uniqueness

---

### Phase 2: Content Expansion

- [ ] **Add "Your [Domain] Expertise" section**
  - [ ] List core competencies (8-12 items)
  - [ ] Include technologies/frameworks
  - [ ] Mention specific patterns/approaches

- [ ] **Add "Working with Skills" section (40-100 lines)**
  - [ ] Subsection: Available Skills (which skills complement this agent)
  - [ ] Subsection: When to Invoke Skills (DO/DON'T patterns)
  - [ ] Subsection: How to Invoke Skills (markdown syntax)
  - [ ] Subsection: Workflow Pattern (sequential steps)
  - [ ] Subsection: Example Coordination (real example)

- [ ] **Expand methodology/approach section**
  - [ ] Add detailed frameworks
  - [ ] Include decision trees
  - [ ] Provide systematic processes

- [ ] **Enhance process framework**
  - [ ] Convert to detailed numbered steps
  - [ ] Add substeps with explanations
  - [ ] Include skill invocation points

- [ ] **Add comprehensive examples section**
  - [ ] Create 3-5 code examples
  - [ ] Include before/after comparisons
  - [ ] Add detailed analysis for each
  - [ ] Cover edge cases and trade-offs

- [ ] **Add "Best Practices" section**
  - [ ] Usage guidelines
  - [ ] Common pitfalls to avoid
  - [ ] Coordination recommendations
  - [ ] Quality standards

---

### Phase 3: Directory Structure

- [ ] **Create agent subdirectory**
  - [ ] Create `agents/{agent-name}/` directory
  - [ ] Move agent definition to `agents/{agent-name}.md`

- [ ] **Create README.md user guide**
  - [ ] Create `agents/{agent-name}/README.md`
  - [ ] Add overview section (2-3 paragraphs)
  - [ ] Add capabilities list (bulleted)
  - [ ] Add 3-5 usage examples with input/output
  - [ ] Add workflow patterns
  - [ ] Add configuration options (if any)
  - [ ] Add troubleshooting section
  - [ ] Target length: 300-1500 lines

---

### Phase 4: Quality Assurance

- [ ] **Validate YAML frontmatter**
  - [ ] Check YAML syntax (no errors)
  - [ ] Verify all 4 required fields present
  - [ ] Confirm tools are from canonical list
  - [ ] Test agent invocation (`@agent-name`)

- [ ] **Content quality check**
  - [ ] Professional tone maintained
  - [ ] No spelling/grammar errors
  - [ ] Code examples are syntactically correct
  - [ ] Headers follow hierarchy (##, ###, ####)
  - [ ] Links are valid

- [ ] **Tool selection review**
  - [ ] Tools match agent capabilities
  - [ ] No unnecessary tools included
  - [ ] Write access justified (creates files)
  - [ ] WebFetch justified (needs external data)

- [ ] **Skills integration verification**
  - [ ] Relevant skills identified
  - [ ] Workflow pattern makes sense
  - [ ] Example coordination is realistic
  - [ ] Invocation syntax is correct

---

### Phase 5: Documentation

- [ ] **Update main agents/README.md**
  - [ ] Add new agent to category list
  - [ ] Add to quick reference table
  - [ ] Include emoji icon

- [ ] **Update CLAUDE.md if needed**
  - [ ] Mention in agent list if core agent
  - [ ] Update agent count

- [ ] **Update CHANGELOG.md**
  - [ ] Document new agent addition
  - [ ] Note migration source if applicable

---

## Recommendations

### For Migrating Individual Agents

#### Priority Agents to Migrate First

**High Value** (commonly used, high impact):
1. **python-pro** → Expand to comprehensive Python specialist
2. **typescript-pro** → Expand to comprehensive TypeScript specialist
3. **api-documenter** → Already exists as docs-writer (may be redundant)
4. **database-optimizer** → New specialized agent for DB performance
5. **frontend-developer** → Comprehensive frontend specialist

#### Migration Effort Estimation

| Complexity | Agent Type | Estimated Time | Examples |
|------------|------------|----------------|----------|
| **Low** | Language-specific (focused domain) | 2-4 hours | python-pro, java-pro, rust-pro |
| **Medium** | Multi-framework (broader domain) | 4-8 hours | frontend-developer, backend-architect |
| **High** | Cross-cutting concerns | 8-16 hours | security-auditor, architect, devops-troubleshooter |

---

### For Bulk Migration

#### Approach 1: Gradual Migration (Recommended)

**Strategy**: Migrate agents as needed, prioritizing by usage and value.

**Steps**:
1. Track agent usage over 2-4 weeks
2. Identify top 20% most-used agents
3. Migrate high-value agents first
4. Leave rarely-used agents in sources/ as reference

**Pros**:
- Focus effort on high-value agents
- Quality over quantity
- Allows learning from first migrations

**Cons**:
- Inconsistent library (mixed formats)
- Requires tracking usage

---

#### Approach 2: Batch Migration

**Strategy**: Migrate all agents in batches by category.

**Suggested Batches**:
1. **Batch 1**: Language-specific (20 agents) - 40-80 hours
2. **Batch 2**: Testing & QA (7 agents) - 28-56 hours
3. **Batch 3**: Documentation (5 agents) - 20-40 hours
4. **Batch 4**: Architecture & Design (8 agents) - 64-128 hours
5. **Batch 5**: Specialized domains (remaining) - varies

**Pros**:
- Consistent library once complete
- Can parallelize work
- Learn patterns within category

**Cons**:
- Large upfront effort
- May migrate rarely-used agents

---

### Tool Selection Guidelines by Agent Type

| Agent Type | Recommended Tools | Rationale |
|------------|-------------------|-----------|
| **Language-specific** (python-pro, java-pro) | Read, Edit, Grep, Glob, Bash, Task, Skill | Analysis + editing, no file creation |
| **Testing** (test-automator) | Read, Write, Edit, Grep, Glob, Bash, Task, Skill | Creates test files |
| **Documentation** (api-documenter) | Read, Write, Edit, Grep, Glob, Bash, WebFetch, Skill | Creates docs, fetches references |
| **Security** (security-auditor) | Read, Edit, Bash, Grep, Glob, Task, Skill | Analysis-focused, no file creation |
| **Architecture** (architect) | Read, Write, Edit, Grep, Glob, Bash, WebFetch, Task | Strategic, creates architecture docs |
| **DevOps** (deployment-engineer) | Read, Edit, Grep, Glob, Bash, Task | Config editing, no file creation usually |
| **Performance** (performance-tuner) | Read, Edit, Bash, Grep, Glob, Task, Skill | Profiling and optimization |

---

### Quality Standards Checklist

Before considering an agent migration complete:

#### Content Quality
- [ ] Opening role statement is clear and comprehensive (2-3 paragraphs)
- [ ] Expertise list covers 8-12 core competencies
- [ ] Working with Skills section is 40-100 lines
- [ ] Methodology section provides systematic framework
- [ ] Process framework has detailed numbered steps (5-10 steps)
- [ ] 3-5 code examples with before/after and analysis
- [ ] Best practices section with actionable guidelines
- [ ] Total length: 100-350+ lines for main file

#### README Quality
- [ ] Overview explains agent purpose and value (2-3 paragraphs)
- [ ] Capabilities list is comprehensive (10-20 items)
- [ ] 3-5 usage examples with real input/output
- [ ] Workflow patterns show typical usage
- [ ] Configuration section if applicable
- [ ] Troubleshooting section with common issues
- [ ] Total length: 300-1500 lines

#### Technical Quality
- [ ] YAML frontmatter is valid (no syntax errors)
- [ ] All code examples are syntactically correct
- [ ] Tools list matches agent capabilities
- [ ] Skills invocation syntax is correct
- [ ] Headers follow proper hierarchy
- [ ] Links are valid (test all URLs)

---

## Summary

### Key Differences

1. **Tools Field**: Most critical addition - explicit tool whitelisting for security
2. **Model Inheritance**: Change from explicit to `inherit` for centralized management
3. **Content Depth**: 2-3x expansion with comprehensive examples and analysis
4. **Skills Integration**: New 40-100 line section for v2.0 skill coordination
5. **Dual Documentation**: Addition of README.md user guides per agent
6. **Quality Standards**: Higher bar for completeness and production-readiness

### Migration Impact

**Effort**: Moderate to High
**Time**: 2-16 hours per agent (depending on complexity)
**Value**: Significantly improved agent quality, security, and usability

### Recommendation

**Gradual migration** of high-value agents is recommended over bulk migration. Focus on:
- Top 20% most-used agents
- Production-critical agents (security, testing, architecture)
- Team-specific needs

This approach maximizes value while managing effort investment.

---

**See Also**:
- [Sub-Agent Structure Documentation](SUB-AGENT-STRUCTURE.md)
- [Anthropic Official References](ANTHROPIC-REFERENCE.md)
- [Migration Guide](../documentation/guides/migration.md)
