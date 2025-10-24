---
name: secret-scanner
description: Detect exposed secrets, API keys, credentials, and tokens in code. Use before commits, on file saves, or when security is mentioned. Prevents accidental secret exposure. Triggers on file changes, git commits, security checks, .env file modifications.
allowed-tools: Read, Grep
---

# Secret Scanner Skill

Prevent accidental secret exposure in your codebase.

## When I Activate

- ✅ Before git commits
- ✅ Files modified/saved
- ✅ User mentions secrets, keys, or credentials
- ✅ .env files changed
- ✅ Configuration files modified

## What I Detect

### API Keys & Tokens
- AWS access keys (AKIA...)
- Stripe API keys (sk_live_..., pk_live_...)
- GitHub tokens (ghp_...)
- Google API keys
- OAuth tokens
- JWT secrets

### Database Credentials
- Database connection strings
- MySQL/PostgreSQL passwords
- MongoDB connection URIs
- Redis passwords

### Private Keys
- SSH private keys
- RSA/DSA keys
- PGP/GPG keys
- SSL certificates

### Authentication Secrets
- Password variables
- Auth tokens
- Session secrets
- Encryption keys

## Alert Examples

### API Key Detection
```javascript
// You type:
const apiKey = 'sk_live_1234567890abcdef';

// I immediately alert:
🚨 CRITICAL: Exposed Stripe API key detected!
📍 File: config.js, Line 3
🔧 Fix: Use environment variables
  const apiKey = process.env.STRIPE_API_KEY;
📖 Add to .gitignore: .env
```

### AWS Credentials
```python
# You type:
aws_access_key = "AKIAIOSFODNN7EXAMPLE"

# I alert:
🚨 CRITICAL: AWS access key exposed!
📍 File: aws_config.py, Line 1
🔧 Fix: Use AWS credentials file or environment variables
  aws_access_key = os.getenv("AWS_ACCESS_KEY_ID")
📖 Never commit AWS credentials
```

### Database Password
```yaml
# You type in docker-compose.yml:
environment:
  DB_PASSWORD: "mySecretPassword123"

# I alert:
🚨 CRITICAL: Database password in configuration file!
📍 File: docker-compose.yml, Line 5
🔧 Fix: Use .env file
  DB_PASSWORD: ${DB_PASSWORD}
📖 Add .env to .gitignore
```

## Detection Patterns

### Pattern Types

**High Confidence:**
- Known API key formats (Stripe, AWS, etc.)
- Private key headers
- JWT tokens
- Connection strings with credentials

**Medium Confidence:**
- Variables named "password", "secret", "key"
- Base64 encoded strings in sensitive contexts
- Long random strings in assignments

**Low Confidence (Flagged for Review):**
- Generic secret patterns
- Potential credentials in comments

## Git Integration

### Pre-Commit Protection

```bash
# Before commit, I scan:
git add .
git commit

# I block if secrets found:
🚨 CRITICAL: Cannot commit - secrets detected!
📍 3 secrets found:
  - config.js:12 - API key
  - .env:5 - Database password (in gitignore - OK)
  - auth.js:45 - JWT secret

❌ Commit blocked - remove secrets first
```

### .gitignore Validation

I check if sensitive files are in .gitignore:

```
✅ .env - In .gitignore (good)
⚠️ config/secrets.json - NOT in .gitignore (add it!)
✅ .aws/credentials - In .gitignore (good)
```

## False Positive Handling

### Example Files
```javascript
// I understand these are examples:
// Example: const apiKey = 'your_api_key_here';
// TODO: Add your API key from environment
```

### Test Files
```javascript
// Test fixtures are OK (but flagged for review):
const mockApiKey = 'sk_test_1234567890abcdef';  // ✅ Test key
```

### Documentation
```markdown
<!-- Documentation examples are flagged but low priority -->
Set your API key: `export API_KEY=your_key_here`
```

## Relationship with security-auditor

**secret-scanner (me):** Exposed secrets and credentials
**security-auditor:** Code vulnerability patterns

### Together
```
secret-scanner: Finds hardcoded API key
security-auditor: Finds how the key is used insecurely
Combined: Complete security picture
```

## Quick Fixes

### Move to Environment Variables

```javascript
// Before:
const apiKey = 'sk_live_abc123';

// After:
const apiKey = process.env.API_KEY;

// .env file (add to .gitignore):
API_KEY=sk_live_abc123
```

### Use Secret Management

```javascript
// AWS Secrets Manager
const AWS = require('aws-sdk');
const secrets = new AWS.SecretsManager();
const secret = await secrets.getSecretValue({ SecretId: 'myApiKey' }).promise();
```

### Configuration Files

```yaml
# docker-compose.yml
services:
  app:
    environment:
      - API_KEY=${API_KEY}  # From .env file

# .env (gitignored)
API_KEY=sk_live_abc123
```

## Sandboxing Compatibility

**Works without sandboxing:** ✅ Yes (recommended)
**Works with sandboxing:** ✅ Yes

- **Filesystem**: Read-only access
- **Network**: None required
- **Configuration**: None required

## Customization

Add company-specific secret patterns:

```bash
cp -r ~/.claude/skills/security/secret-scanner \
      ~/.claude/skills/security/company-secret-scanner

# Edit SKILL.md to add:
# - Internal API key formats
# - Company-specific secret patterns
# - Custom detection rules
```

## Best Practices

1. **Never commit secrets** - Use environment variables
2. **Use .gitignore** - Add .env, secrets.json, etc.
3. **Rotate exposed secrets** - If committed, rotate immediately
4. **Use secret management** - AWS Secrets Manager, HashiCorp Vault
5. **Audit regularly** - Review code for exposed secrets

## Emergency Response

### If Secret Committed

1. **Rotate the secret immediately**
2. **Remove from git history**
   ```bash
   git filter-branch --force --index-filter \
     "git rm --cached --ignore-unmatch config/secrets.json" \
     --prune-empty --tag-name-filter cat -- --all
   ```
3. **Force push** (coordinate with team)
4. **Update all deployments** with new secret

## Related Tools

- **security-auditor skill**: Vulnerability detection
- **@code-reviewer sub-agent**: Security review
- **/review command**: Comprehensive security check
