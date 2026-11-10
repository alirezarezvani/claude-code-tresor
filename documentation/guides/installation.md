# Installation Guide

Complete installation instructions for Claude Code Tresor.

## Prerequisites

Before installing Claude Code Tresor, ensure you have:

- **Claude Code CLI** installed and configured
- **Git** installed (version 2.0 or higher)
- **Terminal/Command Line** access
- **Text Editor** for customization (optional)

### Verify Prerequisites

```bash
# Check Claude Code CLI
claude --version

# Check Git
git --version
```

---

## Installation Methods

Claude Code Tresor supports three installation methods:

### Method 1: Full Installation (Recommended)

Installs **all components**: 8 skills, 8 core agents plus the extended subagent library, and 19 commands

```bash
# Clone repository
git clone https://github.com/alirezarezvani/claude-code-tresor.git
cd claude-code-tresor

# Run installation script
./scripts/install.sh
```

**What gets installed:**
- 8 autonomous skills in `~/.claude/skills/`
- 8 core agents in `~/.claude/agents/` plus the extended subagents in `~/.claude/subagents/`
- 19 slash commands in `~/.claude/commands/`, one file per command (plus the five old workflow command names, kept until v3.0.0)
- Prompt templates and standards

**Installation time:** ~2-3 minutes

---

### Method 2: Selective Installation

Install only specific components:

#### Skills Only (8 Autonomous Skills)

```bash
./scripts/install.sh --skills-only
```

Installs:
- code-reviewer
- test-generator
- git-commit-helper
- security-auditor
- secret-scanner
- dependency-auditor
- api-documenter
- readme-updater

#### Agents Only (8 Core Agents + Library)

```bash
./scripts/install.sh --agents-only
```

Installs the 8 core agents into `~/.claude/agents/`:
- @systems-architect
- @config-safety-reviewer
- @root-cause-analyzer
- @security-auditor
- @test-engineer
- @performance-tuner
- @refactor-expert
- @docs-writer

It also copies the full library of 133 agents to `~/.claude/subagents/` for browsing. Claude Code does not load that folder. To use a library agent, activate it:

```bash
./scripts/install.sh --agent backend-architect --agent data-engineer
```

Each `--agent` writes one file to `~/.claude/agents/`. A few names are used by two teams (for example `customer-support`); for those, give the path shown in the error, such as `--agent operations/support/customer-support`. Run the same command again to refresh an activated agent; `update.sh` only refreshes the 8 core agents.

#### Commands Only (19 Commands)

```bash
./scripts/install.sh --commands-only
```

Installs all 19 commands as one file each, for example `~/.claude/commands/review.md` for `/review`. The five old workflow command names (`/create-prompt`, `/run-prompt`, `/add-to-todos`, `/check-todos`, `/whats-next`) are installed too and will be removed in v3.0.0.

---

### Method 3: Resources Only

Install **prompts, templates, and standards** without skills/agents/commands:

```bash
./scripts/install.sh --resources-only
```

Use this if you only want reference materials and templates.

---

## Verification Steps

After installation, verify everything works:

### 1. Verify Skills Installation

```bash
# Check installed skills
ls ~/.claude/skills/

# Expected output:
# code-reviewer/
# test-generator/
# git-commit-helper/
# security-auditor/
# secret-scanner/
# dependency-auditor/
# api-documenter/
# readme-updater/
```

### 2. Verify Agents Installation

```bash
# Check installed agents
ls ~/.claude/agents/

# Expected output:
# config-safety-reviewer.md
# docs-writer.md
# performance-tuner.md
# refactor-expert.md
# root-cause-analyzer.md
# security-auditor.md
# systems-architect.md
# test-engineer.md
```

### 3. Verify Commands Installation

```bash
# Check installed commands
ls ~/.claude/commands/

# Expected output: 24 files (19 commands + 5 old names), such as:
# scaffold.md
# review.md
# test-gen.md
# docs-gen.md
# health-check.md
```

### 4. Test Installation

Start Claude Code and test components:

```bash
# Start Claude Code
claude

# In conversation, skills activate automatically when you save code files

# Test an agent
@code-reviewer analyze this function for best practices

# Test a command
/scaffold --help
```

---

## Common Installation Issues

### Issue: Permission Denied

**Error:** `Permission denied: ./scripts/install.sh`

**Solution:**
```bash
# Make install script executable
chmod +x ./scripts/install.sh

# Run installation again
./scripts/install.sh
```

---

### Issue: Script Not Found

**Error:** `./scripts/install.sh: No such file or directory`

**Solution:**
```bash
# Ensure you're in repository root
pwd  # Should show: .../claude-code-tresor

# List scripts directory
ls scripts/

# If missing, re-clone repository
cd ..
rm -rf claude-code-tresor
git clone https://github.com/alirezarezvani/claude-code-tresor.git
cd claude-code-tresor
```

---

### Issue: Skills Not Activating

**Problem:** Skills installed but not activating in conversations

**Solution:**
1. Restart Claude Code CLI
2. Verify skills are in `~/.claude/skills/`
3. Check skill configuration:
```bash
cat ~/.claude/skills/code-reviewer/SKILL.md
```
4. Ensure trigger keywords are used (see [Getting Started Guide](getting-started.md))

---

### Issue: Agents Not Found

**Problem:** `@agent-name not found`

**Solution:**
1. Verify agent directory exists:
```bash
ls ~/.claude/agents/code-reviewer/
```
2. Check agent configuration:
```bash
cat ~/.claude/agents/code-reviewer/SKILL.md
```
3. Restart Claude Code CLI

---

### Issue: Commands Not Working

**Problem:** `/command-name not recognized`

**Solution:**
1. Verify command directory exists:
```bash
ls ~/.claude/commands/scaffold/
```
2. Check command configuration:
```bash
cat ~/.claude/commands/scaffold/command.json
```
3. Restart Claude Code CLI
4. Try full command path: `/development/scaffold` instead of `/scaffold`

---

## Post-Installation Next Steps

After successful installation:

1. **[Read Getting Started Guide →](getting-started.md)**
   - Learn how to use skills, agents, and commands
   - Follow first-time user walkthrough

2. **[Explore Examples →](../examples/)**
   - See real-world workflows
   - Learn best practices

3. **[Customize Configuration →](configuration.md)**
   - Modify skill behavior
   - Configure agents
   - Customize commands

4. **[Read FAQ →](../reference/faq.md)**
   - Common questions
   - Troubleshooting tips

---

## Updating

To update Claude Code Tresor to the latest version:

```bash
cd claude-code-tresor

# Pull latest changes
git pull origin main

# Re-run installation
./scripts/update.sh
```

The update script preserves your customizations while updating utilities.

---

## Uninstallation

To remove Claude Code Tresor:

```bash
# Remove skills
rm -rf ~/.claude/skills/code-reviewer
rm -rf ~/.claude/skills/test-generator
rm -rf ~/.claude/skills/git-commit-helper
rm -rf ~/.claude/skills/security-auditor
rm -rf ~/.claude/skills/secret-scanner
rm -rf ~/.claude/skills/dependency-auditor
rm -rf ~/.claude/skills/api-documenter
rm -rf ~/.claude/skills/readme-updater

# Remove agents
rm -rf ~/.claude/agents/code-reviewer
rm -rf ~/.claude/agents/test-engineer
rm -rf ~/.claude/agents/docs-writer
rm -rf ~/.claude/agents/architect
rm -rf ~/.claude/agents/debugger
rm -rf ~/.claude/agents/security-auditor
rm -rf ~/.claude/agents/performance-tuner
rm -rf ~/.claude/agents/refactor-expert

# Remove commands
rm -rf ~/.claude/commands/scaffold
rm -rf ~/.claude/commands/review
rm -rf ~/.claude/commands/test-gen
rm -rf ~/.claude/commands/docs-gen

# Remove repository
cd ..
rm -rf claude-code-tresor
```

---

## Getting Help

If you encounter issues:

- **[Troubleshooting Guide →](troubleshooting.md)** - Common problems and solutions
- **[GitHub Issues →](https://github.com/alirezarezvani/claude-code-tresor/issues)** - Report bugs
- **[GitHub Discussions →](https://github.com/alirezarezvani/claude-code-tresor/discussions)** - Ask questions
- **[FAQ →](../reference/faq.md)** - Frequently asked questions

---

**Last Updated:** November 7, 2025 | **Version:** 2.0.0
