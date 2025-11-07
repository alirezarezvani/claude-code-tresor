# Contributing Guide

Thank you for contributing to Claude Code Tresor! This guide covers everything you need to know.

## How to Contribute

### Ways to Contribute

1. **Report Bugs** - Found an issue? Let us know
2. **Suggest Features** - Have an idea? We'd love to hear it
3. **Improve Documentation** - Help others learn
4. **Create Skills** - Add new autonomous helpers
5. **Create Agents** - Add specialized experts
6. **Create Commands** - Add workflow automation
7. **Share Prompts** - Contribute useful templates
8. **Fix Bugs** - Submit pull requests
9. **Review PRs** - Help review contributions

---

## Getting Started

### 1. Fork and Clone

```bash
# Fork repository on GitHub
# Then clone your fork
git clone https://github.com/YOUR_USERNAME/claude-code-tresor.git
cd claude-code-tresor

# Add upstream remote
git remote add upstream https://github.com/alirezarezvani/claude-code-tresor.git
```

---

### 2. Create a Branch

```bash
# Update main branch
git checkout main
git pull upstream main

# Create feature branch
git checkout -b feature/my-new-skill

# Or for bug fixes
git checkout -b fix/issue-123
```

---

### 3. Make Changes

Follow the appropriate guide below:
- [Creating a Skill](#creating-a-skill)
- [Creating an Agent](#creating-an-agent)
- [Creating a Command](#creating-a-command)
- [Improving Documentation](#improving-documentation)

---

### 4. Test Your Changes

```bash
# Install your changes locally
./scripts/install.sh

# Test the skill/agent/command
# Restart Claude Code and verify it works

# Run validation (if available)
./scripts/validate.sh
```

---

### 5. Commit Changes

Use conventional commits:

```bash
# Add files
git add .

# Commit with conventional commit format
git commit -m "feat(skills): add custom-linter skill"
git commit -m "fix(agents): resolve code-reviewer timeout issue"
git commit -m "docs: improve installation guide"
```

**Commit Types:**
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation only
- `style:` Formatting, no code change
- `refactor:` Code restructuring
- `test:` Adding tests
- `chore:` Maintenance

---

### 6. Push and Create PR

```bash
# Push to your fork
git push origin feature/my-new-skill

# Create Pull Request on GitHub
# Fill out PR template completely
```

---

## Creating a Skill

### Skill Structure

```bash
skills/
└── category/              # development, security, documentation
    └── skill-name/
        ├── SKILL.md       # Configuration + documentation
        └── README.md      # Quick reference
```

---

### Step 1: Create Skill Directory

```bash
# Choose category: development, security, or documentation
mkdir -p skills/development/my-custom-skill
cd skills/development/my-custom-skill
```

---

### Step 2: Create SKILL.md

```yaml
---
name: "my-custom-skill"
description: "Brief description of what skill does"
trigger_keywords:
  - "keyword1"
  - "keyword2"
  - "keyword3"
tools:
  - "Read"
  - "Write"
  - "Edit"
  - "Grep"
  - "Glob"
model: "claude-sonnet-4"
enabled: true
priority: "medium"
file_patterns:
  - "*.ts"
  - "*.tsx"
exclude_patterns:
  - "node_modules/**"
  - "dist/**"
---

# My Custom Skill

## Purpose

Explain what this skill does and why it's useful.

## Behavior

Describe how the skill works:
- When it activates
- What it checks
- What suggestions it provides

## Examples

### Example 1: Basic Usage

**Scenario:** User saves file with issue

**Skill Response:**
\`\`\`
⚠️ Issue detected: [description]
Suggestion: [fix]
\`\`\`

### Example 2: Advanced Usage

[More examples]

## Configuration

Explain any custom configuration options.

## Integration

How this skill works with other skills/agents.

## Limitations

Known limitations or edge cases.
```

---

### Step 3: Create README.md

```markdown
# My Custom Skill

Quick reference for my-custom-skill.

## What It Does

One sentence description.

## When It Activates

- Trigger condition 1
- Trigger condition 2

## Example

\`\`\`
[Quick example]
\`\`\`

## Configuration

\`\`\`yaml
---
name: "my-custom-skill"
enabled: true
---
\`\`\`

## See Also

- [Complete Documentation →](SKILL.md)
- [Skills Reference →](../../documentation/reference/skills-reference.md)
```

---

### Step 4: Test Skill

```bash
# Install skill
mkdir -p ~/.claude/skills/my-custom-skill
cp -r skills/development/my-custom-skill/* ~/.claude/skills/my-custom-skill/

# Restart Claude Code
claude

# Test skill activation
# Create scenario that should trigger skill
# Verify skill provides expected suggestions
```

---

### Step 5: Document Skill

Add to `documentation/reference/skills-reference.md`:

```markdown
### my-custom-skill

**Category:** Development
**Purpose:** Brief description

**Triggers:**
- When X happens
- When Y happens

**Example:**
\`\`\`
[Quick example]
\`\`\`

**[Full Documentation →](../../skills/development/my-custom-skill/SKILL.md)**
```

---

## Creating an Agent

### Agent Structure

```bash
agents/
└── agent-name/
    ├── SKILL.md       # Configuration + documentation
    └── README.md      # Quick reference
```

---

### Step 1: Create Agent Directory

```bash
mkdir -p agents/my-custom-agent
cd agents/my-custom-agent
```

---

### Step 2: Create SKILL.md

```yaml
---
name: "my-custom-agent"
description: "Expert in [domain]"
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
  - "capability1"
  - "capability2"
max_iterations: 50
---

# My Custom Agent

## Expertise

What this agent specializes in.

## Capabilities

Detailed list of what agent can do:
1. Capability 1 - explanation
2. Capability 2 - explanation

## Usage

### Basic Invocation

\`\`\`
@my-custom-agent analyze this component
\`\`\`

### Advanced Invocation

\`\`\`
@my-custom-agent
Context: [provide context]
Task: [specific task]
Focus: [what to focus on]
\`\`\`

## Examples

### Example 1: [Use Case]

**Invocation:**
\`\`\`
@my-custom-agent [specific request]
\`\`\`

**Response:**
\`\`\`
[Expected agent response]
\`\`\`

## Best Practices

How to get best results from this agent.

## Limitations

Known limitations.
```

---

### Step 3: Create README.md

```markdown
# My Custom Agent

Quick reference for @my-custom-agent.

## Expertise

One sentence description.

## Usage

\`\`\`
@my-custom-agent analyze [file/component]
\`\`\`

## Common Tasks

- Task 1: `@my-custom-agent [invocation]`
- Task 2: `@my-custom-agent [invocation]`

## See Also

- [Complete Documentation →](SKILL.md)
- [Agents Reference →](../../documentation/reference/agents-reference.md)
```

---

### Step 4: Test Agent

```bash
# Install agent
mkdir -p ~/.claude/agents/my-custom-agent
cp -r agents/my-custom-agent/* ~/.claude/agents/my-custom-agent/

# Restart Claude Code
claude

# Test agent invocation
@my-custom-agent test task

# Verify agent:
# 1. Invokes successfully
# 2. Uses tools correctly
# 3. Provides valuable output
```

---

## Creating a Command

### Command Structure

```bash
commands/
└── category/              # development, workflow, testing, documentation
    └── command-name/
        ├── command.json   # Configuration
        └── README.md      # Documentation
```

---

### Step 1: Create Command Directory

```bash
# Choose category
mkdir -p commands/workflow/my-custom-command
cd commands/workflow/my-custom-command
```

---

### Step 2: Create command.json

```json
{
  "name": "my-custom-command",
  "description": "Brief description of command",
  "category": "workflow",
  "usage": "/my-custom-command --param1 <value> --param2 <value>",
  "parameters": {
    "param1": {
      "type": "string",
      "description": "Description of param1",
      "required": true
    },
    "param2": {
      "type": "array",
      "description": "Description of param2",
      "required": false,
      "default": ["default1", "default2"]
    }
  },
  "agents": [
    "@agent1",
    "@agent2"
  ],
  "enabled": true,
  "timeout": 300
}
```

---

### Step 3: Create README.md

```markdown
# /my-custom-command

Command description.

## Usage

\`\`\`
/my-custom-command --param1 <value> --param2 <value>
\`\`\`

## Parameters

- `--param1` (required) - Description
- `--param2` (optional) - Description (default: value)

## Examples

### Example 1: Basic Usage

\`\`\`
/my-custom-command --param1 value
\`\`\`

### Example 2: Advanced Usage

\`\`\`
/my-custom-command --param1 value --param2 val1,val2,val3
\`\`\`

## Workflow

What this command does step-by-step:
1. Step 1
2. Step 2
3. Step 3

## Agents Used

- `@agent1` - For task X
- `@agent2` - For task Y

## See Also

- [Commands Reference →](../../documentation/reference/commands-reference.md)
```

---

### Step 4: Test Command

```bash
# Install command
mkdir -p ~/.claude/commands/my-custom-command
cp -r commands/workflow/my-custom-command/* ~/.claude/commands/my-custom-command/

# Restart Claude Code
claude

# Test command
/my-custom-command --param1 test

# Verify:
# 1. Command recognized
# 2. Parameters validated
# 3. Workflow executes correctly
# 4. Output as expected
```

---

## Improving Documentation

### Documentation Structure

```bash
documentation/
├── guides/           # User guides
├── reference/        # Technical reference
├── workflows/        # Workflow documentation
└── archive/          # Archived documentation
```

---

### Making Documentation Changes

```bash
# Create branch
git checkout -b docs/improve-installation-guide

# Edit documentation
vi documentation/guides/installation.md

# Test links work
# Check formatting renders correctly

# Commit
git commit -m "docs: improve installation guide clarity"

# Push and create PR
git push origin docs/improve-installation-guide
```

---

## Code Standards

### YAML Style

```yaml
---
name: "skill-name"           # Always quoted
description: "Description"    # Always quoted
tools:                       # 2-space indentation
  - "Read"                   # Array items quoted
  - "Write"
enabled: true                # Boolean unquoted
priority: "high"             # String quoted
---
```

---

### JSON Style

```json
{
  "name": "command-name",
  "description": "Description",
  "parameters": {
    "param1": {
      "type": "string",
      "required": true
    }
  }
}
```

**Rules:**
- 2-space indentation
- Double quotes only
- No trailing commas
- Validate with `python -m json.tool`

---

### Markdown Style

```markdown
# Main Title

## Section Title

### Subsection Title

**Bold** for emphasis
*Italic* for terms

- Unordered list item
  - Nested item

1. Ordered list item
2. Second item

\`inline code\`

\`\`\`language
code block
\`\`\`

[Link text](url)
```

---

## Testing Requirements

### Skill Testing

- [ ] Skill activates on expected triggers
- [ ] Skill provides accurate suggestions
- [ ] Skill doesn't activate on excluded files
- [ ] Configuration fields work as documented
- [ ] No conflicts with existing skills

---

### Agent Testing

- [ ] Agent invokes successfully with `@agent-name`
- [ ] Agent uses tools correctly
- [ ] Agent provides valuable output
- [ ] Agent handles errors gracefully
- [ ] Configuration fields work as documented

---

### Command Testing

- [ ] Command invokes successfully with `/command-name`
- [ ] Parameters validated correctly
- [ ] Workflow executes as expected
- [ ] Agents invoked correctly
- [ ] Error handling works
- [ ] Help text accurate (`/command-name --help`)

---

### Documentation Testing

- [ ] All links work
- [ ] Code examples accurate
- [ ] Formatting renders correctly
- [ ] Technical accuracy verified
- [ ] No typos or grammar errors

---

## Pull Request Process

### PR Title Format

```
<type>(<scope>): <description>

Examples:
feat(skills): add custom-linter skill
fix(agents): resolve code-reviewer timeout
docs: improve installation guide
refactor(commands): simplify review command workflow
```

---

### PR Description Template

```markdown
## Description

Brief description of changes.

## Type of Change

- [ ] New skill
- [ ] New agent
- [ ] New command
- [ ] Bug fix
- [ ] Documentation
- [ ] Other (specify)

## Checklist

- [ ] Followed contribution guidelines
- [ ] Tested changes locally
- [ ] Updated documentation
- [ ] Added examples
- [ ] Conventional commits used
- [ ] All tests passing

## Additional Context

Any additional information, screenshots, or context.
```

---

### Review Process

1. **Automated Checks** - CI runs validation
2. **Maintainer Review** - Code quality, standards
3. **Testing** - Functionality verification
4. **Feedback** - Requested changes if needed
5. **Approval** - Merged when ready

**Timeline:** Most PRs reviewed within 48 hours.

---

## Code of Conduct

### Our Standards

- **Respectful** - Treat everyone with respect
- **Inclusive** - Welcome diverse perspectives
- **Constructive** - Provide helpful feedback
- **Collaborative** - Work together effectively

### Unacceptable Behavior

- Harassment or discrimination
- Trolling or insulting comments
- Personal or political attacks
- Publishing others' private information
- Other unprofessional conduct

**Report Issues:** [Contact maintainer](mailto:rezvani@gmail.com)

---

## Getting Help

**Questions about contributing?**
- **[GitHub Discussions →](https://github.com/alirezarezvani/claude-code-tresor/discussions)** - Ask questions
- **[Existing Issues →](https://github.com/alirezarezvani/claude-code-tresor/issues)** - Check for similar work

**Need guidance?**
- **[Configuration Guide →](configuration.md)** - Learn configuration
- **[Skills Reference →](../reference/skills-reference.md)** - Skill examples
- **[Agents Reference →](../reference/agents-reference.md)** - Agent examples

---

## Recognition

Contributors are recognized in:
- **[CONTRIBUTORS.md](../../CONTRIBUTORS.md)** - All contributors listed
- **Release Notes** - Significant contributions mentioned
- **GitHub Contributors** - Automatic GitHub recognition

---

## License

By contributing, you agree that your contributions will be licensed under the **MIT License**.

---

**Thank you for contributing to Claude Code Tresor!**

---

**Last Updated:** November 7, 2025 | **Version:** 2.0.0
