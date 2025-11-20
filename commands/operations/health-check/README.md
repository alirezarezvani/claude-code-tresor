# `/health-check` - System Health Verification

> Comprehensive production monitoring with anomaly detection and alerting

**Version:** 2.7.0
**Category:** Operations / Monitoring
**Type:** Orchestration Command
**Estimated Duration:** 5-15 minutes

---

## Overview

The `/health-check` command performs comprehensive system health verification across all layers - application, database, infrastructure, and external dependencies. It detects anomalies, tracks trends, and generates alerts for critical issues.

---

## Key Features

- ✅ **Multi-Layer Health Checks** - Application, database, infrastructure, dependencies
- ✅ **Anomaly Detection** - Detect unusual patterns and degradation
- ✅ **Trend Analysis** - Compare current vs historical metrics
- ✅ **Business Metrics** - Verify key functionality working
- ✅ **Alert Generation** - Automated alerts for critical issues
- ✅ **Integration-Ready** - Works with PagerDuty, Slack, email

---

## Quick Start

```bash
# Standard health check
/health-check

# Comprehensive (includes anomaly detection)
/health-check --comprehensive

# Specific environment
/health-check --env production
```

---

## When to Use

**Scheduled (Automated):**
- Every 5-15 minutes in production
- After deployments (every 5 min for 1 hour)

**Manual (On-Demand):**
- Before deployments (verify environment healthy)
- After incidents (verify recovery)
- During performance issues (diagnose)
- Weekly comprehensive check (--comprehensive)

---

## Example Output

```
Health Check Complete! 💚

Overall Status: HEALTHY ✓

Application: HEALTHY ✓
- Error rate: 0.3% ✓
- P95 latency: 180ms ✓
- Services: 3/3 responding ✓

Database: HEALTHY ✓
- Connections: 15/100 (15%) ✓
- Cache hit: 97% ✓
- Replication lag: 2MB ✓

Infrastructure: HEALTHY ✓
- Nodes: 3/3 Ready ✓
- CPU: 55% ✓
- Memory: 68% ✓

Anomalies: 1 warning
⚠️ P95 latency trending up (+24% vs 7-day avg)

Recommendations:
- Monitor latency trend
- Run /profile if trend continues
```

---

## See Also

- **[/deploy-validate](../deploy-validate/)** - Pre-deployment validation
- **[/incident-response](../incident-response/)** - Incident management
- **[/profile](../../performance/profile/)** - Performance profiling

---

**Version:** 2.7.0
**Last Updated:** November 19, 2025
**Category:** Operations
**License:** MIT
**Author:** Alireza Rezvani
