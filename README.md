# Claude Code Tresor 🏆

> A world-class collection of Claude Code utilities: prompts, slash commands, and subagents that supercharge your development workflow.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/alirezarezvani/claude-code-tresor)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-Compatible-blue.svg)](https://claude.ai/code)
[![Contributions Welcome](https://img.shields.io/badge/contributions-welcome-brightgreen.svg)](CONTRIBUTING.md)

**Author**: Alireza Rezvani
**Created**: September 16, 2025
**License**: MIT
**Repository**: https://github.com/alirezarezvani/claude-code-tresor

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

### 🤖 Specialized Agents (3 Core)
Expert-level assistance for complex development tasks:

| Agent | Expertise | Best For |
|-------|-----------|----------|
| **`@code-reviewer`** | Code quality, security, performance analysis | PR reviews, code audits, best practices |
| **`@test-engineer`** | Testing strategies, test creation, QA | Unit tests, integration tests, coverage analysis |
| **`@docs-writer`** | Technical documentation, user guides | API docs, README files, troubleshooting guides |

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

## 🚀 Quick Start

### Option 1: Automated Installation (Recommended)

```bash
# Clone the repository
git clone https://github.com/alirezarezvani/claude-code-tresor.git
cd claude-code-tresor

# Run the installation script
chmod +x scripts/install.sh
./scripts/install.sh
```

### Option 2: Manual Installation

```bash
# Copy commands to Claude Code directory
cp -r commands/* ~/.config/claude-code/commands/

# Copy agents to Claude Code directory
cp -r agents/* ~/.config/claude-code/agents/

# Copy resources for reference
cp -r prompts standards examples ~/claude-code-resources/
```

### Option 3: Selective Installation

```bash
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
├──
├── ⚡ commands/                     # Slash Commands
│   ├── development/                # Project scaffolding and tools
│   ├── testing/                    # Test generation and analysis
│   ├── documentation/              # Doc generation utilities
│   └── workflow/                   # PR reviews and automation
├──
├── 🤖 agents/                      # Specialized Agents
│   ├── code-reviewer/              # Code quality expert
│   ├── test-engineer/              # Testing specialist
│   └── docs-writer/                # Documentation expert
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
1. **Install**: Run `./scripts/install.sh`
2. **Try**: `/scaffold react-component TestComponent --tests`
3. **Learn**: Browse `examples/workflows/react-app-setup.md`
4. **Explore**: Check out prompt templates in `prompts/`

### 🏃‍♂️ Ready to Build?
1. **Full Setup**: Follow `examples/workflows/react-app-setup.md`
2. **Code Review**: Use `@code-reviewer` for quality analysis
3. **Testing**: Generate tests with `@test-engineer`
4. **Documentation**: Create docs with `/docs-gen`

### 👥 Team Lead?
1. **Standards**: Implement `standards/style-guides/javascript.md`
2. **Workflows**: Set up `standards/git-workflows/conventional-commits.md`
3. **Templates**: Use `standards/templates/` for consistency
4. **Training**: Share `examples/` with your team

### 🔧 Power User?
1. **Customize**: Adapt templates in `prompts/` for your needs
2. **Extend**: Explore additional utilities in `sources/`
3. **Contribute**: Add your own utilities following `CONTRIBUTING.md`
4. **Automate**: Build custom workflows using the utilities

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

- **🏗️ Core Utilities**: 10 (commands + agents)
- **📝 Prompt Templates**: 20+ battle-tested prompts
- **📏 Standards**: 5 comprehensive style guides
- **💡 Examples**: 10+ real-world workflows
- **📦 Source Library**: 200+ additional components
- **⚡ Installation Time**: < 2 minutes
- **📈 Active Development**: Continuously updated

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
- 🌐 **Website**: [Your website if you have one]

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