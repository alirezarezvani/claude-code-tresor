# Commands Reference

Complete reference for all Claude Code Tresor commands.

## Overview

Commands are **workflow automation tools** that orchestrate multi-step processes, coordinate agents, and streamline common development tasks.

**Key Characteristics:**
- ✅ **Manual invocation** - Use `/command-name` syntax
- ✅ **Multi-step workflows** - Coordinate multiple operations
- ✅ **Agent orchestration** - Invoke multiple agents
- ✅ **Parameter support** - Flexible options and flags

---

## Command Configuration Specification

### command.json Schema

```json
{
  "name": "command-name",
  "description": "Command purpose",
  "category": "workflow",
  "usage": "/command-name --param1 <value>",
  "parameters": {
    "param1": {
      "type": "string",
      "description": "Parameter description",
      "required": true
    }
  },
  "agents": ["@agent1", "@agent2"],
  "enabled": true,
  "timeout": 300
}
```

---

## Field Reference

### name (required)
**Type:** String
**Format:** lowercase-with-dashes
**Example:** `"review"`

Command name used with `/command-name` invocation.

---

### description (required)
**Type:** String
**Example:** `"Automated code review with quality checks"`

Human-readable command purpose.

---

### category (required)
**Type:** String
**Allowed values:**
- `"development"` - Development workflows
- `"workflow"` - General workflows
- `"testing"` - Testing workflows
- `"documentation"` - Documentation workflows

---

### usage (required)
**Type:** String
**Example:** `"/review --scope <files> --checks <types>"`

Command usage syntax shown in help.

---

### parameters (optional)
**Type:** Object
**Structure:**
```json
"parameters": {
  "param_name": {
    "type": "string|array|boolean|number",
    "description": "Parameter description",
    "required": true|false,
    "default": "default_value"
  }
}
```

---

### agents (optional)
**Type:** Array of strings
**Example:** `["@code-reviewer", "@security-auditor"]`

Agents invoked by this command.

---

### enabled (optional)
**Type:** Boolean
**Default:** `true`

---

### timeout (optional)
**Type:** Number (seconds)
**Default:** `300` (5 minutes)

Maximum execution time before timeout.

---

## Development Commands

### /scaffold

**Purpose:** Project and component scaffolding

**Category:** `development`

**Usage:**
```bash
/scaffold <type> <name> [options]
```

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `type` | string | Yes | Component type (react-component, express-api, etc.) |
| `name` | string | Yes | Component name |
| `--typescript` | boolean | No | Use TypeScript (default: true) |
| `--tests` | boolean | No | Generate tests (default: true) |
| `--storybook` | boolean | No | Generate Storybook story (default: false) |
| `--path` | string | No | Custom output path |

**Examples:**

**React Component:**
```bash
/scaffold react-component UserProfile --typescript --tests --storybook
```

Creates:
- `src/components/UserProfile.tsx`
- `src/components/UserProfile.test.tsx`
- `src/components/UserProfile.stories.tsx`

**Express API:**
```bash
/scaffold express-api user-service --auth --database postgres --tests
```

Creates:
- `src/api/users.controller.ts`
- `src/api/users.service.ts`
- `src/api/users.routes.ts`
- `tests/api/users.test.ts`

**Vue Component:**
```bash
/scaffold vue-component ProductCard --composition-api --tests
```

**Microservice:**
```bash
/scaffold microservice payment-service --language typescript --database mongodb
```

**Supported Types:**
- `react-component` - React component with hooks
- `vue-component` - Vue 3 component
- `angular-component` - Angular component
- `express-api` - Express REST API
- `nestjs-api` - NestJS REST API
- `graphql-api` - GraphQL API
- `microservice` - Complete microservice
- `lambda-function` - AWS Lambda function
- `database-model` - Database model/schema

**Configuration:**
```json
{
  "name": "scaffold",
  "description": "Project and component scaffolding",
  "category": "development",
  "usage": "/scaffold <type> <name> [options]",
  "parameters": {
    "type": {
      "type": "string",
      "required": true,
      "description": "Component type"
    },
    "name": {
      "type": "string",
      "required": true,
      "description": "Component name"
    },
    "typescript": {
      "type": "boolean",
      "required": false,
      "default": true
    },
    "tests": {
      "type": "boolean",
      "required": false,
      "default": true
    }
  },
  "enabled": true
}
```

**[Full Documentation →](../../commands/development/scaffold/README.md)**

---

## Workflow Commands

### /review

**Purpose:** Automated code review with multi-dimensional quality checks

**Category:** `workflow`

**Usage:**
```bash
/review [options]
```

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `--scope` | string | No | Files to review (staged, all, or path) (default: staged) |
| `--checks` | array | No | Check types (security, performance, quality, configuration, all) |
| `--format` | string | No | Output format (markdown, json, html) (default: markdown) |
| `--output` | string | No | Output file path |
| `--fix` | boolean | No | Auto-fix issues (default: false) |
| `--pre-commit` | boolean | No | Run as pre-commit hook |

**Examples:**

**Basic Review (Staged Files):**
```bash
/review
```

**Comprehensive Review:**
```bash
/review --scope all --checks all
```

**Security Focus:**
```bash
/review --scope src/api/ --checks security,configuration
```

**Pre-Commit Hook:**
```bash
/review --pre-commit --checks security,quality
```

**Auto-Fix Issues:**
```bash
/review --scope staged --fix
```

**Generate Report:**
```bash
/review --scope all --format html --output ./reports/review.html
```

**Workflow:**

1. **Scope Analysis**
   - Identify files to review
   - Filter by patterns
   - Prioritize critical files

2. **Quality Checks**
   - **Code Quality:** @code-reviewer analyzes structure, patterns, maintainability
   - **Security:** @security-auditor scans for OWASP Top 10
   - **Performance:** @performance-tuner identifies bottlenecks
   - **Configuration:** Validates environment configs, checks risky changes

3. **Issue Aggregation**
   - Categorize issues by severity
   - Deduplicate findings
   - Prioritize action items

4. **Report Generation**
   - Summary with metrics
   - Detailed findings
   - Fix recommendations
   - Code examples

**Output Example:**
```
Code Review Report
==================

Scope: 12 files (staged)
Duration: 45 seconds

Summary:
✅ Code Quality: PASS (2 warnings)
🔴 Security: FAIL (1 critical issue)
⚠️ Performance: WARNING (3 issues)
✅ Configuration: PASS

Critical Issues:
1. SQL Injection Vulnerability
   File: src/api/users.controller.ts:45
   Severity: Critical
   Description: User input not sanitized in raw SQL query
   Fix: Use parameterized queries

[Detailed report continues...]
```

**Agents Used:**
- `@code-reviewer` - Code quality analysis
- `@security-auditor` - Security vulnerability scanning
- `@performance-tuner` - Performance analysis

**Configuration:**
```json
{
  "name": "review",
  "description": "Automated code review with quality checks",
  "category": "workflow",
  "usage": "/review [options]",
  "parameters": {
    "scope": {
      "type": "string",
      "required": false,
      "default": "staged",
      "description": "Files to review"
    },
    "checks": {
      "type": "array",
      "required": false,
      "default": ["all"],
      "description": "Check types"
    },
    "fix": {
      "type": "boolean",
      "required": false,
      "default": false
    }
  },
  "agents": [
    "@code-reviewer",
    "@security-auditor",
    "@performance-tuner"
  ],
  "enabled": true,
  "timeout": 600
}
```

**[Full Documentation →](../../commands/workflow/review/README.md)**

---

## Testing Commands

### /test-gen

**Purpose:** Intelligent test generation with multiple frameworks

**Category:** `testing`

**Usage:**
```bash
/test-gen [options]
```

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `--file` | string | Yes | File to generate tests for |
| `--framework` | string | No | Test framework (jest, vitest, mocha, pytest) |
| `--coverage` | number | No | Target coverage percentage (default: 80) |
| `--type` | string | No | Test type (unit, integration, e2e, all) |
| `--mocks` | boolean | No | Generate mocks (default: true) |
| `--run` | boolean | No | Run tests after generation (default: false) |

**Examples:**

**Basic Test Generation:**
```bash
/test-gen --file src/utils/validation.ts
```

**High Coverage:**
```bash
/test-gen --file src/services/payment.service.ts --coverage 95 --mocks
```

**Integration Tests:**
```bash
/test-gen --file src/api/users.controller.ts --type integration --framework jest
```

**E2E Tests:**
```bash
/test-gen --file src/pages/Login.tsx --type e2e --framework playwright
```

**Python Tests:**
```bash
/test-gen --file src/models/user.py --framework pytest --coverage 90
```

**Workflow:**

1. **File Analysis**
   - Parse source code
   - Identify functions/methods
   - Detect dependencies
   - Analyze complexity

2. **Test Strategy**
   - Determine test cases
   - Identify edge cases
   - Plan mocking strategy
   - Calculate coverage approach

3. **Test Generation**
   - Generate test structure
   - Create test cases
   - Generate mocks/fixtures
   - Add assertions

4. **Validation**
   - Syntax check
   - Run tests (if --run)
   - Calculate coverage
   - Report results

**Output Example:**
```
Test Generation: src/services/auth.service.ts
=============================================

Generated: src/services/auth.service.test.ts

Test Cases: 15
- 8 happy path tests
- 5 error condition tests
- 2 edge case tests

Coverage: 92% (target: 80%)

Tests Generated:
✅ login() with valid credentials
✅ login() with invalid credentials
✅ login() with missing parameters
✅ register() with unique email
✅ register() with duplicate email
✅ validateToken() with valid token
✅ validateToken() with expired token
[...]

Run tests: npm test auth.service.test.ts
```

**Supported Frameworks:**
- **JavaScript/TypeScript:** Jest, Vitest, Mocha, Jasmine
- **Python:** pytest, unittest
- **Java:** JUnit, TestNG
- **E2E:** Playwright, Cypress, Selenium

**Agents Used:**
- `@test-engineer` - Test strategy and generation

**Configuration:**
```json
{
  "name": "test-gen",
  "description": "Intelligent test generation",
  "category": "testing",
  "usage": "/test-gen --file <file> [options]",
  "parameters": {
    "file": {
      "type": "string",
      "required": true,
      "description": "File to generate tests for"
    },
    "framework": {
      "type": "string",
      "required": false,
      "description": "Test framework"
    },
    "coverage": {
      "type": "number",
      "required": false,
      "default": 80
    }
  },
  "agents": ["@test-engineer"],
  "enabled": true,
  "timeout": 300
}
```

**[Full Documentation →](../../commands/testing/test-gen/README.md)**

---

## Documentation Commands

### /docs-gen

**Purpose:** Automated documentation generation

**Category:** `documentation`

**Usage:**
```bash
/docs-gen <type> [options]
```

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `type` | string | Yes | Doc type (api, architecture, user-guide, readme) |
| `--format` | string | No | Output format (markdown, openapi, html) |
| `--path` | string | No | Source code path (default: src/) |
| `--output` | string | No | Output path (default: docs/) |
| `--include-examples` | boolean | No | Include code examples (default: true) |
| `--include-diagrams` | boolean | No | Generate diagrams (default: true) |

**Examples:**

**API Documentation:**
```bash
/docs-gen api --format openapi --include-examples
```

Generates OpenAPI 3.0 specification with:
- Endpoint documentation
- Request/response schemas
- Authentication details
- Code examples

**Architecture Documentation:**
```bash
/docs-gen architecture --include-diagrams
```

Generates:
- System architecture overview
- Component diagrams
- Data flow diagrams
- Deployment topology

**User Guide:**
```bash
/docs-gen user-guide --format html --output ./docs/user-guide.html
```

**README:**
```bash
/docs-gen readme --include-examples
```

Updates README.md with:
- Project overview
- Installation instructions
- Usage examples
- API reference
- Contributing guide

**Workflow:**

1. **Source Analysis**
   - Parse source code
   - Extract API endpoints
   - Identify components
   - Map dependencies

2. **Documentation Generation**
   - Generate documentation structure
   - Create content sections
   - Add code examples
   - Generate diagrams (Mermaid)

3. **Output Formatting**
   - Format as specified (markdown, HTML, OpenAPI)
   - Add navigation
   - Include assets
   - Validate links

4. **Validation**
   - Check completeness
   - Verify examples
   - Test links
   - Generate report

**Agents Used:**
- `@docs-writer` - Documentation generation
- `@architect` - Architecture diagrams (if needed)

**Configuration:**
```json
{
  "name": "docs-gen",
  "description": "Automated documentation generation",
  "category": "documentation",
  "usage": "/docs-gen <type> [options]",
  "parameters": {
    "type": {
      "type": "string",
      "required": true,
      "description": "Documentation type"
    },
    "format": {
      "type": "string",
      "required": false,
      "description": "Output format"
    },
    "include-examples": {
      "type": "boolean",
      "required": false,
      "default": true
    }
  },
  "agents": ["@docs-writer", "@architect"],
  "enabled": true,
  "timeout": 300
}
```

**[Full Documentation →](../../commands/documentation/docs-gen/README.md)**

---

## Best Practices

### 1. Use Help Flag

Check command syntax and options:
```bash
/scaffold --help
/review --help
/test-gen --help
```

---

### 2. Start with Defaults

Commands have sensible defaults:
```bash
# Default review (staged files, all checks)
/review

# Explicit (same result)
/review --scope staged --checks all
```

---

### 3. Combine with Agents

Commands orchestrate, agents analyze:
```bash
# Command for workflow
/review --scope src/api/

# Then agent for deep dive
@security-auditor detailed analysis of src/api/auth.controller.ts
```

---

### 4. Use Scoped Reviews

Review specific areas instead of entire codebase:
```bash
# Fast, focused
/review --scope src/api/payment.controller.ts --checks security

# Slow, comprehensive
/review --scope all --checks all
```

---

## Troubleshooting

### Command Not Found

```bash
# Check command exists
ls ~/.claude/commands/review/

# Verify configuration
cat ~/.claude/commands/review/command.json

# Try full path
/workflow/review
```

**[Complete troubleshooting →](../guides/troubleshooting.md#command-issues)**

---

## Custom Command Development

**[Contributing Guide →](../guides/contributing.md#creating-a-command)**

---

## See Also

- **[Getting Started →](../guides/getting-started.md)** - Learn how commands work
- **[Configuration Guide →](../guides/configuration.md)** - Advanced configuration
- **[Skills Reference →](skills-reference.md)** - Automatic helpers
- **[Agents Reference →](agents-reference.md)** - Deep analysis agents

---

**Last Updated:** November 7, 2025 | **Version:** 2.0.0
