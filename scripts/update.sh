#!/bin/bash

# Claude Code Tresor Update Script
# Author: Alireza Rezvani
# License: MIT
# Created: September 16, 2025

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration (env-overridable for tests and custom layouts)
CLAUDE_CODE_DIR="${CLAUDE_CODE_DIR:-${HOME}/.claude}"
TRESOR_DIR="${TRESOR_DIR:-${CLAUDE_CODE_DIR}/tresor}"
CONFIG_FILE="${CLAUDE_CODE_DIR}/tresor.config.json"
BACKUP_DIR="${CLAUDE_CODE_DIR}/backup-update-$(date +%Y%m%d-%H%M%S)"

# Functions
log() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1"
    exit 1
}

header() {
    echo -e "\n${BLUE}=== $1 ===${NC}\n"
}

check_installation() {
    header "Checking Installation"

    if [ ! -d "$CLAUDE_CODE_DIR" ]; then
        error "Claude Code directory not found. Please run the installation script first."
    fi

    if [ ! -d "$TRESOR_DIR" ]; then
        error "Tresor installation not found. Please run the installation script first."
    fi

    if [ ! -f "$CONFIG_FILE" ]; then
        warn "Configuration file not found. This might be an older installation."
    else
        log "Existing installation detected"
        local version=$(jq -r '.version' "$CONFIG_FILE" 2>/dev/null || echo "unknown")
        local installed=$(jq -r '.installed' "$CONFIG_FILE" 2>/dev/null || echo "unknown")
        log "Current version: $version (installed: $installed)"
    fi
}

check_for_updates() {
    header "Checking for Updates"

    cd "$TRESOR_DIR"

    # Fetch latest changes
    log "Fetching latest changes..."
    git fetch origin main

    # Check if update is needed
    local local_commit=$(git rev-parse HEAD)
    local remote_commit=$(git rev-parse origin/main)

    if [ "$local_commit" = "$remote_commit" ]; then
        log "Already up to date!"
        return 1
    else
        log "Updates available"
        log "Current: ${local_commit:0:8}"
        log "Latest:  ${remote_commit:0:8}"

        # Show what will be updated
        echo -e "\n${BLUE}Recent changes:${NC}"
        git log --oneline --decorate --graph HEAD..origin/main | head -10
        return 0
    fi
}

create_backup() {
    header "Creating Backup"

    if [ "$SKIP_BACKUP" = false ]; then
        log "Creating backup at: $BACKUP_DIR"

        # Create backup directory
        mkdir -p "$BACKUP_DIR"

        # Backup current installation
        if [ -d "$CLAUDE_CODE_DIR/commands" ]; then
            cp -r "$CLAUDE_CODE_DIR/commands" "$BACKUP_DIR/"
        fi

        if [ -d "$CLAUDE_CODE_DIR/agents" ]; then
            cp -r "$CLAUDE_CODE_DIR/agents" "$BACKUP_DIR/"
        fi

        if [ -d "$CLAUDE_CODE_DIR/skills" ]; then
            cp -r "$CLAUDE_CODE_DIR/skills" "$BACKUP_DIR/"
        fi

        if [ -d "$CLAUDE_CODE_DIR/tresor-resources" ]; then
            cp -r "$CLAUDE_CODE_DIR/tresor-resources" "$BACKUP_DIR/"
        fi

        if [ -f "$CONFIG_FILE" ]; then
            cp "$CONFIG_FILE" "$BACKUP_DIR/"
        fi

        log "Backup created successfully"
    else
        log "Skipping backup as requested"
    fi
}

update_repository() {
    header "Updating Repository"

    cd "$TRESOR_DIR"

    log "Pulling latest changes..."
    git pull origin main

    local new_commit=$(git rev-parse HEAD)
    log "Updated to: ${new_commit:0:8}"
}

# Commands are installed as flat files (~/.claude/commands/<name>.md) so that
# Claude Code names them /<name>. Only Tresor's own files are touched: personal
# commands in the same folder are left alone. Keep in sync with install.sh.
update_commands() {
    header "Updating Commands"

    local commands_src="$TRESOR_DIR/commands"
    local commands_dest="$CLAUDE_CODE_DIR/commands"

    if [ -d "$commands_src" ]; then
        log "Updating commands..."
        mkdir -p "$commands_dest"

        find "$commands_src" -type f -name '*.md' ! -name 'README.md' | sort | while read -r cmd_file; do
            local cmd_name
            cmd_name=$(basename "$cmd_file" .md)
            local rel="${cmd_file#"$commands_src"/}"
            local category="${rel%%/*}"
            local legacy_dir="$commands_dest/${category}-${cmd_name}"

            # Releases before v2.8.0 installed "<category>-<name>/" directories
            if [ -d "$legacy_dir" ]; then
                log "Removing old command directory: ${category}-${cmd_name}"
                rm -rf "$legacy_dir"
            fi

            log "Updating command: /${cmd_name}"
            cp "$cmd_file" "$commands_dest/${cmd_name}.md"
        done

        log "Commands updated successfully"
    else
        warn "Commands directory not found in repository"
    fi
}

update_skills() {
    header "Updating Skills"

    local skills_src="$TRESOR_DIR/skills"
    local skills_dest="$CLAUDE_CODE_DIR/skills"

    if [ -d "$skills_src" ]; then
        log "Updating skills..."

        find "$skills_src" -mindepth 2 -maxdepth 2 -type d | while read -r skill_dir; do
            local skill_name
            skill_name=$(basename "$skill_dir")

            if [ -f "$skill_dir/SKILL.md" ]; then
                log "Updating skill: $skill_name"
                mkdir -p "$skills_dest/$skill_name"
                rm -rf "$skills_dest/$skill_name/$skill_name"  # left behind by older installers
                cp -r "$skill_dir/." "$skills_dest/$skill_name/"
            fi
        done

        log "Skills updated successfully"
    else
        warn "Skills directory not found in repository"
    fi
}

# Write one agent as the flat .md file Claude Code loads, keeping only the
# frontmatter fields Claude Code knows: name, description, tools, model, enabled.
# Tresor's own fields (category, team, color, capabilities, ...) are dropped.
install_agent_file() {
    local src="$1" dest="$2"
    awk '
    BEGIN { in_fm=0; fm_done=0 }
    /^---$/ && fm_done == 0 {
        if (in_fm == 0) { in_fm=1 } else { in_fm=0; fm_done=1 }
        print; next
    }
    # A field starts at column 1; indented lines (list items) belong to it.
    in_fm == 1 && /^[^ \t]/ { keep = ($0 ~ /^(name|description|tools|model|enabled):/) }
    in_fm == 1 { if (keep) print; next }
    { print }
    ' "$src" > "$dest"
}

update_agents() {
    header "Updating Agents"

    local subagents_src="$TRESOR_DIR/subagents/core"
    local agents_dest="$CLAUDE_CODE_DIR/agents"

    if [ -d "$subagents_src" ]; then
        log "Updating agents..."

        # Only Tresor's own agent files are replaced below; personal agents
        # in the same folder are left alone.
        mkdir -p "$agents_dest"

        # Claude Code expects flat .md files: .claude/agents/agent-name.md
        # Convert from subagents/core/agent-name/agent.md → agents/agent-name.md
        find "$subagents_src" -mindepth 1 -maxdepth 1 -type d | while read -r agent_dir; do
            local agent_name=$(basename "$agent_dir")
            local agent_file="$agent_dir/agent.md"

            if [ -f "$agent_file" ]; then
                log "Updating core agent: $agent_name"

                install_agent_file "$agent_file" "$agents_dest/${agent_name}.md"
            fi
        done

        # Also update subagents directory (for repository reference)
        local subagents_full_src="$TRESOR_DIR/subagents"
        if [ -d "$subagents_full_src" ]; then
            log "Updating subagents directory..."
            local subagents_dest="$CLAUDE_CODE_DIR/subagents"
            mkdir -p "$subagents_dest"
            rm -rf "$subagents_dest/subagents"  # left behind by older installers
            cp -r "$subagents_full_src/." "$subagents_dest/"
            local subagent_count=$(find "$subagents_dest" -name "agent.md" -type f | wc -l)
            log "Updated $subagent_count subagents"
        fi

        log "Agents updated successfully (flat .md files)"
    else
        warn "Subagents core directory not found in repository"
    fi
}

update_resources() {
    header "Updating Resources"

    local resources_dest="$CLAUDE_CODE_DIR/tresor-resources"

    log "Updating resources..."

    # Remove old resources
    if [ -d "$resources_dest" ]; then
        rm -rf "$resources_dest"
    fi

    mkdir -p "$resources_dest"

    # Copy updated resources
    for resource in prompts standards examples; do
        if [ -d "$TRESOR_DIR/$resource" ]; then
            log "Updating $resource resources"
            cp -r "$TRESOR_DIR/$resource" "$resources_dest/"
        fi
    done

    # Copy updated documentation
    if [ -f "$TRESOR_DIR/README.md" ]; then
        cp "$TRESOR_DIR/README.md" "$resources_dest/"
    fi

    if [ -f "$TRESOR_DIR/CONTRIBUTING.md" ]; then
        cp "$TRESOR_DIR/CONTRIBUTING.md" "$resources_dest/"
    fi

    log "Resources updated successfully"
}

update_config() {
    header "Updating Configuration"

    log "Updating configuration file..."

    # version.txt is the single source of truth for the release version
    local new_version="unknown"
    if [ -f "$TRESOR_DIR/version.txt" ]; then
        new_version=$(tr -d '[:space:]' < "$TRESOR_DIR/version.txt")
    fi

    # Preserve existing config and update relevant fields
    local temp_config="/tmp/tresor.config.json"

    if [ -f "$CONFIG_FILE" ]; then
        # Update existing config
        jq --arg version "$new_version" --arg updated "$(date -u +"%Y-%m-%dT%H:%M:%SZ")" '
            .version = $version |
            .updated = $updated |
            .lastUpdate = .installed |
            .installed = $updated
        ' "$CONFIG_FILE" > "$temp_config"
    else
        # Create new config
        cat > "$temp_config" << EOF
{
  "version": "$new_version",
  "installed": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "updated": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "author": "Alireza Rezvani",
  "repository": "https://github.com/alirezarezvani/claude-code-tresor",
  "directories": {
    "commands": "$CLAUDE_CODE_DIR/commands",
    "agents": "$CLAUDE_CODE_DIR/agents",
    "resources": "$CLAUDE_CODE_DIR/tresor-resources"
  }
}
EOF
    fi

    mv "$temp_config" "$CONFIG_FILE"
    log "Configuration updated successfully"
}

check_conflicts() {
    header "Checking for Conflicts"

    local conflicts_found=false

    # Check for modified files that might conflict
    cd "$TRESOR_DIR"

    if git diff --quiet HEAD~1..HEAD; then
        log "No conflicts detected"
    else
        warn "Some files have been modified. Checking for conflicts..."

        # List modified files
        git diff --name-only HEAD~1..HEAD | while read -r file; do
            local dest_file=""

            case "$file" in
                commands/*)
                    dest_file="$CLAUDE_CODE_DIR/$(echo "$file" | sed 's|commands/\([^/]*\)/\([^/]*\)|\1-\2|')"
                    ;;
                agents/*)
                    dest_file="$CLAUDE_CODE_DIR/$file"
                    ;;
                *)
                    continue
                    ;;
            esac

            if [ -f "$dest_file" ]; then
                log "Updated: $file"
            fi
        done
    fi
}

print_summary() {
    header "Update Summary"

    echo -e "${GREEN}✅ Claude Code Tresor updated successfully!${NC}\n"

    # Show version information
    if [ -f "$CONFIG_FILE" ]; then
        local version=$(jq -r '.version' "$CONFIG_FILE" 2>/dev/null || echo "unknown")
        local updated=$(jq -r '.updated' "$CONFIG_FILE" 2>/dev/null || echo "unknown")
        echo "📦 Version: $version"
        echo "🕐 Updated: $updated"
        echo
    fi

    echo "📍 Installation Location:"
    echo "   $CLAUDE_CODE_DIR"
    echo

    if [ "$SKIP_BACKUP" = false ]; then
        echo "💾 Backup Location:"
        echo "   $BACKUP_DIR"
        echo
    fi

    echo -e "${BLUE}🔄 What was updated:${NC}"
    echo "   ✓ Autonomous skills"
    echo "   ✓ Slash commands and utilities"
    echo "   ✓ Specialized agents"
    echo "   ✓ Prompt templates and examples"
    echo "   ✓ Standards and style guides"
    echo "   ✓ Documentation and resources"
    echo

    echo -e "${YELLOW}💡 New features and improvements:${NC}"
    cd "$TRESOR_DIR"
    git log --oneline --decorate HEAD~5..HEAD | head -5 | sed 's/^/   • /'
    echo

    echo -e "${GREEN}Ready to use updated Claude Code Tresor! 🚀${NC}"
}

rollback() {
    header "Rolling Back Update"

    # BACKUP_DIR carries this run's timestamp, so look up the newest backup
    # that an earlier update created.
    BACKUP_DIR=$(find "$CLAUDE_CODE_DIR" -maxdepth 1 -type d -name 'backup-update-*' | sort | tail -n 1)

    if [ -z "$BACKUP_DIR" ] || [ ! -d "$BACKUP_DIR" ]; then
        error "No backup found. Cannot rollback."
    fi

    log "Rolling back to backup: $BACKUP_DIR"

    # Restore from backup
    if [ -d "$BACKUP_DIR/commands" ]; then
        rm -rf "$CLAUDE_CODE_DIR/commands"
        cp -r "$BACKUP_DIR/commands" "$CLAUDE_CODE_DIR/"
    fi

    if [ -d "$BACKUP_DIR/agents" ]; then
        rm -rf "$CLAUDE_CODE_DIR/agents"
        cp -r "$BACKUP_DIR/agents" "$CLAUDE_CODE_DIR/"
    fi

    if [ -d "$BACKUP_DIR/skills" ]; then
        rm -rf "$CLAUDE_CODE_DIR/skills"
        cp -r "$BACKUP_DIR/skills" "$CLAUDE_CODE_DIR/"
    fi

    if [ -d "$BACKUP_DIR/tresor-resources" ]; then
        rm -rf "$CLAUDE_CODE_DIR/tresor-resources"
        cp -r "$BACKUP_DIR/tresor-resources" "$CLAUDE_CODE_DIR/"
    fi

    if [ -f "$BACKUP_DIR/tresor.config.json" ]; then
        cp "$BACKUP_DIR/tresor.config.json" "$CONFIG_FILE"
    fi

    log "Rollback completed successfully"
}

show_help() {
    echo "Claude Code Tresor Update Script"
    echo
    echo "Usage: $0 [OPTIONS]"
    echo
    echo "Options:"
    echo "  --help              Show this help message"
    echo "  --check             Check for updates without applying them"
    echo "  --force             Force update even if no changes detected"
    echo "  --skip-backup       Skip creating backup before update"
    echo "  --commands-only     Update only slash commands"
    echo "  --agents-only       Update only agents"
    echo "  --resources-only    Update only resources"
    echo "  --rollback          Rollback to previous version (requires backup)"
    echo "  --cleanup           Remove old backups (keeps latest 5)"
    echo
    echo "Examples:"
    echo "  $0                  # Full update"
    echo "  $0 --check          # Check for updates"
    echo "  $0 --commands-only  # Update only commands"
    echo "  $0 --rollback       # Rollback last update"
    echo
}

cleanup_backups() {
    header "Cleaning Up Old Backups"

    local backup_base="${CLAUDE_CODE_DIR}/backup"
    local backup_count=$(find "$CLAUDE_CODE_DIR" -name "backup-*" -type d | wc -l)

    if [ "$backup_count" -gt 5 ]; then
        log "Found $backup_count backups, keeping latest 5..."

        find "$CLAUDE_CODE_DIR" -name "backup-*" -type d -print0 | \
        sort -z | head -z -n -5 | xargs -0 rm -rf

        log "Old backups cleaned up"
    else
        log "Only $backup_count backups found, no cleanup needed"
    fi
}

# Parse command line arguments
CHECK_ONLY=false
FORCE_UPDATE=false
SKIP_BACKUP=false
COMMANDS_ONLY=false
AGENTS_ONLY=false
RESOURCES_ONLY=false
ROLLBACK=false
CLEANUP=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --help)
            show_help
            exit 0
            ;;
        --check)
            CHECK_ONLY=true
            shift
            ;;
        --force)
            FORCE_UPDATE=true
            shift
            ;;
        --skip-backup)
            SKIP_BACKUP=true
            shift
            ;;
        --commands-only)
            COMMANDS_ONLY=true
            shift
            ;;
        --agents-only)
            AGENTS_ONLY=true
            shift
            ;;
        --resources-only)
            RESOURCES_ONLY=true
            shift
            ;;
        --rollback)
            ROLLBACK=true
            shift
            ;;
        --cleanup)
            CLEANUP=true
            shift
            ;;
        *)
            error "Unknown option: $1"
            ;;
    esac
done

# Main update process
main() {
    header "Claude Code Tresor Update"

    if [ "$CLEANUP" = true ]; then
        cleanup_backups
        exit 0
    fi

    if [ "$ROLLBACK" = true ]; then
        rollback
        exit 0
    fi

    check_installation

    if check_for_updates || [ "$FORCE_UPDATE" = true ]; then
        if [ "$CHECK_ONLY" = true ]; then
            log "Updates are available. Run without --check to apply them."
            exit 0
        fi

        create_backup
        update_repository

        if [ "$COMMANDS_ONLY" = true ]; then
            update_commands
        elif [ "$AGENTS_ONLY" = true ]; then
            update_agents
        elif [ "$RESOURCES_ONLY" = true ]; then
            update_resources
        else
            update_skills
            update_commands
            update_agents
            update_resources
            update_config
        fi

        check_conflicts
        print_summary
    else
        if [ "$CHECK_ONLY" = false ]; then
            log "Already up to date!"
        fi
    fi
}

# Trap to handle interruption
trap 'echo -e "\n${RED}Update interrupted${NC}"; exit 1' INT

# Check if jq is available for JSON processing
if ! command -v jq &> /dev/null; then
    warn "jq not found. Some features may not work correctly."
fi

# Run main function
main "$@"