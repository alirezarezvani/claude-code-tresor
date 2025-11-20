# `/debt-analysis` - Technical Debt Identification

> Strategic technical debt analysis with cost quantification, risk assessment, and ROI-based prioritization

**Version:** 2.7.0
**Category:** Quality / Technical Debt
**Type:** Orchestration Command
**Estimated Duration:** 30-60 minutes

---

## Overview

The `/debt-analysis` command performs systematic technical debt identification and quantification. It analyzes architecture, code, tests, and documentation to identify debt items, calculates the cost of each debt (time wasted), assesses risks, and provides ROI-based prioritization for strategic refactoring.

---

## Key Features

- ✅ **Multi-Category Debt Identification** - Architecture, code, test, documentation debt
- ✅ **Cost Quantification** - Time wasted per debt item (hours/month)
- ✅ **Risk Assessment** - Probability and impact of debt-related issues
- ✅ **Effort Estimation** - Hours required to address each debt
- ✅ **ROI Prioritization** - Cost/benefit analysis for refactoring decisions
- ✅ **Strategic Roadmap** - Phased debt reduction plan

---

## Quick Start

```bash
# Full debt analysis
/debt-analysis

# Specific categories
/debt-analysis --category architecture
/debt-analysis --category code,test

# Prioritize by different criteria
/debt-analysis --prioritize cost     # Highest time waste first
/debt-analysis --prioritize risk     # Highest risk first
/debt-analysis --prioritize effort   # Easiest wins first
```

---

## What Gets Analyzed

### 1. Architecture Debt
- Monolithic architecture limiting scalability
- Missing caching layers
- Synchronous processing (should be async)
- Tight coupling between modules
- No service boundaries

### 2. Code Debt
- Duplicate code (copy-paste programming)
- God classes (> 500 lines)
- Long functions (> 100 lines)
- High cyclomatic complexity (> 15)
- Code smells (primitive obsession, feature envy)

### 3. Test Debt
- Files without tests
- Low test coverage (< 80%)
- Flaky tests
- No integration/E2E tests
- Slow test suites

### 4. Documentation Debt
- Undocumented APIs
- Outdated documentation
- Missing architecture diagrams
- No runbooks for operations
- Incomplete README

---

## Example Output

```
Technical Debt Analysis Complete! 💰

Total Debt: 47 items
Estimated Cost: 450 hours to address all debt
Time Wasted: ~120 hours/month due to debt

Debt by Category:
- Architecture: 8 items (180 hours cost, 60 hours/month wasted)
- Code: 25 items (180 hours cost, 40 hours/month wasted)
- Test: 14 items (90 hours cost, 20 hours/month wasted)
- Documentation: Not assessed

Top 5 Debt Items (by ROI):

1. Add Caching Layer (Architecture)
   - Cost: ~60 hours/month wasted (slow API responses)
   - Effort: 16 hours to implement
   - Risk: HIGH (will break at 500 RPS)
   - ROI: 3.75 hours saved per hour invested
   - Priority: CRITICAL

2. Refactor UserService God Class (Code)
   - Cost: ~15 hours/month wasted (hard to modify)
   - Effort: 40 hours to refactor
   - Risk: MEDIUM (change amplification)
   - ROI: 0.375 hours saved per hour invested
   - Priority: HIGH

3. Add Missing Tests (15 files) (Test)
   - Cost: ~20 hours/month wasted (manual testing)
   - Effort: 60 hours to write tests
   - Risk: HIGH (bugs in production)
   - ROI: 0.33 hours saved per hour invested
   - Priority: HIGH

Refactoring Roadmap:

Week 1 (Quick Wins):
- Implement caching (16h) → -60h/month waste

Month 1:
- Refactor god classes (40h) → -15h/month waste
- Add critical tests (30h) → -10h/month waste

Quarter 1:
- Complete test coverage (60h) → -20h/month waste
- Microservices architecture (200h) → -40h/month waste

Expected Savings After Q1: -145 hours/month
```

---

## Debt Categories Explained

### Architecture Debt

**Common Items:**
- Monolithic architecture (should be microservices)
- No caching (repeated expensive operations)
- Synchronous processing (blocking operations)
- Single database (no read replicas)
- No CDN (serving static assets from app server)

**Cost Calculation:**
- Slow API responses → developers wait → time wasted
- Cannot scale → complex workarounds → time wasted
- Tightly coupled → changes require touching multiple modules → time wasted

---

### Code Debt

**Common Items:**
- Duplicate code (3+ similar code blocks)
- God classes (> 500 lines, too many responsibilities)
- Long functions (> 100 lines, hard to understand)
- High complexity (> 15 cyclomatic complexity)
- Poor naming (cryptic variable names)

**Cost Calculation:**
- Hard to understand → developers spend time reading → time wasted
- Hard to modify → fear of breaking → time wasted
- Hard to test → manual testing → time wasted

---

### Test Debt

**Common Items:**
- Missing tests (files with 0% coverage)
- Low coverage (< 80%)
- Flaky tests (intermittent failures)
- Slow tests (> 10 minutes suite time)
- No E2E tests (manual regression testing)

**Cost Calculation:**
- No tests → manual testing → time wasted
- Flaky tests → investigation → time wasted
- Slow tests → developers wait → time wasted
- Bugs in production → firefighting → time wasted

---

### Documentation Debt

**Common Items:**
- Undocumented APIs
- Outdated README
- No architecture diagrams
- Missing runbooks
- No inline comments

**Cost Calculation:**
- No docs → asking colleagues → time wasted
- Outdated docs → following wrong info → time wasted
- No runbooks → incident response slower → time wasted

---

## Prioritization Methods

### By Cost (Default)
Highest time waste first:
```
1. No caching: 60h/month wasted
2. Monolithic architecture: 40h/month wasted
3. Missing tests: 20h/month wasted
```

### By Risk
Highest probability × impact first:
```
1. No caching: HIGH risk (will break at 500 RPS)
2. God classes: MEDIUM risk (change amplification)
3. Missing tests: HIGH risk (bugs in production)
```

### By Effort
Easiest wins first:
```
1. Implement caching: 16 hours
2. Add tests: 30 hours (for critical files)
3. Refactor god classes: 40 hours
```

### By ROI (Recommended)
Best return on investment:
```
ROI = Cost (hours/month saved) / Effort (hours to implement)

1. Caching: 60h/month ÷ 16h = 3.75 ROI
2. God classes: 15h/month ÷ 40h = 0.375 ROI
3. Tests: 20h/month ÷ 60h = 0.33 ROI
```

---

## Integration with Other Commands

### `/code-health` → `/debt-analysis`
```bash
# Step 1: Assess overall health
/code-health
# → Score: 7.3/10, several issues found

# Step 2: Deep-dive into debt
/debt-analysis
# → Quantifies cost, prioritizes by ROI

# Step 3: Plan refactoring
# Use debt analysis ROI to decide what to tackle first
```

### `/profile` Integration
```bash
# Performance debt often correlates with code debt
/profile
# → Found: Dashboard API slow (1.5s)

/debt-analysis
# → Found: No caching layer (architecture debt)

# Fix architecture debt → improves performance
```

---

## Command Options

### `--category`
```bash
/debt-analysis --category architecture   # Architecture debt only
/debt-analysis --category code,test      # Multiple categories
/debt-analysis --category all            # All categories (default)
```

### `--prioritize`
```bash
/debt-analysis --prioritize cost     # Highest time waste first (default)
/debt-analysis --prioritize risk     # Highest risk first
/debt-analysis --prioritize effort   # Easiest wins first
/debt-analysis --prioritize roi      # Best ROI first (recommended)
```

---

## FAQ

### Q: How is this different from `/code-health`?

**A:**
- **`/code-health`**: Assessment (what's the current state?)
- **`/debt-analysis`**: Prioritization (what should we fix first?)

Use both: `/code-health` for baseline, `/debt-analysis` for action plan.

### Q: How do you calculate "time wasted"?

**A:** Based on common patterns:
- No caching → developers wait for slow APIs → 60h/month
- God classes → developers spend extra time understanding → 15h/month
- No tests → manual testing + bug fixes → 20h/month

Estimates based on team size and development velocity.

### Q: Should I fix all debt?

**A:** No! Prioritize by ROI:
- Fix high-ROI debt (quick wins, big impact)
- Accept low-ROI debt (low impact, high effort)
- Focus on debt causing real pain

---

## See Also

- **[/code-health](../code-health/)** - Codebase health assessment
- **[Refactor Expert Agent](../../../subagents/core/refactor-expert/)** - Code refactoring specialist
- **[Systems Architect Agent](../../../subagents/core/systems-architect/)** - Architecture debt specialist

---

**Version:** 2.7.0
**Last Updated:** November 19, 2025
**Category:** Quality
**License:** MIT
**Author:** Alireza Rezvani
