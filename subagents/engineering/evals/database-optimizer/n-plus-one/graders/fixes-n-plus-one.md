---
type: llm
---

PASS if the reply identifies the N+1 query problem, uses select_related('author') for the author and an annotation such as Count('comments') (or prefetch_related) for the comment count, so the endpoint runs a small constant number of queries.
FAIL if it only adds caching or pagination without removing the per-post queries.
