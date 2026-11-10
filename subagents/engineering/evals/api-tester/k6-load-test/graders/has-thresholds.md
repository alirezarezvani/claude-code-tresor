---
type: regex
target: { source: file, path: load-test.js }
pattern: 'thresholds[\s\S]*p\(95\)\s*<\s*300[\s\S]*rate\s*<\s*0\.01|thresholds[\s\S]*rate\s*<\s*0\.01[\s\S]*p\(95\)\s*<\s*300'
---
