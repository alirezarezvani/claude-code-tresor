---
description: Phase 1 baseline test for database-optimizer
tags: [database-optimizer, phase-1]
max_turns: 10
timeout_seconds: 600
allowed_tools: [Read, Glob, Grep, Agent]
---

Our Django endpoint that lists 200 blog posts with their author name and comment count makes 401 database queries. Here is the code. Fix it and explain why it happened.

```python
def post_list(request):
    posts = Post.objects.all()[:200]
    data = [
        {"title": p.title, "author": p.author.name, "comments": p.comments.count()}
        for p in posts
    ]
    return JsonResponse(data, safe=False)
```
