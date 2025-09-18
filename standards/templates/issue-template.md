# GitHub Issue Templates 🎫

Comprehensive templates for creating clear, actionable GitHub issues that facilitate efficient project management and bug resolution.

## 🐛 Bug Report Template

```markdown
---
name: Bug Report
about: Create a report to help us improve
title: '[BUG] Brief description of the issue'
labels: 'bug, needs-triage'
assignees: ''
---

## 🐛 Bug Description

**Brief Summary**
A clear and concise description of what the bug is.

**Expected Behavior**
Describe what you expected to happen.

**Actual Behavior**
Describe what actually happened.

## 🔍 Steps to Reproduce

1. Go to '...'
2. Click on '...'
3. Scroll down to '...'
4. See error

**Minimal Reproduction Example**
```code
// Paste minimal code that reproduces the issue
```

## 🌐 Environment

**System Information:**
- OS: [e.g., macOS 13.0, Windows 11, Ubuntu 22.04]
- Browser: [e.g., Chrome 118, Firefox 119, Safari 17]
- Node.js Version: [e.g., 18.17.0]
- Package Version: [e.g., 2.1.0]

**Additional Environment Details:**
- Database: [e.g., PostgreSQL 15.0, MongoDB 6.0]
- Framework: [e.g., React 18.2.0, Next.js 13.5.0]
- Other relevant packages: [list with versions]

## 📱 Device Information (if applicable)

- Device: [e.g., iPhone 14, Samsung Galaxy S23]
- Mobile OS: [e.g., iOS 17.0, Android 13]
- Mobile Browser: [e.g., Safari Mobile, Chrome Mobile]
- Screen Resolution: [e.g., 1920x1080, 375x812]

## 📸 Screenshots/Videos

<!-- Add screenshots or videos to help explain the problem -->
![Screenshot](url-to-screenshot)

## 📋 Error Messages/Logs

```
Paste any error messages or relevant log output here
```

**Console Errors:**
```javascript
// Browser console errors
```

**Server Logs:**
```
// Server-side error logs
```

## 🔧 Debugging Information

**What I've tried:**
- [ ] Cleared browser cache
- [ ] Tried in incognito/private mode
- [ ] Restarted the application
- [ ] Checked for similar issues
- [ ] Updated to latest version

**Workaround (if any):**
Describe any temporary workaround you've found.

## 📊 Impact Assessment

**Severity:**
- [ ] Critical (blocks core functionality)
- [ ] High (major feature impacted)
- [ ] Medium (minor feature impacted)
- [ ] Low (cosmetic or edge case)

**Frequency:**
- [ ] Always (100% of the time)
- [ ] Often (>50% of the time)
- [ ] Sometimes (10-50% of the time)
- [ ] Rarely (<10% of the time)

**User Impact:**
- Number of users affected: [estimate]
- Business impact: [describe]

## 🧪 Additional Context

Add any other context about the problem here, such as:
- When did this start happening?
- Does it happen in all environments?
- Related issues or PRs
- Relevant documentation links
```

## ✨ Feature Request Template

```markdown
---
name: Feature Request
about: Suggest an idea for this project
title: '[FEATURE] Brief description of the feature'
labels: 'enhancement, needs-discussion'
assignees: ''
---

## 🎯 Feature Summary

**Is your feature request related to a problem? Please describe.**
A clear and concise description of what the problem is. Ex. I'm always frustrated when [...]

**Describe the solution you'd like**
A clear and concise description of what you want to happen.

## 💡 Detailed Description

**Use Case:**
Describe the specific use case this feature would address.

**User Story:**
As a [type of user], I want [goal] so that [benefit].

**Acceptance Criteria:**
- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

## 🎨 Proposed Implementation

**Technical Approach:**
Describe how you envision this feature being implemented.

**API Changes (if applicable):**
```javascript
// Example API usage
const result = await newFeature(params);
```

**UI/UX Considerations:**
Describe any user interface changes or considerations.

## 📋 Requirements

**Functional Requirements:**
1. The system shall...
2. The user must be able to...
3. The feature should...

**Non-Functional Requirements:**
- Performance: [e.g., response time <100ms]
- Security: [e.g., data encryption required]
- Scalability: [e.g., support 1000+ concurrent users]
- Accessibility: [e.g., WCAG 2.1 AA compliance]

## 🔄 Alternatives Considered

**Alternative 1:**
Description and why it was rejected.

**Alternative 2:**
Description and why it was rejected.

**Why this approach is preferred:**
Explanation of why the proposed solution is best.

## 📊 Impact Assessment

**Priority:**
- [ ] Critical (must have for next release)
- [ ] High (important for user experience)
- [ ] Medium (nice to have)
- [ ] Low (future consideration)

**Effort Estimate:**
- [ ] Small (< 1 day)
- [ ] Medium (1-3 days)
- [ ] Large (1-2 weeks)
- [ ] Extra Large (> 2 weeks)

**Dependencies:**
- Depends on feature X
- Requires API changes
- Needs database migration

## 🎯 Success Metrics

How will we measure the success of this feature?
- [ ] User adoption rate
- [ ] Performance metrics
- [ ] User satisfaction surveys
- [ ] Error rate reduction

## 📖 Additional Context

Add any other context, mockups, or screenshots about the feature request here.

**Related Issues:**
- Related to #123
- Blocks #456
- Enhances #789

**Documentation Needs:**
- [ ] API documentation
- [ ] User guide updates
- [ ] Migration guide
- [ ] Examples and tutorials
```

## 📋 Task/Epic Template

```markdown
---
name: Task/Epic
about: Track work items and project milestones
title: '[TASK] Brief description of the task'
labels: 'task'
assignees: ''
---

## 🎯 Objective

**Goal:**
Clear statement of what needs to be accomplished.

**Background:**
Context and reasoning behind this task.

## 📋 Scope

**In Scope:**
- Item 1
- Item 2
- Item 3

**Out of Scope:**
- Item A
- Item B
- Item C

## ✅ Subtasks

### Phase 1: Planning
- [ ] Requirements gathering
- [ ] Technical design
- [ ] Resource allocation
- [ ] Timeline estimation

### Phase 2: Implementation
- [ ] Core functionality
- [ ] Testing implementation
- [ ] Documentation
- [ ] Code review

### Phase 3: Deployment
- [ ] Staging deployment
- [ ] User acceptance testing
- [ ] Production deployment
- [ ] Monitoring setup

## 📊 Definition of Done

- [ ] All subtasks completed
- [ ] Code reviewed and approved
- [ ] Tests passing (>90% coverage)
- [ ] Documentation updated
- [ ] Performance benchmarks met
- [ ] Security review completed
- [ ] Stakeholder approval received

## 🗓️ Timeline

**Start Date:** [YYYY-MM-DD]
**Target Completion:** [YYYY-MM-DD]

**Milestones:**
- Milestone 1: [Date] - Description
- Milestone 2: [Date] - Description
- Milestone 3: [Date] - Description

## 👥 Stakeholders

**Owner:** @username
**Contributors:** @user1, @user2
**Reviewers:** @reviewer1, @reviewer2
**Stakeholders:** @stakeholder1, @stakeholder2

## 📈 Success Criteria

- [ ] Criteria 1
- [ ] Criteria 2
- [ ] Criteria 3

## 🔗 Related Work

- Depends on #123
- Blocks #456
- Related to #789
```

## 💬 Discussion Template

```markdown
---
name: Discussion
about: Start a discussion about ideas, questions, or proposals
title: '[DISCUSSION] Topic for discussion'
labels: 'discussion'
assignees: ''
---

## 🗣️ Discussion Topic

**Question/Proposal:**
Clear statement of what you want to discuss.

**Context:**
Background information that helps frame the discussion.

## 🎯 Goals

What do you hope to achieve from this discussion?
- [ ] Goal 1
- [ ] Goal 2
- [ ] Goal 3

## 💭 Initial Thoughts

Share your initial thoughts or proposals on the topic.

## 🤔 Questions for Discussion

1. Question 1?
2. Question 2?
3. Question 3?

## 📚 References

- [Link 1](url) - Description
- [Link 2](url) - Description
- Related issues: #123, #456

## 👥 Who Should Participate

Tag relevant team members or stakeholders who should participate in this discussion.
```

## 🏷️ Issue Labels Guide

### Type Labels
- `bug` - Something isn't working
- `enhancement` - New feature or request
- `task` - Work item or epic
- `discussion` - Ideas, questions, proposals
- `documentation` - Improvements to documentation
- `question` - Further information is requested

### Priority Labels
- `priority:critical` - Critical issue requiring immediate attention
- `priority:high` - High priority, should be addressed soon
- `priority:medium` - Medium priority, normal timeline
- `priority:low` - Low priority, nice to have

### Status Labels
- `needs-triage` - Needs initial review and categorization
- `needs-investigation` - Requires further investigation
- `needs-discussion` - Requires team discussion
- `in-progress` - Currently being worked on
- `blocked` - Cannot proceed due to dependency
- `ready-for-review` - Ready for code review
- `needs-testing` - Requires testing

### Component Labels
- `frontend` - Frontend/UI related
- `backend` - Backend/API related
- `database` - Database related
- `devops` - Infrastructure/deployment related
- `security` - Security related
- `performance` - Performance related

### Size Labels
- `size:xs` - Extra small effort (<2 hours)
- `size:s` - Small effort (<1 day)
- `size:m` - Medium effort (1-3 days)
- `size:l` - Large effort (1-2 weeks)
- `size:xl` - Extra large effort (>2 weeks)

## 🎯 Best Practices

### Creating Issues
1. **Use templates**: Choose the appropriate template
2. **Be specific**: Provide clear, detailed descriptions
3. **Include context**: Add relevant background information
4. **Label appropriately**: Use consistent labeling
5. **Assign correctly**: Tag relevant team members

### Managing Issues
1. **Triage regularly**: Review and categorize new issues
2. **Update status**: Keep issue status current
3. **Close when done**: Close completed issues promptly
4. **Link related work**: Reference related issues and PRs
5. **Document decisions**: Record important discussions

### Common Pitfalls
- ❌ Vague or unclear descriptions
- ❌ Missing reproduction steps for bugs
- ❌ No acceptance criteria for features
- ❌ Incorrect or missing labels
- ❌ Not updating issue status
- ❌ Duplicate issues without cross-referencing

This comprehensive issue template system ensures clear communication and efficient project management across all types of GitHub issues.