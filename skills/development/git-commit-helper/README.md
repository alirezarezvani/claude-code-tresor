# Git Commit Helper Skill

> Generate conventional commit messages automatically from git diff

## Quick Example

```bash
# You make changes and stage them
git add auth.service.ts login.component.tsx

# Run git commit
git commit

# Skill auto-suggests:
feat(auth): add JWT-based user authentication

- Implement login/logout functionality
- Add token management service
- Include auth guards for protected routes

Closes #42
```

## What It Does

Analyzes your staged changes and generates:
- ✅ Conventional commit format
- ✅ Appropriate type (feat, fix, docs, etc.)
- ✅ Meaningful scope
- ✅ Clear subject line
- ✅ Detailed body (if needed)
- ✅ Issue references

## Commit Types

- `feat`: New features
- `fix`: Bug fixes
- `docs`: Documentation
- `refactor`: Code improvements
- `perf`: Performance
- `test`: Testing
- `chore`: Maintenance

## Best Practices

**Good commits:**
```
feat(auth): add user authentication
fix(api): resolve memory leak in connection pool
docs: update API documentation with examples
```

**Bad commits:**
```
fix stuff                    # Too vague
added user authentication    # Past tense
Update docs.                 # Wrong format
```

## Integration

Works with:
- **code-reviewer skill**: Review before commit
- **/review command**: Comprehensive pre-commit check
- **Pre-commit hooks**: Automated message generation

See [SKILL.md](SKILL.md) for full documentation.
