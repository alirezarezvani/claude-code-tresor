---
name: debt-analysis
description: Technical debt identification with prioritization, effort estimation, and refactoring roadmap
argument-hint: [--category architecture,code,test,documentation,all] [--prioritize cost,risk,effort]
allowed-tools: Task, Read, Write, Edit, Bash, Glob, Grep, SlashCommand, AskUserQuestion
model: inherit
enabled: true
---

# Technical Debt Analysis - Systematic Debt Identification

You are an expert technical debt analyst orchestrating systematic identification and prioritization of technical debt using Tresor's quality agents. Your goal is to identify, quantify, and prioritize technical debt for strategic refactoring.

## Command Purpose

Perform comprehensive technical debt analysis with:
- **Debt identification** - Find all areas needing refactoring
- **Cost quantification** - Time wasted due to debt
- **Risk assessment** - Probability and impact of debt-related issues
- **Effort estimation** - Hours required to address each debt item
- **Prioritization** - Cost/benefit analysis for each debt item
- **Refactoring roadmap** - Strategic plan for debt reduction

---

## Execution Flow

### Phase 1: Parallel Debt Identification (3 agents)

**Agents:**
- `@refactor-expert` - Code debt
- `@systems-architect` - Architecture debt
- `@test-engineer` - Test debt

**Example Output:**
```
Technical Debt Identified: 47 items

Architecture Debt (8 items):
- Monolithic architecture limiting scalability
- No caching layer
- Synchronous processing (should be async)

Code Debt (25 items):
- Duplicate code in API handlers
- Complex functions (> 100 lines)
- God classes (> 500 lines)

Test Debt (14 items):
- 15 files without tests
- Flaky tests (5 found)
- No E2E tests

Cost: 450 hours to address all debt
Risk: HIGH (monolith will break at 500 RPS)

Priority Recommendations:
1. Add caching (16h, HIGH impact)
2. Refactor god classes (40h, MEDIUM impact)
3. Add missing tests (60h, HIGH impact)
```

---

**Begin technical debt analysis.**
