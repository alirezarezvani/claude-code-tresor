# Troubleshooting Guide

Common issues and solutions for Claude Code Tresor.

## Installation Issues

### Permission Denied Error

**Error:**
```
Permission denied: ./scripts/install.sh
```

**Solution:**
```bash
# Make script executable
chmod +x ./scripts/install.sh

# Run installation
./scripts/install.sh
```

---

### Script Not Found Error

**Error:**
```
./scripts/install.sh: No such file or directory
```

**Solution:**
```bash
# Verify you're in repository root
pwd  # Should show: .../claude-code-tresor

# If not in correct directory
cd /path/to/claude-code-tresor

# If directory doesn't exist, re-clone
git clone https://github.com/alirezarezvani/claude-code-tresor.git
cd claude-code-tresor
./scripts/install.sh
```

---

### Installation Incomplete

**Problem:** Some components missing after installation

**Solution:**
```bash
# Check what was installed
ls ~/.claude/skills/
ls ~/.claude/agents/
ls ~/.claude/commands/

# Re-run installation with specific flags
./scripts/install.sh --skills    # Install skills only
./scripts/install.sh --agents    # Install agents only
./scripts/install.sh --commands  # Install commands only

# Or full reinstall
./scripts/install.sh
```

---

## Skill Issues

### Skills Not Activating

**Problem:** Skills installed but not providing suggestions

**Checklist:**
1. ✅ Restart Claude Code CLI
2. ✅ Verify skill installed: `ls ~/.claude/skills/code-reviewer/`
3. ✅ Check configuration: `cat ~/.claude/skills/code-reviewer/SKILL.md`
4. ✅ Verify `enabled: true` in configuration
5. ✅ Check trigger keywords match your workflow

**Debug Steps:**
```bash
# Enable debug mode
export CLAUDE_CODE_DEBUG=true

# Restart Claude Code
claude

# Check skill logs (if available)
cat ~/.claude/logs/skills.log
```

---

### Skill Triggers Wrong Files

**Problem:** Skill activating for files it shouldn't

**Solution:**
Edit skill configuration to exclude files:

```yaml
---
name: "code-reviewer"
exclude_patterns:
  - "node_modules/**"
  - "dist/**"
  - "*.test.ts"
  - "*.min.js"
---
```

Save and restart Claude Code.

---

### Too Many Skill Suggestions

**Problem:** Overwhelming number of suggestions

**Solution 1: Reduce Skill Priority**
```yaml
---
name: "code-reviewer"
priority: "low"  # Changed from "high"
---
```

**Solution 2: Disable Non-Essential Skills**
```yaml
---
name: "readme-updater"
enabled: false  # Temporarily disable
---
```

**Solution 3: Narrow File Patterns**
```yaml
---
name: "test-generator"
file_patterns:
  - "src/**/*.ts"  # Only src directory
exclude_patterns:
  - "src/**/*.test.ts"  # Exclude existing tests
---
```

---

### Skill Missing Dependencies

**Problem:** Skill fails with "dependency not found"

**Solution:**
```bash
# Check skill requirements in SKILL.md
cat ~/.claude/skills/security-auditor/SKILL.md

# Install missing dependencies (example for Node.js)
npm install -g eslint  # If ESLint required

# Restart Claude Code
```

---

## Agent Issues

### Agent Not Found

**Error:**
```
@code-reviewer not found
```

**Solution:**
```bash
# Verify agent exists
ls ~/.claude/agents/code-reviewer/

# Check agent configuration
cat ~/.claude/agents/code-reviewer/SKILL.md

# Verify name field matches
grep "name:" ~/.claude/agents/code-reviewer/SKILL.md

# If missing, reinstall
./scripts/install.sh --agents

# Restart Claude Code
```

---

### Agent Fails to Execute

**Problem:** `@agent-name` invoked but fails

**Debug Steps:**
```bash
# Check agent configuration is valid
cat ~/.claude/agents/code-reviewer/SKILL.md

# Verify tools are available
# Tools like Bash, Task should be accessible

# Enable debug mode
export CLAUDE_CODE_DEBUG=true

# Try simpler invocation
# Instead of: @code-reviewer analyze entire codebase
# Try: @code-reviewer analyze this file
```

---

### Agent Times Out

**Problem:** Agent takes too long and times out

**Solution:**
```yaml
---
name: "code-reviewer"
max_iterations: 100  # Increase from default 50
timeout: 600         # Increase timeout to 10 minutes
---
```

Or reduce scope:
```
# Instead of analyzing entire codebase
@code-reviewer analyze src/components/UserProfile.tsx

# Break into smaller tasks
@code-reviewer analyze security issues only
```

---

### Agent Gives Generic Responses

**Problem:** Agent provides vague, unhelpful answers

**Solution:**

**Bad invocation (too vague):**
```
@code-reviewer review this
```

**Good invocation (specific):**
```
@code-reviewer analyze src/api/auth.controller.ts for:
1. Security vulnerabilities (OWASP Top 10)
2. Input validation issues
3. Error handling gaps
4. Authentication/authorization flaws
```

**Provide context:**
```
@code-reviewer
Context: Production API serving 10k requests/minute
Review: src/api/payment.controller.ts
Focus: Race conditions, transaction safety, error recovery
```

---

## Command Issues

### Command Not Recognized

**Error:**
```
/review: command not found
```

**Solution:**
```bash
# Verify command exists
ls ~/.claude/commands/review/

# Check command configuration
cat ~/.claude/commands/review/command.json

# Verify enabled
grep "enabled" ~/.claude/commands/review/command.json

# If missing, reinstall
./scripts/install.sh --commands

# Restart Claude Code

# Try full path
/workflow/review --scope staged
```

---

### Command Fails with Invalid Parameters

**Error:**
```
/review --invalid-option: parameter not recognized
```

**Solution:**
```bash
# Check command help
/review --help

# View valid parameters
cat ~/.claude/commands/review/command.json

# Use correct syntax
/review --scope staged --checks security,performance
```

---

### Command Stuck or Hanging

**Problem:** Command runs but never completes

**Solution:**
```bash
# Cancel current command (Ctrl+C)

# Check command timeout
cat ~/.claude/commands/review/command.json
# Look for "timeout" field

# Increase timeout if needed
{
  "name": "review",
  "timeout": 600  # 10 minutes
}

# Or reduce scope
/review --scope src/components/UserProfile.tsx  # Single file
# Instead of: /review --scope all  # Entire codebase
```

---

### Command Invokes Wrong Agent

**Problem:** Command calls unexpected agent

**Solution:**
Check command configuration:

```bash
cat ~/.claude/commands/review/command.json
```

Look for `agents` field:
```json
{
  "agents": [
    "@code-reviewer",
    "@security-auditor"
  ]
}
```

Customize if needed (edit command.json and restart).

---

## Configuration Issues

### YAML Syntax Errors

**Error:**
```
Configuration invalid: YAML parse error
```

**Solution:**
```bash
# Check YAML syntax
cat ~/.claude/skills/code-reviewer/SKILL.md

# Common YAML errors:
# 1. Incorrect indentation (use 2 spaces, not tabs)
# 2. Missing quotes around special characters
# 3. Missing colon after key

# Validate YAML online: https://www.yamllint.com/

# Fix syntax, save, restart Claude Code
```

**Valid YAML:**
```yaml
---
name: "code-reviewer"
tools:
  - "Read"
  - "Write"
---
```

**Invalid YAML:**
```yaml
---
name: code-reviewer  # Missing quotes (ok)
tools:
- "Read"  # Wrong indentation (should be 2 spaces)
 - "Write" # Inconsistent indentation
---
```

---

### JSON Syntax Errors

**Error:**
```
Configuration invalid: JSON parse error
```

**Solution:**
```bash
# Validate JSON
cat ~/.claude/commands/review/command.json | python -m json.tool

# Common JSON errors:
# 1. Trailing commas
# 2. Single quotes instead of double quotes
# 3. Missing closing brackets

# Fix syntax, save, restart
```

**Valid JSON:**
```json
{
  "name": "review",
  "enabled": true
}
```

**Invalid JSON:**
```json
{
  "name": "review",
  "enabled": true,  // Trailing comma
}
```

---

### Configuration Changes Not Applied

**Problem:** Changes to config files not taking effect

**Solution:**
1. Save configuration file
2. **Restart Claude Code CLI completely**
3. Verify changes:
```bash
# Check saved file
cat ~/.claude/skills/code-reviewer/SKILL.md

# Test skill/agent/command
```

**Note:** Configuration is loaded at startup. Must restart for changes to apply.

---

## Performance Issues

### Claude Code Runs Slowly

**Problem:** Sluggish performance with skills/agents

**Solution:**

**Check Resource Usage:**
```bash
# Check running processes
ps aux | grep claude

# Check CPU/memory
top -o cpu
```

**Reduce Active Skills:**
```yaml
# Disable non-essential skills temporarily
---
name: "readme-updater"
enabled: false
---
```

**Limit File Monitoring:**
```yaml
---
name: "code-reviewer"
file_patterns:
  - "src/**/*.ts"  # Only critical files
exclude_patterns:
  - "node_modules/**"
  - "dist/**"
  - "*.test.ts"
---
```

**Use Lighter Model:**
```yaml
---
model: "claude-sonnet-4"  # Instead of claude-opus-4
---
```

---

### High Memory Usage

**Problem:** Claude Code consuming excessive memory

**Solution:**
```bash
# Restart Claude Code
# Close unnecessary terminal windows
# Reduce concurrent skills

# Check for memory leaks
ps aux | grep claude | awk '{print $6}'  # Memory in KB

# If consistently high, report issue on GitHub
```

---

## File and Path Issues

### Skill Cannot Access Files

**Problem:** "Permission denied" or "File not found"

**Solution:**
```bash
# Verify file exists
ls /path/to/file.ts

# Check file permissions
ls -la /path/to/file.ts

# Ensure skill has Read permission
# Skills should have Read/Write/Edit/Grep/Glob tools

# Check skill configuration
cat ~/.claude/skills/code-reviewer/SKILL.md
```

---

### Command Creates Files in Wrong Location

**Problem:** `/scaffold` creates files in unexpected directory

**Solution:**
```bash
# Check current directory before running command
pwd

# Navigate to correct directory first
cd /path/to/project

# Then run command
/scaffold react-component UserProfile

# Or specify full path
/scaffold react-component UserProfile --path /absolute/path/to/project/src/components
```

---

## Integration Issues

### Skills Conflict with Each Other

**Problem:** Multiple skills providing contradictory suggestions

**Solution:**

**Option 1: Adjust Priorities**
```yaml
# code-reviewer gets priority
---
name: "code-reviewer"
priority: "high"
---

# security-auditor runs after
---
name: "security-auditor"
priority: "medium"
---
```

**Option 2: Narrow Scopes**
```yaml
# code-reviewer handles general code
---
name: "code-reviewer"
file_patterns:
  - "src/**/*.ts"
exclude_patterns:
  - "src/api/**"  # Exclude API files
---

# security-auditor handles API only
---
name: "security-auditor"
file_patterns:
  - "src/api/**/*.ts"
---
```

---

### Agent Invokes Wrong Tools

**Problem:** Agent tries to use tools it doesn't have access to

**Solution:**
```bash
# Check agent configuration
cat ~/.claude/agents/code-reviewer/SKILL.md

# Verify tools field includes needed tools
---
tools:
  - "Read"
  - "Write"
  - "Edit"
  - "Grep"
  - "Glob"
  - "Bash"  # Add if agent needs to run commands
---

# Save and restart Claude Code
```

---

## Error Messages

### "Skill Not Enabled"

**Error:**
```
Skill 'code-reviewer' is not enabled
```

**Solution:**
```bash
# Edit skill configuration
vi ~/.claude/skills/code-reviewer/SKILL.md

# Set enabled to true
---
enabled: true
---

# Save and restart Claude Code
```

---

### "Agent Invocation Failed"

**Error:**
```
Failed to invoke @code-reviewer: configuration error
```

**Solution:**
```bash
# Check agent configuration syntax
cat ~/.claude/agents/code-reviewer/SKILL.md

# Validate YAML frontmatter
# Ensure all required fields present:
# - name
# - description
# - tools

# Fix errors, save, restart
```

---

### "Command Timeout"

**Error:**
```
Command '/review' timed out after 120 seconds
```

**Solution:**
```bash
# Increase timeout in command.json
vi ~/.claude/commands/review/command.json

# Add or increase timeout
{
  "name": "review",
  "timeout": 600  # 10 minutes
}

# Or reduce command scope
/review --scope src/components/UserProfile.tsx
```

---

## Getting More Help

### Enable Debug Mode

```bash
# Enable detailed logging
export CLAUDE_CODE_DEBUG=true
export CLAUDE_CODE_LOG_LEVEL=debug

# Restart Claude Code
claude

# Check logs (if available)
cat ~/.claude/logs/debug.log
```

---

### Collect Diagnostic Information

Before reporting issues, collect:

```bash
# Claude Code version
claude --version

# Installation verification
ls ~/.claude/skills/
ls ~/.claude/agents/
ls ~/.claude/commands/

# Configuration samples
cat ~/.claude/skills/code-reviewer/SKILL.md
cat ~/.claude/agents/code-reviewer/SKILL.md
cat ~/.claude/commands/review/command.json

# System information
uname -a  # OS version
node --version  # Node.js version (if applicable)
git --version  # Git version
```

---

### Report Issues

If problems persist:

1. **Check FAQ:** [FAQ →](../reference/faq.md)
2. **Search GitHub Issues:** [Existing issues →](https://github.com/alirezarezvani/claude-code-tresor/issues)
3. **Create New Issue:** [Report bug →](https://github.com/alirezarezvani/claude-code-tresor/issues/new)

**Include in bug report:**
- Error message (full text)
- Steps to reproduce
- Expected vs actual behavior
- Configuration files (sanitized)
- System information

4. **Ask Community:** [GitHub Discussions →](https://github.com/alirezarezvani/claude-code-tresor/discussions)

---

## Emergency Recovery

### Complete Reset

If all else fails, complete reset:

```bash
# Backup customizations first
cp -r ~/.claude/skills ~/.claude/skills.backup
cp -r ~/.claude/agents ~/.claude/agents.backup
cp -r ~/.claude/commands ~/.claude/commands.backup

# Remove all Claude Code Tresor components
rm -rf ~/.claude/skills/code-reviewer
rm -rf ~/.claude/skills/test-generator
# ... (remove all skills)

rm -rf ~/.claude/agents/code-reviewer
rm -rf ~/.claude/agents/test-engineer
# ... (remove all agents)

rm -rf ~/.claude/commands/scaffold
rm -rf ~/.claude/commands/review
# ... (remove all commands)

# Re-clone repository
cd ~
rm -rf claude-code-tresor
git clone https://github.com/alirezarezvani/claude-code-tresor.git
cd claude-code-tresor

# Fresh installation
./scripts/install.sh

# Restore customizations if needed
# (Manually merge from .backup directories)

# Restart Claude Code
```

---

## Next Steps

- **[Configuration Guide →](configuration.md)** - Advanced configuration
- **[FAQ →](../reference/faq.md)** - Common questions
- **[GitHub Issues →](https://github.com/alirezarezvani/claude-code-tresor/issues)** - Report bugs

---

**Last Updated:** November 7, 2025 | **Version:** 2.0.0
