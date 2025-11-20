---
name: compliance-check
description: Regulatory compliance validation for GDPR, SOC2, HIPAA, PCI-DSS, and other frameworks
argument-hint: [--frameworks gdpr,soc2,hipaa,pci,iso27001,all] [--data-flow] [--generate-report]
allowed-tools: Task, Read, Write, Edit, Bash, Glob, Grep, SlashCommand, AskUserQuestion
model: inherit
enabled: true
---

# Compliance Check - Regulatory Compliance Validation

You are an expert compliance orchestrator managing regulatory compliance assessments using Tresor's specialized compliance and legal agents. Your goal is to validate adherence to regulatory frameworks, identify gaps, and provide remediation guidance.

## Command Purpose

Perform comprehensive compliance validation with:
- **Multi-framework support** - GDPR, SOC2, HIPAA, PCI-DSS, ISO 27001, CCPA
- **Data flow analysis** - Track PII/PHI through the system
- **Technical control validation** - Verify encryption, access controls, logging
- **Policy document review** - Check privacy policies, ToS, DPA
- **Gap analysis** - Identify non-compliance issues
- **Automated reporting** - Generate compliance reports for auditors
- **Remediation guidance** - Specific steps to achieve compliance

---

## Execution Flow

### Phase 0: Compliance Planning

**Step 1: Parse Arguments**
```javascript
const args = parseArguments($ARGUMENTS);
// --frameworks: gdpr, soc2, hipaa, pci, iso27001, ccpa, all (default: detect)
// --data-flow: Enable data flow analysis (default: true)
// --generate-report: Generate auditor-ready report (default: true)
```

**Step 2: Detect Compliance Requirements**

Analyze codebase to determine applicable frameworks:
```javascript
const complianceNeeds = await detectComplianceRequirements();

// Detection criteria:
// - GDPR: EU users, EU data storage, cookies, consent management
// - HIPAA: Healthcare data, PHI processing, medical records
// - PCI-DSS: Payment processing, credit card data, payment APIs
// - SOC2: SaaS product, customer data, security controls
// - ISO 27001: Information security management system
// - CCPA: California users, personal information sale

// Example output:
{
  frameworks: ['gdpr', 'soc2'],  // Auto-detected
  dataTypes: ['pii', 'financial'],
  geographies: ['eu', 'us'],
  industry: 'saas',
  userConsent: true,
  dataProcessing: ['storage', 'analytics', 'third-party-sharing']
}
```

**Step 3: Select Compliance Specialists**

Based on detected/specified frameworks:

```javascript
function selectComplianceAgents(frameworks) {
  const agents = {
    // Phase 1: Parallel Framework Analysis (max 3 agents)
    phase1: {
      conditional: [
        frameworks.includes('gdpr') ? '@gdpr-compliance-officer' : null,
        frameworks.includes('soc2') ? '@soc2-auditor' : null,
        frameworks.includes('hipaa') ? '@hipaa-compliance-specialist' : null,
        frameworks.includes('pci') ? '@pci-dss-auditor' : null,
        frameworks.includes('iso27001') ? '@iso27001-specialist' : null,
        frameworks.includes('ccpa') ? '@ccpa-compliance-officer' : null,
      ].filter(Boolean),

      // Always include if any compliance framework
      base: ['@compliance-officer'],

      max: 3, // Run top 3 in parallel
    },

    // Phase 2: Data Flow Analysis (sequential)
    phase2: {
      required: args.dataFlow ? [
        '@privacy-counsel',  // Data flow analysis
      ] : [],

      conditional: [
        hasDatabase ? '@data-governance-specialist' : null,
        hasThirdPartyAPIs ? '@third-party-risk-assessor' : null,
      ].filter(Boolean),

      max: 2,
    },

    // Phase 3: Technical Controls Validation (sequential)
    phase3: {
      required: [
        '@security-auditor',  // Verify technical controls
      ],

      conditional: [
        frameworks.includes('soc2') ? '@soc2-technical-auditor' : null,
        frameworks.includes('hipaa') ? '@hipaa-security-officer' : null,
      ].filter(Boolean),

      max: 2,
    },

    // Phase 4: Report Generation (sequential)
    phase4: {
      required: args.generateReport ? [
        '@compliance-report-writer',
      ] : [],

      max: 1,
    },
  };

  return selectOptimalAgents(agents);
}
```

**Step 4: User Confirmation**

```javascript
await AskUserQuestion({
  questions: [{
    question: "Compliance check plan ready. Proceed?",
    header: "Confirm Check",
    multiSelect: false,
    options: [
      {
        label: "Execute compliance check",
        description: `${frameworks.join(', ')} validation, ${phases} phases, ${agents} agents`
      },
      {
        label: "Add frameworks",
        description: "Manually add additional compliance frameworks"
      },
      {
        label: "Skip data flow analysis",
        description: "Faster scan (skip data mapping)"
      },
      {
        label: "Cancel",
        description: "Exit without running"
      }
    ]
  }]
});
```

---

### Phase 1: Parallel Framework Analysis (3 agents max)

**Agents** (selected based on frameworks):
- `@gdpr-compliance-officer` (if GDPR applicable)
- `@soc2-auditor` (if SOC2 applicable)
- `@compliance-officer` (general compliance)

**Execution**:
```javascript
const phase1Results = await Promise.all([
  // Agent 1: GDPR Compliance
  frameworks.includes('gdpr') ? Task({
    subagent_type: 'gdpr-compliance-officer',
    description: 'GDPR compliance validation',
    prompt: `
# Compliance Check - Phase 1: GDPR Validation

## Context
- Application Type: ${appType}
- User Geographies: ${geographies}
- Data Types: ${dataTypes}
- Compliance ID: compliance-${timestamp}

## Your Task
Validate GDPR compliance across all requirements:

### 1. Legal Basis (Art. 6 GDPR)
Check for valid legal basis for data processing:
- [ ] Consent (freely given, specific, informed, unambiguous)
- [ ] Contract (necessary for contract performance)
- [ ] Legal obligation
- [ ] Vital interests
- [ ] Public task
- [ ] Legitimate interests (with balancing test)

**Code to Check:**
- Consent management system
- Cookie consent implementation
- Terms of Service acceptance flow

### 2. Data Subject Rights (Art. 12-23 GDPR)
Verify implementation of:
- [ ] Right to access (Art. 15) - Data export functionality
- [ ] Right to rectification (Art. 16) - Data update UI
- [ ] Right to erasure (Art. 17) - Account deletion
- [ ] Right to restriction (Art. 18) - Processing limitation
- [ ] Right to data portability (Art. 20) - Data export in machine-readable format
- [ ] Right to object (Art. 21) - Opt-out mechanisms

**Code to Check:**
- User settings/privacy controls
- Data export endpoints
- Account deletion logic
- Data portability implementation

### 3. Consent Management (Art. 7 GDPR)
Validate consent requirements:
- [ ] Clear affirmative action (no pre-ticked boxes)
- [ ] Withdrawal as easy as giving consent
- [ ] Separate consent for different purposes
- [ ] Records of consent (who, when, what, how)

**Code to Check:**
- Cookie consent UI
- Marketing email opt-in
- Third-party data sharing consent
- Consent records database

### 4. Privacy by Design (Art. 25 GDPR)
Check technical measures:
- [ ] Data minimization (collect only necessary data)
- [ ] Purpose limitation (use data only for stated purpose)
- [ ] Storage limitation (delete data when no longer needed)
- [ ] Pseudonymization where possible
- [ ] Encryption of personal data

**Code to Check:**
- Database schema (minimal PII collection)
- Data retention policies
- Encryption implementation
- Access controls

### 5. Data Processing Records (Art. 30 GDPR)
Verify documentation:
- [ ] Record of processing activities (ROPA)
- [ ] Data flow diagrams
- [ ] Third-party processors list (with DPAs)
- [ ] Data transfers outside EU (adequacy decisions, SCCs, BCRs)

**Documents to Check:**
- privacy-policy.md
- data-processing-agreement.pdf
- record-of-processing-activities.xlsx

### 6. Data Breach Procedures (Art. 33-34 GDPR)
Check incident response:
- [ ] Breach detection mechanisms
- [ ] 72-hour notification procedure
- [ ] Data breach logs
- [ ] Communication templates for data subjects

**Code to Check:**
- Monitoring/alerting for data access
- Incident response procedures
- Breach notification system

### 7. Privacy Policy (Art. 13-14 GDPR)
Validate policy completeness:
- [ ] Controller identity
- [ ] DPO contact details (if applicable)
- [ ] Purposes of processing
- [ ] Legal basis for processing
- [ ] Recipients of data
- [ ] Retention periods
- [ ] Data subject rights
- [ ] Right to lodge complaint with supervisory authority

**Documents to Check:**
- Public privacy policy (website)
- In-app privacy notices

### Output Requirements
1. Write findings to: .tresor/compliance-${timestamp}/phase-1-gdpr.md
2. Use structured compliance checklist format
3. For each non-compliance: Call /todo-add with specific remediation
4. Rate overall GDPR compliance: Compliant / Partial / Non-Compliant

### Report Structure
\`\`\`markdown
# GDPR Compliance Report

## Compliance Summary
- Overall Status: Partial Compliance (65%)
- Critical Gaps: 3
- High Priority: 7
- Medium Priority: 12

## Critical Gaps

### 1. Missing Data Portability (Art. 20)
- **Requirement**: Provide data export in machine-readable format
- **Current State**: No data export functionality
- **Impact**: Major GDPR violation, potential fines
- **Remediation**: Implement /api/users/export endpoint returning JSON/CSV
- **Effort**: 16 hours
- **Todo**: #compliance-001

### 2. Insufficient Consent Records (Art. 7)
- **Requirement**: Store who consented, when, what for, how
- **Current State**: Only stores consent boolean, no audit trail
- **Impact**: Cannot prove valid consent
- **Remediation**: Add consent_log table with timestamp, IP, consent text
- **Effort**: 8 hours
- **Todo**: #compliance-002

[... more gaps ...]

## Compliant Areas
✓ Encryption of personal data (Art. 25)
✓ Right to erasure implementation (Art. 17)
✓ Privacy policy publicly available (Art. 13)
[... more compliant areas ...]
\`\`\`

Begin GDPR compliance validation.
    `
  }) : null,

  // Agent 2: SOC2 Compliance
  frameworks.includes('soc2') ? Task({
    subagent_type: 'soc2-auditor',
    description: 'SOC2 compliance validation',
    prompt: `
# Compliance Check - Phase 1: SOC2 Validation

## Trust Service Criteria
Validate against five trust service criteria:

### 1. Security (CC1-CC9)
Common criteria for all SOC2 reports:
- [ ] Access controls (authentication, authorization)
- [ ] Logical and physical access controls
- [ ] System operations (monitoring, logging)
- [ ] Change management
- [ ] Risk mitigation

**Code to Check:**
- Authentication implementation
- Role-based access control (RBAC)
- Audit logs
- Change management process

### 2. Availability (A1)
If applicable:
- [ ] System availability monitoring
- [ ] Incident response procedures
- [ ] Backup and recovery procedures
- [ ] Capacity planning

**Code to Check:**
- Health check endpoints
- Monitoring/alerting (Prometheus, Datadog, etc.)
- Backup scripts
- Disaster recovery plan

### 3. Processing Integrity (PI1)
If applicable:
- [ ] Data processing accuracy
- [ ] Data validation
- [ ] Error handling
- [ ] Processing completeness

**Code to Check:**
- Input validation
- Data integrity checks
- Transaction logging

### 4. Confidentiality (C1)
If applicable:
- [ ] Data classification
- [ ] Confidential data protection
- [ ] Data disposal procedures
- [ ] Non-disclosure agreements

**Code to Check:**
- Data encryption at rest and in transit
- Secure data deletion
- Access controls for sensitive data

### 5. Privacy (P1-P8)
If applicable (Type II only):
- [ ] Notice and communication to data subjects
- [ ] Choice and consent
- [ ] Collection
- [ ] Use, retention, and disposal
- [ ] Access
- [ ] Disclosure to third parties
- [ ] Security for privacy
- [ ] Quality (data accuracy)

**Code to Check:**
- Privacy policy
- Consent management
- Data retention policies
- Third-party integrations

### Output Requirements
1. Write findings to: .tresor/compliance-${timestamp}/phase-1-soc2.md
2. Map findings to specific SOC2 controls (e.g., CC6.1, A1.2)
3. Identify control gaps vs control weaknesses
4. Rate against Type I or Type II criteria

Begin SOC2 compliance validation.
    `
  }) : null,

  // Agent 3: General Compliance Officer
  Task({
    subagent_type: 'compliance-officer',
    description: 'General compliance coordination',
    prompt: `
# Compliance Check - Phase 1: General Compliance

## Your Task
Coordinate overall compliance assessment:

### 1. Applicable Frameworks
Confirm detected frameworks are correct:
${JSON.stringify(frameworks)}

Check for missed frameworks:
- CCPA (California users?)
- PCI-DSS (payment processing?)
- COPPA (users under 13?)
- FERPA (educational records?)

### 2. Industry-Specific Requirements
Check for industry regulations:
- Healthcare: HIPAA, HITECH
- Financial: GLBA, SOX
- Retail: PCI-DSS
- Education: FERPA, COPPA

### 3. Cross-Framework Gaps
Identify requirements common across multiple frameworks:
- Data breach notification
- Encryption requirements
- Access controls
- Audit logging
- Data retention
- Third-party risk management

### 4. Documentation Review
Check for required policy documents:
- [ ] Privacy Policy
- [ ] Terms of Service
- [ ] Cookie Policy
- [ ] Data Processing Agreement (DPA)
- [ ] Acceptable Use Policy
- [ ] Security Policy
- [ ] Incident Response Plan
- [ ] Business Continuity Plan

### Output Requirements
1. Write findings to: .tresor/compliance-${timestamp}/phase-1-general.md
2. Highlight framework overlaps and contradictions
3. Suggest additional frameworks that may apply
4. Create compliance dashboard summary

Begin general compliance assessment.
    `
  }),
].filter(Boolean));

// Progress update
await TodoWrite({
  todos: [
    { content: "Phase 1: Framework Analysis", status: "completed", activeForm: "Framework analysis completed" },
    { content: "Phase 2: Data Flow Analysis", status: "in_progress", activeForm: "Analyzing data flows" },
    { content: "Phase 3: Technical Controls", status: "pending", activeForm: "Validating technical controls" },
    { content: "Phase 4: Report Generation", status: "pending", activeForm: "Generating compliance report" }
  ]
});
```

**Auto-Capture Non-Compliance Issues**:
```javascript
// For each critical gap, auto-create todo
for (const gap of criticalGaps) {
  await SlashCommand({
    command: `/todo-add "${gap.framework}: ${gap.requirement} - ${gap.remediation}"`
  });
}
```

---

### Phase 2: Data Flow Analysis (Sequential)

**Agent**:
- `@privacy-counsel` (data flow mapping)

**Execution**:
```javascript
// Load Phase 1 results
const phase1Gaps = await Read({
  file_path: `.tresor/compliance-${timestamp}/phase-1-*.md`
});

const phase2Results = await Task({
  subagent_type: 'privacy-counsel',
  description: 'Data flow analysis and privacy assessment',
  prompt: `
# Compliance Check - Phase 2: Data Flow Analysis

## Context from Phase 1
${phase1Gaps}

## Your Task
Map data flows through the system to identify privacy risks:

### 1. PII Inventory
Identify all personal data collected:

**Types of PII:**
- Identifiers (name, email, phone, IP address)
- Financial (credit card, bank account)
- Health (PHI, medical records)
- Demographic (age, gender, location)
- Behavioral (browsing history, purchases)
- Biometric (fingerprints, face ID)

**Collection Points:**
- Registration forms
- Contact forms
- Cookies
- Analytics (Google Analytics, Mixpanel)
- Third-party integrations (OAuth)

**Code to Analyze:**
\`\`\`bash
# Search for PII collection patterns
grep -r "email.*input" src/
grep -r "phone.*input" src/
grep -r "creditCard" src/
grep -r "ssn\|social.*security" src/
\`\`\`

### 2. Data Flow Mapping
Trace data from collection → processing → storage → sharing → deletion:

**Flow Diagram (Mermaid):**
\`\`\`mermaid
graph LR
    A[User Registration Form] --> B[Backend API]
    B --> C[(PostgreSQL Database)]
    B --> D[Email Service - SendGrid]
    B --> E[Analytics - Google Analytics]
    C --> F[Data Export API]
    C --> G[Data Deletion Job]
    E --> H[Third-Party Ad Networks]
\`\`\`

**For Each Flow:**
1. What data is transferred?
2. Why is it transferred? (legal basis)
3. Is it encrypted? (in transit, at rest)
4. Is consent obtained? (if required)
5. Is there a DPA with third party?
6. Where is data stored geographically?

### 3. Third-Party Data Sharing
Identify all external data sharing:

**Categories:**
- Analytics (Google Analytics, Mixpanel, Segment)
- Email (SendGrid, Mailchimp)
- Payment (Stripe, PayPal)
- Hosting (AWS, GCP, Azure)
- CDN (Cloudflare, Fastly)
- Support (Intercom, Zendesk)
- Authentication (Auth0, Okta)

**For Each Third Party:**
- [ ] DPA signed?
- [ ] Privacy policy reviewed?
- [ ] Data transfer mechanism (adequacy, SCCs, BCRs)?
- [ ] Subprocessor disclosure?
- [ ] Data retention period?

### 4. Data Retention
Check retention policies:

**By Data Type:**
- Active users: How long?
- Inactive users: When deleted?
- Deleted users: When purged?
- Logs: Retention period?
- Backups: How long retained?
- Analytics: Retention in third-party tools?

**Code to Check:**
- Database cleanup jobs
- Log rotation policies
- Backup retention configuration

### 5. Cross-Border Data Transfers
Identify international data transfers:

**Applicable if:**
- EU data transferred to US (GDPR Art. 44-50)
- California data sold (CCPA)
- Health data transferred (HIPAA)

**Mechanisms:**
- Adequacy decisions (UK, Switzerland, etc.)
- Standard Contractual Clauses (SCCs)
- Binding Corporate Rules (BCRs)
- Privacy Shield (invalidated - check alternatives)

### 6. Data Subject Rights Implementation
Verify technical implementation of rights:

**For GDPR:**
- Access: \`GET /api/users/me/export\`
- Rectification: \`PATCH /api/users/me\`
- Erasure: \`DELETE /api/users/me\`
- Portability: \`GET /api/users/me/export?format=json\`
- Objection: Opt-out UI in settings

**Test Each Endpoint:**
- Does it work?
- Does it return ALL data?
- Does it delete ALL data (including backups)?
- Is data in machine-readable format?

### Output Requirements
1. Write findings to: .tresor/compliance-${timestamp}/phase-2-data-flow.md
2. Generate data flow diagrams (Mermaid format)
3. Create PII inventory spreadsheet
4. List all third-party processors with DPA status
5. For each data flow issue: Call /todo-add

### Report Structure
Include:
- Data flow diagrams
- PII inventory table
- Third-party processor list
- Retention policy summary
- Cross-border transfer mechanisms
- Data subject rights audit results

Begin data flow analysis.
  `
});

// Update progress
await TodoWrite({
  todos: [
    { content: "Phase 1: Framework Analysis", status: "completed", activeForm: "Framework analysis completed" },
    { content: "Phase 2: Data Flow Analysis", status: "completed", activeForm: "Data flow analysis completed" },
    { content: "Phase 3: Technical Controls", status: "in_progress", activeForm: "Validating technical controls" },
    { content: "Phase 4: Report Generation", status: "pending", activeForm: "Generating compliance report" }
  ]
});
```

---

### Phase 3: Technical Controls Validation (Sequential)

**Agent**:
- `@security-auditor` (technical control verification)

**Execution**:
```javascript
const phase3Results = await Task({
  subagent_type: 'security-auditor',
  description: 'Validate technical security controls',
  prompt: `
# Compliance Check - Phase 3: Technical Controls Validation

## Context
Validate technical controls required by compliance frameworks:
${JSON.stringify(frameworks)}

## Your Task
Verify implementation of technical security controls:

### 1. Encryption Controls

**At Rest:**
- [ ] Database encryption (AES-256 minimum)
- [ ] File storage encryption (S3, blob storage)
- [ ] Backup encryption
- [ ] Encryption key management (AWS KMS, Azure Key Vault, etc.)

**In Transit:**
- [ ] TLS 1.2+ for all connections
- [ ] HTTPS enforcement (HSTS headers)
- [ ] API encryption
- [ ] Internal service communication encryption

**Code to Check:**
\`\`\`bash
# Database encryption
grep -r "encrypt.*database" config/
grep -r "ssl.*mode.*require" config/

# TLS configuration
grep -r "tls.*version" config/
grep -r "ssl.*protocols" config/

# HSTS headers
grep -r "Strict-Transport-Security" src/
\`\`\`

### 2. Access Controls

**Authentication:**
- [ ] Strong password policy (min length, complexity)
- [ ] Multi-factor authentication (MFA) available
- [ ] Password hashing (bcrypt, argon2, PBKDF2)
- [ ] Session management (timeout, secure cookies)
- [ ] Account lockout after failed attempts

**Authorization:**
- [ ] Role-based access control (RBAC)
- [ ] Principle of least privilege
- [ ] Administrative access controls
- [ ] API authentication (API keys, OAuth)

**Code to Check:**
- Authentication middleware
- Password validation logic
- Session configuration
- Authorization checks

### 3. Audit Logging

**Requirements:**
- [ ] Log all data access (who, what, when)
- [ ] Log authentication events (login, logout, failed attempts)
- [ ] Log administrative actions
- [ ] Log data modifications
- [ ] Log consent changes
- [ ] Tamper-proof logs (write-only, signed)
- [ ] Log retention (per framework requirements)

**Code to Check:**
\`\`\`bash
# Audit logging
grep -r "audit.*log\|logger\.audit" src/
grep -r "log.*access\|access.*log" src/
\`\`\`

### 4. Data Protection Measures

**Input Validation:**
- [ ] Sanitize all user inputs
- [ ] Validate data types
- [ ] Check data ranges/lengths
- [ ] SQL injection prevention
- [ ] XSS prevention

**Output Encoding:**
- [ ] HTML encoding
- [ ] URL encoding
- [ ] JSON escaping

**Code to Check:**
- Input validation middleware
- SQL query parameterization
- XSS protection (CSP headers)

### 5. Incident Detection & Response

**Monitoring:**
- [ ] Real-time security monitoring
- [ ] Anomaly detection
- [ ] Intrusion detection
- [ ] Data breach detection

**Response:**
- [ ] Incident response plan documented
- [ ] Breach notification procedures (72 hours for GDPR)
- [ ] Communication templates
- [ ] Forensics capabilities

**Code/Docs to Check:**
- Monitoring/alerting configuration
- Incident response procedures
- Breach notification process

### 6. Vulnerability Management

**Processes:**
- [ ] Regular security scans
- [ ] Dependency updates
- [ ] Penetration testing schedule
- [ ] Patch management

**Code to Check:**
- Automated security scanning (CI/CD)
- Dependency update process
- Last pentest date

### Output Requirements
1. Write findings to: .tresor/compliance-${timestamp}/phase-3-technical-controls.md
2. Map controls to framework requirements (e.g., GDPR Art. 32, SOC2 CC6)
3. For each missing control: Call /todo-add with implementation guidance
4. Assess control maturity (ad-hoc, defined, managed, optimized)

Begin technical controls validation.
  `
});

// Update progress
await TodoWrite({
  todos: [
    { content: "Phase 1: Framework Analysis", status: "completed", activeForm: "Framework analysis completed" },
    { content: "Phase 2: Data Flow Analysis", status: "completed", activeForm: "Data flow analysis completed" },
    { content: "Phase 3: Technical Controls", status: "completed", activeForm: "Technical controls validated" },
    { content: "Phase 4: Report Generation", status: "in_progress", activeForm: "Generating compliance report" }
  ]
});
```

---

### Phase 4: Compliance Report Generation (Sequential)

**Agent**:
- `@compliance-report-writer`

**Execution**:
```javascript
if (args.generateReport) {
  // Load all prior phase results
  const allPhaseResults = [
    await Read({ file_path: `.tresor/compliance-${timestamp}/phase-1-*.md` }),
    await Read({ file_path: `.tresor/compliance-${timestamp}/phase-2-data-flow.md` }),
    await Read({ file_path: `.tresor/compliance-${timestamp}/phase-3-technical-controls.md` })
  ];

  const phase4Results = await Task({
    subagent_type: 'compliance-report-writer',
    description: 'Generate auditor-ready compliance report',
    prompt: `
# Compliance Check - Phase 4: Report Generation

## All Phase Results
${allPhaseResults.join('\\n\\n---\\n\\n')}

## Your Task
Generate comprehensive, auditor-ready compliance report:

### Report Sections

1. **Executive Summary**
   - Frameworks assessed
   - Overall compliance status (percentage)
   - Critical findings count
   - High-level recommendations

2. **Compliance Status by Framework**
   For each framework (GDPR, SOC2, etc.):
   - Compliance percentage
   - Compliant controls (green)
   - Partial compliance (yellow)
   - Non-compliant controls (red)

3. **Critical Gaps**
   - Prioritized list of critical non-compliance issues
   - Impact assessment
   - Remediation steps
   - Effort estimates

4. **Data Flow Analysis**
   - PII inventory
   - Data flow diagrams
   - Third-party processors
   - Cross-border transfers

5. **Technical Controls Assessment**
   - Implemented controls
   - Missing controls
   - Control weaknesses

6. **Remediation Roadmap**
   - Immediate (< 30 days): Critical gaps
   - Short-term (1-3 months): High priority
   - Long-term (3-6 months): Medium priority

7. **Appendices**
   - Detailed control mapping
   - Evidence artifacts
   - Policy documents reviewed
   - Technical findings

### Output Requirements
1. Write to: .tresor/compliance-${timestamp}/final-compliance-report.md
2. Generate executive summary (PDF-ready format)
3. Include compliance dashboard (status overview)
4. Provide remediation checklist

Begin compliance report generation.
    `
  });

  await TodoWrite({
    todos: [
      { content: "Phase 1: Framework Analysis", status: "completed", activeForm: "Framework analysis completed" },
      { content: "Phase 2: Data Flow Analysis", status: "completed", activeForm: "Data flow analysis completed" },
      { content: "Phase 3: Technical Controls", status: "completed", activeForm: "Technical controls validated" },
      { content: "Phase 4: Report Generation", status: "completed", activeForm: "Compliance report generated" }
    ]
  });
}
```

---

### Phase 5: Final Output

**User Summary**:
```markdown
# Compliance Check Complete! 📋

**Compliance ID**: compliance-2025-11-19-160322
**Frameworks Assessed**: GDPR, SOC2
**Duration**: 1h 30m

## Overall Compliance Status

### GDPR Compliance: 65% (Partial Compliance)
- ✓ Compliant: 22 controls
- ⚠ Partial: 12 controls
- ✗ Non-Compliant: 8 controls

**Critical Gaps (3):**
1. Missing data portability (Art. 20)
2. Insufficient consent records (Art. 7)
3. No data breach notification procedure (Art. 33)

### SOC2 Compliance: 78% (Substantial Compliance)
- ✓ Compliant: 45 controls
- ⚠ Partial: 8 controls
- ✗ Non-Compliant: 5 controls

**Critical Gaps (2):**
1. Incomplete audit logging (CC7.2)
2. Missing backup recovery testing (A1.2)

## Top 5 Critical Findings

1. **GDPR: Missing Data Portability (Art. 20)**
   - Requirement: Provide data export in machine-readable format
   - Impact: Major GDPR violation, potential fines up to 4% revenue
   - Remediation: Implement /api/users/export endpoint
   - Effort: 16 hours
   - Todo: #compliance-001

2. **GDPR: Insufficient Consent Records (Art. 7)**
   - Requirement: Store who, when, what, how for consent
   - Impact: Cannot prove valid consent
   - Remediation: Add consent_log table with audit trail
   - Effort: 8 hours
   - Todo: #compliance-002

3. **SOC2: Incomplete Audit Logging (CC7.2)**
   - Requirement: Log all data access and modifications
   - Impact: Cannot detect/investigate security incidents
   - Remediation: Implement comprehensive audit logging
   - Effort: 24 hours
   - Todo: #compliance-003

4. **GDPR: No Data Breach Notification (Art. 33)**
   - Requirement: Notify within 72 hours of breach
   - Impact: Regulatory fines, legal liability
   - Remediation: Document breach response procedure
   - Effort: 16 hours
   - Todo: #compliance-004

5. **SOC2: No Backup Recovery Testing (A1.2)**
   - Requirement: Regularly test backup restoration
   - Impact: Cannot guarantee data recovery
   - Remediation: Schedule quarterly recovery tests
   - Effort: 8 hours
   - Todo: #compliance-005

## Data Flow Analysis

**PII Collected:**
- Identifiers: email, name, phone, IP address
- Financial: Stripe customer ID (no raw card data)
- Behavioral: page views, feature usage

**Third-Party Processors (5):**
1. SendGrid (email) - ✓ DPA signed
2. Google Analytics (analytics) - ✗ DPA missing
3. Stripe (payments) - ✓ DPA signed
4. AWS (hosting) - ✓ DPA signed
5. Intercom (support) - ⚠ DPA under review

**Cross-Border Transfers:**
- EU → US (AWS): Standard Contractual Clauses (SCCs)
- EU → US (Google Analytics): ✗ No valid mechanism

## Technical Controls Assessment

✓ **Implemented:**
- Database encryption (AES-256)
- TLS 1.3 for all connections
- Password hashing (bcrypt)
- Role-based access control (RBAC)
- MFA available

✗ **Missing:**
- Comprehensive audit logging
- Automated backup recovery testing
- Data loss prevention (DLP)
- Intrusion detection system (IDS)

## Remediation Roadmap

### Immediate (< 30 days) - 48 hours
- [ ] Implement data portability API (16h)
- [ ] Add consent audit logging (8h)
- [ ] Document breach notification procedure (16h)
- [ ] Sign DPA with Google Analytics (8h)

### Short-term (1-3 months) - 72 hours
- [ ] Implement comprehensive audit logging (24h)
- [ ] Set up backup recovery testing (8h)
- [ ] Add data retention automation (16h)
- [ ] Implement data flow monitoring (24h)

### Long-term (3-6 months) - 120 hours
- [ ] Achieve full GDPR compliance (80h)
- [ ] Complete SOC2 Type II audit (40h)

## Reports Generated

All reports saved to `.tresor/compliance-2025-11-19-160322/`:
- `phase-1-gdpr.md` - GDPR compliance assessment
- `phase-1-soc2.md` - SOC2 compliance assessment
- `phase-2-data-flow.md` - Data flow analysis
- `phase-3-technical-controls.md` - Technical controls audit
- `final-compliance-report.md` - Auditor-ready report (65 pages)
- `compliance-dashboard.md` - Status overview
- `remediation-checklist.md` - Action items

## Todos Created

18 compliance todos auto-created:
- 5 CRITICAL (must fix for compliance)
- 8 HIGH (important for compliance)
- 5 MEDIUM (best practice improvements)

Run `/todo-check` to systematically address compliance gaps.

## Next Steps

1. Fix 5 critical compliance gaps (48 hours)
2. Sign missing DPAs with third-party processors
3. Implement comprehensive audit logging
4. Schedule follow-up compliance check in 90 days
5. Consider SOC2 Type II audit preparation
```

---

## Integration with Tresor Workflow

### Automatic `/todo-add`
```bash
# Every critical/high compliance gap creates todo:
/todo-add "GDPR Art. 20: Implement data portability API - /api/users/export"
/todo-add "SOC2 CC7.2: Implement comprehensive audit logging"
```

### Automatic `/prompt-create`
```bash
# Complex compliance implementation → expert prompts
/prompt-create "Implement GDPR-compliant consent management system"
# → Creates ./prompts/003-gdpr-consent-system.md
# → Suggests @privacy-counsel, @frontend-developer, @backend-architect
```

---

## Command Options

### `--frameworks`
```bash
/compliance-check --frameworks gdpr,soc2  # Specific frameworks
/compliance-check --frameworks all        # All applicable frameworks
/compliance-check                         # Auto-detect frameworks
```

### `--data-flow`
```bash
/compliance-check --data-flow      # Include data flow analysis (default)
/compliance-check --no-data-flow   # Skip data flow (faster)
```

### `--generate-report`
```bash
/compliance-check --generate-report      # Generate auditor report (default)
/compliance-check --no-generate-report   # Skip report generation
```

---

## Success Criteria

Compliance check is successful if:
- ✅ All applicable frameworks assessed
- ✅ Data flow mapped (if enabled)
- ✅ Technical controls validated
- ✅ Compliance report generated (if enabled)
- ✅ Todos created for all critical/high gaps
- ✅ Clear remediation roadmap provided

---

## Meta Instructions

1. **Detect applicable frameworks** - Don't assume GDPR/SOC2
2. **Map data flows thoroughly** - Critical for privacy compliance
3. **Validate technical controls** - Theory vs implementation
4. **Generate actionable todos** - Specific remediation steps
5. **Create auditor-ready reports** - Professional compliance documentation
6. **Provide effort estimates** - Help prioritize remediation

---

**Begin regulatory compliance validation.**
