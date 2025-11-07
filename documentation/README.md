# Documentation Index

Complete navigation for Claude Code Tresor documentation.

## Quick Start

**New to Claude Code Tresor?** Start here:

1. **[Installation Guide →](guides/installation.md)** - Install Claude Code Tresor (5 minutes)
2. **[Getting Started →](guides/getting-started.md)** - Your first workflow (10 minutes)
3. **[FAQ →](reference/faq.md)** - Common questions answered

---

## User Guides

Comprehensive guides for all users:

### Getting Started
- **[Installation Guide →](guides/installation.md)** - Complete installation instructions
  - Full installation (all components)
  - Selective installation (skills, agents, or commands only)
  - Verification steps
  - Common installation issues

- **[Getting Started →](guides/getting-started.md)** - First-time user walkthrough
  - Understanding skills, agents, and commands
  - Your first workflow
  - Learning path (4 weeks)
  - Common patterns

### Configuration & Customization
- **[Configuration Guide →](guides/configuration.md)** - Configure skills, agents, and commands
  - Skills configuration (YAML frontmatter)
  - Agents configuration (YAML frontmatter or agent.json)
  - Commands configuration (command.json)
  - Environment variables
  - Advanced configuration

- **[Troubleshooting →](guides/troubleshooting.md)** - Fix common issues
  - Installation issues
  - Skills not activating
  - Agents not found
  - Commands not working
  - Configuration errors
  - Performance issues

### Migration & Contributing
- **[Migration Guide →](guides/migration.md)** - Upgrade between versions
  - Version compatibility
  - v1.0 → v2.0 migration
  - Breaking changes
  - Rollback procedures
  - Testing after migration

- **[Contributing Guide →](guides/contributing.md)** - Contribute to Claude Code Tresor
  - How to contribute
  - Creating skills
  - Creating agents
  - Creating commands
  - Pull request process
  - Code of conduct

---

## Technical Reference

Complete technical documentation for skills, agents, and commands:

### Skills Reference
- **[Skills Reference →](reference/skills-reference.md)** - Complete skills documentation
  - Skills configuration specification
  - 8 autonomous skills documented
  - YAML frontmatter schema
  - Configuration best practices
  - Troubleshooting skills

**8 Skills Available:**
1. **code-reviewer** - Real-time code quality checks
2. **test-generator** - Test coverage suggestions
3. **git-commit-helper** - Conventional commit messages
4. **security-auditor** - OWASP Top 10 vulnerability scanning
5. **secret-scanner** - API key/secret detection
6. **dependency-auditor** - CVE checking for dependencies
7. **api-documenter** - OpenAPI spec generation
8. **readme-updater** - README update suggestions

---

### Agents Reference
- **[Agents Reference →](reference/agents-reference.md)** - Complete agents documentation
  - Agents configuration specification
  - 8 specialized agents documented
  - YAML frontmatter schema
  - Invocation best practices
  - Agent coordination patterns

**8 Agents Available:**
1. **@code-reviewer** - Code quality expert
2. **@test-engineer** - Testing specialist
3. **@docs-writer** - Documentation expert
4. **@architect** - System design expert
5. **@debugger** - Debugging specialist
6. **@security-auditor** - Security expert
7. **@performance-tuner** - Performance optimization
8. **@refactor-expert** - Code refactoring

---

### Commands Reference
- **[Commands Reference →](reference/commands-reference.md)** - Complete commands documentation
  - Commands configuration specification
  - 4 essential commands documented
  - command.json schema
  - Parameter reference
  - Workflow orchestration

**4 Commands Available:**
1. **/scaffold** - Project/component scaffolding
2. **/review** - Automated code review
3. **/test-gen** - Test generation
4. **/docs-gen** - Documentation generation

---

### FAQ
- **[FAQ →](reference/faq.md)** - Frequently asked questions
  - What is Claude Code Tresor?
  - Skills vs. agents vs. commands?
  - Installation and setup
  - Configuration and customization
  - Troubleshooting
  - Contributing
  - Migration

---

## Workflows

Advanced workflows and integration patterns:

### Git Workflows
- **[Git Workflow →](workflows/git-workflow.md)** - Complete branching strategy
  - Git Flow (dev → main)
  - Branch naming conventions
  - Conventional commits
  - PR workflow
  - Release workflow
  - Hotfix workflow

- **[Quick Reference →](workflows/quick-reference.md)** - Git workflow cheat sheet
  - Daily workflow
  - Release workflow
  - Hotfix workflow
  - Common commands

### GitHub Automation
- **[GitHub Automation →](workflows/github-automation.md)** - CI/CD automation system
  - 5 core workflows
  - Branching strategy
  - Conventional commits
  - Branch protection rules
  - Testing workflows
  - Troubleshooting

### Agent-Skill Integration
- **[Agent-Skill Integration →](workflows/agent-skill-integration.md)** - Multi-tier validation
  - 3-tier architecture
  - Strategic agent-skill pairing
  - Implementation guide
  - Key innovations
  - Testing integration
  - Best practices

---

## Archive

Historical documentation (no longer maintained):

- **[Archive →](archive/)** - Obsolete documentation
  - [Test Archive →](archive/tests/) - Historical test files
  - [Planning Archive →](archive/planning/) - Historical planning documents

---

## External Resources

Additional resources outside this repository:

### Marketing & Promotion
- **[Gist: Claude Code Tresor v2.0](https://gist.github.com/alirezarezvani/3f3deaeeb4a8c3b9e7e25f16ba345821)** - Feature highlights and marketing copy
- **[GitHub Repository](https://github.com/alirezarezvani/claude-code-tresor)** - Source code and issues
- **[GitHub Discussions](https://github.com/alirezarezvani/claude-code-tresor/discussions)** - Community forum

### Support
- **[GitHub Issues](https://github.com/alirezarezvani/claude-code-tresor/issues)** - Report bugs
- **[GitHub Discussions](https://github.com/alirezarezvani/claude-code-tresor/discussions)** - Ask questions

---

## Documentation Structure

Complete documentation directory structure:

```
documentation/
├── README.md                          # This file (master index)
├── guides/                            # User guides
│   ├── installation.md                # Installation instructions
│   ├── getting-started.md             # First-time user walkthrough
│   ├── configuration.md               # Configuration guide
│   ├── troubleshooting.md             # Troubleshooting guide
│   ├── migration.md                   # Version migration guide
│   └── contributing.md                # Contributing guide
├── reference/                         # Technical reference
│   ├── skills-reference.md            # Skills technical reference
│   ├── agents-reference.md            # Agents technical reference
│   ├── commands-reference.md          # Commands technical reference
│   └── faq.md                         # Frequently asked questions
├── workflows/                         # Workflow documentation
│   ├── git-workflow.md                # Git branching strategy
│   ├── quick-reference.md             # Git workflow cheat sheet
│   ├── github-automation.md           # GitHub Actions automation
│   └── agent-skill-integration.md     # Agent-skill integration guide
└── archive/                           # Historical documentation
    ├── README.md                      # Archive index
    ├── tests/                         # Test archive
    │   └── README.md
    └── planning/                      # Planning archive
        └── README.md
```

---

## Documentation Quality

### Verification Status

- ✅ **All guides complete** - 6 user guides (installation, getting-started, configuration, troubleshooting, migration, contributing)
- ✅ **All reference docs complete** - 4 reference documents (skills, agents, commands, FAQ)
- ✅ **All workflow docs complete** - 4 workflow documents (git-workflow, quick-reference, github-automation, agent-skill-integration)
- ✅ **Archive complete** - All obsolete files archived with documentation
- ✅ **Cross-references validated** - All internal links verified

### Documentation Coverage

**Total files:** 18 documentation files
- 6 user guides
- 4 technical reference docs
- 4 workflow documents
- 4 archive/navigation files

**Reduction achieved:** From 27+ files → 18 comprehensive files (33% reduction)

---

## Contributing to Documentation

Found an issue or want to improve documentation?

1. **[Report Issue →](https://github.com/alirezarezvani/claude-code-tresor/issues/new)** - Report documentation bugs
2. **[Contributing Guide →](guides/contributing.md#improving-documentation)** - Documentation contribution guidelines
3. **[GitHub Discussions →](https://github.com/alirezarezvani/claude-code-tresor/discussions)** - Suggest improvements

---

## About Claude Code Tresor

**Author:** Alireza Rezvani
**License:** MIT
**Repository:** https://github.com/alirezarezvani/claude-code-tresor
**Version:** 2.0.0
**Last Updated:** November 7, 2025

---

**Need help?** Start with the [FAQ →](reference/faq.md) or ask in [GitHub Discussions →](https://github.com/alirezarezvani/claude-code-tresor/discussions)
