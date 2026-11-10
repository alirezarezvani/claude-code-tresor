---
description: Phase 1 baseline test for api-tester
tags: [api-tester, phase-1]
max_turns: 20
timeout_seconds: 600
allowed_tools: [Read, Glob, Grep, Write, Agent]
---

Write Jest + supertest tests for this Express route and save them as users.test.js. Cover the success case and every error case.

```js
// app.js exports the Express app
app.post('/users', async (req, res) => {
  const { email, name } = req.body;
  if (!email || !name) return res.status(400).json({ error: 'email and name are required' });
  if (await db.users.exists(email)) return res.status(409).json({ error: 'email already registered' });
  const user = await db.users.create({ email, name });
  res.status(201).json(user);
});
```
