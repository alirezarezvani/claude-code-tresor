---
description: Phase 1 baseline test for content-writer
tags: [content-writer, phase-1]
max_turns: 20
timeout_seconds: 600
allowed_tools: [Read, Glob, Grep, Write, Agent]
---

Turn these commit messages into short user-facing release notes for version 3.2, grouped into New, Improved and Fixed, and save them as RELEASE-NOTES.md:

- feat(export): add CSV export to reports page
- fix(auth): session expired after 5 min instead of 60
- perf(search): cache search index, 3x faster first query
- chore(deps): bump lodash
- fix(ui): date picker showed wrong week start for de-DE
