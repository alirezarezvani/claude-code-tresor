# Claude Code Tresor - Migration Guide

> Upgrade guide for users migrating from v2.6 or earlier

**Current Version:** 2.7.0
**Last Updated:** November 19, 2025

---

## 🎯 Quick Migration Path

| From Version | To Version | Breaking Changes | Migration Time | Difficulty |
|--------------|------------|------------------|----------------|------------|
| v2.6.x → v2.7.0 | ✅ Backward Compatible | None | 5 minutes | Easy |
| v2.5.x → v2.7.0 | ✅ Backward Compatible | None | 10 minutes | Easy |
| v2.4.x → v2.7.0 | ⚠️ Agent Names Changed | Minor | 15 minutes | Medium |
| v2.0-2.3 → v2.7.0 | ⚠️ Multiple Changes | Significant | 30 minutes | Medium |

---

## 🔄 Migrating from v2.6.x to v2.7.0

### What Changed

**1. TÂCHES → Tresor Workflow Framework**
- Command names updated for consistency
- No functional changes

**2. Agent Structure Consolidated**
- Primary location: `/subagents/` (133 agents)
- `/agents/` now contains symlinks for backward compatibility
- All existing agent invocations continue to work

**3. Workflow Commands Renamed**
| Old Command (v2.6.x) | New Command (v2.7.0) | Status |
|---------------------|----------------------|--------|
| `/create-prompt` | `/prompt-create` | ✅ Recommended |
| `/run-prompt` | `/prompt-run` | ✅ Recommended |
| `/add-to-todos` | `/todo-add` | ✅ Recommended |
| `/check-todos` | `/todo-check` | ✅ Recommended |
| `/whats-next` | `/handoff-create` | ✅ Recommended |

### Migration Steps

#### Step 1: Update Repository (5 minutes)

```bash
# Pull latest changes
cd /path/to/claude-code-tresor
git pull origin main

# Verify version
grep "version" README.md
# Should show: v2.7.0
```

#### Step 2: Reinstall (Optional but Recommended)

```bash
# Reinstall all components
./scripts/install.sh

# Or update selectively
./scripts/install.sh --agents    # Updates agent symlinks
./scripts/install.sh --commands  # Updates workflow commands
```

#### Step 3: Update Your Workflows (5 minutes)

**Update command invocations** in your scripts, documentation, and prompts:

**Before (v2.6.x):**
```bash
/create-prompt Design authentication system
/run-prompt 001
/add-to-todos Fix API performance issue
/check-todos
/whats-next
```

**After (v2.7.0):**
```bash
/prompt-create Design authentication system
/prompt-run 001
/todo-add Fix API performance issue
/todo-check
/handoff-create
```

**Note:** Old command names are NOT deprecated yet - they will work until v3.0.0. However, updating to new names is recommended.

#### Step 4: Verify Installation

```bash
# Test agent invocation (both locations should work)
@systems-architect --help
@config-safety-reviewer --help

# Test workflow command
/prompt-create --help
```

### Backward Compatibility

✅ **All v2.6 workflows continue to work**
- Agent invocations (`@agent-name`) work identically
- Old command names will continue to work in v2.7.x and v2.8.x
- No breaking changes

---

## 🔄 Migrating from v2.5.x to v2.7.0

### What Changed

**Everything from v2.6.x → v2.7.0, PLUS:**
- Improved documentation structure
- Enhanced agent catalog with color-coding

### Migration Steps

**Follow the v2.6.x → v2.7.0 steps above.**

### Additional Notes

- No breaking changes between v2.5.x and v2.7.0
- All agent names remain the same (already updated in v2.5.0)
- Full backward compatibility maintained

---

## ⚠️ Migrating from v2.4.x to v2.7.0

### What Changed

**Everything from v2.5.x → v2.7.0, PLUS:**

**Agent Naming Changes (Breaking - from v2.5.0):**
| Old Name (v2.4.x) | New Name (v2.5.0+) | Action Required |
|-------------------|-------------------|-----------------|
| `@code-reviewer` | `@config-safety-reviewer` | ⚠️ Update invocations |
| `@debugger` | `@root-cause-analyzer` | ⚠️ Update invocations |
| `@architect` | `@systems-architect` | ⚠️ Update invocations |

### Migration Steps

#### Step 1: Update Repository (5 minutes)

```bash
cd /path/to/claude-code-tresor
git pull origin main
```

#### Step 2: Find and Replace Old Agent Names (10 minutes)

**Search your codebase for old agent invocations:**
```bash
# Find all files using old agent names
grep -r "@code-reviewer" .
grep -r "@debugger" .
grep -r "@architect" .
```

**Replace with new names:**
```bash
# Option 1: Manual replacement (recommended)
# Open each file and replace:
# @code-reviewer → @config-safety-reviewer
# @debugger → @root-cause-analyzer
# @architect → @systems-architect

# Option 2: Automated replacement (use with caution)
find . -type f -exec sed -i '' 's/@code-reviewer/@config-safety-reviewer/g' {} +
find . -type f -exec sed -i '' 's/@debugger/@root-cause-analyzer/g' {} +
find . -type f -exec sed -i '' 's/@architect/@systems-architect/g' {} +
```

#### Step 3: Reinstall

```bash
./scripts/install.sh
```

#### Step 4: Test Agent Invocations

```bash
# Test new agent names
@config-safety-reviewer Review database configuration
@root-cause-analyzer Debug production API timeout
@systems-architect Design scalable microservices
```

#### Step 5: Update Documentation

Update any custom documentation, READMEs, or scripts that reference old agent names.

---

## ⚠️ Migrating from v2.0-2.3.x to v2.7.0

### What Changed

**Everything from v2.4.x → v2.7.0, PLUS:**
- Subagents ecosystem introduced (133 agents)
- Skills layer added (8 autonomous helpers)
- Workflow commands enhanced
- Documentation restructured

### Migration Steps

#### Step 1: Clean Installation Recommended (30 minutes)

Due to significant structural changes, a clean installation is recommended:

```bash
# Backup your current installation
cp -r ~/.claude-code ~/.claude-code-backup-v2.3

# Uninstall old version (if using custom install locations)
# [Your custom uninstall steps here]

# Clone fresh v2.7.0
cd ~/projects
git clone https://github.com/alirezarezvani/claude-code-tresor.git
cd claude-code-tresor
git checkout main

# Install v2.7.0
./scripts/install.sh
```

#### Step 2: Migrate Custom Configurations

If you customized any agents, commands, or prompts in v2.0-2.3.x:

1. **Compare old vs new structures:**
   ```bash
   diff -r ~/.claude-code-backup-v2.3 ~/.claude-code/agents/
   ```

2. **Port custom changes:**
   - Copy custom prompts to `prompts/` directory
   - Merge custom agent modifications (if any)
   - Update custom standards to new format

#### Step 3: Update Agent Names (Breaking Change from v2.5.0)

Follow the **v2.4.x → v2.7.0** migration steps above.

#### Step 4: Learn New Features

**New in v2.5.0+:**
- 133 subagents organized by team ([subagents/](subagents/))
- Color-coded team system
- Searchable agent index ([subagents/AGENT-INDEX.md](subagents/AGENT-INDEX.md))

**New in v2.7.0:**
- Tresor Workflow Framework commands
- Unified agent structure in `/subagents/`
- Comprehensive navigation guides

**See:** [Getting Started Guide](documentation/guides/getting-started.md)

---

## 🗺️ Feature Comparison

| Feature | v2.0-2.3 | v2.4 | v2.5 | v2.6 | v2.7 |
|---------|----------|------|------|------|------|
| **Core Agents** | 8 | 8 | 8 (renamed) | 8 | 8 |
| **Extended Agents** | 0 | 0 | 133 | 133 | 133 |
| **Skills** | 0 | 0 | 8 | 8 | 8 |
| **Workflow Commands** | 4 | 4 | 4 | 9 (TÂCHES) | 9 (Tresor) |
| **Agent Location** | `/agents/` | `/agents/` | `/agents/` + `/subagents/` | `/agents/` + `/subagents/` | `/subagents/` (primary) |
| **Color-Coded Teams** | ❌ | ❌ | ✅ | ✅ | ✅ |
| **Agent Index** | ❌ | ❌ | ✅ | ✅ | ✅ |
| **Navigation Guide** | ❌ | ❌ | ❌ | ❌ | ✅ |
| **Migration Guide** | ❌ | ❌ | ❌ | ❌ | ✅ |

---

## 🔧 Troubleshooting

### Issue: Old command names don't work

**Symptoms:** `/create-prompt` returns "command not found"

**Solution:**
```bash
# Reinstall commands
./scripts/install.sh --commands

# Verify installation
ls ~/.claude/commands/
```

**Alternative:** Use new command names (`/prompt-create`)

---

### Issue: Agent invocations fail

**Symptoms:** `@systems-architect` returns "agent not found"

**Solution:**
```bash
# Verify agents are installed
ls ~/.claude/agents/

# Reinstall agents
./scripts/install.sh --agents

# Check symlinks
ls -la agents/systems-architect/
# Should show: agent.md -> ../../subagents/core/systems-architect/agent.md
```

---

### Issue: "No such file or directory" for symlinks

**Symptoms:** Symlinks in `/agents/` are broken

**Solution:**
```bash
# Navigate to repository root
cd /path/to/claude-code-tresor

# Recreate symlinks
for agent in config-safety-reviewer docs-writer performance-tuner refactor-expert root-cause-analyzer security-auditor systems-architect test-engineer; do
  ln -sf ../../subagents/core/$agent/agent.md agents/$agent/agent.md
done

# Verify
ls -la agents/systems-architect/agent.md
```

---

### Issue: Skills not triggering automatically

**Symptoms:** Skills don't activate on file changes

**Solution:**
```bash
# Verify skills are installed
ls ~/.claude/skills/

# Reinstall skills
./scripts/install.sh --skills

# Check skill configuration
cat ~/.claude/skills/code-reviewer/SKILL.md
```

**See:** [Troubleshooting Guide](documentation/guides/troubleshooting.md)

---

## 📅 Deprecation Timeline

### v2.7.0 (Current - November 2025)
- ✅ `/agents/` maintained with symlinks (fully backward compatible)
- ✅ Old workflow command names continue to work

### v2.8.x (Q1 2026 - Planned)
- ⚠️ `/agents/` marked deprecated (still functional, migration warnings added)
- ⚠️ Old workflow command names deprecated (still functional, warnings added)

### v3.0.0 (Q2 2026 - Planned)
- ❌ `/agents/` removed (breaking change)
- ❌ Old workflow command names removed (breaking change)
- ❌ Only `/subagents/` and new command names supported

**Recommendation:** Update to v2.7.0 naming conventions now to prepare for v3.0.0.

---

## 🆘 Migration Support

**Need Help?**

1. **[FAQ](documentation/reference/faq.md)** - Common migration questions
2. **[Troubleshooting Guide](documentation/guides/troubleshooting.md)** - Fix migration issues
3. **[GitHub Issues](https://github.com/alirezarezvani/claude-code-tresor/issues)** - Report migration bugs
4. **[GitHub Discussions](https://github.com/alirezarezvani/claude-code-tresor/discussions)** - Ask migration questions

**Professional Support:** Available for teams requiring custom migration assistance.

---

## 📚 Related Guides

- **[Navigation Guide](NAVIGATION.md)** - Find your way around the repository
- **[Getting Started](documentation/guides/getting-started.md)** - First-time user guide
- **[Workflow Guide](WORKFLOW-GUIDE.md)** - Tresor Workflow Framework usage
- **[Architecture Overview](ARCHITECTURE.md)** - System design and component relationships

---

**Version:** 2.7.0
**Last Updated:** November 19, 2025
**License:** MIT
**Author:** Alireza Rezvani
