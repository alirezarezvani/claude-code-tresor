---
type: regex
target: { source: file, path: fetch.py }
pattern: 'async def[\s\S]*asyncio\.(gather|TaskGroup)|TaskGroup[\s\S]*async def'
---
