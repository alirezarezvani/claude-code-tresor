# `/code-health` - Codebase Health Assessment

> Comprehensive quality metrics with test coverage, documentation, and maintainability analysis

**Version:** 2.7.0
**Category:** Quality / Code Analysis
**Type:** Orchestration Command
**Estimated Duration:** 20-40 minutes

---

## Overview

The `/code-health` command performs comprehensive codebase health assessment across multiple quality dimensions - code quality, test coverage, documentation completeness, and maintainability. It provides a 0-10 health score with actionable improvement recommendations.

---

## Key Features

- ✅ **Multi-Dimensional Assessment** - Quality, tests, docs, maintainability
- ✅ **Health Score (0-10)** - Overall codebase health rating
- ✅ **Intelligent Analysis** - Auto-detects languages and frameworks
- ✅ **Actionable Recommendations** - Prioritized by impact
- ✅ **Trend Tracking** - Compare health over time
- ✅ **Best Practices Compliance** - Language/framework conventions

---

## Quick Start

```bash
# Full health assessment
/code-health

# Specific scope
/code-health --scope quality,tests
/code-health --scope documentation

# Quick assessment (skip deep analysis)
/code-health --quick
```

---

## What Gets Assessed

### 1. Code Quality (Weight: 30%)
- Cyclomatic complexity (target: < 10 per function)
- Code duplication (target: < 5%)
- Code smells (long functions, god classes)
- Naming conventions
- File organization

### 2. Test Coverage (Weight: 30%)
- Unit test coverage (target: ≥ 80%)
- Integration test coverage
- E2E test coverage (if applicable)
- Files without tests
- Test quality (assertions, edge cases)

### 3. Documentation (Weight: 20%)
- Code comments (target: 50% of functions)
- API documentation completeness
- README quality
- Inline documentation
- Architecture diagrams

### 4. Maintainability (Weight: 20%)
- File length (target: < 300 lines per file)
- Function length (target: < 50 lines per function)
- Dependency count
- Coupling/cohesion
- SOLID principles adherence

---

## Example Output

```
Code Health Assessment Complete! 📊

Overall Health Score: 7.3/10 (GOOD)

Breakdown:
- Code Quality: 7.5/10 🟢
- Test Coverage: 8.2/10 🟢
- Documentation: 6.5/10 🟡
- Maintainability: 7.2/10 🟢

Top Issues:
1. 15 files without tests
2. 3 files > 500 lines (god classes)
3. 45% of functions lack documentation
4. 12 complex functions (complexity > 15)

Quick Wins (16 hours):
- Add tests for critical files (8h)
- Refactor 3 god classes (8h)

Expected Improvement: 7.3 → 8.5 (+1.2 points)
```

---

## Integration with Tresor Workflow

### Automatic `/todo-add`
```bash
# Quality issues → todos
/todo-add "Tests: Add unit tests for src/api/users.ts (0% coverage)"
/todo-add "Refactor: Split UserService.ts (847 lines) into smaller modules"
```

### Automatic `/prompt-create`
```bash
# Complex refactoring → expert prompts
/prompt-create "Refactor god class UserService into smaller SOLID-compliant modules"
```

### `/debt-analysis` Integration
```bash
# After code-health, deep-dive into technical debt
/code-health
# → Health: 7.3/10, several issues found

/debt-analysis
# → Quantifies cost of issues, prioritizes by ROI
```

---

## Command Options

### `--scope`
```bash
/code-health --scope quality        # Code quality only
/code-health --scope tests          # Test coverage only
/code-health --scope docs           # Documentation only
/code-health --scope all            # All dimensions (default)
```

### `--threshold`
```bash
/code-health --threshold 8.0   # Stricter threshold (default: 7.0)
/code-health --threshold 6.0   # More lenient threshold
```

### `--quick`
```bash
/code-health --quick
# Fast assessment (15-20 min):
# - Surface-level metrics
# - Skip deep analysis
# - Suitable for CI/CD
```

---

## Recommended Frequency

- **Weekly:** Quick health check (`--quick`)
- **Monthly:** Full assessment (default)
- **Before releases:** Full assessment with high threshold
- **After major refactors:** Verify improvements

---

## FAQ

### Q: What's a good health score?

**A:**
- **9.0-10.0:** Excellent (production-ready, well-maintained)
- **7.0-8.9:** Good (acceptable, minor improvements needed)
- **5.0-6.9:** Fair (needs attention, plan improvements)
- **< 5.0:** Poor (urgent refactoring needed)

### Q: How do I improve my health score?

**A:** Focus on quick wins first:
1. Add missing tests (highest impact)
2. Refactor god classes (split into modules)
3. Document public APIs
4. Reduce cyclomatic complexity

Use `/debt-analysis` to prioritize by ROI.

---

## See Also

- **[/debt-analysis](../debt-analysis/)** - Technical debt identification
- **[/profile](../../performance/profile/)** - Performance profiling
- **[Refactor Expert Agent](../../../subagents/core/refactor-expert/)** - Code refactoring specialist

---

**Version:** 2.7.0
**Last Updated:** November 19, 2025
**Category:** Quality
**License:** MIT
**Author:** Alireza Rezvani
