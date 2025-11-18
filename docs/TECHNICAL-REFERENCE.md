# Claude Code Tresor - Technical Reference

> **Developer and contributor reference for agent format, standards, and validation**
>
> **Version**: 2.6.0 | **Last Updated**: November 15, 2025

---

## Table of Contents

1. [Agent Format Specification](#agent-format-specification)
2. [YAML Frontmatter Requirements](#yaml-frontmatter-requirements)
3. [Content Quality Standards](#content-quality-standards)
4. [Validation Criteria](#validation-criteria)
5. [Color System](#color-system)
6. [Contributing Guidelines](#contributing-guidelines)

---

## Agent Format Specification

### Directory Structure

```
subagents/{category}/{subcategory}/{agent-name}/
├── agent.md (required)
└── README.md (optional)
```

### Standard Template

```markdown
---
name: "agent-name"
description: "Clear description (50-300 chars)"
category: "category-name"
team: "team-name"
color: "#HEX_CODE"
subcategory: "subcategory"
tools: [Read, Write, Edit, Grep, Glob, Bash, Task]
model: claude-opus-4
enabled: true
capabilities:
  - "Capability 1"
  - "Capability 2"
  - "Capability 3"
  - "Capability 4"
max_iterations: 50
---

## Identity & Operating Principles
## Focus Areas
## Approach
## Output
## Usage Examples
## Integration Tips
```

---

## YAML Frontmatter Requirements

### Required Fields (9)

| Field | Type | Format | Example |
|-------|------|--------|---------|
| name | string | kebab-case, 3-25 chars | "systems-architect" |
| description | string | 50-300 chars | "Expert system architect..." |
| category | string | Valid category | "engineering" |
| team | string | Matches category | "engineering" |
| color | string | Hex code | "#3B82F6" |
| tools | array | Valid tools | [Read, Write, Edit] |
| model | string | claude-opus-4 | "claude-opus-4" |
| enabled | boolean | true/false | true |
| capabilities | array | 4 strings | ["Cap 1", "Cap 2"] |

### Valid Categories

core, engineering, design, marketing, product, leadership, operations, research, ai-automation, account-customer-success

### Valid Tools

Read, Write, Edit, Grep, Glob, Bash, Task, Skill, WebFetch, WebSearch, TodoWrite

---

## Content Quality Standards

### Quality Scoring (0-10)

**Score Calculation**:
- Required sections: +2
- Content completeness: +2
- Example quality: +2
- Integration tips: +1
- Related agents: +1
- Best practices: +1
- Common pitfalls: +1

**Ratings**:
- 9-10: Excellent (production-ready)
- 7-8: Good (minor enhancements)
- 5-6: Acceptable (improvements needed)
- <5: Needs work

### Current Repository Quality: 9.7/10

---

## Validation Criteria

**All 4 Validation Tiers**:

1. YAML Frontmatter: 100% pass required
2. Content Quality: 7.0/10 minimum
3. Organization: 100% correct categorization
4. Cross-References: All links must work

**v2.6.0 Results**: 100%, 9.7/10, 100%, 100% ✅

---

## Color System

| Category | Color | Hex |
|----------|-------|-----|
| Core | Gold | #FFD700 |
| Engineering | Blue | #3B82F6 |
| Design | Magenta | #EC4899 |
| Marketing | Green | #10B981 |
| Product | Purple | #8B5CF6 |
| Leadership | Gold | #F59E0B |
| Operations | Teal | #14B8A6 |
| Research | Orange | #F97316 |
| AI/Automation | Indigo | #6366F1 |
| Account/CS | Cyan | #06B6D4 |

---

## Contributing Guidelines

### Quality Requirements

- Minimum quality score: 7.0/10
- All required YAML fields
- 2+ usage examples
- Clear focus areas and approach
- No placeholder text

### Submission Process

1. Create agent using template
2. Validate all fields
3. Test examples
4. Submit PR with quality score
5. Maintain after feedback

---

**See Also**:
- [Agent Library Guide](AGENT-LIBRARY-GUIDE.md)
- [Anthropic Official Docs](https://docs.anthropic.com/claude-code/sub-agents)

**Version**: 2.6.0
