# `/audit` - Comprehensive Security Audit Command

> Intelligent multi-phase security orchestration with automatic agent selection from Tresor's 141-agent ecosystem

**Version:** 2.7.0
**Category:** Security
**Type:** Orchestration Command

---

## Overview

The `/audit` command performs comprehensive security audits using intelligent multi-phase orchestration. It automatically detects your tech stack, selects optimal agents from Tresor's 141-agent ecosystem, verifies dependencies, and executes up to 4 phases of security analysis with seamless integration into the Tresor Workflow Framework.

### Key Features

- ✅ **Intelligent Agent Selection** - Auto-selects optimal agents based on detected tech stack
- ✅ **Multi-Phase Orchestration** - Up to 4 phases (parallel scan + sequential deep dives)
- ✅ **Dependency Verification** - Ensures no conflicts before parallel execution
- ✅ **Automatic Issue Capture** - Integrates with `/todo-add` for all findings
- ✅ **Expert Prompt Generation** - Creates `/prompt-create` prompts for complex fixes
- ✅ **Session Resumption** - Supports `/handoff-create` for multi-session audits
- ✅ **Production-Grade** - OWASP-compliant, penetration tested, comprehensive RCA

---

## Quick Start

### Basic Usage

```bash
# Full comprehensive audit (all scopes)
/audit

# Security-only audit (faster)
/audit --scope security

# Infrastructure-only audit
/audit --scope infrastructure

# Compliance-only audit
/audit --scope compliance
```

### Advanced Usage

```bash
# Maximum safety (sequential execution, no parallelism)
/audit --parallel-max 1

# JSON output for CI/CD integration
/audit --report-format json

# Resume from previous session
/audit --resume --report-id audit-2025-11-19-143022
```

---

## How It Works

### Phase 0: Planning & User Confirmation

**Context Detection:**
- Scans codebase to detect languages, frameworks, databases, auth methods
- Analyzes infrastructure (Docker, Kubernetes, cloud providers)
- Identifies API types (REST, GraphQL, gRPC)

**Intelligent Agent Selection:**
```
Detected Tech Stack:
- Languages: JavaScript, TypeScript
- Framework: React (frontend), Express (backend)
- Database: PostgreSQL
- Auth: JWT
- Infrastructure: Docker, AWS

Selected Agents:
Phase 1 (Parallel - 3 agents):
  ✓ @security-auditor (OWASP Top 10)
  ✓ @react-security-specialist (React-specific vulnerabilities)
  ✓ @dependency-auditor (CVE scanning)

Phase 2 (Sequential):
  → @cloud-architect (AWS infrastructure security)

Phase 3 (Sequential):
  → @penetration-tester (Active exploit testing)

Phase 4 (Sequential):
  → @root-cause-analyzer (Comprehensive RCA if critical findings)

Estimated Duration: 2-3 hours
Dependency Verification: ✅ No conflicts detected

Proceed? (y/n/modify)
```

---

### Phase 1: Parallel Security Scan (3 agents max)

**Agents Run Simultaneously:**
- `@security-auditor` - OWASP Top 10 vulnerabilities
- `@react-security-specialist` - React-specific security issues
- `@dependency-auditor` - CVE scanning for all dependencies

**Auto-Capture Issues:**
```bash
# Each agent automatically calls /todo-add for findings:
/todo-add "Fix XSS vulnerability in user input - src/components/UserForm.tsx:45-67"
/todo-add "Upgrade react-router-dom@5.2.0 (CVE-2024-12345) - package.json"
/todo-add "Remove exposed API key from config - src/config/api.ts:12"
```

**Output:**
```
Phase 1 Complete (45 minutes)
- @security-auditor: 4 findings (2 critical, 2 high)
- @react-security-specialist: 3 findings (1 high, 2 medium)
- @dependency-auditor: 5 findings (3 high, 2 low)

Todos Created: 12
Reports: .tresor/audit-2025-11-19/phase-1-*.md
```

---

### Phase 2: Infrastructure Security Review (Sequential)

**Single Agent:**
- `@cloud-architect` (selected based on AWS infrastructure detected)

**Analyzes:**
- AWS security groups, IAM policies, S3 bucket permissions
- RDS encryption, backup policies
- VPC configurations, network security

**Receives Context from Phase 1:**
```
Critical Findings to Follow Up:
- SQL injection found → Verify database-level protections
- Weak JWT algorithm → Review token signing infrastructure
- Environment variables in code → Check secrets management
```

**Output:**
```
Phase 2 Complete (30 minutes)
- @cloud-architect: 5 findings (1 critical, 2 high, 2 medium)

Todos Created: 5 (total: 17)
Reports: .tresor/audit-2025-11-19/phase-2-cloud-architect.md
```

---

### Phase 3: Penetration Testing (Sequential)

**Agent:**
- `@penetration-tester`

**Active Testing:**
- Attempts to exploit vulnerabilities found in Phase 1-2
- Tests authentication bypass techniques
- Performs privilege escalation attempts
- Assesses blast radius of successful exploits

**Safety Constraints:**
- Read-only testing (no destructive actions)
- No DoS attacks
- No data exfiltration

**Output:**
```
Phase 3 Complete (50 minutes)
- @penetration-tester: 3 exploits confirmed (3 critical)

CRITICAL: 3 vulnerabilities are actively exploitable!
1. SQL injection → Full database access confirmed
2. JWT forgery → Authentication bypass successful
3. S3 bucket → PII data publicly accessible

Todos Created: 3 CRITICAL (total: 20)
Reports: .tresor/audit-2025-11-19/phase-3-penetration-tester.md
```

---

### Phase 4: Root Cause Analysis (Sequential, Conditional)

**Agent:**
- `@root-cause-analyzer` (only runs if Phase 1-3 found critical issues)

**Analyzes:**
- Root causes of critical vulnerabilities
- When/how vulnerabilities were introduced
- Systemic issues vs one-off problems
- Strategic fixes vs tactical patches

**Auto-Generates Expert Prompts:**
```bash
# For complex architectural fixes, auto-calls /prompt-create:
/prompt-create "Design zero-trust microservices architecture to replace vulnerable monolith"

# Output: ./prompts/001-zero-trust-architecture.md
# Suggests: @systems-architect, @backend-architect, @security-auditor
```

**Output:**
```
Phase 4 Complete (40 minutes)
- @root-cause-analyzer: Comprehensive RCA for 3 critical issues

Root Causes Identified:
1. SQL injection: Lack of input validation framework (architectural)
2. JWT forgery: Weak crypto library choice (design decision)
3. S3 exposure: Missing infrastructure-as-code review (process)

Expert Prompts Generated: 2
- 001-zero-trust-architecture.md (run: /prompt-run 001)
- 002-input-validation-framework.md (run: /prompt-run 002)

Todos Created: 0 (RCA is analysis, not actionable items)
Reports: .tresor/audit-2025-11-19/phase-4-root-cause-analyzer.md
```

---

## Final Output

### Consolidated Report

**Location:** `.tresor/audit-2025-11-19-143022/final-report.md`

**Contents:**
```markdown
# Security Audit Final Report

**Audit ID**: audit-2025-11-19-143022
**Duration**: 2h 45m
**Status**: Complete

## Executive Summary

- Total Findings: 20 (3 critical, 7 high, 8 medium, 2 low)
- Agents Invoked: 5
- Phases Completed: 4/4
- Todos Created: 20
- Expert Prompts Generated: 2

## Top 3 Critical Issues

1. SQL Injection in User API - src/api/users.ts:45-67
   - Exploitable: ✅ Confirmed
   - Impact: Full database access
   - Fix Time: ~4 hours
   - Todo: #audit-001

2. JWT Forgery Vulnerability - config/auth.js:12
   - Exploitable: ✅ Confirmed
   - Impact: Authentication bypass
   - Fix Time: ~2 hours
   - Todo: #audit-002

3. Public S3 Bucket Exposure - infrastructure/s3.tf:34
   - Exploitable: ✅ Confirmed
   - Impact: PII data leak
   - Fix Time: ~1 hour
   - Todo: #audit-003

## Remediation Roadmap

### Week 1 (Immediate)
- [ ] Fix SQL injection (#audit-001) - 4h
- [ ] Update JWT signing (#audit-002) - 2h
- [ ] Encrypt S3 bucket (#audit-003) - 1h

### Week 2-4 (Short-term)
- [ ] Implement input validation framework - 16h
- [ ] Review all auth flows - 8h
- [ ] Run /prompt-run 001 (zero-trust architecture) - 40h

### Month 2-3 (Long-term)
- [ ] Implement zero-trust architecture - 120h
- [ ] Establish security testing in CI/CD - 24h
- [ ] Quarterly security audits - ongoing

## Next Steps

1. Run `/todo-check` to review and select todos
2. Fix 3 critical issues immediately (7 hours total)
3. Execute expert prompts: `/prompt-run 001`, `/prompt-run 002`
4. Schedule follow-up audit in 90 days
```

---

## Example Workflows

### Workflow 1: First-Time Security Audit

```bash
# Step 1: Run comprehensive audit
/audit

# Step 2: Review findings
cat .tresor/audit-2025-11-19/final-report.md

# Step 3: Check and prioritize todos
/todo-check
# → Select critical todo
# → System suggests @security-auditor
# → Invoke agent to fix

# Step 4: Execute expert prompts for architectural fixes
/prompt-run 001  # Zero-trust architecture
/prompt-run 002  # Input validation framework

# Step 5: Verify fixes
/audit --scope security  # Run focused re-audit
```

---

### Workflow 2: Focused Infrastructure Audit

```bash
# Infrastructure-only audit (faster)
/audit --scope infrastructure

# Review findings
/todo-check
# → 5 infrastructure todos created

# Fix infrastructure issues
# [Work on todos]

# Verify fixes
/audit --scope infrastructure  # Re-audit infrastructure
```

---

### Workflow 3: CI/CD Integration

```bash
# Run audit with JSON output
/audit --report-format json --parallel-max 1

# Parse JSON output in CI/CD pipeline
# Fail build if critical findings exist

# Example JSON output:
{
  "auditId": "audit-2025-11-19-143022",
  "status": "complete",
  "summary": {
    "total": 20,
    "critical": 3,
    "high": 7,
    "medium": 8,
    "low": 2
  },
  "findings": [...],
  "reports": [...]
}
```

---

### Workflow 4: Multi-Session Audit

```bash
# Day 1: Start audit (runs Phase 1-2, then pause)
/audit

# After Phase 2, need to pause
/handoff-create  # Save session context

# Day 2: Resume audit from Phase 3
/audit --resume --report-id audit-2025-11-19-143022

# Completes Phase 3-4 with full context from Day 1
```

---

## Integration with Tresor Workflow

### Automatic `/todo-add` Integration

Every finding with severity `critical` or `high` automatically creates a todo:

```markdown
## Security Audit Findings - 2025-11-19 14:30

- **Fix SQL injection vulnerability** - User input not sanitized before database query. **Problem:** Attacker can execute arbitrary SQL. **Files:** src/api/users.ts:45-67. **Solution:** Use parameterized queries or ORM.

- **Upgrade vulnerable dependency** - react-router-dom has known XSS vulnerability. **Problem:** CVE-2024-12345 rated 8.5/10. **Files:** package.json:23. **Solution:** Upgrade to v6.4.1+.
```

### Automatic `/prompt-create` Integration

Complex architectural issues trigger expert prompt generation:

```bash
# Auto-generated prompt for zero-trust architecture
./prompts/001-zero-trust-architecture.md

# Prompt content:
<objective>
Design and implement zero-trust microservices architecture to replace vulnerable monolithic application.

Security requirements from audit:
- Eliminate SQL injection via API gateway + input validation
- Implement mutual TLS between services
- Deploy service mesh for end-to-end encryption
- Use short-lived tokens (JWT → OAuth2 + refresh tokens)
</objective>

<suggested_agents>
- @systems-architect (primary - overall architecture)
- @backend-architect (microservices decomposition)
- @security-auditor (zero-trust validation)
- @cloud-architect (infrastructure security)
</suggested_agents>

# Run with:
/prompt-run 001
```

### `/todo-check` for Remediation

After audit completes, use `/todo-check` for systematic remediation:

```bash
/todo-check

# Output:
Outstanding Todos:

1. [CRITICAL] Fix SQL injection in user API (audit-2025-11-19)
   → Suggested: @security-auditor (confidence: 95%)

2. [CRITICAL] Update JWT signing algorithm (audit-2025-11-19)
   → Suggested: @auth-security-specialist (confidence: 92%)

3. [HIGH] Upgrade react-router-dom (audit-2025-11-19)
   → Suggested: @dependency-auditor (confidence: 90%)

Reply with the number of the todo you'd like to work on.
```

---

## Command Options

### `--scope` (Security Scope)

**Options:** `security`, `compliance`, `infrastructure`, `all` (default: `all`)

```bash
/audit --scope security        # OWASP Top 10, dependencies, auth
/audit --scope compliance      # GDPR, SOC2, HIPAA compliance
/audit --scope infrastructure  # Cloud, containers, network security
/audit --scope all             # Complete audit (all scopes)
```

### `--parallel-max` (Parallel Agent Limit)

**Options:** `1`, `2`, `3` (default: `3`)

```bash
/audit --parallel-max 3  # Maximum speed (3 agents in Phase 1)
/audit --parallel-max 2  # Moderate (2 agents in Phase 1)
/audit --parallel-max 1  # Maximum safety (sequential only)
```

### `--report-format` (Output Format)

**Options:** `markdown`, `json` (default: `markdown`)

```bash
/audit --report-format markdown  # Human-readable reports
/audit --report-format json      # Machine-parseable (CI/CD)
```

### `--resume` (Resume Previous Audit)

```bash
/audit --resume --report-id audit-2025-11-19-143022
```

Resumes from last completed phase, loading full context.

---

## Technical Details

### Agent Selection Algorithm

```javascript
function selectAgents(techStack, scope) {
  // Phase 1: Always include @security-auditor
  const phase1 = ['@security-auditor'];

  // Add language-specific security experts
  if (techStack.languages.includes('javascript'))
    phase1.push('@javascript-security-expert');

  if (techStack.frameworks.includes('react'))
    phase1.push('@react-security-specialist');

  // Add dependency auditor
  phase1.push('@dependency-auditor');

  // Limit to top 3 by confidence score
  return phase1.slice(0, 3);
}
```

### Dependency Verification

Before parallel execution, verifies:
- ✅ No two agents write to the same file
- ✅ No agent reads what another agent writes
- ✅ No data dependencies between agents

If conflicts detected, prompts user to run sequentially.

---

## Supported Technologies

### Languages
- JavaScript, TypeScript, Python, Java, Go, Rust, C#, PHP, Ruby

### Frameworks
- **Frontend:** React, Vue, Angular, Svelte
- **Backend:** Express, NestJS, Django, Flask, Spring Boot, Rails

### Databases
- PostgreSQL, MySQL, MongoDB, Redis, Cassandra, DynamoDB

### Infrastructure
- Docker, Kubernetes, Terraform, CloudFormation
- AWS, Azure, GCP

### Authentication
- JWT, OAuth2, SAML, session-based

### APIs
- REST, GraphQL, gRPC, WebSocket

---

## FAQ

### Q: How long does an audit take?

**A:** Typically 2-4 hours for comprehensive audit (all scopes). Focused audits (single scope) take 30-90 minutes.

### Q: Can I run audits in CI/CD?

**A:** Yes! Use `--report-format json` and `--parallel-max 1` for deterministic, CI-friendly output.

### Q: What if audit takes too long?

**A:** Use `/handoff-create` to save context, then `/audit --resume` in next session.

### Q: How do I fix findings?

**A:** Use `/todo-check` to review findings, system suggests optimal agents for each fix.

### Q: Can I customize agent selection?

**A:** Yes, select "Modify agent selection" during confirmation prompt.

---

## Troubleshooting

### Issue: "Dependency conflicts detected"

**Cause:** Two agents would write to same file or have data dependencies

**Solution:**
```bash
# Run with sequential execution
/audit --parallel-max 1
```

---

### Issue: Audit incomplete (timeout)

**Cause:** Agent taking longer than expected

**Solution:**
```bash
# Save current state
/handoff-create

# Resume in new session
/audit --resume --report-id [audit-id]
```

---

### Issue: Missing agents for tech stack

**Cause:** Tech stack not detected or no matching agents

**Solution:**
- Manually review detected tech stack during confirmation
- Select "Modify agent selection" to manually choose agents

---

## See Also

- **[Security Auditor Agent](../../subagents/core/security-auditor/)** - Core security agent
- **[Penetration Tester Agent](../../subagents/engineering/security/penetration-tester/)** - Exploit testing
- **[Compliance Officer Agent](../../subagents/leadership/compliance-officer/)** - Regulatory compliance
- **[Root Cause Analyzer](../../subagents/core/root-cause-analyzer/)** - Comprehensive RCA

---

**Version:** 2.7.0
**Last Updated:** November 19, 2025
**Category:** Security
**License:** MIT
**Author:** Alireza Rezvani
