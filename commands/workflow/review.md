---
allowed-tools: Task, Bash(git status:*), Bash(git diff:*), Bash(git log:*), Read, Grep, Glob
argument-hint: [--scope staged|unstaged|pr|commit] [--checks security,performance,style] [--format detailed|json] [--severity critical|high|medium] [--output filename]
description: Comprehensive code review with security, performance, and configuration safety analysis using specialized agents
model: inherit
---

# Comprehensive Code Review

You are coordinating a comprehensive code review using specialized agents with explicit focus on configuration safety and production impact.

## Integration with Skills

This command builds on automatic skill detections:

**Before This Command Runs:**
- code-reviewer skill has flagged code quality issues in real-time
- security-auditor, secret-scanner, dependency-auditor skills have detected security concerns
- test-generator skill has identified untested code

**This Command Coordinates:**
- Aggregates all skill findings into one report
- Invokes sub-agents for deep analysis beyond skill capabilities
- Prioritizes issues by severity (CRITICAL → LOW)
- Provides comprehensive recommendations

**Workflow:** Skills detect → This command aggregates + invokes experts → Comprehensive report

## Review Process

1. **Context Analysis**: First understand what code is being reviewed
2. **Multi-Agent Coordination**: Use Task tool to delegate to specialized agents:
   - `@code-reviewer` for general quality and best practices
   - `@security-auditor` for security vulnerabilities
   - `@architect` for architectural concerns
   - `@performance-tuner` for performance optimization

3. **Configuration Safety Priority**: Pay special attention to:
   - Database connection strings and timeouts
   - API endpoints and rate limits
   - Cache configurations and TTL values
   - Feature flags and environment variables
   - Deployment scripts and infrastructure changes

## Arguments Processing

- `--scope`: Determines what to review (staged, unstaged, pr, commit:hash, file:path)
- `--checks`: Focus areas (security, performance, style, maintainability, configuration)
- `--format`: Output format (detailed, json, markdown)
- `--severity`: Filter by severity level (critical, high, medium, low)
- `--output`: Save report to specified file

## Review Focus Areas

### Configuration Changes (CRITICAL)
- Verify environment-specific settings won't cause outages
- Check for hardcoded values that should be configurable
- Validate timeout and retry configurations
- Review database migration safety

### Security Analysis
- Authentication and authorization checks
- Input validation and sanitization
- Secret management and exposure prevention
- Dependency vulnerability assessment

### Performance Impact
- Query optimization and N+1 problems
- Caching strategy effectiveness
- Resource utilization patterns
- Scalability considerations

### Code Quality
- Maintainability and readability
- Test coverage and quality
- Documentation completeness
- Error handling robustness

## Output Format

Provide a consolidated report with:
1. **Executive Summary**: Key findings and recommendations
2. **Critical Issues**: Must-fix items (especially configuration risks)
3. **Security Findings**: Vulnerability assessment
4. **Performance Recommendations**: Optimization opportunities
5. **Code Quality Observations**: Style and maintainability notes
6. **Action Plan**: Prioritized steps for remediation

Focus on actionable feedback with specific examples and fixes.