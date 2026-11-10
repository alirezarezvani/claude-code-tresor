---
description: Phase 1 baseline test for api-tester
tags: [api-tester, phase-1]
max_turns: 20
timeout_seconds: 600
allowed_tools: [Read, Glob, Grep, Write, Agent]
---

Write a k6 load test for GET https://api.example.com/v1/products that ramps up to 200 virtual users over 2 minutes, holds for 5 minutes, and fails if the 95th percentile response time goes over 300 ms or more than 1% of requests fail. Save it as load-test.js.
