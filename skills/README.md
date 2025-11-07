# Claude Code Skills

> **Contextual helpers that Claude invokes during conversations when relevant**

Skills are Claude Code's proactive assistance feature. Claude automatically invokes skills during conversations when they're contextually relevant to your discussion or task.

## Quick Start

```bash
# Install skills
./scripts/install.sh --skills

# Skills are invoked by Claude automatically during conversations
# Start a Claude Code session and discuss your code - skills activate when relevant
```

## What Are Skills?

**Skills** are lightweight, contextual helpers that:
- ✅ **Invoked by Claude** automatically when relevant to the conversation
- ✅ **Work proactively** without manual invocation by you
- ✅ **Detect opportunities** during code discussions (issues, improvements, missing tests)
- ✅ **Suggest next steps** based on conversation context
- ✅ **Complement sub-agents** by handling quick checks before deep analysis

### Skills vs Sub-Agents vs Commands

| Feature | Skills | Sub-Agents | Commands |
|---------|--------|------------|----------|
| **Invocation** | By Claude (auto) | Manual (`@agent`) | Manual (`/command`) |
| **Scope** | Single concern | Expert analysis | Multi-agent workflow |
| **Context** | Shared | Separate | Orchestrates |
| **Duration** | During conversation | Task-specific | Workflow-specific |
| **Tools** | Limited (safe) | Full access | Coordinates agents |
| **Best For** | Quick checks | Deep analysis | Complex workflows |

**Example workflow:**
1. You discuss code with Claude → **Skill** is invoked automatically → suggests improvement
2. You invoke **Sub-Agent** (`@code-reviewer`) → comprehensive analysis
3. You run **Command** (`/review --full`) → coordinates security + performance + architecture review

## Available Skills (8 Core)

### Development (3 skills)

#### 1. code-reviewer
**What it does:** Code quality checks when discussing code with Claude
- ✅ Detects code smells and anti-patterns
- ✅ Suggests best practices (naming, structure)
- ✅ Basic security checks
- ✅ Style consistency validation

**Invoked when:** Discussing code quality, reviewing files, asking about patterns
**Tools:** Read, Grep, Glob
**Complements:** `@code-reviewer` sub-agent for deep analysis

**Example:**
```javascript
// You ask Claude: "Review this function"
function getData() {
  return fetch('/api/data').then(r => r.json())
}

// Claude invokes code-reviewer skill, which suggests:
// - Missing error handling
// - No TypeScript types
// - Should use async/await
// → For full review: @code-reviewer
```

[📖 Full Documentation](development/code-reviewer/SKILL.md)

---

#### 2. test-generator
**What it does:** Suggests tests during code discussions
- ✅ Scaffolds basic test structure (3-5 tests)
- ✅ Detects untested code
- ✅ Framework-aware (Jest, Vitest, Pytest, JUnit)
- ✅ Suggests edge cases

**Invoked when:** Discussing new functions, asking about testing, reviewing code without tests
**Tools:** Read, Write, Edit
**Complements:** `@test-engineer` sub-agent for comprehensive test suites

**Example:**
```javascript
// You ask Claude: "I added this function, what tests should I write?"
export function calculateDiscount(price, percentage) {
  return price * (percentage / 100)
}

// Claude invokes test-generator skill, which suggests:
// tests/calculateDiscount.test.js
// - Basic calculation test
// - Edge case: zero percentage
// - Edge case: 100% discount
// → For full suite: @test-engineer
```

[📖 Full Documentation](development/test-generator/SKILL.md)

---

#### 3. git-commit-helper
**What it does:** Generates conventional commit messages from git diff
- ✅ Analyzes staged changes
- ✅ Suggests commit type (feat, fix, docs, etc.)
- ✅ Writes clear commit message
- ✅ Follows conventional commits format

**Triggers:** `git diff --staged`, commit mentioned, "commit this"
**Tools:** Bash, Read
**Complements:** Manual commit workflow

**Example:**
```bash
# You stage changes:
git add src/auth/login.tsx

# Skill analyzes diff and suggests:
feat(auth): add login form with email validation

- Implement LoginForm component
- Add email/password validation
- Connect to authentication API
- Add error handling for failed login

Closes #42
```

[📖 Full Documentation](development/git-commit-helper/SKILL.md)

---

### Security (3 skills)

#### 4. security-auditor
**What it does:** OWASP Top 10 vulnerability scanning
- ✅ SQL injection detection
- ✅ XSS vulnerability scanning
- ✅ Authentication/authorization issues
- ✅ Insecure data exposure
- ✅ Security misconfiguration

**Triggers:** API endpoint changes, database queries, authentication code
**Tools:** Read, Grep, Bash
**Complements:** `@code-reviewer` sub-agent for comprehensive security review

**Example:**
```javascript
// You write:
app.get('/users/:id', (req, res) => {
  const query = `SELECT * FROM users WHERE id = ${req.params.id}`
  db.query(query)
})

// Skill alerts:
// 🚨 CRITICAL: SQL Injection vulnerability
// Line 2: Direct parameter interpolation
// Fix: Use parameterized queries
// → For full audit: @code-reviewer --focus security
```

[📖 Full Documentation](security/security-auditor/SKILL.md)

---

#### 5. secret-scanner
**What it does:** Detects exposed secrets before commit
- ✅ API keys (AWS, Stripe, GitHub, SendGrid)
- ✅ Database credentials
- ✅ Private keys and tokens
- ✅ OAuth secrets

**Triggers:** Pre-commit, file changes, "push" or "commit" mentioned
**Tools:** Read, Grep (read-only)
**Complements:** Pre-commit hooks, CI/CD security scans

**Example:**
```javascript
// You accidentally commit:
const config = {
  stripeKey: 'sk_live_51HfG8KLm...',  // ⚠️ DETECTED
  apiUrl: 'https://api.example.com'
}

// Skill blocks commit:
// 🚨 EXPOSED SECRET DETECTED
// File: src/config.js:2
// Type: Stripe Live Secret Key
// Action: Move to .env, add to .gitignore
// COMMIT BLOCKED
```

[📖 Full Documentation](security/secret-scanner/SKILL.md)

---

#### 6. dependency-auditor
**What it does:** Checks dependencies for known vulnerabilities (CVEs)
- ✅ npm audit (Node.js)
- ✅ pip-audit (Python)
- ✅ bundle audit (Ruby)
- ✅ CVE severity classification
- ✅ Fix suggestions

**Triggers:** package.json changes, requirements.txt updates, `npm install`
**Tools:** Bash, Read
**Complements:** CI/CD security pipelines, Dependabot

**Example:**
```bash
# You install dependency:
npm install lodash@4.17.15

# Skill runs npm audit:
# 🚨 HIGH: Prototype Pollution in lodash@4.17.15
# CVE-2020-8203
# Fix available: npm update lodash
# Patched in: 4.17.21
```

[📖 Full Documentation](security/dependency-auditor/SKILL.md)

---

### Documentation (2 skills)

#### 7. api-documenter
**What it does:** Auto-generates OpenAPI/Swagger specs from code
- ✅ Extracts API endpoints from code
- ✅ Generates request/response schemas
- ✅ Creates example payloads
- ✅ Documents authentication requirements
- ✅ Framework-aware (Express, FastAPI, Django REST, Spring Boot)

**Triggers:** API routes added/modified, controller changes, "document API"
**Tools:** Read, Write, Grep
**Complements:** `@docs-writer` sub-agent for user guides

**Example:**
```javascript
// You add endpoint:
/**
 * Get user by ID
 * @param {string} id - User ID
 * @returns {User} User object
 */
app.get('/api/users/:id', async (req, res) => {
  const user = await User.findById(req.params.id)
  res.json(user)
})

// Skill auto-generates:
// openapi.json with endpoint spec
// Request/response schemas
// Example payloads
// → For full docs site: @docs-writer
```

[📖 Full Documentation](documentation/api-documenter/SKILL.md)

---

#### 8. readme-updater
**What it does:** Keeps README current with project changes
- ✅ Detects new features → Updates Features section
- ✅ New dependencies → Updates Installation
- ✅ Configuration changes → Updates Setup
- ✅ Environment variables → Adds to Config section

**Triggers:** Project structure changes, features added, dependencies modified
**Tools:** Read, Write, Edit, Grep
**Complements:** `@docs-writer` sub-agent for comprehensive documentation

**Example:**
```bash
# You add Stripe integration:
npm install stripe

# Skill suggests README update:
## Installation
npm install
npm install stripe  # For payment processing

## Environment Variables
STRIPE_SECRET_KEY=your_key  # Required for payments

## Features
- ✨ Payment processing with Stripe  # NEW
```

[📖 Full Documentation](documentation/readme-updater/SKILL.md)

---

## Sandboxing (Optional)

**All skills work WITHOUT sandboxing enabled (default).**

Sandboxing provides additional filesystem/network isolation but is completely optional.

### When to Enable Sandboxing

Enable for:
- **dependency-auditor**: Restricts npm/pip registry access
- **secret-scanner**: Read-only filesystem protection
- **security-auditor**: Limits tool execution

### How to Enable (Optional)

```bash
# During installation
./scripts/install.sh --skills-only --sandboxing

# Or configure manually in skill's settings
```

**See:** [SANDBOXING-GUIDE.md](../SANDBOXING-GUIDE.md) for detailed configuration

---

## Integration Patterns

### 1. Skill → Sub-Agent

**Pattern:** Skill detects → User invokes sub-agent for deep analysis

```
[code-reviewer skill] detects code smell
       ↓
User: "@code-reviewer analyze this component"
       ↓
[Sub-agent] provides comprehensive review
```

**Example:**
```javascript
// Skill: "Potential performance issue in loop"
// You: "@code-reviewer --focus performance"
// Sub-Agent: Full analysis with profiling suggestions
```

### 2. Skill → Command

**Pattern:** Skill suggests → User runs command for workflow

```
[test-generator skill] detects untested code
       ↓
User: "/test-gen --file utils.js --coverage 90"
       ↓
[Command] orchestrates test creation workflow
```

### 3. Multiple Skills

**Pattern:** Skills work together automatically

```
[code-reviewer] detects issue
[security-auditor] flags vulnerability
[test-generator] suggests missing test
       ↓
User sees all suggestions together
```

---

## Customization

### Copy-Paste Templates

For custom skills, see [TEMPLATES.md](TEMPLATES.md) with ready-to-use templates:
- Basic skill template
- Security scanning template
- Documentation generator template
- Custom framework integration template

### Company-Specific Skills

```bash
# Copy skill and customize
cp -r skills/security/security-auditor \
      skills/security/company-security-auditor

# Edit SKILL.md frontmatter:
---
name: company-security-auditor
description: Company-specific security standards and policies
allowed-tools: Read, Grep, Bash
---
```

---

## Troubleshooting

### Skill Not Activating

**Check trigger keywords in SKILL.md description:**
```yaml
description: Use when [KEYWORD], or user mentions [KEYWORD]
```

**Verify allowed-tools:**
```yaml
allowed-tools: Read, Write, Edit  # Must have needed tools
```

### Skill Conflicts with Sub-Agent

**Skills and sub-agents should complement, not duplicate:**
- **Skill:** Quick, automatic checks
- **Sub-Agent:** Deep, manual analysis

**If overlap:** Use skill for detection, sub-agent for resolution

### Sandboxing Issues

**Skill needs network but sandboxed?**
- Add domain to allowedDomains in sandboxing config
- Or disable sandboxing (works fine without it)

**See:** [SANDBOXING-GUIDE.md](../SANDBOXING-GUIDE.md)

---

## Best Practices

1. **Let skills run continuously** - Don't disable unless causing issues
2. **Skills detect, you decide** - Review suggestions before acting
3. **Use sub-agents for deep work** - Skills are for quick checks
4. **Keep skill descriptions accurate** - Trigger keywords matter
5. **Customize for your team** - Copy and modify templates
6. **Sandboxing is optional** - Only enable if security requirements demand it

---

## Next Steps

1. **Get Started:** [GETTING-STARTED.md](../GETTING-STARTED.md) - 5-minute quick start
2. **Architecture:** [ARCHITECTURE.md](../ARCHITECTURE.md) - Understand the 3-tier system
3. **Migration:** [MIGRATION-GUIDE.md](../MIGRATION-GUIDE.md) - Upgrading from older versions
4. **Templates:** [TEMPLATES.md](TEMPLATES.md) - Copy-paste custom skill templates
5. **Examples:** [examples/workflows/skills-in-action.md](../examples/workflows/skills-in-action.md)

---

## Related Documentation

- [Sub-Agents](../agents/README.md) - Manual expert invocation
- [Commands](../commands/README.md) - Workflow orchestration
- [Prompts](../prompts/README.md) - Development templates
- [Standards](../standards/README.md) - Code quality guidelines

---

**Created:** October 24, 2025
**Author:** Alireza Rezvani
**License:** MIT
