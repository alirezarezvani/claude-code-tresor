# Frequently Asked Questions

Common questions about Claude Code Tresor.

## General Questions

### What is Claude Code Tresor?

Claude Code Tresor is a comprehensive collection of professional-grade utilities for Claude Code CLI, including:

- **8 Autonomous Skills** - Automatic background helpers (code-reviewer, security-auditor, etc.)
- **8 Specialized Agents** - Expert sub-agents for deep analysis (@code-reviewer, @test-engineer, etc.)
- **4 Essential Commands** - Workflow automation (/scaffold, /review, /test-gen, /docs-gen)
- **20+ Prompt Templates** - Production-ready prompts for common scenarios
- **Development Standards** - Style guides, Git workflows, collaboration guidelines

**Think of it as:** A professional toolkit that augments Claude Code with specialized experts and automation.

---

### Who created Claude Code Tresor?

**Author:** Alireza Rezvani
**License:** MIT
**Repository:** https://github.com/alirezarezvani/claude-code-tresor
**Contact:** rezvani@gmail.com

---

### Is Claude Code Tresor free?

Yes! Claude Code Tresor is **open source** under the MIT License:
- ✅ Free for personal use
- ✅ Free for commercial use
- ✅ No attribution required (but appreciated!)
- ✅ Modify and redistribute freely

---

## Skills, Agents, and Commands

### What's the difference between skills, agents, and commands?

| Feature | Skills | Agents | Commands |
|---------|--------|--------|----------|
| **Invocation** | Automatic | Manual (`@agent`) | Manual (`/command`) |
| **When to use** | Continuous monitoring | Deep analysis | Workflows |
| **Tool access** | Limited (safe) | Full access | Orchestrates |
| **Context** | Shared | Separate | Coordinates |
| **Examples** | code-reviewer (skill) | @code-reviewer (agent) | /review (command) |

**Simple explanation:**
- **Skills** = Automatic helpers (always watching)
- **Agents** = Expert consultants (call when needed)
- **Commands** = Workflow automation (multi-step processes)

---

### When should I use a skill vs. an agent vs. a command?

**Use Skills when:**
- ✅ You want automatic, continuous monitoring
- ✅ You need real-time suggestions while coding
- ✅ You want lightweight, non-blocking feedback

**Example:** Let code-reviewer skill monitor your code as you work.

---

**Use Agents when:**
- ✅ You need deep, comprehensive analysis
- ✅ You have a specific complex question
- ✅ You need expert guidance on architecture/design
- ✅ You're debugging a complex issue

**Example:** `@architect design a scalable microservices architecture`

---

**Use Commands when:**
- ✅ You need to automate a multi-step workflow
- ✅ You want to coordinate multiple agents
- ✅ You're running a standardized process (scaffolding, review, testing)

**Example:** `/review --scope all --checks security,performance`

---

### How do skills work?

Skills are **conversation-based autonomous helpers** that activate automatically:

**How they activate:**
1. You save a file with code changes
2. Skill detects the change (based on file patterns)
3. Skill analyzes the code
4. Skill provides suggestions in conversation

**Example:**
```
You: [Saves UserProfile.tsx with missing error handling]

code-reviewer skill: "⚠️ Missing error handling in async function.
Suggestion: Add try-catch block to handle API failures."
```

**Key points:**
- ✅ NO manual invocation needed
- ✅ Works in background continuously
- ✅ Provides suggestions without interrupting
- ✅ Limited tool access for safety

---

### How do I invoke an agent?

Use `@agent-name` syntax:

```
@code-reviewer analyze src/api/users.controller.ts for security issues
```

**Tips for better results:**
- Be specific about what you want
- Provide context (production, requirements, constraints)
- Specify focus areas

**Example:**
```
@architect design user authentication system

Requirements:
- 10k concurrent users
- JWT tokens
- Refresh token mechanism
- Rate limiting

Constraints:
- Node.js/Express
- PostgreSQL
- 2-week timeline
```

---

### How do I run a command?

Use `/command-name` syntax with options:

```
/review --scope staged --checks security,performance
```

**Get help:**
```
/review --help
```

**Common commands:**
```bash
# Scaffold components
/scaffold react-component UserProfile --typescript --tests

# Code review
/review --scope all --checks all

# Generate tests
/test-gen --file src/utils/helpers.ts --coverage 90

# Generate documentation
/docs-gen api --format openapi
```

---

## Installation & Setup

### How do I install Claude Code Tresor?

**Full installation (recommended):**
```bash
git clone https://github.com/alirezarezvani/claude-code-tresor.git
cd claude-code-tresor
./scripts/install.sh
```

**Selective installation:**
```bash
./scripts/install.sh --skills    # 8 skills only
./scripts/install.sh --agents    # 8 agents only
./scripts/install.sh --commands  # 4 commands only
```

**[Complete installation guide →](../guides/installation.md)**

---

### What gets installed where?

- **Skills:** `~/.claude/skills/`
- **Agents:** `~/.claude/agents/`
- **Commands:** `~/.claude/commands/`
- **Prompts:** `~/.claude/prompts/`
- **Standards:** `~/.claude/standards/`

**Repository stays separate** at `~/claude-code-tresor/` (or wherever you cloned it).

---

### Do I need to keep the repository after installation?

**Yes, recommended** for:
- Updates (`git pull && ./scripts/update.sh`)
- Reference documentation
- Examples and templates

**But not required** - installed utilities work independently.

---

### How do I update Claude Code Tresor?

```bash
cd claude-code-tresor
git pull origin main
./scripts/update.sh
```

Preserves your customizations while updating utilities.

---

### Can I uninstall Claude Code Tresor?

Yes:

```bash
# Remove all components
rm -rf ~/.claude/skills/code-reviewer
rm -rf ~/.claude/skills/test-generator
# ... (remove all skills)

rm -rf ~/.claude/agents/code-reviewer
# ... (remove all agents)

rm -rf ~/.claude/commands/scaffold
# ... (remove all commands)

# Remove repository
rm -rf ~/claude-code-tresor
```

**[Complete uninstall instructions →](../guides/installation.md#uninstallation)**

---

## Configuration & Customization

### Can I customize skills/agents/commands?

**Yes!** Edit configuration files:

**Skills:**
```bash
vi ~/.claude/skills/code-reviewer/SKILL.md
# Edit YAML frontmatter
```

**Agents:**
```bash
vi ~/.claude/agents/code-reviewer/SKILL.md
# Edit YAML frontmatter
```

**Commands:**
```bash
vi ~/.claude/commands/review/command.json
# Edit JSON configuration
```

**[Complete configuration guide →](../guides/configuration.md)**

---

### Can I create my own skills/agents/commands?

**Absolutely!** Follow our guides:

- **[Creating Skills →](../guides/contributing.md#creating-a-skill)**
- **[Creating Agents →](../guides/contributing.md#creating-an-agent)**
- **[Creating Commands →](../guides/contributing.md#creating-a-command)**

---

### Can I disable specific skills?

Yes, set `enabled: false` in skill configuration:

```yaml
---
name: "readme-updater"
enabled: false  # Skill disabled
---
```

Restart Claude Code for changes to take effect.

---

### How do I configure file patterns for skills?

Edit skill's YAML frontmatter:

```yaml
---
name: "code-reviewer"
file_patterns:
  - "src/**/*.ts"      # Only TypeScript in src/
  - "src/**/*.tsx"
exclude_patterns:
  - "*.test.*"         # Exclude tests
  - "*.stories.*"      # Exclude Storybook
  - "node_modules/**"  # Exclude dependencies
---
```

---

## Troubleshooting

### Skills not activating - why?

**Common causes:**

1. **Skill disabled:**
```yaml
---
enabled: false  # Change to true
---
```

2. **File patterns don't match:**
```yaml
---
file_patterns:
  - "*.ts"  # Does this match your files?
---
```

3. **File excluded:**
```yaml
---
exclude_patterns:
  - "node_modules/**"  # Is your file here?
---
```

4. **Need to restart:** Restart Claude Code CLI

**[Complete troubleshooting →](../guides/troubleshooting.md#skill-issues)**

---

### Agent not found - what's wrong?

**Solutions:**

```bash
# 1. Check agent exists
ls ~/.claude/agents/code-reviewer/

# 2. Verify configuration
cat ~/.claude/agents/code-reviewer/SKILL.md

# 3. Check enabled field
---
enabled: true  # Must be true
---

# 4. Restart Claude Code
```

**[Complete troubleshooting →](../guides/troubleshooting.md#agent-issues)**

---

### Command not working - how to fix?

**Solutions:**

```bash
# 1. Check command exists
ls ~/.claude/commands/review/

# 2. Verify configuration
cat ~/.claude/commands/review/command.json

# 3. Try full path
/workflow/review  # Instead of /review

# 4. Check syntax
/review --help  # Show correct usage

# 5. Restart Claude Code
```

**[Complete troubleshooting →](../guides/troubleshooting.md#command-issues)**

---

### Too many skill suggestions - how to reduce?

**Option 1: Lower priority:**
```yaml
---
name: "code-reviewer"
priority: "low"  # Changed from "high"
---
```

**Option 2: Disable temporarily:**
```yaml
---
name: "readme-updater"
enabled: false
---
```

**Option 3: Narrow scope:**
```yaml
---
name: "test-generator"
file_patterns:
  - "src/**/*.ts"  # Only src/ directory
exclude_patterns:
  - "*.test.*"     # Exclude existing tests
---
```

---

## Migration

### How do I migrate from v1.0 to v2.0?

**Major changes:**
- **NEW:** 8 autonomous skills
- **CHANGED:** Agent syntax (`rr-` → `@`)
- **CHANGED:** Directory structure

**Migration steps:**
```bash
cd claude-code-tresor
git pull origin main
./scripts/migrate-v1-to-v2.sh
```

**[Complete migration guide →](../guides/migration.md)**

---

### What's the new agent syntax?

**v1.0 (old):**
```
rr-code-reviewer analyze this
```

**v2.0 (new):**
```
@code-reviewer analyze this
```

---

## Performance & Limits

### Do skills slow down Claude Code?

**No - skills are lightweight:**
- Limited tool access (Read, Write, Edit, Grep, Glob only)
- Efficient conversation-based activation
- Run in background without blocking

**If experiencing slowness:**
- Reduce active skills (disable non-essential)
- Narrow file patterns (monitor fewer files)
- Use Sonnet model instead of Opus for skills

---

### How many skills/agents can I have?

**No hard limit**, but practical recommendations:

- **Skills:** 5-10 active skills (more = more suggestions)
- **Agents:** Unlimited (invoked manually as needed)
- **Commands:** Unlimited

**Balance:** More skills = more feedback but potentially overwhelming.

---

### Can I run multiple commands simultaneously?

**Generally no** - commands orchestrate workflows sequentially.

**Exception:** If commands are independent (different scopes).

**Recommendation:** Run commands one at a time for best results.

---

## Contributing & Community

### How can I contribute?

**Ways to contribute:**
1. **Report bugs** - [GitHub Issues →](https://github.com/alirezarezvani/claude-code-tresor/issues)
2. **Suggest features** - [GitHub Discussions →](https://github.com/alirezarezvani/claude-code-tresor/discussions)
3. **Create skills/agents/commands** - [Contributing Guide →](../guides/contributing.md)
4. **Improve documentation** - Submit PRs for documentation
5. **Share prompts/templates** - Contribute useful patterns
6. **Review PRs** - Help review community contributions

**[Complete contributing guide →](../guides/contributing.md)**

---

### Where can I get help?

**Resources:**
- **[Troubleshooting Guide →](../guides/troubleshooting.md)** - Fix common issues
- **[This FAQ →](faq.md)** - Quick answers
- **[GitHub Discussions →](https://github.com/alirezarezvani/claude-code-tresor/discussions)** - Ask questions
- **[GitHub Issues →](https://github.com/alirezarezvani/claude-code-tresor/issues)** - Report bugs

---

### Is there a community?

**Yes!**
- **[GitHub Discussions →](https://github.com/alirezarezvani/claude-code-tresor/discussions)** - Community forum
- **[Contributors →](../../CONTRIBUTORS.md)** - Meet the community

---

## Advanced Topics

### Can skills invoke agents?

**Yes**, through coordination configuration:

```yaml
---
name: "code-reviewer"
coordination:
  invoke_agents:
    - agent: "@security-auditor"
      when: "security_issue_detected"
---
```

**Future feature** - currently skills suggest agent invocation to user.

---

### Can agents invoke other agents?

**Yes**, using the Task tool:

```
@architect design system
[Invokes @security-auditor for security review]
[Invokes @performance-tuner for optimization]
```

---

### Can I use Claude Code Tresor with other Claude Code extensions?

**Yes!** Claude Code Tresor is designed to work alongside:
- Other skills
- Other agents
- Other commands
- MCP servers

**Potential conflicts:**
- Skills with similar names (ensure unique names)
- Commands with same name (use unique names)

---

### Does Claude Code Tresor work offline?

**Partially:**
- ✅ Configuration and documentation accessible offline
- ✅ Templates and standards available offline
- ❌ Skills/agents/commands require Claude AI (online)

---

## Still Have Questions?

**Can't find your answer?**

1. **[Search Documentation →](../README.md)** - Browse complete docs
2. **[Ask Community →](https://github.com/alirezarezvani/claude-code-tresor/discussions)** - Post question
3. **[Report Issue →](https://github.com/alirezarezvani/claude-code-tresor/issues)** - If you found a bug

---

**Last Updated:** November 7, 2025 | **Version:** 2.0.0
