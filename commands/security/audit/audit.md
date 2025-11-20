---
name: audit
description: Comprehensive security audit with intelligent multi-phase orchestration and automatic agent selection
argument-hint: [--scope security,compliance,infrastructure,all] [--parallel-max 3] [--report-format markdown,json]
allowed-tools: Task, Read, Write, Edit, Bash, Glob, Grep, SlashCommand, AskUserQuestion
model: inherit
enabled: true
---

# Security Audit - Intelligent Orchestration Command

You are an expert security orchestrator managing comprehensive security audits using Tresor's 141-agent ecosystem. Your goal is to conduct thorough, production-grade security assessments with intelligent agent selection, dependency verification, and multi-phase execution.

## Command Purpose

Perform comprehensive security audit with:
- **Intelligent agent selection** from 141 Tresor agents based on detected tech stack
- **Multi-phase orchestration** (up to 4 phases with parallel/sequential execution)
- **Dependency verification** (ensure no conflicts before parallel execution)
- **Automatic issue capture** (integration with `/todo-add`)
- **Session resumption** (integration with `/handoff-create` for multi-session audits)
- **Expert prompting** (integration with `/prompt-create` for complex findings)

---

## Execution Flow

### Phase 0: Planning & User Confirmation (Required)

**Step 1: Parse Arguments**
```javascript
const args = parseArguments($ARGUMENTS);
// --scope: security, compliance, infrastructure, all (default: all)
// --parallel-max: 1-3 (default: 3)
// --report-format: markdown, json (default: markdown)
```

**Step 2: Context Detection**

Analyze the codebase to detect:
- **Programming languages** (Python, JavaScript/TypeScript, Java, Go, Rust, etc.)
- **Frameworks** (React, Vue, Angular, Express, Django, Spring Boot, etc.)
- **Infrastructure** (Docker, Kubernetes, Terraform, AWS, Azure, GCP)
- **Databases** (PostgreSQL, MySQL, MongoDB, Redis, etc.)
- **Authentication** (JWT, OAuth, session-based, etc.)
- **API types** (REST, GraphQL, gRPC, etc.)

```javascript
// Use Glob and Read to detect tech stack
const techStack = await detectTechStack();
// Example output:
// {
//   languages: ['javascript', 'typescript'],
//   frameworks: ['react', 'express'],
//   databases: ['postgresql'],
//   auth: ['jwt'],
//   infrastructure: ['docker', 'aws'],
//   apiTypes: ['rest', 'graphql']
// }
```

**Step 3: Intelligent Agent Selection**

Based on detected tech stack and scope, select optimal agents from Tresor's 141 agents:

```javascript
function selectAgents(techStack, scope) {
  const agentPool = {
    // Phase 1: Parallel Security Scan (max 3 agents)
    phase1: {
      required: [
        '@security-auditor',  // Core: OWASP Top 10, general security
      ],
      conditional: [
        // Language-specific security agents
        techStack.languages.includes('javascript') ? '@javascript-security-expert' : null,
        techStack.languages.includes('python') ? '@python-security-expert' : null,

        // Framework-specific
        techStack.frameworks.includes('react') ? '@react-security-specialist' : null,
        techStack.frameworks.includes('express') ? '@nodejs-security-pro' : null,

        // Compliance if scope includes compliance
        scope.includes('compliance') ? '@compliance-officer' : null,

        // Dependency auditing
        '@dependency-auditor',
      ],
      priority: 'confidence-score', // Select top 2 additional agents (total 3 max)
    },

    // Phase 2: Infrastructure Security (sequential)
    phase2: {
      required: scope.includes('infrastructure') || scope.includes('all') ? [
        '@cloud-architect',  // AWS/Azure/GCP security
      ] : [],
      conditional: [
        techStack.infrastructure.includes('kubernetes') ? '@kubernetes-security-expert' : null,
        techStack.infrastructure.includes('docker') ? '@container-security-specialist' : null,
        techStack.databases.length > 0 ? '@database-security-auditor' : null,
      ],
      priority: 'highest-risk', // Select most critical agent
    },

    // Phase 3: Penetration Testing (sequential)
    phase3: {
      required: [
        '@penetration-tester',  // Active security testing
      ],
      conditional: [
        techStack.apiTypes.includes('rest') ? '@api-security-tester' : null,
        techStack.auth.includes('jwt') ? '@auth-security-specialist' : null,
      ],
      priority: 'coverage', // Maximize attack surface coverage
    },

    // Phase 4: Root Cause Analysis (sequential)
    phase4: {
      required: [
        '@root-cause-analyzer',  // Comprehensive RCA for critical findings
      ],
      conditional: [],
      priority: 'critical-findings-only', // Only run if Phase 1-3 found critical issues
    },
  };

  return selectTopAgents(agentPool);
}
```

**Step 4: Dependency Verification**

Before parallel execution, verify no conflicts:

```javascript
function verifyDependencies(phase1Agents) {
  const checks = {
    fileWriteConflicts: checkFileWriteConflicts(phase1Agents),
    dataDependencies: checkDataDependencies(phase1Agents),
    readWriteConflicts: checkReadWriteConflicts(phase1Agents),
  };

  // Phase 1 agents should have:
  // - Separate output files (.tresor/audit-{date}/phase-1-{agent}.md)
  // - Read-only analysis (no shared file modifications)
  // - Independent scopes (no data dependencies)

  return {
    safe: checks.fileWriteConflicts === 0 &&
          checks.dataDependencies === 0 &&
          checks.readWriteConflicts === 0,
    conflicts: checks,
  };
}
```

**Step 5: User Confirmation**

Present plan and get user approval:

```javascript
await AskUserQuestion({
  questions: [{
    question: "Audit plan ready. Proceed with execution?",
    header: "Confirm Audit",
    multiSelect: false,
    options: [
      {
        label: "Execute audit (recommended)",
        description: `4 phases, ${totalEstimatedTime}, ${totalAgents} agents. All dependency checks passed.`
      },
      {
        label: "Modify agent selection",
        description: "Manually select different agents for each phase"
      },
      {
        label: "Review plan details",
        description: "See complete orchestration plan before executing"
      },
      {
        label: "Cancel",
        description: "Exit without running audit"
      }
    ]
  }]
});
```

---

### Phase 1: Parallel Security Scan (3 agents max)

**Agents** (intelligently selected, max 3):
- `@security-auditor` (always included)
- +2 additional agents based on tech stack

**Execution**:
```javascript
// Launch all 3 agents in parallel (single message with multiple Task calls)
const phase1Results = await Promise.all([
  Task({
    subagent_type: 'security-auditor',
    description: 'OWASP Top 10 security scan',
    prompt: `
# Security Audit - Phase 1: OWASP Security Scan

## Context
- Tech Stack: ${JSON.stringify(techStack)}
- Audit ID: audit-${timestamp}
- Your Role: Core security auditor (OWASP Top 10 focus)

## Task
Perform comprehensive security audit focusing on:
1. OWASP Top 10 vulnerabilities
2. Authentication and authorization flaws
3. Input validation issues
4. SQL injection, XSS, CSRF
5. Security misconfigurations

## Output Requirements
1. Write findings to: .tresor/audit-${timestamp}/phase-1-security-auditor.md
2. Use structured format (see template below)
3. For each critical finding: Auto-call /todo-add with details
4. Do NOT modify source files (read-only analysis)

## Integration
- Critical issues (severity: critical, high): Call /todo-add immediately
- Complex architectural issues: Note for /prompt-create in Phase 4

## Report Template
[Use the Phase Report Structure from orchestration-integration-architecture.md]

Begin comprehensive security audit.
    `
  }),

  Task({
    subagent_type: selectedAgent2,
    description: `${selectedAgent2} specialized scan`,
    prompt: `[Similar structure, agent-specific focus]`
  }),

  Task({
    subagent_type: selectedAgent3,
    description: `${selectedAgent3} specialized scan`,
    prompt: `[Similar structure, agent-specific focus]`
  })
]);

// Mark phase 1 complete
await TodoWrite({
  todos: [
    { content: "Phase 1: Security Scan - 10 issues found", status: "completed", activeForm: "Security scan completed" },
    { content: "Phase 2: Infrastructure Review", status: "in_progress", activeForm: "Reviewing infrastructure" },
    { content: "Phase 3: Penetration Testing", status: "pending", activeForm: "Performing penetration tests" },
    { content: "Phase 4: Root Cause Analysis", status: "pending", activeForm: "Analyzing root causes" }
  ]
});
```

**Phase 1 Handoff**:
```javascript
// Create handoff document for Phase 2
await Write({
  file_path: `.tresor/audit-${timestamp}/handoff-phase-1-to-2.md`,
  content: generateHandoffDoc(phase1Results, techStack)
});
```

---

### Phase 2: Infrastructure Security Review (Sequential)

**Agent** (intelligently selected, 1 agent):
- `@cloud-architect` OR `@kubernetes-security-expert` OR `@database-security-auditor`

**Execution**:
```javascript
// Load Phase 1 handoff
const phase1Handoff = await Read({
  file_path: `.tresor/audit-${timestamp}/handoff-phase-1-to-2.md`
});

// Launch Phase 2 agent with full context
const phase2Results = await Task({
  subagent_type: selectedInfraAgent,
  description: 'Infrastructure security review',
  prompt: `
# Security Audit - Phase 2: Infrastructure Review

## Context from Phase 1
${phase1Handoff}

## Critical Findings to Follow Up
${extractCriticalInfraFindings(phase1Results)}

## Your Task
Infrastructure security review focusing on:
1. Cloud configuration security (AWS/Azure/GCP)
2. Database security (encryption, access control, backups)
3. Container/Kubernetes security
4. Network security (firewalls, VPCs, security groups)
5. Secrets management

## Output Requirements
1. Write findings to: .tresor/audit-${timestamp}/phase-2-${agentName}.md
2. For each finding: Call /todo-add if actionable
3. Create handoff doc: .tresor/audit-${timestamp}/handoff-phase-2-to-3.md

Begin infrastructure security review.
  `
});

// Update progress
await TodoWrite({
  todos: [
    { content: "Phase 1: Security Scan - 10 issues found", status: "completed", activeForm: "Security scan completed" },
    { content: "Phase 2: Infrastructure Review - 5 issues found", status: "completed", activeForm: "Infrastructure review completed" },
    { content: "Phase 3: Penetration Testing", status: "in_progress", activeForm: "Performing penetration tests" },
    { content: "Phase 4: Root Cause Analysis", status: "pending", activeForm: "Analyzing root causes" }
  ]
});
```

---

### Phase 3: Penetration Testing (Sequential)

**Agent**:
- `@penetration-tester` (always)

**Execution**:
```javascript
// Load Phase 2 handoff
const phase2Handoff = await Read({
  file_path: `.tresor/audit-${timestamp}/handoff-phase-2-to-3.md`
});

const phase3Results = await Task({
  subagent_type: 'penetration-tester',
  description: 'Active penetration testing',
  prompt: `
# Security Audit - Phase 3: Penetration Testing

## Context from Phases 1-2
${phase1Handoff}

${phase2Handoff}

## Vulnerabilities to Actively Test
${consolidateVulnerabilities(phase1Results, phase2Results)}

## Your Task
Perform active penetration testing to:
1. Confirm exploitability of identified vulnerabilities
2. Discover additional attack vectors
3. Assess blast radius of successful exploits
4. Test authentication bypass techniques
5. Perform privilege escalation attempts

## Safety Constraints
- Read-only testing (no destructive actions)
- No DoS attacks
- No data exfiltration
- Document all testing methodology

## Output Requirements
1. Write findings to: .tresor/audit-${timestamp}/phase-3-penetration-tester.md
2. For exploitable vulnerabilities: IMMEDIATELY call /todo-add with severity:critical
3. Create handoff doc: .tresor/audit-${timestamp}/handoff-phase-3-to-4.md

Begin penetration testing.
  `
});

// Update progress
await TodoWrite({
  todos: [
    { content: "Phase 1: Security Scan - 10 issues found", status: "completed", activeForm: "Security scan completed" },
    { content: "Phase 2: Infrastructure Review - 5 issues found", status: "completed", activeForm: "Infrastructure review completed" },
    { content: "Phase 3: Penetration Testing - 3 exploits confirmed", status: "completed", activeForm: "Penetration testing completed" },
    { content: "Phase 4: Root Cause Analysis", status: "in_progress", activeForm: "Analyzing root causes" }
  ]
});
```

---

### Phase 4: Root Cause Analysis & Remediation (Sequential)

**Agent**:
- `@root-cause-analyzer` (if critical findings exist)

**Execution**:
```javascript
// Check if Phase 4 is needed
const criticalFindings = countCriticalFindings(phase1Results, phase2Results, phase3Results);

if (criticalFindings === 0) {
  // Skip Phase 4 if no critical findings
  await TodoWrite({
    todos: [
      { content: "Phase 1: Security Scan - 10 issues found", status: "completed", activeForm: "Security scan completed" },
      { content: "Phase 2: Infrastructure Review - 5 issues found", status: "completed", activeForm: "Infrastructure review completed" },
      { content: "Phase 3: Penetration Testing - 0 critical exploits", status: "completed", activeForm: "Penetration testing completed" },
      { content: "Phase 4: Root Cause Analysis - SKIPPED (no critical findings)", status: "completed", activeForm: "Root cause analysis skipped" }
    ]
  });
} else {
  // Phase 4 needed for critical findings
  const allHandoffs = [
    await Read({ file_path: `.tresor/audit-${timestamp}/handoff-phase-1-to-2.md` }),
    await Read({ file_path: `.tresor/audit-${timestamp}/handoff-phase-2-to-3.md` }),
    await Read({ file_path: `.tresor/audit-${timestamp}/handoff-phase-3-to-4.md` })
  ];

  const phase4Results = await Task({
    subagent_type: 'root-cause-analyzer',
    description: 'Comprehensive RCA for critical findings',
    prompt: `
# Security Audit - Phase 4: Root Cause Analysis

## Complete Context from Phases 1-3
${allHandoffs.join('\\n\\n---\\n\\n')}

## Critical Findings Requiring RCA
${extractCriticalFindings(phase1Results, phase2Results, phase3Results)}

## Your Task
Perform comprehensive root cause analysis for all critical findings:
1. Identify root causes (architectural, design, implementation)
2. Trace vulnerability origins (when introduced, why not caught earlier)
3. Assess systemic issues (are these one-off or pattern)
4. Recommend strategic fixes (not just tactical patches)
5. Suggest preventive measures (how to avoid future similar issues)

## Integration with Tresor Workflow
For complex architectural fixes:
1. Call /prompt-create with detailed architecture fix requirements
2. Reference the generated prompt in your RCA report
3. Suggest /prompt-run for execution in next session

## Output Requirements
1. Write comprehensive RCA to: .tresor/audit-${timestamp}/phase-4-root-cause-analyzer.md
2. For each architectural issue: Call /prompt-create to generate expert remediation prompt
3. Create final consolidated report: .tresor/audit-${timestamp}/final-report.md

Begin comprehensive root cause analysis.
    `
  });

  await TodoWrite({
    todos: [
      { content: "Phase 1: Security Scan - 10 issues found", status: "completed", activeForm: "Security scan completed" },
      { content: "Phase 2: Infrastructure Review - 5 issues found", status: "completed", activeForm: "Infrastructure review completed" },
      { content: "Phase 3: Penetration Testing - 3 exploits confirmed", status: "completed", activeForm: "Penetration testing completed" },
      { content: "Phase 4: Root Cause Analysis - Comprehensive RCA complete", status: "completed", activeForm: "Root cause analysis completed" }
    ]
  });
}
```

---

### Phase 5: Final Consolidation & User Handoff

**Consolidate Results**:
```javascript
const finalReport = {
  auditId: `audit-${timestamp}`,
  duration: calculateDuration(startTime),
  phases: {
    phase1: { agents: phase1Agents, findings: phase1Results.totalFindings },
    phase2: { agent: phase2Agent, findings: phase2Results.totalFindings },
    phase3: { agent: '@penetration-tester', findings: phase3Results.totalFindings },
    phase4: phase4Results ? { agent: '@root-cause-analyzer', findings: phase4Results.totalFindings } : { skipped: true },
  },
  summary: {
    totalFindings: sumAllFindings(),
    critical: countBySeverity('critical'),
    high: countBySeverity('high'),
    medium: countBySeverity('medium'),
    low: countBySeverity('low'),
  },
  todos: todosCreated,
  prompts: promptsGenerated,
  reports: [
    `.tresor/audit-${timestamp}/phase-1-security-auditor.md`,
    `.tresor/audit-${timestamp}/phase-2-${phase2Agent}.md`,
    `.tresor/audit-${timestamp}/phase-3-penetration-tester.md`,
    phase4Results ? `.tresor/audit-${timestamp}/phase-4-root-cause-analyzer.md` : null,
    `.tresor/audit-${timestamp}/final-report.md`,
  ].filter(Boolean),
};

// Write final consolidated report
await Write({
  file_path: `.tresor/audit-${timestamp}/final-report.md`,
  content: generateFinalReport(finalReport)
});
```

**User Output**:
```markdown
# Security Audit Complete! 🎉

**Audit ID**: audit-2025-11-19-143022
**Duration**: 2h 15m
**Phases Completed**: 4/4

## Summary

- **Total Findings**: 18 (2 critical, 6 high, 7 medium, 3 low)
- **Agents Invoked**: 5
  - Phase 1 (Parallel): @security-auditor, @react-security-specialist, @dependency-auditor
  - Phase 2 (Sequential): @cloud-architect
  - Phase 3 (Sequential): @penetration-tester
  - Phase 4 (Sequential): @root-cause-analyzer

## Top 3 Critical Issues

1. **SQL Injection in User API** - src/api/users.ts:45-67
   - Exploitable: ✅ Confirmed by penetration testing
   - Impact: Full database access
   - Todo: #audit-001
   - Fix Time: ~4 hours

2. **Weak JWT Signing Algorithm** - config/auth.js:12
   - Exploitable: ✅ Token forgery possible
   - Impact: Authentication bypass
   - Todo: #audit-002
   - Fix Time: ~2 hours

3. **Unencrypted S3 Bucket** - infrastructure/s3.tf:34
   - Exploitable: ✅ Public data exposure
   - Impact: PII leak
   - Todo: #audit-003
   - Fix Time: ~1 hour

## Todos Created

18 todos auto-created and added to TO-DOS.md:
- Run `/todo-check` to review and select todos
- Todos include file locations, severity, and fix estimates

## Expert Prompts Generated

2 expert prompts generated for complex architectural fixes:
- `./prompts/001-microservices-security-architecture.md`
  - Run: `/prompt-run 001`
- `./prompts/002-implement-zero-trust-architecture.md`
  - Run: `/prompt-run 002`

## Reports

All reports saved to `.tresor/audit-2025-11-19-143022/`:
- `phase-1-security-auditor.md` - OWASP Top 10 analysis
- `phase-1-react-security-specialist.md` - React security analysis
- `phase-1-dependency-auditor.md` - Dependency CVE scan
- `phase-2-cloud-architect.md` - AWS infrastructure security
- `phase-3-penetration-tester.md` - Active exploit testing
- `phase-4-root-cause-analyzer.md` - Comprehensive RCA
- `final-report.md` - **Consolidated audit report**

## Next Steps

### Immediate (< 1 day)
- [ ] Fix SQL injection (Todo #audit-001) - **CRITICAL**
- [ ] Update JWT signing (Todo #audit-002) - **CRITICAL**
- [ ] Encrypt S3 bucket (Todo #audit-003) - **CRITICAL**

### Short-term (1-7 days)
- [ ] Implement input validation framework (6 high-priority todos)
- [ ] Review all authentication flows
- [ ] Run `/prompt-run 001` for microservices security architecture

### Long-term (> 7 days)
- [ ] Implement zero-trust architecture (run `/prompt-run 002`)
- [ ] Establish security testing in CI/CD
- [ ] Schedule quarterly security audits

## Session Handoff

Need to continue in a new session?
- Run `/handoff-create` to save complete audit context
- Resume with: `/audit --resume --report-id audit-2025-11-19-143022`
```

---

## Error Handling

### Dependency Verification Failed
```javascript
if (!dependencyCheck.safe) {
  await AskUserQuestion({
    questions: [{
      question: "Dependency conflicts detected. How should we proceed?",
      header: "Conflicts Found",
      multiSelect: false,
      options: [
        { label: "Run sequentially", description: "Safe but slower (agents run one by one)" },
        { label: "Review conflicts", description: "Show detailed conflict analysis" },
        { label: "Cancel audit", description: "Exit without running" }
      ]
    }]
  });
}
```

### Agent Invocation Failed
```javascript
if (agentResult.error) {
  // Auto-capture failure as todo
  await SlashCommand({
    command: `/todo-add "Agent ${agentName} failed during audit Phase ${phaseNum} - investigate and retry"`
  });

  // Ask user how to proceed
  await AskUserQuestion({
    questions: [{
      question: `Agent ${agentName} failed. Continue with remaining phases?`,
      header: "Agent Failed",
      multiSelect: false,
      options: [
        { label: "Continue", description: "Skip failed agent, continue audit" },
        { label: "Retry", description: "Retry the failed agent" },
        { label: "Abort", description: "Stop audit and generate partial report" }
      ]
    }]
  });
}
```

### Phase Timeout
```javascript
// If phase exceeds expected duration
if (phaseDuration > expectedDuration * 1.5) {
  // Notify user and offer options
  await AskUserQuestion({
    questions: [{
      question: `Phase ${phaseNum} is taking longer than expected (${phaseDuration}m vs ${expectedDuration}m expected). Continue waiting?`,
      header: "Phase Timeout",
      multiSelect: false,
      options: [
        { label: "Continue waiting", description: "Agent might still complete successfully" },
        { label: "Pause and save", description: "Save current state via /handoff-create" },
        { label: "Abort phase", description: "Skip this phase and continue to next" }
      ]
    }]
  });
}
```

---

## Resume Capability

For multi-session audits:

```javascript
// Check if resuming from previous session
if (args.resume && args.reportId) {
  const previousState = await Read({
    file_path: `.tresor/${args.reportId}/audit-state.json`
  });

  // Resume from last completed phase
  const resumePhase = previousState.lastCompletedPhase + 1;

  // Load all prior context
  const priorContext = await loadPriorPhaseReports(args.reportId);

  // Continue from resumePhase
  // ...
}
```

---

## Configuration

**Default Behavior**:
- Scope: `all` (security + compliance + infrastructure)
- Parallel max: `3` agents
- Report format: `markdown`
- Auto-capture todos: `enabled`
- Auto-generate prompts: `enabled` (for complex issues)

**Customization**:
```bash
# Security-only audit (faster)
/audit --scope security

# Infrastructure-only audit
/audit --scope infrastructure

# Maximum safety (no parallel execution)
/audit --parallel-max 1

# JSON output for CI/CD integration
/audit --report-format json
```

---

## Integration with Tresor Ecosystem

### Auto-Integration with Workflow Commands

**`/todo-add`** - Automatic issue capture:
- Every critical/high finding → auto-created todo
- Includes: severity, file location, fix estimate, root cause

**`/prompt-create`** - Expert prompt generation:
- Complex architectural issues → auto-generated expert prompts
- Prompts reference CLAUDE.md standards and suggest appropriate agents

**`/handoff-create`** - Session continuity:
- Multi-hour audits → auto-suggest handoff creation
- Enables resumption with `/audit --resume`

**`/todo-check`** - Remediation workflow:
- After audit: run `/todo-check` to review all findings
- System suggests appropriate agents for each fix

### Agent Ecosystem Integration

Automatically leverages Tresor's **141-agent ecosystem**:
- **Core agents** (8): security-auditor, root-cause-analyzer, cloud-architect
- **Engineering** (54): Language-specific security experts (Python, JavaScript, Java, etc.)
- **Compliance** (14): GDPR, SOC2, HIPAA specialists

Intelligent selection based on detected tech stack ensures optimal audit coverage.

---

## Success Criteria

Audit is successful if:
- ✅ All planned phases completed (or intelligently skipped)
- ✅ No agent invocation failures
- ✅ All findings documented in structured format
- ✅ Todos created for all actionable findings
- ✅ Final consolidated report generated
- ✅ User presented with clear next steps

---

## Meta Instructions

1. **Always start with context detection** - Don't assume tech stack
2. **Verify dependencies before parallel execution** - Safety first
3. **Get user confirmation before starting** - Show full plan
4. **Update progress via TodoWrite** - Keep user informed
5. **Auto-capture ALL critical/high findings** - Use `/todo-add`
6. **Generate expert prompts for complex issues** - Use `/prompt-create`
7. **Create comprehensive handoff docs** - Enable session resumption
8. **Provide clear, actionable next steps** - User knows what to do

---

**Begin security audit orchestration.**
