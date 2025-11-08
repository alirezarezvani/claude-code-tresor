# Claude Code Slash Commands

This directory contains a curated collection of slash commands that enhance your Claude Code workflow. Each command is designed to automate common development tasks and boost productivity.

## 📁 Directory Structure

```
commands/
├── development/          # Project scaffolding and development tools
│   ├── scaffold/        # Project and component scaffolding
│   ├── refactor/        # Code refactoring utilities
│   └── optimize/        # Performance optimization tools
├── testing/             # Testing automation and utilities
│   ├── test-gen/        # Automated test generation
│   ├── coverage/        # Test coverage analysis
│   └── e2e/            # End-to-end testing helpers
├── documentation/       # Documentation generation and management
│   ├── docs-gen/        # Documentation generation
│   ├── api-docs/        # API documentation tools
│   └── readme-gen/      # README generation utilities
└── workflow/            # Development workflow automation
    ├── review/          # Code review automation
    ├── commit-msg/      # Commit message generation
    └── deploy/          # Deployment helpers
```

## 🚀 Available Commands

### Development Commands
- **`/scaffold`** - Generate project structures, components, and boilerplate code
- **`/refactor`** - Automated code refactoring with best practices
- **`/optimize`** - Performance analysis and optimization suggestions

### Testing Commands
- **`/test-gen`** - Generate comprehensive test suites automatically
- **`/coverage`** - Analyze and improve test coverage
- **`/e2e`** - End-to-end testing setup and management

### Documentation Commands
- **`/docs-gen`** - Generate project documentation from code
- **`/api-docs`** - Create API documentation and specifications
- **`/readme-gen`** - Generate and update README files

### Workflow Commands
- **`/review`** - Automated code review with best practices
- **`/commit-msg`** - Generate conventional commit messages
- **`/deploy`** - Deployment automation and verification

## 💡 Usage Examples

### Quick Scaffolding
```bash
# Create a new React component with tests
/scaffold react-component UserProfile --hooks --tests --stories

# Generate a complete Express API
/scaffold express-api user-service --auth --tests --docker
```

### Automated Testing
```bash
# Generate tests for a specific file
/test-gen --file src/utils/helpers.js --framework jest

# Analyze test coverage and suggest improvements
/coverage --report --suggestions
```

### Smart Documentation
```bash
# Generate API docs from code comments
/docs-gen api --format openapi --output docs/

# Create comprehensive README
/readme-gen --sections all --examples --badges
```

### Code Review Automation
```bash
# Review current changes with best practices
/review --scope staged --checks security,performance,style

# Generate commit message from changes
/commit-msg --conventional --scope
```

## 🛠️ Installation

### Individual Command Installation
```bash
# Install a specific command
cp commands/development/scaffold ~/.claude/commands/

# Install all commands from a category
cp -r commands/testing/* ~/.claude/commands/
```

### Bulk Installation
```bash
# Install all commands at once
./scripts/install.sh commands
```

## 📋 Command Standards

All commands in this collection follow these standards:

### File Structure
```
command-name/
├── command.json         # Command configuration
├── README.md           # Documentation and examples
├── examples/           # Usage examples
└── tests/             # Test cases (if applicable)
```

### Configuration Format
```json
{
  "name": "command-name",
  "description": "Brief description of functionality",
  "category": "development|testing|documentation|workflow",
  "parameters": {
    "required": ["param1"],
    "optional": ["param2"]
  },
  "author": "Author Name",
  "version": "1.0.0",
  "created": "2025-09-16"
}
```

### Quality Requirements
- ✅ **Functionality**: Works reliably across different scenarios
- ✅ **Documentation**: Clear usage examples and parameter descriptions
- ✅ **Error Handling**: Graceful handling of edge cases
- ✅ **Performance**: Efficient execution with minimal resource usage
- ✅ **Compatibility**: Works across different project types and structures

## 🤝 Contributing

We welcome contributions of new commands! See our [Contributing Guidelines](../CONTRIBUTING.md) for details on:

- Command development standards
- Testing requirements
- Documentation guidelines
- Pull request process

### Command Ideas Wanted
- **Database migration tools**
- **CI/CD pipeline generators**
- **Security audit commands**
- **Performance benchmarking**
- **Internationalization helpers**
- **Accessibility testing tools**

## 📈 Usage Analytics

Popular commands (based on community usage):
1. `/scaffold` - Project and component generation
2. `/test-gen` - Automated test creation
3. `/review` - Code review automation
4. `/docs-gen` - Documentation generation

## 🔧 Troubleshooting

### Common Issues

**Command not found**
```bash
# Ensure command is properly installed
ls ~/.claude/commands/command-name/

# Check command configuration
cat ~/.claude/commands/command-name/command.json
```

**Permission errors**
```bash
# Fix permissions
chmod +x ~/.claude/commands/command-name/*
```

**Configuration errors**
```bash
# Validate JSON configuration
cat command.json | python -m json.tool
```

## 📞 Support

- **Documentation**: Check individual command README files
- **Issues**: Report bugs in the main repository
- **Feature Requests**: Use GitHub Discussions
- **Community**: Join our Discord/Slack (links in main README)

---

**Happy coding with Claude Code Tresor! 🚀**