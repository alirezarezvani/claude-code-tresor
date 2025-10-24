# Secret Scanner Skill

> Detect and prevent exposed secrets, API keys, and credentials

## Quick Example

```javascript
// You type:
const stripeKey = 'sk_live_1234567890abcdef';

// Instant alert:
🚨 CRITICAL: Exposed Stripe API key!
🔧 Fix: const stripeKey = process.env.STRIPE_SECRET_KEY;
```

## What It Detects

- AWS/Google/Azure API keys
- Stripe/PayPal API keys
- Database passwords
- JWT secrets
- SSH private keys
- OAuth tokens

## Pre-Commit Protection

Blocks commits with exposed secrets:
```bash
git commit
# 🚨 Cannot commit - secrets detected!
```

## Quick Fix

```bash
# 1. Move to .env file
echo "API_KEY=your_key" > .env

# 2. Add to .gitignore
echo ".env" >> .gitignore

# 3. Use in code
const key = process.env.API_KEY;
```

See [SKILL.md](SKILL.md) for full documentation.
