# Dependency Auditor Skill

> Automatic vulnerability checking for project dependencies

## Quick Example

```bash
# You add a dependency
npm install lodash@4.17.15

# Skill auto-audits:
🚨 HIGH: Prototype Pollution in lodash@4.17.15
🔧 Fix: npm update lodash
📖 CVE-2020-8203
```

## Supported Package Managers

- **Node.js**: npm, yarn, pnpm
- **Python**: pip
- **Ruby**: bundler
- **Java**: Maven, Gradle
- **Go**: go modules

## What It Checks

- ✅ Known CVEs
- ✅ Security advisories
- ✅ Outdated packages
- ✅ License issues
- ✅ Deprecated packages

## CI/CD Integration

Block deployments with vulnerabilities:
```yaml
# GitHub Actions
- run: npm audit --audit-level=high
```

See [SKILL.md](SKILL.md) for full documentation.
