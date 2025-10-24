# Skill Templates

> **Copy-paste templates for creating custom skills**

Use these templates to create company-specific or project-specific skills. Each template is ready to customize with your own logic.

---

## Template 1: Basic Skill (Minimal)

**Use for:** Simple detection and suggestion skills

**File:** `skills/custom/my-skill/SKILL.md`

```markdown
---
name: my-skill
description: Brief description with TRIGGER KEYWORDS. Use when [condition], or user mentions [keyword]. Triggers on [event1], [event2].
allowed-tools: Read, Grep
---

# My Skill

[One-sentence description]

## When I Activate

- ✅ [Condition 1]
- ✅ [Condition 2]
- ✅ User mentions [keyword]

## What I Do

- [Action 1]
- [Action 2]
- [Action 3]

## Examples

### Example 1

\```language
// Your code:
[code example]

// I suggest:
[suggestion]
\```

## Relationship with @sub-agent-name

**Me (Skill):** Quick automatic checks
**@sub-agent (Sub-Agent):** Deep manual analysis

### Workflow
1. I detect [issue]
2. User invokes **@sub-agent** for details

## Sandboxing Compatibility

**Works without sandboxing:** ✅ Yes
**Works with sandboxing:** ✅ Yes

- **Filesystem**: [Read/Write/None]
- **Network**: [None/Optional]
- **Configuration**: None required

## Best Practices

1. [Practice 1]
2. [Practice 2]
3. [Practice 3]
```

**File:** `skills/custom/my-skill/README.md`

```markdown
# My Skill

> [One-sentence tagline]

## Quick Example

\```language
// Example showing skill in action
\```

## What It Does

- ✅ [Feature 1]
- ✅ [Feature 2]
- ✅ [Feature 3]

## Triggers

- [Event 1]
- [Event 2]
- [Event 3]

See [SKILL.md](SKILL.md) for full documentation.
```

---

## Template 2: Security Scanner

**Use for:** Custom security checks, company security policies

**File:** `skills/security/company-security-scanner/SKILL.md`

```markdown
---
name: company-security-scanner
description: Company-specific security standards validation. Use when security code modified, auth mentioned, or compliance needed. Triggers on authentication code, API endpoints, data handling.
allowed-tools: Read, Grep, Bash
---

# Company Security Scanner

Enforce company security standards and compliance requirements.

## When I Activate

- ✅ Authentication/authorization code modified
- ✅ API endpoints added or changed
- ✅ Data handling or storage code
- ✅ User mentions security, compliance, or audit
- ✅ Pre-commit (optional)

## What I Check

### Security Standards

**Authentication:**
- Company-approved auth methods only
- JWT token expiration policies
- Password complexity requirements
- MFA enforcement

**Data Protection:**
- PII handling compliance
- Data encryption at rest
- HTTPS/TLS enforcement
- Database credential management

**API Security:**
- Rate limiting implementation
- Input validation standards
- CORS configuration
- API key rotation policies

## Detection Logic

### Pattern Matching

\```javascript
// Detect non-compliant auth:
const violations = [
  /basicAuth/i,                    // BasicAuth not allowed
  /hardcoded.*password/i,          // No hardcoded passwords
  /jwt.*expiresIn.*[^1-9]h/       // JWT must expire < 10h
]
\```

### Company Standards

\```yaml
Required Headers:
  - X-Content-Type-Options: nosniff
  - X-Frame-Options: DENY
  - Strict-Transport-Security: max-age=31536000

Forbidden Packages:
  - old-jwt-lib (use company-auth-lib)
  - insecure-crypto (use company-crypto-lib)
\```

## Examples

### Authentication Violation

\```javascript
// You write:
app.post('/login', (req, res) => {
  const { username, password } = req.body
  if (password === 'admin123') {  // ⚠️ VIOLATION
    res.json({ token: generateToken() })
  }
})

// I alert:
// 🚨 CRITICAL: Security Violation
// Line 3: Hardcoded password
// Company Policy: Passwords must be hashed and stored securely
// Required: Use company-auth-lib.verifyPassword()
// → For compliance review: @security-auditor
\```

### Missing Security Headers

\```javascript
// You write:
app.use(cors())  // ⚠️ INCOMPLETE

// I suggest:
// ⚠️ MEDIUM: Missing required security headers
// Company Standard: Must include X-Frame-Options, CSP
// Add:
app.use(helmet({
  frameguard: { action: 'deny' },
  contentSecurityPolicy: { /* company policy */ }
}))
\```

## Integration with @security-auditor

**Me (Skill):** Real-time company policy enforcement
**@security-auditor (Sub-Agent):** Comprehensive vulnerability analysis

### Workflow
1. I detect company policy violations during coding
2. User runs **@security-auditor** for OWASP Top 10 analysis
3. Combined: Company standards + Industry best practices

## Customization

\```markdown
### Add Company-Specific Rules

Edit SKILL.md and add to "What I Check" section:

**Company Rule #47:**
- All APIs must use company-auth-lib v2.3+
- Rate limit: 100 req/min per user
- Audit logging required for PII access

### Update Detection Patterns

\```javascript
// Add to detection logic:
const companyViolations = [
  /api.*without.*companyAuthMiddleware/i,
  /pii.*without.*auditLog/i
]
\```
\```

## Sandboxing Compatibility

**Works without sandboxing:** ✅ Yes
**Works with sandboxing:** ✅ Yes

**Optional sandboxing config:**
\```json
{
  "network": {
    "allowedDomains": [
      "company-security-api.internal"
    ]
  },
  "filesystem": {
    "readOnly": [
      "/company-security-policies/"
    ]
  }
}
\```

## Best Practices

1. **Keep policies updated** - Sync with security team monthly
2. **Severity levels** - CRITICAL blocks commits, MEDIUM warns
3. **Education over enforcement** - Explain why, not just what
4. **Integration** - Work with CI/CD security gates
5. **Exception handling** - Document approved exceptions

## Related Tools

- **@security-auditor sub-agent**: OWASP vulnerability scanning
- **secret-scanner skill**: Exposed secrets detection
- **dependency-auditor skill**: CVE checking
```

**File:** `skills/security/company-security-scanner/README.md`

```markdown
# Company Security Scanner

> Real-time company security policy enforcement

## Quick Example

\```javascript
// You write non-compliant code:
app.post('/login', basicAuth())  // ❌ BasicAuth not allowed

// Skill alerts:
🚨 Security Policy Violation
Company requires OAuth2 with MFA
Use: company-auth-lib.oauth2WithMFA()
\```

## What It Checks

- ✅ Company-approved authentication methods
- ✅ Required security headers
- ✅ Data protection compliance
- ✅ API security standards
- ✅ Forbidden package usage

## Integration

Works with:
- **@security-auditor**: Industry vulnerability scanning
- **secret-scanner skill**: Exposed secrets
- **CI/CD**: Blocks non-compliant deployments

See [SKILL.md](SKILL.md) for full documentation.
```

---

## Template 3: Framework-Specific Validator

**Use for:** React/Vue/Angular conventions, Next.js best practices

**File:** `skills/development/nextjs-validator/SKILL.md`

```markdown
---
name: nextjs-validator
description: Next.js 15+ best practices and conventions. Use when Next.js files modified, app router used, or server components mentioned. Triggers on page.tsx, layout.tsx, route.ts changes.
allowed-tools: Read, Grep, Glob
---

# Next.js Validator

Enforce Next.js 15+ best practices and App Router conventions.

## When I Activate

- ✅ Files in `app/` directory modified
- ✅ Server/Client components created
- ✅ API routes added
- ✅ User mentions Next.js, App Router, RSC
- ✅ File saved with `.tsx` in `app/` folder

## What I Check

### App Router Conventions

**File Structure:**
- `app/page.tsx` - Pages
- `app/layout.tsx` - Layouts
- `app/loading.tsx` - Loading states
- `app/error.tsx` - Error boundaries
- `app/not-found.tsx` - 404 pages

**Server vs Client Components:**
- Server Components (default)
- Client Components (`'use client'`)
- Proper directive placement

**Data Fetching:**
- `fetch()` with caching strategies
- Server Actions for mutations
- `revalidatePath()` / `revalidateTag()`

### Performance Checks

- Image optimization (`next/image`)
- Font optimization (`next/font`)
- Script loading (`next/script`)
- Dynamic imports for code splitting
- Metadata API usage

## Examples

### Server Component Violation

\```typescript
// You write:
'use client'  // ⚠️ UNNECESSARY

export default function Page() {
  // No client-side features used
  return <div>Static content</div>
}

// I suggest:
// ⚠️ OPTIMIZATION: Unnecessary 'use client'
// This component uses no client-side features
// Remove directive to enable Server Component benefits:
// - Faster initial load
// - Smaller bundle size
// - Better SEO
\```

### Image Optimization

\```typescript
// You write:
<img src="/hero.jpg" />  // ⚠️ NOT OPTIMIZED

// I suggest:
// ⚠️ PERFORMANCE: Use next/image for optimization
// Replace with:
import Image from 'next/image'
<Image
  src="/hero.jpg"
  alt="Hero image"
  width={800}
  height={600}
  priority  // For above-the-fold images
/>
// Benefits: Automatic WebP, lazy loading, responsive
\```

### Data Fetching Pattern

\```typescript
// You write:
'use client'
import { useEffect, useState } from 'react'

export default function Page() {
  const [data, setData] = useState()
  useEffect(() => {
    fetch('/api/data').then(r => setData(r))
  }, [])
}

// I suggest:
// ⚠️ PATTERN: Use Server Component for data fetching
// Replace with:
async function Page() {
  const data = await fetch('/api/data', {
    next: { revalidate: 3600 }  // Cache for 1 hour
  })
  return <div>{data}</div>
}
// Benefits: No loading states, better SEO, simpler code
\```

## Detection Logic

### Pattern Recognition

\```javascript
const patterns = {
  unnecessaryUseClient: /'use client'.*no.*hooks.*no.*events/,
  unoptimizedImage: /<img[^>]+src=/,
  clientDataFetch: /'use client'.*useEffect.*fetch/,
  missingMetadata: /export.*Page.*without.*metadata/
}
\```

## Relationship with @architect

**Me (Skill):** Next.js convention enforcement
**@architect (Sub-Agent):** Full architecture review

### Workflow
1. I detect Next.js-specific issues in real-time
2. User invokes **@architect** for system design review

## Sandboxing Compatibility

**Works without sandboxing:** ✅ Yes
**Works with sandboxing:** ✅ Yes

- **Filesystem**: Read-only
- **Network**: None
- **Configuration**: None required

## Best Practices

1. **Server Components by default** - Only use 'use client' when needed
2. **Optimize images** - Always use next/image
3. **Cache strategically** - Use revalidate for dynamic content
4. **Colocate data fetching** - Fetch in component, not separate hook
5. **Use Metadata API** - Generate SEO tags automatically

## Related Tools

- **@architect sub-agent**: System architecture review
- **code-reviewer skill**: General code quality
- **test-generator skill**: Component testing
```

---

## Template 4: Documentation Generator

**Use for:** Auto-generating specific documentation types

**File:** `skills/documentation/changelog-generator/SKILL.md`

```markdown
---
name: changelog-generator
description: Auto-generate CHANGELOG.md entries from git commits. Use when commits made, version bumped, or release prepared. Triggers on git commit, version in package.json changed.
allowed-tools: Bash, Read, Write
---

# Changelog Generator

Automatically generate CHANGELOG.md from conventional commits.

## When I Activate

- ✅ Git commits detected
- ✅ `package.json` version changed
- ✅ User mentions "changelog", "release notes", or "version"
- ✅ Tag created (e.g., v1.2.0)
- ✅ Multiple commits since last changelog update

## What I Generate

### Changelog Format (Keep a Changelog)

\```markdown
# Changelog

## [1.2.0] - 2025-10-24

### Added
- New authentication system with OAuth2
- User profile management UI

### Changed
- Improved performance of data loading (30% faster)
- Updated dependency versions for security

### Fixed
- Resolved memory leak in WebSocket connection
- Fixed timezone bug in date formatting

### Security
- Patched XSS vulnerability in user input
\```

## Detection Logic

### Parse Conventional Commits

\```bash
# Analyze commits since last tag:
git log $(git describe --tags --abbrev=0)..HEAD --oneline

# Extract commit types:
feat:    → ### Added
fix:     → ### Fixed
perf:    → ### Changed (performance)
security:→ ### Security
docs:    → Skip (documentation changes)
\```

### Version Bumping

\```javascript
// Determine version bump:
const hasFeat = commits.some(c => c.startsWith('feat:'))
const hasFix = commits.some(c => c.startsWith('fix:'))
const hasBreaking = commits.some(c => c.includes('BREAKING CHANGE'))

if (hasBreaking) return 'major'  // 1.0.0 → 2.0.0
if (hasFeat) return 'minor'       // 1.0.0 → 1.1.0
if (hasFix) return 'patch'        // 1.0.0 → 1.0.1
\```

## Examples

### From Commits to Changelog

\```bash
# Recent commits:
feat(auth): add OAuth2 authentication
fix(api): resolve memory leak in WebSocket
perf(db): optimize query performance (30% faster)
docs: update API documentation

# Generated changelog entry:
## [1.2.0] - 2025-10-24

### Added
- **auth**: OAuth2 authentication system

### Fixed
- **api**: Memory leak in WebSocket connection

### Changed
- **db**: Query performance optimized (30% faster)
\```

### Integration with Release

\```bash
# You create tag:
git tag v1.2.0

# I auto-generate:
# 1. CHANGELOG.md entry
# 2. GitHub release notes
# 3. npm version bump
# → For complete release: /release command
\```

## Relationship with @docs-writer

**Me (Skill):** Auto-generate changelog from commits
**@docs-writer (Sub-Agent):** Comprehensive release documentation

### Workflow
1. I generate changelog entries automatically
2. User invokes **@docs-writer** for full release notes with migration guides

## Customization

\```markdown
### Custom Commit Types

Add to detection logic:

\```yaml
Custom Types:
  epic: → ### Major Features
  ux: → ### User Experience
  a11y: → ### Accessibility
\```

### Custom Changelog Format

Edit template:

\```markdown
## [Version] - Date

**New Features**
- Feature 1
- Feature 2

**Bug Fixes**
- Fix 1

**Breaking Changes**
- ⚠️ Change 1 (migration guide link)
\```
\```

## Sandboxing Compatibility

**Works without sandboxing:** ✅ Yes
**Works with sandboxing:** ✅ Yes

- **Filesystem**: Writes to CHANGELOG.md
- **Network**: None (unless fetching GitHub metadata)
- **Git**: Requires git access

## Best Practices

1. **Conventional commits** - Consistent commit messages are crucial
2. **Semantic versioning** - Follow semver strictly
3. **Breaking changes** - Always document migration path
4. **Categorization** - Group changes logically
5. **Links** - Reference issues and PRs

## Related Tools

- **git-commit-helper skill**: Generate commit messages
- **@docs-writer sub-agent**: Full release documentation
- **/release command**: Complete release workflow
```

---

## Template 5: Testing Helper

**Use for:** Test coverage monitoring, test quality checks

**File:** `skills/testing/coverage-monitor/SKILL.md`

```markdown
---
name: coverage-monitor
description: Monitor test coverage and suggest missing tests. Use when code added without tests, coverage drops, or tests mentioned. Triggers on new files without tests, coverage below threshold.
allowed-tools: Bash, Read, Grep, Glob
---

# Coverage Monitor

Track test coverage and suggest missing tests automatically.

## When I Activate

- ✅ New file added without corresponding test file
- ✅ Function added without tests
- ✅ Coverage drops below threshold (e.g., 80%)
- ✅ User mentions "tests", "coverage", or "untested"
- ✅ Pull request created

## What I Check

### Coverage Metrics

**File Coverage:**
- Each source file has corresponding test file
- Naming convention: `utils.ts` → `utils.test.ts`

**Line Coverage:**
- Minimum 80% line coverage
- Critical paths: 100% coverage (auth, payments)

**Branch Coverage:**
- All if/else paths tested
- All switch cases covered
- Error handling tested

**Function Coverage:**
- All exported functions tested
- Edge cases covered

## Examples

### Missing Test File

\```typescript
// You create:
src/utils/formatDate.ts

// I detect:
// ⚠️ COVERAGE: Missing test file
// File: src/utils/formatDate.ts
// Expected: src/utils/formatDate.test.ts
// Functions to test:
//   - formatDate() - 3 suggested tests
//   - parseDate() - 4 suggested tests
// → For full suite: @test-engineer
\```

### Coverage Drop

\```bash
# You commit changes:
git commit -m "feat: add discount calculation"

# I run coverage:
# Coverage: 78% → 72% (-6%)
# ⚠️ COVERAGE DROP
# New uncovered lines:
#   - src/pricing.ts:45-52 (discount logic)
#   - src/pricing.ts:67 (error handling)
# Suggested tests:
#   - Test discount calculation with edge cases
#   - Test error handling for invalid discounts
\```

### Untested Error Path

\```javascript
// You write:
function processPayment(amount) {
  if (amount < 0) {
    throw new Error('Invalid amount')  // ⚠️ UNTESTED
  }
  return chargeCard(amount)
}

// I suggest:
// ⚠️ UNTESTED: Error path not covered
// Line 3: Error thrown but no test
// Add test:
test('throws error for negative amount', () => {
  expect(() => processPayment(-10))
    .toThrow('Invalid amount')
})
\```

## Detection Logic

\```bash
# Check for test file:
if [ -f "src/utils/formatDate.ts" ] && [ ! -f "src/utils/formatDate.test.ts" ]; then
  echo "Missing test file"
fi

# Run coverage:
npm test -- --coverage
if [ $coverage -lt 80 ]; then
  echo "Coverage below threshold"
fi

# Find untested functions:
grep -r "export function" src/ | while read func; do
  # Check if function name appears in tests
done
\```

## Integration with @test-engineer

**Me (Skill):** Real-time coverage monitoring
**@test-engineer (Sub-Agent):** Comprehensive test suite creation

### Workflow
1. I detect missing coverage automatically
2. User invokes **@test-engineer** for complete test implementation
3. I validate coverage after tests added

## Customization

\```markdown
### Set Custom Thresholds

Edit thresholds in SKILL.md:

\```yaml
Coverage Thresholds:
  Minimum: 80%
  Critical Paths: 100%  # auth, payments, security
  New Code: 90%  # Higher bar for new features
\```

### Custom Test Patterns

\```javascript
// Support different test frameworks:
const testPatterns = [
  '.test.ts',     // Jest
  '.spec.ts',     // Angular
  '_test.py',     // Python
  '_spec.rb'      // RSpec
]
\```
\```

## Sandboxing Compatibility

**Works without sandboxing:** ✅ Yes
**Works with sandboxing:** ⚠️ Needs test runner access

**Required sandboxing config:**
\```json
{
  "filesystem": {
    "readWrite": ["coverage/"]
  },
  "commands": {
    "allowed": ["npm test", "jest", "pytest"]
  }
}
\```

## Best Practices

1. **Continuous monitoring** - Check coverage on every commit
2. **Fail fast** - Block PRs below threshold
3. **Prioritize critical paths** - 100% coverage for auth, payments
4. **Test quality over quantity** - Meaningful tests, not just lines
5. **Integration with CI** - Automate coverage reporting

## Related Tools

- **test-generator skill**: Auto-create test scaffolding
- **@test-engineer sub-agent**: Comprehensive test implementation
- **/test-gen command**: Generate complete test suites
```

---

## Installation

### Using Templates

1. **Copy template:**
```bash
cp -r skills/TEMPLATES.md my-project/
```

2. **Customize:**
- Edit SKILL.md frontmatter (name, description, allowed-tools)
- Update detection logic
- Add company-specific examples

3. **Install:**
```bash
# Symlink to Claude Code config
ln -s $(pwd)/skills/custom/my-skill \
      ~/.claude/skills/my-skill
```

4. **Verify:**
```bash
# Check skill is loaded
claude --list-skills | grep my-skill
```

---

## Best Practices for Custom Skills

### 1. Clear Trigger Keywords

**Good:**
```yaml
description: Use when API endpoints modified, routes changed, or REST API mentioned
```

**Bad:**
```yaml
description: Helps with API stuff
```

### 2. Appropriate Tool Selection

**For detection only:**
```yaml
allowed-tools: Read, Grep
```

**For documentation generation:**
```yaml
allowed-tools: Read, Write, Edit
```

**For running checks:**
```yaml
allowed-tools: Read, Bash
```

### 3. Complement, Don't Duplicate

**Skill** = Quick, automatic, real-time
**Sub-Agent** = Deep, manual, comprehensive

**Example:**
- Skill: Detects untested function
- Sub-Agent: Creates full test suite with edge cases

### 4. Sandboxing: Optional First

Design skills to work WITHOUT sandboxing by default. Add sandboxing as optional hardening.

### 5. Progressive Disclosure

README.md = Quick reference
SKILL.md = Complete documentation
External links = Deep-dive resources

---

## Template Checklist

Before publishing custom skill:

- [ ] SKILL.md has valid YAML frontmatter
- [ ] Description includes trigger keywords
- [ ] allowed-tools matches actual tool usage
- [ ] Works WITHOUT sandboxing (default)
- [ ] README.md has quick example
- [ ] Examples show real-world usage
- [ ] Sandboxing section explains optional config
- [ ] Integration with sub-agents/commands documented
- [ ] Best practices section included
- [ ] Tested with actual code changes

---

## Support

**Questions?**
- Browse existing skills in `skills/` for reference
- See [skills/README.md](README.md) for architecture overview
- Check [GETTING-STARTED.md](../GETTING-STARTED.md) for setup help

**Contributing?**
- Fork repo, add skill to `skills/custom/`
- Submit PR with skill + examples
- Follow template structure

---

**Created:** October 24, 2025
**Author:** Alireza Rezvani
**License:** MIT
