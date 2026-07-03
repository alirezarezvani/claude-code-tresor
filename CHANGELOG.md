# Changelog

All notable changes to Claude Code Tresor will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [3.0.0](https://github.com/alirezarezvani/claude-code-tresor/compare/v2.7.0...v3.0.0) (2026-07-03)


### ⚠ BREAKING CHANGES

* Core agents renamed - update invocations:   @architect → @systems-architect   @code-reviewer → @config-safety-reviewer   @debugger → @root-cause-analyzer
* Core agents renamed - update invocations:   @architect → @systems-architect   @code-reviewer → @config-safety-reviewer   @debugger → @root-cause-analyzer
* Core agents renamed - update invocations:   @architect → @systems-architect   @code-reviewer → @config-safety-reviewer   @debugger → @root-cause-analyzer

### Release

* v2.7.0 - 10 Orchestration Commands + Tresor Workflow Framework ([#49](https://github.com/alirezarezvani/claude-code-tresor/issues/49)) ([cb2780f](https://github.com/alirezarezvani/claude-code-tresor/commit/cb2780f40af1e9dc2c8cdf1ac48dadde656bb6a5))


### Dev

* Added Meta prompting Slash commands into the Claude Code Tresor ([#31](https://github.com/alirezarezvani/claude-code-tresor/issues/31)) ([6b8f3ad](https://github.com/alirezarezvani/claude-code-tresor/commit/6b8f3ada42a043009951defe1e00739248473962))


### Features

* add CLAUDE.md development guide ([3f02f90](https://github.com/alirezarezvani/claude-code-tresor/commit/3f02f9093aa272f4f54fc7370481a3f6b1065098))
* add comprehensive best practices to 2 core agents ([fbd1756](https://github.com/alirezarezvani/claude-code-tresor/commit/fbd175657f912fc5effd9dbde9c71e4210abd77e))
* add comprehensive technical documentation and subagents structure ([5e4f3c8](https://github.com/alirezarezvani/claude-code-tresor/commit/5e4f3c809e8be72183bd66689d5df7b2850aa2f6))
* add comprehensive usage examples to 4 agents for v2.6 ([3657f97](https://github.com/alirezarezvani/claude-code-tresor/commit/3657f9703c08c48ba073cc7d8edb680a3bdd860f))
* add standard sections to 9 specialized agents for v2.6 ([8b0fbd9](https://github.com/alirezarezvani/claude-code-tresor/commit/8b0fbd9b2bf0c0e01fcad745fa6e0f3602137031))
* **agents:** complete Phase 2 agent-skill integration rollout ([052c244](https://github.com/alirezarezvani/claude-code-tresor/commit/052c244d3e7441b3c4969601ad2fc0fbaaac13a4))
* **agents:** enable agent-skill integration for multi-tier validation ([ccbd016](https://github.com/alirezarezvani/claude-code-tresor/commit/ccbd0162535b2dabe523c5dc95b710f81c2cdf3e))
* **automation:** add GitHub issue and project automation system ([#10](https://github.com/alirezarezvani/claude-code-tresor/issues/10)) ([7f930a0](https://github.com/alirezarezvani/claude-code-tresor/commit/7f930a0468d073b5a44518d45a8ca5349085ce2d))
* **ci:** enforce dev → main only PR policy ([fdc3114](https://github.com/alirezarezvani/claude-code-tresor/commit/fdc3114aa25786d65e9b575b7daea37551802ec1))
* **ci:** skip slow Claude checks for release PRs ([7a07c8f](https://github.com/alirezarezvani/claude-code-tresor/commit/7a07c8fe61be29ae1eec4e673e5eabdade4cb4fc))
* complete agent migration - all 133 subagents organized ([83f01b8](https://github.com/alirezarezvani/claude-code-tresor/commit/83f01b894333bc1995a9b16a9367eff737f6180e))
* complete agent-skill integration + fix issue [#20](https://github.com/alirezarezvani/claude-code-tresor/issues/20) ([#23](https://github.com/alirezarezvani/claude-code-tresor/issues/23)) ([e405894](https://github.com/alirezarezvani/claude-code-tresor/commit/e4058946258996761d5fcc70fe61dda4fd3fc569))
* complete comprehensive framework refinement ([5dd81e7](https://github.com/alirezarezvani/claude-code-tresor/commit/5dd81e7f3b873dae146c5eba12eb687e78ba0a68))
* consolidate duplicate agents with enhanced capabilities ([5bbf8e0](https://github.com/alirezarezvani/claude-code-tresor/commit/5bbf8e08e0f977cb360f1c2d520332db6fe5b834))
* convert utilities to proper Claude Code format ([46987c9](https://github.com/alirezarezvani/claude-code-tresor/commit/46987c981da223882e7d1d807ce8d974bde68a9a))
* Convert utilities to proper Claude Code format and enhance documentation ([8417125](https://github.com/alirezarezvani/claude-code-tresor/commit/8417125dc2f747b7f54e0f111ccb9bda1ad5f1e7))
* initial release of Claude Code Tresor utilities collection ([97fc623](https://github.com/alirezarezvani/claude-code-tresor/commit/97fc6231ff4cc4b6fa04e24a03da75aed77fb783))
* integrate TÂCHES workflow framework - v2.6.5 ([#30](https://github.com/alirezarezvani/claude-code-tresor/issues/30)) ([cb6b023](https://github.com/alirezarezvani/claude-code-tresor/commit/cb6b02359d72faea89ee58c378a0f098a6a86312))
* migrate 8 core agents to subagents/core/ structure ([3d03520](https://github.com/alirezarezvani/claude-code-tresor/commit/3d035206ed16dc6831cec05dc21b23b84713171a))
* release v2.0.0 with autonomous Skills layer ([c895c83](https://github.com/alirezarezvani/claude-code-tresor/commit/c895c834924b10c625dbbdd90e79232c21759a66))
* rename core agents and create organized subagents structure ([cecbd8b](https://github.com/alirezarezvani/claude-code-tresor/commit/cecbd8bb978331f6f3c02d155ee9970fa3f5c0e5))
* restructure design category agents for v2.6 improvements ([2818f6f](https://github.com/alirezarezvani/claude-code-tresor/commit/2818f6f5b5e75bcc8bfdd90f66c6c393045e41c4))
* v2.7.0 - 10 Orchestration Commands + Tresor Workflow Framework ([#35](https://github.com/alirezarezvani/claude-code-tresor/issues/35)) ([d9138f2](https://github.com/alirezarezvani/claude-code-tresor/commit/d9138f2b7fb06d704d52e369fea32473c991e0a2))
* **workflow:** add workflow test verification document ([#9](https://github.com/alirezarezvani/claude-code-tresor/issues/9)) ([b8c76c1](https://github.com/alirezarezvani/claude-code-tresor/commit/b8c76c1fb46f7fc87b8ffe0725d23dfd1eaa0cc5))


### Bug Fixes

* add missing YAML fields and create agent index ([932abeb](https://github.com/alirezarezvani/claude-code-tresor/commit/932abebaa5f1020f83d770d467d1df76f314cff2))
* align install.sh options with documentation (closes [#4](https://github.com/alirezarezvani/claude-code-tresor/issues/4)) ([#8](https://github.com/alirezarezvani/claude-code-tresor/issues/8)) ([68ba825](https://github.com/alirezarezvani/claude-code-tresor/commit/68ba82537ec357b1ffb282e4f7d616cde25a28b3))
* **ci:** add timeouts to Claude workflows to prevent hangs ([6606802](https://github.com/alirezarezvani/claude-code-tresor/commit/6606802b5c56518221f146cdc78b23254c0db9e2))
* **ci:** disable body-max-line-length in commitlint ([63f992e](https://github.com/alirezarezvani/claude-code-tresor/commit/63f992ed9ab58dae47e06a16ddea68c22604b137))
* **ci:** resolve YAML linting issues in claude.yml ([77c9c07](https://github.com/alirezarezvani/claude-code-tresor/commit/77c9c079bce0479e9dbf704674d7b8809d5744c7))
* **ci:** skip branch naming validation for release PRs ([2595464](https://github.com/alirezarezvani/claude-code-tresor/commit/25954648b181041111a3625c4963017169a82a42))
* **ci:** skip commitlint validation for release PRs ([3be2f42](https://github.com/alirezarezvani/claude-code-tresor/commit/3be2f42e8f5f2c00c3410c5510898be67aebc1e8))
* correct installation path in update.sh and update documentation ([78af2b6](https://github.com/alirezarezvani/claude-code-tresor/commit/78af2b65d6b87b128a4a0be21639e90b2a03ab01))
* correct installation path in update.sh and update documentation ([#25](https://github.com/alirezarezvani/claude-code-tresor/issues/25)) ([d77ad8d](https://github.com/alirezarezvani/claude-code-tresor/commit/d77ad8dd808aacffb9c3185f43962133fc9fc5bf))
* critical installation script fixes for v2.7.0 ([#38](https://github.com/alirezarezvani/claude-code-tresor/issues/38)) ([6ebbbf7](https://github.com/alirezarezvani/claude-code-tresor/commit/6ebbbf71258965980290a863640d4f1fb67d844b))
* **docs:** correct installation path and skills behavior documentation ([1b7fdce](https://github.com/alirezarezvani/claude-code-tresor/commit/1b7fdce5410725c3809e431b09172a25dc4521ff))
* **docs:** sync command names with install script ([#55](https://github.com/alirezarezvani/claude-code-tresor/issues/55)) ([247e63f](https://github.com/alirezarezvani/claude-code-tresor/commit/247e63f10e653795c1c8fd435b0e5e5856933713))
* formatting in code-reviewer SKILL.md ([99730ec](https://github.com/alirezarezvani/claude-code-tresor/commit/99730ec602be07ea5a6bf6a7d2bf8307902e73df))
* organization validation fixes and final validation report ([3a15318](https://github.com/alirezarezvani/claude-code-tresor/commit/3a1531850c3a21478ff5b6bef8ce35986bc133bb))
* quote command argument-hint values and bug-fix install backup path ([d0d14cf](https://github.com/alirezarezvani/claude-code-tresor/commit/d0d14cfa1fb6dd7a63473974587c83a028e869a1))
* **test:** materialize main branch in smoke test before bare clone ([0d9b1cb](https://github.com/alirezarezvani/claude-code-tresor/commit/0d9b1cb23dc094942a391500062926d2f9499d63))
* update installers to support agent.md and README to v2.6.0 ([7226d31](https://github.com/alirezarezvani/claude-code-tresor/commit/7226d315c21a9bb48695093b13b9ebbd13708f63))


### Documentation

* add completion summary for agent-skill integration ([08a039a](https://github.com/alirezarezvani/claude-code-tresor/commit/08a039aa124f0a66d1207194b9d2d834a74b3d06))
* add comprehensive content structure validation report ([967a45d](https://github.com/alirezarezvani/claude-code-tresor/commit/967a45dd089fc790f58b03e6a7decafd3af9e3a7))
* add comprehensive cross-team collaboration guide for v2.6 ([c0d4f2a](https://github.com/alirezarezvani/claude-code-tresor/commit/c0d4f2aedf34bcd16821c1a619ee5f9045b7999e))
* add comprehensive README files for all 8 team categories ([0c039e9](https://github.com/alirezarezvani/claude-code-tresor/commit/0c039e99107d0348167182b05cc1f95a0c36632a))
* add comprehensive release notes for v2.5.0 ([b4500cf](https://github.com/alirezarezvani/claude-code-tresor/commit/b4500cf24415c4ef05843d753f1b5ccb26fbafe0))
* add comprehensive YAML frontmatter validation report ([f6d3784](https://github.com/alirezarezvani/claude-code-tresor/commit/f6d3784ca05462324624a1b0f6768059c00db5c4))
* add cross-reference and integration validation report ([362f34b](https://github.com/alirezarezvani/claude-code-tresor/commit/362f34bc400e1baff634da55529df6fc9708fc27))
* add migration progress tracker ([8592205](https://github.com/alirezarezvani/claude-code-tresor/commit/85922058ef5ec538e0a9d16d9c4371e3077f44a3))
* add project completion summary for v2.5.0 ([24cdd3a](https://github.com/alirezarezvani/claude-code-tresor/commit/24cdd3a0fc48dd1cdc33dccf2ae8de5840401a96))
* add v2.6 improvement plan based on validation findings ([c107e3b](https://github.com/alirezarezvani/claude-code-tresor/commit/c107e3b7610a965292ae129a8770688d8b62fb8f))
* clarify documentation link placeholder in docs-writer ([d986b6b](https://github.com/alirezarezvani/claude-code-tresor/commit/d986b6b688b55424bfa5ec5a8f6cf8706bedf1b2))
* comprehensive documentation restructuring and cleanup ([1636c51](https://github.com/alirezarezvani/claude-code-tresor/commit/1636c518b9fa6961a260738b4184122b83d6a1f1))
* consolidate 21 documentation files into 2 streamlined guides ([f54292f](https://github.com/alirezarezvani/claude-code-tresor/commit/f54292fc880b2ead41d5656ce70a7916c40b6be9))
* create comprehensive ecosystem roadmap and memory bank ([8315b40](https://github.com/alirezarezvani/claude-code-tresor/commit/8315b40a5c19b9b3b1d3e63a1d9bb79f2087b3b9))
* **ecosystem:** add comprehensive references to related repositories ([76799a6](https://github.com/alirezarezvani/claude-code-tresor/commit/76799a6ab7e414695250b06dbdbe560c3a404537))
* **ecosystem:** publish comprehensive SEO Gist and social media templates ([b8bbe2e](https://github.com/alirezarezvani/claude-code-tresor/commit/b8bbe2e8bcf89f5c502fbd4a146d2a649a24275d))
* improve Smithery badge placement in README ([#45](https://github.com/alirezarezvani/claude-code-tresor/issues/45)) ([28b6c88](https://github.com/alirezarezvani/claude-code-tresor/commit/28b6c88cf981fa328fd7e344bbd2a4c0e676e1cd))
* update all cross-references for renamed agents ([7ee6ab9](https://github.com/alirezarezvani/claude-code-tresor/commit/7ee6ab98136f90f1421626b7f0fdf9ee2a98f2de))
* update architecture description and contact information ([2a0331e](https://github.com/alirezarezvani/claude-code-tresor/commit/2a0331e48975338b5958702f522df260b5773228))
* update cross-references for renamed agents ([b0a24ec](https://github.com/alirezarezvani/claude-code-tresor/commit/b0a24ecc74624f4ca80c52c150a285c0dc1b7530))
* update v2.6.0 release notes with Phase 3 completion ([852a11b](https://github.com/alirezarezvani/claude-code-tresor/commit/852a11b73c264c586f7e154485607b3a1e22291d))
* **workflow:** add complete workflow simulation test results ([0a76c3b](https://github.com/alirezarezvani/claude-code-tresor/commit/0a76c3bb2be4730ce6cf668766de599a5c7cf73e))
* **workflow:** add Git Flow branching strategy documentation ([8ed9706](https://github.com/alirezarezvani/claude-code-tresor/commit/8ed97065fbd1454a2b08125a3efa1adfb1301d7a))


### Tests

* add JSON-schema, cross-ref, count, smoke, link, and shellcheck CI ([82b1beb](https://github.com/alirezarezvani/claude-code-tresor/commit/82b1bebbe309f220c511b7c240a5b9cce4448edb))
* **ci:** trigger workflows for branch protection setup ([#7](https://github.com/alirezarezvani/claude-code-tresor/issues/7)) ([06b0d90](https://github.com/alirezarezvani/claude-code-tresor/commit/06b0d902616039632253efcc423c301d696b7e2b))
* **ci:** verify GitHub Actions automation workflows ([#5](https://github.com/alirezarezvani/claude-code-tresor/issues/5)) ([9e7d9ed](https://github.com/alirezarezvani/claude-code-tresor/commit/9e7d9edaca4b50acce613642747f677865a1e58e))
* **workflow:** validate complete automation and guardrails ([#12](https://github.com/alirezarezvani/claude-code-tresor/issues/12)) ([73847d4](https://github.com/alirezarezvani/claude-code-tresor/commit/73847d4a391b36f1637d6c48bb14fdf6658ce0aa))


### CI

* implement GitHub Actions automation system ([04d5e77](https://github.com/alirezarezvani/claude-code-tresor/commit/04d5e7747d7d9b457a4873f3b0773bd99ce7d785))
* restore Git Flow and split release into dev + main stages ([0a89f39](https://github.com/alirezarezvani/claude-code-tresor/commit/0a89f39595a586669f6edc7a07be9847d18c530a))
* simplify to trunk-based CI/CD with release-please ([e07e63b](https://github.com/alirezarezvani/claude-code-tresor/commit/e07e63bc313568548e2ec89b72f3501d60a97875))

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
