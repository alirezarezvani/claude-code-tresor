# Migration Guide

Guide for migrating between Claude Code Tresor versions.

## Version Compatibility

| Version | Release Date | Status | Migration Required |
|---------|-------------|--------|-------------------|
| 2.0.0 | Oct 2025 | Current | Yes (from 1.x) |
| 1.0.0 | Sep 2025 | Legacy | N/A |

---

## Migration Paths

### v1.0 → v2.0 (October 2025)

**Major Changes:**
- **NEW:** 8 autonomous skills added
- **CHANGED:** Agent invocation syntax
- **CHANGED:** Directory structure for commands
- **CHANGED:** Configuration format (YAML frontmatter)
- **REMOVED:** Deprecated utilities from `sources/`

**Migration Required:** Yes
**Estimated Time:** 30-60 minutes
**Breaking Changes:** Yes

---

## v1.0 → v2.0 Migration

### Step 1: Backup Current Installation

```bash
# Backup existing installation
cp -r ~/.claude/agents ~/.claude/agents.v1.backup
cp -r ~/.claude/commands ~/.claude/commands.v1.backup

# Backup customizations
cp -r ~/.claude/prompts ~/.claude/prompts.v1.backup
```

---

### Step 2: Review Breaking Changes

#### 1. Agent Invocation Syntax (BREAKING)

**v1.0 (Old):**
```
rr-code-reviewer analyze this component
```

**v2.0 (New):**
```
@code-reviewer analyze this component
```

**Action Required:**
- Update any saved workflows/scripts
- Update documentation/notes with new syntax
- Team training on new invocation pattern

---

#### 2. Agent Configuration Format (BREAKING)

**v1.0 (agent.json):**
```json
{
  "name": "code-reviewer",
  "description": "Code quality analyst",
  "model": "claude-opus-4"
}
```

**v2.0 (SKILL.md with YAML frontmatter):**
```yaml
---
name: "code-reviewer"
description: "Code quality analyst"
model: "claude-opus-4"
tools:
  - "Read"
  - "Write"
  - "Edit"
  - "Grep"
  - "Glob"
  - "Bash"
  - "Task"
---
```

**Action Required:**
- Custom agents must add YAML frontmatter
- Specify `tools` field (required in v2.0)
- Keep agent.json for backward compatibility (optional)

---

#### 3. Command Directory Structure (BREAKING)

**v1.0:**
```
~/.claude/commands/
  ├── scaffold.json
  ├── review.json
  └── test-gen.json
```

**v2.0:**
```
~/.claude/commands/
  ├── development/scaffold/
  │   └── command.json
  ├── workflow/review/
  │   └── command.json
  └── testing/test-gen/
      └── command.json
```

**Action Required:**
- Custom commands must be reorganized into category directories
- Update command.json to include `category` field

---

#### 4. Skills Introduction (NEW)

**v2.0 Adds:**
- 8 new autonomous skills
- Automatic activation (no manual invocation)
- Conversation-based suggestions

**Action Required:**
- Install skills: `./scripts/install.sh --skills`
- Configure skill behavior (optional)
- Test skills in development workflow

---

### Step 3: Install v2.0

```bash
# Navigate to repository
cd ~/claude-code-tresor

# Pull latest changes
git fetch origin
git checkout main
git pull origin main

# Verify version
cat VERSION  # Should show 2.0.0

# Run migration script
./scripts/migrate-v1-to-v2.sh

# Or manual installation
./scripts/install.sh
```

---

### Step 4: Migrate Custom Agents

If you created custom agents in v1.0:

```bash
# List custom agents
ls ~/.claude/agents/

# For each custom agent
cd ~/.claude/agents/my-custom-agent/

# Add YAML frontmatter to SKILL.md
cat << 'EOF' > SKILL.md
---
name: "my-custom-agent"
description: "My custom agent description"
tools:
  - "Read"
  - "Write"
  - "Edit"
  - "Grep"
  - "Glob"
  - "Bash"
  - "Task"
model: "claude-opus-4"
enabled: true
---

# My Custom Agent

[Rest of your agent documentation]
EOF
```

---

### Step 5: Migrate Custom Commands

If you created custom commands in v1.0:

```bash
# Create category directory
mkdir -p ~/.claude/commands/custom/my-command/

# Move command.json
mv ~/.claude/commands/my-command.json ~/.claude/commands/custom/my-command/command.json

# Add category field to command.json
{
  "name": "my-command",
  "category": "custom",  // ADD THIS
  "description": "...",
  // rest of configuration
}
```

---

### Step 6: Update Workflows and Scripts

Update any saved workflows:

**Example workflow.md (v1.0):**
```markdown
## Code Review Workflow

1. Make changes
2. Run: rr-code-reviewer analyze codebase
3. Fix issues
4. Commit
```

**Updated workflow.md (v2.0):**
```markdown
## Code Review Workflow

1. Make changes
2. Skills provide real-time feedback (automatic)
3. For deep review: @code-reviewer analyze codebase
4. For complete audit: /review --scope all
5. Fix issues
6. Commit
```

---

### Step 7: Test Migration

Verify everything works:

```bash
# Test skills (automatic activation)
# Create a file with an issue and save it

# Test agents (manual invocation)
@code-reviewer analyze src/components/TestComponent.tsx

# Test commands
/review --scope staged
/scaffold react-component TestComponent
/test-gen --file src/utils/helpers.ts
```

---

### Step 8: Update Team Documentation

Update internal team documentation:

1. **Update onboarding docs** with new syntax
2. **Update development guides** with skills workflow
3. **Create migration guide** for team members
4. **Schedule training session** on v2.0 features

---

## Data Migration

### Custom Prompts

v2.0 is backward compatible with v1.0 prompts:

```bash
# No migration needed - prompts work as-is
ls ~/.claude/prompts/

# Optional: organize into v2.0 structure
mv ~/.claude/prompts/custom-prompts/ ~/.claude/prompts/team/
```

---

### Custom Standards

```bash
# Standards are backward compatible
ls ~/.claude/standards/

# Optional: update with v2.0 best practices
# See: documentation/reference/standards-reference.md
```

---

## Rollback Procedures

If migration fails or issues arise:

### Option 1: Quick Rollback

```bash
# Restore v1.0 agents
rm -rf ~/.claude/agents/*
cp -r ~/.claude/agents.v1.backup/* ~/.claude/agents/

# Restore v1.0 commands
rm -rf ~/.claude/commands/*
cp -r ~/.claude/commands.v1.backup/* ~/.claude/commands/

# Remove v2.0 skills
rm -rf ~/.claude/skills/

# Checkout v1.0 tag
cd ~/claude-code-tresor
git checkout v1.0.0

# Restart Claude Code
```

---

### Option 2: Parallel Installation

Run v1.0 and v2.0 side-by-side:

```bash
# Keep v1.0 in production
# Install v2.0 in test environment

# Install v2.0 to alternate location
./scripts/install.sh --prefix ~/.claude-v2/

# Test v2.0 without affecting v1.0
export CLAUDE_CONFIG_PATH=~/.claude-v2/
claude

# When ready, switch permanently
mv ~/.claude ~/.claude-v1-backup
mv ~/.claude-v2 ~/.claude
```

---

## Testing After Migration

### Comprehensive Test Checklist

- [ ] **Skills activate automatically**
  - [ ] Save file with code issue
  - [ ] Verify code-reviewer provides suggestion
  - [ ] Verify security-auditor detects vulnerabilities

- [ ] **Agents invoked successfully**
  - [ ] `@code-reviewer analyze file.ts` works
  - [ ] `@test-engineer create tests` works
  - [ ] `@docs-writer generate documentation` works

- [ ] **Commands execute correctly**
  - [ ] `/scaffold react-component Test` works
  - [ ] `/review --scope staged` works
  - [ ] `/test-gen --file test.ts` works

- [ ] **Custom agents work**
  - [ ] Custom agents invoke with `@custom-name`
  - [ ] Custom agent configuration valid
  - [ ] Custom agent tools accessible

- [ ] **Custom commands work**
  - [ ] Custom commands invoke with `/custom-name`
  - [ ] Custom command configuration valid
  - [ ] Custom command workflows execute

- [ ] **Performance acceptable**
  - [ ] No significant slowdown
  - [ ] Skills don't overwhelm with suggestions
  - [ ] Commands complete in reasonable time

---

## Known Migration Issues

### Issue: Skills Overwhelming with Suggestions

**Problem:** After migration, too many skill suggestions

**Solution:**
```yaml
# Reduce skill priority or disable temporarily
---
name: "code-reviewer"
priority: "low"  # or enabled: false
---
```

---

### Issue: Agent Syntax Confusion

**Problem:** Team members use old `rr-` syntax

**Solution:**
- Update team documentation prominently
- Add alias/wrapper for transition period:
```bash
# Create temporary alias
alias rr-code-reviewer="echo 'Use: @code-reviewer (v2.0 syntax)'"
```

---

### Issue: Custom Agent Configuration Invalid

**Problem:** Custom agents fail with "configuration error"

**Solution:**
```bash
# Validate YAML frontmatter
cat ~/.claude/agents/custom-agent/SKILL.md

# Ensure required fields present:
---
name: "custom-agent"
description: "..."
tools: [...]  # Required in v2.0
---

# Test configuration
@custom-agent test invocation
```

---

## Post-Migration Optimization

### Optimize Skill Configuration

```yaml
---
name: "code-reviewer"
# Focus on critical file types only
file_patterns:
  - "src/**/*.ts"
  - "src/**/*.tsx"
exclude_patterns:
  - "node_modules/**"
  - "dist/**"
  - "*.test.ts"
  - "*.stories.tsx"
---
```

---

### Coordinate Skills and Agents

```yaml
---
name: "code-reviewer"
# Invoke specialist agent for deep issues
coordination:
  invoke_agents:
    - agent: "@security-auditor"
      when: "security_issue_detected"
---
```

---

## Version-Specific Notes

### v2.0.0 (October 2025)

**New Features:**
- 8 autonomous skills for real-time assistance
- Improved agent-skill coordination
- Enhanced command workflows
- Updated documentation structure

**Deprecations:**
- `rr-` agent prefix (use `@` instead)
- Flat command structure (use categorized directories)
- agent.json only (add YAML frontmatter)

**Removed:**
- Experimental utilities in `sources/experimental/`
- Deprecated agents (see CHANGELOG.md)

---

## Future Migration Guidance

### v2.x → v3.0 (Future)

**Expected Changes:**
- Enhanced skill coordination
- New agent capabilities
- Improved command orchestration

**Preparation:**
- Keep configurations in version control
- Document custom implementations
- Follow upgrade announcements

---

## Getting Help

**Migration Issues?**
- **[Troubleshooting Guide →](troubleshooting.md)**
- **[GitHub Issues →](https://github.com/alirezarezvani/claude-code-tresor/issues)**
- **[Migration FAQ →](../reference/faq.md#migration)**

**Need Assistance?**
- **[GitHub Discussions →](https://github.com/alirezarezvani/claude-code-tresor/discussions)**
- Create issue tagged `migration`

---

## Next Steps After Migration

1. **[Configuration Guide →](configuration.md)** - Optimize your setup
2. **[Getting Started →](getting-started.md)** - Learn v2.0 features
3. **[Skills Reference →](../reference/skills-reference.md)** - Master new skills
4. **[Best Practices →](../workflows/)** - v2.0 workflows

---

**Last Updated:** November 7, 2025 | **Version:** 2.0.0
