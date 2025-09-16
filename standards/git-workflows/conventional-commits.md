# Conventional Commits Standard 📝

A specification for adding human and machine-readable meaning to commit messages, enabling automated versioning, changelog generation, and better collaboration.

## 🎯 Overview

Conventional Commits provide:
- **Structured History**: Clear, searchable commit history
- **Automated Tools**: Enables automated versioning and changelog generation
- **Clear Communication**: Describes the nature and impact of changes
- **Better Collaboration**: Makes it easier for team members to understand changes
- **Release Management**: Facilitates semantic versioning and automated releases

## 📏 Commit Message Format

### Basic Structure
```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

### Examples
```bash
# Simple commit
feat: add user authentication

# With scope
feat(auth): add JWT token validation

# With body and footer
feat(api): add user registration endpoint

Implement POST /api/auth/register endpoint with email validation,
password hashing, and user creation. Includes comprehensive error
handling and input sanitization.

Closes #123
```

## 🏷️ Commit Types

### Primary Types

#### `feat` - New Features
```bash
# Adding new functionality
feat: add dark mode toggle
feat(ui): implement responsive navigation menu
feat(api): add user profile endpoint
```

#### `fix` - Bug Fixes
```bash
# Fixing existing functionality
fix: resolve memory leak in data processing
fix(auth): correct token expiration validation
fix(ui): fix button alignment on mobile devices
```

#### `docs` - Documentation
```bash
# Documentation changes only
docs: update API documentation
docs(readme): add installation instructions
docs: fix typos in contributing guide
```

#### `style` - Code Style
```bash
# Code style changes (formatting, missing semicolons, etc.)
style: fix eslint warnings
style(components): improve code formatting
style: add missing semicolons
```

#### `refactor` - Code Refactoring
```bash
# Code changes that neither fix bugs nor add features
refactor: extract user validation logic
refactor(utils): simplify date formatting functions
refactor: improve error handling structure
```

#### `test` - Tests
```bash
# Adding or modifying tests
test: add unit tests for authentication service
test(api): add integration tests for user endpoints
test: improve test coverage for utility functions
```

#### `chore` - Maintenance
```bash
# Other changes that don't modify src or test files
chore: update dependencies
chore(build): configure webpack for production
chore: add pre-commit hooks
```

### Secondary Types

#### `perf` - Performance Improvements
```bash
perf: improve database query performance
perf(image): optimize image loading and caching
perf: reduce bundle size by 20%
```

#### `ci` - Continuous Integration
```bash
ci: add automated testing workflow
ci(github): update build pipeline configuration
ci: fix deployment script issues
```

#### `build` - Build System
```bash
build: upgrade webpack to version 5
build(docker): optimize container image size
build: configure babel for modern browsers
```

#### `revert` - Reverting Changes
```bash
revert: revert "feat: add user authentication"

This reverts commit 1234567890abcdef due to security concerns.
```

## 🎯 Scopes

### Purpose
Scopes provide additional context about which part of the codebase is affected.

### Common Scopes

#### Frontend Scopes
```bash
feat(ui): add loading spinner component
fix(components): resolve prop validation warnings
style(layout): improve responsive grid system
```

#### Backend Scopes
```bash
feat(api): add user management endpoints
fix(database): resolve connection pool issues
perf(queries): optimize user search functionality
```

#### Feature-Based Scopes
```bash
feat(auth): implement OAuth2 integration
fix(payment): resolve checkout calculation errors
test(notifications): add email delivery tests
```

#### Infrastructure Scopes
```bash
chore(docker): update base image to node:18
ci(deploy): add staging environment workflow
build(webpack): configure code splitting
```

### Scope Guidelines
- **Be Consistent**: Use the same scopes across your team
- **Be Specific**: Choose the most relevant scope
- **Keep It Short**: Use abbreviations when appropriate
- **Document Scopes**: Maintain a list of accepted scopes

## ✍️ Writing Effective Descriptions

### Description Guidelines
- **Use imperative mood**: "add" not "added" or "adds"
- **Keep it concise**: 50 characters or less when possible
- **Start lowercase**: Unless it's a proper noun
- **No period**: Don't end with a period
- **Be descriptive**: Explain what the change does, not how

### Good Examples
```bash
# ✅ Clear and concise
feat: add user profile photo upload
fix: resolve race condition in async data loading
docs: update installation guide for Windows
refactor: extract validation logic to separate module

# ✅ Good use of scope
feat(auth): implement password reset functionality
fix(mobile): correct touch event handling on iOS
perf(api): cache frequently accessed user data
```

### Poor Examples
```bash
# ❌ Vague descriptions
feat: add stuff
fix: bug fix
chore: updates

# ❌ Wrong tense or format
feat: adding new feature
fix: fixed the bug.
docs: Updated README

# ❌ Too verbose for description line
feat: add comprehensive user authentication system with JWT tokens and password hashing
```

## 📝 Body and Footer Guidelines

### Body Guidelines
- **Use when needed**: Add body for complex changes
- **Explain why**: Focus on motivation and impact
- **Wrap at 72 characters**: For better readability
- **Separate from description**: Use blank line

```bash
feat(api): add user subscription management

Implement comprehensive subscription system including:
- Monthly and annual billing cycles
- Automatic renewal with grace period
- Webhook integration for payment processing
- Admin panel for subscription management

The system supports multiple payment providers and
includes comprehensive error handling for failed
payments and edge cases.
```

### Footer Guidelines
- **Reference issues**: Link to GitHub issues or tickets
- **Breaking changes**: Clearly mark breaking changes
- **Co-authors**: Credit contributors

```bash
# Issue references
Closes #123
Fixes #456
Resolves #789
See #321

# Breaking changes
BREAKING CHANGE: remove support for Node.js 14

The minimum supported Node.js version is now 16.14.0 due to
dependencies requiring newer JavaScript features.

# Co-authors
Co-authored-by: John Doe <john@example.com>
Co-authored-by: Jane Smith <jane@example.com>
```

## 🚨 Breaking Changes

### Marking Breaking Changes
```bash
# In the type/scope
feat!: remove deprecated user API endpoints
fix(api)!: change response format for user data

# In the footer
feat(auth): add new authentication system

BREAKING CHANGE: replace session-based auth with JWT tokens

All existing authentication endpoints have been removed.
Clients must now use the new JWT-based authentication system.
Migration guide: https://docs.example.com/auth-migration
```

### Breaking Change Guidelines
- **Always mark breaking changes** with `!` or `BREAKING CHANGE:`
- **Explain the impact** in the footer
- **Provide migration guidance** when possible
- **Consider alternatives** before introducing breaking changes

## 🔧 Tool Integration

### Commitizen Setup
```bash
# Install commitizen
npm install -g commitizen
npm install --save-dev cz-conventional-changelog

# Configure package.json
{
  "config": {
    "commitizen": {
      "path": "./node_modules/cz-conventional-changelog"
    }
  }
}

# Use commitizen
npx cz
```

### Commitlint Configuration
```javascript
// commitlint.config.js
module.exports = {
  extends: ['@commitlint/config-conventional'],
  rules: {
    'type-enum': [
      2,
      'always',
      [
        'feat',
        'fix',
        'docs',
        'style',
        'refactor',
        'test',
        'chore',
        'perf',
        'ci',
        'build',
        'revert'
      ]
    ],
    'subject-case': [2, 'never', ['start-case', 'pascal-case']],
    'subject-max-length': [2, 'always', 72],
    'body-max-line-length': [2, 'always', 100]
  }
};
```

### Husky Pre-commit Hook
```bash
# Install husky
npm install --save-dev husky

# Enable git hooks
npx husky install

# Add commit message hook
npx husky add .husky/commit-msg 'npx --no-install commitlint --edit $1'
```

## 📊 Automated Versioning

### Semantic Release Configuration
```json
{
  "plugins": [
    "@semantic-release/commit-analyzer",
    "@semantic-release/release-notes-generator",
    "@semantic-release/changelog",
    "@semantic-release/npm",
    "@semantic-release/git",
    "@semantic-release/github"
  ],
  "release": {
    "branches": ["main"]
  }
}
```

### Version Bump Rules
- **Major**: Breaking changes (`!` or `BREAKING CHANGE:`)
- **Minor**: New features (`feat:`)
- **Patch**: Bug fixes (`fix:`)
- **No version bump**: Other changes (`docs:`, `style:`, etc.)

## 📈 Changelog Generation

### Automated Changelog Example
```markdown
# Changelog

## [2.1.0] - 2025-09-16

### Features
- **auth**: add OAuth2 integration (#123)
- **ui**: implement dark mode toggle (#456)
- add user profile photo upload (#789)

### Bug Fixes
- **mobile**: correct touch event handling on iOS (#321)
- resolve memory leak in data processing (#654)

### Performance Improvements
- **api**: cache frequently accessed user data (#987)

### BREAKING CHANGES
- **auth**: remove session-based authentication

  All existing authentication endpoints have been removed.
  See migration guide: https://docs.example.com/auth-migration
```

## 🎯 Best Practices

### Commit Frequency
```bash
# ✅ Good: Logical, atomic commits
feat: add user registration form
test: add validation tests for user registration
docs: update API documentation for registration

# ❌ Bad: Large, mixed commits
feat: add user system with registration, login, profile, and admin panel
```

### Commit Size
- **Make atomic commits**: One logical change per commit
- **Keep commits focused**: Single responsibility principle
- **Test between commits**: Each commit should leave the code in a working state

### Message Quality
```bash
# ✅ Excellent: Clear, specific, helpful
feat(auth): add password strength validation with configurable rules

# ✅ Good: Clear and specific
fix(ui): resolve button text overflow on mobile devices

# 🆗 Acceptable: Basic but clear
feat: add search functionality

# ❌ Poor: Vague and unhelpful
fix: bug fix
chore: update stuff
```

## 🚀 Advanced Patterns

### Multi-part Features
```bash
# When implementing a large feature across multiple commits
feat(auth): add authentication database schema
feat(auth): implement user registration API
feat(auth): add login endpoint with JWT tokens
test(auth): add comprehensive authentication tests
docs(auth): document new authentication system
```

### Dependency Updates
```bash
# Regular dependency updates
chore(deps): update lodash to version 4.17.21
chore(deps-dev): update jest to version 29.0.0

# Security updates
fix(deps): update vulnerable packages
chore(deps): bump axios from 0.21.1 to 0.24.0 for security fix
```

### Hotfixes
```bash
# Production hotfixes
fix: resolve critical payment processing error

Critical bug causing payment failures in production.
Applied immediate fix to prevent further issues.

Fixes #URGENT-123
```

## 📚 Team Guidelines

### Onboarding New Team Members
1. **Training**: Explain conventional commit benefits and structure
2. **Tools**: Set up commitizen and commitlint
3. **Practice**: Review commit history together
4. **Templates**: Provide commit message templates
5. **Review**: Include commit message quality in code reviews

### Code Review Integration
```markdown
# PR Review Checklist
- [ ] Commit messages follow conventional format
- [ ] Each commit represents a logical change
- [ ] Breaking changes are properly marked
- [ ] Commit descriptions are clear and helpful
- [ ] Related issues are referenced in footers
```

### Enforcement Levels
- **Soft**: Guidelines and recommendations
- **Medium**: Automated checks with warnings
- **Strict**: Build fails on non-compliant commits

## 🔍 Troubleshooting

### Common Issues

#### Commit Message Too Long
```bash
# ❌ Problem: Description too long
feat: add comprehensive user authentication system with JWT tokens, password hashing, email verification, and social login

# ✅ Solution: Use body for details
feat(auth): add comprehensive user authentication system

Implement full authentication system including:
- JWT token-based authentication
- Secure password hashing with bcrypt
- Email verification workflow
- Social login integration (Google, GitHub)
```

#### Wrong Commit Type
```bash
# ❌ Problem: Wrong type
docs: fix user registration validation bug

# ✅ Solution: Correct type
fix: resolve user registration validation bug
```

#### Missing Breaking Change Marker
```bash
# ❌ Problem: Breaking change not marked
feat(api): change user endpoint response format

# ✅ Solution: Mark breaking change
feat(api)!: change user endpoint response format

BREAKING CHANGE: user endpoint now returns different response structure
```

## 📞 Resources and Support

### Documentation
- [Conventional Commits Specification](https://conventionalcommits.org/)
- [Semantic Versioning](https://semver.org/)
- [Angular Commit Guidelines](https://github.com/angular/angular/blob/main/CONTRIBUTING.md#commit)

### Tools
- [Commitizen](https://commitizen.github.io/cz-cli/)
- [Commitlint](https://commitlint.js.org/)
- [Semantic Release](https://semantic-release.gitbook.io/)
- [Husky](https://typicode.github.io/husky/)

---

**Remember**: Consistent, clear commit messages are an investment in your project's maintainability and your team's productivity. Take the time to write thoughtful commits!