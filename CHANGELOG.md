# Changelog

All notable changes to Claude Code Tresor will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [2.7.0] - 2025-11-19

### 🚀 Major Features

#### 10 New Orchestration Commands (12,682 lines)

**Security Commands (3):**
- Added `/audit` - Comprehensive security audit with OWASP Top 10, infrastructure review, penetration testing, and RCA
- Added `/vulnerability-scan` - CVE scanning, dependency analysis, SAST, exploit correlation, with auto-fix capability
- Added `/compliance-check` - Multi-framework compliance validation (GDPR, SOC2, HIPAA, PCI-DSS, ISO 27001, CCPA)

**Performance Commands (2):**
- Added `/profile` - Multi-layer performance profiling (frontend, backend, database) with bottleneck identification
- Added `/benchmark` - Intelligent load testing with scenario generation, stress/spike/soak patterns, capacity planning

**Operations Commands (3):**
- Added `/deploy-validate` - Pre-deployment validation with test execution, config safety, risk scoring, go/no-go decisions
- Added `/health-check` - System health verification with multi-layer checks, anomaly detection, alert generation
- Added `/incident-response` - Production incident coordination with emergency triage, parallel investigation, RCA, blameless postmortems

**Quality Commands (2):**
- Added `/code-health` - Codebase health assessment with quality metrics, test coverage, documentation, maintainability scoring
- Added `/debt-analysis` - Technical debt identification with cost quantification, risk assessment, ROI-based prioritization

**Key Features:**
- Intelligent agent selection (auto-detects tech stack, selects from 141 agents)
- Multi-phase orchestration (3-4 phases, parallel + sequential execution)
- Dependency verification (prevents conflicts in parallel execution)
- Full Tresor Workflow integration (auto-calls `/todo-add`, `/prompt-create`, `/handoff-create`)
- Production-grade safety (go/no-go decisions, rollback verification, risk scoring)
- Session resumption support (multi-hour orchestrations with context preservation)

#### Tresor Workflow Framework

- Rebranded TÂCHES → Tresor Workflow Framework
- Renamed workflow commands (removed `tresor-` prefix):
  - `/create-prompt` → `/prompt-create`
  - `/run-prompt` → `/prompt-run`
  - `/add-to-todos` → `/todo-add`
  - `/check-todos` → `/todo-check`
  - `/whats-next` → `/handoff-create`
- Updated all command frontmatter (YAML `name:` fields)
- Updated all documentation references

#### Agent Structure Consolidation

- **Primary Location:** `/subagents/` directory (133 total agents)
  - 8 core agents in `/subagents/core/`
  - 125 specialized agents across 9 team categories
- **Backward Compatibility:** `/agents/` directory maintained with symlinks to `/subagents/core/`
- Updated `/agents/README.md` with:
  - Deprecation notice
  - Migration guide
  - Symlink explanation
  - Deprecation timeline (removal in v3.0.0)

### ✨ Added

**Documentation:**
- **NAVIGATION.md** (282 lines) - Complete repository navigation guide
- **MIGRATION.md** (404 lines) - Upgrade guide for users on v2.6.0 or earlier
- **WORKFLOW-GUIDE.md** (715 lines) - Comprehensive Tresor Workflow Framework guide
- **ORCHESTRATION-COMMANDS-COMPLETE.md** - Complete implementation summary
- **orchestration-integration-architecture.md** - Integration architecture documentation
- 18 README files for orchestration commands (comprehensive examples and usage guides)
- 2 README files for quality commands

**Automation:**
- Added `install_orchestration_commands()` function in `scripts/install.sh`
- Added `--orchestration` flag for installing only orchestration commands

**Symlinks:**
- Created symlinks: `/agents/[name]/agent.md` → `/subagents/core/[name]/agent.md`
- All 8 core agents now accessible from both locations (backward compatible)

### 🔄 Changed

**Command Structure:**
- Reorganized workflow commands: moved `review.md` into `review/` directory
- All commands now follow consistent pattern: `/commands/[category]/[name]/[name].md`
- Updated command count: 9 → 19 total commands

**Documentation:**
- Updated README.md:
  - Version 2.7.0
  - New "What's New in v2.7.0" section
  - Command count updated (9 → 19)
  - Added collapsible sections for orchestration commands
  - Updated Project Stats section
- Updated CLAUDE.md:
  - Version 2.7.0
  - Added "Orchestration Commands" section with usage examples
  - Updated architecture diagram
  - Added installation examples with `--orchestration` flag
  - Updated agent location references (`/agents/` → `/subagents/core/`)
- Updated `scripts/install.sh`:
  - Added orchestration commands to summary output
  - Updated help text with `--orchestration` flag
  - Updated installation examples

**Agent Documentation:**
- Completely rewrote `/agents/README.md` (331 lines → 163 lines)
- Added deprecation notice
- Updated to v2.7.0 naming conventions
- Added symlink explanation and migration timeline

### 🗑️ Removed

**TÂCHES References:**
- Removed all TÂCHES branding (replaced with Tresor Workflow Framework)
- Updated 9 files to remove TÂCHES references
- Maintained proper attribution in commit history

**Old Command Files:**
- Deleted old workflow command files (moved/renamed):
  - `commands/workflow/create-prompt/create-prompt.md` → `prompt-create/prompt-create.md`
  - `commands/workflow/run-prompt/run-prompt.md` → `prompt-run/prompt-run.md`
  - `commands/workflow/add-to-todos/add-to-todos.md` → `todo-add/todo-add.md`
  - `commands/workflow/check-todos/check-todos.md` → `todo-check/todo-check.md`
  - `commands/workflow/whats-next/whats-next.md` → `handoff-create/handoff-create.md`
  - `commands/workflow/review.md` → `review/review.md`

### 🔧 Technical Details

**Code Statistics:**
- Total new code: 14,083+ lines
- Orchestration commands: 12,682 lines
- Documentation guides: 1,401 lines
- README files: 2,000+ lines
- 43 files changed (16,281 insertions, 366 deletions)

**Agent Utilization:**
- Core agents: 8/8 used (100%)
- Extended agents: 38+/133 leveraged (28%)
- Total agents in ecosystem: 141 (unchanged)

**Backward Compatibility:**
- ✅ No breaking changes
- ✅ All existing workflows continue to work
- ✅ Symlinks ensure old agent paths functional
- ✅ Deprecated paths maintained until v3.0.0

### 📊 Impact

**Repository Growth:**
- Commands: 9 → 19 (+111%)
- Code lines: ~15,000 → ~30,000 (+100%)
- Documentation quality: Comprehensive guides added

**Capabilities Added:**
- Security auditing and compliance validation
- Performance profiling and load testing
- Deployment safety and production monitoring
- Incident response and postmortem generation
- Code quality and technical debt analysis

**Developer Experience:**
- Intelligent orchestration reduces manual agent coordination
- Auto-detection of tech stack simplifies command usage
- Multi-session support enables complex long-running tasks
- Auto-integration with Tresor Workflow streamlines remediation

### 🐛 Bug Fixes

- Fixed inconsistent command directory structure (`review.md` placement)
- Updated outdated agent names in `/agents/README.md` (v2.4 → v2.7)
- Corrected agent count documentation (8 + 133 = 141, not 8 + 133)

### 📝 Documentation

**New Guides:**
- NAVIGATION.md - Find your way around the repository
- MIGRATION.md - Upgrade from v2.6.0 or earlier
- WORKFLOW-GUIDE.md - Complete Tresor Workflow Framework guide

**Improved:**
- README.md - Clear organization of 19 commands by category
- CLAUDE.md - Added orchestration commands section with usage examples
- agents/README.md - Complete rewrite with deprecation notice and migration guide

### ⚠️ Deprecations

**Deprecated Paths (Removed in v3.0.0):**
- `/agents/` directory (use `/subagents/core/` instead)
- Backward compatible via symlinks until v3.0.0
- Migration warnings will be added in v2.8.0

**Deprecated Terminology:**
- "Core agents" and "subagents" distinction (all are now simply "agents" in `/subagents/`)
- Preferred: "141 agents organized by team" instead of "8 core + 133 subagents"

### 🔐 Security

- Added comprehensive security audit command (`/audit`)
- Added vulnerability scanning with auto-fix (`/vulnerability-scan`)
- Added compliance validation for 6 major frameworks (`/compliance-check`)
- All security commands include read-only testing (no destructive actions)
- Exploit correlation with public databases (Exploit-DB, Metasploit)

### ⚡ Performance

- Added performance profiling with Core Web Vitals (`/profile`)
- Added load testing with intelligent scenario generation (`/benchmark`)
- Support for multiple test patterns (baseline, stress, spike, soak)
- Breaking point detection and capacity planning
- Cost-benefit analysis for infrastructure scaling

### 🔧 Operations

- Added pre-deployment validation with go/no-go decisions (`/deploy-validate`)
- Added system health checks with anomaly detection (`/health-check`)
- Added incident response coordination with blameless postmortems (`/incident-response`)
- Risk scoring for deployment decisions
- Alert integration (PagerDuty, Slack)

---

## [2.6.0] - 2025-11-15

### Quality Excellence Release

- Achieved 9.7/10 exceptional quality rating
- Design category improved from 4.0 to 8.0/10 (+100% boost)
- Added 12 enhanced examples to key agents
- Improved consistency across 9 specialized agents
- Added best practices to config-safety-reviewer and security-auditor
- Created collaboration guide for cross-team workflows
- Streamlined documentation (21 files → 3 guides + archive)

**Backward Compatible** - No breaking changes from v2.5.0

---

## [2.5.0] - 2025-11-15

### Agent Reorganization & Extension

- **New Structure:** `subagents/` directory with 10 color-coded team categories
- **141 Total Agents:** 8 core + 133 subagents across all development domains
- **Core Agent Renaming:**
  - `@architect` → `@systems-architect`
  - `@code-reviewer` → `@config-safety-reviewer`
  - `@debugger` → `@root-cause-analyzer`
- **Color Coding System:** Visual team identification (10 team colors)
- **Comprehensive Documentation:** 450KB of guides, catalogs, references

**BREAKING CHANGES:**
- Agent name changes (see above)
- Update all `@architect`, `@code-reviewer`, `@debugger` references

---

## [2.0.0] - 2025-10-01

### Skills Layer Introduction

- **8 Autonomous Skills:** Automatic background helpers
- **Development Skills:** code-reviewer, test-generator, git-commit-helper
- **Security Skills:** security-auditor, secret-scanner, dependency-auditor
- **Documentation Skills:** api-documenter, readme-updater
- Skills activate automatically (no manual invocation)
- Lightweight tool access for safety

---

## [1.0.0] - 2025-09-16

### Initial Release

- **8 Core Agents:** Expert sub-agents for development tasks
- **4 Slash Commands:** Project scaffolding, code review, test generation, documentation
- **20+ Prompts:** Battle-tested templates
- **Development Standards:** Style guides and workflows
- **Examples:** Real-world workflow demonstrations
- **Installation Scripts:** One-command setup

---

## Version History Summary

| Version | Date | Highlights |
|---------|------|------------|
| **2.7.0** | 2025-11-19 | 10 orchestration commands, Tresor Workflow Framework, agent consolidation |
| **2.6.0** | 2025-11-15 | Quality excellence (9.7/10 rating), enhanced examples |
| **2.5.0** | 2025-11-15 | 141 agents, color-coded teams, subagents directory |
| **2.0.0** | 2025-10-01 | Skills layer (8 autonomous helpers) |
| **1.0.0** | 2025-09-16 | Initial release (8 agents, 4 commands, prompts) |

---

## Migration Guides

- **v2.6.x → v2.7.0:** See [MIGRATION.md](MIGRATION.md)
- **v2.5.x → v2.7.0:** See [MIGRATION.md](MIGRATION.md)
- **v2.4.x → v2.7.0:** See [MIGRATION.md](MIGRATION.md) (includes agent name changes)
- **v2.0-2.3.x → v2.7.0:** See [MIGRATION.md](MIGRATION.md) (clean installation recommended)

---

## Deprecation Notices

### Deprecated in v2.7.0 (Removal in v3.0.0)

**Paths:**
- `/agents/` directory → Use `/subagents/core/` instead
- Backward compatible via symlinks until v3.0.0

**Terminology:**
- "Core agents" vs "subagents" distinction → Use "agents organized by team"

### Removed in v2.7.0

- TÂCHES branding (replaced with Tresor Workflow Framework)
- Old workflow command file locations (reorganized for consistency)

---

## Upcoming Features

### Planned for v2.8.0 (Q1 2026)

- Enhanced orchestration command features
- Additional specialized agents
- Improved CI/CD integration
- Performance optimizations

### Planned for v3.0.0 (Q2 2026)

**Breaking Changes:**
- Remove `/agents/` directory (use `/subagents/core/`)
- Remove backward compatibility symlinks
- Potentially consolidate `/subagents/` → `/agents/` with new structure

---

## Contributors

- **Alireza Rezvani** - Creator and maintainer
- **Community Contributors** - Bug reports, feature suggestions, testing

---

## License

All versions are released under the [MIT License](LICENSE).

---

**Latest Version:** 2.7.0
**Last Updated:** November 19, 2025
**Repository:** https://github.com/alirezarezvani/claude-code-tresor
