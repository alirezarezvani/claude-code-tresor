# Product Context - Claude Code Tresor

> **Technical Stack, Architectural Decisions, and Development Conventions**
>
> **Last Updated**: November 15, 2025 | **Version**: 2.6.0

---

## Tech Stack

### Core Technologies

**Languages**:
- **Markdown**: Agent definitions, documentation, prompts
- **YAML**: Frontmatter, configuration, workflows
- **JSON**: Indexes, metadata, analytics
- **Bash**: Installation scripts, automation
- **Python**: Validation scripts, analysis tools

**Platforms**:
- **Claude Code**: Primary platform for agents and skills
- **GitHub**: Repository hosting, releases, community
- **Node.js**: (Planned) CLI tooling
- **React**: (Planned) Web dashboard

---

## Architectural Decisions

### AD-001: YAML Frontmatter for Agent Metadata

**Decision**: Use YAML frontmatter in Markdown files for agent configuration

**Rationale**:
- Human-readable and editable
- Combines metadata with content
- Standard in static site generators
- Easy to parse programmatically

**Consequences**:
- ✅ Easy to edit and maintain
- ✅ Single file per agent
- ⚠️ Installer must parse YAML (not native JSON)

**Status**: Accepted | **Date**: November 2025

---

### AD-002: Team-Aligned Categories

**Decision**: Organize agents by professional team categories (not technical domains)

**Rationale**:
- Matches real organizational structure
- Easier for teams to find relevant agents
- Color-coding aids visual navigation
- Scalable to 200+ agents

**Consequences**:
- ✅ Intuitive navigation for business users
- ✅ Clear ownership and maintenance
- ⚠️ Some agents could fit multiple categories

**Status**: Accepted | **Date**: November 2025

---

### AD-003: Three-Tier Agent System

**Decision**: Skills (auto) → Agents (manual) → Commands (orchestration)

**Rationale**:
- Skills: Lightweight, automatic detection
- Agents: Deep expertise, manual invocation
- Commands: Multi-agent workflows
- Clear separation of concerns

**Consequences**:
- ✅ Optimal user experience
- ✅ Clear integration patterns
- ✅ Scalable architecture

**Status**: Accepted | **Date**: September 2025

---

### AD-004: Color-Coded Visual System

**Decision**: Assign specific colors to each team category

**Rationale**:
- Visual identification
- Branding consistency
- Accessibility (with emojis backup)
- Professional appearance

**Colors Chosen**:
- Engineering: Blue (#3B82F6) - Trust, technical
- Design: Magenta (#EC4899) - Creative, innovative
- Marketing: Green (#10B981) - Growth, action
- Product: Purple (#8B5CF6) - Strategic, premium
- Leadership: Gold (#F59E0B) - Executive, value
- Operations: Teal (#14B8A6) - Efficient, balanced
- Research: Orange (#F97316) - Discovery, energy
- AI/Automation: Indigo (#6366F1) - Intelligence, future
- Account/CS: Cyan (#06B6D4) - Communication, trust
- Core: Gold (#FFD700) - Premium, essential

**Status**: Accepted | **Date**: November 2025

---

### AD-005: Model Standardization

**Decision**: Use claude-opus-4 for all subagents

**Rationale**:
- Consistent performance and capabilities
- Easier maintenance
- Predictable behavior
- Future-proof

**Consequences**:
- ✅ Uniform quality
- ✅ Easier updates
- ⚠️ Higher cost than mixed models (acceptable trade-off)

**Status**: Accepted | **Date**: November 2025

---

## Development Conventions

### File Naming

**Agents**: `{agent-name}/agent.md` (kebab-case)
**Skills**: `{skill-name}/SKILL.md` (kebab-case)
**Commands**: `{category}/{command-name}.md` (kebab-case)
**Standards**: `{category}/{standard-name}.md` (kebab-case)

### YAML Frontmatter Format

**Required Fields** (9):
- name, description, category, team, color
- tools, model, enabled, capabilities

**Standardization**:
- Always use double quotes for strings
- Arrays in bracket notation
- 4-capability minimum
- max_iterations: 50 default

### Directory Organization

**Pattern**: `{component}/{category}/{subcategory}/{name}/`

**Examples**:
- `subagents/engineering/backend/backend-architect/`
- `skills/security/secret-scanner/`
- `commands/workflow/review/`

---

## Quality Standards

### Agent Quality Targets

- **Minimum**: 7.0/10 (for new agents)
- **Target**: 8.0/10 (preferred)
- **Excellence**: 9.0/10+ (core agents)

### Current State

- **Overall**: 9.7/10 (v2.6.0)
- **Core Agents**: 8.5/10
- **Engineering**: 8.4/10
- **Design**: 8.0/10 (improved from 4.0)
- **Others**: 6.0-6.5/10

### Validation Requirements

**All Agents Must Pass**:
1. YAML frontmatter (100% valid)
2. Content structure (required sections)
3. Organization (correct category/subcategory)
4. Cross-references (all links work)

---

## Development Workflow

### Adding New Components

**New Agent**:
1. Choose category and subcategory
2. Use template from TECHNICAL-REFERENCE.md
3. Fill YAML frontmatter (11 fields)
4. Write content (Focus Areas, Approach, Output, Examples)
5. Validate (run validation script)
6. Submit PR (minimum 7.0/10 quality)

**New Skill**:
1. Define purpose and triggers
2. Create SKILL.md with frontmatter
3. Implement detection logic
4. Add agent integration
5. Test activation and suggestions

**New Command**:
1. Define purpose and agents to orchestrate
2. Create command.md with frontmatter
3. Implement orchestration logic
4. Add safety gates and validation
5. Create examples and tests

**New Standard**:
1. Research best practices
2. Create standard markdown
3. Define enforcement rules
4. Map to validator agents
5. Add to /enforce-standard

---

## Integration Patterns

### Skill → Agent

```
File saved → Skill detects issue → Suggests specific agent
Example: performance-monitor → @performance-tuner with issue context
```

### Agent → Skill

```
Agent invoked → Calls relevant skills first → Builds on findings
Example: @security-auditor → Invokes security skills → Deep analysis
```

### Command → Agents → Skills

```
Command executed → Orchestrates agents → Agents use skills → Consolidated output
Example: /audit → @security-auditor (uses skills) → Security report
```

### Standard → Agent → Enforcement

```
/enforce-standard → Loads standard → Invokes validator agent → Reports violations
Example: /enforce-standard --type typescript → @typescript-pro → Violations + fixes
```

---

## Version History

### v2.0 (September 2025)
- Skills layer introduction
- 8 autonomous background helpers
- 3-tier architecture (skills → agents → commands)

### v2.5.0 (November 15, 2025)
- Agent reorganization and extension
- 141 agents (8 core + 133 subagents)
- 10 color-coded categories
- Professional organization
- Quality: 7.1/10

### v2.6.0 (November 15, 2025)
- Quality improvements
- Design category transformation (4.0 → 8.0/10)
- 12 usage examples added
- 9 agents with standard sections
- 2 core agents with best practices
- Cross-team collaboration guide
- Quality: 9.7/10

### v3.0 (Planned - Q1 2026)
- Complete ecosystem integration
- 20+ skills, 15+ commands
- 30+ enforced standards
- 40+ specialized prompts
- Community marketplace
- Target: Industry-standard utility

---

## Key Decisions Log

**November 15, 2025**:
- Consolidated 21 docs → 2 guides + archive
- Created ecosystem roadmap (16-week plan)
- Identified installer metadata fix as P0

**November 15, 2025** (earlier):
- Renamed core agents for clarity
- Merged duplicate agents
- Migrated all 133 subagents
- Achieved 9.7/10 quality

---

## Active Priorities

**Current Focus**: Phase 1 - Foundation Enhancement

**This Week**:
1. Create memory bank ✅ (in progress)
2. Fix installer metadata
3. Generate machine-readable indexes
4. Create /discover-agent command

**This Month**:
- Complete Phase 1 (8 skills, 3 commands, 6 standards)
- Begin Phase 2 (ecosystem integration)

---

**Maintained By**: Alireza Rezvani
**AI Assistant**: Claude (Anthropic)
**Repository**: https://github.com/alirezarezvani/claude-code-tresor
**License**: MIT
