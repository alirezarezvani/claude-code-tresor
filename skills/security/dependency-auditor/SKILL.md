---
name: dependency-auditor
description: Check dependencies for known vulnerabilities using npm audit, pip-audit, etc. Use when package.json or requirements.txt changes, or before deployments. Alerts on vulnerable dependencies. Triggers on dependency file changes, deployment prep, security mentions.
allowed-tools: Bash, Read
---

# Dependency Auditor Skill

Automatic dependency vulnerability checking.

## When I Activate

- ✅ package.json modified
- ✅ requirements.txt changed
- ✅ Gemfile or pom.xml modified
- ✅ User mentions dependencies or vulnerabilities
- ✅ Before deployments
- ✅ yarn.lock or package-lock.json changes

## What I Check

### Dependency Vulnerabilities
- Known CVEs in packages
- Outdated dependencies with security fixes
- Malicious packages
- License compatibility issues
- Deprecated packages

### Package Managers Supported
- **Node.js**: npm, yarn, pnpm
- **Python**: pip, pipenv, poetry
- **Ruby**: bundler
- **Java**: Maven, Gradle
- **Go**: go modules
- **PHP**: composer

## Example Alerts

### NPM Vulnerability

```bash
# You run: npm install lodash

# I automatically audit:
🚨 HIGH: Prototype Pollution in lodash
📍 Package: lodash@4.17.15
📦 Vulnerable versions: < 4.17.21
🔧 Fix: npm update lodash
📖 CVE-2020-8203
   https://nvd.nist.gov/vuln/detail/CVE-2020-8203

Recommendation: Update to lodash@4.17.21 or higher
```

### Python Vulnerability

```bash
# You modify requirements.txt: django==2.2.0

# I alert:
🚨 CRITICAL: Multiple vulnerabilities in Django 2.2.0
📍 Package: Django@2.2.0
📦 Vulnerable versions: < 2.2.28
🔧 Fix: Update requirements.txt to Django==2.2.28
📖 CVEs: CVE-2021-33203, CVE-2021-33571

Affected: SQL injection, XSS vulnerabilities
Recommendation: Update immediately to Django@2.2.28+
```

### Multiple Vulnerabilities

```bash
# After npm install:
🚨 Dependency audit found 8 vulnerabilities:
  - 3 CRITICAL
  - 2 HIGH
  - 2 MEDIUM
  - 1 LOW

Critical issues:
  1. axios@0.21.0 - SSRF vulnerability
     Fix: npm install axios@latest

  2. ajv@6.10.0 - Prototype pollution
     Fix: npm install ajv@^8.0.0

  3. node-fetch@2.6.0 - Information disclosure
     Fix: npm install node-fetch@^2.6.7

Run 'npm audit fix' to automatically fix 6/8 issues
```

## Automatic Actions

### On Dependency Changes

```yaml
1. Detect package manager (npm, pip, etc.)
2. Run security audit command
3. Parse vulnerability results
4. Categorize by severity
5. Suggest fixes
6. Flag breaking changes
```

### Audit Commands

```bash
# Node.js
npm audit
npm audit --json  # Structured output

# Python
pip-audit
safety check

# Ruby
bundle audit

# Java (Maven)
mvn dependency-check:check
```

## Severity Classification

### CRITICAL 🚨
- Remote code execution
- SQL injection
- Authentication bypass
- Publicly exploitable

### HIGH ⚠️
- Cross-site scripting
- Denial of service
- Information disclosure
- Wide attack surface

### MEDIUM 📋
- Limited impact vulnerabilities
- Requires specific conditions
- Difficult to exploit

### LOW 💡
- Minor security improvements
- Best practice violations
- Minimal risk

## Fix Strategies

### Automatic Updates

```bash
# Safe automatic fixes
npm audit fix

# May include breaking changes
npm audit fix --force
```

### Manual Updates

```bash
# Check what will change
npm outdated

# Update specific package
npm update lodash

# Major version update
npm install lodash@latest
```

### Alternative Packages

```
Vulnerable: request@2.88.0 (deprecated)
Alternative: axios or node-fetch
Migration guide: [link]
```

## Integration with CI/CD

### Block Deployments

```yaml
# .github/workflows/security.yml
- name: Dependency audit
  run: |
    npm audit --audit-level=high
    # Fails if HIGH or CRITICAL found
```

### Scheduled Audits

```yaml
# Weekly dependency check
on:
  schedule:
    - cron: '0 0 * * 0'
jobs:
  audit:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - run: npm audit
```

## Sandboxing Compatibility

**Works without sandboxing:** ✅ Yes
**Works with sandboxing:** ⚙️ Needs npm/pip registry access

**Sandbox config:**
```json
{
  "network": {
    "allowedDomains": [
      "registry.npmjs.org",
      "pypi.org",
      "rubygems.org",
      "repo.maven.apache.org"
    ]
  }
}
```

## License Checking

I also check license compatibility:

```
⚠️ License issue: GPL-3.0 package in commercial project
📦 Package: some-gpl-package@1.0.0
📖 GPL-3.0 requires source code disclosure
🔧 Consider: Find MIT/Apache-2.0 alternative
```

## Best Practices

1. **Regular audits**: Run weekly or on every dependency change
2. **Update frequently**: Keep dependencies current
3. **Review breaking changes**: Test before major updates
4. **Pin versions**: Use exact versions in production
5. **Audit lock files**: Commit and audit lock files

## Related Tools

- **security-auditor skill**: Code vulnerability detection
- **@architect sub-agent**: Dependency strategy
- **/review command**: Pre-deployment security check
