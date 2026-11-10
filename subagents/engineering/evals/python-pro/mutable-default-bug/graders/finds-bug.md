---
type: llm
---

PASS if the reply says the default list `items=[]` is created once and shared by every Cart, and fixes it with a `None` default (or an equivalent that creates a new list per instance).
FAIL if the reply blames something else or keeps a shared mutable default.
