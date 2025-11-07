# Agent-Skill Integration Guide

> **How to enable agents to invoke skills for enhanced workflows**

**Created:** November 7, 2025
**Author:** Alireza Rezvani
**Status:** Production Ready

---

## Overview

This guide explains how to extend the Claude Code Tresor architecture so that **agents can invoke skills** during their work, creating a powerful multi-tier validation workflow.

### The Problem

Originally, skills were only available in the main conversation. When an agent was invoked (e.g., `@code-reviewer`), it ran in a separate context without access to skills.

### The Solution

Enable agents to invoke skills using the `Skill` tool with explicit instructions on **when** and **how** to use them.

---

## Architecture Pattern

### 3-Tier Workflow with Agent-Skill Integration

```
User Conversation
    │
    ├─> Tier 1: Skills (Quick checks during conversation)
    │   └─> Claude invokes: code-reviewer, test-generator, security-auditor
    │
    └─> Tier 2: Agents (Deep analysis with skill support)
        │
        ├─> @code-reviewer agent invoked
        │   └─> Agent invokes: security-auditor skill (quick scan)
        │   └─> Agent performs: Deep security analysis
        │   └─> Agent invokes: test-generator skill (coverage check)
        │   └─> Agent performs: Comprehensive review report
        │
        └─> Tier 3: Commands (Multi-agent orchestration)
            └─> /review command coordinates multiple agents
```

---

## Strategic Agent-Skill Pairing

Not all agents should invoke all skills. Strategic pairing maximizes efficiency:

### Recommended Pairings

| Agent | Should Invoke Skills | Status | Why? |
|-------|---------------------|--------|------|
| **code-reviewer** | security-auditor, test-generator | ✅ Phase 1 | Quick security/test scan before deep review |
| **test-engineer** | code-reviewer | ✅ Phase 1 | Validate code structure before creating tests |
| **security-auditor** | secret-scanner | ✅ Phase 1 | Quick secret detection before full audit |
| **debugger** | code-reviewer | ✅ Phase 1 | Check code quality of proposed fixes |
| **performance-tuner** | code-reviewer | ✅ Phase 2 | Validate patterns before optimization |
| **refactor-expert** | code-reviewer, test-generator | ✅ Phase 2 | Check quality and tests before refactoring |
| **docs-writer** | api-documenter, readme-updater | ✅ Phase 2 | Get structure before comprehensive docs |
| **architect** | ❌ None | N/A | High-level design doesn't need quick checks |

### Pairing Principles

1. **Skills provide quick initial scan** → Agent provides deep analysis
2. **Skills check obvious issues** → Agent identifies complex patterns
3. **Skills suggest basics** → Agent provides comprehensive solutions
4. **Complementary, not duplicate** → Focus on different aspects

---

## Implementation Steps

### Step 1: Add Skill Tool Access

Update agent YAML frontmatter to include `Skill` tool:

```yaml
---
name: code-reviewer
description: Expert code quality analysis...
tools: Read, Edit, Grep, Glob, Bash, Task, Skill  # Added Skill
model: inherit
---
```

### Step 2: Add "Working with Skills" Section

Add this section after the agent's role description:

```markdown
## Working with Skills

You have access to lightweight skills for quick validations BEFORE your deep analysis. Skills are complementary helpers, not replacements for your expert review.

### Available Skills

**1. [skill-name] skill**
- What it does
- When to use it
- **Invoke when:** Specific condition

**2. [another-skill] skill**
- What it does
- When to use it
- **Invoke when:** Specific condition

### When to Invoke Skills

**DO invoke skills at the START of your work for:**
- ✅ Quick validation before deep analysis
- ✅ Initial scan to identify obvious issues
- ✅ Understanding context

**DON'T invoke skills for:**
- ❌ Your core expertise areas
- ❌ Complex analysis requiring judgment
- ❌ Architectural decisions

### How to Invoke Skills

Use the Skill tool with skill name only (no arguments):

\`\`\`markdown
# At the START of your work:
[Invoke skill-name skill for quick scan]
[Review skill output]

# Then proceed with YOUR deep expert analysis
\`\`\`

### Workflow Pattern

\`\`\`
1. QUICK CHECKS (Skills)
   └─> Invoke relevant skills
   └─> Review skill outputs

2. DEEP ANALYSIS (You - Expert)
   └─> Build on skill findings
   └─> Identify issues skills missed
   └─> Provide comprehensive solutions

3. REPORT
   └─> Acknowledge skill findings
   └─> Add your expert insights
   └─> Deliver actionable recommendations
\`\`\`
```

### Step 3: Update Agent's Core Instructions

Ensure the agent's main workflow mentions skill usage:

```markdown
## Review Process

When invoked, follow this workflow:

1. **Context Gathering**: Understand the task
2. **Quick Validation**: Invoke relevant skills for initial scan
3. **Deep Analysis**: Your expert investigation (building on skill findings)
4. **Recommendations**: Comprehensive, actionable feedback
```

---

## Example: code-reviewer Agent

### Complete Implementation

```markdown
---
name: code-reviewer
description: Expert code quality analysis...
tools: Read, Edit, Grep, Glob, Bash, Task, Skill
model: inherit
---

You are an expert code reviewer...

## Working with Skills

You have access to lightweight skills for quick validations BEFORE your deep analysis.

### Available Skills

**1. security-auditor skill**
- Quick OWASP Top 10 vulnerability scan
- Secret/API key detection
- Basic security pattern checks
- **Invoke when:** Reviewing authentication, APIs, or user input handling

**2. test-generator skill**
- Detects untested code
- Suggests basic test structure
- Identifies missing test cases
- **Invoke when:** Code changes lack tests or test coverage is unclear

### When to Invoke Skills

**DO invoke skills at the START for:**
- ✅ Quick security validation
- ✅ Test coverage check
- ✅ Initial scan

**DON'T invoke for:**
- ❌ Architectural analysis (your expertise)
- ❌ Performance optimization (your domain)
- ❌ Complex refactoring (your comprehensive approach)

### How to Invoke

\`\`\`markdown
# At the START of your review:
[Invoke security-auditor skill]
[Invoke test-generator skill]

# Then YOUR deep analysis
\`\`\`

### Workflow Pattern

\`\`\`
1. QUICK CHECKS (Skills)
   └─> security-auditor
   └─> test-generator

2. DEEP ANALYSIS (You)
   └─> Build on findings
   └─> Expert recommendations

3. REPORT
   └─> Comprehensive review
\`\`\`
```

---

## Testing the Integration

### Test Case 1: code-reviewer with Skills

```bash
# Start Claude Code
claude

# Invoke agent
@code-reviewer Review src/api/auth.ts

# Expected behavior:
# 1. Agent invokes security-auditor skill (quick scan)
# 2. Agent reviews skill output
# 3. Agent performs deep security analysis
# 4. Agent provides comprehensive report

# Verify skill was invoked:
# - Agent output should mention "Security scan identified..."
# - Agent should build on skill findings with deeper context
```

### Test Case 2: test-engineer with Skills

```bash
claude

@test-engineer Create comprehensive tests for src/utils/validator.ts

# Expected behavior:
# 1. Agent invokes code-reviewer skill (check testability)
# 2. Agent designs comprehensive test strategy
# 3. Agent implements full test suite

# Verify:
# - Agent mentions code structure analysis
# - Tests go beyond basic scaffolding
```

---

## Rollout Plan

### Phase 1: Core Agents (Complete ✅)

- ✅ code-reviewer - security-auditor, test-generator
- ✅ test-engineer - code-reviewer
- ✅ security-auditor - secret-scanner
- ✅ debugger - code-reviewer

### Phase 2: Performance, Refactoring & Documentation (Complete ✅)

- ✅ performance-tuner - code-reviewer
- ✅ refactor-expert - code-reviewer, test-generator
- ✅ docs-writer - api-documenter, readme-updater

### Phase 3: Extended Library (Future)

- Apply pattern to sources/ directory agents (80+ additional agents)
- Custom agent-skill pairings per domain

---

## Best Practices

### DO

✅ **Invoke skills at the START** of agent work for quick validation
✅ **Build on skill findings** with deeper context and expertise
✅ **Acknowledge skill outputs** in your final report
✅ **Use skills for their strength** - quick, obvious issue detection
✅ **Provide complementary analysis** - what skills cannot detect

### DON'T

❌ **Rely only on skills** - your deep analysis is the value
❌ **Duplicate skill work** - focus on what they missed
❌ **Invoke skills mid-workflow** - use at START only
❌ **Over-invoke** - only use relevant skills for the task
❌ **Replace your expertise** - skills are helpers, not replacements

---

## Troubleshooting

### Skill Not Available in Agent

**Problem:** Agent tries to invoke skill but gets error

**Check:**
1. Agent frontmatter includes `Skill` in tools list
2. Skill is installed: `ls ~/.claude/skills/`
3. Skill name is correct (e.g., `security-auditor` not `security-audit`)

### Agent Doesn't Invoke Skill

**Problem:** Agent doesn't use skill even though instructed

**Fix:**
1. Make instructions more explicit in "How to Invoke" section
2. Add example in "Workflow Pattern" showing exact invocation
3. Ensure agent prompt emphasizes using skills at START

### Skill Invocation Loops

**Problem:** Agent invokes skill, skill invokes agent, infinite loop

**Prevention:**
- Skills should NEVER invoke agents
- Skills have limited tools: Read, Write, Edit, Grep, Glob (no Task tool)
- Agents invoke skills, not the reverse

---

## Maintenance

### When Adding New Skills

1. Identify which agents would benefit
2. Update agent frontmatter with `Skill` tool
3. Add skill to agent's "Available Skills" section
4. Update "When to Invoke" guidelines
5. Test the integration
6. Document in this guide

### When Creating New Agents

1. Consider if agent needs skill access
2. Identify 1-2 complementary skills
3. Follow implementation steps above
4. Add to "Strategic Agent-Skill Pairing" table

---

## Summary

**Agent-skill integration creates powerful multi-tier validation:**

1. **Skills** → Quick, lightweight checks (5-10 seconds)
2. **Agents** → Deep, expert analysis building on skill findings (2-5 minutes)
3. **Commands** → Multi-agent orchestration for complex workflows (10-30 minutes)

**Result:** Faster, more comprehensive code quality validation with layered depth.

---

## Related Documentation

- [ARCHITECTURE.md](../ARCHITECTURE.md) - 3-tier system overview
- [skills/README.md](../skills/README.md) - Skills documentation
- [agents/README.md](../agents/README.md) - Agents documentation
- [GETTING-STARTED.md](../GETTING-STARTED.md) - Getting started guide

---

**Questions or suggestions?** Open an issue on GitHub.
