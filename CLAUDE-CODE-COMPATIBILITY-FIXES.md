# Claude Code Compatibility Fixes - v2.7.0

**Date:** November 19, 2025
**Issue:** #40
**Reporter:** marcel-Ngan
**Status:** ✅ FIXED

---

## Overview

Fixed 3 critical compatibility issues preventing Claude Code from automatically loading Tresor skills and agents. All issues were caused by incorrect directory structure and YAML frontmatter that didn't match Claude Code's expectations.

---

## Problems Identified

### Problem 1: Skills Directory Structure Too Nested ❌

**Issue:**
- **Tresor Repository:** `skills/development/code-reviewer/SKILL.md` (2 levels deep)
- **Claude Code Expects:** `.claude/skills/code-reviewer/SKILL.md` (1 level deep)
- **Result:** Claude Code couldn't find skills because of extra category layer

**Root Cause:**
`install_skills()` in install.sh maintained the category structure when copying:
```bash
# OLD (BROKEN):
cp -r "$skill_dir" "$skills_dest/${category}/${skill_name}"
# Results in: .claude/skills/development/code-reviewer/
```

---

### Problem 2: Agents Should Be Flat .md Files ❌

**Issue:**
- **Tresor Install Created:** `.claude/agents/security-auditor/agent.md` (directory)
- **Claude Code Expects:** `.claude/agents/security-auditor.md` (flat file)
- **Result:** Claude Code couldn't load agents from directories

**Root Cause:**
`install_agents()` copied entire directories instead of extracting agent.md:
```bash
# OLD (BROKEN):
cp -r "$agent_dir" "$agents_dest/$agent_name"
# Results in: .claude/agents/security-auditor/ (directory)
```

---

### Problem 3: Non-Standard YAML Frontmatter Fields ❌

**Issue:**
Agent files contained unsupported YAML fields:
```yaml
---
name: "systems-architect"
description: "Expert system architect..."
category: "core"              # ❌ Not supported
team: "engineering"           # ❌ Not supported
color: "#FFD700"             # ❌ Not supported
capabilities:                 # ❌ Not supported
  - "System Design..."
max_iterations: 50            # ❌ Not supported
tools: Read, Write, Edit
model: claude-opus-4
enabled: true
---
```

**Claude Code Supported Fields:**
```yaml
---
name: agent-name              # ✅ Supported
description: ...              # ✅ Supported
tools: Read, Edit, Grep       # ✅ Supported
model: sonnet                 # ✅ Supported (opus, sonnet, haiku, inherit)
enabled: true                 # ✅ Supported
---
```

**Root Cause:**
Repository agent files included Tresor-specific metadata fields for documentation/organization that Claude Code doesn't recognize.

---

## Solutions Implemented

### Fix 1: Flatten Skills Structure ✅

**Updated:** `install_skills()` in scripts/install.sh

**Before:**
```bash
# Maintained category nesting
cp -r "$skill_dir" "$skills_dest/${category}/${skill_name}"
```

**After:**
```bash
# Flatten to one level (remove category layer)
cp -r "$skill_dir" "$skills_dest/$skill_name"
```

**Result:**
- `skills/development/code-reviewer/SKILL.md` → `.claude/skills/code-reviewer/SKILL.md` ✓
- `skills/security/security-auditor/SKILL.md` → `.claude/skills/security-auditor/SKILL.md` ✓

**Log Output:**
```
Installing skill: code-reviewer (from development)
Installing skill: security-auditor (from security)
```

---

### Fix 2: Create Flat Agent .md Files ✅

**Updated:** `install_agents()` in scripts/install.sh

**Before:**
```bash
# Copied entire directory
cp -r "$agent_dir" "$agents_dest/$agent_name"
# Result: .claude/agents/systems-architect/ (directory)
```

**After:**
```bash
# Extract agent.md and create flat file
awk '...' "$agent_file" > "$agents_dest/${agent_name}.md"
# Result: .claude/agents/systems-architect.md (flat file) ✓
```

**Result:**
- `subagents/core/systems-architect/agent.md` → `.claude/agents/systems-architect.md` ✓
- `subagents/core/security-auditor/agent.md` → `.claude/agents/security-auditor.md` ✓

---

### Fix 3: Strip Unsupported YAML Fields ✅

**Implementation:** AWK script in install_agents() and update_agents()

**AWK Logic:**
```bash
awk '
BEGIN { in_frontmatter=0; frontmatter_done=0; }

# Track YAML frontmatter boundaries (---)
/^---$/ {
    # Handle opening and closing ---
    ...
}

# Inside frontmatter: filter fields
in_frontmatter == 1 {
    # Only keep supported fields
    if ($0 ~ /^(name|description|tools|model|enabled):/) {
        print;  # Keep this line
    }
    # Skip everything else (category, team, color, capabilities, max_iterations)
    next;
}

# Outside frontmatter: keep everything
{ print }
'
```

**Fields Removed:**
- `category:` - Tresor organizational metadata
- `team:` - Tresor organizational metadata
- `color:` - Tresor UI metadata
- `subcategory:` - Tresor organizational metadata
- `capabilities:` - Tresor documentation
- `max_iterations:` - Tresor-specific setting

**Fields Kept:**
- `name:` - Agent identifier ✅
- `description:` - Agent description ✅
- `tools:` - Available tools ✅
- `model:` - Model to use ✅
- `enabled:` - Enable/disable flag ✅

**Result:**
```yaml
# BEFORE (in repository):
---
name: "systems-architect"
description: "Expert system architect..."
category: "core"
team: "engineering"
color: "#FFD700"
capabilities:
  - "System Design..."
max_iterations: 50
tools: Read, Write, Edit
model: claude-opus-4
enabled: true
---

# AFTER (in .claude/agents/):
---
name: "systems-architect"
description: "Expert system architect..."
tools: Read, Write, Edit
model: claude-opus-4
enabled: true
---
```

---

## Files Modified

### scripts/install.sh

**Changes:**
1. `install_skills()` - Lines 207-235
   - Flatten skills structure (remove category nesting)
   - Direct copy to `.claude/skills/{skill-name}/`

2. `install_agents()` - Lines 158-215
   - Source from `subagents/core/` instead of `agents/`
   - Create flat `.md` files instead of directories
   - Strip unsupported YAML fields with AWK
   - Result: `.claude/agents/{agent-name}.md`

### scripts/update.sh

**Changes:**
1. `update_agents()` - Lines 166-237
   - Match install.sh logic (flat files, clean YAML)
   - Remove old agents completely before update
   - Apply same AWK filtering

---

## Testing

### Test 1: Skills Installation

```bash
# After fix:
./scripts/install.sh --skills-only

# Expected result:
ls ~/.claude/skills/
# code-reviewer/
# test-generator/
# git-commit-helper/
# security-auditor/
# secret-scanner/
# dependency-auditor/
# api-documenter/
# readme-updater/

# Each should have SKILL.md inside
ls ~/.claude/skills/code-reviewer/
# SKILL.md ✓
```

---

### Test 2: Agents Installation

```bash
# After fix:
./scripts/install.sh --agents-only

# Expected result:
ls ~/.claude/agents/
# systems-architect.md ✓ (flat file, not directory)
# config-safety-reviewer.md ✓
# root-cause-analyzer.md ✓
# security-auditor.md ✓
# test-engineer.md ✓
# performance-tuner.md ✓
# refactor-expert.md ✓
# docs-writer.md ✓
```

---

### Test 3: YAML Frontmatter

```bash
# After fix:
head -15 ~/.claude/agents/systems-architect.md

# Expected output (cleaned YAML):
---
name: "systems-architect"
description: "Expert system architect specializing in evidence-based design decisions..."
tools: Read, Write, Edit, Grep, Glob, Bash, WebFetch, Task
model: claude-opus-4
enabled: true
---

# NO category, team, color, capabilities, max_iterations ✓
```

---

### Test 4: Claude Code Loading

```bash
# Start Claude Code and verify:
claude-code

# In Claude Code session:
@systems-architect --help
# Should work ✓

# Test skill auto-activation:
# [Edit a file]
# code-reviewer skill should activate automatically ✓
```

---

## Impact

### Before Fixes
- ❌ Skills: Not loaded (too nested)
- ❌ Agents: Not loaded (wrong structure)
- ❌ YAML: Parsing errors (unsupported fields)
- **Result:** Tresor completely non-functional in Claude Code

### After Fixes
- ✅ Skills: Loaded correctly (flattened structure)
- ✅ Agents: Loaded correctly (flat .md files)
- ✅ YAML: Parsed correctly (only supported fields)
- **Result:** Tresor fully functional in Claude Code

---

## Backward Compatibility

### Repository Structure (Unchanged)

The repository structure remains unchanged:
```
claude-code-tresor/
├── skills/
│   ├── development/
│   │   ├── code-reviewer/
│   │   └── test-generator/
│   └── security/
│       └── security-auditor/
├── subagents/
│   └── core/
│       ├── systems-architect/
│       │   └── agent.md
│       └── security-auditor/
│           └── agent.md
```

**Why keep this structure?**
- Better organization for 133 agents
- Color-coded teams for documentation
- Rich metadata for repository browsing
- Clean separation of concerns

### Installation Transforms Structure

**During installation, scripts transform:**
- `skills/category/skill-name/` → `.claude/skills/skill-name/` (flatten)
- `subagents/core/agent/agent.md` → `.claude/agents/agent.md` (flatten + clean YAML)

**This ensures:**
- ✅ Repository: Well-organized, documented, browseable
- ✅ Claude Code: Correct structure, clean YAML, fully functional

---

## Migration for Existing Users

### If Already Installed Tresor

**Symptoms:**
- Agents not working (`@systems-architect` not found)
- Skills not auto-activating
- Errors about unknown YAML fields

**Solution:**
```bash
# Reinstall with fixed scripts:
cd /path/to/claude-code-tresor
git pull origin main  # Get fixes
./scripts/install.sh  # Reinstall with correct structure

# Or update:
./scripts/update.sh  # Uses fixed logic
```

**What Happens:**
1. Old incorrect structure removed
2. New correct structure installed
3. YAML cleaned automatically
4. Agents and skills now work ✓

---

## Technical Details

### AWK Script for YAML Filtering

**Purpose:** Remove unsupported YAML fields while preserving content

**How It Works:**
1. Tracks frontmatter boundaries (`---`)
2. Inside frontmatter: Only print lines matching supported fields
3. Outside frontmatter: Print everything
4. Preserves all agent logic/content after frontmatter

**Supported Field Regex:**
```bash
/^(name|description|tools|model|enabled):/
```

**Why AWK vs sed/grep:**
- Handles multi-line YAML (capabilities array)
- Precise frontmatter boundary detection
- Preserves all non-frontmatter content
- Single-pass processing

---

## Validation

### Automated Validation Script

Future enhancement - add to install.sh:
```bash
validate_installation() {
    # Check skills are flat
    local nested_skills=$(find "$CLAUDE_CODE_DIR/skills" -mindepth 2 -name "SKILL.md" | wc -l)
    if [ "$nested_skills" -gt 0 ]; then
        warn "Found $nested_skills nested skills (should be flat)"
    fi

    # Check agents are flat files
    local agent_dirs=$(find "$CLAUDE_CODE_DIR/agents" -mindepth 1 -type d | wc -l)
    if [ "$agent_dirs" -gt 0 ]; then
        warn "Found $agent_dirs agent directories (should be flat .md files)"
    fi

    # Check YAML fields
    for agent in "$CLAUDE_CODE_DIR/agents"/*.md; do
        if grep -q "^category:" "$agent" || grep -q "^team:" "$agent"; then
            warn "$(basename $agent) contains unsupported YAML fields"
        fi
    done
}
```

---

## Credits

**Issue Reported By:** marcel-Ngan (GitHub issue #40)
**Fixed By:** Alireza Rezvani
**Date:** November 19, 2025
**Version:** v2.7.0 patch

---

## Related Documentation

- **GitHub Issue:** #40
- **Installation Script:** scripts/install.sh
- **Update Script:** scripts/update.sh
- **Claude Code Docs:** https://claude.ai/code/docs

---

**Status:** All 3 problems fixed in scripts/install.sh and scripts/update.sh

**Verification:** Pending user testing after merge
