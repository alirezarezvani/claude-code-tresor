---
description: Phase 1 baseline test for python-pro
tags: [python-pro, phase-1]
max_turns: 20
timeout_seconds: 600
allowed_tools: [Read, Glob, Grep, Write, Agent]
---

This script is slow because it fetches the URLs one after another. Rewrite it so the requests run concurrently with asyncio and httpx, keep type hints, and limit it to 10 requests at a time. Save the result as fetch.py and add a pytest test file test_fetch.py that mocks the HTTP calls.

```python
import requests

def fetch_all(urls):
    results = {}
    for url in urls:
        r = requests.get(url, timeout=10)
        results[url] = r.status_code
    return results
```
