---
name: test-generator
description: Automatically suggest tests for new functions and components. Use when new code is written, functions added, or user mentions testing. Creates test scaffolding with Jest, Vitest, Pytest patterns. Triggers on new functions, components, test requests, testing mentions.
allowed-tools: Read, Write, Edit
---

# Test Generator Skill

Auto-suggest tests when you write new code.

## When I Activate

- ✅ New function created
- ✅ New component added
- ✅ User mentions testing or tests
- ✅ Test file missing for implementation
- ✅ User asks "can you test this?"

## What I Generate

### Quick Test Scaffolding
- Basic happy path tests
- Null/undefined edge cases
- Simple error scenarios
- Framework-appropriate syntax (Jest/Vitest/Pytest)

### What I Don't Do
- Comprehensive test suites → Use **@test-engineer** sub-agent
- Integration tests → Use **@test-engineer** sub-agent
- E2E test design → Use **@test-engineer** sub-agent
- Test strategy planning → Use **@test-engineer** sub-agent

## Relationship with @test-engineer Sub-Agent

**Me (Skill):** Quick test scaffolding
**@test-engineer (Sub-Agent):** Comprehensive testing strategy

### Workflow
1. You write a function
2. I auto-generate basic test structure
3. You want full suite → Invoke **@test-engineer** sub-agent
4. Sub-agent creates comprehensive tests

## Examples

### JavaScript Function

```javascript
// You write:
function calculateDiscount(price, percentage) {
  if (price <= 0) throw new Error('Invalid price');
  return price * (percentage / 100);
}

// I auto-generate:
describe('calculateDiscount', () => {
  it('calculates discount correctly', () => {
    expect(calculateDiscount(100, 10)).toBe(10);
  });

  it('throws error for invalid price', () => {
    expect(() => calculateDiscount(0, 10)).toThrow('Invalid price');
  });

  it('handles zero percentage', () => {
    expect(calculateDiscount(100, 0)).toBe(0);
  });

  // TODO: Add more edge cases
  // Consider: negative percentages, decimal values, very large numbers
});
```

### React Component

```jsx
// You write:
function UserCard({ user, onEdit }) {
  return (
    <div className="user-card">
      <h2>{user.name}</h2>
      <button onClick={() => onEdit(user.id)}>Edit</button>
    </div>
  );
}

// I auto-generate:
import { render, screen, fireEvent } from '@testing-library/react';

describe('UserCard', () => {
  const mockUser = { id: 1, name: 'John Doe' };
  const mockOnEdit = jest.fn();

  it('renders user name', () => {
    render(<UserCard user={mockUser} onEdit={mockOnEdit} />);
    expect(screen.getByText('John Doe')).toBeInTheDocument();
  });

  it('calls onEdit with user id when button clicked', () => {
    render(<UserCard user={mockUser} onEdit={mockOnEdit} />);
    fireEvent.click(screen.getByText('Edit'));
    expect(mockOnEdit).toHaveBeenCalledWith(1);
  });

  // TODO: Add tests for edge cases
  // - Missing user data
  // - Undefined onEdit
  // - Long names (UI testing)
});
```

### Python Function

```python
# You write:
def fetch_user_data(user_id: int) -> dict:
    if user_id <= 0:
        raise ValueError("Invalid user ID")
    return db.query("SELECT * FROM users WHERE id = ?", [user_id])

# I auto-generate:
import pytest

def test_fetch_user_data_success():
    """Test successful user data retrieval"""
    result = fetch_user_data(1)
    assert isinstance(result, dict)
    assert 'id' in result

def test_fetch_user_data_invalid_id():
    """Test with invalid user ID"""
    with pytest.raises(ValueError, match="Invalid user ID"):
        fetch_user_data(0)

def test_fetch_user_data_negative_id():
    """Test with negative ID"""
    with pytest.raises(ValueError):
        fetch_user_data(-1)

# TODO: Add integration tests with database
# TODO: Test database connection failures
```

## Framework Detection

I automatically detect your testing framework:

- **JavaScript/TypeScript**: Jest, Vitest, Mocha
- **Python**: pytest, unittest
- **Java**: JUnit
- **Go**: testing package

Detection based on:
- package.json dependencies
- requirements.txt
- Existing test files
- Import statements

## Test Patterns

### Unit Tests
```javascript
// Function testing
test('adds numbers correctly', () => {
  expect(add(2, 3)).toBe(5);
});
```

### Component Tests
```jsx
// React component testing
test('button click triggers callback', () => {
  const onClick = jest.fn();
  render(<Button onClick={onClick} />);
  fireEvent.click(screen.getByRole('button'));
  expect(onClick).toHaveBeenCalled();
});
```

### Edge Cases
```javascript
// Boundary testing
test('handles empty input', () => {
  expect(processData([])).toEqual([]);
});

test('handles null input', () => {
  expect(processData(null)).toBeNull();
});
```

## When to Use Sub-Agent

Invoke **@test-engineer** for:
- Complete test suites (20+ tests)
- Integration test strategy
- E2E test planning
- Test coverage goals
- Complex mocking scenarios

**Example:**
```
Me: "Generated 3 basic tests for calculateDiscount()"
You: "@test-engineer create comprehensive test suite with all edge cases"
Sub-agent: [Creates 25+ tests covering all scenarios]
```

## Sandboxing Compatibility

**Works without sandboxing:** ✅ Yes
**Works with sandboxing:** ✅ Yes

- **Filesystem**: Writes test files to project
- **Network**: None required
- **Configuration**: None required

## Customization

Edit test templates:

```bash
cp -r ~/.claude/skills/development/test-generator \
      ~/.claude/skills/development/my-test-generator

# Edit SKILL.md to customize:
# - Test patterns
# - Framework preferences
# - Coverage expectations
```

## Integration with Commands

### /test-gen Command
```bash
/test-gen --file utils.js --framework jest --coverage 90

# Combines:
# 1. My quick scaffolding
# 2. @test-engineer comprehensive tests
# 3. Full test file generation
```

## Tips

1. **Let me scaffold first** - Review before invoking sub-agent
2. **Add TODOs** - I include TODO comments for complex cases
3. **Framework consistency** - I match your project's testing style
4. **Quick iteration** - Regenerate if not satisfied

## Related Tools

- **@test-engineer**: Comprehensive test suite creation
- **code-reviewer skill**: Flags code that needs testing
- **/test-gen command**: Full test generation workflow
