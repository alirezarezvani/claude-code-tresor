# CLAUDE.md - Development Guide

> **For Claude Code instances working with Claude Code Tresor**

## 🎯 Repository Purpose

Claude Code Tresor is a comprehensive collection of professional-grade utilities for Claude Code:
- **8 Autonomous Skills**: Automatic background helpers (NEW in v2.0!)
- **8 Specialized Agents**: Expert sub-agents for deep analysis
- **4 Essential Slash Commands**: Workflow automation and orchestration
- **20+ Prompt Templates**: Production-ready prompts for common development scenarios
- **Development Standards**: Style guides, Git workflows, and team collaboration guidelines

**Author**: Alireza Rezvani | **License**: MIT | **Created**: September 16, 2025 | **Updated**: October 24, 2025 (v2.0.0)

## 🏗️ Architecture

```
claude-code-tresor/
├── skills/                     # 8 Autonomous Skills (NEW v2.0!)
│   ├── development/            # code-reviewer, test-generator, git-commit-helper
│   ├── security/               # security-auditor, secret-scanner, dependency-auditor
│   └── documentation/          # api-documenter, readme-updater
├── agents/                     # 8 Specialized Agents (.md + README.md)
│   ├── code-reviewer/          # Code quality expert
│   ├── test-engineer/          # Testing specialist
│   ├── docs-writer/            # Documentation expert
│   ├── architect/              # System design expert
│   ├── debugger/               # Debugging specialist
│   ├── security-auditor/       # Security expert
│   ├── performance-tuner/      # Performance optimization
│   └── refactor-expert/        # Code refactoring
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
2. **Developer invokes Agent** → `@code-reviewer` comprehensive analysis
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
Task tool -> @code-reviewer for security analysis
Task tool -> @performance-tuner for optimization
Task tool -> @security-auditor for vulnerability scan
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
@code-reviewer Analyze this component for React best practices and security
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

## ⚠️ Safety Guidelines

1. **Configuration Changes**: Always review configuration changes carefully
2. **Database Migrations**: Validate schema changes in staging first
3. **API Modifications**: Ensure backward compatibility
4. **Environment Variables**: Never commit secrets or keys
5. **Deployment Scripts**: Test deployment automation thoroughly

## 📞 Support

- **Issues**: GitHub Issues for bugs and feature requests
- **Discussions**: GitHub Discussions for questions and ideas
- **Documentation**: Browse `examples/` for detailed workflows
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