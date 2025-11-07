#!/bin/bash

# Claude Code Tresor Installation Script
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
REPO_URL="https://github.com/alirezarezvani/claude-code-tresor"
TRESOR_DIR="${CLAUDE_CODE_DIR}/tresor"
BACKUP_DIR="${CLAUDE_CODE_DIR}/backup-$(date +%Y%m%d-%H%M%S)"

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

check_dependencies() {
    header "Checking Dependencies"

    # Check if git is installed
    if ! command -v git &> /dev/null; then
        error "Git is not installed. Please install git first."
    fi
    log "Git is available"

    # Check if Claude Code is installed (optional check)
    if command -v claude-code &> /dev/null; then
        log "Claude Code CLI detected"
    else
        warn "Claude Code CLI not found. Make sure to install it from: https://claude.ai/code"
    fi
}

create_directories() {
    header "Creating Directories"

    # Create Claude Code directory if it doesn't exist
    if [ ! -d "$CLAUDE_CODE_DIR" ]; then
        log "Creating Claude Code directory: $CLAUDE_CODE_DIR"
        mkdir -p "$CLAUDE_CODE_DIR"
    else
        log "Claude Code directory already exists"
    fi

    # Create subdirectories
    mkdir -p "$CLAUDE_CODE_DIR/commands"
    mkdir -p "$CLAUDE_CODE_DIR/agents"
    mkdir -p "$CLAUDE_CODE_DIR/skills"
    mkdir -p "$CLAUDE_CODE_DIR/templates"

    log "Directory structure ready"
}

backup_existing() {
    header "Backing Up Existing Configuration"

    if [ -d "$TRESOR_DIR" ]; then
        log "Creating backup at: $BACKUP_DIR"
        cp -r "$CLAUDE_CODE_DIR" "$BACKUP_DIR"
        log "Backup created successfully"
    else
        log "No existing tresor installation found"
    fi
}

clone_repository() {
    header "Downloading Claude Code Tresor"

    if [ -d "$TRESOR_DIR" ]; then
        log "Updating existing installation"
        cd "$TRESOR_DIR"
        git pull origin main
    else
        log "Cloning repository to: $TRESOR_DIR"
        git clone "$REPO_URL" "$TRESOR_DIR"
    fi

    log "Repository downloaded successfully"
}

install_commands() {
    header "Installing Slash Commands"

    local commands_src="$TRESOR_DIR/commands"
    local commands_dest="$CLAUDE_CODE_DIR/commands"

    if [ -d "$commands_src" ]; then
        log "Installing commands to: $commands_dest"

        # Copy all command directories
        find "$commands_src" -mindepth 2 -maxdepth 2 -type d | while read -r cmd_dir; do
            local cmd_name=$(basename "$cmd_dir")
            local category=$(basename "$(dirname "$cmd_dir")")
            local dest_dir="$commands_dest/${category}-${cmd_name}"

            log "Installing command: ${category}/${cmd_name}"
            cp -r "$cmd_dir" "$dest_dir"
        done

        log "Commands installed successfully"
    else
        warn "Commands directory not found in repository"
    fi
}

install_agents() {
    header "Installing Specialized Agents"

    local agents_src="$TRESOR_DIR/agents"
    local agents_dest="$CLAUDE_CODE_DIR/agents"

    if [ -d "$agents_src" ]; then
        log "Installing agents to: $agents_dest"

        # Copy all agent directories
        find "$agents_src" -mindepth 1 -maxdepth 1 -type d | while read -r agent_dir; do
            local agent_name=$(basename "$agent_dir")

            # Skip README-only directories
            if [ -f "$agent_dir/agent.json" ]; then
                log "Installing agent: $agent_name"
                cp -r "$agent_dir" "$agents_dest/$agent_name"
            fi
        done

        log "Agents installed successfully"
    else
        warn "Agents directory not found in repository"
    fi
}

install_skills() {
    header "Installing Autonomous Skills"

    local skills_src="$TRESOR_DIR/skills"
    local skills_dest="$CLAUDE_CODE_DIR/skills"

    if [ -d "$skills_src" ]; then
        log "Installing skills to: $skills_dest"

        # Copy all skill directories (maintaining category structure)
        find "$skills_src" -mindepth 2 -maxdepth 2 -type d | while read -r skill_dir; do
            local skill_name=$(basename "$skill_dir")
            local category=$(basename "$(dirname "$skill_dir")")
            local dest_dir="$skills_dest/${category}/${skill_name}"

            # Check if SKILL.md exists
            if [ -f "$skill_dir/SKILL.md" ]; then
                log "Installing skill: ${category}/${skill_name}"
                mkdir -p "$skills_dest/$category"
                cp -r "$skill_dir" "$dest_dir"
            fi
        done

        log "Skills installed successfully"
    else
        warn "Skills directory not found in repository"
    fi
}

install_resources() {
    header "Installing Resources"

    local resources_dest="$CLAUDE_CODE_DIR/tresor-resources"

    log "Installing resources to: $resources_dest"
    mkdir -p "$resources_dest"

    # Copy prompts, standards, and examples for reference
    for resource in prompts standards examples; do
        if [ -d "$TRESOR_DIR/$resource" ]; then
            log "Installing $resource resources"
            cp -r "$TRESOR_DIR/$resource" "$resources_dest/"
        fi
    done

    # Copy documentation
    if [ -f "$TRESOR_DIR/README.md" ]; then
        cp "$TRESOR_DIR/README.md" "$resources_dest/"
    fi

    if [ -f "$TRESOR_DIR/CONTRIBUTING.md" ]; then
        cp "$TRESOR_DIR/CONTRIBUTING.md" "$resources_dest/"
    fi

    log "Resources installed successfully"
}

create_config() {
    header "Creating Configuration"

    local config_file="$CLAUDE_CODE_DIR/tresor.config.json"

    log "Creating configuration file: $config_file"

    cat > "$config_file" << EOF
{
  "version": "1.0.0",
  "installed": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "author": "Alireza Rezvani",
  "repository": "$REPO_URL",
  "directories": {
    "commands": "$CLAUDE_CODE_DIR/commands",
    "agents": "$CLAUDE_CODE_DIR/agents",
    "resources": "$CLAUDE_CODE_DIR/tresor-resources"
  },
  "components": {
    "commands": {
      "scaffold": "Project scaffolding command",
      "review": "Code review automation",
      "test-gen": "Test generation",
      "docs-gen": "Documentation generation"
    },
    "agents": {
      "code-reviewer": "Code quality analysis agent",
      "test-engineer": "Testing specialist agent",
      "docs-writer": "Documentation specialist agent"
    }
  }
}
EOF

    log "Configuration created successfully"
}

create_update_script() {
    header "Creating Update Script"

    local update_script="$CLAUDE_CODE_DIR/update-tresor.sh"

    log "Creating update script: $update_script"

    cat > "$update_script" << 'EOF'
#!/bin/bash
# Auto-generated update script for Claude Code Tresor

TRESOR_DIR="$HOME/.claude/tresor"

if [ -d "$TRESOR_DIR" ]; then
    echo "Updating Claude Code Tresor..."
    cd "$TRESOR_DIR"
    git pull origin main
    echo "Update complete!"
else
    echo "Tresor not found. Please run the installation script first."
    exit 1
fi
EOF

    chmod +x "$update_script"
    log "Update script created successfully"
}

print_summary() {
    header "Installation Summary"

    echo -e "${GREEN}✅ Claude Code Tresor installed successfully!${NC}\n"

    echo "📍 Installation Location:"
    echo "   $CLAUDE_CODE_DIR"
    echo
    echo "🚀 Available Commands:"
    echo "   /scaffold    - Generate project structures and components"
    echo "   /review      - Automated code review with best practices"
    echo "   /test-gen    - Generate comprehensive test suites"
    echo "   /docs-gen    - Create documentation from code"
    echo
    echo "🤖 Available Agents:"
    echo "   @code-reviewer  - Expert code quality analysis"
    echo "   @test-engineer  - Testing and QA specialist"
    echo "   @docs-writer    - Technical documentation expert"
    echo
    echo "📚 Resources Available:"
    echo "   Prompt Templates: $CLAUDE_CODE_DIR/tresor-resources/prompts"
    echo "   Style Guides:     $CLAUDE_CODE_DIR/tresor-resources/standards"
    echo "   Examples:         $CLAUDE_CODE_DIR/tresor-resources/examples"
    echo
    echo "🔄 To Update:"
    echo "   Run: $CLAUDE_CODE_DIR/update-tresor.sh"
    echo "   Or:  ./scripts/update.sh"
    echo

    if [ -d "$BACKUP_DIR" ]; then
        echo "💾 Backup Location:"
        echo "   $BACKUP_DIR"
        echo
    fi

    echo -e "${BLUE}📖 Getting Started:${NC}"
    echo "   1. Start Claude Code CLI"
    echo "   2. Try: /scaffold react-component MyComponent --tests"
    echo "   3. Try: @code-reviewer Please review this code"
    echo "   4. Browse examples in: tresor-resources/examples"
    echo
    echo -e "${YELLOW}💡 Tip:${NC} Check out the React App Setup workflow:"
    echo "   $CLAUDE_CODE_DIR/tresor-resources/examples/workflows/react-app-setup.md"
    echo
    echo -e "${GREEN}Happy coding with Claude Code Tresor! 🎉${NC}"
}

show_help() {
    echo "Claude Code Tresor Installation Script"
    echo
    echo "Usage: $0 [OPTIONS]"
    echo
    echo "Options:"
    echo "  --help              Show this help message"
    echo "  --skills-only       Install only autonomous skills (v2.0+)"
    echo "  --commands-only     Install only slash commands"
    echo "  --agents-only       Install only agents"
    echo "  --resources-only    Install only resources (prompts, standards, examples)"
    echo "  --update            Update existing installation"
    echo "  --backup-dir DIR    Use custom backup directory"
    echo "  --no-backup         Skip backup of existing installation"
    echo
    echo "Examples:"
    echo "  $0                    # Full installation"
    echo "  $0 --skills-only      # Install only skills"
    echo "  $0 --commands-only    # Install only commands"
    echo "  $0 --agents-only      # Install only agents"
    echo "  $0 --update           # Update existing installation"
    echo
    echo "For more information, visit: $REPO_URL"
}

# Parse command line arguments
SKILLS_ONLY=false
COMMANDS_ONLY=false
AGENTS_ONLY=false
RESOURCES_ONLY=false
UPDATE_ONLY=false
NO_BACKUP=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --help)
            show_help
            exit 0
            ;;
        --skills-only)
            SKILLS_ONLY=true
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
        --update)
            UPDATE_ONLY=true
            shift
            ;;
        --backup-dir)
            BACKUP_DIR="$2"
            shift 2
            ;;
        --no-backup)
            NO_BACKUP=true
            shift
            ;;
        *)
            error "Unknown option: $1"
            ;;
    esac
done

# Main installation process
main() {
    header "Claude Code Tresor Installation"
    echo "Author: Alireza Rezvani"
    echo "Repository: $REPO_URL"
    echo "Installation Directory: $CLAUDE_CODE_DIR"
    echo

    check_dependencies
    create_directories

    if [ "$NO_BACKUP" = false ]; then
        backup_existing
    fi

    clone_repository

    if [ "$SKILLS_ONLY" = true ]; then
        install_skills
    elif [ "$COMMANDS_ONLY" = true ]; then
        install_commands
    elif [ "$AGENTS_ONLY" = true ]; then
        install_agents
    elif [ "$RESOURCES_ONLY" = true ]; then
        install_resources
    elif [ "$UPDATE_ONLY" = true ]; then
        install_skills
        install_commands
        install_agents
        install_resources
        log "Update completed successfully"
    else
        # Full installation
        install_skills
        install_commands
        install_agents
        install_resources
        create_config
        create_update_script
    fi

    print_summary
}

# Trap to handle interruption
trap 'echo -e "\n${RED}Installation interrupted${NC}"; exit 1' INT

# Run main function
main "$@"