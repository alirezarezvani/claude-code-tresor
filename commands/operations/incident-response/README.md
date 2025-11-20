# `/incident-response` - Production Incident Coordination

> Emergency incident management with triage, investigation, RCA, and blameless postmortems

**Version:** 2.7.0
**Category:** Operations / Incident Management
**Type:** Orchestration Command
**Estimated Duration:** 30 minutes - 2 hours

---

## Overview

The `/incident-response` command orchestrates production incident response from emergency triage through comprehensive RCA and postmortem generation. It coordinates multiple specialist agents for rapid investigation and provides structured incident documentation.

---

## Key Features

- ✅ **Emergency Triage** - Immediate assessment and mitigation (5-10 min)
- ✅ **Parallel Investigation** - 3 specialists investigate simultaneously
- ✅ **Comprehensive RCA** - Detailed root cause analysis with timeline
- ✅ **Blameless Postmortems** - Professional incident documentation
- ✅ **Action Item Tracking** - Preventive measures automatically captured
- ✅ **Integration-Ready** - PagerDuty, Slack, JIRA integration

---

## Quick Start

```bash
# Start incident response
/incident-response

# System asks:
# - Severity? (P0/P1/P2)
# - Symptoms? (high error rate, service down, slow performance, etc.)

# For known severity:
/incident-response --severity p0

# Generate postmortem after resolution:
/incident-response --severity p1 --postmortem
```

---

## When to Use

**Use `/incident-response` when:**
- Production service is down or degraded
- High error rates affecting users
- Performance significantly degraded
- Data corruption detected
- Security incident suspected

**4-Phase Response:**
1. **Triage** (5-10 min) - Assess, mitigate immediately
2. **Investigation** (20-30 min) - Find root cause
3. **RCA** (30-45 min) - Comprehensive analysis
4. **Postmortem** (20-30 min) - Document learnings

---

## Example Output

```
Incident Response Complete!

Incident ID: incident-2025-11-19-210000
Severity: P0 - CRITICAL
Duration: 15 minutes
Status: RESOLVED

Root Cause:
Database migration added NOT NULL constraint without data validation

Impact:
- Users: 5,000 affected (100%)
- Revenue loss: ~$125
- Support tickets: 47

Resolution:
Rolled back deployment

Action Items: 6 preventive measures
- Add migration validation
- Automated rollback
- Improve test data
- Lower alert threshold
- Synthetic monitoring
- Rollback runbook

Postmortem: .tresor/incident-*/postmortem.md
```

---

## Incident Severity Levels

### P0 - Critical (Response: Immediate)
- Service completely down
- All users affected
- Data loss occurring
- Security breach

**Response Time:** < 5 minutes
**Escalation:** Page on-call immediately

---

### P1 - High (Response: < 1 hour)
- Major functionality broken
- Significant user subset affected
- Revenue impact
- No workaround available

**Response Time:** < 1 hour
**Escalation:** Slack alert

---

### P2 - Medium (Response: < 4 hours)
- Minor functionality broken
- Limited user impact
- Workaround available
- Non-critical feature

**Response Time:** < 4 hours
**Escalation:** Email/Slack

---

## Integration with Other Commands

### `/health-check` Integration
```bash
# During incident:
/health-check --comprehensive
# → Provides current system health snapshot

# Integrate health data into incident investigation
```

### `/profile` Integration
```bash
# If performance incident:
/incident-response
# → Identifies it's performance-related

# After resolution:
/profile --layers backend,database
# → Deep-dive into performance bottleneck
```

---

## See Also

- **[/health-check](../health-check/)** - System health verification
- **[/deploy-validate](../deploy-validate/)** - Pre-deployment validation
- **[Root Cause Analyzer Agent](../../../subagents/core/root-cause-analyzer/)** - RCA specialist

---

**Version:** 2.7.0
**Last Updated:** November 19, 2025
**Category:** Operations
**License:** MIT
**Author:** Alireza Rezvani
