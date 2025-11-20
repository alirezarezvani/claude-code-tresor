# Claude Code Tresor - Navigation Guide

> Quick reference for finding your way around the Claude Code Tresor repository

**Version:** 2.7.0
**Last Updated:** November 19, 2025

---

## 📍 Quick Start: Where Is Everything?

### 🤖 Looking for Agents?

**Primary Location:** `/subagents/` (133 total agents)

```bash
subagents/
├── core/                      # 8 core production agents
├── engineering/               # 54 engineering specialists
├── design/                    # 7 design specialists
├── marketing/                 # 11 marketing specialists
├── product/                   # 9 product specialists
├── leadership/                # 14 leadership specialists
├── operations/                # 6 operations specialists
├── research/                  # 7 research specialists
├── ai-automation/             # 9 AI/ML specialists
└── account-customer-success/  # 8 account & CS specialists
```

**Quick Links:**
- **[Browse All Agents →](subagents/README.md)** - Complete catalog with descriptions
- **[Search Agent Index →](subagents/AGENT-INDEX.md)** - Find agents by keyword

**Backward Compatibility:** `/agents/` directory contains symlinks to `/subagents/core/` for v2.6 users.

---

### ⚡ Looking for Commands?

**Location:** `/commands/`

```bash
commands/
├── development/scaffold/      # Project/component scaffolding
├── workflow/                  # Workflow automation (6 commands)
│   ├── review/                # Code review automation
│   ├── prompt-create/         # Generate optimized prompts
│   ├── prompt-run/            # Execute prompts in sub-agents
│   ├── todo-add/              # Capture ideas with context
│   ├── todo-check/            # Resume work on todos
│   └── handoff-create/        # Context handoff documents
├── testing/test-gen/          # Test generation
└── documentation/docs-gen/    # Documentation generation
```

**Quick Reference:**
| Command | Purpose |
|---------|---------|
| **`/scaffold`** | Generate project structures and components |
| **`/review`** | Automated code review with security checks |
| **`/test-gen`** | Create comprehensive test suites |
| **`/docs-gen`** | Generate documentation from code |
| **`/prompt-create`** | Generate optimized prompts for complex tasks |
| **`/prompt-run`** | Execute prompts in fresh sub-agent contexts |
| **`/todo-add`** | Capture ideas without losing flow |
| **`/todo-check`** | Resume work on todos (with agent suggestions) |
| **`/handoff-create`** | Create comprehensive context handoff document |

---

### ✨ Looking for Skills?

**Location:** `/skills/`

```bash
skills/
├── development/
│   ├── code-reviewer/         # Real-time code quality checks
│   ├── test-generator/        # Auto-suggest missing tests
│   └── git-commit-helper/     # Generate commit messages
├── security/
│   ├── security-auditor/      # OWASP Top 10 scanning
│   ├── secret-scanner/        # Detect exposed API keys
│   └── dependency-auditor/    # CVE checking
└── documentation/
    ├── api-documenter/        # Auto-generate OpenAPI specs
    └── readme-updater/        # Keep README current
```

**Skills activate automatically** based on trigger keywords - no manual invocation needed.

**See:** [Skills Guide →](skills/README.md)

---

### 📝 Looking for Prompts?

**Location:** `/prompts/`

Organized by category:
- `frontend/` - React, Vue, Angular development prompts
- `backend/` - API, database, microservices prompts
- `debugging/` - Error analysis and troubleshooting prompts
- `best-practices/` - Clean code, security, refactoring prompts

**See:** [Prompts Catalog →](prompts/README.md)

---

### 📏 Looking for Standards?

**Location:** `/standards/`

```bash
standards/
├── javascript-typescript.json  # ESLint/Prettier configs
├── git-workflow.md             # Conventional commits, branch strategies
├── code-review.md              # PR templates and checklists
└── team-collaboration.md       # Guidelines and best practices
```

---

### 📚 Looking for Documentation?

**Location:** `/documentation/`

```bash
documentation/
├── guides/
│   ├── installation.md         # Install Claude Code Tresor
│   ├── getting-started.md      # First-time user walkthrough
│   ├── configuration.md        # Customize settings
│   ├── troubleshooting.md      # Fix common issues
│   ├── migration.md            # Upgrade from older versions
│   └── contributing.md         # Contribute to the project
├── reference/
│   ├── skills.md               # Skills technical reference
│   ├── agents.md               # Agents architecture details
│   ├── commands.md             # Commands API reference
│   └── faq.md                  # Frequently asked questions
└── workflows/
    ├── git-workflow.md         # Git workflow examples
    ├── github-automation.md    # CI/CD integration
    └── agent-skill-integration.md  # How agents and skills work together
```

**Start Here:** [Master Documentation Index →](documentation/README.md)

---

## 🔍 Finding What You Need

### By Task Type

**Want to scaffold a new project?**
→ `/scaffold` command ([commands/development/scaffold/](commands/development/scaffold/))

**Want automated code review?**
→ `/review` command ([commands/workflow/review/](commands/workflow/review/))

**Want to create tests?**
→ `/test-gen` command OR `test-generator` skill ([commands/testing/test-gen/](commands/testing/test-gen/))

**Want to optimize performance?**
→ `@performance-tuner` agent ([subagents/core/performance-tuner/](subagents/core/performance-tuner/))

**Want security audit?**
→ `@security-auditor` agent OR `security-auditor` skill ([subagents/core/security-auditor/](subagents/core/security-auditor/))

**Want architecture review?**
→ `@systems-architect` agent ([subagents/core/systems-architect/](subagents/core/systems-architect/))

---

### By Domain

**Backend/API Development:**
- Agents: `@backend-architect`, `@api-documenter`, `@database-optimizer` ([subagents/engineering/backend/](subagents/engineering/backend/))
- Commands: `/scaffold express-api`, `/docs-gen api`

**Frontend/UI Development:**
- Agents: `@frontend-developer`, `@ui-designer`, `@react-specialist` ([subagents/engineering/frontend/](subagents/engineering/frontend/))
- Commands: `/scaffold react-component`, `/review --checks a11y`

**Security:**
- Agents: `@security-auditor`, `@security-threat-analyst`, `@penetration-tester` ([subagents/engineering/security/](subagents/engineering/security/))
- Skills: `security-auditor`, `secret-scanner`, `dependency-auditor`

**Testing:**
- Agents: `@test-engineer`, `@qa-test-engineer`, `@api-tester` ([subagents/engineering/testing/](subagents/engineering/testing/))
- Commands: `/test-gen`, Skills: `test-generator`

**DevOps/Infrastructure:**
- Agents: `@devops-engineer`, `@cloud-architect`, `@kubernetes-pro` ([subagents/engineering/devops/](subagents/engineering/devops/))
- Commands: `/scaffold terraform-module`

---

### By Language

**Python:** `@python-pro` → [subagents/engineering/languages/python-pro/](subagents/engineering/languages/python-pro/)
**TypeScript:** `@typescript-pro` → [subagents/engineering/languages/typescript-pro/](subagents/engineering/languages/typescript-pro/)
**Java:** `@java-pro` → [subagents/engineering/languages/java-pro/](subagents/engineering/languages/java-pro/)
**Rust:** `@rust-pro` → [subagents/engineering/languages/rust-pro/](subagents/engineering/languages/rust-pro/)
**Go:** `@golang-pro` → [subagents/engineering/languages/golang-pro/](subagents/engineering/languages/golang-pro/)

**See all 16 language specialists:** [subagents/engineering/languages/](subagents/engineering/languages/)

---

## 📦 Repository Structure Overview

```
claude-code-tresor/
├── agents/                     # [Deprecated v2.7.0] Symlinks to subagents/core/
├── subagents/                  # PRIMARY: 133 agents organized by team
├── skills/                     # 8 autonomous background helpers
├── commands/                   # 9 slash commands for workflows
├── prompts/                    # 20+ prompt templates
├── standards/                  # Development standards and configs
├── examples/                   # Real-world usage examples
├── documentation/              # Complete documentation
│   ├── guides/                 # User guides
│   ├── reference/              # Technical reference
│   └── workflows/              # Workflow examples
├── sources/                    # Extended library (200+ components)
├── scripts/                    # Installation utilities
├── README.md                   # Project overview
├── CLAUDE.md                   # Development guide (for Claude instances)
├── NAVIGATION.md               # This file
├── MIGRATION.md                # Upgrade guide
├── WORKFLOW-GUIDE.md           # Tresor Workflow Framework guide
└── ARCHITECTURE.md             # System architecture
```

---

## 🚀 Quick Installation

```bash
# Full installation (recommended)
./scripts/install.sh

# Selective installation
./scripts/install.sh --skills        # 8 autonomous skills only
./scripts/install.sh --agents        # 133 agents only
./scripts/install.sh --commands      # 9 workflow commands only
```

**See:** [Installation Guide →](documentation/guides/installation.md)

---

## 🆘 Need Help?

**Quick Start:**
1. **New User?** → [Getting Started Guide](documentation/guides/getting-started.md)
2. **Upgrading?** → [Migration Guide](MIGRATION.md)
3. **Stuck?** → [Troubleshooting Guide](documentation/guides/troubleshooting.md)
4. **Questions?** → [FAQ](documentation/reference/faq.md)

**Support Channels:**
- **[GitHub Issues](https://github.com/alirezarezvani/claude-code-tresor/issues)** - Report bugs or request features
- **[GitHub Discussions](https://github.com/alirezarezvani/claude-code-tresor/discussions)** - Ask questions and share ideas
- **[Documentation Index](documentation/README.md)** - Browse all documentation

---

## 📖 Related Resources

- **[Tresor Workflow Framework Guide](WORKFLOW-GUIDE.md)** - Meta-prompting, todos, context handoff
- **[Migration Guide](MIGRATION.md)** - Upgrade from v2.6 or earlier
- **[Architecture Overview](ARCHITECTURE.md)** - System design and component relationships
- **[Contributing Guide](CONTRIBUTING.md)** - Contribute to the project

---

**Version:** 2.7.0
**Last Updated:** November 19, 2025
**License:** MIT
**Author:** Alireza Rezvani
