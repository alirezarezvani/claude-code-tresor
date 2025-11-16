# Duplicate Analysis & Conflict Resolution

> **Identification and resolution strategy for duplicate/overlapping agents**
>
> **Last Updated**: November 15, 2025 | **Version**: 2.5.0

---

## Table of Contents

1. [Executive Summary](#executive-summary)
2. [Exact Duplicate Agents](#exact-duplicate-agents)
3. [Functional Overlap Groups](#functional-overlap-groups)
4. [Naming Conflicts](#naming-conflicts)
5. [Resolution Strategies](#resolution-strategies)
6. [Migration Recommendations](#migration-recommendations)
7. [Disambiguation Guide](#disambiguation-guide)

---

## Executive Summary

### Scope of Analysis

- **Total Agents Analyzed**: 145 (8 core agents/ + 137 sources/agents/)
- **Exact Name Duplicates**: 3 agents (code-reviewer, debugger, security-auditor)
- **Functional Overlap Groups**: 7 groups (20+ agents with similar functionality)
- **Naming Ambiguity**: 4 critical cases (architect, performance, test, refactor)

### Conflict Severity

| Severity | Count | Impact | Action Required |
|----------|-------|--------|-----------------|
| **CRITICAL** | 4 | High user confusion, unclear invocation | Immediate renaming |
| **HIGH** | 3 | Direct naming conflict, different purposes | Rename + documentation |
| **MEDIUM** | 7 | Functional overlap, complementary | Documentation + tags |
| **LOW** | 10+ | Specialized variants, minimal conflict | Keep as-is |

---

## Exact Duplicate Agents

### 1. code-reviewer.md (HIGH CONFLICT)

#### Conflict Details

| Aspect | Core Agent (agents/) | Sources Agent (sources/agents/) |
|--------|---------------------|--------------------------------|
| **File Path** | `/agents/code-reviewer.md` | `/sources/agents/code-reviewer.md` |
| **File Size** | 214 lines | ~65 lines |
| **Model** | inherit | sonnet |
| **Specialization** | Configuration safety & production reliability | General code review |
| **Primary Focus** | Magic numbers, pool sizes, connection limits, timeouts | Framework expertise, best practices |
| **Unique Features** | Configuration risk assessment, outage prevention | Multi-framework review (React, Node, Python, Go, Java) |

#### Detailed Comparison

**Core Agent (Production Safety Specialist)**:
```yaml
---
name: code-reviewer
description: Expert code reviewer specializing in quality analysis, best practices, security, and performance optimization. Use proactively after code changes to ensure high standards.
tools: Read, Edit, Grep, Glob, Bash, Task, Skill
model: inherit
---
```

**Key Capabilities**:
- ⚠️ **Configuration Change Risk Assessment** (PRIMARY SPECIALIZATION)
- Pool size validation (database, thread pools, connection pools)
- Timeout configuration safety
- Magic number detection
- Production outage prevention patterns
- High-risk configuration pattern detection
- Skills integration (security-auditor skill, test-generator skill)

**Real Example** (from core agent):
```javascript
// ❌ CRITICAL: Magic number - connection pool size
const pool = new Pool({ max: 50 });

// ✅ Configuration-driven with documentation
const pool = new Pool({
  max: parseInt(process.env.DB_POOL_MAX_CONNECTIONS) || 10,
  // Sizing: 1 connection per 100 concurrent requests (tested at 1000 req/s)
  // Production validated with 500 concurrent users
});
```

---

**Sources Agent (General Code Review)**:
```yaml
---
name: code-reviewer
description: Expert code review specialist. Proactively reviews code for quality, security, and maintainability. Use immediately after writing or modifying code.
model: sonnet
---
```

**Key Capabilities**:
- General code quality (DRY, SOLID, KISS)
- Security (OWASP Top 10, but less depth than security-auditor)
- Performance (algorithmic efficiency, caching)
- Testing (coverage adequacy, test quality)
- Multi-framework expertise (React, Node.js, Python, Go, Java)
- Configuration is **secondary concern**

---

#### Resolution Strategy

**Option 1: Rename Core Agent** (RECOMMENDED)
- Rename `/agents/code-reviewer.md` → `/agents/config-safety-reviewer.md`
- Emphasizes unique specialization
- Clear differentiation from general review
- Invocation: `@config-safety-reviewer`

**Option 2: Add Specialization Tags**
- Keep both names
- Add `specialization: configuration-safety` to core agent frontmatter
- Add `specialization: general-review` to sources agent frontmatter
- Requires user to understand tags

**Option 3: Consolidate** (NOT RECOMMENDED)
- Merge both into single agent
- Would create overly complex agent
- Loses focused specialization

**DECISION: Option 1 - Rename core agent to `config-safety-reviewer`**

---

### 2. debugger.md (MEDIUM-HIGH CONFLICT)

#### Conflict Details

| Aspect | Core Agent (agents/) | Sources Agent (sources/agents/) |
|--------|---------------------|--------------------------------|
| **File Path** | `/agents/debugger.md` | `/sources/agents/debugger.md` |
| **File Size** | 392 lines | ~30 lines |
| **Model** | inherit | - (unspecified) |
| **Specialization** | Comprehensive root cause analysis (RCA) | Lightweight quick debugging |
| **Depth** | 5-step scientific method, profiling, case studies | Basic error analysis and fix |
| **Complexity** | Advanced (memory leaks, deadlocks, race conditions) | Entry-level (stack traces, error messages) |

#### Detailed Comparison

**Core Agent (Root Cause Analysis Framework)**:
```yaml
---
name: debugger
description: Expert debugging specialist focused on root cause analysis, systematic problem-solving, and minimal-impact fixes. Use proactively when encountering errors, performance issues, or unexpected behavior.
tools: Read, Edit, Bash, Grep, Glob, Task, Skill
model: inherit
---
```

**Key Capabilities**:
- 🔬 **Systematic RCA Framework** (5-step scientific method)
- Performance profiling strategies (CPU, memory, I/O, network)
- Complex debugging: memory leaks, race conditions, deadlocks, distributed systems
- Database lock analysis, thread dump interpretation
- Network debugging (tcpdump, Wireshark)
- Prevention strategies and monitoring setup
- Defensive programming patterns
- Real case studies with solutions (8+ examples)

**Example Depth** (from core agent):
```
## Case Study: Memory Leak in Node.js Service

**Symptoms**: Memory usage grows from 200MB to 2GB over 24 hours, then OOM crash

**Investigation**:
1. Heap snapshot analysis (Chrome DevTools / node --inspect)
2. Identified retained objects: 500k Event listeners not cleaned up
3. Root cause: Missing removeEventListener() in cleanup lifecycle

**Fix**: Implement proper cleanup in component unmount
**Prevention**: Add memory leak detection in CI/CD
```

---

**Sources Agent (Quick Debugging)**:
```yaml
---
name: debugger
description: Debugging specialist for errors, test failures, and unexpected behavior. Use proactively when encountering any issues.
model: [unspecified]
---
```

**Key Capabilities**:
- Error message analysis
- Stack trace interpretation
- Reproduction step identification
- Minimal fix implementation
- Basic prevention recommendations
- ~30 lines total (lightweight)

---

#### Resolution Strategy

**Option 1: Rename Core Agent** (RECOMMENDED)
- Rename `/agents/debugger.md` → `/agents/root-cause-analyzer.md`
- Emphasizes comprehensive RCA approach
- Clear differentiation from quick debugging
- Invocation: `@root-cause-analyzer`

**Option 2: Keep Both with Tags**
- Add `depth: comprehensive` to core agent
- Add `depth: lightweight` to sources agent
- Documentation explains when to use each

**Option 3: Merge with Depth Parameter** (NOT RECOMMENDED)
- Single agent with `--depth quick|comprehensive` flag
- Adds complexity to invocation
- Harder to maintain

**DECISION: Option 1 - Rename core agent to `root-cause-analyzer`**

---

### 3. security-auditor.md (MEDIUM CONFLICT)

#### Conflict Details

| Aspect | Core Agent (agents/) | Sources Agent (sources/agents/) |
|--------|---------------------|--------------------------------|
| **File Path** | `/agents/security-auditor.md` | `/sources/agents/security-auditor.md` |
| **File Size** | 708 lines | ~50 lines |
| **Model** | inherit | opus |
| **Specialization** | Strategic security architecture | Tactical security implementation |
| **Focus** | OWASP, threat modeling, compliance, RCA | Authentication implementation, encryption setup |
| **Depth** | Comprehensive audit framework | Implementation guidance |

#### Detailed Comparison

**Core Agent (Strategic Security Architecture)**:
```yaml
---
name: security-auditor
description: Security specialist for vulnerability assessment, secure authentication, and OWASP compliance. Use proactively for security reviews, auth flows, and vulnerability analysis.
tools: Read, Edit, Bash, Grep, Glob, Task, Skill
model: inherit
---
```

**Key Capabilities**:
- 🛡️ **OWASP Top 10 Systematic Analysis** (comprehensive framework)
- Threat modeling and risk assessment
- Security architecture review (defense in depth, zero trust)
- Skills coordination (security-auditor skill, secret-scanner skill, dependency-auditor skill)
- Compliance assessment (PCI-DSS, HIPAA, SOC 2, GDPR)
- Incident response and breach analysis
- Strategic remediation roadmaps
- 10+ comprehensive code examples with analysis

---

**Sources Agent (Tactical Security Implementation)**:
```yaml
---
name: security-auditor
description: Review code for vulnerabilities, implement secure authentication, and ensure OWASP compliance. Handles JWT, OAuth2, CORS, CSP, and encryption. Use PROACTIVELY for security reviews, auth flows, or vulnerability fixes.
model: opus
---
```

**Key Capabilities**:
- Authentication/authorization **implementation** (JWT, OAuth2, SAML)
- Input validation and SQL injection **prevention**
- Security headers **configuration** (CSP, HSTS)
- Encryption **implementation** (at rest and in transit)
- CORS **setup**
- More **tactical/implementation-focused**, less strategic

---

#### Resolution Strategy

**Option 1: Add Level Tags** (RECOMMENDED)
- Add `level: strategic` to core agent frontmatter
- Add `level: tactical` to sources agent frontmatter
- Keep both names (both are "security-auditor")
- Documentation explains:
  - Strategic level: Architecture, threat modeling, compliance
  - Tactical level: Implementation, configuration, code fixes

**Option 2: Rename Sources Agent**
- Rename sources agent to `security-implementer`
- Clear differentiation
- May cause confusion (users expect "auditor")

**Option 3: Consolidate** (NOT RECOMMENDED)
- Would create massive 1000+ line agent
- Loses focus on strategic vs. tactical

**DECISION: Option 1 - Add level tags (strategic vs. tactical)**

---

## Functional Overlap Groups

### Group 1: Architect Family (8 variants) - CRITICAL CONFLICT

| Agent | Location | Specialization | Conflict Level |
|-------|----------|----------------|----------------|
| **architect** | `/agents/` | System design, trade-offs, technology evaluation | CRITICAL (ambiguous name) |
| **systems-architect** | `/sources/agents/core/` | Long-term system evolution, maintainability | HIGH (overlaps with architect) |
| **backend-architect** | `/sources/agents/` | APIs, microservices, database schemas | MEDIUM (backend-specific) |
| **cloud-architect** | `/sources/agents/` | Infrastructure, Terraform, cost optimization | MEDIUM (cloud-specific) |
| **graphql-architect** | `/sources/agents/` | GraphQL patterns and architecture | LOW (GraphQL-specific) |
| **docs-architect** | `/sources/agents/` | Documentation structure and organization | LOW (docs-specific) |
| **architect-review** | `/sources/agents/` | Architectural consistency, pattern adherence | MEDIUM (review focus) |

#### Problem: "architect" is Ambiguous

When user says `@architect`, which agent should respond?
- System design (general)?
- Backend APIs?
- Cloud infrastructure?
- Documentation structure?

#### Resolution Strategy

**RECOMMENDED: Rename Core Agent + Create Disambiguation**

1. **Rename `/agents/architect.md` → `/agents/systems-architect.md`**
   - Aligns with sources/agents/core/systems-architect.md
   - Clear: system-level architecture
   - Invocation: `@systems-architect`

2. **Consolidate `systems-architect` versions**
   - Merge `/agents/architect.md` (339 lines) with `/sources/agents/core/systems-architect.md`
   - Take best of both versions
   - Single authoritative systems architect

3. **Create Disambiguation Guide**
   ```
   # Which Architect to Use?

   - System design & evolution → @systems-architect
   - Backend API design → @backend-architect
   - Cloud infrastructure → @cloud-architect
   - GraphQL patterns → @graphql-architect
   - Architecture review → @architect-review
   - Documentation structure → @docs-architect
   ```

---

### Group 2: Performance Family (4 variants) - HIGH CONFLICT

| Agent | Location | Specialization | Conflict Level |
|-------|----------|----------------|----------------|
| **performance-tuner** | `/agents/` | Profiling, bottleneck identification, optimization | HIGH (primary) |
| **performance-optimizer** | `/sources/agents/core/` | Optimization strategies (measure, optimize, verify) | HIGH (overlaps with tuner) |
| **performance-engineer** | `/sources/agents/` | General performance engineering | MEDIUM (broader scope) |
| **database-optimizer** | `/sources/agents/` | Database-specific optimization | LOW (DB-specific) |
| **performance-benchmarker** | `/sources/agents/testing/` | Performance benchmarking and testing | LOW (testing-specific) |

#### Resolution Strategy

**RECOMMENDED: Keep Primary + Specialize Others**

1. **Keep `/agents/performance-tuner` as primary**
   - Most comprehensive (552 lines)
   - Already has skills integration
   - Primary performance agent

2. **Consolidate `performance-optimizer` into `performance-tuner`**
   - Merge sources/agents/core/performance-optimizer.md into /agents/performance-tuner.md
   - Remove duplicate version

3. **Rename specialized variants** for clarity:
   - Keep `database-optimizer` (DB-specific)
   - Keep `performance-benchmarker` (testing-specific)
   - Rename `performance-engineer` → `web-performance-engineer` (if frontend-focused)

---

### Group 3: Refactoring Family (3 variants) - HIGH CONFLICT

| Agent | Location | Specialization | Conflict Level |
|-------|----------|----------------|----------------|
| **refactor-expert** | `/agents/` | SOLID, design patterns, test-driven refactoring | HIGH (primary) |
| **code-refactoring-expert** | `/sources/agents/core/` | Code smells, incremental improvements, safety | HIGH (95% overlap) |
| **legacy-modernizer** | `/sources/agents/` | Legacy code modernization | MEDIUM (legacy-specific) |

#### Resolution Strategy

**RECOMMENDED: Consolidate Duplicates**

1. **Merge `code-refactoring-expert` into `refactor-expert`**
   - 95% content overlap
   - `/agents/refactor-expert.md` is more comprehensive (855 lines)
   - Enhance with best parts of code-refactoring-expert
   - Remove `/sources/agents/core/code-refactoring-expert.md`

2. **Keep `legacy-modernizer` separate**
   - Specialized for legacy systems
   - Complementary to refactor-expert

---

### Group 4: Test/QA Family (4+ variants) - MEDIUM CONFLICT

| Agent | Location | Specialization | Conflict Level |
|-------|----------|----------------|----------------|
| **test-engineer** | `/agents/` | Comprehensive test creation, pyramid approach | MEDIUM (primary) |
| **qa-test-engineer** | `/sources/agents/core/` | QA specialist, adversarial mindset | MEDIUM (QA focus) |
| **test-automator** | `/sources/agents/` | Test automation focus | LOW (automation-specific) |
| **api-tester** | `/sources/agents/testing/` | API-specific testing | LOW (API-specific) |
| **performance-benchmarker** | `/sources/agents/testing/` | Performance testing | LOW (performance-specific) |

#### Resolution Strategy

**RECOMMENDED: Keep All (Complementary Specialists)**

- **test-engineer**: Comprehensive test strategy (primary)
- **qa-test-engineer**: QA mindset (adversarial, exploratory testing)
- **test-automator**: Automation infrastructure
- **api-tester**: API contract testing
- **performance-benchmarker**: Load/stress testing

**Action**: Add clear descriptions showing complementary roles

---

### Group 5: Documentation Family (4 variants) - LOW CONFLICT

| Agent | Location | Specialization | Conflict Level |
|-------|----------|----------------|----------------|
| **docs-writer** | `/agents/` | User guides, tutorials, architecture docs | LOW (primary) |
| **api-documenter** | `/sources/agents/` | OpenAPI/Swagger, SDKs, interactive docs | LOW (API-specific) |
| **docs-architect** | `/sources/agents/` | Documentation structure and organization | LOW (structure focus) |
| **tutorial-engineer** | `/sources/agents/` | Tutorial and learning content creation | LOW (tutorial-specific) |

#### Resolution Strategy

**RECOMMENDED: Keep All (Complementary)**

- **docs-writer**: General documentation (primary)
- **api-documenter**: API documentation specialist
- **docs-architect**: Documentation architecture
- **tutorial-engineer**: Tutorial content specialist

**Action**: Create cross-reference guide showing specializations

---

### Group 6: Debugging/Analysis Family (3+ variants) - MEDIUM CONFLICT

| Agent | Location | Specialization | Conflict Level |
|-------|----------|----------------|----------------|
| **debugger** | `/agents/` | Root cause analysis framework | MEDIUM (primary) |
| **code-analyzer-debugger** | `/sources/agents/core/` | Systematic investigation, evidence-based | MEDIUM (similar to debugger) |
| **error-detective** | `/sources/agents/` | Error pattern identification | LOW (pattern-specific) |

#### Resolution Strategy

**RECOMMENDED: Rename + Clarify**

1. **Rename `/agents/debugger` → `/agents/root-cause-analyzer`** (as decided above)
2. **Rename `code-analyzer-debugger` → `code-analyzer`**
   - Focuses on code analysis aspect
   - Differentiate from RCA debugging
3. **Keep `error-detective`**
   - Error pattern specialist (complementary)

---

### Group 7: Security Family (3+ variants) - MEDIUM CONFLICT

| Agent | Location | Specialization | Conflict Level |
|-------|----------|----------------|----------------|
| **security-auditor** | `/agents/` | Strategic security audit, OWASP, compliance | MEDIUM (primary) |
| **security-threat-analyst** | `/sources/agents/core/` | Threat modeling, attack patterns | MEDIUM (threat focus) |
| **incident-responder** | `/sources/agents/` | Breach analysis and response | LOW (incident-specific) |

#### Resolution Strategy

**RECOMMENDED: Keep All (Complementary Levels)**

- **security-auditor** (strategic): Architecture, compliance, comprehensive audits
- **security-threat-analyst** (tactical): Threat modeling, attack vectors
- **incident-responder** (operational): Incident response, forensics

**Action**: Add `level` tags and create decision matrix

---

## Naming Conflicts

### Critical Naming Ambiguity Cases

#### 1. "architect" (8 uses) - CRITICAL

**Problem**: Generic name used for multiple specializations

**Resolution**:
- Core: `architect` → `systems-architect`
- Backend: Keep `backend-architect`
- Cloud: Keep `cloud-architect`
- GraphQL: Keep `graphql-architect`
- Docs: Keep `docs-architect`
- Review: Keep `architect-review`

**Result**: No ambiguity - each has clear specialization prefix

---

#### 2. "code-reviewer" (2 uses) - HIGH

**Problem**: Same name, different purposes (safety vs. general)

**Resolution**:
- Core: `code-reviewer` → `config-safety-reviewer`
- Sources: Keep `code-reviewer` (general review)

**Result**: Clear differentiation

---

#### 3. "debugger" (2 uses) - HIGH

**Problem**: Same name, different depth (comprehensive vs. quick)

**Resolution**:
- Core: `debugger` → `root-cause-analyzer`
- Sources: Keep `debugger` (quick debugging)

**Result**: Clear differentiation by depth

---

#### 4. "performance" prefix (4 uses) - MEDIUM

**Problem**: Multiple performance agents

**Resolution**:
- Primary: `performance-tuner` (keep as-is)
- Consolidate: Merge `performance-optimizer` into `performance-tuner`
- Specialized: `database-optimizer`, `performance-benchmarker` (keep)

**Result**: Clear primary + specialized variants

---

## Resolution Strategies

### Strategy 1: Rename for Clarity (RECOMMENDED for core/)

**Use Case**: Core agents that conflict with sources agents

**Actions**:
- `architect` → `systems-architect`
- `code-reviewer` → `config-safety-reviewer`
- `debugger` → `root-cause-analyzer`

**Pros**:
- Clear differentiation
- No user confusion
- Emphasizes unique specialization

**Cons**:
- Breaking change for existing users
- Requires documentation updates

---

### Strategy 2: Add Metadata Tags (RECOMMENDED for specialization)

**Use Case**: Agents with different levels/focus but similar domain

**Actions**:
- Add `level: strategic` or `level: tactical` to YAML frontmatter
- Add `depth: comprehensive` or `depth: lightweight`
- Add `specialization: backend` or `specialization: cloud`

**Example**:
```yaml
---
name: security-auditor
description: Security specialist...
level: strategic  # NEW: strategic vs. tactical
tools: Read, Edit, Bash, Grep, Glob, Task, Skill
model: inherit
---
```

**Pros**:
- No name changes needed
- Machine-readable metadata
- Enables filtering/search

**Cons**:
- Requires user understanding of tags
- Still have naming conflicts

---

### Strategy 3: Consolidate Duplicates (RECOMMENDED for 95%+ overlap)

**Use Case**: Near-identical agents in different locations

**Actions**:
- Merge `refactor-expert` and `code-refactoring-expert`
- Merge `performance-tuner` and `performance-optimizer`
- Merge `systems-architect` versions

**Pros**:
- Eliminates duplication
- Reduces maintenance burden
- Single source of truth

**Cons**:
- Need to preserve best of both versions
- Migration effort

---

### Strategy 4: Create Disambiguation Guides (RECOMMENDED for all)

**Use Case**: Help users choose the right agent

**Actions**:
- Create decision trees for each conflict group
- Add "When to use" sections in READMEs
- Cross-reference related agents

**Example**:
```markdown
# Which Agent to Use?

## For Code Review:
- **General code quality** → @code-reviewer (sources/)
- **Configuration safety** → @config-safety-reviewer (core/)
- **Security focus** → @security-auditor
- **Performance focus** → @performance-tuner

## For Architecture:
- **System design** → @systems-architect
- **Backend APIs** → @backend-architect
- **Cloud infrastructure** → @cloud-architect
- **GraphQL** → @graphql-architect
```

**Pros**:
- Helps users make right choice
- Educational
- No code changes needed

**Cons**:
- Documentation overhead
- Requires maintenance

---

## Migration Recommendations

### Immediate Actions (Week 1)

1. **Rename Core Agents**
   - [ ] `/agents/architect.md` → `/agents/systems-architect.md`
   - [ ] `/agents/code-reviewer.md` → `/agents/config-safety-reviewer.md`
   - [ ] `/agents/debugger.md` → `/agents/root-cause-analyzer.md`

2. **Add Metadata Tags**
   - [ ] Add `level: strategic` to `/agents/security-auditor.md`
   - [ ] Add `level: tactical` to `/sources/agents/security-auditor.md`
   - [ ] Add depth/specialization tags to performance agents

3. **Create Disambiguation Guides**
   - [ ] Create `docs/AGENT-DISAMBIGUATION.md`
   - [ ] Update each category README with "Which agent to use?"
   - [ ] Add cross-references in agent descriptions

---

### Short-Term Actions (Weeks 2-3)

4. **Consolidate Duplicates**
   - [ ] Merge `code-refactoring-expert` into `refactor-expert`
   - [ ] Merge `performance-optimizer` into `performance-tuner`
   - [ ] Merge `systems-architect` versions

5. **Update Cross-References**
   - [ ] Update all `@agent-name` mentions in documentation
   - [ ] Update command orchestrations (/review, /test-gen, etc.)
   - [ ] Update workflow examples

6. **Validation**
   - [ ] Test all renamed agents with `@new-name`
   - [ ] Verify YAML frontmatter is valid
   - [ ] Check all cross-references work

---

### Long-Term Actions (Month 1)

7. **Documentation**
   - [ ] Update CLAUDE.md with new agent names
   - [ ] Update all examples in documentation/
   - [ ] Create video/tutorial showing agent selection

8. **Migration Guide**
   - [ ] Create migration guide for existing users
   - [ ] Document breaking changes
   - [ ] Provide transition period with deprecation warnings

---

## Disambiguation Guide

### Quick Reference: Which Agent to Use?

#### Code Review

| Need | Agent | Location | Invocation |
|------|-------|----------|------------|
| **Configuration safety** | config-safety-reviewer | /agents/ | `@config-safety-reviewer` |
| **General code quality** | code-reviewer | /sources/agents/ | `@code-reviewer` |
| **Security focus** | security-auditor (strategic) | /agents/ | `@security-auditor` |
| **Refactoring** | refactor-expert | /agents/ | `@refactor-expert` |

---

#### Debugging

| Need | Agent | Location | Invocation |
|------|-------|----------|------------|
| **Root cause analysis** | root-cause-analyzer | /agents/ | `@root-cause-analyzer` |
| **Quick debugging** | debugger | /sources/agents/ | `@debugger` |
| **Error patterns** | error-detective | /sources/agents/ | `@error-detective` |

---

#### Architecture

| Need | Agent | Location | Invocation |
|------|-------|----------|------------|
| **System design** | systems-architect | /agents/ | `@systems-architect` |
| **Backend APIs** | backend-architect | /sources/agents/ | `@backend-architect` |
| **Cloud infrastructure** | cloud-architect | /sources/agents/ | `@cloud-architect` |
| **GraphQL** | graphql-architect | /sources/agents/ | `@graphql-architect` |
| **Architecture review** | architect-review | /sources/agents/ | `@architect-review` |
| **Documentation structure** | docs-architect | /sources/agents/ | `@docs-architect` |

---

#### Security

| Need | Agent | Location | Invocation |
|------|-------|----------|------------|
| **Strategic audit** | security-auditor | /agents/ | `@security-auditor` (level: strategic) |
| **Tactical implementation** | security-auditor | /sources/agents/ | `@security-auditor` (level: tactical) |
| **Threat modeling** | security-threat-analyst | /sources/agents/core/ | `@security-threat-analyst` |
| **Incident response** | incident-responder | /sources/agents/ | `@incident-responder` |

---

#### Performance

| Need | Agent | Location | Invocation |
|------|-------|----------|------------|
| **General optimization** | performance-tuner | /agents/ | `@performance-tuner` |
| **Database optimization** | database-optimizer | /sources/agents/ | `@database-optimizer` |
| **Performance testing** | performance-benchmarker | /sources/agents/testing/ | `@performance-benchmarker` |

---

#### Testing

| Need | Agent | Location | Invocation |
|------|-------|----------|------------|
| **Comprehensive testing** | test-engineer | /agents/ | `@test-engineer` |
| **QA mindset** | qa-test-engineer | /sources/agents/core/ | `@qa-test-engineer` |
| **Test automation** | test-automator | /sources/agents/ | `@test-automator` |
| **API testing** | api-tester | /sources/agents/testing/ | `@api-tester` |

---

#### Documentation

| Need | Agent | Location | Invocation |
|------|-------|----------|------------|
| **User guides** | docs-writer | /agents/ | `@docs-writer` |
| **API documentation** | api-documenter | /sources/agents/ | `@api-documenter` |
| **Documentation architecture** | docs-architect | /sources/agents/ | `@docs-architect` |
| **Tutorials** | tutorial-engineer | /sources/agents/ | `@tutorial-engineer` |

---

## Summary

### Conflicts Identified

- **Exact Duplicates**: 3 (code-reviewer, debugger, security-auditor)
- **Functional Overlap**: 7 groups (20+ agents)
- **Naming Ambiguity**: 4 critical cases

### Resolution Actions

1. **Rename core agents** for clarity:
   - architect → systems-architect
   - code-reviewer → config-safety-reviewer
   - debugger → root-cause-analyzer

2. **Add metadata tags** for specialization:
   - level: strategic/tactical
   - depth: comprehensive/lightweight
   - specialization: backend/cloud/etc.

3. **Consolidate duplicates**:
   - Merge code-refactoring-expert into refactor-expert
   - Merge performance-optimizer into performance-tuner
   - Merge systems-architect versions

4. **Create disambiguation guides**:
   - Decision trees for each domain
   - Quick reference tables
   - Cross-references in READMEs

### Impact

- **User Experience**: Clearer agent selection, reduced confusion
- **Maintainability**: Fewer duplicates, single source of truth
- **Scalability**: Clear patterns for adding new agents

---

**See Also**:
- [Agent Inventory](AGENT-INVENTORY.md)
- [Agent Categorization](AGENT-CATEGORIZATION.md)
- [Agent Dependencies](AGENT-DEPENDENCIES.md)
- [Sub-Agent Structure](SUB-AGENT-STRUCTURE.md)
