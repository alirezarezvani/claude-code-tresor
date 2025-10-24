# Code Reviewer Skill

> Automatic code quality analysis that works in the background while you code

## Quick Start

### Installation

```bash
# If using Claude Code Tresor installation script:
./scripts/install.sh  # Select "y" for skills

# Manual installation:
cp -r skills/development/code-reviewer ~/.claude/skills/development/
claude --restart
```

### First Use

1. **Start Claude Code**
   ```bash
   claude
   ```

2. **Write some code** (it activates automatically)
   ```javascript
   // Create a file: test.js
   function getUserById(id) {
     return db.query('SELECT * FROM users WHERE id = ' + id);
   }
   ```

3. **Watch the magic! ✨**
   ```
   🤖 code-reviewer skill:
     🚨 CRITICAL: SQL injection vulnerability (test.js:2)
     💡 Use parameterized queries
     📖 Learn: Use prepared statements or ORM methods
   ```

## What It Does

### Automatic Analysis

The skill automatically analyzes your code as you write it, checking for:

- **Code Quality**: Style, patterns, anti-patterns
- **Potential Bugs**: Null checks, type issues, logic errors
- **Security Basics**: Hardcoded secrets, injection vulnerabilities
- **Best Practices**: Error handling, naming conventions

### Real-Time Feedback

Get instant feedback without interrupting your flow:
- ✅ Non-blocking background operation
- ✅ Fast analysis (< 1 second)
- ✅ Context-aware suggestions
- ✅ Severity-based prioritization

## Usage Examples

### Example 1: JavaScript Vulnerability Detection

```javascript
// You write:
const apiKey = 'sk_live_1234567890';

// Skill alerts:
🚨 CRITICAL: Hardcoded API key detected (line 1)
💡 Move to environment variable: process.env.API_KEY
📖 Never commit secrets to version control
```

### Example 2: TypeScript Type Safety

```typescript
// You write:
function calculateTotal(items: any[]) {
  return items.reduce((sum, item) => sum + item.price, 0);
}

// Skill alerts:
⚠️ HIGH: Using 'any' type reduces type safety (line 1)
💡 Define proper interface: items: CartItem[]
📋 MEDIUM: No null check on item.price (line 2)
```

### Example 3: React Best Practices

```jsx
// You write:
function UserList({ users }) {
  return (
    <div>
      {users.map(user => <UserCard user={user} />)}
    </div>
  );
}

// Skill alerts:
⚠️ HIGH: Missing key prop in list rendering (line 4)
💡 Add key prop: <UserCard key={user.id} user={user} />
📖 Keys help React identify which items changed
```

### Example 4: Python Error Handling

```python
# You write:
def get_user_email(user_id):
    user = database.users[user_id]
    return user['email']

# Skill alerts:
⚠️ HIGH: No error handling for KeyError (line 2, 3)
💡 Add try/except or use .get() method
📋 MEDIUM: Function lacks docstring (line 1)
```

## When to Use Sub-Agent

After the skill flags an issue, invoke the **@code-reviewer** sub-agent for deeper analysis:

### Scenario 1: Understanding the Issue

```
Skill: "⚠️ N+1 query pattern detected"

You: "@code-reviewer explain the N+1 query problem in detail"

Sub-Agent:
- Explains what N+1 queries are
- Shows performance impact with examples
- Provides 3 different solutions
- Recommends best approach for your stack
- Shows before/after code examples
```

### Scenario 2: Comprehensive Review

```
Skill: "Several issues found in auth.service.ts"

You: "@code-reviewer review auth.service.ts comprehensively"

Sub-Agent:
- Full security audit
- Architecture recommendations
- Performance optimization suggestions
- Best practice guidelines
- Refactoring roadmap
```

## Integration with Commands

### /review Command

The `/review` command aggregates skill findings with sub-agent analysis:

```bash
# Quick review (skill findings only)
# Skills auto-analyze as you code

# Comprehensive review (skills + sub-agents)
/review --scope staged --checks all

# Output includes:
# 1. Automatic skill findings (fast)
# 2. Deep sub-agent analysis (comprehensive)
# 3. Prioritized action plan
```

### /scaffold Command

When using `/scaffold`, the code-reviewer skill automatically validates generated code:

```bash
/scaffold react-component UserProfile --hooks --tests

# Skill automatically checks:
# - Generated component quality
# - Hook usage patterns
# - Test coverage adequacy
```

## Configuration

### Disabling the Skill

If you want to temporarily disable:

```bash
# Rename to disable
mv ~/.claude/skills/development/code-reviewer \
   ~/.claude/skills/development/code-reviewer.disabled

# Re-enable
mv ~/.claude/skills/development/code-reviewer.disabled \
   ~/.claude/skills/development/code-reviewer

# Restart
claude --restart
```

### Customizing Triggers

Edit the skill description to change when it activates:

```bash
# Edit SKILL.md
nano ~/.claude/skills/development/code-reviewer/SKILL.md

# Modify the description field in YAML frontmatter
# Add or remove trigger keywords
```

### Adding Custom Checks

Copy and customize:

```bash
# Create custom variant
cp -r ~/.claude/skills/development/code-reviewer \
      ~/.claude/skills/development/my-company-reviewer

# Edit SKILL.md to add:
# - Company-specific patterns
# - Team coding standards
# - Custom security rules
```

## Language-Specific Examples

### JavaScript/Node.js

```javascript
// Express.js route handler
app.post('/api/users', (req, res) => {
  const user = req.body;  // ⚠️ No validation!
  db.users.insert(user);
  res.json(user);
});

// Skill flags:
🚨 CRITICAL: No input validation (line 2)
⚠️ HIGH: No error handling (line 3)
💡 Add validation middleware and try/catch
```

### Python/Django

```python
# Django view
def create_user(request):
    username = request.POST['username']  # ⚠️ KeyError risk!
    password = request.POST['password']  # 🚨 Plain text!
    User.objects.create(username=username, password=password)

# Skill flags:
🚨 CRITICAL: Storing plain text password (line 3)
⚠️ HIGH: No error handling for missing POST data (line 2)
💡 Use request.POST.get() and hash passwords
```

### Go

```go
// HTTP handler
func getUser(w http.ResponseWriter, r *http.Request) {
    id := r.URL.Query().Get("id")
    query := "SELECT * FROM users WHERE id = " + id  // 🚨 SQL injection!
    rows, _ := db.Query(query)  // ⚠️ Ignored error!
}

// Skill flags:
🚨 CRITICAL: SQL injection vulnerability (line 3)
⚠️ HIGH: Error ignored (line 4)
💡 Use parameterized queries and handle errors
```

## Comparison with Sub-Agent

| Feature | code-reviewer Skill | @code-reviewer Sub-Agent |
|---------|---------------------|--------------------------|
| **Invocation** | Automatic | Manual |
| **Speed** | < 1 second | 5-10 seconds |
| **Depth** | Pattern matching | Comprehensive analysis |
| **Context** | Main thread | Separate context |
| **Best For** | Real-time feedback | Deep review & learning |
| **Output** | Quick alerts | Detailed reports with examples |

### When to Use Which?

**Use Skill (Automatic):**
- While actively coding
- Quick feedback on obvious issues
- Real-time security checks
- Before committing

**Use Sub-Agent (Manual):**
- After skill flags complex issues
- Planning refactoring
- Learning best practices
- Comprehensive PR reviews
- Architectural decisions

## Troubleshooting

### Skill Not Activating

**Check installation:**
```bash
ls ~/.claude/skills/development/code-reviewer/SKILL.md
# Should exist

cat ~/.claude/skills/development/code-reviewer/SKILL.md
# Check YAML frontmatter is valid
```

**Restart Claude:**
```bash
claude --restart
```

### Too Many Alerts

Adjust sensitivity by editing SKILL.md:

```yaml
# Make triggers more specific
description: ... Triggers on [add specific conditions]
```

### False Positives

The skill uses pattern matching, so occasional false positives are normal. For accurate analysis, invoke the **@code-reviewer** sub-agent.

## Sandboxing

### Without Sandboxing (Default)
- ✅ Full functionality
- ✅ Fast analysis
- ✅ Read access to project files

### With Sandboxing (Optional)
- ✅ Same functionality
- ✅ Filesystem restrictions (can only read project)
- ✅ No network access needed

**Configuration**: None required - works in both modes.

## Performance

- **Analysis time**: < 1 second per file
- **Memory usage**: Minimal (< 50MB)
- **CPU usage**: Low (background thread)
- **File size limit**: Works efficiently up to 5000 lines

Large files (>5000 lines) may take slightly longer but remain non-blocking.

## Best Practices

### 1. Don't Ignore Warnings

Every flagged issue is worth reviewing, even if you decide not to fix it immediately.

### 2. Use for Learning

When you don't understand a warning, invoke the sub-agent:
```
@code-reviewer why is [issue] a problem?
```

### 3. Combine with Testing

The skill complements **test-generator** skill:
- code-reviewer flags potential bugs
- test-generator suggests tests for those scenarios

### 4. Pre-Commit Checks

Before committing, let the skill analyze your changes:
```bash
git add .
# Skill automatically analyzes staged files
# Review warnings before committing
```

### 5. Team Consistency

Customize the skill for your team's standards and share via git:
```bash
# Add to project
mkdir -p .claude/skills/development/
cp -r ~/.claude/skills/development/code-reviewer .claude/skills/development/

# Commit
git add .claude/
git commit -m "Add team code review skill"
```

## FAQ

**Q: Does this replace manual code reviews?**
A: No, it's a first-pass automated check. Human review is still essential.

**Q: Can I customize the rules?**
A: Yes! Copy the skill and modify SKILL.md to add custom patterns.

**Q: Will it slow down my coding?**
A: No, it runs asynchronously in the background without blocking.

**Q: Does it work offline?**
A: Yes, no network access required.

**Q: Can I use multiple code-reviewer skills?**
A: Yes, create variants for different languages or frameworks.

## Related Skills

- **test-generator**: Auto-suggest tests for flagged issues
- **security-auditor**: Deeper security vulnerability scanning
- **git-commit-helper**: Generate commit messages from reviewed code

## Related Sub-Agents

- **@code-reviewer**: Comprehensive code review with examples
- **@test-engineer**: Test strategy for flagged issues
- **@architect**: Architectural review and refactoring

## Learn More

- [Skill Architecture](../../../ARCHITECTURE.md)
- [Customization Templates](../../TEMPLATES.md)
- [All Skills](../../README.md)
- [Getting Started](../../../GETTING-STARTED.md)

---

**Made with ❤️ for developers by Claude Code Tresor**
