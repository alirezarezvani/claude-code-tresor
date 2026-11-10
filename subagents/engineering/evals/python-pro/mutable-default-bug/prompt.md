---
description: Phase 1 baseline test for python-pro
tags: [python-pro, phase-1]
max_turns: 10
timeout_seconds: 600
allowed_tools: [Read, Glob, Grep, Agent]
---

Users report that items from one cart show up in other carts. Find the bug in this code and explain the fix in two or three sentences.

```python
class Cart:
    def __init__(self, owner, items=[]):
        self.owner = owner
        self.items = items

    def add(self, item):
        self.items.append(item)
```
