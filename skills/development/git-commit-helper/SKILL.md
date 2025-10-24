---
name: git-commit-helper
description: Generate conventional commit messages automatically. Use when user runs git commit, stages changes, or asks for commit message help. Analyzes git diff to create clear, descriptive conventional commit messages. Triggers on git commit, staged changes, commit message requests.
allowed-tools: Bash, Read
---

# Git Commit Helper Skill

Generate conventional commit messages from your git diff.

## When I Activate

- ✅ `git commit` without message
- ✅ User asks "what should my commit message be?"
- ✅ Staged changes exist
- ✅ User mentions commit or conventional commits
- ✅ Before creating commits

## What I Generate

### Conventional Commit Format

```
<type>(<scope>): <subject>

<body>

<footer>
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `style`: Code style (formatting, no logic change)
- `refactor`: Code refactoring
- `perf`: Performance improvements
- `test`: Test additions or fixes
- `build`: Build system changes
- `ci`: CI/CD changes
- `chore`: Maintenance tasks

## Examples

### Feature Addition

```bash
# You staged:
git add auth.service.ts login.component.tsx

# I analyze diff and suggest:
feat(auth): add JWT-based user authentication

- Implement login/logout functionality
- Add token management service
- Include auth guards for protected routes
- Add unit tests for auth service

Closes #42
```

### Bug Fix

```bash
# You staged:
git add UserList.tsx

# I suggest:
fix(components): resolve memory leak in UserList

Fixed subscription not being cleaned up in useEffect,
causing memory leak when component unmounts.

Closes #156
```

### Breaking Change

```bash
# You staged:
git add api/users.ts

# I suggest:
feat(api): update user API response format

Changed response structure to include metadata
for better pagination and filtering support.

BREAKING CHANGE: User API now returns { data, metadata }
instead of direct array. Update client code accordingly.
```

### Documentation Update

```bash
# You staged:
git add README.md docs/api.md

# I suggest:
docs: update API documentation with authentication examples

- Add authentication flow diagrams
- Include cURL examples for protected endpoints
- Document error responses
```

## Analysis Process

### Step 1: Check Staged Changes
```bash
git diff --staged --name-only
git diff --staged
```

### Step 2: Categorize Changes
- New files → feat
- Modified files → fix, refactor, or feat
- Deleted files → chore or refactor
- Test files → test
- Documentation → docs

### Step 3: Analyze Content
- What was changed?
- Why was it changed?
- What's the impact?
- Are there breaking changes?

### Step 4: Generate Message

**Subject line:**
- Max 50 characters
- Imperative mood ("add" not "added")
- No period at end
- Lowercase after type

**Body:**
- Explain WHAT and WHY, not HOW
- Wrap at 72 characters
- Bullet points for multiple changes

**Footer:**
- Breaking changes: `BREAKING CHANGE: description`
- Issue references: `Closes #123`, `Fixes #456`

## Message Components

### Type Selection

```yaml
feat: New functionality
  - New components, features, capabilities

fix: Bug fixes
  - Resolving issues, fixing bugs

refactor: Code improvements
  - No functional changes, better code structure

perf: Performance
  - Speed improvements, optimization

docs: Documentation
  - README, comments, guides

test: Testing
  - Adding or fixing tests

style: Formatting
  - Code style, linting, formatting

chore: Maintenance
  - Dependencies, build config, tooling
```

### Scope Selection

Common scopes:
- Component name: `feat(UserCard): ...`
- Module: `fix(auth): ...`
- Package: `chore(api): ...`
- Area: `docs(readme): ...`

### Subject Guidelines

✅ Good:
- `add user authentication`
- `fix memory leak in component`
- `update API documentation`

❌ Bad:
- `added user authentication` (past tense)
- `fixes bug` (too vague)
- `Update API docs.` (period at end)

## Advanced Examples

### Multiple Changes

```bash
# Multiple files in auth feature
feat(auth): implement complete authentication system

- Add JWT token generation and validation
- Implement password hashing with bcrypt
- Create login/logout API endpoints
- Add auth middleware for protected routes
- Include refresh token functionality

Closes #42, #43, #44
```

### Refactoring

```bash
# Code restructuring
refactor(api): extract database logic into repository pattern

Moved database queries from controllers to repository classes
for better separation of concerns and testability.

No functional changes or API modifications.
```

### Performance Improvement

```bash
# Optimization
perf(queries): optimize user data fetching

- Implement query batching to eliminate N+1 queries
- Add database indices on frequently queried columns
- Cache user profile data with 5-minute TTL

Performance improvement: 80ms → 12ms average response time
```

## Git Integration

### Pre-commit Hook

I work great with pre-commit hooks:

```bash
#!/bin/sh
# .git/hooks/prepare-commit-msg

# If no commit message provided, trigger skill
if [ -z "$2" ]; then
  # Skill suggests message based on staged changes
  echo "# Suggested commit message (edit as needed)" > "$1"
fi
```

### Amending Commits

```bash
# Poor initial message
git commit -m "fix stuff"

# Amend with better message
# I suggest improved message based on changes
git commit --amend
```

## Sandboxing Compatibility

**Works without sandboxing:** ✅ Yes
**Works with sandboxing:** ✅ Yes

**May need network access for:**
- Fetching issue details from GitHub API
- Checking if issue numbers are valid

**Sandbox config (optional):**
```json
{
  "network": {
    "allowedDomains": [
      "api.github.com"
    ]
  }
}
```

## Customization

### Custom Commit Types

Edit SKILL.md to add company-specific types:

```yaml
deploy: Deployment
migrate: Database migrations
hotfix: Production hotfixes
```

### Custom Scopes

Train the skill to recognize your project structure:

```yaml
Common scopes: auth, api, ui, database, admin, mobile
```

### Message Templates

Customize message format for your team:

```bash
# Standard format
feat(scope): subject

# Your custom format
[JIRA-123] feat(scope): subject
```

## Tips for Best Messages

1. **Be specific**: "fix login button" not "fix bug"
2. **Use imperative mood**: "add" not "added" or "adds"
3. **Include context**: Why this change was needed
4. **Reference issues**: Always include issue numbers
5. **Breaking changes**: Always flag in footer

## Common Patterns

### Frontend Changes
```
feat(ui): add responsive navigation menu
fix(components): resolve prop validation warning
style(css): update button hover effects
```

### Backend Changes
```
feat(api): add user pagination endpoint
fix(database): resolve connection pool exhaustion
perf(queries): add database indices for user lookups
```

### Infrastructure Changes
```
ci: add automated deployment pipeline
build: update dependencies to latest versions
chore(docker): optimize container image size
```

## Related Tools

- **code-reviewer skill**: Reviews code before commit
- **@docs-writer sub-agent**: Generates changelog from commits
- **/review command**: Pre-commit code review

## Integration

### With code-reviewer

```bash
# 1. Write code
# 2. code-reviewer flags issues
# 3. Fix issues
# 4. Stage changes
# 5. I generate commit message
git commit  # Uses my suggested message
```

### With /review Command

```bash
# 1. Make changes
/review --scope staged  # Review before commit
# 2. Address findings
# 3. Stage final changes
# 4. I generate commit message
git commit
```

## Learn More

- [Conventional Commits](https://www.conventionalcommits.org/)
- [Git Best Practices](../../standards/git-workflows/)
- [Customization Guide](../../TEMPLATES.md)
