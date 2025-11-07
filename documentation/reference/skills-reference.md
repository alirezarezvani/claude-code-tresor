# Skills Reference

Complete reference for all Claude Code Tresor skills.

## Overview

Skills are **autonomous background helpers** that work continuously without manual invocation. They activate automatically based on code changes, file saves, and commits.

**Key Characteristics:**
- ✅ **Automatic activation** - No manual invocation needed
- ✅ **Lightweight** - Limited tool access (Read, Write, Edit, Grep, Glob)
- ✅ **Proactive** - Detect issues before you commit
- ✅ **Non-blocking** - Provide suggestions without interrupting workflow

---

## Skill Configuration Specification

### YAML Frontmatter Schema

```yaml
---
name: "skill-name"                    # Required: Unique identifier
description: "Skill description"      # Required: Human-readable purpose
trigger_keywords:                     # Optional: Supplementary triggers
  - "keyword1"
  - "keyword2"
tools:                                # Required: Available tools
  - "Read"
  - "Write"
  - "Edit"
  - "Grep"
  - "Glob"
model: "claude-sonnet-4"              # Optional: Default is sonnet
enabled: true                         # Optional: Default is true
priority: "medium"                    # Optional: high, medium, low
file_patterns:                        # Optional: Files to monitor
  - "*.ts"
  - "*.tsx"
exclude_patterns:                     # Optional: Files to ignore
  - "node_modules/**"
  - "dist/**"
---
```

---

## Field Reference

### name (required)
**Type:** String
**Format:** lowercase-with-dashes
**Example:** `"code-reviewer"`

Unique identifier for the skill. Used internally for configuration and coordination.

---

### description (required)
**Type:** String
**Length:** 50-200 characters
**Example:** `"Real-time code quality and best practices checker"`

Human-readable description of skill purpose.

---

### trigger_keywords (optional)
**Type:** Array of strings
**Default:** `[]`
**Example:**
```yaml
trigger_keywords:
  - "save"
  - "commit"
  - "code"
```

Supplementary keywords that activate skill. **Note:** Skills primarily activate based on file changes, not keywords.

---

### tools (required)
**Type:** Array of strings
**Allowed values:**
- `"Read"` - Read files
- `"Write"` - Create/overwrite files
- `"Edit"` - Modify existing files
- `"Grep"` - Search file contents
- `"Glob"` - Find files by pattern

**Important:** Skills do NOT have access to `Bash` or `Task` tools for safety.

**Example:**
```yaml
tools:
  - "Read"
  - "Grep"
  - "Glob"
```

---

### model (optional)
**Type:** String
**Default:** `"claude-sonnet-4"`
**Allowed values:**
- `"claude-sonnet-4"` - Fast, efficient (recommended for skills)
- `"claude-opus-4"` - Most capable (use for complex analysis)

**Example:**
```yaml
model: "claude-sonnet-4"
```

---

### enabled (optional)
**Type:** Boolean
**Default:** `true`
**Example:**
```yaml
enabled: true   # Skill active
enabled: false  # Skill disabled
```

---

### priority (optional)
**Type:** String
**Default:** `"medium"`
**Allowed values:**
- `"high"` - Execute first (critical checks)
- `"medium"` - Default priority
- `"low"` - Execute last (nice-to-have checks)

**Example:**
```yaml
priority: "high"  # Security checks should be high
```

---

### file_patterns (optional)
**Type:** Array of glob patterns
**Default:** All files
**Example:**
```yaml
file_patterns:
  - "*.ts"
  - "*.tsx"
  - "src/**/*.js"
```

---

### exclude_patterns (optional)
**Type:** Array of glob patterns
**Default:** `[]`
**Example:**
```yaml
exclude_patterns:
  - "node_modules/**"
  - "dist/**"
  - "*.test.ts"
  - "*.min.js"
```

---

## Development Skills

### code-reviewer

**Purpose:** Real-time code quality and best practices checking

**Activates when:**
- File saved with code changes
- New code file created

**Checks for:**
- Code quality issues
- Best practices violations
- Style inconsistencies
- Potential bugs
- Maintainability concerns

**Example Output:**
```
⚠️ Code quality issues detected:
- Missing error handling in async function
- Variable naming doesn't follow conventions
- Consider extracting complex logic into helper function
```

**Configuration:**
```yaml
---
name: "code-reviewer"
description: "Real-time code quality and best practices checker"
tools:
  - "Read"
  - "Grep"
  - "Glob"
model: "claude-sonnet-4"
enabled: true
priority: "high"
file_patterns:
  - "*.ts"
  - "*.tsx"
  - "*.js"
  - "*.jsx"
exclude_patterns:
  - "*.test.*"
  - "*.spec.*"
  - "node_modules/**"
---
```

**[Full Documentation →](../../skills/development/code-reviewer/SKILL.md)**

---

### test-generator

**Purpose:** Suggest missing tests and test coverage improvements

**Activates when:**
- New code file created without tests
- Code file modified but tests not updated
- Low test coverage detected

**Suggests:**
- Missing test files
- Untested code paths
- Edge cases to test
- Test improvement opportunities

**Example Output:**
```
📋 Test suggestions:
- Missing tests for UserProfile component
- Suggested test cases:
  1. Test happy path rendering
  2. Test error state
  3. Test loading state
  4. Test user interactions
```

**Configuration:**
```yaml
---
name: "test-generator"
description: "Suggest missing tests and coverage improvements"
tools:
  - "Read"
  - "Grep"
  - "Glob"
model: "claude-sonnet-4"
enabled: true
priority: "medium"
file_patterns:
  - "src/**/*.ts"
  - "src/**/*.tsx"
exclude_patterns:
  - "*.test.*"
  - "*.spec.*"
---
```

**[Full Documentation →](../../skills/development/test-generator/SKILL.md)**

---

### git-commit-helper

**Purpose:** Generate conventional commit messages

**Activates when:**
- User prepares to commit
- Staged changes detected

**Provides:**
- Conventional commit message
- Commit type suggestion (feat, fix, docs, etc.)
- Commit scope suggestion
- Detailed commit body (if needed)

**Example Output:**
```
💡 Suggested commit message:

feat(auth): implement user login with JWT tokens

- Add login endpoint with email/password validation
- Generate JWT tokens with 24h expiration
- Add refresh token mechanism
- Include basic rate limiting

🤖 Generated with Claude Code
```

**Configuration:**
```yaml
---
name: "git-commit-helper"
description: "Generate conventional commit messages"
tools:
  - "Read"
  - "Bash"
model: "claude-sonnet-4"
enabled: true
priority: "low"
---
```

**[Full Documentation →](../../skills/development/git-commit-helper/SKILL.md)**

---

## Security Skills

### security-auditor

**Purpose:** OWASP Top 10 vulnerability scanning

**Activates when:**
- Code file saved with security-sensitive operations
- API endpoints modified
- Authentication/authorization code changed

**Scans for:**
- SQL injection vulnerabilities
- XSS vulnerabilities
- CSRF vulnerabilities
- Insecure authentication
- Broken access control
- Security misconfigurations

**Example Output:**
```
🔴 Critical security issues:
1. SQL Injection: User input not sanitized
   File: src/api/users.ts:45
   Fix: Use parameterized queries

2. XSS Vulnerability: Unescaped user content
   File: src/components/Comment.tsx:12
   Fix: Sanitize HTML before rendering
```

**Configuration:**
```yaml
---
name: "security-auditor"
description: "OWASP Top 10 vulnerability scanner"
tools:
  - "Read"
  - "Grep"
  - "Glob"
model: "claude-opus-4"  # Use Opus for thorough security analysis
enabled: true
priority: "high"
file_patterns:
  - "src/api/**/*.ts"
  - "src/controllers/**/*.ts"
  - "src/components/**/*.tsx"
exclude_patterns:
  - "*.test.*"
---
```

**[Full Documentation →](../../skills/security/security-auditor/SKILL.md)**

---

### secret-scanner

**Purpose:** Detect exposed API keys, passwords, and secrets

**Activates when:**
- Any file saved
- Before commit

**Detects:**
- API keys
- Access tokens
- Passwords
- Private keys
- Database credentials
- OAuth secrets

**Example Output:**
```
🚨 SECRETS DETECTED:
1. AWS Access Key exposed
   File: src/config/aws.ts:8
   Pattern: AKIA[0-9A-Z]{16}
   Action: REMOVE IMMEDIATELY and rotate key

2. Database password in plaintext
   File: src/config/database.ts:12
   Action: Use environment variables
```

**Configuration:**
```yaml
---
name: "secret-scanner"
description: "Detect exposed API keys and secrets"
tools:
  - "Read"
  - "Grep"
model: "claude-sonnet-4"
enabled: true
priority: "high"
file_patterns:
  - "**/*"
exclude_patterns:
  - "node_modules/**"
  - ".git/**"
---
```

**[Full Documentation →](../../skills/security/secret-scanner/SKILL.md)**

---

### dependency-auditor

**Purpose:** Check dependencies for known vulnerabilities (CVEs)

**Activates when:**
- package.json modified
- Dependencies added/updated
- Lock file changed

**Checks:**
- Known CVEs in dependencies
- Outdated dependencies with security fixes
- Vulnerable transitive dependencies
- License compliance issues

**Example Output:**
```
⚠️ Dependency vulnerabilities found:

1. lodash@4.17.15 (High Severity)
   CVE-2020-8203: Prototype pollution
   Fix: Update to lodash@4.17.21

2. axios@0.21.0 (Medium Severity)
   CVE-2021-3749: SSRF vulnerability
   Fix: Update to axios@0.21.4
```

**Configuration:**
```yaml
---
name: "dependency-auditor"
description: "Check dependencies for CVEs"
tools:
  - "Read"
  - "Bash"
model: "claude-sonnet-4"
enabled: true
priority: "high"
file_patterns:
  - "package.json"
  - "package-lock.json"
  - "yarn.lock"
  - "pom.xml"
  - "requirements.txt"
---
```

**[Full Documentation →](../../skills/security/dependency-auditor/SKILL.md)**

---

## Documentation Skills

### api-documenter

**Purpose:** Auto-generate OpenAPI specifications

**Activates when:**
- API endpoint added/modified
- Controller/route file changed

**Generates:**
- OpenAPI 3.0 specifications
- Endpoint documentation
- Request/response schemas
- Authentication requirements
- Error responses

**Example Output:**
```
📚 API documentation update available:

New endpoint detected: POST /api/users/login

Generated OpenAPI spec:
```yaml
paths:
  /api/users/login:
    post:
      summary: Authenticate user
      requestBody:
        required: true
        content:
          application/json:
            schema:
              type: object
              properties:
                email:
                  type: string
                password:
                  type: string
      responses:
        200:
          description: Login successful
```

**Configuration:**
```yaml
---
name: "api-documenter"
description: "Auto-generate OpenAPI specifications"
tools:
  - "Read"
  - "Write"
  - "Grep"
  - "Glob"
model: "claude-opus-4"
enabled: true
priority: "low"
file_patterns:
  - "src/api/**/*.ts"
  - "src/controllers/**/*.ts"
  - "src/routes/**/*.ts"
---
```

**[Full Documentation →](../../skills/documentation/api-documenter/SKILL.md)**

---

### readme-updater

**Purpose:** Keep README current with code changes

**Activates when:**
- Project structure changes
- New features added
- Configuration files modified
- Dependencies updated

**Updates:**
- Installation instructions
- Feature list
- Configuration examples
- Usage examples
- Dependency list

**Example Output:**
```
📝 README update suggested:

New feature added: User authentication
Suggested README section:

## Authentication

This project includes JWT-based authentication:

```bash
# Login
POST /api/users/login
{
  "email": "user@example.com",
  "password": "secure-password"
}
```

Would you like me to update README.md?
```

**Configuration:**
```yaml
---
name: "readme-updater"
description: "Keep README current with changes"
tools:
  - "Read"
  - "Write"
  - "Edit"
  - "Grep"
model: "claude-sonnet-4"
enabled: true
priority: "low"
file_patterns:
  - "src/**/*"
  - "package.json"
  - "*.config.js"
---
```

**[Full Documentation →](../../skills/documentation/readme-updater/SKILL.md)**

---

## Skill Coordination

Skills can coordinate with agents for deeper analysis:

```yaml
---
name: "code-reviewer"
coordination:
  invoke_agents:
    - agent: "@security-auditor"
      when: "security_issue_detected"
      priority: "immediate"
    - agent: "@performance-tuner"
      when: "performance_issue_detected"
      priority: "deferred"
---
```

**Coordination Modes:**
- `immediate` - Invoke agent immediately
- `deferred` - Suggest agent invocation to user
- `background` - Invoke agent in background

---

## Best Practices

### 1. Configure File Patterns

Focus skills on relevant files:

```yaml
file_patterns:
  - "src/**/*.ts"      # Only source files
  - "src/**/*.tsx"
exclude_patterns:
  - "*.test.*"         # Exclude tests
  - "*.stories.*"      # Exclude Storybook
  - "*.spec.*"         # Exclude specs
  - "node_modules/**"  # Exclude dependencies
```

---

### 2. Set Appropriate Priorities

```yaml
# Security checks: high priority
---
name: "security-auditor"
priority: "high"
---

# Code quality: medium priority
---
name: "code-reviewer"
priority: "medium"
---

# Documentation: low priority
---
name: "readme-updater"
priority: "low"
---
```

---

### 3. Choose Right Model

```yaml
# Fast checks: use Sonnet
---
name: "code-reviewer"
model: "claude-sonnet-4"
---

# Deep analysis: use Opus
---
name: "security-auditor"
model: "claude-opus-4"
---
```

---

### 4. Coordinate with Agents

Let skills detect issues, agents provide deep analysis:

```
Skill detects → User reviews → Agent analyzes → User fixes
```

Example:
```
code-reviewer skill: "⚠️ Security issue detected"
User: @security-auditor analyze this security issue
@security-auditor: [Detailed security analysis]
```

---

## Troubleshooting

### Skill Not Activating

```yaml
# Check enabled field
---
enabled: true  # Must be true
---

# Check file patterns
file_patterns:
  - "*.ts"  # Does this match your files?

# Check exclude patterns
exclude_patterns:
  - "node_modules/**"  # Is file excluded?
```

**[Complete troubleshooting →](../guides/troubleshooting.md#skill-issues)**

---

## Custom Skill Development

**[Contributing Guide →](../guides/contributing.md#creating-a-skill)**

---

## See Also

- **[Getting Started →](../guides/getting-started.md)** - Learn how skills work
- **[Configuration Guide →](../guides/configuration.md)** - Advanced configuration
- **[Agents Reference →](agents-reference.md)** - Deep analysis agents
- **[Commands Reference →](commands-reference.md)** - Workflow automation

---

**Last Updated:** November 7, 2025 | **Version:** 2.0.0
