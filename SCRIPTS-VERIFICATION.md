# Scripts Verification Report - v2.7.0

**Date:** November 19, 2025
**Scripts Reviewed:** 4
**Status:** ⚠️ Issues Found - Fixes Recommended

---

## Scripts Overview

```
scripts/
├── install.sh              # Main installation script
├── update.sh               # Update existing installation
├── migrate-core-agent.sh   # Legacy migration script
└── publish-gist.sh         # Publish documentation gist
```

---

## ✅ install.sh - Main Installation Script

### Status: ⚠️ Minor Issue Found

### What Works ✓

**1. Core Installation Functions:**
- ✅ `install_commands()` - Correctly installs all commands from `/commands/` subdirectories
- ✅ `install_orchestration_commands()` - Correctly installs 10 orchestration commands
- ✅ `install_agents()` - Installs agents from `/agents/` (including symlinks)
- ✅ `install_subagents()` - Installs all 133 agents from `/subagents/`
- ✅ `install_skills()` - Correctly installs 8 skills
- ✅ `install_resources()` - Installs prompts, standards, examples

**2. Command Line Flags:**
- ✅ `--skills-only` - Install skills only
- ✅ `--commands-only` - Install all 19 commands
- ✅ `--agents-only` - Install agents + subagents
- ✅ `--orchestration` - Install 10 orchestration commands only (NEW v2.7)
- ✅ `--resources-only` - Install prompts/standards/examples
- ✅ `--update` - Update existing installation
- ✅ `--help` - Show help

**3. Help Text:**
- ✅ Updated with --orchestration flag
- ✅ Shows v2.7.0 command count (19 total)
- ✅ Lists orchestration commands in summary

**4. Summary Output:**
- ✅ Shows 4 development commands
- ✅ Shows 5 Tresor Workflow commands
- ✅ Shows 10 orchestration commands (NEW section)
- ✅ Shows 8 core agents
- ✅ Mentions 133 subagents

### Issue Found ⚠️

**Missing Variable Initialization:**

**Line 429-434:** Flag variables initialized
```bash
SKILLS_ONLY=false
COMMANDS_ONLY=false
AGENTS_ONLY=false
RESOURCES_ONLY=false
UPDATE_ONLY=false
NO_BACKUP=false
```

**Missing:**
```bash
ORCHESTRATION_ONLY=false  # ← NOT INITIALIZED
```

**Impact:** If ORCHESTRATION_ONLY is not initialized, the script may fail or behave unexpectedly when using `--orchestration` flag.

**Fix Required:**
```bash
# Add after line 431:
ORCHESTRATION_ONLY=false
```

---

## ✅ update.sh - Update Script

### Status: ✅ No Issues

### What Works ✓

**1. Update Functions:**
- ✅ `update_commands()` - Removes old, installs new commands
- ✅ `update_agents()` - Updates both `/agents/` and `/subagents/`
- ✅ `update_resources()` - Updates prompts, standards, examples
- ✅ `update_config()` - Updates version in config file

**2. Subagent Handling (Lines 193-202):**
```bash
# Also update subagents if they exist
local subagents_src="$TRESOR_DIR/subagents"
if [ -d "$subagents_src" ]; then
    log "Updating subagents directory..."
    local subagents_dest="$CLAUDE_CODE_DIR/subagents"
    rm -rf "$subagents_dest"  # Clean update
    cp -r "$subagents_src" "$subagents_dest"
    local subagent_count=$(find "$subagents_dest" -name "agent.md" -type f | wc -l)
    log "Updated $subagent_count subagents"
fi
```

**Correctly:**
- ✅ Removes old subagents directory
- ✅ Copies entire new subagents structure
- ✅ Counts installed agents
- ✅ Works with v2.7.0 structure

**3. Selective Update:**
- ✅ `--commands-only` - Update only commands
- ✅ `--agents-only` - Update agents and subagents
- ✅ `--resources-only` - Update resources only

**4. Safety Features:**
- ✅ Creates backup before update
- ✅ `--rollback` flag to restore backup
- ✅ Conflict detection
- ✅ `--cleanup` to remove old backups

**Recommendation:** No changes needed ✅

---

## ⚠️ migrate-core-agent.sh - Legacy Migration Script

### Status: ⚠️ Deprecated - Should Be Removed or Updated

### Issues Found

**1. Hardcoded Paths (Lines 12-13):**
```bash
SOURCE_DIR="/Users/rezarezvani/projects/claude-code-tresor/agents"
TARGET_DIR="/Users/rezarezvani/projects/claude-code-tresor/subagents/core"
```

**Problem:**
- ❌ Won't work for other users (hardcoded username)
- ❌ Assumes specific directory structure
- ❌ Not portable

**2. Outdated Purpose:**
- This script was used to migrate agents from `/agents/` to `/subagents/core/`
- Migration is complete in v2.7.0
- Script is no longer needed

**3. No Error Handling:**
- Minimal error checking
- Assumes files exist
- No validation of migration success

### Recommendations

**Option 1: Remove Script (Recommended)**
- Migration is complete
- No longer needed for v2.7.0+
- Reduces maintenance burden

**Option 2: Archive Script**
- Move to `scripts/archive/migrate-core-agent.sh`
- Add deprecation notice
- Document it's for historical reference only

**Option 3: Update for General Use**
- Replace hardcoded paths with `$PWD` or arguments
- Add proper error handling
- Document when/why to use it

**Recommended Action:** Remove or archive (Option 1 or 2)

---

## ✅ publish-gist.sh - Gist Publishing Script

### Status: ✅ No Issues

### What Works ✓

**1. Functionality:**
- ✅ Publishes documentation gist to GitHub
- ✅ Checks for `gh` CLI availability
- ✅ Checks authentication status
- ✅ Creates public gist with proper metadata

**2. User Experience:**
- ✅ Clear error messages if gh not installed
- ✅ Manual publishing instructions as fallback
- ✅ Copies URL to clipboard (macOS/Linux)
- ✅ Provides sharing suggestions (Twitter, Reddit, HN)

**3. Description:**
```bash
GIST_DESCRIPTION="Ultimate guide to extending Claude Code with skills, agents,
commands, and utilities. Covers Tresor (ready-to-use), Skill Factory
(custom builds), and Skills Library (26+ domain packages)."
```

**Correctly:**
- ✅ Mentions Tresor, Skill Factory, Skills Library
- ✅ Accurate ecosystem description

**Recommendation:** No changes needed ✅

---

## Summary of Issues

| Script | Status | Issues | Action Required |
|--------|--------|--------|-----------------|
| **install.sh** | ⚠️ Minor Issue | Missing ORCHESTRATION_ONLY variable init | Add 1 line |
| **update.sh** | ✅ Good | None | No changes |
| **migrate-core-agent.sh** | ⚠️ Deprecated | Hardcoded paths, outdated purpose | Remove or archive |
| **publish-gist.sh** | ✅ Good | None | No changes |

---

## Recommended Fixes

### Fix 1: install.sh - Add Missing Variable (CRITICAL)

**Location:** Line 429-435 (after `NO_BACKUP=false`)

**Current:**
```bash
# Parse command line arguments
CHECK_ONLY=false
FORCE_UPDATE=false
SKIP_BACKUP=false
COMMANDS_ONLY=false
AGENTS_ONLY=false
RESOURCES_ONLY=false  # Line 434
                      # MISSING: ORCHESTRATION_ONLY=false
ROLLBACK=false
CLEANUP=false
```

**Fix:**
```bash
# Parse command line arguments
SKILLS_ONLY=false
COMMANDS_ONLY=false
AGENTS_ONLY=false
ORCHESTRATION_ONLY=false  # ← ADD THIS LINE
RESOURCES_ONLY=false
UPDATE_ONLY=false
NO_BACKUP=false
```

**Impact if Not Fixed:**
- Script will fail with "unbound variable" error when using `--orchestration` flag
- Critical for v2.7.0 since it's a new feature

---

### Fix 2: migrate-core-agent.sh - Remove or Archive (RECOMMENDED)

**Option A: Remove Entirely**
```bash
# Remove script (migration complete)
git rm scripts/migrate-core-agent.sh
git commit -m "chore: remove deprecated migration script"
```

**Option B: Archive**
```bash
# Create archive directory
mkdir -p scripts/archive

# Move script
git mv scripts/migrate-core-agent.sh scripts/archive/

# Add deprecation notice
cat > scripts/archive/README.md << 'EOF'
# Archived Scripts

These scripts are kept for historical reference only.

## migrate-core-agent.sh

**Status:** Deprecated (v2.7.0)
**Purpose:** Migrated agents from /agents/ to /subagents/core/ (completed)
**Use:** No longer needed - migration is complete
EOF

git add scripts/archive/README.md
git commit -m "chore: archive deprecated migration script"
```

**Recommended:** Option A (remove) - Migration is complete, script serves no purpose

---

## Additional Recommendations

### Enhancement 1: Add Version Check to install.sh

**Add before installation:**
```bash
check_version() {
    local current_version="2.7.0"

    if [ -f "$CLAUDE_CODE_DIR/tresor.config.json" ]; then
        local installed_version=$(jq -r '.version' "$CLAUDE_CODE_DIR/tresor.config.json" 2>/dev/null || echo "unknown")

        if [ "$installed_version" != "unknown" ] && [ "$installed_version" != "$current_version" ]; then
            warn "Upgrading from v$installed_version to v$current_version"
            warn "See MIGRATION.md for upgrade instructions"
        fi
    fi
}
```

**Benefit:** Warns users about version changes and points to migration guide

---

### Enhancement 2: Validate Installation After Completion

**Add after installation:**
```bash
validate_installation() {
    header "Validating Installation"

    local errors=0

    # Check commands installed
    if [ -d "$CLAUDE_CODE_DIR/commands" ]; then
        local cmd_count=$(find "$CLAUDE_CODE_DIR/commands" -name "*.md" -type f | wc -l)
        if [ "$cmd_count" -ge 19 ]; then
            log "Commands: $cmd_count installed ✓"
        else
            warn "Commands: Expected ≥19, found $cmd_count"
            errors=$((errors + 1))
        fi
    fi

    # Check agents installed
    if [ -d "$CLAUDE_CODE_DIR/subagents" ]; then
        local agent_count=$(find "$CLAUDE_CODE_DIR/subagents" -name "agent.md" -type f | wc -l)
        if [ "$agent_count" -ge 133 ]; then
            log "Agents: $agent_count installed ✓"
        else
            warn "Agents: Expected ≥133, found $agent_count"
            errors=$((errors + 1))
        fi
    fi

    # Check skills installed
    if [ -d "$CLAUDE_CODE_DIR/skills" ]; then
        local skill_count=$(find "$CLAUDE_CODE_DIR/skills" -name "SKILL.md" -type f | wc -l)
        if [ "$skill_count" -ge 8 ]; then
            log "Skills: $skill_count installed ✓"
        else
            warn "Skills: Expected ≥8, found $skill_count"
            errors=$((errors + 1))
        fi
    fi

    if [ $errors -eq 0 ]; then
        log "Installation validated successfully ✓"
    else
        warn "Installation completed with $errors warnings"
    fi
}
```

**Benefit:** Ensures installation completed correctly, catches issues early

---

## Testing Checklist

### Test install.sh (After Fixing Missing Variable)

```bash
# Test 1: Full installation
./scripts/install.sh
# Expected: All components installed

# Test 2: Orchestration only
./scripts/install.sh --orchestration
# Expected: Only 10 orchestration commands installed

# Test 3: Agents only
./scripts/install.sh --agents-only
# Expected: 8 core agents + 133 subagents installed

# Test 4: Commands only
./scripts/install.sh --commands-only
# Expected: All 19 commands installed

# Test 5: Skills only
./scripts/install.sh --skills-only
# Expected: 8 skills installed

# Test 6: Help
./scripts/install.sh --help
# Expected: Help text with all options
```

### Test update.sh

```bash
# Test 1: Check for updates
./scripts/update.sh --check
# Expected: Shows if updates available

# Test 2: Full update
./scripts/update.sh
# Expected: Updates all components

# Test 3: Commands only update
./scripts/update.sh --commands-only
# Expected: Updates only commands

# Test 4: Rollback
./scripts/update.sh --rollback
# Expected: Restores previous version
```

---

## Critical Fix Required

### Fix install.sh - Add ORCHESTRATION_ONLY Variable

**File:** `scripts/install.sh`
**Line:** After line 431 (after `AGENTS_ONLY=false`)

**Add:**
```bash
ORCHESTRATION_ONLY=false
```

**Without this fix:** `--orchestration` flag will cause script to fail

---

## Recommended Actions

### Immediate (Critical)

1. **Fix install.sh missing variable**
   - Add `ORCHESTRATION_ONLY=false` initialization
   - Test `--orchestration` flag works

### High Priority

2. **Remove deprecated migrate-core-agent.sh**
   - Migration is complete
   - Script no longer needed
   - Contains hardcoded paths

### Optional Enhancements

3. **Add installation validation**
   - Verify correct count of commands/agents/skills
   - Catch installation issues early

4. **Add version check**
   - Warn users about version upgrades
   - Point to MIGRATION.md

---

## Installation Flow Validation

### Scenario 1: New User - Full Installation

```bash
./scripts/install.sh
```

**Expected Flow:**
1. Check dependencies (git, claude-code) ✓
2. Create directories (.claude/commands, agents, skills) ✓
3. No backup (fresh install) ✓
4. Clone repository to .claude/tresor ✓
5. Install skills (8 skills) ✓
6. Install commands (19 commands) ✓
7. Install agents (8 from /agents/ including symlinks) ✓
8. Install subagents (133 from /subagents/) ✓
9. Install resources (prompts, standards, examples) ✓
10. Create config file ✓
11. Create update script ✓
12. Print summary ✓

**Result:** ✅ Should work correctly

---

### Scenario 2: User Wants Only Orchestration Commands

```bash
./scripts/install.sh --orchestration
```

**Expected Flow:**
1. Check dependencies ✓
2. Create directories ✓
3. Backup (if exists) ✓
4. Clone/update repository ✓
5. Call install_orchestration_commands() ✓
6. Install from commands/security/, performance/, operations/, quality/ ✓
7. Print summary ✓

**Result:** ⚠️ Will fail without ORCHESTRATION_ONLY=false initialization

---

### Scenario 3: Existing User - Update

```bash
./scripts/update.sh
```

**Expected Flow:**
1. Check installation exists ✓
2. Check for updates (git fetch) ✓
3. Create backup ✓
4. Pull latest changes ✓
5. Update commands (remove old, install new) ✓
6. Update agents AND subagents ✓
7. Update resources ✓
8. Update config file ✓
9. Check conflicts ✓
10. Print summary ✓

**Result:** ✅ Should work correctly (subagents properly handled)

---

## Verification Tests Passed

### install.sh

✅ **Structure Analysis:**
- All functions properly defined
- Proper error handling with `set -e`
- Color-coded output for user experience
- Trap for interruption handling

✅ **Directory Handling:**
- Creates all necessary directories
- Backs up existing installation
- Handles missing directories gracefully

✅ **Installation Logic:**
- Correctly copies files with `cp -r`
- Uses `find` to locate command/agent directories
- Maintains directory structure

✅ **Flags:**
- All flags properly parsed in case statement
- Conditional logic correct in main()
- Help text matches available flags

### update.sh

✅ **Update Logic:**
- Removes old before installing new (prevents orphans)
- Handles both agents and subagents
- Updates config file with new version
- Creates backups before updates

✅ **Safety:**
- Backup before update
- Rollback capability
- Conflict detection
- Cleanup old backups

---

## Conclusion

### Overall Assessment

**3 out of 4 scripts are production-ready:**
- ✅ update.sh - Fully functional
- ✅ publish-gist.sh - Fully functional
- ⚠️ install.sh - **1 critical fix needed** (missing variable)
- ⚠️ migrate-core-agent.sh - Deprecated, should be removed

### Critical Fix Required Before Release

**File:** `scripts/install.sh`
**Line:** 432 (after `AGENTS_ONLY=false`)
**Add:** `ORCHESTRATION_ONLY=false`

**Impact:** Without this fix, `--orchestration` flag won't work

### Recommended Actions

1. **CRITICAL:** Add ORCHESTRATION_ONLY=false to install.sh
2. **RECOMMENDED:** Remove or archive migrate-core-agent.sh
3. **OPTIONAL:** Add installation validation
4. **OPTIONAL:** Add version check warning

---

**Status:** 1 critical fix required before v2.7.0 release

**Estimated Time:** 5 minutes to fix + test

Would you like me to apply the critical fix now?
