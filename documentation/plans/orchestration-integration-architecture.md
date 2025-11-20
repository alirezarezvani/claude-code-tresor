# Orchestration Integration Architecture
## T\u00c2CHES Workflow + Agent Documentation + Context Handoff

**Date**: November 19, 2025
**Version**: 1.0
**Status**: Design Phase

---

## Overview

This document defines how the new orchestration commands (`/audit`, `/profile`, `/deploy-validate`, etc.) integrate with:
1. **Tresor Workflow** (`/todo-add`, `/todo-check`, `/prompt-create`, `/prompt-run`, `/handoff-create`)
2. **Agent Documentation Standards** (how agents document their work)
3. **Context Handoff Mechanisms** (how agents pass context between phases)
4. **Status Update Protocols** (real-time progress visibility)

---

## Part 1: Tresor Workflow Integration

### Current Tresor Commands

Located in `/commands/workflow/`:
- `/todo-add` - Capture issues without breaking flow
- `/todo-check` - Resume work with complete context
- `/prompt-create` - Generate optimized prompts
- `/prompt-run` - Execute prompts in fresh contexts
- `/handoff-create` - Create comprehensive handoff documents

### Integration Strategy

#### 1.1 Auto-Capture During Orchestration

**When**: Agents discover issues during execution
**How**: Automatic `/todo-add` invocation

```typescript
// Example: During /audit execution
Phase 1: Security Scan (3 agents parallel)
  @security-auditor finds: XSS vulnerability in user input
    → Auto-calls: /add-to-todos "Fix XSS in src/api/users.ts:45-67"

  @dependency-auditor finds: 3 critical CVEs in dependencies
    → Auto-calls: /add-to-todos "Upgrade vulnerable deps: lodash@4.17.15, express@4.16.0"

  @compliance-officer finds: Missing GDPR consent flow
    → Auto-calls: /add-to-todos "Implement GDPR consent UI - /components/Auth/"

Phase 2: Infrastructure Review
  @cloud-architect finds: Unencrypted S3 bucket
    → Auto-calls: /add-to-todos "Enable S3 encryption for user-uploads bucket"
```

**Implementation**:
```javascript
// In agent execution context
async function reportIssue(issue) {
  await SlashCommand({
    command: `/add-to-todos ${issue.description} - ${issue.location}`
  });

  // Continue execution
  return {
    severity: issue.severity,
    tracked: true,
    todoId: generatedId
  };
}
```

#### 1.2 Phase-Based Todo Batching

**When**: After each orchestration phase completes
**How**: Consolidated todo creation with phase metadata

```javascript
// After Phase 1 completion
const phaseIssues = {
  phase: 1,
  name: "Security Scan",
  agents: ["@security-auditor", "@dependency-auditor", "@compliance-officer"],
  issues: [
    { severity: "critical", count: 2, agent: "@security-auditor" },
    { severity: "high", count: 3, agent: "@dependency-auditor" },
    { severity: "medium", count: 5, agent: "@compliance-officer" }
  ],
  totalIssues: 10
};

// Create structured todo
await SlashCommand({
  command: `/add-to-todos "Phase 1 Security Scan: 10 issues (2 critical, 3 high, 5 medium) - See .tresor/audit-2025-11-19/phase-1-report.md"`
});
```

#### 1.3 Smart Resumption from Todos

**When**: User runs `/todo-check`
**How**: Detect incomplete orchestrations and offer resumption

```javascript
// /check-todos enhanced detection
function analyzeIncompleteOrchestrations(todos) {
  const orchestrationPatterns = {
    audit: /Phase \d+ Security Scan|audit-\d{4}-\d{2}-\d{2}/,
    profile: /Performance profiling|profile-report/,
    deployValidate: /Pre-deployment|deploy-validation/
  };

  const incomplete = todos.filter(todo => {
    // Check if todo is from an orchestration
    const matchedCommand = Object.keys(orchestrationPatterns).find(cmd =>
      orchestrationPatterns[cmd].test(todo.description)
    );

    if (matchedCommand) {
      // Check if orchestration is incomplete
      const reportPath = extractReportPath(todo.description);
      const report = readReport(reportPath);

      return report.status !== "completed";
    }
    return false;
  });

  return incomplete.map(todo => ({
    ...todo,
    resumable: true,
    command: detectOriginalCommand(todo),
    phase: detectIncompletePhase(todo)
  }));
}

// User interaction
/check-todos
  → Shows: "3 incomplete orchestrations detected"
  → Option 1: "Resume /audit from Phase 2"
  → Option 2: "Resume /profile from Phase 3"
  → Option 3: "View all todos"
```

#### 1.4 Meta-Prompting Integration

**When**: Complex issues require expert prompt generation
**How**: Invoke `/prompt-create` for sophisticated fixes

```javascript
// During /audit, critical architectural issue found
@systems-architect finds: "Monolithic architecture causing scaling issues"
  → Too complex for simple todo
  → Auto-invokes: /create-prompt "Design microservices migration strategy for monolithic e-commerce app with 500k users"

  → Creates optimized prompt with:
    - References to CLAUDE.md standards
    - Suggested agents (@backend-architect, @database-optimizer, @devops-engineer)
    - Tresor's anti-overengineering principles

  → Saves prompt to: .tresor/prompts/001-microservices-migration.md
  → Links to todo: "/add-to-todos Execute prompt 001 for microservices migration - /run-prompt 001"
```

#### 1.5 Session Handoff Integration

**When**: Orchestration spans multiple sessions
**How**: Auto-integrate with `/handoff-create`

```javascript
// At end of /audit session
function createSessionHandoff(orchestrationState) {
  const handoff = {
    command: "/audit",
    startTime: "2025-11-19T10:00:00Z",
    duration: "2h 15m",
    phasesCompleted: [1, 2, 3],
    phasesRemaining: [4],

    phase1: {
      agents: ["@security-auditor", "@dependency-auditor", "@compliance-officer"],
      findings: 10,
      report: ".tresor/audit-2025-11-19/phase-1-report.md"
    },

    phase4Pending: {
      agent: "@penetration-tester",
      dependencies: "Requires production-like staging environment",
      estimatedDuration: "4-6 hours",
      prerequisites: ["Set up staging env", "Load production data snapshot"]
    },

    todos: 15,
    prompts: 2,

    resumeCommand: "/audit --resume phase-4 --report-id audit-2025-11-19"
  };

  // Auto-invoke /whats-next with orchestration context
  await SlashCommand({
    command: `/whats-next --include-orchestration ${JSON.stringify(handoff)}`
  });
}

// Result: whats-next.md includes full orchestration state
// Next session: Load whats-next.md → Resume exactly where left off
```

---

## Part 2: Agent Documentation Standards

### 2.1 Documentation Requirements

Every agent MUST produce:
1. **Phase Report** - Structured findings from their phase
2. **Handoff Document** - Context for next phase/agent
3. **Status Updates** - Real-time progress via TodoWrite
4. **Final Summary** - Consolidated results

### 2.2 Phase Report Structure

**Location**: `.tresor/{command}-{date}/phase-{N}-{agent-name}.md`

**Template**:
```markdown
# Phase {N} Report: {Agent Name}
**Command**: /{command}
**Agent**: @{agent-name}
**Date**: {ISO-8601 timestamp}
**Duration**: {HH:MM:SS}
**Status**: {completed|partial|failed}

---

## Executive Summary
{2-3 sentence overview of findings}

---

## Findings

### Critical Issues ({count})
1. **{Issue Title}** - {Location}
   - **Severity**: Critical
   - **Impact**: {User impact description}
   - **Root Cause**: {Technical explanation}
   - **Recommendation**: {Specific fix}
   - **Effort**: {hours estimate}
   - **Todo ID**: {auto-generated from /add-to-todos}

### High Priority Issues ({count})
{Same structure}

### Medium Priority Issues ({count})
{Same structure}

---

## Analysis Details

### {Category 1}
{Detailed technical analysis}

### {Category 2}
{Detailed technical analysis}

---

## Metrics

- Files Analyzed: {count}
- Lines of Code Scanned: {count}
- Issues Found: {total} (Critical: {n}, High: {n}, Medium: {n}, Low: {n})
- False Positives: {count}
- Confidence Score: {0-100}%

---

## Recommendations

### Immediate Actions (< 1 day)
1. {Action with specific location and steps}

### Short-term Actions (1-7 days)
1. {Action with specific location and steps}

### Long-term Actions (> 7 days)
1. {Action with specific location and steps}

---

## Context for Next Phase

### Key Findings to Pass Forward
- {Finding 1 that affects next phase}
- {Finding 2 that affects next phase}

### Dependencies
- {Dependency 1 required by next agent}
- {Dependency 2 required by next agent}

### Questions for Next Agent
1. {Question for next phase agent}
2. {Question for next phase agent}

---

## Artifacts

- Detailed scan results: `./artifacts/scan-results.json`
- Code samples: `./artifacts/vulnerable-code-snippets/`
- Remediation scripts: `./artifacts/fix-scripts/`

---

## Agent Metadata

- Agent: @{agent-name}
- Model: {claude-sonnet-4-5-20250929}
- Tools Used: {Grep, Read, Bash, etc.}
- Token Usage: {tokens}
- Confidence: {0-100}%
```

### 2.3 Handoff Document Structure

**Location**: `.tresor/{command}-{date}/handoff-phase-{N}-to-{N+1}.md`

**Template**:
```markdown
# Handoff: Phase {N} → Phase {N+1}
**From**: Phase {N} (@{agent-names})
**To**: Phase {N+1} (@{agent-names})
**Date**: {ISO-8601 timestamp}

---

## Phase {N} Completion Summary

✅ **Completed**:
- {Task 1}
- {Task 2}

⏸️ **Deferred** (for next phase):
- {Task 1} - Reason: {why}
- {Task 2} - Reason: {why}

❌ **Blocked**:
- {Task 1} - Blocker: {what's blocking}

---

## Critical Context for Phase {N+1}

### Discovered Architecture
{Key architectural findings that affect next phase}

### Security Posture
{Security context needed by next agent}

### Performance Baseline
{Performance metrics for next phase}

### Dependencies
{External dependencies discovered}

---

## Data Handoff

### Files Modified
- `src/api/users.ts` - Added input validation (lines 45-67)
- `config/database.js` - Updated connection pool settings

### Files to Review
- `src/auth/` - Potential vulnerabilities found, need @penetration-tester review
- `infrastructure/` - Configuration drift detected

### Intermediate Data
- Scan results: `.tresor/audit-2025-11-19/phase-1-scan-results.json`
- Dependency graph: `.tresor/audit-2025-11-19/phase-1-dependency-graph.svg`

---

## Questions for Phase {N+1} Agents

1. **For @{next-agent}**: {Specific question requiring next agent's expertise}
2. **For @{next-agent}**: {Specific question requiring next agent's expertise}

---

## Recommendations for Next Phase

### Execution Strategy
- {Recommendation 1 for how next phase should run}
- {Recommendation 2 for how next phase should run}

### Focus Areas
1. {Area 1 that needs deep dive}
2. {Area 2 that needs deep dive}

### Avoid
- {Anti-pattern 1 to avoid}
- {Anti-pattern 2 to avoid}

---

## Phase {N+1} Estimated Scope

- **Duration**: {hours estimate}
- **Agents**: {list}
- **Parallel Safety**: {Safe|Requires Sequential} - {Reason}
- **Dependencies Met**: {Yes|No|Partial}
```

### 2.4 Real-Time Status Updates

**How**: TodoWrite tool during agent execution

```javascript
// Agent starts phase
await TodoWrite({
  todos: [
    { content: "Phase 1: Security Scan", status: "in_progress", activeForm: "Running security scan" },
    { content: "Phase 2: Infrastructure Review", status: "pending", activeForm: "Reviewing infrastructure" },
    { content: "Phase 3: Penetration Testing", status: "pending", activeForm: "Performing penetration tests" }
  ]
});

// Agent progresses
await TodoWrite({
  todos: [
    { content: "Phase 1: Security Scan - Analyzing dependencies (30%)", status: "in_progress", activeForm: "Analyzing dependencies" },
    { content: "Phase 2: Infrastructure Review", status: "pending", activeForm: "Reviewing infrastructure" },
    { content: "Phase 3: Penetration Testing", status: "pending", activeForm: "Performing penetration tests" }
  ]
});

// Agent completes phase
await TodoWrite({
  todos: [
    { content: "Phase 1: Security Scan - 10 issues found", status: "completed", activeForm: "Security scan completed" },
    { content: "Phase 2: Infrastructure Review", status: "in_progress", activeForm: "Reviewing infrastructure" },
    { content: "Phase 3: Penetration Testing", status: "pending", activeForm: "Performing penetration tests" }
  ]
});
```

**User sees**:
```
✅ Phase 1: Security Scan - 10 issues found
⏳ Phase 2: Infrastructure Review (analyzing cloud configs...)
⏸️ Phase 3: Penetration Testing
```

### 2.5 Final Consolidated Report

**Location**: `.tresor/{command}-{date}/final-report.md`

**Template**:
```markdown
# {Command} Final Report
**Command**: /{command}
**Date**: {ISO-8601 timestamp}
**Duration**: {HH:MM:SS}
**Status**: {completed|partial|failed}

---

## Executive Summary

{High-level overview for non-technical stakeholders}

### Key Metrics
- Total Issues: {count} (Critical: {n}, High: {n}, Medium: {n}, Low: {n})
- Files Analyzed: {count}
- Agents Invoked: {count}
- Phases Completed: {N}/{Total}

### Top 3 Priorities
1. **{Critical Issue 1}** - {Location} - Estimated Fix: {hours}
2. **{Critical Issue 2}** - {Location} - Estimated Fix: {hours}
3. **{Critical Issue 3}** - {Location} - Estimated Fix: {hours}

---

## Phase Summaries

### Phase 1: {Name}
**Agents**: {@agent1, @agent2, @agent3}
**Duration**: {HH:MM:SS}
**Findings**: {count}

{2-sentence summary}

[Full Report →](./phase-1-security-scan.md)

### Phase 2: {Name}
{Same structure}

---

## Detailed Findings

### Critical Issues ({count})
{Consolidated from all phases}

### High Priority Issues ({count})
{Consolidated from all phases}

### Medium Priority Issues ({count})
{Consolidated from all phases}

---

## Remediation Roadmap

### Week 1 (Immediate)
- [ ] Fix XSS in user input - src/api/users.ts:45-67 (4h)
- [ ] Upgrade vulnerable dependencies (2h)
- [ ] Enable S3 encryption (1h)

### Week 2-4 (Short-term)
- [ ] Implement GDPR consent flow (16h)
- [ ] Refactor authentication module (24h)

### Month 2-3 (Long-term)
- [ ] Migrate to microservices architecture (120h)

---

## Todos Created

{count} todos created during execution:
- [View all todos →](./.tresor/todos.md)
- [Resume incomplete work →] `/todo-check`

---

## Prompts Generated

{count} expert prompts created for complex issues:
- [001-microservices-migration.md](./.tresor/prompts/001-microservices-migration.md) - Run: `/run-prompt 001`
- [002-gdpr-compliance.md](./.tresor/prompts/002-gdpr-compliance.md) - Run: `/run-prompt 002`

---

## Session Handoff

Need to continue in a new session?
- [Load handoff context →](./.tresor/whats-next.md)
- Resume command: `/{command} --resume --report-id {report-id}`

---

## Artifacts

- Phase reports: `./.tresor/{command}-{date}/phase-*.md`
- Handoff documents: `./.tresor/{command}-{date}/handoff-*.md`
- Scan results: `./.tresor/{command}-{date}/artifacts/`
- Remediation scripts: `./.tresor/{command}-{date}/artifacts/fix-scripts/`
```

---

## Part 3: Context Handoff Mechanisms

### 3.1 Between Phases (Sequential)

**Scenario**: Phase 1 completes → Phase 2 starts

```javascript
// Phase 1 completes
const phase1Results = {
  agent: "@security-auditor",
  findings: [...],
  handoff: {
    criticalContext: "Found SQL injection in user API",
    filesModified: ["src/api/users.ts"],
    nextPhaseNeeds: "Infrastructure review to check if DB has protection"
  }
};

// Write handoff document
await Write({
  file_path: ".tresor/audit-2025-11-19/handoff-phase-1-to-2.md",
  content: generateHandoffDoc(phase1Results)
});

// Phase 2 starts
const phase2Context = await Read({
  file_path: ".tresor/audit-2025-11-19/handoff-phase-1-to-2.md"
});

// Agent receives context
await Task({
  subagent_type: "cloud-architect",
  prompt: `
You are starting Phase 2 of the /audit orchestration.

# Context from Phase 1
${phase2Context}

# Your Task
Review infrastructure configurations with special attention to:
- Database protection mechanisms (Phase 1 found SQL injection)
- Files already modified: src/api/users.ts

Begin your analysis...
  `
});
```

### 3.2 Between Parallel Agents (Same Phase)

**Scenario**: 3 agents running in parallel need shared context

```javascript
// Shared context document created before parallel execution
const sharedContext = {
  command: "/audit",
  phase: 1,
  scope: {
    files: ["src/api/**", "src/auth/**"],
    focus: "authentication and authorization",
    exclude: ["node_modules/", "test/"]
  },
  agents: {
    "@security-auditor": "Focus on OWASP Top 10 vulnerabilities",
    "@dependency-auditor": "Focus on CVEs in authentication libraries",
    "@compliance-officer": "Focus on GDPR and SOC2 compliance"
  }
};

await Write({
  file_path: ".tresor/audit-2025-11-19/phase-1-shared-context.md",
  content: generateSharedContext(sharedContext)
});

// Each parallel agent reads shared context
await Task({
  subagent_type: "security-auditor",
  prompt: `
You are part of Phase 1 parallel execution.

# Shared Context
${await Read({ file_path: ".tresor/audit-2025-11-19/phase-1-shared-context.md" })}

# Your Specific Focus
${sharedContext.agents["@security-auditor"]}

Work independently. You will coordinate results after completion.
  `
});
```

### 3.3 Cross-Session Handoff

**Scenario**: Work spans multiple days/sessions

```javascript
// End of Session 1
await SlashCommand({
  command: `/whats-next --orchestration-state ${JSON.stringify({
    command: "/audit",
    phasesCompleted: [1, 2],
    phasesRemaining: [3, 4],
    reportPath: ".tresor/audit-2025-11-19",
    resumeCommand: "/audit --resume phase-3 --report-id audit-2025-11-19"
  })}`
});

// Start of Session 2 (next day)
// User: "Continue the audit from yesterday"

// Load session context
const lastSession = await Read({
  file_path: ".tresor/whats-next.md"
});

// Parse orchestration state
const orchestrationState = extractOrchestrationState(lastSession);

// Resume execution
if (orchestrationState.command === "/audit") {
  await resumeAudit({
    fromPhase: orchestrationState.phasesRemaining[0],
    reportPath: orchestrationState.reportPath,
    priorContext: await loadAllPhaseReports(orchestrationState.reportPath)
  });
}
```

---

## Part 4: Practical Examples

### Example 1: /audit with Full Integration

**User Command**:
```bash
/audit --scope security,compliance --parallel-max 3
```

**Execution Flow**:

#### Step 1: Planning & User Confirmation
```
🔍 Analyzing codebase...

Detected Context:
- Language: JavaScript/TypeScript (Node.js)
- Framework: Express.js
- Database: PostgreSQL
- Auth: JWT
- Files: 1,247 files, 45,000 LOC
- Focus: security, compliance

Recommended Orchestration:
Phase 1 (Parallel - 3 agents):
  ✓ @security-auditor - OWASP Top 10 vulnerabilities
  ✓ @dependency-auditor - CVE scanning
  ✓ @compliance-officer - GDPR/SOC2 compliance
  Dependencies: ✅ No conflicts (separate domains)

Phase 2 (Sequential):
  → @cloud-architect - Infrastructure security review
  Dependencies: Needs Phase 1 findings

Phase 3 (Sequential):
  → @penetration-tester - Active exploitation attempts
  Dependencies: Needs Phase 1 + 2 context

Phase 4 (Sequential):
  → @root-cause-analyzer - Comprehensive RCA for critical findings
  Dependencies: Needs all prior phases

Estimated Duration: 4-6 hours
Todos will be created for: All findings
Prompts will be generated for: Complex architectural issues

Proceed? (y/n/modify)
```

**User**: `y`

#### Step 2: Phase 1 Execution (Parallel)

**TodoWrite Status**:
```
⏳ Phase 1: Security Scan (0%)
⏸️ Phase 2: Infrastructure Review
⏸️ Phase 3: Penetration Testing
⏸️ Phase 4: Root Cause Analysis
```

**3 Agents Launch in Parallel**:

```javascript
// All launch simultaneously
Promise.all([
  Task({
    subagent_type: "security-auditor",
    prompt: `Security audit focusing on OWASP Top 10. Report findings to .tresor/audit-2025-11-19/phase-1-security-auditor.md`
  }),

  Task({
    subagent_type: "dependency-auditor",
    prompt: `CVE scan for all dependencies. Report findings to .tresor/audit-2025-11-19/phase-1-dependency-auditor.md`
  }),

  Task({
    subagent_type: "compliance-officer",
    prompt: `GDPR and SOC2 compliance review. Report findings to .tresor/audit-2025-11-19/phase-1-compliance-officer.md`
  })
]);
```

**Agent Progress Updates**:
```
⏳ Phase 1: Security Scan (15%)
  ├─ @security-auditor: Analyzing auth module... (files: 12/45)
  ├─ @dependency-auditor: Scanning package.json... (deps: 34/156)
  └─ @compliance-officer: Reviewing data handling... (files: 8/23)
```

**Auto-Captured Todos** (during execution):
```javascript
// @security-auditor discovers issue
await SlashCommand({
  command: `/add-to-todos "Fix XSS vulnerability in user input - src/api/users.ts:45-67"`
});

// @dependency-auditor discovers issue
await SlashCommand({
  command: `/add-to-todos "Upgrade lodash@4.17.15 (CVE-2020-8203) - package.json"`
});

// @compliance-officer discovers issue
await SlashCommand({
  command: `/add-to-todos "Implement GDPR consent flow - components/Auth/"`
});
```

**Phase 1 Completion**:
```
✅ Phase 1: Security Scan (100%) - 10 issues found
  ├─ @security-auditor: 4 issues (2 critical, 2 high)
  ├─ @dependency-auditor: 3 issues (3 high)
  └─ @compliance-officer: 3 issues (1 high, 2 medium)

Reports generated:
- .tresor/audit-2025-11-19/phase-1-security-auditor.md
- .tresor/audit-2025-11-19/phase-1-dependency-auditor.md
- .tresor/audit-2025-11-19/phase-1-compliance-officer.md
- .tresor/audit-2025-11-19/handoff-phase-1-to-2.md

Todos created: 10
```

#### Step 3: Phase 2 Execution (Sequential)

**TodoWrite Status**:
```
✅ Phase 1: Security Scan - 10 issues found
⏳ Phase 2: Infrastructure Review (0%)
⏸️ Phase 3: Penetration Testing
⏸️ Phase 4: Root Cause Analysis
```

**Single Agent with Handoff Context**:
```javascript
// Load Phase 1 handoff
const phase1Handoff = await Read({
  file_path: ".tresor/audit-2025-11-19/handoff-phase-1-to-2.md"
});

// Launch Phase 2 with context
await Task({
  subagent_type: "cloud-architect",
  prompt: `
You are Phase 2 of the /audit orchestration.

# Context from Phase 1
${phase1Handoff}

# Critical Findings to Follow Up
- SQL injection found in user API - verify database-level protections
- Weak JWT configuration - review token expiration and signing
- Unencrypted data in transit - verify HTTPS and TLS settings

# Your Task
Infrastructure security review with special attention to:
1. Database security (SQL injection protection)
2. Network security (HTTPS/TLS)
3. Cloud configuration (S3, IAM, security groups)

Report to: .tresor/audit-2025-11-19/phase-2-cloud-architect.md
  `
});
```

**Phase 2 Progress**:
```
✅ Phase 1: Security Scan - 10 issues found
⏳ Phase 2: Infrastructure Review (40%)
  └─ @cloud-architect: Analyzing AWS configs... (resources: 45/112)
⏸️ Phase 3: Penetration Testing
⏸️ Phase 4: Root Cause Analysis
```

**Phase 2 Completion**:
```
✅ Phase 1: Security Scan - 10 issues found
✅ Phase 2: Infrastructure Review - 5 issues found
⏸️ Phase 3: Penetration Testing
⏸️ Phase 4: Root Cause Analysis

Reports generated:
- .tresor/audit-2025-11-19/phase-2-cloud-architect.md
- .tresor/audit-2025-11-19/handoff-phase-2-to-3.md

Todos created: 5 (total: 15)
```

#### Step 4: Session Break & Resumption

**User needs to stop** (time constraint):

```
⚠️ Audit paused after Phase 2 (2/4 phases complete)

Creating session handoff...
```

**Auto-invokes `/handoff-create`**:
```javascript
await SlashCommand({
  command: `/whats-next --orchestration-state ${JSON.stringify({
    command: "/audit",
    startTime: "2025-11-19T10:00:00Z",
    duration: "2h 15m",
    phasesCompleted: [1, 2],
    phasesRemaining: [3, 4],
    reportPath: ".tresor/audit-2025-11-19",
    findings: {
      total: 15,
      critical: 2,
      high: 6,
      medium: 7
    },
    resumeCommand: "/audit --resume phase-3 --report-id audit-2025-11-19"
  })}`
});
```

**Generated: `.tresor/whats-next.md`**:
```markdown
# Session Handoff: Audit (Incomplete)
**Date**: 2025-11-19T12:15:00Z
**Duration**: 2h 15m
**Status**: Paused (50% complete)

---

## Orchestration State

### Completed Phases
✅ Phase 1: Security Scan (3 agents parallel)
  - @security-auditor: 4 issues
  - @dependency-auditor: 3 issues
  - @compliance-officer: 3 issues

✅ Phase 2: Infrastructure Review (1 agent)
  - @cloud-architect: 5 issues

### Remaining Phases
⏸️ Phase 3: Penetration Testing
  - Agent: @penetration-tester
  - Dependencies: ✅ All met
  - Duration: ~2 hours
  - Prerequisites: Production-like staging environment

⏸️ Phase 4: Root Cause Analysis
  - Agent: @root-cause-analyzer
  - Dependencies: ⏸️ Needs Phase 3
  - Duration: ~1 hour

---

## Findings Summary

Total: 15 issues (2 critical, 6 high, 7 medium)

Top 3 Priorities:
1. SQL injection in user API - src/api/users.ts:45-67
2. Weak JWT signing algorithm - config/auth.js:12
3. Unencrypted S3 bucket - infrastructure/s3.tf:34

---

## Resume Instructions

### Option 1: Continue Immediately
`/audit --resume phase-3 --report-id audit-2025-11-19`

### Option 2: Review Findings First
1. Read: .tresor/audit-2025-11-19/final-report.md (partial)
2. Check todos: `/todo-check`
3. Resume: `/audit --resume phase-3 --report-id audit-2025-11-19`

---

## Context Files
- Phase 1 Reports: .tresor/audit-2025-11-19/phase-1-*.md
- Phase 2 Report: .tresor/audit-2025-11-19/phase-2-cloud-architect.md
- Handoff Docs: .tresor/audit-2025-11-19/handoff-*.md
- Todos: 15 items in .tresor/todos.md
```

#### Step 5: Next Session - Resume

**User (next day)**: "Continue the audit"

**Claude detects whats-next.md**:
```
📋 Loading session context...

Found incomplete orchestration:
- Command: /audit
- Progress: 50% (2/4 phases)
- Last session: 2025-11-19 (1 day ago)
- Next phase: Phase 3 - Penetration Testing

Load context and resume? (y/n)
```

**User**: `y`

**Execution resumes**:
```javascript
// Load all prior context
const priorReports = [
  await Read({ file_path: ".tresor/audit-2025-11-19/phase-1-security-auditor.md" }),
  await Read({ file_path: ".tresor/audit-2025-11-19/phase-1-dependency-auditor.md" }),
  await Read({ file_path: ".tresor/audit-2025-11-19/phase-1-compliance-officer.md" }),
  await Read({ file_path: ".tresor/audit-2025-11-19/phase-2-cloud-architect.md" }),
  await Read({ file_path: ".tresor/audit-2025-11-19/handoff-phase-2-to-3.md" })
];

// Launch Phase 3 with full context
await Task({
  subagent_type: "penetration-tester",
  prompt: `
You are Phase 3 of the /audit orchestration (resumed from previous session).

# Full Context from Phases 1-2
${priorReports.join("\n\n---\n\n")}

# Critical Vulnerabilities to Test
1. SQL injection in src/api/users.ts:45-67 (confirmed by @security-auditor)
2. Weak JWT in config/auth.js:12 (confirmed by @security-auditor)
3. Unencrypted S3 in infrastructure/s3.tf:34 (confirmed by @cloud-architect)

# Your Task
Perform active penetration testing to:
1. Confirm exploitability of identified vulnerabilities
2. Discover additional attack vectors
3. Assess blast radius of successful exploits

Report to: .tresor/audit-2025-11-19/phase-3-penetration-tester.md
  `
});
```

**Phase 3-4 Complete**:
```
✅ Phase 1: Security Scan - 10 issues found
✅ Phase 2: Infrastructure Review - 5 issues found
✅ Phase 3: Penetration Testing - 3 critical exploits confirmed
✅ Phase 4: Root Cause Analysis - Comprehensive RCA complete

🎉 Audit Complete!

Final Report: .tresor/audit-2025-11-19/final-report.md
Todos Created: 18
Prompts Generated: 2

Next Steps:
1. Review final report
2. Check todos: /check-todos
3. Execute prompts: /run-prompt 001, /run-prompt 002
4. Fix critical issues immediately
```

### Example 2: /check-todos with Orchestration Detection

**User**: `/todo-check`

**Output**:
```
📋 Analyzing todos...

Found 23 todos:

🚨 Incomplete Orchestrations (2):
1. [2025-11-19] Audit incomplete (Phase 3-4 remaining)
   → Resume: /audit --resume phase-3 --report-id audit-2025-11-19

2. [2025-11-18] Performance profiling incomplete (Phase 2-3 remaining)
   → Resume: /profile --resume phase-2 --report-id profile-2025-11-18

📝 Regular Todos (18):
From /audit orchestration:
1. [CRITICAL] Fix SQL injection in src/api/users.ts:45-67
   → Suggested: @security-auditor (confidence: 95%)

2. [HIGH] Upgrade lodash@4.17.15 (CVE-2020-8203)
   → Suggested: @dependency-auditor (confidence: 90%)

3. [HIGH] Implement GDPR consent flow
   → Suggested: Use /create-prompt for complex implementation
   → Then: /run-prompt 001

From /profile orchestration:
4. [MEDIUM] Optimize N+1 queries in user API
   → Suggested: @database-optimizer (confidence: 92%)

... (14 more todos)

Options:
1. Resume incomplete orchestration
2. Work on specific todo (invoke suggested agent)
3. Generate expert prompt for complex todo
4. View all todos
5. Exit

Choose (1-5):
```

**User selects**: `2` (work on todo #1)

**Agent auto-invoked**:
```javascript
await Task({
  subagent_type: "security-auditor",
  prompt: `
The user has resumed work on a todo from the /audit orchestration.

# Todo Context
Description: Fix SQL injection in src/api/users.ts:45-67
Severity: CRITICAL
Created By: Phase 1 - @security-auditor
Detected During: /audit (2025-11-19)

# Background Context
${await Read({ file_path: ".tresor/audit-2025-11-19/phase-1-security-auditor.md" })}

# Your Task
Fix the SQL injection vulnerability. Provide:
1. Exact code fix
2. Test to verify fix
3. Documentation update

After fixing, mark todo as complete.
  `
});
```

---

## Summary: Integration Architecture

### Tresor Workflow Integration ✅
- **Auto-capture**: Agents call `/todo-add` during execution
- **Phase batching**: Consolidated todos after each phase
- **Smart resumption**: `/todo-check` detects incomplete orchestrations
- **Meta-prompting**: Complex issues → `/prompt-create` → `/prompt-run`
- **Session handoff**: Auto-invokes `/handoff-create` with orchestration state

### Agent Documentation ✅
- **Phase reports**: Structured findings from each agent
- **Handoff docs**: Context transfer between phases
- **Status updates**: Real-time TodoWrite progress
- **Final report**: Consolidated results across all phases
- **Artifacts**: Scan results, remediation scripts, data exports

### Context Handoff ✅
- **Sequential phases**: Handoff docs with critical context
- **Parallel agents**: Shared context docs
- **Cross-session**: whats-next.md with full orchestration state
- **Agent coordination**: Clear interfaces between phases

### User Experience ✅
- **Transparency**: See real-time progress via TodoWrite
- **Control**: Confirm orchestration before execution
- **Resumability**: Pause/resume across sessions
- **Actionability**: Todos + prompts for all findings
- **Traceability**: Complete audit trail of work

---

## Next Steps

1. **Implement /audit** as proof of concept with full integration
2. **Test cross-session resumption** to validate handoff mechanisms
3. **Refine agent prompts** based on real-world results
4. **Document best practices** for future commands

Ready to build the first integrated command?
