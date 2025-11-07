# Getting Started

> **Get productive with Claude Code Tresor in 5 minutes**

This guide gets you from zero to productive quickly. Choose your path based on what you need most.

---

## ⚡ Quick Start (2 minutes)

### Installation

```bash
# Clone repository
git clone https://github.com/YOUR_USERNAME/claude-code-tresor.git
cd claude-code-tresor

# Install everything (recommended for first time)
./scripts/install.sh

# Or selective installation:
./scripts/install.sh --skills-only      # Skills only
./scripts/install.sh --agents-only      # Sub-agents only
./scripts/install.sh --commands-only    # Commands only
```

### Verify Installation

```bash
# Check installed components
ls ~/.claude/skills/          # 8 skills
ls ~/.claude/agents/          # 8 sub-agents
ls ~/.claude/commands/        # 4 commands

# Test a skill (skills work automatically when coding)
# Test a sub-agent
claude "@code-reviewer Analyze this file"

# Test a command
claude "/scaffold react-component Button"
```

**✅ You're ready!** Skills are available and Claude will invoke them during conversations when relevant.

---

## 🎯 Choose Your Path

### Path 1: "I want proactive code quality suggestions"

**What you get:** Skills that Claude invokes during code discussions

```bash
# 1. Install skills
./scripts/install.sh --skills

# 2. Start Claude Code and discuss your code
# Skills are invoked by Claude when contextually relevant:
# - code-reviewer: Suggests improvements during code discussions
# - security-auditor: Flags vulnerabilities when reviewing security
# - test-generator: Suggests tests when discussing new functions

# Example: Discuss code with Claude
claude
> "I'm working on src/utils/api.ts - any quality issues?"

# Claude invokes relevant skills:
# ✅ code-reviewer checks patterns
# ✅ security-auditor scans for issues
# ✅ test-generator suggests missing tests

# 3. For deep analysis, invoke sub-agent
claude "@code-reviewer --focus security"
```

**Time investment:** 2 minutes setup, proactive assistance during conversations

---

### Path 2: "I need comprehensive code review"

**What you get:** Multi-perspective code analysis

```bash
# 1. Install sub-agents and commands
./scripts/install.sh --agents-only --commands

# 2. Stage your changes
git add .

# 3. Run comprehensive review
claude "/review --scope staged --checks all"

# This coordinates:
# - @code-reviewer: Code quality and patterns
# - @security-auditor: Vulnerability scanning
# - @performance-tuner: Performance analysis
# - @architect: Architecture validation

# Result: Detailed report with actionable recommendations
```

**Time investment:** 3 minutes setup, 5-10 minutes per review

---

### Path 3: "I want to scaffold projects faster"

**What you get:** Pre-configured templates and scaffolding

```bash
# 1. Install commands
./scripts/install.sh --commands

# 2. Scaffold components/projects
claude "/scaffold react-component UserProfile --hooks --tests"
claude "/scaffold express-api user-service --auth --database"
claude "/scaffold nextjs-app my-app --typescript --tailwind"

# 3. Generated structure:
# - Component files with boilerplate
# - Test files with basic structure
# - TypeScript types
# - Documentation stubs

# 4. Customize generated code to your needs
```

**Time investment:** 2 minutes setup, saves 15-30 minutes per scaffold

---

### Path 4: "I need automated testing workflows"

**What you get:** Test generation and execution automation

```bash
# 1. Install test-focused tools
./scripts/install.sh --skills-only --agents --commands

# 2. Start conversation about testing
# Claude invokes test-generator skill when relevant

# 3. Generate comprehensive test suites
claude "/test-gen --file src/utils/api.ts --framework jest --coverage 90"

# 4. For complex testing needs
claude "@test-engineer Create comprehensive test suite with edge cases"

# Result:
# - Unit tests for all functions
# - Integration tests for workflows
# - Edge cases and error handling
# - 90%+ code coverage
```

**Time investment:** 3 minutes setup, saves hours per feature

---

### Path 5: "I want automatic documentation"

**What you get:** Self-updating docs from code

```bash
# 1. Install documentation tools
./scripts/install.sh --skills-only --agents

# 2. Discuss documentation with Claude
# Skills are invoked when discussing docs:
# - api-documenter: Suggests OpenAPI specs for APIs
# - readme-updater: Suggests README updates

# Example workflow:
claude
> "I added this API endpoint - help me document it"
function createUser(req, res) { /* code */ }

# Claude invokes api-documenter skill which suggests:
# ✅ OpenAPI spec structure
# ✅ Example requests/responses
# ✅ Documentation updates

# 3. For comprehensive docs
claude "/docs-gen api --format openapi"
claude "@docs-writer Create user guide with examples"

# Result: Well-documented APIs
```

**Time investment:** 2 minutes setup, proactive documentation suggestions

---

## 🚀 Real-World Scenarios

### Scenario: New Feature Development

**Task:** Add user authentication feature

```bash
# 1. Start Claude Code session
claude

# 2. Discuss your work
> "I'm adding user authentication - can you review as I go?"

# Skills are invoked by Claude during the conversation:
# - code-reviewer checks patterns in real-time
# - security-auditor validates auth implementation
# - test-generator suggests test cases

# 3. Run formal review when ready
git add src/auth/
claude "/review --scope staged"

# 4. Generate comprehensive tests
claude "/test-gen --file src/auth/login.ts --framework jest"

# 5. Update documentation
claude "/docs-gen --update-readme"

# 6. Commit
git commit -m "feat(auth): add login with OAuth2"

# Total time saved: 2-3 hours
```

---

### Scenario: Bug Fix

**Task:** Fix production bug

```bash
# 1. Analyze issue
claude "@debugger Analyze this error: [stack trace]"

# 2. Discuss fix with Claude
claude
> "I'm fixing this issue - can you validate my approach?"
# (code-reviewer skill is invoked during discussion)

# 3. Add regression test
claude "@test-engineer Create test to prevent this regression"

# 4. Security check
claude "@security-auditor Validate fix doesn't introduce vulnerabilities"

# 5. Deploy with confidence
git commit -m "fix(api): resolve memory leak in WebSocket"

# Total time saved: 1-2 hours
```

---

### Scenario: Code Review for PR

**Task:** Review teammate's pull request

```bash
# 1. Fetch PR
gh pr checkout 123

# 2. Comprehensive review
claude "/review --scope pr --checks all"

# Review covers:
# ✅ Code quality (patterns, smells)
# ✅ Security (vulnerabilities, secrets)
# ✅ Performance (bottlenecks, optimizations)
# ✅ Architecture (design patterns, coupling)
# ✅ Tests (coverage, edge cases)

# 3. Provide feedback
# (generates detailed report with line numbers)

# Total time saved: 30-45 minutes per PR
```

---

## 📚 Understanding the 3-Tier Architecture

### Skills (Tier 1: Contextual Helpers)
- **What:** Helpers invoked by Claude during conversations
- **When:** Claude activates them when contextually relevant
- **Examples:** code-reviewer, test-generator, security-auditor

**Think of skills like:** Smart autocomplete - activates when relevant to your current discussion

### Sub-Agents (Tier 2: Manual Experts)
- **What:** Invoked specialists for deep analysis
- **When:** You explicitly call them (`@agent`)
- **Examples:** @code-reviewer, @test-engineer, @docs-writer

**Think of sub-agents like:** Consulting an expert - you ask when you need deep help

### Commands (Tier 3: Workflows)
- **What:** Multi-agent orchestrated workflows
- **When:** You run a command (`/command`)
- **Examples:** /review, /scaffold, /test-gen

**Think of commands like:** Running a script - automates complex multi-step processes

---

## 🔧 Configuration (Optional)

### Sandboxing (Advanced Users)

**Default:** Sandboxing is OFF (all skills work without it)

**Enable sandboxing** for additional security isolation:

```bash
# During installation
./scripts/install.sh --skills-only --sandboxing

# Or configure manually per skill
vim ~/.claude/skills/security-auditor/config.json
```

**When to enable:**
- High-security environments
- Untrusted code analysis
- Compliance requirements

**See:** [SANDBOXING-GUIDE.md](SANDBOXING-GUIDE.md) for details

---

### Customization

**Customize existing skills:**

```bash
# Copy skill and modify
cp -r ~/.claude/skills/code-reviewer \
      ~/.claude/skills/company-code-reviewer

# Edit for your standards
vim ~/.claude/skills/company-code-reviewer/SKILL.md
```

**Create new skills:**

See [skills/TEMPLATES.md](skills/TEMPLATES.md) for copy-paste templates

---

## 🎓 Learning Path

### Day 1: Installation & Basics
- ✅ Install skills (`./scripts/install.sh --skills`)
- ✅ Start Claude Code session and discuss your code
- ✅ Observe Claude invoking skills during conversations
- ✅ Request deep analysis: `@code-reviewer Analyze this`

### Day 2: Commands
- ✅ Try scaffolding: `/scaffold react-component TestComponent`
- ✅ Run code review: `/review --scope staged`
- ✅ Generate tests: `/test-gen --file utils.js`

### Week 1: Integration
- ✅ Use skills + sub-agents together during conversations
- ✅ Integrate `/review` into PR workflow
- ✅ Discuss documentation updates with Claude (skills suggest improvements)

### Week 2: Customization
- ✅ Create custom skill from template
- ✅ Adjust skill triggers for your workflow
- ✅ Share custom skills with team

---

## 🆘 Troubleshooting

### Skill Not Activating

**Check:**
```bash
# Verify skill installed
ls ~/.claude/skills/ | grep skill-name

# Check Claude Code recognizes it
claude --list-skills
```

**Fix:**
```bash
# Reinstall skill
./scripts/install.sh --skills
```

### Command Not Found

**Check:**
```bash
ls ~/.claude/commands/ | grep command-name
```

**Fix:**
```bash
./scripts/install.sh --commands
```

### Sub-Agent Error

**Common issue:** Tool access restrictions

**Fix:**
```bash
# Check agent configuration
cat ~/.claude/agents/agent-name.json

# Verify allowed-tools includes required tools
```

---

## 📖 Next Steps

### Dive Deeper

1. **Architecture:** [ARCHITECTURE.md](ARCHITECTURE.md) - Understand the system design
2. **Skills Guide:** [skills/README.md](skills/README.md) - Comprehensive skills documentation
3. **Templates:** [skills/TEMPLATES.md](skills/TEMPLATES.md) - Create custom skills
4. **Examples:** [examples/workflows/](examples/workflows/) - Real-world workflows

### For Existing Users

Already using Claude Code Tresor? See [MIGRATION-GUIDE.md](MIGRATION-GUIDE.md) for upgrading to the new skills system.

### Get Help

- **GitHub Issues:** Bug reports and feature requests
- **GitHub Discussions:** Questions and community support
- **Documentation:** Browse [examples/](examples/) for detailed workflows
- **Professional Support:** Available for custom development

---

## 💡 Pro Tips

1. **Start small** - Install skills first, get comfortable, then add sub-agents and commands
2. **Let skills run** - They're designed to be non-intrusive, leave them on
3. **Combine tools** - Skills detect → Sub-agents analyze → Commands orchestrate
4. **Customize gradually** - Use defaults first, customize when you know your needs
5. **Share with team** - Skills and agents work great for team standards

---

## 🎉 You're Ready!

You now have:
- ✅ Tools installed and verified
- ✅ Understanding of 3-tier architecture
- ✅ Real-world scenarios to practice
- ✅ Next steps for continued learning

**Start coding - skills are watching your back!**

---

**Questions?** See [README.md](README.md) for full documentation or open a GitHub issue.

**Created:** October 24, 2025
**Author:** Alireza Rezvani
**License:** MIT
