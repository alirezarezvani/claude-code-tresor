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

# Configuration (env-overridable for tests and custom layouts)
CLAUDE_CODE_DIR="${CLAUDE_CODE_DIR:-${HOME}/.claude}"
REPO_URL="${TRESOR_REPO_URL:-https://github.com/alirezarezvani/claude-code-tresor}"
TRESOR_DIR="${TRESOR_DIR:-${CLAUDE_CODE_DIR}/tresor}"
# Backups live as a sibling of CLAUDE_CODE_DIR so the install can back up the
# entire directory without recursive-copy issues (BACKUP_DIR inside source).
BACKUP_DIR="${CLAUDE_CODE_DIR}.backup-$(date +%Y%m%d-%H%M%S)"

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
    if command -v claude &> /dev/null || command -v claude-code &> /dev/null; then
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

# Copy every command file under the given source directories into
# ~/.claude/commands as a flat <name>.md file.
#
# Claude Code names a command after its file path: commands/review.md is
# /review, but commands/workflow-review/review.md is /workflow-review:review.
# Releases before v2.8.0 installed "<category>-<name>/" directories, which
# produced those long names, skipped scaffold/test-gen/docs-gen entirely and
# nested a second copy on every re-install. Those directories are removed here.
copy_command_files() {
    local commands_src="$1"
    local commands_dest="$2"
    shift 2

    mkdir -p "$commands_dest"

    find "$@" -type f -name '*.md' ! -name 'README.md' | sort | while read -r cmd_file; do
        local cmd_name
        cmd_name=$(basename "$cmd_file" .md)
        local rel="${cmd_file#"$commands_src"/}"
        local category="${rel%%/*}"
        local legacy_dir="$commands_dest/${category}-${cmd_name}"
        local dest_file="$commands_dest/${cmd_name}.md"

        if [ -d "$legacy_dir" ]; then
            log "Removing old command directory: ${category}-${cmd_name}"
            rm -rf "$legacy_dir"
        fi

        # Keep a copy if we are about to replace a file with different content
        # (for example a personal command that happens to share the name).
        if [ -f "$dest_file" ] && ! cmp -s "$cmd_file" "$dest_file"; then
            cp "$dest_file" "$dest_file.bak"
            warn "Replaced existing /${cmd_name} (previous copy: ${cmd_name}.md.bak)"
        fi

        log "Installing command: /${cmd_name}"
        cp "$cmd_file" "$dest_file"
    done
}

install_commands() {
    header "Installing Slash Commands"

    local commands_src="$TRESOR_DIR/commands"
    local commands_dest="$CLAUDE_CODE_DIR/commands"

    if [ -d "$commands_src" ]; then
        log "Installing commands to: $commands_dest"
        copy_command_files "$commands_src" "$commands_dest" "$commands_src"
        log "Commands installed successfully"
    else
        warn "Commands directory not found in repository"
    fi
}

install_orchestration_commands() {
    header "Installing Orchestration Commands (v2.7+)"

    local commands_src="$TRESOR_DIR/commands"
    local commands_dest="$CLAUDE_CODE_DIR/commands"

    if [ -d "$commands_src" ]; then
        log "Installing orchestration commands to: $commands_dest"

        # Orchestration commands live in these four categories
        local category_dirs=()
        local category
        for category in security performance operations quality; do
            if [ -d "$commands_src/$category" ]; then
                category_dirs+=("$commands_src/$category")
            fi
        done

        if [ "${#category_dirs[@]}" -gt 0 ]; then
            copy_command_files "$commands_src" "$commands_dest" "${category_dirs[@]}"
        fi

        log "Orchestration commands installed successfully (10 commands)"
    else
        warn "Commands directory not found in repository"
    fi
}

# Write one agent as the flat .md file Claude Code loads, keeping only the
# frontmatter fields Claude Code knows: name, description, tools, model, color, maxTurns.
# Any other field is dropped (older copies of an agent may still carry Tresor fields).
install_agent_file() {
    local src="$1" dest="$2"
    awk '
    BEGIN { in_fm=0; fm_done=0 }
    /^---$/ && fm_done == 0 {
        if (in_fm == 0) { in_fm=1 } else { in_fm=0; fm_done=1 }
        print; next
    }
    # A field starts at column 1; indented lines (list items) belong to it.
    in_fm == 1 && /^[^ \t]/ { keep = ($0 ~ /^(name|description|tools|model|color|maxTurns):/) }
    in_fm == 1 { if (keep) print; next }
    { print }
    ' "$src" > "$dest"
}

install_agents() {
    header "Installing Core Agents"

    local subagents_src="$TRESOR_DIR/subagents/core"
    local agents_dest="$CLAUDE_CODE_DIR/agents"

    if [ -d "$subagents_src" ]; then
        log "Installing core agents to: $agents_dest"
        mkdir -p "$agents_dest"

        # Claude Code expects flat .md files: .claude/agents/agent-name.md
        # Our repo has: subagents/core/agent-name/agent.md
        # Convert: directory/agent.md → flat agent-name.md with cleaned YAML
        find "$subagents_src" -mindepth 1 -maxdepth 1 -type d | while read -r agent_dir; do
            local agent_name=$(basename "$agent_dir")
            local agent_file="$agent_dir/agent.md"

            if [ -f "$agent_file" ]; then
                log "Installing core agent: $agent_name"
                install_agent_file "$agent_file" "$agents_dest/${agent_name}.md"
            fi
        done

        log "Core agents installed successfully (flat .md files)"
    else
        warn "Subagents core directory not found in repository"
    fi
}

# Activate chosen agents from the library (--agent NAME). A NAME is an agent's
# folder name, or its path under subagents/ when two teams share a name
# (for example operations/support/customer-support).
install_selected_agents() {
    header "Activating Selected Agents"

    local agents_dest="$CLAUDE_CODE_DIR/agents"
    mkdir -p "$agents_dest"

    local name matches count
    for name in "${SELECTED_AGENTS[@]}"; do
        if [ -f "$TRESOR_DIR/subagents/$name/agent.md" ]; then
            matches="$TRESOR_DIR/subagents/$name/agent.md"
        else
            matches=$(find "$TRESOR_DIR/subagents" -path "*/$name/agent.md" -type f)
        fi
        count=$(printf '%s' "$matches" | grep -c . || true)

        if [ "$count" -eq 0 ]; then
            error "Agent not found: $name (see $CLAUDE_CODE_DIR/subagents/AGENT-INDEX.md)"
        elif [ "$count" -gt 1 ]; then
            echo "$matches" | sed "s|^$TRESOR_DIR/subagents/|  |; s|/agent.md$||" >&2
            error "Agent name '$name' is used by more than one team. Pass one of the paths above."
        fi

        install_agent_file "$matches" "$agents_dest/$(basename "$(dirname "$matches")").md"
        log "Activated agent: $name"
    done
}

install_subagents() {
    header "Installing Extended Subagents"

    local subagents_src="$TRESOR_DIR/subagents"
    local subagents_dest="$CLAUDE_CODE_DIR/subagents"

    if [ -d "$subagents_src" ]; then
        log "Installing subagents to: $subagents_dest"

        # Copy the contents (not the directory itself) so a re-install
        # refreshes the library instead of nesting subagents/subagents.
        mkdir -p "$subagents_dest"
        rm -rf "$subagents_dest/subagents"  # left behind by older installers
        cp -r "$subagents_src/." "$subagents_dest/"

        # Count installed agents
        local agent_count=$(find "$subagents_dest" -name "agent.md" -type f | wc -l)
        log "Installed $agent_count subagents across 10 categories"

        log "Claude Code Tresor Subagents installed successfully"
    else
        warn "Claude Code Tresor Subagents directory not found in repository"
    fi
}

install_skills() {
    header "Installing Autonomous Skills"

    local skills_src="$TRESOR_DIR/skills"
    local skills_dest="$CLAUDE_CODE_DIR/skills"

    if [ -d "$skills_src" ]; then
        log "Installing skills to: $skills_dest"
        mkdir -p "$skills_dest"

        # Flatten skills: skills/category/skill-name → .claude/skills/skill-name
        # Claude Code expects skills at one level: .claude/skills/{skill-name}/SKILL.md
        find "$skills_src" -mindepth 2 -maxdepth 2 -type d | while read -r skill_dir; do
            local skill_name=$(basename "$skill_dir")
            local category=$(basename "$(dirname "$skill_dir")")

            # Check if SKILL.md exists
            if [ -f "$skill_dir/SKILL.md" ]; then
                log "Installing skill: ${skill_name} (from ${category})"
                # Copy directly to skills_dest (flatten, remove category layer).
                # Copy the contents so a re-install refreshes the skill instead
                # of nesting skill-name/skill-name.
                mkdir -p "$skills_dest/$skill_name"
                rm -rf "$skills_dest/$skill_name/$skill_name"  # left behind by older installers
                cp -r "$skill_dir/." "$skills_dest/$skill_name/"
            fi
        done

        log "Claude Code Tresor Skills installed successfully"
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

    # version.txt is the single source of truth for the release version
    local tresor_version="unknown"
    if [ -f "$TRESOR_DIR/version.txt" ]; then
        tresor_version=$(tr -d '[:space:]' < "$TRESOR_DIR/version.txt")
    fi

    cat > "$config_file" << EOF
{
  "version": "$tresor_version",
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
      "config-safety-reviewer": "Configuration safety review agent",
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
    echo "🚀 Core Workflow Commands (4):"
    echo "   /scaffold    - Generate project structures and components"
    echo "   /review      - Automated code review with best practices"
    echo "   /test-gen    - Generate comprehensive test suites"
    echo "   /docs-gen    - Create documentation from code"
    echo
    echo "🔄 Tresor Workflow Commands (5):"
    echo "   /prompt-create  - Generate optimized prompts for complex tasks"
    echo "   /prompt-run     - Execute prompts in sub-agents (parallel/sequential)"
    echo "   /todo-add       - Capture ideas with full context"
    echo "   /todo-check     - Resume work on todos (suggests Tresor agents)"
    echo "   /handoff-create - Create comprehensive context handoff document"
    echo
    echo "🎯 Orchestration Commands (10) - NEW in v2.7.0:"
    echo "   Security:      /audit, /vulnerability-scan, /compliance-check"
    echo "   Performance:   /profile, /benchmark"
    echo "   Operations:    /deploy-validate, /health-check, /incident-response"
    echo "   Quality:       /code-health, /debt-analysis"
    echo "   Total: 12,682 lines of intelligent multi-phase orchestration"
    echo
    echo "📦 Old Command Names (5) - still work, removed in v3.0.0:"
    echo "   /create-prompt, /run-prompt, /add-to-todos, /check-todos, /whats-next"
    echo "   Total installed commands: 24 (19 current + 5 old names)"
    echo
    echo "🤖 Core Agents (8):"
    echo "   @systems-architect        - System design and architecture"
    echo "   @config-safety-reviewer   - Configuration safety specialist"
    echo "   @root-cause-analyzer      - Comprehensive debugging and RCA"
    echo "   @security-auditor         - Security and OWASP compliance"
    echo "   @test-engineer            - Testing and QA specialist"
    echo "   @performance-tuner        - Performance optimization"
    echo "   @refactor-expert          - Code refactoring specialist"
    echo "   @docs-writer              - Technical documentation expert"
    echo
    echo "🌍 Extended Subagents (133+):"
    echo "   Browse: $CLAUDE_CODE_DIR/subagents/"
    echo "   Activate one: ./scripts/install.sh --agent <name>"
    echo "   Categories: Engineering, Design, Marketing, Product, Leadership,"
    echo "               Operations, Research, AI/Automation, Account/CS"
    echo "   Complete catalog: $CLAUDE_CODE_DIR/subagents/AGENT-INDEX.md"
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
    echo "   3. Try: @config-safety-reviewer Please review this configuration change"
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
    echo "  --agents-only       Install only agents (133 total)"
    echo "                      (--skills, --commands and --agents also work)"
    echo "  --orchestration     Install only orchestration commands (v2.7+, 10 commands)"
    echo "  --resources-only    Install only resources (prompts, standards, examples)"
    echo "  --agent NAME        Activate one library agent in ~/.claude/agents/ (repeatable)."
    echo "                      Used alone, it only activates the named agents."
    echo "  --update            Update existing installation"
    echo "  --backup-dir DIR    Use custom backup directory"
    echo "  --no-backup         Skip backup of existing installation"
    echo
    echo "Use one of the 'only' options per run. Run without options to install everything."
    echo
    echo "Examples:"
    echo "  $0                    # Full installation"
    echo "  $0 --skills-only      # Install only skills"
    echo "  $0 --commands-only    # Install only commands (19 + 5 old names)"
    echo "  $0 --agents-only      # Install only agents (133 total)"
    echo "  $0 --orchestration    # Install only orchestration commands (10)"
    echo "  $0 --agent deployment-engineer --agent backend-architect   # Activate two library agents"
    echo "  $0 --update           # Update existing installation"
    echo
    echo "For more information, visit: $REPO_URL"
}

# Parse command line arguments
SKILLS_ONLY=false
COMMANDS_ONLY=false
AGENTS_ONLY=false
ORCHESTRATION_ONLY=false
RESOURCES_ONLY=false
UPDATE_ONLY=false
NO_BACKUP=false
SELECTED_AGENTS=()

while [[ $# -gt 0 ]]; do
    case $1 in
        --help)
            show_help
            exit 0
            ;;
        --skills-only|--skills)
            SKILLS_ONLY=true
            shift
            ;;
        --commands-only|--commands)
            COMMANDS_ONLY=true
            shift
            ;;
        --agents-only|--agents)
            AGENTS_ONLY=true
            shift
            ;;
        --orchestration)
            ORCHESTRATION_ONLY=true
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
        --agent)
            [ -n "${2:-}" ] || error "--agent needs an agent name"
            SELECTED_AGENTS+=("$2")
            shift 2
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
        install_subagents
    elif [ "$ORCHESTRATION_ONLY" = true ]; then
        install_orchestration_commands
    elif [ "$RESOURCES_ONLY" = true ]; then
        install_resources
    elif [ "$UPDATE_ONLY" = true ]; then
        install_skills
        install_commands
        install_agents
        install_subagents
        install_resources
        log "Claude Code Tresor Update completed successfully"
    elif [ ${#SELECTED_AGENTS[@]} -gt 0 ]; then
        install_subagents
    else
        # Full installation
        install_skills
        install_commands
        install_agents
        install_subagents
        install_resources
        create_config
        create_update_script
    fi

    if [ ${#SELECTED_AGENTS[@]} -gt 0 ]; then
        install_selected_agents
    fi

    print_summary
}

# Trap to handle interruption
trap 'echo -e "\n${RED}Installation interrupted${NC}"; exit 1' INT

# Run main function
main "$@"