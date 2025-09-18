# Pull Request Template 📋

A comprehensive template for creating clear, reviewable pull requests that facilitate efficient code review and maintain high code quality standards.

## 📝 PR Description Template

```markdown
## 🎯 Summary

Brief description of what this PR accomplishes and why it's needed.

## 🔄 Changes Made

### Added
- [ ] New feature/functionality description
- [ ] New tests for feature coverage
- [ ] Documentation updates

### Modified
- [ ] Existing feature improvements
- [ ] Performance optimizations
- [ ] Refactoring changes

### Fixed
- [ ] Bug fix description
- [ ] Security vulnerability resolution
- [ ] Issue resolution (closes #123)

### Removed
- [ ] Deprecated code removal
- [ ] Unused dependencies
- [ ] Legacy functionality

## 🧪 Testing

### Test Coverage
- [ ] Unit tests added/updated
- [ ] Integration tests added/updated
- [ ] E2E tests added/updated
- [ ] Manual testing completed

### Test Results
```bash
# Include test command output
npm test
# or
pytest --coverage
```

### Test Cases Covered
- [ ] Happy path scenarios
- [ ] Edge cases and error conditions
- [ ] Performance under load
- [ ] Security considerations

## 📸 Screenshots/Demo

<!-- For UI changes, include before/after screenshots -->
<!-- For API changes, include request/response examples -->

### Before
![Before](image-url)

### After
![After](image-url)

## 🔍 Code Review Checklist

### Security
- [ ] No hardcoded secrets or credentials
- [ ] Input validation implemented
- [ ] Authorization checks in place
- [ ] SQL injection prevention
- [ ] XSS protection implemented

### Performance
- [ ] No N+1 queries introduced
- [ ] Efficient algorithms used
- [ ] Caching strategy considered
- [ ] Database indexes optimized
- [ ] Memory usage optimized

### Code Quality
- [ ] Follows project coding standards
- [ ] Functions are single-responsibility
- [ ] Code is DRY (Don't Repeat Yourself)
- [ ] Error handling is comprehensive
- [ ] Logging is appropriate

### Documentation
- [ ] Code comments for complex logic
- [ ] API documentation updated
- [ ] README updated if needed
- [ ] Migration guides provided

## 🚀 Deployment Notes

### Environment Changes
- [ ] Environment variables added/modified
- [ ] Database migrations required
- [ ] Configuration changes needed
- [ ] Infrastructure updates required

### Rollback Plan
Describe how to rollback these changes if issues arise:
1. Step 1
2. Step 2
3. Step 3

### Monitoring
- [ ] Metrics/alerts configured
- [ ] Error tracking updated
- [ ] Performance monitoring in place

## 🔗 Related Issues

Closes #[issue-number]
Related to #[issue-number]
Depends on #[pr-number]

## 🎭 Type of Change

- [ ] 🐛 Bug fix (non-breaking change fixing an issue)
- [ ] ✨ New feature (non-breaking change adding functionality)
- [ ] 💥 Breaking change (fix or feature causing existing functionality to break)
- [ ] 📚 Documentation update
- [ ] 🔧 Configuration change
- [ ] 🎨 Code style/formatting change
- [ ] ♻️ Refactoring (no functional changes)
- [ ] ⚡ Performance improvement
- [ ] 🧪 Test updates

## 📋 Definition of Done

- [ ] Code compiles without warnings
- [ ] All tests pass
- [ ] Code coverage maintains/improves threshold
- [ ] Documentation is updated
- [ ] Security review completed
- [ ] Performance impact assessed
- [ ] Accessibility standards met (if applicable)
- [ ] Cross-browser testing completed (if applicable)

## 🤝 Reviewer Guidelines

### What to Focus On
1. **Correctness**: Does the code do what it's supposed to do?
2. **Security**: Are there any security vulnerabilities?
3. **Performance**: Will this impact system performance?
4. **Maintainability**: Is the code readable and maintainable?
5. **Testing**: Is the testing strategy comprehensive?

### Review Process
1. Check out the branch locally
2. Run tests locally
3. Review code for the focus areas above
4. Test the functionality manually
5. Provide constructive feedback

## 🚨 Known Issues/Limitations

List any known issues or limitations that will be addressed in future PRs:
- Issue 1: Description and plan to address
- Issue 2: Description and plan to address

## 📖 Additional Context

Add any additional context about the PR here. Include:
- Design decisions and rationale
- Alternative approaches considered
- Future improvements planned
- Dependencies or prerequisites
```

## 🏷️ PR Labels Guide

Use appropriate labels to categorize your PR:

### Type Labels
- `feature` - New functionality
- `bugfix` - Bug fixes
- `hotfix` - Critical fixes for production
- `refactor` - Code refactoring
- `docs` - Documentation changes
- `test` - Test-related changes
- `chore` - Maintenance tasks

### Priority Labels
- `priority:critical` - Must be reviewed immediately
- `priority:high` - Should be reviewed within 24 hours
- `priority:medium` - Standard review timeline
- `priority:low` - Can be reviewed when convenient

### Size Labels
- `size:xs` - <10 lines changed
- `size:s` - 10-99 lines changed
- `size:m` - 100-499 lines changed
- `size:l` - 500-999 lines changed
- `size:xl` - 1000+ lines changed

### Review Labels
- `needs-review` - Ready for review
- `needs-changes` - Requires changes before merge
- `approved` - Approved by reviewers
- `work-in-progress` - Not ready for review

## 🔄 PR Lifecycle

### 1. Draft Phase
- [ ] Create draft PR early for visibility
- [ ] Implement core functionality
- [ ] Add basic tests
- [ ] Update documentation

### 2. Review Phase
- [ ] Mark PR as ready for review
- [ ] Request specific reviewers
- [ ] Address feedback promptly
- [ ] Update tests based on feedback

### 3. Approval Phase
- [ ] All reviewers approve
- [ ] CI/CD checks pass
- [ ] Conflicts resolved
- [ ] Final validation complete

### 4. Merge Phase
- [ ] Squash commits if needed
- [ ] Update commit message
- [ ] Merge to target branch
- [ ] Delete feature branch

## 🎯 Best Practices

### Writing Good PRs
1. **Keep it small**: Smaller PRs are easier to review
2. **Single responsibility**: One logical change per PR
3. **Clear title**: Descriptive and concise
4. **Detailed description**: Explain the why, not just the what
5. **Test thoroughly**: Include comprehensive tests

### Reviewing PRs
1. **Be constructive**: Provide helpful, actionable feedback
2. **Ask questions**: If something is unclear, ask for clarification
3. **Suggest improvements**: Offer specific recommendations
4. **Approve quickly**: Don't block unnecessarily
5. **Follow up**: Ensure feedback is addressed

### Common Pitfalls to Avoid
- ❌ Massive PRs that are hard to review
- ❌ Unclear or missing descriptions
- ❌ No tests or inadequate test coverage
- ❌ Breaking changes without proper communication
- ❌ Ignoring CI/CD failures
- ❌ Not updating documentation

This template ensures comprehensive, reviewable pull requests that maintain code quality and facilitate effective collaboration.