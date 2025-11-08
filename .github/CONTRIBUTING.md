# Contributing to Claude Code Tresor

Thank you for your interest in contributing to Claude Code Tresor! This document provides guidelines and information for contributors.

## 🎯 How to Contribute

We welcome contributions in the following areas:

### 🚀 Slash Commands
- **Development tools**: Project scaffolding, code refactoring, optimization
- **Testing utilities**: Test generation, coverage analysis, E2E testing
- **Documentation tools**: Auto-generation, API docs, README helpers
- **Workflow automation**: PR reviews, commit messages, deployment

### 🤖 Specialized Agents
- **Code analysis**: Review, security audit, performance optimization
- **Development assistance**: Debugging, refactoring, architecture design
- **Documentation**: Technical writing, API documentation, user guides
- **Testing**: Test creation, validation, quality assurance

### 📝 Prompts & Templates
- **Code generation**: Language and framework-specific templates
- **Best practices**: Clean code, security, performance guidelines
- **Architecture**: System design patterns and methodologies
- **Debugging**: Error analysis and troubleshooting strategies

### 📋 Standards & Guidelines
- **Style guides**: Language-specific coding standards
- **Workflow standards**: Git conventions, PR templates
- **Documentation standards**: README templates, API documentation
- **Quality standards**: Testing methodologies, code review checklists

## 🚀 Getting Started

### Prerequisites
- Familiarity with Claude Code
- Understanding of software development best practices
- Experience with the specific technology you're contributing to

### Development Setup

1. **Fork the repository**:
   ```bash
   git clone https://github.com/your-username/claude-code-tresor.git
   cd claude-code-tresor
   ```

2. **Create a branch for your contribution**:
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Install development dependencies** (if any):
   ```bash
   ./scripts/install.sh
   ```

## 📝 Contribution Guidelines

### File Structure and Naming

#### Slash Commands
- **Location**: `commands/{category}/{command-name}/`
- **Files**:
  - `command.json` - Command configuration
  - `README.md` - Documentation and usage examples
  - `examples/` - Usage examples and test cases

#### Agents
- **Location**: `agents/{agent-name}/`
- **Files**:
  - `agent.json` - Agent configuration and behavior
  - `README.md` - Agent documentation and capabilities
  - `prompts/` - Specialized prompts for the agent
  - `examples/` - Usage examples and test cases

#### Prompts
- **Location**: `prompts/{category}/{prompt-name}.md`
- **Format**: Markdown with clear structure and examples

#### Standards
- **Location**: `standards/{category}/{standard-name}.md`
- **Format**: Comprehensive guidelines with examples

### Quality Standards

#### Code Quality
- **Functionality**: Must work as described and handle edge cases
- **Documentation**: Clear README with usage examples
- **Testing**: Include test cases and validation examples
- **Error handling**: Graceful handling of common error scenarios

#### Documentation Standards
- **Clear purpose**: What problem does this solve?
- **Usage examples**: Real-world scenarios and code samples
- **Parameters**: Clear description of all inputs and outputs
- **Prerequisites**: Dependencies and requirements

#### Naming Conventions
- **Commands**: Use kebab-case (e.g., `code-review`, `test-gen`)
- **Agents**: Use kebab-case (e.g., `code-reviewer`, `performance-tuner`)
- **Files**: Use kebab-case for consistency
- **Directories**: Use kebab-case throughout

### Content Guidelines

#### Slash Commands
```json
{
  "name": "command-name",
  "description": "Brief description of what this command does",
  "category": "development|testing|documentation|workflow",
  "parameters": {
    "required": ["param1", "param2"],
    "optional": ["param3", "param4"]
  },
  "examples": [
    {
      "usage": "/command-name --param1=value",
      "description": "Example usage description"
    }
  ],
  "author": "Your Name",
  "version": "1.0.0",
  "created": "2025-09-16"
}
```

#### Agent Configuration
```json
{
  "name": "agent-name",
  "description": "Brief description of agent capabilities",
  "category": "analysis|development|documentation|testing",
  "capabilities": [
    "Primary capability 1",
    "Primary capability 2"
  ],
  "prompts": {
    "system": "Core system prompt for the agent",
    "examples": ["Example usage 1", "Example usage 2"]
  },
  "author": "Your Name",
  "version": "1.0.0",
  "created": "2025-09-16"
}
```

## ✅ Testing Your Contributions

### Manual Testing
1. **Install your contribution locally**
2. **Test all documented use cases**
3. **Verify error handling**
4. **Check integration with Claude Code**

### Documentation Testing
1. **Follow your own instructions**
2. **Verify all examples work**
3. **Check for clarity and completeness**

### Community Testing
1. **Share with other developers**
2. **Gather feedback on usability**
3. **Iterate based on feedback**

## 📤 Submitting Your Contribution

### Pull Request Process

1. **Ensure your branch is up to date**:
   ```bash
   git fetch upstream
   git rebase upstream/main
   ```

2. **Run any available tests**:
   ```bash
   # Add any test commands here when available
   ```

3. **Create a descriptive pull request**:
   - Use our [PR template](standards/templates/pr-template.md)
   - Include clear description of changes
   - Add examples and test cases
   - Reference any related issues

4. **Respond to feedback**:
   - Address reviewer comments promptly
   - Make requested changes
   - Update documentation as needed

### PR Title Format
```
[Category] Brief description of changes

Examples:
[Commands] Add React component scaffolding command
[Agents] Implement security audit agent
[Prompts] Add debugging prompts for Node.js
[Standards] Update TypeScript style guide
```

### PR Description Template
```markdown
## Description
Brief description of what this PR accomplishes.

## Type of Contribution
- [ ] New slash command
- [ ] New agent
- [ ] New prompt template
- [ ] Documentation update
- [ ] Bug fix
- [ ] Other (please describe)

## Testing
- [ ] Tested locally with Claude Code
- [ ] All examples work as documented
- [ ] Error cases handled gracefully

## Checklist
- [ ] Code follows project conventions
- [ ] Documentation is complete and clear
- [ ] Examples are provided
- [ ] No breaking changes (or breaking changes are documented)
```

## 🔍 Code Review Process

### Review Criteria
1. **Functionality**: Does it work as intended?
2. **Quality**: Is the code/content well-structured?
3. **Documentation**: Is it clear and complete?
4. **Examples**: Are there sufficient usage examples?
5. **Integration**: Does it fit well with existing utilities?

### Review Timeline
- **Initial review**: Within 48 hours
- **Follow-up reviews**: Within 24 hours
- **Final approval**: When all criteria are met

## 🎖️ Recognition

Contributors will be recognized in:
- **README.md**: Contributors section
- **CHANGELOG.md**: Version release notes
- **Individual utility files**: Author attribution

## 🤝 Community Guidelines

### Code of Conduct
- **Be respectful**: Treat all community members with respect
- **Be constructive**: Provide helpful feedback and suggestions
- **Be inclusive**: Welcome contributors of all skill levels
- **Be patient**: Remember that everyone is learning

### Communication Channels
- **GitHub Issues**: Bug reports and feature requests
- **GitHub Discussions**: General questions and ideas
- **Pull Request Comments**: Code review and feedback

## ❓ Getting Help

### Common Questions
- **"How do I test my slash command?"**: See [Testing Your Contributions](#-testing-your-contributions)
- **"What should I name my agent?"**: Follow our [Naming Conventions](#naming-conventions)
- **"Where should I put my prompt?"**: Check [File Structure and Naming](#file-structure-and-naming)

### Support Channels
- **GitHub Issues**: For bugs and technical problems
- **GitHub Discussions**: For general questions and ideas
- **Documentation**: Check existing examples in the repository

## 📈 Roadmap

Want to contribute but not sure where to start? Check out our roadmap:

### High Priority
- [ ] Advanced testing utilities
- [ ] Security scanning tools
- [ ] Performance benchmarking commands
- [ ] Multi-language support for prompts

### Medium Priority
- [ ] Integration with popular frameworks
- [ ] Advanced debugging agents
- [ ] Documentation generation improvements
- [ ] Workflow automation enhancements

### Future Enhancements
- [ ] Plugin system for custom extensions
- [ ] Community marketplace integration
- [ ] Advanced AI-powered utilities
- [ ] Cross-platform compatibility tools

---

**Thank you for contributing to Claude Code Tresor!**

Your contributions help make development workflows better for everyone in the Claude Code community.

*For questions or support, please reach out through GitHub Issues or Discussions.*