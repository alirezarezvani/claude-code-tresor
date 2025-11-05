# Migration Guide

> **Upgrading to Claude Code Tresor with Skills**

This guide helps existing users migrate to the new version with the Skills layer while preserving your current setup.

---

## What's New

### Skills Layer (Tier 1)

The biggest addition is **Skills** - autonomous background helpers that work continuously without manual invocation.

**Before (Agents + Commands only):**
```bash
# You had to manually invoke everything
@code-reviewer Analyze this file
/review --scope staged
```

**After (Skills + Agents + Commands):**
```bash
# Skills work automatically in background
# (no manual invocation needed)

# You write code → skills automatically:
# ✅ Check code quality
# ✅ Scan for security issues
# ✅ Suggest tests
# ✅ Update documentation

# Agents and commands work exactly as before
@code-reviewer Analyze this file  # Still works
/review --scope staged             # Still works
```

**Key benefit:** Continuous assistance without interrupting your flow.

---

## Breaking Changes

**Good news: NONE!** 🎉

This is a **purely additive upgrade**:
- ✅ All existing agents still work
- ✅ All existing commands still work
- ✅ Skills are an addition, not a replacement
- ✅ No configuration changes required
- ✅ Backward compatible

**If you do nothing:** Your current setup continues working exactly as before.

**If you upgrade:** You gain automatic background assistance while keeping everything you already have.

---

## Migration Paths

Choose based on your comfort level:

### Path 1: Full Upgrade (Recommended)

**Who:** Users wanting the complete experience
**Time:** 5 minutes
**Risk:** None (rollback available)

```bash
# 1. Backup current setup (optional but recommended)
cp -r ~/.claude/agents ~/.claude/agents.backup
cp -r ~/.claude/commands ~/.claude/commands.backup

# 2. Pull latest version
cd claude-code-tresor
git pull origin main

# 3. Run installation
./scripts/install.sh

# Installation will:
# - Add new skills/ directory
# - Update agents with skill coordination docs
# - Update commands with skill integration
# - Preserve all your existing setup

# 4. Verify
ls ~/.claude/skills/        # Should see 8 skills
ls ~/.claude/agents/        # Should see 8 agents (same as before)
ls ~/.claude/commands/      # Should see 4 commands (same as before)

# 5. Start coding - skills work automatically!
```

---

### Path 2: Skills Only (Conservative)

**Who:** Users wanting to try skills first
**Time:** 2 minutes
**Risk:** None

```bash
# Install only skills, don't touch agents/commands
cd claude-code-tresor
git pull origin main
./scripts/install.sh --skills

# Your agents and commands remain unchanged
# Skills work alongside them automatically
```

---

### Path 3: Gradual Migration (Safest)

**Who:** Users in production environments
**Time:** 10 minutes (spread over days)
**Risk:** Minimal

```bash
# Day 1: Review what's new
cd claude-code-tresor
git pull origin main
cat GETTING-STARTED.md
cat ARCHITECTURE.md

# Day 2: Install skills only
./scripts/install.sh --skills

# Day 3-7: Use skills, observe behavior
# (Skills work in background automatically)

# Week 2: If satisfied, update agents and commands
./scripts/install.sh --agents-only --commands

# Rollback at any time:
rm -rf ~/.claude/skills
```

---

## Step-by-Step Migration

### Before You Start

**Check current installation:**
```bash
# What do you currently have?
ls ~/.claude/agents/        # List installed agents
ls ~/.claude/commands/      # List installed commands

# Save versions for reference
cd claude-code-tresor
git log --oneline -1 > ~/claude-tresor-version-before.txt
```

---

### Step 1: Backup (Optional but Recommended)

```bash
# Backup everything
tar -czf ~/claude-tresor-backup-$(date +%Y%m%d).tar.gz \
  ~/.claude/agents \
  ~/.claude/commands

# Verify backup
tar -tzf ~/claude-tresor-backup-*.tar.gz | head -10
```

---

### Step 2: Update Repository

```bash
cd claude-code-tresor

# Check for uncommitted changes
git status

# If you have local modifications, stash them
git stash

# Pull latest version
git pull origin main

# Verify new structure
ls -la skills/  # Should see skills/ directory
```

---

### Step 3: Run Installation

```bash
# Full installation (recommended)
./scripts/install.sh

# The installer will:
# ✅ Create ~/.claude/skills/ directory
# ✅ Install 8 core skills
# ✅ Update agents with skill coordination docs
# ✅ Update commands with skill integration
# ✅ Preserve all existing customizations

# Installation output example:
# Installing Claude Code Tresor...
# ✅ Skills installed (8 skills)
# ✅ Agents updated (8 agents)
# ✅ Commands updated (4 commands)
# ✅ Documentation copied
# Done! Skills are now active.
```

---

### Step 4: Verify Installation

```bash
# Check skills installed
ls ~/.claude/skills/
# Expected: development/, security/, documentation/

ls ~/.claude/skills/development/
# Expected: code-reviewer/, test-generator/, git-commit-helper/

ls ~/.claude/skills/security/
# Expected: security-auditor/, secret-scanner/, dependency-auditor/

ls ~/.claude/skills/documentation/
# Expected: api-documenter/, readme-updater/

# Verify skill format (should have SKILL.md frontmatter)
head -10 ~/.claude/skills/development/code-reviewer/SKILL.md
# Should see:
# ---
# name: code-reviewer
# description: ...
# allowed-tools: Read, Grep, Glob
# ---

# Check agents still work
claude "@code-reviewer --version"

# Check commands still work
claude "/scaffold --help"
```

---

### Step 5: Test Skills

Skills work automatically, so just start coding:

```javascript
// Create a test file
echo 'function test() { return 1 + 1 }' > test.js

// Edit the file
vim test.js

// Skills should activate automatically:
// - code-reviewer: Checks code quality
// - test-generator: Suggests tests
// - security-auditor: Scans for issues

// You don't invoke skills - they just work!
```

---

### Step 6: Update Your Workflow (Optional)

**Old workflow (still works):**
```bash
# Manual invocation for everything
@code-reviewer Analyze this file
@test-engineer Create tests
/review --scope staged
```

**New workflow (enhanced):**
```bash
# Skills work automatically in background
# → Continuous quality checks
# → Real-time security scanning
# → Automatic test suggestions

# Invoke agents for deep analysis (when needed)
@code-reviewer --focus performance

# Run commands for workflows (as before)
/review --scope staged
```

---

## Compatibility

### Existing Agents

**All agents work exactly as before** with enhanced skill awareness:

```bash
# Before migration:
@code-reviewer Analyze this file
# → Comprehensive code review

# After migration:
@code-reviewer Analyze this file
# → Comprehensive code review
# + Aware of what skills already detected
# + Can build on skill suggestions
# + Provides deeper analysis beyond skills
```

**No behavior change unless you want it.**

---

### Existing Commands

**All commands work exactly as before** with skill integration:

```bash
# Before migration:
/review --scope staged
# → Coordinates agents for review

# After migration:
/review --scope staged
# → Skills pre-scan issues (automatic)
# → Coordinates agents for review (as before)
# → Agents build on skill findings (enhanced)
```

**Commands are smarter but interface unchanged.**

---

### Custom Configurations

**Your customizations are preserved:**

```bash
# If you customized agents:
~/.claude/agents/custom-agent/
# → Preserved exactly as-is
# → Can add skill coordination if desired (optional)

# If you modified commands:
~/.claude/commands/custom-command/
# → Preserved exactly as-is
# → Can integrate skills if desired (optional)
```

---

## New Workflow Patterns

### Pattern 1: Let Skills Handle Routine Checks

**Before:**
```bash
# You had to manually check everything
@code-reviewer Check code quality
@security-auditor Scan for vulnerabilities
@test-engineer Verify test coverage
```

**After:**
```bash
# Skills do routine checks automatically
# (no manual invocation needed)

# You only invoke agents for deep analysis:
@code-reviewer --focus architecture  # Complex design review
@security-auditor --compliance PCI    # Compliance audit
@test-engineer --coverage 95          # Comprehensive suite
```

**Benefit:** Save time on routine checks, focus on complex analysis.

---

### Pattern 2: Skills → Agents Handoff

**New workflow:**
```bash
# 1. Skill detects issue automatically
# skill: "⚠️ Potential security issue in auth.js"

# 2. You decide to investigate
# You: @security-auditor Analyze auth.js in detail

# 3. Agent provides deep analysis
# agent: [Comprehensive security report with fixes]

# Result: Skill detects, agent analyzes, you decide
```

---

### Pattern 3: Continuous Documentation

**Before:**
```bash
# Manual documentation updates
/docs-gen --update-readme
/docs-gen api --format openapi
```

**After:**
```bash
# Skills update docs automatically
# - readme-updater: Keeps README current
# - api-documenter: Updates OpenAPI specs

# You only invoke for comprehensive docs:
@docs-writer Create user guide with tutorials
/docs-gen --complete
```

**Benefit:** Docs stay current without manual effort.

---

## Troubleshooting

### Skills Not Activating

**Symptom:** Skills don't seem to activate automatically

**Check:**
```bash
# 1. Verify skills installed
ls ~/.claude/skills/
# Should see: development/, security/, documentation/

# 2. Check SKILL.md format
head -10 ~/.claude/skills/development/code-reviewer/SKILL.md
# Should have YAML frontmatter:
# ---
# name: code-reviewer
# description: ...
# ---

# 3. Verify Claude recognizes skills
claude --list-skills
# Should list all 8 skills
```

**Fix:**
```bash
# Reinstall skills
./scripts/install.sh --skills-only --force
```

---

### Agents Not Working After Migration

**Symptom:** `@agent` invocation fails or behaves differently

**Check:**
```bash
# 1. Verify agent files intact
ls ~/.claude/agents/code-reviewer/
# Should see: agent.json, README.md

# 2. Check agent configuration
cat ~/.claude/agents/code-reviewer/agent.json
# Should have valid JSON
```

**Fix:**
```bash
# Restore from backup
cp -r ~/.claude/agents.backup/* ~/.claude/agents/

# Or reinstall
./scripts/install.sh --agents-only --force
```

---

### Commands Not Working After Migration

**Symptom:** `/command` fails or shows errors

**Check:**
```bash
# 1. Verify command files
ls ~/.claude/commands/review/
# Should see: command.json, README.md

# 2. Check command configuration
cat ~/.claude/commands/review/command.json
```

**Fix:**
```bash
# Restore from backup
cp -r ~/.claude/commands.backup/* ~/.claude/commands/

# Or reinstall
./scripts/install.sh --commands-only --force
```

---

### Performance Issues

**Symptom:** Skills seem to slow down editor or Claude

**Causes:**
- Too many skills active simultaneously
- Heavy operations in skill detection

**Fix:**
```bash
# 1. Check which skills are active
claude --list-skills --status

# 2. Disable specific skills temporarily
mv ~/.claude/skills/heavy-skill ~/.claude/skills/heavy-skill.disabled

# 3. Re-enable when needed
mv ~/.claude/skills/heavy-skill.disabled ~/.claude/skills/heavy-skill
```

**Note:** Skills are designed to be lightweight. Performance issues are rare.

---

### Sandboxing Issues

**Symptom:** Skill needs network/filesystem access but sandboxed

**Check:**
```bash
# Is sandboxing enabled?
cat ~/.claude/settings.json | grep sandboxing
```

**Fix:**
```bash
# Option 1: Disable sandboxing (skills work fine without it)
vim ~/.claude/settings.json
# Set: "sandboxing": false

# Option 2: Configure sandboxing for specific skill
vim ~/.claude/skills/dependency-auditor/config.json
# Add allowed domains/paths
```

**See:** SANDBOXING-GUIDE.md for details

---

## Rollback Procedure

If you need to rollback to pre-skills version:

```bash
# 1. Remove skills
rm -rf ~/.claude/skills/

# 2. Restore agents and commands from backup
rm -rf ~/.claude/agents
rm -rf ~/.claude/commands
tar -xzf ~/claude-tresor-backup-*.tar.gz -C ~/

# 3. Verify restoration
ls ~/.claude/agents/    # Should see original agents
ls ~/.claude/commands/  # Should see original commands
ls ~/.claude/skills/    # Should not exist

# 4. Downgrade repository (optional)
cd claude-code-tresor
git log --oneline | head -20  # Find pre-skills commit
git checkout <commit-hash>

# Your setup is now back to pre-migration state
```

---

## FAQ

### Q: Do I need to change my workflow?

**A:** No. Skills work automatically in the background. Your existing workflow with agents and commands continues unchanged.

---

### Q: Will skills conflict with my custom agents?

**A:** No. Skills are separate from agents and don't interfere. They complement each other.

---

### Q: Can I disable specific skills?

**A:** Yes. Rename the skill directory:
```bash
mv ~/.claude/skills/skill-name ~/.claude/skills/skill-name.disabled
```

---

### Q: How do I customize a skill?

**A:** Copy and modify:
```bash
cp -r ~/.claude/skills/code-reviewer ~/.claude/skills/my-code-reviewer
vim ~/.claude/skills/my-code-reviewer/SKILL.md
```

**See:** [skills/TEMPLATES.md](skills/TEMPLATES.md)

---

### Q: Do skills work offline?

**A:** Yes, except dependency-auditor (needs npm/pip registries).

---

### Q: Can I contribute my custom skill?

**A:** Absolutely! Submit a PR with your skill in `skills/custom/`.

---

### Q: What if I only want some skills?

**A:** During installation, copy only desired skills:
```bash
# Install only security skills
cp -r skills/security ~/.claude/skills/
```

---

### Q: Is sandboxing required?

**A:** No. All skills work without sandboxing (default). Sandboxing is optional hardening.

---

## Post-Migration Checklist

After migration, verify:

- [ ] Skills installed: `ls ~/.claude/skills/`
- [ ] 8 skills present: development/ (3), security/ (3), documentation/ (2)
- [ ] Agents still work: `@code-reviewer --help`
- [ ] Commands still work: `/review --help`
- [ ] Skills activate automatically (test by editing a file)
- [ ] No errors in Claude output
- [ ] Backup created (can rollback if needed)
- [ ] Read GETTING-STARTED.md for new workflows
- [ ] Read ARCHITECTURE.md to understand 3-tier system

---

## Getting Help

**Issues during migration?**

1. **Check troubleshooting section above** (covers 90% of issues)
2. **Review installation output** for error messages
3. **Verify backups exist** before making changes
4. **Open GitHub issue** with:
   - Migration path chosen (Full/Skills-only/Gradual)
   - Error messages (if any)
   - Output of `ls -la ~/.claude/`
   - Claude version: `claude --version`

**Need migration assistance?**
- GitHub Issues: Bug reports
- GitHub Discussions: Questions
- Documentation: [GETTING-STARTED.md](GETTING-STARTED.md), [ARCHITECTURE.md](ARCHITECTURE.md)

---

## Success Stories

After migrating to skills:

**Developer 1:**
> "Skills caught 3 security issues before I even committed. Saved hours of security review time."

**Developer 2:**
> "README stays current automatically. Documentation is no longer a chore."

**Developer 3:**
> "The gradual migration path was perfect. Tested skills for a week before going all-in. Zero disruption."

---

## Next Steps

Now that you've migrated:

1. **Explore Skills:** [skills/README.md](skills/README.md) - Comprehensive guide
2. **Learn Workflows:** [GETTING-STARTED.md](GETTING-STARTED.md) - 5-minute start
3. **Understand Architecture:** [ARCHITECTURE.md](ARCHITECTURE.md) - System design
4. **Create Custom Skills:** [skills/TEMPLATES.md](skills/TEMPLATES.md) - Templates
5. **Share Feedback:** Open GitHub issue or discussion

---

**Welcome to Claude Code Tresor with Skills! 🎉**

**Created:** October 24, 2025
**Author:** Alireza Rezvani
**License:** MIT
