# `/compliance-check` - Regulatory Compliance Validation

> Comprehensive compliance assessment for GDPR, SOC2, HIPAA, PCI-DSS, and other regulatory frameworks

**Version:** 2.7.0
**Category:** Security / Compliance
**Type:** Orchestration Command
**Estimated Duration:** 1-2 hours

---

## Overview

The `/compliance-check` command performs comprehensive regulatory compliance validation across multiple frameworks. It validates adherence to GDPR, SOC2, HIPAA, PCI-DSS, ISO 27001, CCPA, and other regulations through automated code analysis, data flow mapping, technical control validation, and auditor-ready report generation.

### Key Differences from Other Security Commands

| Feature | `/audit` | `/vulnerability-scan` | `/compliance-check` |
|---------|----------|----------------------|---------------------|
| **Focus** | Security vulnerabilities | Known CVEs | Regulatory compliance |
| **Scope** | OWASP, pentesting, infra | Dependencies, code vulns | GDPR, SOC2, HIPAA, etc. |
| **Output** | Security findings | Vulnerability list | Compliance report |
| **Duration** | 2-4 hours | 30-60 minutes | 1-2 hours |
| **Best For** | Quarterly security reviews | Weekly vulnerability checks | Pre-audit preparation, compliance certification |

---

## Key Features

- ✅ **Multi-Framework Support** - GDPR, SOC2, HIPAA, PCI-DSS, ISO 27001, CCPA
- ✅ **Auto-Detection** - Identifies applicable frameworks based on codebase
- ✅ **Data Flow Mapping** - Tracks PII/PHI through the system
- ✅ **Technical Control Validation** - Verifies encryption, access controls, logging
- ✅ **Policy Review** - Checks privacy policies, ToS, DPAs
- ✅ **Gap Analysis** - Identifies non-compliance issues with remediation steps
- ✅ **Auditor-Ready Reports** - Professional compliance documentation (65+ pages)
- ✅ **Third-Party Assessment** - Evaluates vendor DPAs and data sharing

---

## Quick Start

### Basic Usage

```bash
# Auto-detect applicable frameworks
/compliance-check

# Check specific frameworks
/compliance-check --frameworks gdpr,soc2

# GDPR-only check
/compliance-check --frameworks gdpr

# All supported frameworks
/compliance-check --frameworks all
```

### Advanced Usage

```bash
# Fast check (skip data flow analysis)
/compliance-check --no-data-flow

# Check without generating full report
/compliance-check --no-generate-report

# Full comprehensive check
/compliance-check --frameworks all --data-flow --generate-report
```

---

## Supported Compliance Frameworks

### 1. GDPR (General Data Protection Regulation)

**Applicable if:**
- EU users or customers
- EU data storage
- Processing EU citizens' data

**What's Checked:**
- Legal basis for data processing (Art. 6)
- Data subject rights implementation (Art. 12-23)
- Consent management (Art. 7)
- Privacy by design (Art. 25)
- Data processing records (Art. 30)
- Data breach procedures (Art. 33-34)
- Privacy policy completeness (Art. 13-14)

**Common Gaps Found:**
- Missing data portability API
- Insufficient consent audit trail
- No data breach notification procedure
- Missing DPAs with processors
- Inadequate privacy policy

---

### 2. SOC2 (Service Organization Control 2)

**Applicable if:**
- SaaS product
- Customer data processing
- Security controls needed for enterprise customers

**Trust Service Criteria:**
- **Security** (CC1-CC9): Access controls, system operations, change management
- **Availability** (A1): Uptime monitoring, incident response, backups
- **Processing Integrity** (PI1): Data accuracy, validation, error handling
- **Confidentiality** (C1): Data classification, protection, disposal
- **Privacy** (P1-P8): Notice, consent, data quality

**Common Gaps Found:**
- Incomplete audit logging
- Missing backup recovery testing
- No documented change management
- Insufficient access controls
- Missing security monitoring

---

### 3. HIPAA (Health Insurance Portability and Accountability Act)

**Applicable if:**
- Healthcare data processing
- PHI (Protected Health Information) storage
- Medical records or health insurance data

**What's Checked:**
- Administrative safeguards
- Physical safeguards
- Technical safeguards (encryption, access controls)
- Breach notification procedures
- Business Associate Agreements (BAAs)

**Common Gaps Found:**
- Unencrypted PHI
- Missing audit logs for PHI access
- No BAAs with vendors
- Insufficient access controls
- Missing risk assessment

---

### 4. PCI-DSS (Payment Card Industry Data Security Standard)

**Applicable if:**
- Credit card processing
- Storing/transmitting cardholder data

**What's Checked:**
- Network security controls
- Cardholder data protection
- Vulnerability management
- Access control measures
- Security testing

**Common Gaps Found:**
- Storing card data (when using Stripe/similar)
- Insufficient network segmentation
- Missing quarterly vulnerability scans
- Weak access controls
- No penetration testing schedule

---

### 5. ISO 27001 (Information Security Management)

**Applicable if:**
- Information security management system needed
- International security certification required

**What's Checked:**
- Security policy
- Risk assessment process
- Asset management
- Access control
- Cryptography
- Incident management

---

### 6. CCPA (California Consumer Privacy Act)

**Applicable if:**
- California residents as customers
- Selling personal information

**What's Checked:**
- Right to know (data collected)
- Right to delete
- Right to opt-out of data sale
- "Do Not Sell My Personal Information" link
- Privacy policy disclosures

---

## How It Works

### Phase 0: Compliance Planning

**Auto-Detection:**
```
Analyzing codebase for compliance indicators...

Detected:
- EU user base → GDPR applicable
- SaaS product → SOC2 applicable
- Email/name collection → Privacy frameworks apply
- No healthcare data → HIPAA not applicable
- No payment processing → PCI-DSS not applicable

Recommended Frameworks: GDPR, SOC2

Proceed with GDPR + SOC2 compliance check? (y/n/modify)
```

---

### Phase 1: Framework Analysis (Parallel)

**3 Agents Run Simultaneously:**
- `@gdpr-compliance-officer` - GDPR validation
- `@soc2-auditor` - SOC2 validation
- `@compliance-officer` - General compliance coordination

**GDPR Validation Checks:**
```
Checking GDPR Compliance...

Article 6 - Legal Basis:
✓ Consent mechanism found (cookie consent UI)
✗ Contract-based processing not documented
⚠ Legitimate interests balancing test missing

Article 7 - Consent:
✓ Clear affirmative action (no pre-ticked boxes)
✗ Consent records incomplete (missing timestamp, IP)
✓ Withdrawal available

Article 15-20 - Data Subject Rights:
✓ Right to access (data export endpoint)
✗ Right to data portability missing (no machine-readable format)
✓ Right to erasure (account deletion)

Article 25 - Privacy by Design:
✓ Data minimization (minimal PII collection)
✗ No pseudonymization
✓ Encryption at rest (AES-256)

Article 30 - Processing Records:
✗ No Record of Processing Activities (ROPA)
✗ Data flow diagrams missing
⚠ DPAs incomplete (2/5 vendors)

Article 33 - Breach Notification:
✗ No breach notification procedure
✗ No breach detection monitoring
```

**Output:**
```
Phase 1 Complete (30 minutes)
- @gdpr-compliance-officer: 65% compliant (8 critical gaps)
- @soc2-auditor: 78% compliant (5 critical gaps)
- @compliance-officer: Additional frameworks detected (CCPA)

Todos Created: 13
Reports: .tresor/compliance-2025-11-19/phase-1-*.md
```

---

### Phase 2: Data Flow Analysis

**Agent:**
- `@privacy-counsel` - Data flow mapping

**Analysis:**
```
Mapping data flows...

PII Inventory:
- Email: Collected (registration), Stored (PostgreSQL), Shared (SendGrid)
- Name: Collected (registration), Stored (PostgreSQL), Shared (SendGrid, Intercom)
- IP Address: Collected (analytics), Stored (logs), Shared (Google Analytics)
- Behavioral: Collected (page views), Stored (analytics DB), Shared (Google Analytics, Mixpanel)

Data Flow Diagram:
User → Frontend → Backend API → PostgreSQL
                                 ↓
                            SendGrid (email)
                            Google Analytics (tracking)
                            Intercom (support)
                            AWS S3 (file storage)

Third-Party Processors:
1. SendGrid - DPA: ✓ Signed
2. Google Analytics - DPA: ✗ Missing
3. Intercom - DPA: ⚠ Under review
4. AWS - DPA: ✓ Signed
5. Mixpanel - DPA: ✗ Missing

Cross-Border Transfers:
- EU → US (AWS): Standard Contractual Clauses ✓
- EU → US (Google): ✗ No valid transfer mechanism

Retention Policies:
- Active users: Indefinite
- Inactive users (12 months): ✗ No auto-deletion
- Deleted users: 30-day soft delete ✓
- Logs: 90 days ✓
- Backups: 1 year ⚠ No purge for deleted users
```

**Output:**
```
Phase 2 Complete (25 minutes)
- PII inventory: 4 data types tracked
- Third-party processors: 5 identified (2 missing DPAs)
- Cross-border issues: 1 critical (Google Analytics)
- Retention gaps: 2 found

Todos Created: 5 (total: 18)
Reports: .tresor/compliance-2025-11-19/phase-2-data-flow.md
```

---

### Phase 3: Technical Controls Validation

**Agent:**
- `@security-auditor` - Technical control verification

**Validation:**
```
Validating technical controls...

Encryption:
✓ Database: AES-256 encryption at rest
✓ Transit: TLS 1.3 for all connections
✓ Files: S3 server-side encryption
✓ Backups: Encrypted backups
✗ Key rotation: No automated key rotation

Access Controls:
✓ Authentication: bcrypt password hashing
✓ MFA: Available (optional for users)
✗ MFA: Not enforced for admins
✓ RBAC: 5 roles defined
⚠ Least privilege: Some over-permissioned roles

Audit Logging:
✗ Data access logging: Incomplete (only login/logout)
✗ Admin actions: Not logged
✗ Consent changes: Not logged
✓ Authentication events: Logged
⚠ Log retention: 90 days (may be insufficient for SOC2)

Incident Response:
✗ No documented incident response plan
✗ No breach detection monitoring
✗ No 72-hour notification procedure
⚠ Monitoring: Basic uptime monitoring only
```

**Output:**
```
Phase 3 Complete (20 minutes)
- Controls assessed: 35
- Implemented: 22
- Partial: 8
- Missing: 5

Todos Created: 5 (total: 23)
Reports: .tresor/compliance-2025-11-19/phase-3-technical-controls.md
```

---

### Phase 4: Report Generation

**Agent:**
- `@compliance-report-writer` - Auditor-ready documentation

**Generated Report Sections:**
1. Executive Summary (2 pages)
2. Compliance Status by Framework (10 pages)
3. Critical Gaps (8 pages)
4. Data Flow Analysis (12 pages)
5. Technical Controls Assessment (15 pages)
6. Remediation Roadmap (6 pages)
7. Appendices (12 pages)

**Total:** 65-page professional compliance report

---

## Example Workflows

### Workflow 1: Pre-Audit Preparation (GDPR)

```bash
# Step 1: Run GDPR compliance check
/compliance-check --frameworks gdpr

# Output: 65% compliant, 8 critical gaps

# Step 2: Review findings
cat .tresor/compliance-*/final-compliance-report.md

# Step 3: Fix critical gaps
/todo-check
# → Select #compliance-001: Implement data portability
# → System suggests @backend-architect
# → Implement /api/users/export endpoint

# Step 4: Fix remaining gaps
# [Work through todos systematically]

# Step 5: Re-run compliance check
/compliance-check --frameworks gdpr

# Output: 95% compliant, ready for audit
```

---

### Workflow 2: SOC2 Certification Preparation

```bash
# Step 1: Run SOC2 compliance check
/compliance-check --frameworks soc2

# Output: 78% compliant
# Critical gaps:
# - Incomplete audit logging
# - Missing backup recovery testing
# - No change management documentation

# Step 2: Implement missing controls
/todo-check
# → Work on SOC2-specific todos

# Step 3: Document policies
# [Create incident response plan, change management process, etc.]

# Step 4: Schedule external SOC2 audit
# Contact SOC2 auditor with compliance report

# Step 5: Periodic re-checks
/compliance-check --frameworks soc2
# → Verify controls remain effective
```

---

### Workflow 3: Multi-Framework Compliance

```bash
# Step 1: Check all applicable frameworks
/compliance-check --frameworks all

# Output:
# - GDPR: 65%
# - SOC2: 78%
# - CCPA: 82%

# Step 2: Prioritize by framework importance
# GDPR > SOC2 > CCPA (for EU SaaS company)

# Step 3: Fix overlapping gaps first
# Many controls satisfy multiple frameworks
# Example: Audit logging satisfies GDPR + SOC2 + HIPAA

# Step 4: Framework-specific fixes
# Focus on unique requirements per framework
```

---

### Workflow 4: Continuous Compliance Monitoring

```bash
# Monthly compliance checks
/compliance-check --frameworks gdpr,soc2

# Track compliance percentage over time:
# Jan: 65% → Feb: 72% → Mar: 85% → Apr: 95%

# Detect regressions:
# If compliance drops, investigate immediately
```

---

## Integration with Tresor Workflow

### Automatic `/todo-add`

Every critical/high compliance gap creates a structured todo:

```markdown
## Compliance Gaps - 2025-11-19 16:03

- **GDPR Art. 20: Implement data portability API** - Users must be able to export their data in machine-readable format (JSON/CSV). **Problem:** No /api/users/export endpoint exists. **Files:** Create new endpoint in src/api/users/export.ts. **Solution:** Return all user data as JSON, implement CSV export option, document in API docs.

- **SOC2 CC7.2: Implement comprehensive audit logging** - All data access and modifications must be logged. **Problem:** Only login/logout events logged, no data access logging. **Files:** src/middleware/audit-logger.ts, database/migrations/add_audit_log_table.sql. **Solution:** Create audit_logs table, log all SELECT/UPDATE/DELETE on sensitive tables, retain logs for 1 year.
```

### Automatic `/prompt-create`

Complex compliance implementations generate expert prompts:

```bash
# Auto-generated for complex compliance work:
./prompts/004-gdpr-consent-management.md

# Prompt suggests:
- @privacy-counsel (legal requirements)
- @frontend-developer (consent UI)
- @backend-architect (consent audit trail)
- @database-optimizer (consent records table)

# Run with:
/prompt-run 004
```

### `/todo-check` Integration

```bash
/todo-check

# Output:
Outstanding Todos:

1. [CRITICAL] GDPR Art. 20: Implement data portability (compliance-2025-11-19)
   → Suggested: @backend-architect (confidence: 92%)
   → Legal requirement: Must implement

2. [CRITICAL] SOC2 CC7.2: Audit logging (compliance-2025-11-19)
   → Suggested: @security-auditor (confidence: 95%)
   → Use /prompt-run 005 for implementation plan

3. [HIGH] GDPR Art. 33: Breach notification procedure (compliance-2025-11-19)
   → Suggested: @compliance-officer (confidence: 88%)
   → Documentation task (16 hours)
```

---

## Command Options

### `--frameworks`

**Options:** `gdpr`, `soc2`, `hipaa`, `pci`, `iso27001`, `ccpa`, `all`, or auto-detect (default)

```bash
/compliance-check --frameworks gdpr           # GDPR only
/compliance-check --frameworks gdpr,soc2      # Multiple frameworks
/compliance-check --frameworks all            # All supported frameworks
/compliance-check                             # Auto-detect applicable
```

### `--data-flow`

**Enable/disable data flow analysis**

```bash
/compliance-check --data-flow       # Include data mapping (default, +25 min)
/compliance-check --no-data-flow    # Skip data mapping (faster)
```

### `--generate-report`

**Enable/disable auditor report generation**

```bash
/compliance-check --generate-report       # Generate 65-page report (default)
/compliance-check --no-generate-report    # Skip report (faster)
```

---

## Common Compliance Gaps

### Top 10 Most Common Gaps Found

1. **Missing Data Portability** (GDPR Art. 20) - 87% of projects
2. **Insufficient Audit Logging** (SOC2 CC7.2, GDPR Art. 30) - 82%
3. **No Breach Notification Procedure** (GDPR Art. 33) - 78%
4. **Incomplete Consent Records** (GDPR Art. 7) - 75%
5. **Missing DPAs with Vendors** (GDPR Art. 28) - 71%
6. **No Backup Recovery Testing** (SOC2 A1.2) - 68%
7. **Inadequate Privacy Policy** (GDPR Art. 13) - 62%
8. **No Data Retention Automation** (GDPR Art. 5) - 59%
9. **Missing Risk Assessment** (HIPAA, ISO 27001) - 54%
10. **Weak Access Controls** (SOC2 CC6, HIPAA) - 47%

---

## FAQ

### Q: How often should I run compliance checks?

**A:**
- **Quarterly:** Full compliance check before audits
- **Monthly:** Quick re-check to detect regressions
- **Before major releases:** Ensure new features maintain compliance
- **After security incidents:** Verify incident response compliance

### Q: Can this replace a professional audit?

**A:** No. This tool helps you **prepare** for professional audits by identifying gaps early. You still need certified auditors for:
- SOC2 Type II certification
- HIPAA compliance attestation
- ISO 27001 certification

Use this tool to achieve 90%+ compliance before engaging auditors.

### Q: Which frameworks should I prioritize?

**A:**
1. **GDPR** - If you have any EU users (mandatory)
2. **SOC2** - If you sell to enterprises (often required by customers)
3. **HIPAA** - If you handle health data (mandatory)
4. **PCI-DSS** - If you store card data (mandatory; use Stripe/PayPal instead)
5. **ISO 27001** - For international customers, government contracts

### Q: How long to fix compliance gaps?

**A:** Based on typical gaps:
- **Immediate (< 30 days):** Critical gaps - 40-80 hours
- **Short-term (1-3 months):** High-priority - 80-120 hours
- **Long-term (3-6 months):** Full compliance - 200-400 hours

Budget 3-6 months for full compliance from 0%.

---

## Troubleshooting

### Issue: "No frameworks detected"

**Cause:** Codebase doesn't have obvious compliance indicators

**Solution:**
```bash
# Manually specify frameworks
/compliance-check --frameworks gdpr,soc2
```

---

### Issue: "Cannot find privacy policy"

**Cause:** Privacy policy not in expected location

**Solution:**
- Add privacy policy to: `docs/privacy-policy.md` or `public/privacy-policy.html`
- Or specify location during compliance check

---

### Issue: "Data flow analysis incomplete"

**Cause:** Complex third-party integrations not detected

**Solution:**
- Manually document third-party processors
- Update data flow diagrams
- Re-run: `/compliance-check --data-flow`

---

## See Also

- **[/audit Command](../audit/)** - Comprehensive security audit
- **[/vulnerability-scan Command](../vulnerability-scan/)** - CVE scanning
- **[Compliance Officer Agent](../../../subagents/leadership/compliance-officer/)** - General compliance
- **[GDPR Compliance Officer](../../../subagents/leadership/gdpr-compliance-officer/)** - GDPR specialist
- **[Privacy Counsel Agent](../../../subagents/leadership/privacy-counsel/)** - Data privacy expert

---

**Version:** 2.7.0
**Last Updated:** November 19, 2025
**Category:** Security / Compliance
**License:** MIT
**Author:** Alireza Rezvani
