# Slash Commands Enhancement Plan

> **Intelligent Agent Orchestration for Claude Code Tresor Commands**
>
> **Version**: 3.0 Vision | **Created**: November 18, 2025
> **Status**: Ready for Implementation

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Current State Analysis](#current-state-analysis)
3. [Enhancement Strategy](#enhancement-strategy)
4. [Existing Command Enhancements](#existing-command-enhancements)
5. [New Command Proposals](#new-command-proposals)
6. [Intelligent Agent Selection](#intelligent-agent-selection)
7. [Implementation Roadmap](#implementation-roadmap)

---

## Executive Summary

### Vision

Transform slash commands from simple orchestrators into **intelligent workflow engines** that automatically select and coordinate the optimal agents from our 141-agent ecosystem based on context, file types, and project structure.

### Current State

**Commands**: 9 total (4 core + 5 Tresor)
- Core: /scaffold, /review, /test-gen, /docs-gen
- Tresor: /prompt-create, /prompt-run, /todo-add, /todo-check, /handoff-create

**Agent Integration**: Basic (manual agent mention)
- /review uses 4 agents explicitly
- Other commands mention 1-2 agents
- No intelligent selection

### Target State

**Commands**: 15-20 comprehensive commands
**Intelligence**: Context-aware agent selection
**Orchestration**: Multi-phase parallel/sequential workflows
**Quality Gates**: Automated validation and blocking
**Integration**: Full ecosystem (141 agents, 8+ skills)

### Impact

- **50-70% faster** development workflows
- **Automated quality** enforcement
- **Intelligent guidance** (right agent every time)
- **Production safety** (validation gates)

---

## Current State Analysis

### Existing Commands

#### 1. /scaffold (Development)

**Current Capability**:
- Generates project boilerplate
- Mentions @systems-architect

**Current Limitations**:
- No intelligent framework detection
- Single agent coordination
- No tech stack awareness

**Agent Ecosystem Underutilized**:
- 16 language specialists available (only mentions 1)
- 54 engineering agents available (uses 1)
- No design/architecture integration

---

#### 2. /review (Workflow)

**Current Capability**:
- Code review automation
- Uses 4 agents: config-safety-reviewer, security-auditor, systems-architect, performance-tuner

**Current Limitations**:
- Static agent selection (always same 4)
- No file-type awareness
- No parallel execution
- No quality gates

**Improvement Potential**: HIGHEST
- Could auto-select from 141 agents based on files
- Could run specialized reviews (Python files → @python-pro)
- Could enforce quality gates
- Could execute agents in parallel (3x faster)

---

#### 3. /test-gen (Testing)

**Current Capability**:
- Generates test suites
- Mentions @test-engineer

**Current Limitations**:
- No coverage gap analysis
- No framework auto-detection
- Single agent (7 testing agents available)

**Improvement Potential**:
- Auto-detect Jest/pytest/JUnit from project
- Use @qa-test-engineer for adversarial tests
- Use @api-tester for API tests
- Use @performance-benchmarker for load tests

---

#### 4. /docs-gen (Documentation)

**Current Capability**:
- Generates documentation
- Mentions @docs-writer

**Current Limitations**:
- No documentation drift detection
- No audience-specific docs
- Single agent (3 documentation agents available)

**Improvement Potential**:
- Use @tutorial-engineer for tutorials
- Use @api-documenter for API specs
- Use @docs-architect for structure
- Auto-detect what docs are needed

---

## Enhancement Strategy

### Core Principles

1. **Intelligent Over Manual**: Commands auto-select agents, not users
2. **Context-Aware**: File types, paths, content determine agents
3. **Parallel When Possible**: Independent agents run simultaneously
4. **Quality Gates**: Enforce standards automatically
5. **Actionable Output**: Clear, prioritized recommendations

### Enhancement Levels

**Level 1 - Intelligent Selection** (All commands)
- Auto-detect file types → Select language specialists
- Scan file paths → Select domain specialists
- Analyze content → Select task-specific agents

**Level 2 - Multi-Phase Orchestration** (Complex commands)
- Phase 1: Quick checks (parallel)
- Phase 2: Deep analysis (parallel where possible)
- Phase 3: Synthesis and recommendations

**Level 3 - Quality Gates** (Validation commands)
- Blocking gates (critical security, config safety)
- Warning gates (performance, coverage)
- Info gates (style, docs)

**Level 4 - Adaptive Workflows** (Advanced commands)
- Conditional agent selection based on findings
- Iterative refinement
- Dynamic prioritization

---

## Existing Command Enhancements

### 1. /review Enhancement (CRITICAL PRIORITY)

#### Current Flow
```
/review → Invoke 4 fixed agents → Generate report
```

#### Enhanced Flow
```
/review →
  Step 1: Analyze context
    - git diff → Identify changed files
    - Detect file types (.py, .ts, .sql, etc.)
    - Detect paths (api/, ui/, config/)
    - Detect content (keywords: security, performance)

  Step 2: Intelligent agent selection
    - Core 4 agents (always): config-safety-reviewer, security-auditor
    - Language specialists (auto): @python-pro if .py files
    - Domain specialists (auto): @backend-architect if api/ changes
    - Quality specialists (conditional): @refactor-expert if code smells

  Step 3: Parallel execution
    - Phase 1 (quick): Skills + language specialists
    - Phase 2 (deep): Core reviewers + domain specialists
    - Phase 3 (architecture): @systems-architect if major changes

  Step 4: Quality gates
    - Blocking: Critical security, unsafe configs
    - Warning: Performance regression, coverage drop
    - Info: Style issues, doc gaps

  Step 5: Consolidated report
    - Grouped by severity
    - Agent attribution
    - Actionable fixes
```

#### New Arguments

```bash
/review [options]

--auto-agents (default: true)
  # Automatically select agents based on changed files

--quality-gates [blocking|warning|all|none]
  # Which quality gates to enforce

--parallel (default: true)
  # Run independent agents in parallel

--agent-override "agent1,agent2,..."
  # Override auto-selection

--fail-on [critical|high|medium|low]
  # Exit code based on severity

--interactive
  # Show agent selection, allow customization

--explain
  # Show WHY each agent was selected
```

#### Example Output

```bash
/review --explain

🔍 Analyzing changes...
Found: 8 files changed (3 .py, 2 .ts, 1 .sql, 2 config)

🤖 Agent Selection:

ALWAYS (Core Review):
✓ @config-safety-reviewer - Config changes detected (CRITICAL)
✓ @security-auditor - Security validation

AUTO-SELECTED (File-Based):
✓ @python-pro - 3 Python files changed
✓ @typescript-pro - 2 TypeScript files changed
✓ @sql-pro - 1 SQL migration file

AUTO-SELECTED (Path-Based):
✓ @backend-architect - Changes in api/ directory
✓ @database-optimizer - Changes in database/migrations/

Total: 7 agents in 2 parallel phases (est. 30-40s)

Proceed? (y/n/customize):
```

**Implementation Tasks**:
- [ ] Add file type detection logic
- [ ] Add path pattern matching
- [ ] Implement parallel agent execution
- [ ] Add quality gates system
- [ ] Create consolidated report generator
- [ ] Add --explain mode

**Estimated Effort**: 8-10 hours
**Impact**: 3x faster reviews, 50% fewer bugs

---

### 2. /scaffold Enhancement (HIGH PRIORITY)

#### Current Flow
```
/scaffold <type> <name> → Generate boilerplate
```

#### Enhanced Flow
```
/scaffold <type> <name> [options] →
  Step 1: Project context detection
    - Scan package.json/requirements.txt
    - Detect: React, Next.js, Express, Django, etc.
    - Determine: Frontend, backend, fullstack

  Step 2: Multi-agent planning
    - @systems-architect: Overall structure
    - @[language]-pro: Language-specific patterns
    - @frontend-developer OR @backend-architect: Specialized patterns

  Step 3: Generation with best practices
    - Framework-specific boilerplate
    - Testing infrastructure
    - Documentation stubs
    - CI/CD configuration

  Step 4: Skill activation confirmation
    - code-reviewer will monitor
    - test-generator will suggest tests
    - api-documenter will document endpoints
```

#### New Arguments

```bash
/scaffold <type> <name> [options]

--intelligence-level [basic|smart|expert]
  basic: Generate only (no agent consultation)
  smart: Consult specialist agents (default)
  expert: Full multi-agent architecture review

--optimize-for [speed|maintainability|scalability]
  Changes pattern recommendations

--with-tests
  Generate comprehensive test infrastructure

--with-docker
  Add Docker containerization

--with-ci
  Add CI/CD configuration

--framework-detect
  Auto-detect and match existing project patterns
```

#### Example

```bash
/scaffold api users-service --intelligence-level expert --with-tests --with-docker

Output:
✓ Detecting project context...
Detected: Node.js + TypeScript + Express + PostgreSQL

✓ Consulting @systems-architect...
Recommended: Microservice pattern with clean architecture

✓ Consulting @typescript-pro...
Patterns: Decorators, dependency injection, async/await

✓ Consulting @backend-architect...
API Design: RESTful with OpenAPI spec

Generating:
📁 services/users/
├── src/
│   ├── controllers/     # Request handlers
│   ├── services/        # Business logic
│   ├── repositories/    # Data access
│   ├── models/          # Data models
│   └── middleware/      # Express middleware
├── tests/
│   ├── unit/
│   ├── integration/
│   └── e2e/
├── Dockerfile
├── docker-compose.yml
├── .env.example
└── README.md

✓ Generating tests with @test-engineer...
Created: 45 test cases (unit, integration, E2E)

✓ Activating monitoring skills...
→ code-reviewer will validate generated code
→ test-generator will suggest additional tests
→ api-documenter will document endpoints

Ready! Next steps:
1. Review generated code
2. Customize as needed
3. Run tests: npm test
```

**Implementation Tasks**:
- [ ] Add project detection logic
- [ ] Implement multi-agent planning workflow
- [ ] Add framework templates
- [ ] Create test infrastructure generation
- [ ] Add Docker/CI templates

**Estimated Effort**: 6-8 hours
**Impact**: Professional project setup in minutes

---

### 3. /test-gen Enhancement (HIGH PRIORITY)

#### Enhanced Flow

```
/test-gen →
  Step 1: Code analysis
    - Detect: Functions, methods, components
    - Identify: Existing test coverage
    - Calculate: Coverage gaps

  Step 2: Framework detection
    - package.json → Jest/Vitest
    - requirements.txt → pytest
    - pom.xml → JUnit

  Step 3: Multi-agent testing
    - @test-engineer: Comprehensive test strategy
    - @[language]-pro: Language-specific patterns
    - @qa-test-engineer: Adversarial/edge cases
    - @api-tester (if API): API-specific tests

  Step 4: Specialized tests
    - @performance-benchmarker: Load tests
    - @frontend-developer: Visual regression (if UI)
```

#### New Arguments

```bash
/test-gen [options]

--analyze-coverage
  # Scan existing tests, identify gaps

--test-types [unit|integration|e2e|all]
  # Specific test types

--adversarial
  # Invoke @qa-test-engineer for edge cases

--property-based
  # Generate property-based tests

--visual-regression
  # Generate visual regression tests (UI components)

--load-tests
  # Generate load tests with @performance-benchmarker

--coverage-target <percentage>
  # Target coverage (default: 90%)
```

**Implementation Tasks**:
- [ ] Add coverage gap analysis
- [ ] Add framework auto-detection
- [ ] Integrate multiple testing agents
- [ ] Add specialized test types

**Estimated Effort**: 4-6 hours
**Impact**: 90%+ coverage automatically

---

### 4. /docs-gen Enhancement (MEDIUM PRIORITY)

#### Enhanced Flow

```
/docs-gen →
  Step 1: Documentation needs analysis
    - Scan project structure
    - Identify: API routes, CLI commands, components
    - Detect: Missing/outdated docs

  Step 2: Multi-agent documentation
    - @docs-writer: User guides
    - @api-documenter: API specifications
    - @tutorial-engineer: Tutorials
    - @docs-architect: Documentation structure

  Step 3: Audience-specific generation
    - Developers: Technical, API reference
    - Users: Guides, tutorials
    - Contributors: Setup, workflows
```

#### New Arguments

```bash
/docs-gen [type] [options]

--detect-drift
  # Compare code vs docs, identify outdated sections

--audience [developer|user|contributor|enterprise]
  # Audience-specific documentation

--diagrams
  # Auto-generate architecture diagrams

--interactive
  # Create interactive docs (Docusaurus)

--compliance [gdpr|hipaa|soc2]
  # Add compliance docs (@compliance-officer-fs)
```

**Implementation Tasks**:
- [ ] Add documentation drift detection
- [ ] Add audience-specific templates
- [ ] Integrate architecture diagram generation
- [ ] Add compliance documentation

**Estimated Effort**: 4-6 hours
**Impact**: Always-current documentation

---

## New Command Proposals

### Priority 1: Critical Commands (Week 1-2)

#### /diagnose - Intelligent Debugging

**Purpose**: Systematic root cause analysis with multi-agent debugging

**Orchestration**:
1. @root-cause-analyzer (triage)
2. Conditional specialists (database/performance/security)
3. @test-engineer (regression tests)

**Arguments**:
```bash
/diagnose <description> [--logs path] [--production] [--trace]
```

**Use Case**: Production incidents, complex bugs

**Estimated Effort**: 6-8 hours

---

#### /secure - Security Audit

**Purpose**: Comprehensive security audit and compliance validation

**Orchestration**:
1. Security skills (parallel quick scan)
2. @security-auditor (deep audit)
3. @compliance-officer-fs (if compliance flag)

**Arguments**:
```bash
/secure [api|auth|infrastructure|all] [--compliance gdpr|hipaa]
```

**Use Case**: Pre-deployment security, compliance audits

**Estimated Effort**: 6-8 hours

---

#### /pr-ready - Pre-Submission Validation

**Purpose**: Ensure PR meets all standards before submission

**Orchestration**:
1. Quick checks (skills)
2. /review with quality gates
3. PR materials generation
4. Changelog update

**Arguments**:
```bash
/pr-ready [--auto-fix] [--strict] [--generate-tests]
```

**Use Case**: Before creating PR, ensure quality

**Estimated Effort**: 4-6 hours

---

### Priority 2: High Value (Week 3-4)

#### /optimize - Performance Optimization

**Orchestration**:
1. @performance-tuner (profiling)
2. Specialized optimizers (database/frontend/backend)
3. @performance-benchmarker (validation)

**Arguments**:
```bash
/optimize [api|database|frontend|bundle|memory] [--profile] [--budget]
```

**Estimated Effort**: 6-8 hours

---

#### /refactor - Intelligent Refactoring

**Orchestration**:
1. @refactor-expert (code smell detection)
2. @systems-architect (patterns)
3. @test-engineer (test validation)

**Arguments**:
```bash
/refactor [file|function|module] [--pattern solid|dry] [--safe-mode]
```

**Estimated Effort**: 6-8 hours

---

#### /deploy-check - Deployment Validation

**Orchestration**:
1. @config-safety-reviewer (config)
2. @security-auditor (security)
3. @deployment-engineer (deployment plan)

**Arguments**:
```bash
/deploy-check <env> [--breaking-changes] [--rollback-plan]
```

**Estimated Effort**: 5-7 hours

---

### Priority 3: Medium Value (Week 5-6)

#### /analyze - Codebase Analysis

**Purpose**: Deep insights into architecture, quality, tech debt

**Arguments**:
```bash
/analyze [architecture|quality|tech-debt] [--visualize] [--depth]
```

**Estimated Effort**: 6-8 hours

---

#### /migrate - Technology Migration

**Purpose**: Database/framework/language migration assistance

**Arguments**:
```bash
/migrate <from> <to> [--plan-only] [--zero-downtime]
```

**Estimated Effort**: 8-10 hours

---

#### /feature-plan - Feature Planning

**Purpose**: End-to-end feature planning with multi-agent design

**Arguments**:
```bash
/feature-plan <description> [--fullstack] [--generate-prompts]
```

**Estimated Effort**: 6-8 hours

---

## Intelligent Agent Selection

### Selection Algorithm

**Input**: Command context (files, description, project type)
**Output**: Ranked list of agents with confidence scores

#### Phase 1: File-Based Selection

```yaml
File Extension Mapping:
.py → @python-pro (confidence: 0.95)
.ts/.tsx → @typescript-pro (confidence: 0.95)
.java → @java-pro (confidence: 0.95)
.go → @golang-pro (confidence: 0.95)
.rs → @rust-pro (confidence: 0.95)
.sql → @sql-pro + @database-optimizer (confidence: 0.90)
.tf → @terraform-specialist + @cloud-architect (confidence: 0.85)
Dockerfile → @deployment-engineer (confidence: 0.90)
```

#### Phase 2: Path Pattern Matching

```yaml
Path Patterns:
api/, backend/, server/ → @backend-architect (confidence: 0.85)
components/, ui/, frontend/ → @frontend-developer (confidence: 0.85)
auth/, security/ → @security-auditor (confidence: 0.90)
database/, migrations/ → @database-optimizer (confidence: 0.85)
tests/, __tests__/ → @test-engineer (confidence: 0.80)
docs/, documentation/ → @docs-writer (confidence: 0.80)
deploy/, infra/ → @deployment-engineer (confidence: 0.85)
```

#### Phase 3: Content Analysis

```yaml
Keywords:
"performance", "optimize", "slow" → @performance-tuner
"security", "vulnerability", "auth" → @security-auditor
"refactor", "code smell", "clean" → @refactor-expert
"test", "coverage", "qa" → @test-engineer
"debug", "error", "bug" → @root-cause-analyzer
"architecture", "design", "system" → @systems-architect
```

#### Phase 4: Project Type Detection

```yaml
package.json:
  react → @frontend-developer + @typescript-pro + @ui-designer
  next → @frontend-developer + @backend-architect
  express → @backend-architect + @javascript-pro

requirements.txt:
  django → @backend-architect + @python-pro
  fastapi → @backend-architect + @python-pro + @api-documenter

go.mod → @golang-pro + @backend-architect
Cargo.toml → @rust-pro
pom.xml → @java-pro
```

#### Confidence Scoring

```javascript
function calculateConfidence(agent, context) {
  let score = 0;

  // File type match
  if (context.files.some(f => agentHandlesFileType(agent, f))) {
    score += 0.4;
  }

  // Path pattern match
  if (context.files.some(f => agentHandlesPath(agent, f))) {
    score += 0.3;
  }

  // Content keyword match
  if (agentHandlesKeywords(agent, context.description)) {
    score += 0.2;
  }

  // Project type match
  if (agentHandlesProjectType(agent, context.projectType)) {
    score += 0.1;
  }

  return Math.min(score, 1.0);
}
```

---

## Implementation Roadmap

### Phase 1: Critical Enhancements (Week 1-2, 20-25 hours)

**Week 1**:
- [x] Tresor integration (completed)
- [ ] Enhance /review with intelligent selection (8 hours)
- [ ] Add quality gates system (4 hours)
- [ ] Create /diagnose command (6 hours)

**Week 2**:
- [ ] Create /secure command (6 hours)
- [ ] Create /pr-ready command (5 hours)
- [ ] Add parallel execution framework (6 hours)

**Deliverables**: 3 enhanced commands, 3 new critical commands

---

### Phase 2: High-Value Commands (Week 3-4, 20-25 hours)

**Week 3**:
- [ ] Enhance /scaffold with multi-agent (6 hours)
- [ ] Create /optimize command (7 hours)
- [ ] Create /refactor command (7 hours)

**Week 4**:
- [ ] Create /deploy-check command (6 hours)
- [ ] Enhance /test-gen with coverage analysis (5 hours)
- [ ] Add command discovery system (4 hours)

**Deliverables**: 2 enhanced commands, 4 new high-value commands

---

### Phase 3: Additional Commands (Week 5-6, 20-25 hours)

**Week 5**:
- [ ] Create /analyze command (7 hours)
- [ ] Create /migrate command (8 hours)
- [ ] Enhance /docs-gen with drift detection (5 hours)

**Week 6**:
- [ ] Create /feature-plan command (6 hours)
- [ ] Create /tech-debt command (6 hours)
- [ ] Create /onboard command (4 hours)
- [ ] Polish and documentation (4 hours)

**Deliverables**: 1 enhanced command, 5 new commands

---

### Total Implementation

**Timeline**: 6 weeks
**Effort**: 60-75 hours
**Commands**: 9 → 18 (100% increase)
**Enhancement**: All commands with intelligent orchestration

---

## Success Metrics

### Adoption
- 80% of developers use enhanced commands daily
- 50% reduction in "which agent?" questions

### Performance
- 50% faster code reviews (parallel execution)
- 70% faster debugging (intelligent diagnosis)
- 60% faster scaffolding (multi-agent planning)

### Quality
- 40% fewer production bugs (quality gates)
- 90%+ test coverage (enhanced test-gen)
- 95% security compliance (automated audits)

### Productivity
- 50-70% overall productivity improvement
- 30% reduction in manual review time
- 80% automation of repetitive workflows

---

## Next Immediate Actions

**This Week** (Start with highest ROI):

1. **Enhance /review** (8 hours) - CRITICAL
   - Intelligent agent selection
   - Parallel execution
   - Quality gates

2. **Create /diagnose** (6 hours) - CRITICAL
   - Production debugging workflow
   - Multi-agent RCA

3. **Create /secure** (6 hours) - CRITICAL
   - Automated security audits
   - Compliance validation

**Total**: 20 hours for major command ecosystem boost

---

**Status**: Ready for implementation
**Owner**: Alireza Rezvani
**Created**: November 18, 2025
