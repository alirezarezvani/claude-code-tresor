# CLAUDE.md - Development Guide

> **For Claude Code instances working with Claude Code Tresor**

## 🎯 Repository Purpose

Claude Code Tresor is a comprehensive collection of professional-grade utilities for Claude Code:
- **4 Essential Slash Commands**: `/scaffold`, `/review`, `/test-gen`, `/docs-gen`
- **5 Specialized Agents**: `@code-reviewer`, `@test-engineer`, `@docs-writer`, `@architect`, `@debugger`
- **20+ Prompt Templates**: Production-ready prompts for common development scenarios
- **Development Standards**: Style guides, Git workflows, and team collaboration guidelines

**Author**: Alireza Rezvani | **License**: MIT | **Created**: September 16, 2025

## 🏗️ Architecture

```
claude-code-tresor/
├── commands/                   # Slash Commands (.json + README.md)
│   ├── development/scaffold/   # Project/component scaffolding
│   ├── workflow/review/        # Code review automation
│   ├── testing/test-gen/       # Test generation
│   └── documentation/docs-gen/ # Documentation generation
├── agents/                     # Specialized Agents (.json + README.md)
│   ├── code-reviewer/          # Code quality expert
│   ├── test-engineer/          # Testing specialist
│   ├── docs-writer/            # Documentation expert
│   ├── architect/              # System design expert
│   └── debugger/               # Debugging specialist
├── prompts/                    # Prompt templates
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
# Full installation (recommended)
./scripts/install.sh

# Selective installation
./scripts/install.sh --commands-only
./scripts/install.sh --agents-only
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
- **Frontend Development**: React, Vue, Angular patterns
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

**Remember**: This repository provides utilities TO users, not a development project itself. Focus on helping users implement, customize, and extend these utilities for their own projects. Provide brutally honest, technically sound guidance that prevents costly mistakes while maintaining code simplicity and readability.