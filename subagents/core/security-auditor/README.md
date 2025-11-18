# Security Auditor Agent 🔒

Security specialist for vulnerability assessment, secure authentication, OWASP compliance, and comprehensive security audits. Protect your applications from security threats.

## 🎯 Overview

The **@security-auditor** agent provides expert security analysis based on industry standards and best practices. From OWASP Top 10 vulnerabilities to compliance requirements, this agent helps you build secure applications.

## ✨ Working with Skills (NEW!)

This agent works in coordination with **three security skills** that provide continuous monitoring:

**security-auditor Skill (Autonomous):**
- Scans for OWASP Top 10 vulnerabilities in real-time
- Detects SQL injection, XSS, CSRF patterns
- Flags insecure authentication and authorization
- Tools: Read, Grep, Bash (lightweight)

**secret-scanner Skill (Autonomous):**
- Detects exposed API keys, tokens, and credentials
- Blocks commits containing secrets (pre-commit protection)
- Identifies hardcoded passwords and keys
- Tools: Read, Grep (read-only, lightweight)

**dependency-auditor Skill (Autonomous):**
- Checks dependencies for known CVEs
- Runs npm audit, pip-audit automatically
- Alerts on vulnerable package versions
- Tools: Bash, Read (registry access needed)

**This Agent (Manual Expert):**
- Invoked explicitly for comprehensive security audits
- Architecture-level security review
- Compliance assessment (PCI-DSS, HIPAA, SOC 2)
- Penetration testing and threat modeling
- Tools: Read, Edit, Bash, Grep, Glob, Task (full access)

### Typical Workflow

1. **Skills monitor** → Continuous security scanning during development
2. **You invoke this agent** → `@security-auditor Comprehensive security audit`
3. **Agent analyzes** → Build on skill findings, provide architecture-level review
4. **Complementary, not duplicate** → Skills detect patterns, agent assesses overall security posture

**See:** [Skills Guide](../../skills/README.md) for more information

## 🚀 Capabilities

### OWASP Top 10 Analysis
- **A01: Broken Access Control** - Authorization flaws
- **A02: Cryptographic Failures** - Data exposure, weak encryption
- **A03: Injection** - SQL, NoSQL, Command injection
- **A04: Insecure Design** - Missing security controls
- **A05: Security Misconfiguration** - Default configs, unnecessary features
- **A06: Vulnerable Components** - Outdated dependencies
- **A07: Authentication Failures** - Weak auth, session management
- **A08: Software & Data Integrity Failures** - Unsigned updates, CI/CD attacks
- **A09: Security Logging Failures** - Insufficient monitoring
- **A10: Server-Side Request Forgery** - SSRF attacks

### Security Auditing
- **Authentication review** - Login, session management, token handling
- **Authorization review** - Access controls, permissions, RBAC
- **Input validation** - Sanitization, type checking, length limits
- **Output encoding** - XSS prevention, context-aware encoding
- **Cryptography** - Encryption at rest/transit, key management
- **API security** - Rate limiting, CORS, security headers

### Compliance Assessment
- **PCI-DSS** - Payment card security standards
- **HIPAA** - Healthcare data protection
- **GDPR** - Data privacy and protection
- **SOC 2** - Security, availability, confidentiality
- **ISO 27001** - Information security management

## 🛠️ Usage Examples

### Authentication Security Audit

```bash
@security-auditor Audit this authentication system for security vulnerabilities

// Login endpoint
app.post('/login', async (req, res) => {
  const { email, password } = req.body;

  const user = await User.findOne({ email });
  if (!user || user.password !== password) {
    return res.status(401).json({ error: 'Invalid credentials' });
  }

  const token = jwt.sign({ id: user.id }, 'secret123');
  res.json({ token });
});

// Protected endpoint
app.get('/profile', (req, res) => {
  const token = req.headers.authorization;
  const decoded = jwt.verify(token, 'secret123');

  const user = User.findById(decoded.id);
  res.json(user);
});
```

**Agent Response:**
```markdown
## Security Audit Results 🔒

### 🚨 Critical Vulnerabilities (Must Fix Immediately)

#### 1. **Plaintext Password Storage** (Line 4)
**Severity**: CRITICAL 🚨
**Issue**: Passwords stored in plaintext
- Database breach exposes all user passwords
- Violates OWASP A02: Cryptographic Failures
- Non-compliant with PCI-DSS, GDPR

**Fix**:
```javascript
const bcrypt = require('bcrypt');

// Hash password on registration
const hashedPassword = await bcrypt.hash(password, 12);

// Verify on login
const isValid = await bcrypt.compare(password, user.passwordHash);
```

#### 2. **Hardcoded JWT Secret** (Line 7, 15)
**Severity**: CRITICAL 🚨
**Issue**: Secret key hardcoded in source code
- Exposed in version control
- Same secret across all environments
- Violates OWASP A05: Security Misconfiguration

**Fix**:
```javascript
// Use environment variable
const JWT_SECRET = process.env.JWT_SECRET;

// Validate secret exists
if (!JWT_SECRET) {
  throw new Error('JWT_SECRET environment variable not set');
}

const token = jwt.sign({ id: user.id }, JWT_SECRET, {
  expiresIn: '1h',
  algorithm: 'HS256'
});
```

#### 3. **No Rate Limiting** (Line 2)
**Severity**: HIGH ⚠️
**Issue**: Unlimited login attempts
- Brute force attacks possible
- Account enumeration
- Violates OWASP A07: Authentication Failures

**Fix**:
```javascript
const rateLimit = require('express-rate-limit');

const loginLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 5, // 5 attempts per window
  message: 'Too many login attempts, please try again later',
  standardHeaders: true,
  legacyHeaders: false,
});

app.post('/login', loginLimiter, async (req, res) => {
  // Login logic
});
```

#### 4. **Information Disclosure** (Line 5)
**Severity**: MEDIUM 📋
**Issue**: Different error messages for invalid email vs password
- Enables account enumeration
- Attacker can validate email addresses

**Fix**:
```javascript
// Generic error message
if (!user || !await bcrypt.compare(password, user.passwordHash)) {
  return res.status(401).json({
    error: 'Invalid email or password'
  });
}
```

#### 5. **Missing Input Validation** (Line 3)
**Severity**: HIGH ⚠️
**Issue**: No validation on email and password
- Injection attacks possible
- Invalid data can cause errors

**Fix**:
```javascript
const { body, validationResult } = require('express-validator');

app.post('/login',
  [
    body('email').isEmail().normalizeEmail(),
    body('password').isString().isLength({ min: 8 })
  ],
  async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    // Login logic
  }
);
```

#### 6. **Missing CSRF Protection**
**Severity**: HIGH ⚠️
**Issue**: No CSRF token validation
- Cross-site request forgery possible
- Violates OWASP A01: Broken Access Control

**Fix**:
```javascript
const csrf = require('csurf');
const csrfProtection = csrf({ cookie: true });

app.post('/login', csrfProtection, async (req, res) => {
  // Login logic
});
```

#### 7. **Insecure Token Storage** (Line 16)
**Severity**: MEDIUM 📋
**Issue**: Token sent in Authorization header without secure storage
- Recommend HTTP-only cookie instead

**Fix**:
```javascript
// Set secure cookie
res.cookie('auth_token', token, {
  httpOnly: true,      // Prevents XSS
  secure: true,        // HTTPS only
  sameSite: 'strict',  // CSRF protection
  maxAge: 3600000      // 1 hour
});
```

### 🛡️ Secure Implementation

```javascript
const express = require('express');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const rateLimit = require('express-rate-limit');
const helmet = require('helmet');
const csrf = require('csurf');
const { body, validationResult } = require('express-validator');

const app = express();

// Security middleware
app.use(helmet());
app.use(csrf({ cookie: true }));

// Rate limiting
const loginLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 5,
  message: 'Too many login attempts'
});

// Secure login endpoint
app.post('/login',
  loginLimiter,
  [
    body('email').isEmail().normalizeEmail(),
    body('password').isString().isLength({ min: 8 })
  ],
  async (req, res) => {
    try {
      // Validate input
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({
          error: 'Invalid input',
          details: errors.array()
        });
      }

      const { email, password } = req.body;

      // Find user
      const user = await User.findOne({ email });

      // Verify password (constant-time comparison)
      const isValid = user &&
        await bcrypt.compare(password, user.passwordHash);

      if (!isValid) {
        // Generic error - prevent account enumeration
        return res.status(401).json({
          error: 'Invalid email or password'
        });
      }

      // Check if account is locked
      if (user.isLocked) {
        return res.status(423).json({
          error: 'Account is locked'
        });
      }

      // Generate secure token
      const token = jwt.sign(
        { id: user.id, role: user.role },
        process.env.JWT_SECRET,
        {
          expiresIn: '1h',
          algorithm: 'HS256',
          issuer: 'your-app',
          audience: 'your-app-users'
        }
      );

      // Set secure cookie
      res.cookie('auth_token', token, {
        httpOnly: true,
        secure: process.env.NODE_ENV === 'production',
        sameSite: 'strict',
        maxAge: 3600000
      });

      // Log successful login
      await auditLog.create({
        userId: user.id,
        action: 'LOGIN_SUCCESS',
        ip: req.ip,
        userAgent: req.get('user-agent')
      });

      res.json({
        success: true,
        user: {
          id: user.id,
          name: user.name,
          email: user.email
        }
      });
    } catch (error) {
      // Log error securely (don't expose internal details)
      console.error('Login error:', error);

      res.status(500).json({
        error: 'Internal server error'
      });
    }
  }
);

// Secure protected endpoint
const authenticateJWT = async (req, res, next) => {
  try {
    const token = req.cookies.auth_token;

    if (!token) {
      return res.status(401).json({ error: 'Authentication required' });
    }

    // Verify token
    const decoded = jwt.verify(token, process.env.JWT_SECRET, {
      algorithms: ['HS256'],
      issuer: 'your-app',
      audience: 'your-app-users'
    });

    // Check if token is blacklisted
    const isBlacklisted = await TokenBlacklist.exists({
      token,
      userId: decoded.id
    });

    if (isBlacklisted) {
      return res.status(401).json({ error: 'Token revoked' });
    }

    // Attach user to request
    req.user = { id: decoded.id, role: decoded.role };
    next();
  } catch (error) {
    if (error.name === 'TokenExpiredError') {
      return res.status(401).json({ error: 'Token expired' });
    }

    return res.status(401).json({ error: 'Invalid token' });
  }
};

app.get('/profile', authenticateJWT, async (req, res) => {
  const user = await User.findById(req.user.id)
    .select('-passwordHash'); // Don't send password hash

  res.json(user);
});
```

### 📊 Security Score: 2/10 → 9/10

### 🎯 Security Checklist
- [x] Password hashing (bcrypt)
- [x] Environment variables for secrets
- [x] Rate limiting (5 attempts / 15 min)
- [x] Input validation
- [x] CSRF protection
- [x] Secure cookie storage (HTTP-only, Secure, SameSite)
- [x] Generic error messages
- [x] JWT best practices (expiry, algorithm)
- [x] Security headers (helmet)
- [x] Audit logging
- [x] Token blacklisting
- [ ] Two-factor authentication (recommended)
- [ ] Account lockout after failed attempts
- [ ] Password complexity requirements
```

### API Security Audit

```bash
@security-auditor Review this REST API for security issues

// Public API endpoint
app.get('/api/users/:id', (req, res) => {
  const user = db.query(`SELECT * FROM users WHERE id = ${req.params.id}`);
  res.json(user);
});

// Admin endpoint
app.delete('/api/users/:id', (req, res) => {
  db.query(`DELETE FROM users WHERE id = ${req.params.id}`);
  res.json({ success: true });
});
```

**Agent Response:**
```markdown
## API Security Analysis 🔒

### 🚨 Critical Issues

#### 1. SQL Injection (Both Endpoints)
**Severity**: CRITICAL 🚨
- Direct parameter interpolation
- Allows arbitrary SQL execution
- Complete database compromise possible

#### 2. No Authentication (Both Endpoints)
**Severity**: CRITICAL 🚨
- Anyone can access user data
- Anyone can delete users
- Violates OWASP A01: Broken Access Control

#### 3. No Authorization (Delete Endpoint)
**Severity**: CRITICAL 🚨
- No admin check
- Users can delete other users

#### 4. Sensitive Data Exposure
**Severity**: HIGH ⚠️
- Returns entire user record (including password hash)
- Violates OWASP A02: Cryptographic Failures

#### 5. No Rate Limiting
**Severity**: MEDIUM 📋
- API abuse possible
- DoS vulnerability

### Secure Implementation
[Complete secure API implementation with fixes]
```

## 🎯 Security Best Practices

### Defense in Depth
Layer multiple security controls:
1. **Network**: Firewall, VPN, SSL/TLS
2. **Application**: Input validation, output encoding
3. **Authentication**: Strong passwords, MFA
4. **Authorization**: Principle of least privilege
5. **Data**: Encryption at rest and in transit
6. **Monitoring**: Logging, alerting, incident response

### Secure Development Lifecycle
1. **Requirements**: Define security requirements
2. **Design**: Threat modeling, security architecture
3. **Implementation**: Secure coding practices
4. **Testing**: Security testing, penetration testing
5. **Deployment**: Secure configuration, monitoring
6. **Maintenance**: Updates, patches, vulnerability management

---

**Need security audit? 🔒**

Use `@security-auditor` for comprehensive security analysis following OWASP standards and compliance requirements!
