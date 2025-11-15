# Claude Code Sub-Agent Structure Documentation

> **Official specification for creating custom sub-agents in Claude Code Tresor**
>
> **Last Updated**: November 15, 2025 | **Version**: 2.5.0

---

## Table of Contents

1. [Overview](#overview)
2. [YAML Frontmatter Schema](#yaml-frontmatter-schema)
3. [Required Fields](#required-fields)
4. [Tool Configuration](#tool-configuration)
5. [Content Structure](#content-structure)
6. [Directory Organization](#directory-organization)
7. [Invocation Mechanisms](#invocation-mechanisms)
8. [Best Practices](#best-practices)
9. [Examples](#examples)
10. [Validation Checklist](#validation-checklist)

---

## Overview

Claude Code sub-agents are specialized AI assistants defined as Markdown files with YAML frontmatter. They enable task-specific problem-solving with:

- **Customized system prompts** - Tailored expertise and behavior
- **Tool access control** - Granular permissions for safety
- **Separate context windows** - Isolated execution environments
- **Skill coordination** - Integration with autonomous background helpers

### Key Benefits

- **Specialization**: Each agent focuses on specific domain expertise
- **Safety**: Tool access restricted to necessary capabilities
- **Efficiency**: Separate contexts prevent context pollution
- **Coordination**: Agents work with skills for comprehensive analysis

---

## YAML Frontmatter Schema

Every sub-agent file **must** start with YAML frontmatter enclosed in `---` delimiters:

```yaml
---
name: agent-identifier
description: Brief description of agent purpose and when to use it
tools: Tool1, Tool2, Tool3
model: inherit
---
```

### Schema Specification

```yaml
---
# REQUIRED FIELDS (4 total)
name: <kebab-case-identifier>              # Agent invocation name
description: <one-line-description>        # Brief agent capability summary
tools: <comma-separated-tool-list>         # Tool access permissions
model: inherit                             # Model inheritance (fixed value)
---
```

---

## Required Fields

### 1. `name` (REQUIRED)

**Type**: `string`
**Format**: kebab-case (lowercase with hyphens)
**Length**: 3-25 characters
**Pattern**: `^[a-z][a-z0-9-]*$`

**Purpose**: Unique identifier for agent invocation using `@agent-name` syntax.

**Examples**:
- ✅ `code-reviewer`
- ✅ `test-engineer`
- ✅ `security-auditor`
- ✅ `performance-tuner`
- ❌ `CodeReviewer` (not lowercase)
- ❌ `code_reviewer` (underscores not allowed)
- ❌ `cr` (too short, not descriptive)

**Validation Rules**:
- Must start with lowercase letter
- Only lowercase letters, numbers, and hyphens
- No consecutive hyphens
- No trailing/leading hyphens
- Should be descriptive and self-explanatory

---

### 2. `description` (REQUIRED)

**Type**: `string`
**Length**: 50-180 characters
**Format**: Plain text, single sentence

**Purpose**: Brief description used by Claude Code to intelligently select appropriate agents based on task context.

**Guidelines**:
- Be specific and action-oriented
- Include domain specialization
- Mention when to invoke proactively
- Avoid vague terms like "helper" or "assistant"

**Examples**:

✅ **Good descriptions**:
```yaml
description: Expert code reviewer specializing in quality analysis, best practices, security, and performance optimization. Use proactively after code changes to ensure high standards.

description: Security specialist for vulnerability assessment, secure authentication, and OWASP compliance. Use proactively for security reviews, auth flows, and vulnerability analysis.

description: Expert system architect specializing in evidence-based design decisions, scalable system patterns, and long-term technical strategy. Use proactively for architectural reviews and system design.
```

❌ **Poor descriptions**:
```yaml
description: Reviews code  # Too brief, not specific

description: A helpful assistant that can help you with various coding tasks and provide suggestions  # Too vague, no specialization

description: Use this when you need help  # Not descriptive
```

---

### 3. `tools` (REQUIRED)

**Type**: `string` (comma-separated list)
**Format**: PascalCase tool names, comma-space separated
**Validation**: Each tool must be from the canonical tool list

**Purpose**: Explicitly declares which tools the agent has access to. This provides security and safety controls.

**Available Tools**:

| Tool | Purpose | Risk Level | Common Usage |
|------|---------|------------|--------------|
| **Read** | Read file contents | Safe | All agents |
| **Write** | Create new files | Moderate | Creation agents only |
| **Edit** | Modify existing files | Moderate | Most agents |
| **Grep** | Search file contents | Safe | All agents |
| **Glob** | File pattern matching | Safe | All agents |
| **Bash** | Execute shell commands | High | All agents (for git, etc.) |
| **Task** | Coordinate with other agents/skills | Moderate | Most agents |
| **Skill** | Invoke autonomous background helpers | Moderate | Most agents |
| **WebFetch** | Fetch remote URLs | Moderate | Strategic agents only |

**Tool Selection Strategy**:

```yaml
# Minimal read-only agent
tools: Read, Grep, Glob, Bash

# Standard analysis agent (most common)
tools: Read, Edit, Grep, Glob, Bash, Task, Skill

# Creation agent (documentation, tests)
tools: Read, Write, Edit, Grep, Glob, Bash, Task, Skill

# Strategic agent (architecture, research)
tools: Read, Write, Edit, Grep, Glob, Bash, WebFetch, Task
```

**Tool Distribution Patterns**:

```
Core Tools (all agents):     Read, Grep, Glob, Bash
Analysis Agents (6/8):       + Edit, Task, Skill
Creation Agents (3/8):       + Write
Strategic Agents (2/8):      + WebFetch
```

**Examples**:

```yaml
# Code reviewer (no file creation)
tools: Read, Edit, Grep, Glob, Bash, Task, Skill

# Test engineer (creates test files)
tools: Read, Write, Edit, Grep, Glob, Bash, Task, Skill

# Architect (strategic with web research)
tools: Read, Write, Edit, Grep, Glob, Bash, WebFetch, Task

# Documentation writer (creates docs, fetches references)
tools: Read, Write, Edit, Grep, Glob, Bash, WebFetch, Skill
```

**Important**: Tool names are case-sensitive and must match exactly.

---

### 4. `model` (REQUIRED)

**Type**: `string`
**Allowed Value**: `inherit` (only)
**Purpose**: Indicates the agent inherits the model from the parent context

**Historical Note**: Earlier versions used explicit model names like `sonnet` or `opus`. The current standard is `inherit` to allow centralized model management.

```yaml
# Current standard (v2.0+)
model: inherit

# Legacy format (sources/ directory, deprecated)
model: sonnet  # Don't use
model: opus    # Don't use
```

---

## Tool Configuration

### Tool Access Patterns by Agent Type

#### Analysis-Only Agents
**Purpose**: Review, audit, recommend (no file creation)
**Tools**: `Read, Edit, Grep, Glob, Bash, Task, Skill`

**Examples**:
- code-reviewer
- security-auditor
- debugger
- refactor-expert
- performance-tuner

**Rationale**: These agents provide expert analysis and suggestions but don't create new files. Users decide on implementation.

---

#### Creation Agents
**Purpose**: Generate new files (tests, documentation, configurations)
**Tools**: `Read, Write, Edit, Grep, Glob, Bash, Task, Skill`

**Examples**:
- test-engineer (creates test files)
- docs-writer (creates documentation)

**Rationale**: These agents actively create deliverables that are expected as part of their function.

---

#### Strategic Agents
**Purpose**: Architecture, research, design decisions
**Tools**: `Read, Write, Edit, Grep, Glob, Bash, WebFetch, Task`

**Examples**:
- architect (system design documentation)

**Rationale**: Strategic agents need to fetch external references, research best practices, and create architecture documentation.

---

### Tool Safety Guidelines

1. **Write Access**: Only grant to agents that explicitly create files as their primary function
2. **WebFetch Access**: Only for agents that need external references (architecture, documentation)
3. **Bash Access**: Universal for reading git status, file listings, etc. (not for destructive operations)
4. **Task/Skill Access**: Most agents should coordinate with other specialists

---

## Content Structure

### Required Sections

Every agent `.md` file should follow this structure after the YAML frontmatter:

```markdown
---
[YAML frontmatter]
---

You are an expert [domain] specialist...

## Your [Domain] Expertise

[Bulleted list of core competencies and specializations]

## Working with Skills

### Available Skills
[List of complementary autonomous skills]

### When to Invoke Skills
[DO/DON'T patterns for skill usage]

### How to Invoke Skills
[Markdown invocation syntax and examples]

### Workflow Pattern
[Sequential steps showing skill-agent coordination]

### Example Coordination
[Real example with skill output and agent analysis]

## [Domain] Approach/Methodology

[Systematic framework for the agent's analysis process]

## [Domain] Process Framework

[Step-by-step process the agent follows]

## [Domain]-Specific Examples

[Real code examples with before/after analysis]

## Best Practices

[Guidelines and recommendations for using this agent]
```

### Section Details

#### 1. Opening Role Statement
**Length**: 1-2 paragraphs
**Purpose**: Define agent identity and core mission

```markdown
You are an expert [domain] specialist with deep knowledge of [technologies,
frameworks, patterns]. Your role is to [primary function] while ensuring
[quality attributes].
```

#### 2. Your [Domain] Expertise
**Format**: Bulleted list
**Content**: Core competencies, technologies, frameworks

```markdown
## Your Code Review Expertise

- **Code Quality & Patterns**: Clean code, SOLID principles, design patterns
- **Security**: OWASP Top 10, authentication, authorization
- **Performance**: Optimization strategies, profiling techniques
- **Testing**: Test coverage analysis, test quality assessment
```

#### 3. Working with Skills (NEW in v2.0)
**Length**: 40-100 lines
**Purpose**: Explain skill-agent coordination

**Subsections**:
- **Available Skills**: List complementary skills
- **When to Invoke**: DO/DON'T patterns
- **How to Invoke**: Markdown syntax
- **Workflow Pattern**: Sequential steps
- **Example Coordination**: Real example

```markdown
## Working with Skills

### Available Skills

**Security Skills**:
- `security-auditor skill` - Quick OWASP Top 10 scan
- `secret-scanner skill` - Credential detection

### When to Invoke Skills

**DO invoke skills when**:
- Starting a comprehensive review
- Need quick automated checks
- Want to identify obvious issues fast

**DON'T invoke skills when**:
- Quick single-file review
- Time-sensitive fixes needed
- Already have clear issue identified

### How to Invoke Skills

[Invoke security-auditor skill for initial scan]
[Invoke test-generator skill to check coverage]

### Workflow Pattern

1. QUICK CHECKS (Skills)
   - Invoke relevant skills at START
   - Review skill outputs
   - Identify quick wins

2. DEEP ANALYSIS (Your Expert Review)
   - Build on skill findings
   - Add contextual analysis
   - Provide strategic recommendations
```

#### 4. [Domain] Approach/Methodology
**Length**: 50-150 lines
**Content**: Core frameworks, principles, systematic approach

#### 5. [Domain] Process Framework
**Format**: Step-by-step numbered list
**Content**: Systematic process the agent follows

```markdown
## Code Review Process Framework

1. **Initial Assessment**
   - Review PR description and linked issues
   - Understand business context
   - Identify critical paths

2. **Automated Checks** (Skills)
   - Invoke security-auditor skill
   - Invoke test-generator skill
   - Review skill findings

3. **Code Analysis**
   - Review changed files systematically
   - Check for code smells and anti-patterns
   - Verify error handling

4. **Security Review**
   - OWASP Top 10 checks
   - Input validation review
   - Authentication/authorization verification

5. **Recommendations**
   - Prioritized findings (Critical/High/Medium/Low)
   - Actionable suggestions with examples
   - Trade-off analysis
```

#### 6. [Domain]-Specific Examples
**Format**: Code blocks with explanations
**Content**: Real before/after examples with analysis

```markdown
## Code Review Examples

### Example 1: Security Vulnerability

**Issue**: SQL Injection vulnerability

❌ **Before**:
\`\`\`javascript
const query = `SELECT * FROM users WHERE id = ${userId}`;
db.execute(query);
\`\`\`

✅ **After**:
\`\`\`javascript
const query = 'SELECT * FROM users WHERE id = ?';
db.execute(query, [userId]);
\`\`\`

**Analysis**: Always use parameterized queries to prevent SQL injection...
```

#### 7. Best Practices
**Format**: Bulleted or numbered list
**Content**: Usage guidelines and recommendations

---

## Directory Organization

### Physical Structure

```
agents/
├── README.md                          # Directory overview
├── {agent-name}.md                    # Agent definition file
└── {agent-name}/
    └── README.md                      # Quick reference guide
```

### Dual-File Pattern

Each agent consists of **two markdown files**:

#### 1. Agent Definition (`{agent-name}.md`)
**Location**: `agents/{agent-name}.md`
**Audience**: Claude Code interpreter
**Content**:
- YAML frontmatter (configuration)
- Full system prompt (8+ sections)
- Internal framework documentation
- Comprehensive examples
- Best practices

**Length**: 100-350+ lines

#### 2. User Guide (`{agent-name}/README.md`)
**Location**: `agents/{agent-name}/README.md`
**Audience**: End users (developers)
**Content**:
- Human-readable overview
- Usage examples with input/output
- Capabilities list
- Workflow patterns
- Quick reference

**Length**: 300-1500 lines

### Example Structure

```
agents/
├── code-reviewer.md              # Agent definition (214 lines)
├── code-reviewer/
│   └── README.md                 # User guide (621 lines)
├── test-engineer.md              # Agent definition (378 lines)
├── test-engineer/
│   └── README.md                 # User guide (1,330 lines)
└── security-auditor.md           # Agent definition (708 lines)
    └── security-auditor/
        └── README.md             # User guide (506 lines)
```

---

## Invocation Mechanisms

### Agent Invocation Syntax

```
@agent-name [task description]
[optional code/content]
```

**Format Rules**:
- Prefix with `@` symbol
- Use always kebab-case agent name (from `name` field)
- Provide clear, specific task description
- Include relevant code/context if needed

**Examples**:

```bash
# Code review request
@code-reviewer Review this React component for best practices and security

# Test generation request
@test-engineer Create comprehensive tests for this utility function with edge cases

# Security audit request
@security-auditor Audit this authentication system for OWASP vulnerabilities

# Architecture consultation
@architect Design a scalable system for handling 100k concurrent WebSocket connections
```

### Skill Invocation Syntax (from within agents)

Skills are invoked using markdown convention:

```markdown
[Invoke skill-name for specific purpose]
```

**Examples**:
```markdown
[Invoke security-auditor skill for initial scan]
[Invoke test-generator skill to check coverage]
[Invoke api-documenter skill for OpenAPI spec]
```

**Pattern in Agent Code**:
```markdown
# At the START of your review:
[Invoke security-auditor skill for quick scan]
[Invoke test-generator skill to check coverage]

# Review skill outputs...
# Then proceed with YOUR deep expert analysis...
```

---

## Best Practices

### Agent Design Principles

#### 1. Single Responsibility
Each agent should have one clear domain of expertise. Don't create "jack-of-all-trades" agents.

✅ **Good**: Separate `code-reviewer`, `security-auditor`, `performance-tuner`
❌ **Bad**: Single `code-helper` agent that does everything

#### 2. Tool Minimalism
Only request tools the agent actually needs. Fewer tools = safer execution.

✅ **Good**: `Read, Edit, Grep, Glob, Bash, Task, Skill` for code reviewer
❌ **Bad**: All tools including `Write, WebFetch` when not needed

#### 3. Skill Coordination
Design agents to work with autonomous skills, not replace them.

✅ **Good**: Agent invokes `security-auditor skill` then adds expert analysis
❌ **Bad**: Agent duplicates what skills already do

#### 4. Clear Descriptions
Make descriptions specific enough for intelligent agent selection.

✅ **Good**: "Expert code reviewer specializing in quality analysis, best practices, security, and performance optimization"
❌ **Bad**: "Reviews code and helps with programming"

#### 5. Comprehensive Examples
Include real code examples that demonstrate the agent's expertise.

✅ **Good**: Multiple before/after code blocks with detailed analysis
❌ **Bad**: Generic descriptions without concrete examples

---

### Content Quality Guidelines

#### Writing Style
- **Professional**: Technical accuracy over casual tone
- **Concise**: Direct and actionable, avoid fluff
- **Structured**: Clear sections with headers
- **Example-Heavy**: Show, don't just tell

#### Code Examples
- Use realistic scenarios
- Include before/after comparisons
- Provide detailed analysis explaining the changes
- Cover edge cases and trade-offs

#### Skill Integration
- Document which skills complement this agent
- Explain when to use skills vs. the agent
- Provide workflow examples showing coordination
- Include example skill outputs and agent responses

#### Standard Integration
- Every subagent will have standards from the /standards/ folder
- These standards are similar to standard operating procedures
- Quality standards and best practices guide will be included

---

### Naming Conventions

#### Agent Names
- **Format**: kebab-case
- **Length**: 3-25 characters
- **Pattern**: `[domain]-[role]` or `[role]-[specialization]`
- **Examples**: `code-reviewer`, `test-engineer`, `security-auditor`

#### Avoid
- Generic terms: `helper`, `assistant`, `tool`
- Abbreviations: `cr`, `sec-aud`, `perf`
- Underscores: `code_reviewer`
- CamelCase: `CodeReviewer`

---

## Examples

### Complete Agent Example: code-reviewer

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

- **Code Quality & Patterns**: Clean code principles, SOLID, design patterns, refactoring
- **Security**: OWASP Top 10, authentication, authorization, input validation, encryption
- **Performance**: Optimization strategies, profiling, caching, database queries
- **Testing**: Test coverage, test quality, edge cases, mocking strategies
- **Frontend**: React/Next.js, TypeScript, responsive design, accessibility
- **Backend**: Node.js/Express, Python/Django, Go, API design, microservices
- **Infrastructure**: Docker, CI/CD, monitoring, logging, error tracking

## Working with Skills

### Available Skills

**Security Skills**:
- `security-auditor skill` - OWASP Top 10 scanning, vulnerability detection
- `secret-scanner skill` - Credential and API key detection
- `dependency-auditor skill` - CVE checking for dependencies

**Development Skills**:
- `test-generator skill` - Test coverage analysis and scaffolding
- `git-commit-helper skill` - Commit message quality validation

### When to Invoke Skills

**DO invoke skills when**:
- Starting a comprehensive code review
- Reviewing multiple files or large PRs
- Need automated security/coverage checks
- Want to identify obvious issues quickly

**DON'T invoke skills when**:
- Reviewing a single small change
- Time-sensitive fixes needed
- Already have specific issue identified
- User explicitly requested agent-only review

### How to Invoke Skills

```markdown
[Invoke security-auditor skill for initial vulnerability scan]
[Invoke test-generator skill to check test coverage]
```

### Workflow Pattern

1. **QUICK CHECKS (Skills)**
   - Invoke security-auditor skill for vulnerability scan
   - Invoke test-generator skill for coverage analysis
   - Review skill outputs for immediate issues

2. **DEEP ANALYSIS (Your Expert Review)**
   - Build on skill findings with contextual analysis
   - Identify complex issues skills might miss
   - Provide strategic recommendations
   - Suggest architectural improvements

3. **REPORT**
   - Acknowledge skill findings
   - Add expert insights and context
   - Prioritize issues (Critical/High/Medium/Low)
   - Provide actionable recommendations with examples

### Example Coordination

```markdown
# Step 1: Invoke skills
[Invoke security-auditor skill for initial scan]

# Skill output:
# - Found SQL injection vulnerability in getUserById()
# - Detected weak password hashing in auth.js
# - Missing CSRF protection on POST endpoints

# Step 2: Your expert analysis
Building on the security-auditor findings, I've identified additional concerns:

**Critical Issues**:
1. SQL Injection (confirmed by skill) in `getUserById()` at line 45
   - Skill found the vulnerability, but it's actually exploitable via the search API
   - Impact: Full database compromise
   - Recommendation: Use parameterized queries + input validation

2. Weak Password Hashing (confirmed by skill) in `auth.js`
   - Using MD5 which is cryptographically broken
   - Missing salt and iteration count
   - Recommendation: Migrate to bcrypt with cost factor 12+

**Additional Issues (not found by skill)**:
3. Race condition in payment processing (lines 120-135)
   - Critical: Could allow double-charging customers
   - Recommendation: Implement idempotency keys and transaction locks
```

## Code Review Process Framework

[... detailed process sections ...]

## Best Practices

[... best practices sections ...]
```

---

### Minimal Agent Example: Simple Linter

```yaml
---
name: eslint-helper
description: ESLint configuration expert for JavaScript/TypeScript projects. Use when setting up or troubleshooting ESLint.
tools: Read, Edit, Grep, Glob, Bash
model: inherit
---

You are an ESLint configuration specialist. You help developers set up, configure,
and troubleshoot ESLint for JavaScript and TypeScript projects.

## Your Expertise

- ESLint configuration file formats (`.eslintrc.js`, `.eslintrc.json`, `package.json`)
- Plugin ecosystem (React, TypeScript, Prettier, etc.)
- Rule configuration and customization
- Integration with build tools (Webpack, Vite, etc.)

## Process

1. Read existing ESLint configuration
2. Identify issues or improvement opportunities
3. Suggest specific rule changes with explanations
4. Ensure compatibility with project tooling

## Examples

[... examples ...]

## Best Practices

- Always preserve existing working rules
- Explain why each rule is recommended
- Consider team coding standards
- Test configuration changes before committing
```

---

## Validation Checklist

Use this checklist when creating or migrating agents:

### YAML Frontmatter
- [ ] File starts with `---` delimiter
- [ ] `name` field is kebab-case, 3-25 characters
- [ ] `description` field is 50-180 characters, specific and actionable
- [ ] `tools` field lists tools in PascalCase, comma-space separated
- [ ] All tools are from the canonical tool list
- [ ] `model` field is set to `inherit`
- [ ] File has closing `---` delimiter
- [ ] No extra fields or typos in field names

### Content Structure
- [ ] Opening role statement (1-2 paragraphs)
- [ ] "Your [Domain] Expertise" section with bulleted competencies
- [ ] "Working with Skills" section (40-100 lines) if using `Skill` tool
- [ ] "[Domain] Approach/Methodology" section
- [ ] "[Domain] Process Framework" section
- [ ] "[Domain]-Specific Examples" section with code blocks
- [ ] "Best Practices" section

### Skills Integration (if applicable)
- [ ] Lists 2-3 complementary skills
- [ ] Explains when to invoke skills (DO/DON'T)
- [ ] Shows skill invocation syntax
- [ ] Provides workflow pattern with skills
- [ ] Includes example coordination

### Code Examples
- [ ] At least 3 realistic code examples
- [ ] Examples include before/after comparisons
- [ ] Each example has detailed analysis
- [ ] Syntax is correct and properly formatted
- [ ] Examples cover common use cases

### Directory Structure
- [ ] Agent definition file: `agents/{agent-name}.md`
- [ ] Subdirectory created: `agents/{agent-name}/`
- [ ] User guide created: `agents/{agent-name}/README.md`
- [ ] Both files have consistent naming

### Documentation Quality
- [ ] Professional, technical tone
- [ ] No spelling or grammar errors
- [ ] Headers follow consistent hierarchy
- [ ] Links are valid (if any)
- [ ] Code blocks have language tags
- [ ] Content is 100+ lines for definition file
- [ ] Content is 300+ lines for user guide

### Tool Selection
- [ ] Tools match agent's actual needs
- [ ] No unnecessary tools included
- [ ] Write access only if agent creates files
- [ ] WebFetch only for strategic agents
- [ ] Task/Skill access for coordination agents

### Testing
- [ ] YAML frontmatter is valid (no syntax errors)
- [ ] Agent can be invoked with `@agent-name`
- [ ] Description accurately describes agent
- [ ] Tool declarations allow necessary operations
- [ ] Skills can be invoked (if applicable)

---

## Summary

Creating a well-structured Claude Code sub-agent requires:

1. **Proper YAML Configuration**: 4 required fields with correct formats
2. **Tool Selection**: Minimal necessary tools for safety
3. **Comprehensive Content**: 8+ sections covering expertise, coordination, process, examples
4. **Skill Integration**: Coordination with autonomous background helpers
5. **Dual Documentation**: Agent definition + user guide
6. **Quality Examples**: Real code with detailed analysis

The result is a specialized, safe, and effective sub-agent that coordinates with skills and other agents to provide expert assistance.

---

**See Also**:
- [Anthropic Official Documentation](docs/ANTHROPIC-REFERENCE.md)
- [Sources vs Agents Comparison](docs/COMPARISON-ANALYSIS.md)
- [Migration Guide](documentation/guides/migration.md)
