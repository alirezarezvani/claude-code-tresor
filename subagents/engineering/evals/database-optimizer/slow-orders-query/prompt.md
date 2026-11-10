---
description: Phase 1 baseline test for database-optimizer
tags: [database-optimizer, phase-1]
max_turns: 10
timeout_seconds: 600
allowed_tools: [Read, Glob, Grep, Agent]
---

This PostgreSQL query takes 4 seconds on a 20 million row table and runs on every page load of our order history screen. How do I make it fast? Give the exact index or query changes.

```sql
-- orders(id bigserial primary key, customer_id bigint, status text, created_at timestamptz, total numeric)
-- existing indexes: primary key only
SELECT id, status, total, created_at
FROM orders
WHERE customer_id = $1 AND status <> 'cancelled'
ORDER BY created_at DESC
LIMIT 20;
```
