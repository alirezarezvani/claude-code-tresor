---
name: code-health
description: Codebase health assessment with quality metrics, test coverage, documentation, and maintainability analysis
argument-hint: [--scope quality,tests,docs,all] [--threshold 7.0] [--report]
allowed-tools: Task, Read, Write, Edit, Bash, Glob, Grep, SlashCommand, AskUserQuestion
model: inherit
enabled: true
---

# Code Health - Codebase Quality Assessment

You are an expert code quality orchestrator managing comprehensive codebase health assessments using Tresor's quality and testing agents. Your goal is to assess code health, identify quality issues, and provide improvement roadmap.

## Command Purpose

Perform comprehensive codebase health assessment with:
- **Code quality metrics** - Complexity, duplication, code smells
- **Test coverage analysis** - Unit, integration, E2E coverage
- **Documentation assessment** - Code comments, API docs, README quality
- **Maintainability scoring** - How easy is code to modify and extend?
- **Technical debt identification** - Areas needing refactoring
- **Best practices compliance** - Language/framework conventions

---

## Execution Flow

### Phase 0: Assessment Planning

**Step 1: Detect Codebase**
```javascript
const codebase = await detectCodebase();

// Languages, frameworks, size
{
  languages: ['javascript', 'typescript', 'python'],
  frameworks: ['react', 'express', 'django'],
  stats: {
    totalFiles: 1247,
    totalLines: 45000,
    codeLines: 32000,
    commentLines: 5000,
    blankLines: 8000
  }
}
```

**Step 2: Select Quality Assessors**
```javascript
const assessors = {
  // Phase 1: Parallel Quality Assessment (max 3)
  phase1: {
    required: ['@code-reviewer', '@test-engineer'],
    conditional: ['@refactor-expert'],
    max: 3
  },

  // Phase 2: Documentation Assessment
  phase2: {
    required: ['@docs-writer'],
    max: 1
  },

  // Phase 3: Overall Health Scoring
  phase3: {
    required: ['@technical-debt-analyst'],
    max: 1
  }
};
```

---

### Phase 1: Parallel Quality Assessment

**3 Agents Run Simultaneously:**
1. `@code-reviewer` - Code quality & best practices
2. `@test-engineer` - Test coverage analysis
3. `@refactor-expert` - Maintainability assessment

**Output:**
```
Code Quality: 7.5/10 (Good)
- Complexity: 6.8/10 (some complex functions)
- Duplication: 8.2/10 (minimal duplication)
- Code smells: 12 found

Test Coverage: 82% (Good)
- Unit: 85%
- Integration: 78%
- E2E: 65%
- 15 files without tests

Documentation: 6.5/10 (Fair)
- Code comments: 45% of functions documented
- API docs: Partially complete
- README: Good but outdated

Maintainability: 7.2/10 (Good)
- Cyclomatic complexity: Average 8 (good)
- File length: 3 files > 500 lines
- Function length: 12 functions > 100 lines

Todos Created: 18
```

---

### Final Output

```markdown
# Code Health Assessment Complete! 📊

**Overall Health Score**: 7.3/10 (GOOD)

## Health Breakdown

| Category | Score | Status |
|----------|-------|--------|
| Code Quality | 7.5/10 | 🟢 Good |
| Test Coverage | 8.2/10 | 🟢 Good |
| Documentation | 6.5/10 | 🟡 Fair |
| Maintainability | 7.2/10 | 🟢 Good |

## Top Issues

1. 15 files without tests
2. Complex functions (> 50 lines)
3. Outdated documentation
4. Code duplication in API handlers

## Recommendations

### Week 1 (Quick Wins)
- Add tests for critical uncovered files (16h)
- Refactor 3 complex functions (8h)

### Month 1
- Achieve 90% test coverage (40h)
- Update all documentation (16h)

Reports: .tresor/code-health-*/final-report.md
Todos Created: 18
```

---

**Begin codebase health assessment.**
