# /review - Comprehensive Code Review Command

> **Author**: Alireza Rezvani
> **Version**: 1.0.0
> **Created**: September 16, 2025

Perform multi-perspective automated code reviews using specialized agents with explicit Task tool invocations for quality, security, architecture, performance, and maintainability analysis.

## Overview

The `/review` command orchestrates multiple specialized review agents to provide comprehensive code analysis. It focuses particularly on configuration changes that could cause outages, following a "prove it's safe" mentality for configuration modifications.

## Key Features

- **Multi-Agent Review**: Parallel execution of specialized review agents
- **Configuration Safety**: Heightened scrutiny for configuration changes
- **Production Focus**: Real-world outage pattern detection
- **Consolidated Reporting**: Unified action plan from multiple perspectives
- **Flexible Scoping**: Review staged, unstaged, commit, PR, or specific files

## Usage

### Basic Usage

```bash
# Review staged changes
/review --scope staged

# Review specific files
/review src/config/database.py src/api/routes.py

# Review with specific checks
/review --checks security,performance,style

# Generate detailed report
/review --format detailed --output review-report.md
```

### Advanced Usage

```bash
# Review pull request with full analysis
/review --scope pr --checks all --format json

# Focus on configuration safety
/review --scope unstaged --checks security,config-safety --severity critical

# Review specific commit
/review --scope commit:abc123 --format markdown
```

## Parameters

### Required
- None (defaults to staged changes)

### Optional
- `--scope`: What to review (`staged`, `unstaged`, `commit`, `pr`, `branch`, `file`, `directory`)
- `--checks`: Types of analysis (`security`, `performance`, `style`, `maintainability`, `testing`, `documentation`)
- `--format`: Output format (`summary`, `detailed`, `json`, `markdown`)
- `--output`: Save report to file
- `--severity`: Filter by severity level (`all`, `critical`, `high`, `medium`, `low`)

## Review Process

The `/review` command follows this systematic approach:

### 1. Code Quality Review
- Uses Task tool with subagent_type="code-reviewer"
- Focuses on clean code principles, SOLID, DRY, naming conventions
- Detects code smells and maintainability issues

### 2. Security Audit
- Uses Task tool with subagent_type="security-auditor"
- Performs OWASP Top 10 analysis
- Validates authentication, authorization, input validation
- Checks for injection risks, XSS, CSRF protection

### 3. Architecture Review
- Uses Task tool with subagent_type="architect-reviewer"
- Evaluates service boundaries, coupling, cohesion
- Assesses scalability and design patterns
- Reviews long-term maintainability

### 4. Performance Analysis
- Uses Task tool with subagent_type="performance-engineer"
- Identifies bottlenecks and resource usage
- Analyzes response times and optimization opportunities
- Reviews database queries and caching strategies

### 5. Configuration Safety (CRITICAL FOCUS)
- Special emphasis on configuration file changes
- Magic number detection with required justification
- Production impact assessment for all config changes

## Configuration Change Review

### Magic Number Detection
For ANY numeric value change in configuration files:
- **ALWAYS QUESTION**: "Why this specific value? What's the justification?"
- **REQUIRE EVIDENCE**: Has this been tested under production-like load?
- **CHECK BOUNDS**: Is this within recommended ranges for your system?
- **ASSESS IMPACT**: What happens if this limit is reached?

### Common Risky Configuration Patterns

#### Connection Pool Settings
```yaml
# DANGER ZONES - Always flag these:
- pool_size: 50 → 25  # Can cause connection starvation
- pool_size: 10 → 100 # Can overload database
- timeout: 5000 → 1000 # Can cause false failures
- idle_timeout: 600 → 60 # Affects resource usage
```

**Key Questions:**
- "How many concurrent users does this support?"
- "What happens when all connections are in use?"
- "Has this been tested with your actual workload?"
- "What's your database's max connection limit?"

#### Timeout Configurations
```yaml
# HIGH RISK - These cause cascading failures:
- request_timeout: 30000 → 60000  # Can cause thread exhaustion
- connect_timeout: 5000 → 1000    # Can cause false failures
- read_timeout: 10000 → 5000      # Affects user experience
```

**Key Questions:**
- "What's the 95th percentile response time in production?"
- "How will this interact with upstream/downstream timeouts?"
- "What happens when this timeout is hit?"

#### Memory and Resource Limits
```yaml
# CRITICAL - Can cause OOM or waste resources:
- heap_size: "2g" → "4g"
- buffer_size: 8192 → 16384
- cache_limit: 1000 → 5000
- thread_pool: 10 → 50
```

**Key Questions:**
- "What's the current memory usage pattern?"
- "Have you profiled this under load?"
- "What's the impact on garbage collection?"

## Report Structure

### Consolidated Report Format
```markdown
# Code Review Report

## Critical Issues (Must fix before deployment)
- Configuration changes that could cause outages
- Security vulnerabilities
- Data loss risks
- Breaking changes

## Recommendations (Should fix)
- Performance degradation risks
- Maintainability issues
- Missing error handling

## Suggestions (Nice to have)
- Code style improvements
- Optimization opportunities
- Additional test coverage

## Positive Feedback (What's done well)
- Good practices to maintain and replicate
```

## Impact Analysis Requirements

For EVERY configuration change, require answers to:
1. **Load Testing**: "Has this been tested with production-level load?"
2. **Rollback Plan**: "How quickly can this be reverted if issues occur?"
3. **Monitoring**: "What metrics will indicate if this change causes problems?"
4. **Dependencies**: "How does this interact with other system limits?"
5. **Historical Context**: "Have similar changes caused issues before?"

## Real-World Outage Patterns

The review process checks for these common 2024 production incidents:

1. **Connection Pool Exhaustion**: Pool size too small for load
2. **Timeout Cascades**: Mismatched timeouts causing failures
3. **Memory Pressure**: Limits set without considering actual usage
4. **Thread Starvation**: Worker/connection ratios misconfigured
5. **Cache Stampedes**: TTL and size limits causing thundering herds

## Examples

### Example 1: Database Configuration Review

**Input:**
```yaml
# database.yml changes
pool_size: 10 → 20
timeout: 5000 → 3000
```

**Review Output:**
```markdown
🚨 CRITICAL: Database Configuration Changes

**Pool Size Increase (10 → 20)**
- ✅ POSITIVE: Addresses potential connection starvation
- ❓ QUESTION: What's your database's max_connections limit?
- ❓ QUESTION: Have you tested this under peak load?
- 💡 RECOMMENDATION: Monitor connection usage metrics

**Timeout Decrease (5000 → 3000)**
- 🚨 HIGH RISK: Reducing timeout can cause false failures
- ❓ QUESTION: What's your 95th percentile query time?
- ❓ QUESTION: How will this affect long-running operations?
- 🛑 BLOCK: Need evidence this won't cause timeouts
```

### Example 2: Security Review

**Input:**
```python
# user_input.py
user_data = request.get_json()
query = f"SELECT * FROM users WHERE email = '{user_data['email']}'"
```

**Review Output:**
```markdown
🚨 CRITICAL: SQL Injection Vulnerability

**Location**: user_input.py:45
**Issue**: Direct string interpolation in SQL query
**Risk**: Database compromise, data breach
**Fix**: Use parameterized queries

```python
# SECURE VERSION
query = "SELECT * FROM users WHERE email = %s"
cursor.execute(query, (user_data['email'],))
```
```

### Example 3: Performance Review

**Input:**
```python
# api.py
def get_user_posts(user_id):
    user = User.objects.get(id=user_id)
    posts = []
    for post_id in user.post_ids:
        post = Post.objects.get(id=post_id)  # N+1 query
        posts.append(post)
    return posts
```

**Review Output:**
```markdown
⚠️ PERFORMANCE: N+1 Query Problem

**Location**: api.py:23-27
**Issue**: Individual queries for each post (N+1 pattern)
**Impact**: Database overload with large datasets
**Fix**: Use bulk query with prefetch

```python
# OPTIMIZED VERSION
def get_user_posts(user_id):
    return Post.objects.filter(
        id__in=User.objects.get(id=user_id).post_ids
    ).select_related('author')
```
```

## Integration with Other Commands

The `/review` command works seamlessly with other utilities:

```bash
# Review after scaffolding
/scaffold express-api user-service
/review src/ --checks security,performance

# Review before testing
/review --scope staged
/test-gen --coverage 90

# Review with security focus
/review --checks security
/security-scan --include-dependencies
```

## Configuration

### Default Settings
```json
{
  "default_scope": "staged",
  "default_checks": ["security", "performance", "style", "maintainability"],
  "default_format": "summary",
  "config_safety_mode": true,
  "severity_threshold": "medium"
}
```

### Custom Configuration
```json
{
  "review": {
    "agents": {
      "code_reviewer": "subagent_type=code-reviewer",
      "security_auditor": "subagent_type=security-auditor",
      "architect": "subagent_type=architect-reviewer",
      "performance": "subagent_type=performance-engineer"
    },
    "config_patterns": {
      "risky_extensions": [".yml", ".yaml", ".json", ".properties", ".env"],
      "magic_number_threshold": 0,
      "require_justification": true
    }
  }
}
```

## Best Practices

### For Reviewers
1. **Configuration Skepticism**: Default position is "risky until proven safe"
2. **Evidence-Based**: Require data, not assumptions for config changes
3. **Holistic Analysis**: Consider system-wide impacts
4. **Documentation**: Record all decisions and rationale

### For Developers
1. **Small Changes**: Make incremental, reviewable changes
2. **Test Evidence**: Provide load testing results for config changes
3. **Rollback Plans**: Always have a quick revert strategy
4. **Monitoring**: Set up alerts for new configuration limits

## Troubleshooting

### Common Issues

**Review agents not found**
- Ensure all required agents are installed
- Check agent configuration paths

**Configuration warnings false positives**
- Adjust magic number threshold in config
- Add exceptions for known safe patterns

**Performance analysis timeout**
- Reduce scope of review
- Use `--checks` to focus on specific areas

## Contributing

When extending the `/review` command:

1. **Add New Check Types**: Extend `check_types` array
2. **New Agent Integration**: Use Task tool with appropriate subagent_type
3. **Pattern Detection**: Add configuration risk patterns
4. **Report Templates**: Maintain consistent output format

## Dependencies

- Task tool for agent orchestration
- Git for change detection
- AST parsing for code analysis
- Configuration file parsers (YAML, JSON, etc.)

---

**Remember**: Configuration changes that "just change numbers" are often the most dangerous. A single wrong value can bring down an entire system. The `/review` command is your guardian against these outages.