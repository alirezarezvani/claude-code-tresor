# CLAUDE.md - Development Guide

> **For Claude Code instances working with Claude Code Tresor**

## 🎯 Repository Purpose

Claude Code Tresor is a comprehensive collection of professional-grade utilities for Claude Code:
- **8 Autonomous Skills**: Automatic background helpers (NEW in v2.0!)
- **8 Core Agents**: Production-ready expert sub-agents for deep analysis
- **133 Extended Agents**: Specialized agents organized by team and function (v2.5+)
- **19 Slash Commands**: Workflow automation and intelligent orchestration (NEW v2.7!)
  - 4 Development commands
  - 5 Tresor Workflow commands
  - 10 Orchestration commands (Security, Performance, Operations, Quality)
- **20+ Prompt Templates**: Production-ready prompts for common development scenarios
- **Development Standards**: Style guides, Git workflows, and team collaboration guidelines

**Author**: Alireza Rezvani | **License**: MIT | **Created**: September 16, 2025 | **Updated**: November 19, 2025 (v2.7.0)

## 🏗️ Architecture

```
claude-code-tresor/
├── skills/                     # 8 Autonomous Skills (v2.0+)
│   ├── development/            # code-reviewer, test-generator, git-commit-helper
│   ├── security/               # security-auditor, secret-scanner, dependency-auditor
│   └── documentation/          # api-documenter, readme-updater
├── subagents/                  # 133 Agents - PRIMARY LOCATION (v2.7+)
│   ├── core/                   # 8 core production agents
│   ├── engineering/            # 54 engineering specialists
│   ├── design/                 # 7 design specialists
│   ├── marketing/              # 11 marketing specialists
│   ├── product/                # 9 product specialists
│   ├── leadership/             # 14 leadership & strategy
│   ├── operations/             # 6 operations specialists
│   ├── research/               # 7 research specialists
│   ├── ai-automation/          # 9 AI/ML & automation
│   └── account-customer-success/ # 8 account & CS specialists
├── agents/                     # [Deprecated v2.7] Symlinks to subagents/core/
├── commands/                   # 19 Slash Commands (v2.7+)
│   ├── development/scaffold/   # Project/component scaffolding
│   ├── workflow/               # 6 workflow commands (review, prompt-*, todo-*, handoff-*)
│   ├── testing/test-gen/       # Test generation
│   ├── documentation/docs-gen/ # Documentation generation
│   ├── security/               # 3 NEW: audit, vulnerability-scan, compliance-check
│   ├── performance/            # 2 NEW: profile, benchmark
│   ├── operations/             # 3 NEW: deploy-validate, health-check, incident-response
│   └── quality/                # 2 NEW: code-health, debt-analysis
├── prompts/                    # 20+ Prompt templates
├── standards/                  # Development standards
├── examples/                   # Real-world workflows
├── sources/                    # Extended library (200+ components)
├── documentation/              # Comprehensive documentation
│   ├── guides/                 # Installation, getting-started, troubleshooting
│   ├── reference/              # Technical reference docs
│   ├── workflows/              # Workflow examples
│   └── plans/                  # Architecture and planning docs
├── NAVIGATION.md               # NEW v2.7: Repository navigation guide
├── MIGRATION.md                # NEW v2.7: Upgrade guide
├── WORKFLOW-GUIDE.md           # NEW v2.7: Tresor Workflow Framework guide
└── scripts/                    # Installation utilities
```

## 🛠️ Common Development Commands

### Building & Testing
```bash
# No build process - this is a utilities collection
# Test installation scripts
./scripts/install.sh --check
```

### Installation & Setup
```bash
# Full installation (recommended) - installs skills + agents + commands
./scripts/install.sh

# Selective installation
./scripts/install.sh --skills        # 8 autonomous skills only
./scripts/install.sh --agents        # 133 agents only (from /subagents/)
./scripts/install.sh --commands      # 19 commands (4 dev + 5 workflow + 10 orchestration)
./scripts/install.sh --orchestration # 10 orchestration commands only (NEW v2.7)
./scripts/install.sh --resources-only

# Updates
./scripts/update.sh
```

### Repository Management
```bash
# Standard Git workflow with conventional commits
git add .
git commit -m "feat: add new utility"
git push origin main

# View repository structure
find . -name "*.json" -path "*/commands/*" -o -name "*.json" -path "*/agents/*"
```

## 📋 Command & Agent Structure

### Slash Command Structure
Each command in `commands/` contains:
- `command.json` - Configuration and metadata
- `README.md` - Comprehensive documentation with examples
- Commands follow pattern: `/command-name --options`

### Agent Structure
Each agent in `agents/` contains:
- `agent.json` - Agent configuration and capabilities
- `README.md` - Detailed usage guide and examples
- Agents follow pattern: `@agent-name task description`

### Skill Structure (NEW v2.0!)
Each skill in `skills/` contains:
- `SKILL.md` - Skill configuration with YAML frontmatter + comprehensive docs
- `README.md` - Quick reference guide with examples
- Skills activate automatically based on trigger keywords

## ✨ Skills Layer (NEW v2.0!)

### What Are Skills?
**Skills** are autonomous background helpers that work continuously without manual invocation:
- ✅ **Automatic activation** - Triggered by code changes, file saves, commits
- ✅ **Lightweight** - Limited tool access for safety (Read, Write, Edit, Grep, Glob)
- ✅ **Proactive** - Detect issues and opportunities in real-time
- ✅ **Non-blocking** - Provide suggestions without interrupting workflow

### 8 Core Skills

**Development Skills (3):**
1. **code-reviewer** - Real-time code quality checks
2. **test-generator** - Auto-suggest missing tests
3. **git-commit-helper** - Generate conventional commit messages

**Security Skills (3):**
4. **security-auditor** - OWASP Top 10 vulnerability scanning
5. **secret-scanner** - Detect exposed API keys/secrets
6. **dependency-auditor** - CVE checking for dependencies

**Documentation Skills (2):**
7. **api-documenter** - Auto-generate OpenAPI specs
8. **readme-updater** - Keep README current with changes

### Skills vs Agents vs Commands

| Feature | Skills | Agents | Commands |
|---------|--------|--------|----------|
| **Invocation** | Automatic | Manual (`@agent`) | Manual (`/command`) |
| **Tools** | Limited (safe) | Full access | Orchestrates |
| **Context** | Shared | Separate | Coordinates |
| **Best For** | Quick checks | Deep analysis | Workflows |

**Typical Workflow:**
1. **Skill detects** issue automatically → suggests improvement
2. **Developer invokes Agent** → `@config-safety-reviewer` comprehensive analysis
3. **Developer runs Command** → `/review --scope staged` full workflow

### Sandboxing (Optional)
All skills work **WITHOUT sandboxing by default**. Sandboxing is optional for additional security isolation.

**See:** [Skills Guide](skills/README.md) | [Getting Started](GETTING-STARTED.md) | [Architecture](ARCHITECTURE.md)

## 🔧 Key Implementation Details

### Configuration Safety (Critical)
The `/review` command emphasizes **configuration safety** to prevent outages:
- Detects risky configuration changes (database connections, API endpoints)
- Validates environment-specific settings
- Checks for magic numbers and hardcoded values
- Reviews deployment configurations

### Multi-Agent Orchestration
Commands can invoke agents using the Task tool:
```bash
# Example from /review command
Task tool -> @config-safety-reviewer for configuration safety analysis
Task tool -> @performance-tuner for optimization
Task tool -> @security-auditor for vulnerability scan
Task tool -> @systems-architect for architecture review
```

### Test Harness Generation
The `/test-gen` command supports multiple frameworks:
- **Python**: pytest, unittest, property-based testing
- **JavaScript/TypeScript**: Jest, Vitest, Playwright
- **Java**: JUnit, TestNG, Mockito
- **Load Testing**: Locust, Artillery

### Documentation Automation
The `/docs-gen` command generates:
- API documentation with OpenAPI specs
- Architecture diagrams with Mermaid
- Interactive documentation with Docusaurus
- CI/CD pipeline for automated docs

## 🎨 Prompt Template Categories

Located in `prompts/` directory:
- **Frontend Development**: React, NextJS, ReactJS, Vue, Angular patterns
- **Backend Development**: APIs, databases, microservices
- **Debugging & Analysis**: Error analysis, performance troubleshooting
- **Best Practices**: Clean code, security, refactoring strategies

## 📏 Development Standards

Located in `standards/` directory:
- **JavaScript/TypeScript**: ESLint/Prettier configurations
- **Git Workflows**: Conventional commits, branch strategies
- **Code Review**: Checklists and PR templates
- **Team Collaboration**: Guidelines and best practices

## 🚀 Usage Examples

### Project Scaffolding
```bash
/scaffold react-component UserProfile --hooks --tests --typescript
/scaffold express-api user-service --auth --database --tests
```

### Code Review Automation
```bash
/review --scope staged --checks security,performance,configuration
@config-safety-reviewer Review database connection pool configuration
@security-auditor Analyze this component for React best practices and security
```

### Test Generation
```bash
/test-gen --file utils.js --framework jest --coverage 90
@test-engineer Create comprehensive tests with edge cases
```

### Documentation Generation
```bash
/docs-gen api --format openapi --include-examples
@docs-writer Create user guide with setup and troubleshooting
```

### System Architecture & Debugging
```bash
@systems-architect Design scalable e-commerce system for 100k concurrent users
@root-cause-analyzer Production API timing out - perform comprehensive RCA
@performance-tuner Profile and optimize database query performance
```

### Agent Discovery
```bash
# Core agents (8) - Production-ready in /subagents/core/
@systems-architect, @config-safety-reviewer, @root-cause-analyzer
@security-auditor, @test-engineer, @performance-tuner
@refactor-expert, @docs-writer

# Extended agents (133) - Organized in /subagents/ by team
# See subagents/README.md for complete catalog
```

### Orchestration Commands (NEW v2.7.0)

**Security & Compliance:**
```bash
# Comprehensive security audit with OWASP Top 10, infrastructure, pentesting
/audit

# Fast CVE scanning for weekly security checks
/vulnerability-scan --depth deep

# GDPR compliance validation before audit
/compliance-check --frameworks gdpr

# Auto-fix safe vulnerabilities
/vulnerability-scan --auto-fix
```

**Performance Optimization:**
```bash
# Profile to find bottlenecks
/profile --layers frontend,backend,database

# Fix identified bottlenecks, then validate with load testing
/benchmark --pattern stress --rps 500

# Quick performance check for CI/CD
/profile --depth quick --layers backend
```

**Operations & Deployment:**
```bash
# Pre-deployment safety checks
/deploy-validate --env production

# Post-deployment health verification
/health-check --comprehensive

# Production incident response
/incident-response --severity p0

# Weekly health monitoring
/health-check --env production
```

**Code Quality & Technical Debt:**
```bash
# Assess codebase health
/code-health

# Identify and prioritize technical debt
/debt-analysis --prioritize roi

# Plan refactoring based on debt analysis
# [Use /prompt-create for complex refactoring prompts]
```

## Tresor Workflow Framework (v2.7.0)

### Meta-Prompting System

**`/prompt-create [task]`** - Expert prompt engineer

- Generates optimized, XML-structured prompts for complex tasks
- **Automatically references Tresor's CLAUDE.md** for project standards
- **Suggests appropriate Tresor agents** based on task type
- Follows Tresor's anti-overengineering and maintainability principles
- Creates prompts optimized for Tresor's 141-agent ecosystem

**`/prompt-run [number(s)] [--parallel|--sequential]`** - Execute prompts

- Runs generated prompts in fresh sub-task contexts
- Supports parallel and sequential execution
- **Integrates with Tresor agents** - prompts can invoke @agents
- Supports Tresor's subagent types (Explore, Plan, general-purpose)

### Todo Management System

**`/todo-add [description]`** - Capture ideas without breaking flow

- Structured format: Problem, Files, Solution
- Preserves full conversation context
- Auto-detects Tresor components (agents, skills, commands)
- Integrates with Tresor's project structure

**`/todo-check`** - Resume work with complete context

- Lists all captured todos with dates and context
- **Detects and suggests Tresor's 141 agents** based on todo content and file paths
- Matches todos to domain patterns (engineering/, design/, skills/, etc.)
- Offers Tresor workflow integration (invoke agent, use skill, work directly)
- Loads complete context for selected todo

### Context Handoff System

**`/handoff-create`** - Create comprehensive handoff document

- Captures complete work history, decisions, and context
- **Complements Tresor's memory bank** (projectbrief, productContext, activeContext)
- Session-specific handoff vs long-term context
- Enables seamless work continuation in fresh contexts

### Tresor Workflow Integration Examples

**Meta-Prompting with Tresor Agents**:
```bash
/prompt-create Design scalable microservices architecture
# → Generates prompt referencing CLAUDE.md
# → Suggests @systems-architect for execution
# → Includes Tresor's maintainability principles

/prompt-run 001
# → Executes with fresh context
# → Can invoke @systems-architect, @backend-architect, @security-auditor
```

**Todo Management with Agent Discovery**:
```bash
# During coding, spot issue
/todo-add Optimize N+1 queries in user API - src/api/users.ts:45-67

# Later
/todo-check
# → Detects backend/database work
# → Suggests @database-optimizer or @performance-tuner
# → One-click agent invocation
```

**Context Handoff with Memory Bank**:
```
Tresor Memory Bank (long-term):
- activeContext.md (updated regularly)
- productContext.md (architectural decisions)
- projectbrief.md (project vision)

Tresor Workflow Handoff (session-specific):
- whats-next.md (created via /handoff-create command)
- Detailed task state, exact file positions
- Resume with zero information loss
```

## Orchestration Commands (v2.7.0)

### Overview

**10 production-grade orchestration commands** with intelligent multi-phase orchestration, automatic agent selection from 141-agent ecosystem, and full Tresor Workflow integration.

**Total:** 12,682 lines of orchestration code across 4 categories

### Security Commands (3)

**`/audit`** - Comprehensive security audit (2-4 hours, 4 phases, 4-5 agents)
- OWASP Top 10 vulnerability scanning
- Infrastructure security review
- Active penetration testing
- Comprehensive RCA for critical findings

**`/vulnerability-scan`** - CVE & dependency scanning (30-60 min, 3 phases, 2-4 agents)
- NVD/GitHub Advisories correlation
- SAST code pattern matching
- Exploit database correlation (Exploit-DB, Metasploit)
- Auto-remediation (`--auto-fix` flag)

**`/compliance-check`** - Regulatory compliance (1-2 hours, 4 phases, 3-6 agents)
- Multi-framework: GDPR, SOC2, HIPAA, PCI-DSS, ISO 27001, CCPA
- Data flow mapping (PII/PHI tracking)
- Technical control validation
- Auditor-ready reports (65+ pages)

### Performance Commands (2)

**`/profile`** - Performance profiling (15min-2h, 3 phases, 3-5 agents)
- Multi-layer: frontend, backend, database
- Core Web Vitals (LCP, FID, CLS)
- Database query optimization (EXPLAIN ANALYZE)
- Quick wins prioritization (impact × ease)

**`/benchmark`** - Load testing (5-30 min, 3 phases, 2-4 agents)
- Intelligent scenario generation (auto-detects endpoints)
- Multiple patterns: baseline, stress, spike, soak
- Breaking point detection
- Capacity planning with cost analysis

### Operations Commands (3)

**`/deploy-validate`** - Pre-deployment validation (10-20 min, 3 phases, 3-4 agents)
- Complete test suite execution
- Configuration safety review
- Security pre-deployment scan
- Go/No-Go decision with risk scoring

**`/health-check`** - System health verification (5-15 min, 3 phases, 3-4 agents)
- Multi-layer health checks (app, database, infrastructure)
- Anomaly detection (trend analysis)
- Alert generation (PagerDuty/Slack integration)

**`/incident-response`** - Production incident coordination (30min-2h, 4 phases, 3-5 agents)
- Emergency triage (5-10 min response)
- Parallel specialist investigation
- Comprehensive RCA with timeline
- Blameless postmortem generation

### Quality Commands (2)

**`/code-health`** - Codebase quality assessment (20-40 min, 3 phases, 3-4 agents)
- Code quality metrics (complexity, duplication, smells)
- Test coverage analysis
- Documentation assessment
- Maintainability scoring (0-10 rating)

**`/debt-analysis`** - Technical debt identification (30-60 min, 3 phases, 3-4 agents)
- Multi-category debt identification
- Cost quantification (time wasted)
- Risk assessment
- ROI-based prioritization

### Key Features Across All Orchestration Commands

**1. Intelligent Agent Selection:**
- Auto-detects tech stack (languages, frameworks, databases)
- Selects optimal agents from 141-agent ecosystem
- Confidence-based ranking

**2. Multi-Phase Orchestration:**
- 3-4 phases per command
- Parallel Phase 1 (up to 3 agents)
- Sequential Phases 2-4 (deep analysis)

**3. Dependency Verification:**
- Checks file write conflicts
- Checks data dependencies
- Auto-fallback to sequential if conflicts

**4. Tresor Workflow Integration:**
- Auto-calls `/todo-add` for all findings
- Auto-calls `/prompt-create` for complex fixes
- Supports `/handoff-create` for multi-session work

### Usage Examples

```bash
# Security workflow
/audit                          # Quarterly comprehensive audit
/vulnerability-scan             # Weekly CVE scanning
/compliance-check --frameworks gdpr,soc2

# Performance workflow
/profile                        # Find bottlenecks
# [Fix bottlenecks]
/benchmark                      # Validate under load

# Operations workflow
/deploy-validate --env production  # Before deployment
# [Deploy]
/health-check                   # Verify deployment
# [If incident]
/incident-response             # Emergency response

# Quality workflow
/code-health                    # Assess current quality
/debt-analysis                  # Plan refactoring
```

**See:** [NAVIGATION.md](NAVIGATION.md) | [Orchestration Commands Summary](documentation/plans/ORCHESTRATION-COMMANDS-COMPLETE.md)

## 🔍 Important Context

### Production Focus
All utilities are designed for **production use** with emphasis on:
- Safety-first approach (especially configuration changes)
- Comprehensive error handling and validation
- Real-world outage prevention patterns
- Professional code quality standards

### Extensibility
The `sources/` directory contains 200+ additional components:
- 80+ specialized agents for various domains
- Advanced slash commands for specific workflows
- Industry-specific prompts and templates

### Community & Contributions
- MIT License allows commercial and personal use
- Contribution guidelines in `CONTRIBUTING.md`
- Professional support available for teams
- Active development with regular updates

## 📚 Documentation

Complete documentation available in `documentation/`:

### Quick Links
- **[Master Index →](documentation/README.md)** - Complete documentation navigation
- **[Installation Guide →](documentation/guides/installation.md)** - Install Claude Code Tresor
- **[Getting Started →](documentation/guides/getting-started.md)** - First-time user walkthrough
- **[FAQ →](documentation/reference/faq.md)** - Frequently asked questions

### Documentation Categories
- **[User Guides →](documentation/guides/)** - Installation, getting-started, configuration, troubleshooting, migration, contributing
- **[Technical Reference →](documentation/reference/)** - Skills, agents, commands, FAQ
- **[Workflows →](documentation/workflows/)** - Git workflow, GitHub automation, agent-skill integration

---

## ⚠️ Safety Guidelines

1. **Configuration Changes**: Always review configuration changes carefully
2. **Database Migrations**: Validate schema changes in staging first
3. **API Modifications**: Ensure backward compatibility
4. **Environment Variables**: Never commit secrets or keys
5. **Deployment Scripts**: Test deployment automation thoroughly

## 📞 Support

- **[FAQ →](documentation/reference/faq.md)** - Common questions answered
- **[Troubleshooting →](documentation/guides/troubleshooting.md)** - Fix common issues
- **[GitHub Issues →](https://github.com/alirezarezvani/claude-code-tresor/issues)** - Report bugs and feature requests
- **[GitHub Discussions →](https://github.com/alirezarezvani/claude-code-tresor/discussions)** - Ask questions and share ideas
- **Professional Support**: Available for custom development and training

## COMMUNICATION STANDARDS & BEHAVIOR

### Core Requirements:
- **Absolute Honesty**: Direct assessments without diplomatic cushioning
- **Zero Fluff**: Eliminate vague statements and buzzwords
- **Pragmatic Focus**: Every suggestion must be immediately actionable
- **Critical Analysis**: Challenge assumptions and identify flaws before responding
- **Always Ask for Clarification**: Never assume or fill gaps with generic advice

### Solution Standards:
- **Strict Adherence**: Follow user instructions exactly as specified
- **File Economy**: Edit existing files instead of creating new ones when possible
- **Code Limits**: Maximum 300 lines per file - split larger files into logical modules
- **Maintainability First**: Prioritize readable, maintainable code over technical complexity
- **Anti-Overengineering**: Choose simple, direct solutions over elaborate architectures

### Response Protocol:
1. **Pre-Response Check**: Verify answer is specific and actionable
2. **Critical Review**: Identify and address solution weaknesses
3. **Implementation Reality**: Confirm feasibility within stated constraints

### Documentation Requirements:
- **Bug Fix Records**: Document each bug and its solution methodology
- **Solution Rationale**: Explain why specific approach was chosen
- **Maintenance Notes**: Include future modification considerations

### Prohibited Responses:
- Generic praise without technical analysis
- Vague suggestions without clear reasoning
- Advice without implementation details
- Assumptions when requirements are unclear
- Over-engineered solutions for simple problems

### Standard Structure:
1. Direct assessment following user specifications
2. Critical analysis with potential issues
3. Step-by-step recommendations (edit vs. create approach)
4. Resource requirements and code organization
5. Documentation and maintenance considerations

---

**Remember**: This repository provides utilities TO users, not a development project itself. Focus on helping users implement, customize, and extend these utilities for their own projects. Provide brutally honest, technically sound guidance that prevents costly mistakes while maintaining code simplicity and readability.No technical jargons that is complicated for the user. Always use the current date,even when you create files or examples.