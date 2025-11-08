# Claude Code Tresor 🏆

> A world-class collection of Claude Code utilities: autonomous skills, expert agents, slash commands, and prompts that supercharge your development workflow.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/version-2.0.0-blue.svg)](https://github.com/alirezarezvani/claude-code-tresor)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Compatible-blue.svg)](https://claude.ai/code)
[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg)](CONTRIBUTING.md)

**Author**: Alireza Rezvani
**Created**: September 16, 2025
**Updated**: November 8, 2025 (v2.0.0 - Documentation & Path Fixes)
**License**: MIT
**Repository**: https://github.com/alirezarezvani/claude-code-tresor

---

## 🎉 What's New in v2.0.0

**Major Feature: Skills Layer** - Autonomous background helpers that work automatically!

- ✨ **8 New Skills** - Automatic code quality, security scanning, test suggestions, and documentation
- 🔄 **3-Tier Architecture** - Skills (automatic) → Agents (manual) → Commands (workflows)
- 📚 **Comprehensive Guides** - [Getting Started](GETTING-STARTED.md), [Architecture](ARCHITECTURE.md), [Migration](MIGRATION-GUIDE.md)
- 🛡️ **Zero Breaking Changes** - All existing agents and commands work exactly as before
- 🎯 **Simple & Intuitive** - Skills work without configuration, sandboxing is optional

**Upgrading?** See [MIGRATION-GUIDE.md](MIGRATION-GUIDE.md) for seamless upgrade with zero breaking changes.

---

## 🎯 What is Claude Code Tresor?

Claude Code Tresor is the ultimate collection of **professional-grade utilities** for Claude Code users. Whether you're a solo developer or part of a team, this repository provides battle-tested tools that integrate seamlessly into your development workflow.

### 🌟 Why Choose Claude Code Tresor?

- **🚀 Production-Ready**: All utilities are tested and used in real-world projects
- **📚 Comprehensive**: Covers the entire development lifecycle
- **🛠️ Easy Installation**: One-command setup with automated updates
- **🎨 Customizable**: Adapt templates to your specific needs and tech stack
- **👥 Team-Friendly**: Includes collaboration guidelines and standards
- **📖 Well-Documented**: Every component includes detailed examples and usage guides

> **💡 Ecosystem Tip:** Looking for more? Check out the [Claude Code Skill Factory](https://github.com/alirezarezvani/claude-code-skill-factory) to build custom skills, or browse the [Claude Skills Library](https://github.com/alirezarezvani/claude-skills) for pre-built professional domain packages. See [Related Projects](#-related-projects--ecosystem) for details.
>
> **📖 [Complete Augmentation Guide](https://gist.github.com/alirezarezvani/a0f6e0a984d4a4adc4842bbe124c5935)** - Comprehensive guide with FAQs, use cases, and installation instructions

---

## ✨ What's Included

### 🚀 Slash Commands (4 Essential)
Transform your development workflow with these powerful commands:

| Command | Purpose | Example Usage |
|---------|---------|---------------|
| **`/scaffold`** | Generate project structures, components, and boilerplate | `/scaffold react-component UserProfile --hooks --tests` |
| **`/review`** | Automated code review with security and performance analysis | `/review --scope staged --checks security,performance` |
| **`/test-gen`** | Create comprehensive test suites automatically | `/test-gen --file utils.js --coverage 90` |
| **`/docs-gen`** | Generate documentation from code and comments | `/docs-gen api --format openapi` |

### 🤖 Specialized Agents (8 Expert)
Expert-level assistance for complex development tasks:

| Agent | Expertise | Best For |
|-------|-----------|----------|
| **`@code-reviewer`** | Code quality, security, performance analysis | PR reviews, code audits, best practices |
| **`@test-engineer`** | Testing strategies, test creation, QA | Unit tests, integration tests, coverage analysis |
| **`@docs-writer`** | Technical documentation, user guides | API docs, README files, troubleshooting guides |
| **`@architect`** | System design, technology evaluation | Architecture reviews, design decisions |
| **`@debugger`** | Root cause analysis, troubleshooting | Production issues, complex bugs |
| **`@security-auditor`** | Security assessment, OWASP compliance | Security audits, vulnerability analysis |
| **`@performance-tuner`** | Performance optimization, profiling | Performance issues, bottleneck analysis |
| **`@refactor-expert`** | Code refactoring, clean architecture | Technical debt, code modernization |

### ✨ Skills (8 Autonomous) - **NEW!**
Automatic background helpers that work while you code:

| Skill | What It Does | Triggers On |
|-------|--------------|-------------|
| **`code-reviewer`** | Real-time code quality checks | File edits, saves |
| **`test-generator`** | Suggests missing tests automatically | New functions, untested code |
| **`git-commit-helper`** | Generates commit messages from diff | `git diff --staged` |
| **`security-auditor`** | Detects vulnerabilities (SQL injection, XSS) | Auth code, API endpoints |
| **`secret-scanner`** | Blocks commits with exposed secrets | Pre-commit, API keys in code |
| **`dependency-auditor`** | Checks dependencies for CVEs | package.json changes |
| **`api-documenter`** | Auto-generates OpenAPI specs | API routes added |
| **`readme-updater`** | Keeps README current | Project changes, features |

**Skills vs Agents:** Skills work **automatically** in the background. Agents require **manual invocation** (`@agent`) for deep analysis.

**Learn more:** [Skills Guide](skills/README.md) · [Getting Started](GETTING-STARTED.md) · [Architecture](ARCHITECTURE.md)

### 📝 Curated Prompt Templates (20+)
Ready-to-use prompts for common development scenarios:

- **Frontend Development**: React, Vue, Angular, JavaScript/TypeScript
- **Backend Development**: APIs, databases, authentication, microservices
- **Debugging & Analysis**: Error analysis, performance troubleshooting
- **Best Practices**: Clean code, security, refactoring strategies

### 📏 Development Standards
Professional coding standards and style guides:

- **JavaScript/TypeScript** style guide with ESLint/Prettier configs
- **Git workflows** with conventional commits
- **Code review** checklists and PR templates
- **Team collaboration** guidelines

### 💡 Real-World Examples
Complete workflow demonstrations:

- **React App Setup**: Full modern React application from scratch
- **API Development**: RESTful APIs with testing and documentation
- **Performance Optimization**: Systematic performance improvement
- **CI/CD Pipelines**: Automated testing and deployment

### 📦 Source Library (200+ Components)
Extensive collection of additional utilities in the `sources/` directory:

- **80+ Specialized Agents**: Marketing, design, operations, AI automation
- **Advanced Slash Commands**: Tools and workflow automation
- **Extended Templates**: Industry-specific prompts and patterns

---

## 🔗 Related Projects & Ecosystem

Looking to extend your Claude Code capabilities further? Check out these companion repositories:

### 🏭 [Claude Code Skill Factory](https://github.com/alirezarezvani/claude-code-skill-factory)
**Build your own custom Skills and Agents at scale**

A comprehensive toolkit for generating production-ready Claude Skills and Agents without starting from scratch. Perfect when you need specialized capabilities beyond what's available in pre-built collections.

**Key Features:**
- **Skills Factory**: Generate multi-file skill packages with Python code, documentation, and examples
- **Agents Factory**: Create single-file specialist agents with enhanced YAML configuration
- **Smart Architecture**: Automatically determines when functional code is needed vs. prompt-only approaches
- **7 Reference Examples**: Financial analysis, AWS architecture, content research, Microsoft 365, and more
- **Enterprise Standards**: Type-annotated code, error handling, and composable design

**Best For:** Developers who need custom domain-specific capabilities, teams building proprietary workflows, or organizations requiring specialized AI tools tailored to their tech stack.

**Use Case:** "I need a skill that analyzes our company's specific Terraform patterns" → Use Skill Factory to generate it

### 📚 [Claude Skills Library](https://github.com/alirezarezvani/claude-skills)
**Production-ready skill packages for professional domains**

A curated collection of specialized skill packages combining best practices, analysis tools, and strategic frameworks for various professional roles. Deploy expert-level capabilities immediately.

**Available Collections:**
- **Marketing** (3 packages): Content strategy, demand generation, product marketing
- **C-Level Advisory** (2 packages): CEO and CTO strategic guidance
- **Product Team** (6 packages): Product management, UX research, design systems, agile delivery
- **Project Management** (6 packages): Jira, Confluence, Scrum, PMO, Atlassian integration
- **Engineering** (9 packages): Architecture, fullstack, QA, DevOps, security, code review
- **AI/ML/Data** (Coming soon): Data science and machine learning workflows

**Key Benefits:**
- **40%+ time savings** through domain-specific guidance
- **30%+ quality improvements** with built-in best practices
- **Python CLI utilities** for automated analysis and reporting
- **Ready-to-use templates** for immediate deployment

**Best For:** Teams needing enterprise-grade expertise packages, professionals seeking domain-specific guidance, or organizations standardizing workflows across multiple roles.

**Use Case:** "I need comprehensive product management workflows with templates and frameworks" → Use Claude Skills Library

---

### 📖 Complete Ecosystem Guide

**New to Claude Code augmentation?** Read the comprehensive guide with FAQs, installation instructions, and detailed use cases:

**[📖 Complete Augmentation Guide](https://gist.github.com/alirezarezvani/a0f6e0a984d4a4adc4842bbe124c5935)** (GitHub Gist)

This guide answers:
- What is Claude Code augmentation and why should I use it?
- How do Skills, Agents, Commands, and Hooks work?
- Which repository should I use for my needs?
- Step-by-step installation for all three repositories
- 20+ FAQs covering installation, usage, and troubleshooting
- 5+ detailed use cases with code examples

---

### 🎯 How These Projects Work Together

| Your Need | Use This Repository |
|-----------|-------------------|
| **Ready-to-use utilities** (scaffolding, code review, testing, docs) | **Claude Code Tresor** (this repo) |
| **Build custom skills** for your specific domain/tech stack | [**Skill Factory**](https://github.com/alirezarezvani/claude-code-skill-factory) |
| **Deploy pre-built expertise** for professional roles | [**Skills Library**](https://github.com/alirezarezvani/claude-skills) |

**Complete Workflow Example:**
1. **Start here** (Claude Code Tresor) → Install 8 skills + 8 agents + 4 commands for development workflows
2. **Browse Skills Library** → Add marketing, product, or engineering domain expertise packages
3. **Build custom with Skill Factory** → Generate proprietary skills for your company's unique needs

All three repositories are **MIT licensed** and maintained by Alireza Rezvani.

---

## 📚 Documentation

**[Complete Documentation →](documentation/README.md)**

### Quick Links
- **[Installation Guide →](documentation/guides/installation.md)** - Install in 5 minutes
- **[Getting Started →](documentation/guides/getting-started.md)** - Your first workflow
- **[FAQ →](documentation/reference/faq.md)** - Common questions answered
- **[Troubleshooting →](documentation/guides/troubleshooting.md)** - Fix issues

### Full Documentation
- **[User Guides →](documentation/guides/)** - Installation, configuration, troubleshooting, migration, contributing
- **[Technical Reference →](documentation/reference/)** - Complete skills, agents, and commands documentation
- **[Workflows →](documentation/workflows/)** - Git workflow, GitHub automation, agent-skill integration

---

## 🚀 Quick Start

### Option 1: Automated Installation (Recommended)

```bash
# Clone the repository
git clone https://github.com/alirezarezvani/claude-code-tresor.git
cd claude-code-tresor

# Run the installation script (installs skills + agents + commands)
chmod +x scripts/install.sh
./scripts/install.sh
```

**What's installed:**
- ✅ **8 Skills** - Automatic background helpers
- ✅ **8 Agents** - Manual expert sub-agents
- ✅ **4 Commands** - Workflow automation

**First time?** See [GETTING-STARTED.md](GETTING-STARTED.md) for 5-minute quick start.

### Option 2: Manual Installation

```bash
# Copy skills to Claude Code directory
cp -r skills/* ~/.claude/skills/

# Copy commands to Claude Code directory
cp -r commands/* ~/.claude/commands/

# Copy agents to Claude Code directory
cp -r agents/* ~/.claude/agents/

# Copy resources for reference
cp -r prompts standards examples ~/claude-code-resources/
```

### Option 3: Selective Installation

```bash
# Install only autonomous skills (v2.0+)
./scripts/install.sh --skills-only

# Install only slash commands
./scripts/install.sh --commands-only

# Install only agents
./scripts/install.sh --agents-only

# Install only resources (prompts, standards, examples)
./scripts/install.sh --resources-only
```

---

## 🛠️ Usage Examples

### 🏗️ Project Setup
```bash
# Create a complete React application
/scaffold react-app my-project --typescript --tailwind --tests

# Generate API endpoints with tests
/scaffold express-api user-service --auth --database --tests
```

### 🔍 Code Review
```bash
# Comprehensive code review
@code-reviewer Please review this component for:
- React best practices
- Performance optimization
- Security considerations
- Accessibility compliance

# Automated PR review
/review --scope pr --checks security,performance,style
```

### 🧪 Testing
```bash
# Generate comprehensive tests
@test-engineer Create unit tests for this utility function with:
- Edge case coverage
- Error handling tests
- Performance benchmarks

# Automated test generation
/test-gen --file components/UserCard.tsx --framework jest
```

### 📖 Documentation
```bash
# Generate API documentation
/docs-gen api --format openapi --include-examples

# Create user guides
@docs-writer Create a user guide for this authentication system with:
- Setup instructions
- Usage examples
- Troubleshooting guide
```

---

## 📁 Repository Structure

```
claude-code-tresor/
├── 📖 README.md                    # This file - complete overview
├── ⚖️ LICENSE                      # MIT License
├── 🤝 CONTRIBUTING.md              # Contribution guidelines
├── 📚 GETTING-STARTED.md           # 5-minute quick start guide
├── 🏗️ ARCHITECTURE.md              # 3-tier system explanation
├── 🔄 MIGRATION-GUIDE.md           # Upgrade guide for existing users
├──
├── ✨ skills/                      # 8 Autonomous Skills (NEW v2.0!)
│   ├── development/                # code-reviewer, test-generator, git-commit-helper
│   ├── security/                   # security-auditor, secret-scanner, dependency-auditor
│   ├── documentation/              # api-documenter, readme-updater
│   ├── README.md                   # Skills guide
│   └── TEMPLATES.md                # Custom skill templates
├──
├── 🤖 agents/                      # 8 Specialized Agents
│   ├── code-reviewer/              # Code quality expert
│   ├── test-engineer/              # Testing specialist
│   ├── docs-writer/                # Documentation expert
│   ├── architect/                  # System design expert
│   ├── debugger/                   # Debugging specialist
│   ├── security-auditor/           # Security expert
│   ├── performance-tuner/          # Performance optimization
│   └── refactor-expert/            # Code refactoring
├──
├── ⚡ commands/                     # 4 Slash Commands
│   ├── development/                # Project scaffolding and tools
│   ├── testing/                    # Test generation and analysis
│   ├── documentation/              # Doc generation utilities
│   └── workflow/                   # PR reviews and automation
├──
├── 📝 prompts/                     # Prompt Templates
│   ├── code-generation/            # Frontend & backend prompts
│   ├── debugging/                  # Error analysis prompts
│   ├── architecture/               # System design prompts
│   └── best-practices/             # Code quality prompts
├──
├── 📏 standards/                   # Development Standards
│   ├── style-guides/               # Language-specific guides
│   ├── git-workflows/              # Git best practices
│   └── templates/                  # PR and issue templates
├──
├── 💡 examples/                    # Real-World Examples
│   ├── workflows/                  # Complete project workflows
│   ├── integrations/               # Service integration examples
│   └── case-studies/               # Detailed project case studies
├──
├── 📦 sources/                     # Extended Source Library
│   ├── agents/                     # 200+ additional agents
│   └── slash-commands/             # Advanced command utilities
├──
└── 🔧 scripts/                     # Utility Scripts
    ├── install.sh                  # Easy installation
    └── update.sh                   # Update utilities
```

---

## 🎯 Getting Started Paths

### 👶 New to Claude Code?
1. **Install**: Run `./scripts/install.sh` (installs skills + agents + commands)
2. **Observe**: Skills work automatically - start coding and watch them detect issues
3. **Try Command**: `/scaffold react-component TestComponent --tests`
4. **Invoke Agent**: `@code-reviewer` for deep analysis
5. **Learn**: Browse [GETTING-STARTED.md](GETTING-STARTED.md) for 5-min quick start

### 🏃‍♂️ Ready to Build?
1. **Skills monitor**: Automatic background checks (code quality, security, tests)
2. **Agent analysis**: `@code-reviewer`, `@test-engineer` for deep dives
3. **Command workflows**: `/review --scope staged`, `/test-gen --file utils.js`
4. **Full workflow**: Skills detect → Agents analyze → Commands orchestrate

### 👥 Team Lead?
1. **Standards**: Implement `standards/style-guides/javascript.md`
2. **Workflows**: Set up `standards/git-workflows/conventional-commits.md`
3. **Templates**: Use `standards/templates/` for consistency
4. **Training**: Share `examples/` with your team

### 🔧 Power User?
1. **Customize**: Adapt templates in `prompts/` for your needs
2. **Extend**: Explore additional utilities in `sources/`
3. **Build Custom**: Use [Skill Factory](https://github.com/alirezarezvani/claude-code-skill-factory) to generate proprietary skills
4. **Add Expertise**: Browse [Skills Library](https://github.com/alirezarezvani/claude-skills) for domain packages (marketing, product, engineering)
5. **Contribute**: Add your own utilities following `CONTRIBUTING.md`
6. **Automate**: Build custom workflows using the utilities

---

## 🚀 Updates & Maintenance

### Automatic Updates
```bash
# Update all utilities
./scripts/update.sh

# Check for updates without applying
./scripts/update.sh --check

# Update specific components
./scripts/update.sh --commands-only
```

### Stay Current
- ⭐ **Star this repository** to get notified of updates
- 👀 **Watch releases** for new features and utilities
- 📢 **Join discussions** to suggest improvements
- 🤝 **Contribute** your own utilities and improvements

---

## 🤝 Contributing

We welcome contributions from the community! Here's how to get involved:

### Quick Contributions
- 🐛 **Report bugs** in GitHub Issues
- 💡 **Suggest features** in GitHub Discussions
- 📖 **Improve documentation** with clarifications
- ⭐ **Share your experience** with others

### Code Contributions
- 🔧 **Add new utilities** following our standards
- 🎨 **Improve existing code** with enhancements
- 🧪 **Add test coverage** for utilities
- 📚 **Create examples** for complex workflows

### Process
1. **Fork** the repository
2. **Create** a feature branch: `git checkout -b feature/amazing-utility`
3. **Follow** our standards in `standards/` directory
4. **Test** your changes thoroughly
5. **Submit** a pull request using our template

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

---

## 📊 Project Stats

**This Repository:**
- **✨ Skills**: 8 autonomous background helpers (NEW v2.0!)
- **🤖 Agents**: 8 expert sub-agents for deep analysis
- **⚡ Commands**: 4 workflow orchestration commands
- **📝 Prompt Templates**: 20+ battle-tested prompts
- **📏 Standards**: 5 comprehensive style guides
- **💡 Examples**: 10+ real-world workflows
- **📦 Source Library**: 200+ additional components
- **⏱️ Installation Time**: < 2 minutes
- **📈 Version**: 2.0.0 (Major update: Skills layer!)

**Complete Ecosystem:**
- **🏭 [Skill Factory](https://github.com/alirezarezvani/claude-code-skill-factory)**: Generate unlimited custom skills and agents
- **📚 [Skills Library](https://github.com/alirezarezvani/claude-skills)**: 26+ pre-built professional domain packages (Marketing, Product, Engineering, PM, C-Level)
- **🔄 Active Development**: All three repositories continuously updated
- **⚖️ License**: MIT across all projects

---

## 🏆 Success Stories

### Individual Developers
> *"Claude Code Tresor cut my React setup time from hours to minutes. The testing utilities alone saved me weeks of work!"* - Sarah K., Frontend Developer

### Development Teams
> *"Our code quality improved dramatically after implementing the standards and review workflows. PRs are now focused on logic, not style."* - Mike R., Tech Lead

### Agencies & Consultancies
> *"We use Claude Code Tresor as our standard toolkit. It ensures consistency across all client projects and speeds up delivery."* - Jennifer L., CTO

---

## 📄 License & Usage

This project is licensed under the **MIT License** - see [LICENSE](LICENSE) for details.

### You Can:
- ✅ Use for commercial and personal projects
- ✅ Modify and distribute
- ✅ Create derivative works
- ✅ Include in proprietary software

### Requirements:
- 📄 Include copyright notice and license
- 🏷️ Credit original author when sharing

---

## 🙏 Acknowledgments

- **Claude Code Team**: For creating an amazing development platform
- **Open Source Community**: For inspiration and best practices
- **Contributors**: Everyone who has helped improve these utilities
- **Users**: For feedback and real-world testing

Special thanks to developers worldwide who believe in sharing knowledge and tools to make development better for everyone.

---

## 📞 Support & Community

### Get Help
- 📋 **Issues**: [GitHub Issues](https://github.com/alirezarezvani/claude-code-tresor/issues) for bugs and feature requests
- 💬 **Discussions**: [GitHub Discussions](https://github.com/alirezarezvani/claude-code-tresor/discussions) for questions and ideas
- 📖 **Documentation**: Browse `examples/` directory for detailed guides
- 🔍 **Search**: Use repository search to find specific utilities

### Connect
- 🐦 **Twitter**: [@alirezarezvani](https://twitter.com/alirezarezvani)
- 💼 **LinkedIn**: [Alireza Rezvani](https://linkedin.com/in/alirezarezvani)
- 🌐 **Website**: [https://alirezarezvani.com] (Portfolio Website)
- 🌐 **Claude Code Tutorials and Guides**: [https://medium.com/@alirezarezvani] (Medium Blog)
### Professional Support
For professional support, custom utilities, or team training:
- 📧 **Email**: [Your professional email]
- 💼 **Consulting**: Available for custom development and team training

---

## ⭐ Star History

If you find Claude Code Tresor valuable, please consider starring the repository! It helps others discover these utilities and motivates continued development.

[![Star History Chart](https://api.star-history.com/svg?repos=alirezarezvani/claude-code-tresor&type=Date)](https://star-history.com/#alirezarezvani/claude-code-tresor&Date)

---

<div align="center">

**Made with ❤️ by [Alireza Rezvani](https://github.com/alirezarezvani)**

*Empowering developers with world-class Claude Code utilities*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](CONTRIBUTING.md)
[![Code Quality](https://img.shields.io/badge/Code%20Quality-A+-brightgreen.svg)](standards/)

**🚀 [Get Started Now](#-quick-start) | 📚 [View Examples](examples/) | 🤝 [Contribute](CONTRIBUTING.md)**

</div>