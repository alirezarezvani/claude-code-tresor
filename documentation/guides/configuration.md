# Configuration Guide

Comprehensive guide to configuring Claude Code Tresor skills, agents, and commands.

## Overview

Claude Code Tresor components are configured through:
- **Skills:** YAML frontmatter in `SKILL.md` files
- **Agents:** YAML frontmatter in `SKILL.md` files or `agent.json`
- **Commands:** JSON configuration in `command.json` files

---

## Skills Configuration

Skills are configured in `~/.claude/skills/{skill-name}/SKILL.md` using YAML frontmatter.

### Basic Skill Configuration

```yaml
---
name: "code-reviewer"
description: "Real-time code quality and best practices checker"
trigger_keywords:
  - "save"
  - "commit"
  - "code"
  - "review"
tools:
  - "Read"
  - "Write"
  - "Edit"
  - "Grep"
  - "Glob"
model: "claude-sonnet-4"
enabled: true
priority: "high"
---
```

### Configuration Fields

#### name (required)
**Type:** String
**Description:** Unique identifier for the skill

```yaml
name: "code-reviewer"
```

---

#### description (required)
**Type:** String
**Description:** Human-readable description of skill purpose

```yaml
description: "Real-time code quality and best practices checker"
```

---

#### trigger_keywords (optional)
**Type:** Array of strings
**Description:** Keywords that activate the skill in conversations

```yaml
trigger_keywords:
  - "save"
  - "commit"
  - "code"
  - "review"
  - "quality"
```

**Note:** Skills activate automatically based on file changes. Keywords are supplementary.

---

#### tools (required)
**Type:** Array of strings
**Description:** Tools the skill can use

**Available tools for skills:**
- `Read` - Read files
- `Write` - Create/overwrite files
- `Edit` - Modify existing files
- `Grep` - Search file contents
- `Glob` - Find files by pattern

**Important:** Skills have **limited tool access** for safety. No Bash or Task tools.

```yaml
tools:
  - "Read"
  - "Grep"
  - "Glob"
```

---

#### model (optional)
**Type:** String
**Description:** Claude model to use

**Available models:**
- `claude-sonnet-4` (default) - Fast, efficient
- `claude-opus-4` - Most capable

```yaml
model: "claude-sonnet-4"
```

---

#### enabled (optional)
**Type:** Boolean
**Description:** Enable/disable skill

```yaml
enabled: true  # Skill active
enabled: false # Skill inactive
```

---

#### priority (optional)
**Type:** String
**Description:** Execution priority

**Values:**
- `high` - Execute first
- `medium` - Default
- `low` - Execute last

```yaml
priority: "high"
```

---

#### file_patterns (optional)
**Type:** Array of glob patterns
**Description:** File types to monitor

```yaml
file_patterns:
  - "*.ts"
  - "*.tsx"
  - "*.js"
  - "*.jsx"
```

---

#### exclude_patterns (optional)
**Type:** Array of glob patterns
**Description:** Files to ignore

```yaml
exclude_patterns:
  - "node_modules/**"
  - "dist/**"
  - "*.test.ts"
```

---

### Example: Custom Skill Configuration

```yaml
---
name: "custom-reviewer"
description: "Custom code reviewer for React projects"
trigger_keywords:
  - "react"
  - "component"
  - "review"
tools:
  - "Read"
  - "Grep"
  - "Glob"
model: "claude-sonnet-4"
enabled: true
priority: "high"
file_patterns:
  - "*.tsx"
  - "*.jsx"
exclude_patterns:
  - "*.test.tsx"
  - "*.stories.tsx"
  - "node_modules/**"
custom_settings:
  max_file_size: "50kb"
  check_accessibility: true
  check_performance: true
---
```

---

## Agents Configuration

Agents can be configured using YAML frontmatter in `SKILL.md` or `agent.json`.

### Method 1: YAML Frontmatter (Recommended)

**File:** `~/.claude/agents/{agent-name}/SKILL.md`

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
  - "security-review"
  - "performance-optimization"
---
```

### Method 2: JSON Configuration

**File:** `~/.claude/agents/{agent-name}/agent.json`

```json
{
  "name": "code-reviewer",
  "description": "Expert code quality analyst",
  "tools": [
    "Read",
    "Write",
    "Edit",
    "Grep",
    "Glob",
    "Bash",
    "Task"
  ],
  "model": "claude-opus-4",
  "enabled": true,
  "capabilities": [
    "code-analysis",
    "security-review",
    "performance-optimization"
  ]
}
```

### Agent Configuration Fields

#### name (required)
**Type:** String
**Description:** Unique identifier (used with `@agent-name`)

```yaml
name: "code-reviewer"
```

---

#### description (required)
**Type:** String
**Description:** Agent's expertise and purpose

```yaml
description: "Expert code quality analyst with focus on security and performance"
```

---

#### tools (required)
**Type:** Array of strings
**Description:** Available tools

**All tools available for agents:**
- `Read`, `Write`, `Edit` - File operations
- `Grep`, `Glob` - Search operations
- `Bash` - Execute commands
- `Task` - Invoke other agents

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

#### model (optional)
**Type:** String
**Description:** Claude model

```yaml
model: "claude-opus-4"  # Most capable
model: "claude-sonnet-4" # Faster
```

---

#### enabled (optional)
**Type:** Boolean

```yaml
enabled: true
```

---

#### capabilities (optional)
**Type:** Array of strings
**Description:** Agent's specialized capabilities

```yaml
capabilities:
  - "code-analysis"
  - "security-review"
  - "performance-optimization"
  - "refactoring"
```

---

#### max_iterations (optional)
**Type:** Number
**Description:** Maximum tool use iterations

```yaml
max_iterations: 50
```

---

### Example: Custom Agent Configuration

```yaml
---
name: "custom-reviewer"
description: "Custom code reviewer for enterprise React applications"
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
  - "react-analysis"
  - "typescript-validation"
  - "security-audit"
  - "performance-profiling"
  - "accessibility-check"
max_iterations: 75
custom_settings:
  frameworks:
    - "React"
    - "Next.js"
  linting_rules: "airbnb"
  security_standards: "OWASP"
---
```

---

## Commands Configuration

Commands are configured in `~/.claude/commands/{command-category}/{command-name}/command.json`.

### Basic Command Configuration

```json
{
  "name": "review",
  "description": "Automated code review with quality checks",
  "category": "workflow",
  "usage": "/review --scope <files> --checks <types>",
  "parameters": {
    "scope": {
      "type": "string",
      "description": "Files to review (staged, all, or file path)",
      "required": false,
      "default": "staged"
    },
    "checks": {
      "type": "array",
      "description": "Check types: security, performance, quality, all",
      "required": false,
      "default": ["all"]
    }
  },
  "agents": [
    "@code-reviewer",
    "@security-auditor",
    "@performance-tuner"
  ],
  "enabled": true
}
```

### Command Configuration Fields

#### name (required)
**Type:** String
**Description:** Command name (used with `/command-name`)

```json
"name": "review"
```

---

#### description (required)
**Type:** String

```json
"description": "Automated code review with quality checks"
```

---

#### category (required)
**Type:** String
**Description:** Command category

**Categories:**
- `development` - Development workflows
- `workflow` - General workflows
- `testing` - Testing workflows
- `documentation` - Documentation workflows

```json
"category": "workflow"
```

---

#### usage (required)
**Type:** String
**Description:** Usage syntax

```json
"usage": "/review --scope <files> --checks <types>"
```

---

#### parameters (optional)
**Type:** Object
**Description:** Command parameters

```json
"parameters": {
  "scope": {
    "type": "string",
    "description": "Files to review",
    "required": false,
    "default": "staged"
  },
  "checks": {
    "type": "array",
    "description": "Check types",
    "required": false,
    "default": ["all"]
  }
}
```

**Parameter types:**
- `string` - Single value
- `array` - Multiple values
- `boolean` - True/false flag
- `number` - Numeric value

---

#### agents (optional)
**Type:** Array of strings
**Description:** Agents invoked by command

```json
"agents": [
  "@code-reviewer",
  "@security-auditor",
  "@performance-tuner"
]
```

---

#### enabled (optional)
**Type:** Boolean

```json
"enabled": true
```

---

### Example: Custom Command Configuration

```json
{
  "name": "full-audit",
  "description": "Comprehensive codebase audit with security and performance analysis",
  "category": "workflow",
  "usage": "/full-audit --path <directory> --report <format>",
  "parameters": {
    "path": {
      "type": "string",
      "description": "Directory to audit",
      "required": false,
      "default": "."
    },
    "report": {
      "type": "string",
      "description": "Report format: json, markdown, html",
      "required": false,
      "default": "markdown"
    },
    "include_tests": {
      "type": "boolean",
      "description": "Include test coverage analysis",
      "required": false,
      "default": true
    }
  },
  "agents": [
    "@code-reviewer",
    "@security-auditor",
    "@performance-tuner",
    "@test-engineer"
  ],
  "enabled": true,
  "timeout": 600,
  "output_directory": "./audit-reports"
}
```

---

## Environment Variables

Configure Claude Code Tresor behavior with environment variables:

```bash
# Set default model
export CLAUDE_CODE_DEFAULT_MODEL="claude-opus-4"

# Disable specific skill
export CLAUDE_CODE_DISABLE_SKILL_code_reviewer=true

# Set skill priority
export CLAUDE_CODE_SKILL_PRIORITY_security_auditor="high"

# Enable debug mode
export CLAUDE_CODE_DEBUG=true
```

---

## Advanced Configuration

### Custom Skill Triggers

Configure skill activation patterns:

```yaml
---
name: "api-documenter"
custom_triggers:
  file_save:
    - pattern: "src/api/**/*.ts"
      action: "generate_openapi"
  git_commit:
    - pattern: "src/controllers/*.ts"
      action: "update_api_docs"
---
```

---

### Agent Coordination

Configure how agents work together:

```yaml
---
name: "code-reviewer"
coordination:
  invoke_agents:
    - agent: "@security-auditor"
      when: "security_issue_detected"
    - agent: "@performance-tuner"
      when: "performance_issue_detected"
---
```

---

### Command Workflows

Configure multi-step command workflows:

```json
{
  "name": "deploy",
  "workflow": [
    {
      "step": "review",
      "command": "/review --scope all"
    },
    {
      "step": "test",
      "command": "/test-gen --coverage 90"
    },
    {
      "step": "build",
      "bash": "npm run build"
    },
    {
      "step": "deploy",
      "bash": "npm run deploy"
    }
  ]
}
```

---

## Configuration Best Practices

### 1. Start with Defaults
Don't over-configure initially. Use defaults and customize as needed.

### 2. Use YAML for Readability
YAML frontmatter is more readable than JSON for complex configurations.

### 3. Test Configuration Changes
After changes, verify with:
```bash
# Restart Claude Code
# Test skill/agent/command
```

### 4. Document Customizations
Add comments explaining why you changed defaults:

```yaml
---
name: "code-reviewer"
# Increased priority because we need immediate feedback
priority: "high"
# Added .vue files for Vue.js project
file_patterns:
  - "*.ts"
  - "*.vue"  # Vue.js components
---
```

### 5. Version Control Configuration
Commit configuration files to git for team consistency:

```bash
git add ~/.claude/skills/custom-reviewer/
git commit -m "feat: add custom code reviewer configuration"
```

---

## Troubleshooting Configuration

### Configuration Not Applied

**Problem:** Changes to configuration not taking effect

**Solution:**
1. Restart Claude Code CLI
2. Check syntax (YAML/JSON valid?)
3. Check file location (correct directory?)

---

### Skill Not Activating

**Problem:** Skill configured but not activating

**Solution:**
1. Check `enabled: true`
2. Verify `trigger_keywords` or `file_patterns`
3. Check `exclude_patterns` not blocking files
4. Enable debug mode: `export CLAUDE_CODE_DEBUG=true`

---

### Agent Not Found

**Problem:** `@agent-name not found`

**Solution:**
1. Check agent directory exists: `ls ~/.claude/agents/agent-name/`
2. Verify `name` field matches directory name
3. Check `enabled: true`

---

## Next Steps

- **[Skills Reference →](../reference/skills-reference.md)** - Complete skill configuration
- **[Agents Reference →](../reference/agents-reference.md)** - Complete agent configuration
- **[Commands Reference →](../reference/commands-reference.md)** - Complete command configuration
- **[Troubleshooting →](troubleshooting.md)** - Fix configuration issues

---

**Last Updated:** November 7, 2025 | **Version:** 2.0.0
