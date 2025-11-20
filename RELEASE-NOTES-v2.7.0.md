# Claude Code Tresor v2.7.0 - Release Notes

**Release Date:** November 19, 2025
**Release Type:** Major Feature Release
**Backward Compatibility:** ✅ Fully backward compatible (no breaking changes)

---

## 🎉 Overview

Claude Code Tresor v2.7.0 is a **major release** introducing the **Intelligent Orchestration System** - 10 production-grade commands that coordinate multiple specialist agents for complex development tasks. This release also includes the **Tresor Workflow Framework**, comprehensive documentation overhaul, and agent structure consolidation.

**Highlights:**
- 🚀 **10 NEW Orchestration Commands** (12,682 lines of intelligent orchestration)
- 🤖 **Intelligent Agent Selection** from 141-agent ecosystem
- 🔄 **Multi-Phase Orchestration** with dependency verification
- 📚 **4 Comprehensive Guides** (1,401 lines of documentation)
- 🔗 **Complete Workflow Integration** (auto-todo creation, meta-prompting, session handoff)
- 📦 **Agent Consolidation** to `/subagents/` (backward compatible)

---

## 🚀 New Features

### 10 Orchestration Commands

#### 🔒 Security Commands (3)

**`/audit` - Comprehensive Security Audit**
- **Duration:** 2-4 hours
- **Phases:** 4 (1 parallel + 3 sequential)
- **Agents:** 4-5 intelligently selected
- **Features:**
  - OWASP Top 10 vulnerability scanning
  - Infrastructure security review (AWS, Kubernetes, Docker)
  - Active penetration testing (read-only, safe)
  - Comprehensive root cause analysis
- **Output:** Security findings, todos, expert prompts, consolidated report
- **Use Case:** Quarterly security reviews, pre-audit preparation

**`/vulnerability-scan` - CVE & Dependency Scanning**
- **Duration:** 30-60 minutes
- **Phases:** 3 (1 parallel + 2 sequential/conditional)
- **Agents:** 2-4 intelligently selected
- **Features:**
  - NVD/GitHub Advisories correlation
  - Dependency tree analysis (transitive vulnerabilities)
  - SAST code pattern matching
  - Exploit correlation (Exploit-DB, Metasploit)
  - **Auto-remediation** (`--auto-fix` flag)
- **Output:** Vulnerability list with fix commands, auto-upgrades
- **Use Case:** Weekly security scans, CI/CD integration, pre-deployment checks

**`/compliance-check` - Regulatory Compliance Validation**
- **Duration:** 1-2 hours
- **Phases:** 4 (1 parallel + 3 sequential)
- **Agents:** 3-6 based on frameworks
- **Features:**
  - Multi-framework: GDPR, SOC2, HIPAA, PCI-DSS, ISO 27001, CCPA
  - Data flow mapping (PII/PHI tracking)
  - Technical control validation (encryption, access controls, logging)
  - Third-party processor assessment
  - **Auditor-ready reports** (65+ pages)
- **Output:** Compliance reports, gap analysis, remediation roadmap
- **Use Case:** Pre-audit preparation, compliance certification, regulatory validation

---

#### ⚡ Performance Commands (2)

**`/profile` - Performance Profiling**
- **Duration:** 15 minutes - 2 hours
- **Phases:** 3 (1 parallel + 2 sequential)
- **Agents:** 3-5 based on layers
- **Features:**
  - Multi-layer profiling (frontend, backend, database)
  - Core Web Vitals (LCP, FID, CLS)
  - Database query optimization (EXPLAIN ANALYZE)
  - Bundle size analysis
  - Root cause analysis for bottlenecks
  - Quick wins prioritization (impact × ease)
  - Before/after metrics predictions
- **Output:** Bottleneck analysis, optimization roadmap, performance baseline
- **Use Case:** Find performance issues, optimize slow endpoints, reduce page load time

**`/benchmark` - Load Testing**
- **Duration:** 5-30 minutes
- **Phases:** 3 (scenario generation + execution + analysis)
- **Agents:** 2-4 based on pattern
- **Features:**
  - Intelligent scenario generation (auto-detects API endpoints)
  - Multiple test patterns (baseline, stress, spike, soak, scalability)
  - Multi-tool support (Locust, Artillery, k6, JMeter)
  - Breaking point detection
  - Capacity planning with cost-benefit analysis
- **Output:** Load test results, breaking point, capacity recommendations
- **Use Case:** Validate optimizations, capacity planning, Black Friday preparation

---

#### 🔧 Operations Commands (3)

**`/deploy-validate` - Pre-Deployment Validation**
- **Duration:** 10-20 minutes
- **Phases:** 3 (1 parallel + 2 sequential)
- **Agents:** 3-4 intelligently selected
- **Features:**
  - Complete test suite execution (unit, integration, E2E)
  - Configuration safety review (prevent config-related outages)
  - Security pre-deployment scan
  - Environment readiness validation
  - Database migration validation
  - **Risk assessment scoring**
  - **Go/No-Go decision** with rationale
  - Rollback plan verification
- **Output:** Deployment approval/block, risk report, monitoring checklist
- **Use Case:** Before every production deployment, hotfix validation

**`/health-check` - System Health Verification**
- **Duration:** 5-15 minutes
- **Phases:** 3 (1 parallel + 2 optional)
- **Agents:** 3-4 based on comprehensive mode
- **Features:**
  - Multi-layer health checks (application, database, infrastructure)
  - Anomaly detection (compare current vs historical metrics)
  - Business metrics validation
  - External dependency verification
  - Alert generation (PagerDuty, Slack integration)
  - Trend analysis
- **Output:** Health status, anomalies, alerts, recommendations
- **Use Case:** Post-deployment verification, continuous monitoring, incident detection

**`/incident-response` - Production Incident Coordination**
- **Duration:** 30 minutes - 2 hours
- **Phases:** 4 (triage + parallel investigation + RCA + postmortem)
- **Agents:** 3-5 based on severity
- **Features:**
  - **Emergency triage** (5-10 min immediate response)
  - Parallel specialist investigation (backend, database, infrastructure)
  - Comprehensive RCA with detailed timeline
  - **Blameless postmortem** generation
  - Action item tracking
  - Communication templates
- **Output:** Triage report, investigation results, RCA, postmortem, action items
- **Use Case:** Production outages, performance incidents, security breaches

---

#### 📊 Quality Commands (2)

**`/code-health` - Codebase Health Assessment**
- **Duration:** 20-40 minutes
- **Phases:** 3 (1 parallel + 2 sequential)
- **Agents:** 3-4 intelligently selected
- **Features:**
  - Code quality metrics (complexity, duplication, code smells)
  - Test coverage analysis (unit, integration, E2E)
  - Documentation assessment (comments, API docs, README)
  - **Maintainability scoring** (0-10 health rating)
  - Best practices compliance
- **Output:** Health score, quality breakdown, improvement roadmap
- **Use Case:** Quarterly quality reviews, before major refactors, track quality trends

**`/debt-analysis` - Technical Debt Identification**
- **Duration:** 30-60 minutes
- **Phases:** 3 (1 parallel + 2 sequential)
- **Agents:** 3-4 based on categories
- **Features:**
  - Multi-category debt (architecture, code, test, documentation)
  - **Cost quantification** (time wasted per debt item in hours/month)
  - **Risk assessment** (probability × impact)
  - **Effort estimation** (hours to fix)
  - **ROI-based prioritization** (cost saved ÷ effort)
  - Strategic refactoring roadmap
- **Output:** Debt inventory, cost analysis, prioritized roadmap
- **Use Case:** Plan refactoring, prioritize technical debt, justify refactoring investment

---

### Tresor Workflow Framework

**Rebranded from TÂCHES:**
- Removed all TÂCHES references, replaced with Tresor Workflow Framework
- Updated 9 files with new branding
- Maintained clean git history

**Command Renames (Clean Names):**
- `/create-prompt` → `/prompt-create`
- `/run-prompt` → `/prompt-run`
- `/add-to-todos` → `/todo-add`
- `/check-todos` → `/todo-check`
- `/whats-next` → `/handoff-create`

**Complete Integration:**
All 10 orchestration commands automatically integrate with:
- **`/todo-add`** - Auto-capture all findings as structured todos
- **`/prompt-create`** - Generate expert prompts for complex fixes
- **`/handoff-create`** - Enable multi-session orchestrations
- **`/todo-check`** - Systematic remediation with agent suggestions

---

### Agent Structure Consolidation

**Primary Location:** `/subagents/` (133 total agents)
- 8 core agents in `/subagents/core/`
- 125 specialized agents across 9 team categories
- Color-coded organization
- Comprehensive AGENT-INDEX.md

**Backward Compatibility:** `/agents/` directory
- Maintained with symlinks to `/subagents/core/`
- All existing agent invocations work identically
- Deprecation timeline: Removal in v3.0.0 (Q2 2026)

**Migration:**
- See [MIGRATION.md](MIGRATION.md) for upgrade guide
- No action required (symlinks ensure compatibility)
- Recommended: Update references to `/subagents/core/` for future-proofing

---

### Documentation Overhaul

**New Comprehensive Guides:**

**NAVIGATION.md** (282 lines)
- Complete repository navigation
- Where to find agents, commands, skills, prompts
- Quick reference by task type, domain, language
- Repository structure overview

**MIGRATION.md** (404 lines)
- Upgrade guides for v2.6, v2.5, v2.4, v2.0-2.3
- Step-by-step migration instructions
- Breaking changes documentation (from previous versions)
- Deprecation timeline
- Troubleshooting guide

**WORKFLOW-GUIDE.md** (715 lines)
- Complete Tresor Workflow Framework guide
- Detailed command documentation
- 5 workflow patterns with examples
- Best practices and performance tips
- Tresor ecosystem integration

**CHANGELOG.md**
- Complete version history
- Semantic versioning compliance
- Migration guides
- Deprecation notices

---

## 🎯 Key Innovations

### 1. Intelligent Agent Selection
**Industry-First:** Auto-select from 141 specialized agents based on tech stack

**How it works:**
- Scans codebase for languages, frameworks, databases, infrastructure
- Ranks 141 agents by confidence score
- Selects top N agents for each phase (max 3 parallel)

**Example:**
```
Detected: React + Express + PostgreSQL + AWS
Selected:
- Phase 1: @security-auditor, @react-security-specialist, @dependency-auditor
- Phase 2: @cloud-architect
- Phase 3: @penetration-tester
```

---

### 2. Dependency Verification
**Industry-First:** Conflict detection for safe parallel agent execution

**Verification Checks:**
- ✅ No file write conflicts (2 agents writing same file)
- ✅ No data dependencies (Agent B needs Agent A's output)
- ✅ No read-write conflicts (Agent A writes what Agent B reads)

**Auto-Fallback:**
If conflicts detected → Prompts user to run sequentially for safety

---

### 3. Multi-Phase Orchestration
**Parallel + Sequential Execution:**

**Typical Pattern:**
- **Phase 1:** Parallel (3 agents investigate simultaneously)
- **Phase 2:** Sequential (1 agent with Phase 1 context)
- **Phase 3:** Sequential (1 agent with full context)
- **Phase 4:** Conditional (only if needed based on findings)

**Context Handoff:**
- Each phase creates handoff document for next phase
- Agents receive complete context from prior phases
- Enables multi-session orchestrations (pause/resume)

---

### 4. Complete Workflow Integration
**Auto-Integration with 4 Workflow Commands:**

**`/todo-add` Integration:**
```javascript
// Every critical/high finding → auto-created todo
for (const finding of criticalFindings) {
  await SlashCommand({ command: `/todo-add "${finding}"` });
}
```

**`/prompt-create` Integration:**
```javascript
// Complex architectural fixes → expert prompts
if (complexIssue) {
  await SlashCommand({ command: `/prompt-create "${issue}"` });
}
```

**`/handoff-create` Integration:**
```javascript
// Multi-hour orchestrations → session handoff
if (duration > 2hours) {
  suggestHandoff();  // User can resume in next session
}
```

**`/todo-check` Integration:**
```javascript
// After orchestration → systematic remediation
// System suggests optimal agents for each todo
```

---

## 📦 Installation

### New Installation

```bash
# Clone repository
git clone https://github.com/alirezarezvani/claude-code-tresor.git
cd claude-code-tresor

# Full installation (includes 10 orchestration commands)
./scripts/install.sh

# Or install only orchestration commands
./scripts/install.sh --orchestration
```

### Upgrade from v2.6.0 or Earlier

```bash
# Navigate to repository
cd claude-code-tresor

# Pull latest changes
git pull origin main

# Reinstall
./scripts/install.sh
```

**No breaking changes** - All existing workflows continue to work.

See [MIGRATION.md](MIGRATION.md) for detailed upgrade instructions.

---

## 🎯 Usage Examples

### Security Workflow

```bash
# Quarterly comprehensive security audit
/audit

# Weekly vulnerability scanning
/vulnerability-scan --depth deep

# Auto-fix safe vulnerabilities
/vulnerability-scan --auto-fix

# GDPR compliance validation
/compliance-check --frameworks gdpr

# After findings, systematic remediation:
/todo-check
# → Select todo
# → System suggests optimal agent
# → Fix issue
```

---

### Performance Workflow

```bash
# Find bottlenecks
/profile --layers frontend,backend,database

# Review findings
cat .tresor/profile-*/final-performance-report.md
# → Found: Missing database index, large bundle, no caching

# Fix bottlenecks (implement quick wins)
/todo-check
# → Add database index (15 min) → -705ms
# → Enable compression (30 min) → -1.6s

# Validate improvements with load testing
/benchmark --duration 5m --rps 100
# → Before: P95 = 680ms
# → After: P95 = 200ms (-70% improvement) ✓

# Find new capacity limits
/benchmark --pattern stress
# → Breaking point: 150 RPS → 800 RPS (5.3x improvement)
```

---

### Operations Workflow

```bash
# Before deploying to production
/deploy-validate --env production

# Result: GO WITH CAUTION (risk: 35/100)
# - All tests passed ✓
# - 2 config warnings (non-blocking)
# - Post-deployment todos created

# Deploy to production
kubectl apply -f k8s/production/

# Verify deployment health
/health-check --comprehensive

# Result: HEALTHY ✓
# - All services responding
# - No anomalies detected
# - P95 latency within normal range

# If incident occurs
/incident-response --severity p0

# Emergency triage → Investigation → RCA → Postmortem
# Blameless postmortem generated with action items
```

---

### Quality Workflow

```bash
# Assess codebase health
/code-health

# Result: 7.3/10 (GOOD)
# - Code quality: 7.5/10
# - Test coverage: 8.2/10
# - Documentation: 6.5/10
# - Maintainability: 7.2/10

# Deep-dive into technical debt
/debt-analysis --prioritize roi

# Result: 47 debt items, 450 hours total cost
# Top ROI:
# 1. Add caching (16h effort, 60h/month saved, ROI: 3.75)
# 2. Refactor god classes (40h effort, 15h/month saved, ROI: 0.375)

# Plan refactoring based on ROI
/todo-check
# → Implement high-ROI debt fixes first

# After refactoring, re-assess
/code-health
# → Improved: 7.3 → 8.5 (+1.2 points)
```

---

## 🤖 Intelligent Features

### Auto-Detection

**Tech Stack Detection:**
```
Analyzing codebase...

Detected:
- Languages: JavaScript, TypeScript, Python
- Frameworks: React, Express, Django
- Databases: PostgreSQL, Redis
- Infrastructure: Kubernetes, AWS
- Authentication: JWT

Based on detection, selected optimal agents:
- @react-security-specialist (React vulnerabilities)
- @backend-performance-tuner (Express optimization)
- @database-optimizer (PostgreSQL query optimization)
- @kubernetes-sre (K8s health checks)
```

**No Manual Configuration Required!**

---

### Multi-Phase Orchestration

**Example: `/audit` Execution**

```
Phase 1 (Parallel - 25 minutes):
  ✓ @security-auditor → 4 findings
  ✓ @react-security-specialist → 3 findings
  ✓ @dependency-auditor → 5 findings

Phase 2 (Sequential - 30 minutes):
  → @cloud-architect (received Phase 1 context)
  → 5 infrastructure findings

Phase 3 (Sequential - 50 minutes):
  → @penetration-tester (received Phase 1-2 context)
  → 3 exploitable vulnerabilities confirmed

Phase 4 (Sequential - 40 minutes):
  → @root-cause-analyzer (comprehensive RCA)
  → Root causes identified, preventive measures recommended

Total: 2h 25m, 20 findings, 18 todos, 2 expert prompts
```

---

### Dependency Verification

**Before Parallel Execution:**

```javascript
Verifying Phase 1 agents can run in parallel...

✓ File write conflicts: None
  - @security-auditor writes to phase-1-security.md
  - @react-security-specialist writes to phase-1-react.md
  - @dependency-auditor writes to phase-1-dependencies.md
  - No conflicts ✓

✓ Data dependencies: None
  - All agents analyze independently
  - No Agent B needs Agent A's output ✓

✓ Read-write conflicts: None
  - All agents read source code (read-only)
  - No agent writes what another reads ✓

Result: SAFE for parallel execution
```

**If Conflicts Detected:**
```
⚠️ Dependency conflicts detected:
- Agent A and Agent B both write to config.json
- Agent C reads config.json (conflict with A and B)

Options:
1. Run sequentially (safe but slower)
2. Review conflicts manually
3. Cancel orchestration

[User selects sequential] → Agents run one by one
```

---

## 🔗 Tresor Workflow Integration

### Auto-Capture Findings

**Every orchestration command auto-creates todos:**

```bash
# During /audit execution:
/todo-add "Fix SQL injection in src/api/users.ts:45-67"
/todo-add "Upgrade lodash@4.17.15 to fix CVE-2024-12345"
/todo-add "Implement GDPR data portability API"

# Result: 18 todos created with:
# - File locations and line numbers
# - Severity ratings
# - Fix estimates
# - Root causes
```

---

### Auto-Generate Expert Prompts

**Complex fixes trigger prompt generation:**

```bash
# During /compliance-check, complex architectural issue found:
/prompt-create "Design zero-trust microservices architecture for GDPR compliance"

# Generated prompt includes:
# - Project standards from CLAUDE.md
# - Suggested agents: @systems-architect, @backend-architect, @security-auditor
# - Anti-overengineering principles
# - Maintainability constraints (300 line limit)

# Execute prompt:
/prompt-run 001
# → Sub-agent performs comprehensive design
```

---

### Multi-Session Support

**Pause/Resume Long Orchestrations:**

```bash
# Day 1: Start comprehensive audit (runs 2 hours)
/audit

# After Phase 2, need to pause:
/handoff-create
# → Creates comprehensive session handoff
# → Saves: completed phases, remaining work, full context

# Day 2: Resume audit
/audit --resume --report-id audit-2025-11-19
# → Loads complete context
# → Continues from Phase 3
# → Zero information loss
```

---

## 📚 Documentation

### New Documentation (1,401 lines)

**[NAVIGATION.md](NAVIGATION.md)** - Find your way around
- Where to find agents, commands, skills, prompts
- Quick reference by task type and domain
- Repository structure overview

**[MIGRATION.md](MIGRATION.md)** - Upgrade guide
- Step-by-step for v2.6, v2.5, v2.4, v2.0-2.3 users
- Breaking changes from previous versions
- Deprecation timeline
- Troubleshooting common issues

**[WORKFLOW-GUIDE.md](WORKFLOW-GUIDE.md)** - Complete framework guide
- Detailed command documentation
- 5 workflow patterns with examples
- Best practices and performance tips
- Integration with Tresor ecosystem

**[CHANGELOG.md](CHANGELOG.md)** - Version history
- Semantic versioning
- Complete feature history
- Migration guides
- Deprecation notices

---

### Command Documentation (20 READMEs)

**Each README includes:**
- Overview and key features
- Quick start examples
- Detailed how-it-works section
- Command options documentation
- Integration with Tresor Workflow
- 3-4 complete workflow examples
- FAQ section
- Troubleshooting guide
- Links to related commands/agents

**Total:** 6,814 lines of comprehensive command documentation

---

## 🔄 Changes & Improvements

### Command Structure

**Before (v2.6.0):**
```
commands/
├── development/scaffold/
├── workflow/
│   ├── review.md (inconsistent)
│   ├── create-prompt/
│   └── ...
├── testing/test-gen/
└── documentation/docs-gen/
```

**After (v2.7.0):**
```
commands/
├── development/scaffold/
├── workflow/
│   ├── review/review.md (consistent)
│   ├── prompt-create/prompt-create.md
│   └── ... (all follow same pattern)
├── testing/test-gen/
├── documentation/docs-gen/
├── security/ (NEW)
├── performance/ (NEW)
├── operations/ (NEW)
└── quality/ (NEW)
```

**All commands now follow:** `/commands/[category]/[name]/[name].md`

---

### Agent Structure

**Before (v2.6.0):**
- `/agents/` - 8 core agents (README.md only, no agent.md)
- `/subagents/` - 133 agents (README.md + agent.md)
- Duplication and confusion

**After (v2.7.0):**
- `/subagents/` - PRIMARY (133 agents with agent.md files)
- `/agents/` - Symlinks to `/subagents/core/` (backward compatible)
- Clear deprecation notice and migration path

---

### Installation Script

**Added Features:**
- `--orchestration` flag for installing only orchestration commands
- `install_orchestration_commands()` function
- Updated help text with all options
- Enhanced summary showing orchestration commands

**Usage:**
```bash
./scripts/install.sh                # Full installation (all 19 commands)
./scripts/install.sh --orchestration  # Only 10 orchestration commands
./scripts/install.sh --commands      # All 19 commands
./scripts/install.sh --agents        # All 133 agents from /subagents/
```

---

## ⚠️ Breaking Changes

**None** - This release is fully backward compatible.

**Deprecations (Removal in v3.0.0):**
- `/agents/` directory (use `/subagents/core/` instead)
- Maintained via symlinks until v3.0.0 (Q2 2026)

---

## 🐛 Bug Fixes

- Fixed inconsistent command directory structure (`review.md` placement)
- Updated outdated agent names in `/agents/README.md` (v2.4 → v2.7 naming)
- Corrected agent count documentation (141 total, not 8 + 133)
- Fixed TÂCHES references (replaced with Tresor Workflow Framework)

---

## 📊 Statistics

### Code Metrics
- **New Code:** 17,221 insertions
- **Cleanup:** 370 deletions
- **Net Addition:** 16,851 lines
- **Files Changed:** 47 files
- **Commits:** 2 clean commits

### Command Breakdown
- **Security:** 4,466 lines (35%)
- **Performance:** 3,709 lines (29%)
- **Operations:** 5,229 lines (41%)
- **Quality:** 1,278 lines (10%)

### Documentation
- **Command READMEs:** 6,814 lines
- **Guide Documents:** 1,401 lines
- **Planning Docs:** 1,306 lines
- **Total Documentation:** 9,521 lines

---

## 🙏 Acknowledgments

- **Claude Code Team** - For creating an amazing platform
- **Open Source Community** - For inspiration and best practices
- **Early Testers** - For feedback and validation
- **Users** - For making this work meaningful

---

## 📞 Support

**Need Help?**
- 📋 [GitHub Issues](https://github.com/alirezarezvani/claude-code-tresor/issues) - Report bugs
- 💬 [GitHub Discussions](https://github.com/alirezarezvani/claude-code-tresor/discussions) - Ask questions
- 📖 [Documentation](documentation/README.md) - Complete guides
- 🗺️ [Navigation Guide](NAVIGATION.md) - Find your way around

**Upgrade Issues?**
- See [MIGRATION.md](MIGRATION.md) for step-by-step instructions
- See [Troubleshooting](documentation/guides/troubleshooting.md) for common issues

---

## 🔮 What's Next?

### v2.7.1 (Patch - December 2025)
- Bug fixes from community feedback
- Minor documentation improvements
- Command examples and demos

### v2.8.0 (Feature - Q1 2026)
- Enhanced orchestration features
- Additional specialized agents
- Improved CI/CD integration
- Deprecation warnings for v3.0.0 changes

### v3.0.0 (Major - Q2 2026)
- **Breaking:** Remove `/agents/` directory
- Simplified agent structure
- Performance optimizations
- New orchestration capabilities

---

## 📄 License

This release is licensed under the [MIT License](LICENSE).

---

## 🌟 Star History

If you find Claude Code Tresor valuable, please consider starring the repository!

**v2.7.0 brings:**
- 10 powerful orchestration commands
- Intelligent agent selection
- Multi-phase coordination
- Complete workflow integration
- Production-grade safety

Help others discover these tools by starring the repo! ⭐

---

**Made with ❤️ by [Alireza Rezvani](https://github.com/alirezarezvani)**

*Empowering developers with world-class Claude Code utilities*

---

**Release:** v2.7.0
**Date:** November 19, 2025
**Branch:** main
**Commits:** 2
**Download:** [Source code (zip)](https://github.com/alirezarezvani/claude-code-tresor/archive/refs/tags/v2.7.0.zip)
