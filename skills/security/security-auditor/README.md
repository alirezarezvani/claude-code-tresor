# Security Auditor Skill

> Automatic OWASP Top 10 and security vulnerability detection

## Quick Example

```javascript
// You write:
const query = `SELECT * FROM users WHERE id = ${userId}`;

// Skill immediately alerts:
🚨 CRITICAL: SQL injection vulnerability (line 1)
🔧 Fix: const query = 'SELECT * FROM users WHERE id = ?';
📖 https://owasp.org/www-community/attacks/SQL_Injection
```

## What It Detects

- 🚨 SQL Injection
- 🚨 XSS (Cross-Site Scripting)
- 🚨 Exposed Secrets & API Keys
- 🚨 Weak Authentication
- 🚨 Authorization Issues
- ⚠️ Security Misconfigurations
- ⚠️ Insecure Data Storage

## Severity Levels

- 🚨 **CRITICAL**: Exploitable vulnerabilities
- ⚠️ **HIGH**: Security weaknesses
- 📋 **MEDIUM**: Potential issues
- 💡 **LOW**: Best practices

## Integration

- **secret-scanner skill**: Detects exposed credentials
- **@code-reviewer sub-agent**: Deep security audit
- **/review command**: Comprehensive security review

See [SKILL.md](SKILL.md) for full documentation.
