# Test Generator Skill

> Automatically generate test scaffolding for new functions and components

## Quick Start

```bash
# Write a function
function calculateTotal(items) {
  return items.reduce((sum, item) => sum + item.price, 0);
}

# Skill auto-generates tests:
describe('calculateTotal', () => {
  it('calculates total correctly', () => {
    expect(calculateTotal([{price: 10}, {price: 20}])).toBe(30);
  });

  it('handles empty array', () => {
    expect(calculateTotal([])).toBe(0);
  });
});
```

## What It Does

- ✅ Auto-detects new functions/components
- ✅ Generates basic test structure
- ✅ Includes happy path + edge cases
- ✅ Matches your testing framework
- ✅ Adds TODO comments for complex scenarios

## Frameworks Supported

- **JavaScript**: Jest, Vitest, Mocha
- **Python**: pytest, unittest
- **Java**: JUnit
- **Go**: testing package

## When to Use @test-engineer

**Skill**: Quick scaffolding (3-5 tests)
**Sub-Agent**: Comprehensive suite (20+ tests, integration, E2E)

```
Skill: Generates basic tests
↓
You: @test-engineer create comprehensive suite
↓
Sub-Agent: 25+ tests with mocks, integration tests, edge cases
```

## Integration

Works with:
- **code-reviewer skill**: Suggests tests for flagged code
- **@test-engineer sub-agent**: Comprehensive test strategy
- **/test-gen command**: Full test generation workflow

## Customization

```bash
# Copy and modify
cp -r ~/.claude/skills/development/test-generator \
      ~/.claude/skills/development/my-test-generator
```

See [SKILL.md](SKILL.md) for full documentation.
