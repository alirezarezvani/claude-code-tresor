# Phase 1: Foundation Enhancement - Detailed Tasks

> **Duration**: Weeks 1-4 | **Goal**: Fix infrastructure + Add high-impact features

---

## Week 1: Infrastructure Fixes (17 hours)

### Task 1.1: Create Memory Bank (4 hours)

**Subtasks:**
- [ ] Create `projectbrief.md` at repository root
  - Document project vision and goals
  - Define target audience and use cases
  - Outline architecture and component taxonomy
  - Estimated time: 2 hours

- [ ] Create `productContext.md` at repository root
  - Document tech stack (Node.js, Python, Markdown, YAML)
  - Record architectural decisions made
  - Define coding conventions and patterns
  - Estimated time: 1.5 hours

- [ ] Create `activeContext.md` at repository root
  - Current repository state (v2.6.0, 141 agents, 9.7/10 quality)
  - Next priorities (Phase 1 tasks)
  - Recent changes and decisions
  - Estimated time: 0.5 hours

**Validation:**
- All 3 files created
- Comprehensive and up-to-date
- Referenced in main README

---

### Task 1.2: Fix Installer Metadata (6 hours)

**Problem:** Installer expects agent.json but we have YAML frontmatter

**Subtasks:**
- [ ] Analyze current installer logic in scripts/install.sh
  - Understand what installer expects
  - Identify all places checking for agent.json
  - Estimated time: 1 hour

- [ ] Design solution (choose approach):
  - Option A: Generate agent.json from YAML frontmatter (automated)
  - Option B: Update installer to read YAML directly (simpler long-term)
  - Recommended: Option B
  - Estimated time: 1 hour

- [ ] Implement installer update
  - Modify scripts/install.sh to parse YAML frontmatter
  - Extract name, description, tools from agent.md files
  - Handle both core agents and subagents
  - Estimated time: 3 hours

- [ ] Test installation
  - Test on clean system (or Docker container)
  - Verify all agents install correctly
  - Check ~/.claude/agents/ directory
  - Estimated time: 1 hour

**Validation:**
- Installer works on clean system
- All 141 agents install correctly
- No agent.json files needed

---

### Task 1.3: Generate Machine-Readable Indexes (4 hours)

**Purpose:** Enable tooling, search, and automation

**Subtasks:**
- [ ] Create indexes/ directory
  - Estimated time: 1 minute

- [ ] Generate agents.json index
  - Extract: name, category, subcategory, capabilities, tools
  - Include: file path, description, color
  - Format: JSON array of 141 agent objects
  - Estimated time: 1.5 hours

- [ ] Generate skills.json index
  - Extract: name, description, triggers, allowed-tools
  - Include: activation patterns
  - Format: JSON array of 8 skill objects
  - Estimated time: 0.5 hours

- [ ] Generate commands.json index
  - Extract: name, description, argument-hint
  - Include: agents used, workflow
  - Format: JSON array of 4 command objects
  - Estimated time: 0.5 hours

- [ ] Generate standards.json index
  - Extract: name, type, language/framework
  - Include: enforcement rules, validator agents
  - Format: JSON array
  - Estimated time: 1 hour

- [ ] Create index README
  - Document index format
  - Usage examples
  - Update frequency
  - Estimated time: 0.5 hours

**Validation:**
- 4 JSON index files created
- Valid JSON syntax
- Complete data for all components
- README documentation

---

### Task 1.4: Audit Documentation (3 hours)

**Purpose:** Fix inconsistencies found in .cursor/plans

**Subtasks:**
- [ ] Fix commands/README.md
  - Remove references to non-existent commands (/refactor, /deploy, /optimize)
  - OR: Create placeholder documentation for planned commands
  - Update command list to match reality
  - Estimated time: 1 hour

- [ ] Update cross-references
  - Find all references to commands in documentation
  - Update to match current state
  - Add "planned" notation for future commands
  - Estimated time: 1 hour

- [ ] Validate all internal links
  - Check all docs/ markdown links
  - Fix broken references
  - Update paths after consolidation
  - Estimated time: 1 hour

**Validation:**
- No false documentation claims
- All links work
- Consistent across all docs

---

## Week 2: High-Impact Skills (18 hours)

### Task 2.1: performance-monitor Skill (6 hours)

**Subtasks:**
- [ ] Create skills/development/performance-monitor/SKILL.md
  - YAML frontmatter (name, description, triggers, allowed-tools)
  - Triggers: *.js, *.ts, *.py, *.go on save
  - Allowed tools: Read, Grep, Bash
  - Estimated time: 1 hour

- [ ] Implement detection logic
  - Slow loops (nested loops, large iterations)
  - N+1 query patterns (ORM queries in loops)
  - Memory leaks (event listeners, intervals not cleaned)
  - Blocking operations (synchronous I/O in async code)
  - Estimated time: 3 hours

- [ ] Add agent integration
  - Suggest @performance-tuner when issues found
  - Provide issue context to agent
  - One-click invocation
  - Estimated time: 1 hour

- [ ] Create tests and examples
  - Test cases for each anti-pattern
  - Example outputs
  - Integration test with @performance-tuner
  - Estimated time: 1 hour

**Validation:**
- Skill activates correctly
- Detects 80%+ of common anti-patterns
- Agent suggestion works

---

### Task 2.2: accessibility-checker Skill (5 hours)

**Subtasks:**
- [ ] Create skills/development/accessibility-checker/SKILL.md
  - Triggers: *.jsx, *.tsx, *.html, *.vue
  - Detects: Missing ARIA, semantic HTML, color contrast
  - Estimated time: 1 hour

- [ ] Implement WCAG validation
  - Check ARIA attributes
  - Validate semantic HTML
  - Color contrast analysis (basic)
  - Keyboard navigation support
  - Estimated time: 2.5 hours

- [ ] Integration with @frontend-ux-specialist
  - Suggest agent for complex accessibility issues
  - Provide violation details
  - Estimated time: 0.5 hours

- [ ] Create tests
  - Test cases for common violations
  - Integration test
  - Estimated time: 1 hour

**Validation:**
- WCAG 2.1 AA basic checks work
- Agent suggestion functional

---

### Task 2.3: docker-validator Skill (4 hours)

**Subtasks:**
- [ ] Create skills/devops/docker-validator/SKILL.md
  - Triggers: Dockerfile, docker-compose.yml
  - Best practices validation
  - Estimated time: 0.5 hours

- [ ] Implement validation rules
  - Multi-stage builds
  - Layer optimization
  - Security (non-root user, .dockerignore)
  - Size optimization
  - Estimated time: 2 hours

- [ ] Integration with @devops-engineer
  - Suggest agent for complex Docker issues
  - Estimated time: 0.5 hours

- [ ] Create tests
  - Test Dockerfile examples
  - Estimated time: 1 hour

**Validation:**
- Detects common Dockerfile issues
- Suggestions are actionable

---

### Task 2.4: env-validator Skill (3 hours)

**Subtasks:**
- [ ] Create skills/devops/env-validator/SKILL.md
  - Triggers: .env, .env.example changes
  - Sync validation
  - Estimated time: 0.5 hours

- [ ] Implement validation
  - Check .env.example completeness
  - Detect missing required vars
  - Validate format and syntax
  - Estimated time: 1.5 hours

- [ ] Integration with @config-safety-reviewer
  - Suggest for complex config issues
  - Estimated time: 0.5 hours

- [ ] Create tests
  - Test cases
  - Estimated time: 0.5 hours

**Validation:**
- Detects missing env vars
- Suggests completions

---

## Week 3: Essential Commands (26 hours)

### Task 3.1: /audit Command (8 hours)

**Subtasks:**
- [ ] Create commands/security/audit.md
  - Command metadata (allowed-tools, argument-hint, description)
  - Estimated time: 1 hour

- [ ] Implement orchestration logic
  - Step 1: @security-auditor (comprehensive scan)
  - Step 2: secret-scanner skill (credentials)
  - Step 3: dependency-auditor skill (CVE check)
  - Step 4: @compliance-officer (standards)
  - Estimated time: 4 hours

- [ ] Create report generator
  - Consolidated security report
  - Prioritized vulnerabilities (Critical/High/Medium/Low)
  - Remediation steps
  - Compliance status
  - Estimated time: 2 hours

- [ ] Create tests and documentation
  - Test orchestration flow
  - Document usage examples
  - Estimated time: 1 hour

**Validation:**
- Command orchestrates all security agents
- Report is comprehensive
- Works in CI/CD

---

### Task 3.2: /discover-agent Command (8 hours)

**Subtasks:**
- [ ] Design wizard flow
  - Question 1: What are you working on?
  - Question 2: Specific task?
  - Question 3: Tech stack?
  - Estimated time: 1 hour

- [ ] Build recommendation engine
  - Parse all agent capabilities from indexes/agents.json
  - Match user input to agent expertise
  - Score and rank agents
  - Estimated time: 4 hours

- [ ] Create interactive CLI
  - Present questions
  - Capture responses
  - Display recommendations with rationale
  - One-click agent invocation
  - Estimated time: 2 hours

- [ ] Create tests
  - Test recommendation accuracy
  - Test edge cases
  - Estimated time: 1 hour

**Validation:**
- Recommends correct agents 90%+ of time
- User-friendly interaction
- Reduces discovery time 80%

---

### Task 3.3: /deploy Command (10 hours)

**Subtasks:**
- [ ] Create commands/devops/deploy.md
  - Command metadata
  - Estimated time: 1 hour

- [ ] Implement multi-agent orchestration
  - Step 1: @deployment-engineer (plan)
  - Step 2: @config-safety-reviewer (config validation)
  - Step 3: @security-auditor (security scan)
  - Step 4: @performance-tuner (health checks)
  - Step 5: @infrastructure-maintainer (monitoring setup)
  - Estimated time: 5 hours

- [ ] Add deployment strategies
  - Blue-green deployment
  - Canary releases
  - Rolling updates
  - Rollback procedures
  - Estimated time: 2 hours

- [ ] Create safety gates
  - Pre-deployment checks
  - Health validation
  - Rollback triggers
  - Estimated time: 1 hour

- [ ] Documentation and tests
  - Usage examples
  - Integration tests
  - Estimated time: 1 hour

**Validation:**
- Orchestrates 5 agents correctly
- Deployment strategies work
- Rollback plan generated

---

## Week 4: Standards & Polish (22 hours)

### Task 4.1: ADR Template & Workflow (4 hours)

**Subtasks:**
- [ ] Create standards/architecture/adr-template.md
  - Standard ADR structure
  - Fields: Status, Context, Decision, Consequences
  - Estimated time: 1 hour

- [ ] Create ADR workflow documentation
  - When to create ADRs
  - Review process
  - Storage location
  - Estimated time: 1 hour

- [ ] Integration with @systems-architect
  - Agent can auto-generate ADRs
  - Based on architecture decisions
  - Estimated time: 1.5 hours

- [ ] Create 3 example ADRs
  - Database choice
  - API architecture
  - Authentication strategy
  - Estimated time: 0.5 hours

**Validation:**
- Template complete and clear
- @systems-architect integration works
- Examples are realistic

---

### Task 4.2: /enforce-standard Command (8 hours)

**Subtasks:**
- [ ] Create commands/quality/enforce-standard.md
  - Command metadata
  - Estimated time: 0.5 hours

- [ ] Implement standard parser
  - Read standard markdown files
  - Extract rules and validation criteria
  - Map to appropriate validator agents
  - Estimated time: 2.5 hours

- [ ] Build enforcement orchestration
  - code-style → @{language}-pro + prettier/eslint
  - architecture → @systems-architect + pattern validation
  - security → @security-auditor + all security skills
  - Estimated time: 3 hours

- [ ] Add auto-fix capability
  - Generate fix suggestions
  - Apply fixes with user confirmation
  - Validation after fixes
  - Estimated time: 1.5 hours

- [ ] Documentation and tests
  - Usage examples
  - Test with TypeScript standard
  - Estimated time: 0.5 hours

**Validation:**
- Enforces standards correctly
- Auto-fix works
- Reports are clear

---

### Task 4.3: Add 5 New Standards (6 hours)

**Subtasks:**
- [ ] Create standards/style-guides/rust.md (1 hour)
  - rustfmt configuration
  - Clippy rules
  - Naming conventions

- [ ] Create standards/style-guides/swift.md (1 hour)
  - SwiftLint configuration
  - Naming conventions
  - SwiftUI patterns

- [ ] Create standards/style-guides/kotlin.md (1 hour)
  - Ktlint + Detekt config
  - Naming conventions
  - Coroutines patterns

- [ ] Create standards/frameworks/nextjs.md (1.5 hours)
  - App Router patterns
  - Server Components best practices
  - Performance optimization

- [ ] Create standards/architecture/microservices.md (1.5 hours)
  - Service boundaries
  - Communication patterns
  - Data consistency strategies

**Validation:**
- All 5 standards complete
- Enforceable by agents
- Include examples

---

### Task 4.4: Create Remaining Skills (4 hours)

**Subtasks:**
- [ ] Create react-best-practices skill (1.5 hours)
  - Hooks rules validation
  - Re-render detection
  - Prop validation

- [ ] Create python-style-checker skill (1 hour)
  - PEP8 validation
  - Type hints coverage
  - Docstring completeness

- [ ] Create bundle-analyzer skill (1 hour)
  - Frontend bundle size tracking
  - Code splitting opportunities
  - Lazy loading suggestions

- [ ] Create migration-safety skill (0.5 hours)
  - Database migration review
  - Rollback validation
  - Data validation checks

**Validation:**
- All 4 skills activate correctly
- Detection accuracy >80%
- Agent integration works

---

## Phase 1 Completion Checklist

**Infrastructure:**
- [x] Memory bank created (3 files)
- [x] Installer fixed and tested
- [x] Machine-readable indexes generated (4 JSON files)
- [x] Documentation audit complete

**Skills:**
- [x] performance-monitor (detects slow code)
- [x] accessibility-checker (WCAG validation)
- [x] docker-validator (Dockerfile best practices)
- [x] env-validator (environment variable validation)
- [x] react-best-practices (React patterns)
- [x] python-style-checker (PEP8 compliance)
- [x] bundle-analyzer (bundle size optimization)
- [x] migration-safety (DB migration review)

**Commands:**
- [x] /audit (security audit workflow)
- [x] /discover-agent (agent discovery wizard)
- [x] /deploy (deployment automation)

**Standards:**
- [x] ADR template and workflow
- [x] 5 new standards (Rust, Swift, Kotlin, Next.js, Microservices)
- [x] /enforce-standard command

**Totals:**
- **8 new skills** (16 total)
- **3 new commands** (7 total)
- **6 new standards** (18 total)
- **4 machine-readable indexes**
- **3 memory bank files**
- **Time Investment**: 67 hours (~2 weeks full-time or 4 weeks part-time)

**Expected Impact:**
- 40% immediate productivity boost
- Discovery problem solved (80% faster agent finding)
- Security posture strengthened (automated audits)
- Deployment safety improved (automated validation)
- Quality baseline established (standard enforcement)

---

**Next:** Proceed to Phase 2 (Ecosystem Integration) after Phase 1 completion