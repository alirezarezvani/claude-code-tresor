# CLAUDE.md - Development Guide

> **For Claude Code instances working with Claude Code Tresor**

## 🎯 Repository Purpose

Claude Code Tresor is a comprehensive collection of professional-grade utilities for Claude Code:
- **8 Autonomous Skills**: Automatic background helpers (NEW in v2.0!)
- **8 Core Agents**: Production-ready expert sub-agents for deep analysis
- **137+ Extended Agents**: Specialized agents organized by team and function (NEW in v2.5!)
- **4 Essential Slash Commands**: Workflow automation and orchestration
- **20+ Prompt Templates**: Production-ready prompts for common development scenarios
- **Development Standards**: Style guides, Git workflows, and team collaboration guidelines

**Author**: Alireza Rezvani | **License**: MIT | **Created**: September 16, 2025 | **Updated**: November 15, 2025 (v2.5.0)

## 🏗️ Architecture

```
claude-code-tresor/
├── skills/                     # 8 Autonomous Skills (NEW v2.0!)
│   ├── development/            # code-reviewer, test-generator, git-commit-helper
│   ├── security/               # security-auditor, secret-scanner, dependency-auditor
│   └── documentation/          # api-documenter, readme-updater
├── agents/                     # 8 Core Production Agents (.md + README.md)
│   ├── config-safety-reviewer/ # Configuration safety & production reliability
│   ├── test-engineer/          # Testing specialist
│   ├── docs-writer/            # Documentation expert
│   ├── systems-architect/      # System design & technical strategy
│   ├── root-cause-analyzer/    # Comprehensive RCA & debugging
│   ├── security-auditor/       # Security expert & OWASP compliance
│   ├── performance-tuner/      # Performance optimization
│   └── refactor-expert/        # Code refactoring & clean architecture
├── subagents/                  # 137+ Extended Agents (NEW v2.5!)
│   ├── engineering/            # 60+ engineering specialists
│   ├── design/                 # 10 design specialists
│   ├── marketing/              # 15+ marketing specialists
│   ├── product/                # 10+ product specialists
│   ├── leadership/             # 15+ leadership & strategy
│   ├── operations/             # 10+ operations specialists
│   ├── research/               # 10+ research specialists
│   ├── ai-automation/          # 10+ AI/ML & automation
│   └── account-customer-success/ # 8+ account & CS specialists
├── commands/                   # 4 Slash Commands (.md + README.md)
│   ├── development/scaffold/   # Project/component scaffolding
│   ├── workflow/review/        # Code review automation
│   ├── testing/test-gen/       # Test generation
│   └── documentation/docs-gen/ # Documentation generation
├── prompts/                    # 20+ Prompt templates
├── standards/                  # Development standards
├── examples/                   # Real-world workflows
├── sources/                    # Extended library (200+ components)
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
./scripts/install.sh --agents        # 8 expert agents only
./scripts/install.sh --commands      # 4 workflow commands only
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
# Core agents (8) - Production-ready in /agents/
@systems-architect, @config-safety-reviewer, @root-cause-analyzer
@security-auditor, @test-engineer, @performance-tuner
@refactor-expert, @docs-writer

# Extended agents (133) - Organized in /subagents/ by team
# See subagents/README.md for complete catalog
```

## TÂCHES Workflow Commands (v2.6.5)

### Meta-Prompting System

**`/create-prompt [task]`** - Expert prompt engineer

- Generates optimized, XML-structured prompts for complex tasks
- **Automatically references Tresor's CLAUDE.md** for project standards
- **Suggests appropriate Tresor agents** based on task type
- Follows Tresor's anti-overengineering and maintainability principles
- Creates prompts optimized for Tresor's 141-agent ecosystem

**`/run-prompt [number(s)] [--parallel|--sequential]`** - Execute prompts

- Runs generated prompts in fresh sub-task contexts
- Supports parallel and sequential execution
- **Integrates with Tresor agents** - prompts can invoke @agents
- Supports Tresor's subagent types (Explore, Plan, general-purpose)

### Todo Management System

**`/add-to-todos [description]`** - Capture ideas without breaking flow

- Structured format: Problem, Files, Solution
- Preserves full conversation context
- Auto-detects Tresor components (agents, skills, commands)
- Integrates with Tresor's project structure

**`/check-todos`** - Resume work with complete context

- Lists all captured todos with dates and context
- **Detects and suggests Tresor's 141 agents** based on todo content and file paths
- Matches todos to domain patterns (engineering/, design/, skills/, etc.)
- Offers Tresor workflow integration (invoke agent, use skill, work directly)
- Loads complete context for selected todo

### Context Handoff System

**`/whats-next`** - Create comprehensive handoff document

- Captures complete work history, decisions, and context
- **Complements Tresor's memory bank** (projectbrief, productContext, activeContext)
- Session-specific handoff vs long-term context
- Enables seamless work continuation in fresh contexts

### TÂCHES + Tresor Integration Examples

**Meta-Prompting with Tresor Agents**:
```bash
/create-prompt Design scalable microservices architecture
# → Generates prompt referencing CLAUDE.md
# → Suggests @systems-architect for execution
# → Includes Tresor's maintainability principles

/run-prompt 001
# → Executes with fresh context
# → Can invoke @systems-architect, @backend-architect, @security-auditor
```

**Todo Management with Agent Discovery**:
```bash
# During coding, spot issue
/add-to-todos Optimize N+1 queries in user API - src/api/users.ts:45-67

# Later
/check-todos
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

TÂCHES Handoff (session-specific):
- whats-next.md (created via /whats-next command)
- Detailed task state, exact file positions
- Resume with zero information loss
```

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