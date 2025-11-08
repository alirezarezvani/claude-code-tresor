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

# Configuration
CLAUDE_CODE_DIR="${HOME}/.claude"
TRESOR_DIR="${CLAUDE_CODE_DIR}/tresor"
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

update_commands() {
    header "Updating Commands"

    local commands_src="$TRESOR_DIR/commands"
    local commands_dest="$CLAUDE_CODE_DIR/commands"

    if [ -d "$commands_src" ]; then
        log "Updating commands..."

        # Remove old commands that might have been renamed or removed
        if [ -d "$commands_dest" ]; then
            log "Cleaning old commands..."
            rm -rf "$commands_dest"/*
        fi

        # Install updated commands
        find "$commands_src" -mindepth 2 -maxdepth 2 -type d | while read -r cmd_dir; do
            local cmd_name=$(basename "$cmd_dir")
            local category=$(basename "$(dirname "$cmd_dir")")
            local dest_dir="$commands_dest/${category}-${cmd_name}"

            log "Updating command: ${category}/${cmd_name}"
            mkdir -p "$commands_dest"
            cp -r "$cmd_dir" "$dest_dir"
        done

        log "Commands updated successfully"
    else
        warn "Commands directory not found in repository"
    fi
}

update_agents() {
    header "Updating Agents"

    local agents_src="$TRESOR_DIR/agents"
    local agents_dest="$CLAUDE_CODE_DIR/agents"

    if [ -d "$agents_src" ]; then
        log "Updating agents..."

        # Remove old agents that might have been renamed or removed
        if [ -d "$agents_dest" ]; then
            log "Cleaning old agents..."
            find "$agents_dest" -mindepth 1 -maxdepth 1 -type d -exec rm -rf {} +
        fi

        # Install updated agents
        find "$agents_src" -mindepth 1 -maxdepth 1 -type d | while read -r agent_dir; do
            local agent_name=$(basename "$agent_dir")

            # Skip README-only directories
            if [ -f "$agent_dir/agent.json" ]; then
                log "Updating agent: $agent_name"
                mkdir -p "$agents_dest"
                cp -r "$agent_dir" "$agents_dest/$agent_name"
            fi
        done

        log "Agents updated successfully"
    else
        warn "Agents directory not found in repository"
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

    # Get current version from repository
    local new_version="1.0.0"
    if [ -f "$TRESOR_DIR/package.json" ]; then
        new_version=$(jq -r '.version' "$TRESOR_DIR/package.json" 2>/dev/null || echo "1.0.0")
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

    if [ ! -d "$BACKUP_DIR" ]; then
        error "No backup found. Cannot rollback."
    fi

    log "Rolling back to previous version..."

    # Restore from backup
    if [ -d "$BACKUP_DIR/commands" ]; then
        rm -rf "$CLAUDE_CODE_DIR/commands"
        cp -r "$BACKUP_DIR/commands" "$CLAUDE_CODE_DIR/"
    fi

    if [ -d "$BACKUP_DIR/agents" ]; then
        rm -rf "$CLAUDE_CODE_DIR/agents"
        cp -r "$BACKUP_DIR/agents" "$CLAUDE_CODE_DIR/"
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