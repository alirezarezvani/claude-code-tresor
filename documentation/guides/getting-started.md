# Getting Started

Welcome to Claude Code Tresor! This guide walks you through your first steps.

## Quick Start (5 Minutes)

### 1. Install Claude Code Tresor

```bash
git clone https://github.com/alirezarezvani/claude-code-tresor.git
cd claude-code-tresor
./scripts/install.sh
```

**[Detailed installation instructions →](installation.md)**

---

### 2. Verify Installation

```bash
# Check skills
ls ~/.claude/skills/

# Check agents
ls ~/.claude/agents/

# Check commands
ls ~/.claude/commands/
```

You should see 8 skills, 8 agents, and 4 commands.

---

### 3. Start Claude Code

```bash
claude
```

You're ready to use Claude Code Tresor!

---

## Understanding the Components

Claude Code Tresor has **three types of utilities**:

### Skills (Automatic Background Helpers)

**What they are:**
- Autonomous helpers that work continuously
- Activate automatically based on code changes
- Provide real-time suggestions

**How they work:**
- NO manual invocation needed
- Trigger when you save files or make commits
- Appear as suggestions in conversations

**Example:**
```
You: [Saves UserProfile.tsx with security issue]
code-reviewer skill: "⚠️ Security issue detected: User input not sanitized"
```

**8 Available Skills:**
1. code-reviewer - Code quality checks
2. test-generator - Test coverage suggestions
3. git-commit-helper - Commit message generation
4. security-auditor - Vulnerability scanning
5. secret-scanner - API key detection
6. dependency-auditor - CVE checking
7. api-documenter - OpenAPI spec generation
8. readme-updater - README updates

---

### Agents (Expert Specialists)

**What they are:**
- Deep analysis experts for specific domains
- Invoked manually with `@agent-name`
- Full tool access for comprehensive work

**How they work:**
```
@agent-name task description
```

**Example:**
```
@code-reviewer analyze this component for React best practices and security issues
```

**8 Available Agents:**
1. @code-reviewer - Code quality expert
2. @test-engineer - Testing specialist
3. @docs-writer - Documentation expert
4. @architect - System design expert
5. @debugger - Debugging specialist
6. @security-auditor - Security expert
7. @performance-tuner - Performance optimization
8. @refactor-expert - Code refactoring

---

### Commands (Workflow Automation)

**What they are:**
- Orchestrated workflows combining multiple steps
- Invoked with `/command-name`
- Can invoke agents and coordinate tasks

**How they work:**
```
/command-name --option value
```

**Example:**
```
/review --scope staged --checks security,performance
```

**4 Available Commands:**
1. /scaffold - Project/component scaffolding
2. /review - Code review automation
3. /test-gen - Test generation
4. /docs-gen - Documentation generation

---

## Typical Workflow

Here's how skills, agents, and commands work together:

### Scenario: Adding a New Feature

**Step 1: Skill Detects Issues (Automatic)**
```
You: [Writes new UserProfile component]
You: [Saves file]
code-reviewer skill: "Suggestion: Add PropTypes validation"
test-generator skill: "Missing tests for UserProfile component"
```

**Step 2: Use Agent for Deep Analysis (Manual)**
```
You: @code-reviewer analyze UserProfile.tsx for production readiness

@code-reviewer:
✅ Code structure follows React best practices
⚠️ Missing error boundaries
⚠️ No accessibility attributes
❌ Security: User input not sanitized
[Detailed analysis with code examples]
```

**Step 3: Run Command for Complete Workflow (Manual)**
```
You: /review --scope UserProfile.tsx --checks all

/review:
1. Running code quality checks...
2. Running security audit...
3. Running performance analysis...
4. Generating report...
[Complete review report with action items]
```

---

## Your First Workflow

Let's walk through a complete real-world example.

### Example: Create and Review a React Component

**Step 1: Create Component**
```bash
# Create new file
touch src/components/LoginForm.tsx
```

**Step 2: Write Code**
```typescript
// src/components/LoginForm.tsx
import React, { useState } from 'react';

export default function LoginForm() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  const handleSubmit = (e) => {
    e.preventDefault();
    fetch('/api/login', {
      method: 'POST',
      body: JSON.stringify({ email, password })
    });
  };

  return (
    <form onSubmit={handleSubmit}>
      <input value={email} onChange={(e) => setEmail(e.target.value)} />
      <input value={password} onChange={(e) => setPassword(e.target.value)} />
      <button type="submit">Login</button>
    </form>
  );
}
```

**Step 3: Skills Activate Automatically**
```
code-reviewer skill: "⚠️ Issues detected:"
- Missing input labels (accessibility)
- No error handling
- Password not type="password"
- Missing CSRF protection

security-auditor skill: "🔴 Critical security issues:"
- Credentials sent without HTTPS validation
- No rate limiting
- Password visible in DOM

test-generator skill: "📋 Suggested tests:"
- Test form submission
- Test validation
- Test error states
```

**Step 4: Deep Analysis with Agent**
```
You: @code-reviewer provide complete analysis with fixes

@code-reviewer:
Here's a production-ready version:

[Provides complete refactored code with:]
- TypeScript types
- Input validation
- Error handling
- Accessibility attributes
- Security improvements
- Loading states
```

**Step 5: Generate Tests**
```
You: /test-gen --file LoginForm.tsx --framework jest

/test-gen:
✅ Generated LoginForm.test.tsx with:
- 12 test cases
- 95% code coverage
- Edge case testing
- Accessibility testing
```

**Step 6: Final Review**
```
You: /review --scope LoginForm.tsx --checks all

/review:
✅ Code Quality: PASS
✅ Security: PASS
✅ Performance: PASS
✅ Accessibility: PASS
✅ Test Coverage: 95%
Ready for production!
```

---

## Common First Tasks

### Task 1: Test a Skill (Automatic)

**Skills activate automatically** - just work normally:

```bash
# Create a file with an issue
echo "const x = 1; x = 2;" > test.js

# Save it - skill activates automatically
# code-reviewer will suggest: "Use let instead of const for reassignment"
```

**No manual invocation needed!**

---

### Task 2: Test an Agent (Manual)

```
You: @architect design a microservices architecture for an e-commerce platform

@architect:
I'll design a scalable microservices architecture...

[Provides detailed architecture with:]
- Service boundaries
- API contracts
- Database strategy
- Deployment topology
- Mermaid diagrams
```

---

### Task 3: Test a Command (Manual)

```
You: /scaffold react-component ProductCard --typescript --tests

/scaffold:
✅ Created src/components/ProductCard.tsx
✅ Created src/components/ProductCard.test.tsx
✅ Added exports to index.ts
✅ Generated Storybook story
```

---

## Learning Path

Follow this recommended learning path:

### Week 1: Basics
1. ✅ Install Claude Code Tresor
2. ✅ Complete this guide
3. 📖 Read [FAQ](../reference/faq.md)
4. 🎯 Practice: Let skills work automatically for 1 week

### Week 2: Agents
1. 📖 Read [Agents Reference](../reference/agents-reference.md)
2. 🎯 Practice: Use each agent once
3. 🎯 Project: Analyze existing codebase with @code-reviewer

### Week 3: Commands
1. 📖 Read [Commands Reference](../reference/commands-reference.md)
2. 🎯 Practice: Use each command
3. 🎯 Project: Scaffold complete feature with /scaffold

### Week 4: Advanced
1. 📖 Read [Configuration Guide](configuration.md)
2. 🎯 Customize skills for your workflow
3. 🎯 Create custom agent or command
4. 📖 Read [Contributing Guide](contributing.md)

---

## Common Patterns

### Pattern 1: Code Review Workflow

```
1. Write code normally
2. Skills provide real-time feedback (automatic)
3. For deeper review: @code-reviewer analyze
4. For complete audit: /review --scope staged
5. Fix issues
6. Commit with /review --pre-commit
```

---

### Pattern 2: Testing Workflow

```
1. Write feature code
2. test-generator skill suggests tests (automatic)
3. Generate tests: /test-gen --file MyComponent.tsx
4. Review tests: @test-engineer review generated tests
5. Run tests
6. Check coverage
```

---

### Pattern 3: Documentation Workflow

```
1. Write/update code
2. api-documenter skill suggests docs (automatic)
3. Generate docs: /docs-gen api --format openapi
4. Review docs: @docs-writer review API documentation
5. Update README: readme-updater skill (automatic)
```

---

## Tips for Success

### 1. Let Skills Work Automatically
Don't manually invoke skills - they work best when monitoring your work continuously.

### 2. Use Agents for Deep Work
When you need comprehensive analysis or complex tasks, invoke agents with `@agent-name`.

### 3. Use Commands for Workflows
For multi-step processes (scaffold, review, test, docs), use `/command-name`.

### 4. Combine All Three
The real power comes from combining skills (automatic) + agents (analysis) + commands (workflows).

### 5. Start Simple
Don't try to use everything at once. Start with skills, then add agents, then commands.

---

## Next Steps

### Essential Reading
1. **[Configuration Guide →](configuration.md)** - Customize behavior
2. **[FAQ →](../reference/faq.md)** - Common questions
3. **[Troubleshooting →](troubleshooting.md)** - Fix issues

### Deep Dives
1. **[Skills Reference →](../reference/skills-reference.md)** - Complete skill docs
2. **[Agents Reference →](../reference/agents-reference.md)** - Complete agent docs
3. **[Commands Reference →](../reference/commands-reference.md)** - Complete command docs

### Advanced Topics
1. **[Contributing →](contributing.md)** - Create custom utilities
2. **[Migration Guide →](migration.md)** - Version upgrades
3. **[Workflows →](../workflows/)** - Advanced patterns

---

## Getting Help

**Questions?**
- **[FAQ →](../reference/faq.md)** - Quick answers
- **[Troubleshooting →](troubleshooting.md)** - Fix issues
- **[GitHub Discussions →](https://github.com/alirezarezvani/claude-code-tresor/discussions)** - Community help

**Found a bug?**
- **[GitHub Issues →](https://github.com/alirezarezvani/claude-code-tresor/issues)** - Report bugs

**Want to contribute?**
- **[Contributing Guide →](contributing.md)** - Get started

---

**Last Updated:** November 7, 2025 | **Version:** 2.0.0
