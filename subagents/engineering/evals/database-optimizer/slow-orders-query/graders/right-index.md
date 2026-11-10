---
type: llm
---

PASS if the reply proposes an index that leads with customer_id and includes created_at in descending or usable order, for example `CREATE INDEX ... ON orders (customer_id, created_at DESC)`, optionally partial on status or covering the selected columns, and suggests checking the plan with EXPLAIN ANALYZE.
FAIL if it proposes only an index on status, or no concrete index.
