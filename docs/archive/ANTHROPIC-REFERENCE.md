# Anthropic Official Documentation Reference

> **Official Anthropic documentation sources for Claude Code sub-agents**
>
> **Last Updated**: November 15, 2025 | **Version**: 2.5.0

---

## Table of Contents

1. [Official Documentation Links](#official-documentation-links)
2. [YAML Frontmatter Specification](#yaml-frontmatter-specification)
3. [Storage Locations](#storage-locations)
4. [Tool Access and Permissions](#tool-access-and-permissions)
5. [Agent Selection Mechanism](#agent-selection-mechanism)
6. [Best Practices from Anthropic](#best-practices-from-anthropic)
7. [Release Information](#release-information)
8. [Community Resources](#community-resources)

---

## Official Documentation Links

### Primary Documentation

| Resource | URL | Description |
|----------|-----|-------------|
| **Subagents Overview** | https://docs.anthropic.com/en/docs/claude-code/sub-agents | Official sub-agent documentation and guide |
| **Subagents in SDK** | https://docs.claude.com/en/docs/claude-code/sdk/subagents | SDK implementation details |
| **Claude Code Settings** | https://docs.claude.com/en/docs/claude-code/settings | Configuration and customization |

### Additional Resources

| Resource | URL | Type |
|----------|-----|------|
| **Release Announcement** | https://winbuzzer.com/2025/07/26/anthropic-rolls-out-sub-agents-for-claude-code-to-streamline-complex-ai-workflows-xcxwbn/ | News Article (July 2025) |
| **Developer Guide** | https://medianeth.dev/blog/claude-code-frameworks-subagents-2025 | Community Tutorial |
| **Best Practices Guide** | https://www.pubnub.com/blog/best-practices-for-claude-code-sub-agents/ | Best Practices |
| **Practical Guide** | https://jewelhuq.medium.com/practical-guide-to-mastering-claude-codes-main-agent-and-sub-agents-fd52952dcf00 | Medium Article |
| **Custom Agents** | https://dev.to/therealmrmumba/claude-codes-custom-agent-framework-changes-everything-4o4m | DEV Community |
| **How-To Guide** | https://www.cometapi.com/how-to-create-and-use-subagents-in-claude-code/ | Tutorial |

---

## YAML Frontmatter Specification

### Official Schema (from Anthropic Documentation)

According to Anthropic's official documentation, each subagent is defined in a Markdown file with this structure:

```yaml
---
name: your-sub-agent-name
description: Description of when this subagent should be invoked
tools: tool1, tool2, tool3  # Optional - inherits all tools if omitted
---
```

### Field Descriptions (Official)

#### `name` Field
**Type**: String
**Required**: Yes
**Format**: Lowercase with hyphens (kebab-case)
**Purpose**: Identifier for the subagent used in invocation

**From Anthropic Documentation**:
> "The name field is the identifier for the subagent. It should be descriptive and use kebab-case formatting."

---

#### `description` Field
**Type**: String
**Required**: Yes
**Purpose**: Helps Claude Code intelligently select appropriate subagents

**From Anthropic Documentation**:
> "Claude Code intelligently selects subagents based on context. Make your description fields specific and action-oriented for best results."

**Guidelines**:
- Be specific about when the subagent should be invoked
- Use action-oriented language
- Describe the task domain clearly
- Include specialization details

---

#### `tools` Field
**Type**: Comma-separated string
**Required**: No (optional)
**Default**: Inherits all tools if omitted

**From Anthropic Documentation**:
> "If you omit tools, the subagent inherits the thread's tools (including MCP). Whitelist when you need tight control."

**Important Notes**:
- Omitting `tools` grants full access to all available tools
- Explicitly listing tools restricts access to only those tools
- Use whitelisting for security and safety
- MCP (Model Context Protocol) tools are inherited if not restricted

---

## Storage Locations

### Official Storage Paths (from Anthropic Documentation)

```
User subagents:    ~/.claude/agents/
Project subagents: .claude/agents/
```

### Location Details

#### User-Level Subagents
**Path**: `~/.claude/agents/`
**Scope**: Available across all projects
**Use Case**: Personal utilities, cross-project helpers
**Persistence**: Permanent until manually removed

#### Project-Level Subagents
**Path**: `.claude/agents/`
**Scope**: Specific to the project directory
**Use Case**: Project-specific agents, team collaboration
**Sharing**: Can be committed to version control for team sharing

### Precedence Rules

**From Anthropic Documentation**:
> "When subagent names conflict, project-level subagents take precedence over user-level subagents."

**Precedence Order**:
1. Project subagents (`.claude/agents/`) - **Highest priority**
2. User subagents (`~/.claude/agents/`) - **Lower priority**

**Example**:
```
If both locations have a `code-reviewer.md` agent:
- Claude Code will use `.claude/agents/code-reviewer.md`
- `~/.claude/agents/code-reviewer.md` will be ignored
```

---

## Tool Access and Permissions

### Tool Inheritance Model

**From Anthropic Documentation**:
> "If you omit tools, the subagent inherits the thread's tools (including MCP)."

### Inheritance Behavior

```yaml
# Full inheritance (all tools + MCP tools)
---
name: my-agent
description: Agent with full tool access
---

# Restricted access (whitelist only)
---
name: my-restricted-agent
description: Agent with limited tools
tools: Read, Grep, Glob
---
```

### MCP (Model Context Protocol) Tools

**What is MCP?**
- Model Context Protocol for external integrations
- Provides access to external APIs, databases, services
- Inherited by default unless tools are explicitly whitelisted

**Security Consideration**:
- Omitting `tools` field = full MCP access
- Whitelisting `tools` = no MCP access unless explicitly included
- Use whitelisting for security-sensitive agents

---

## Agent Selection Mechanism

### Intelligent Selection (from Anthropic)

**From Anthropic Documentation**:
> "Claude Code intelligently selects subagents based on context. Make your description fields specific and action-oriented for best results."

### How Selection Works

1. **Context Analysis**: Claude Code analyzes the user's request
2. **Description Matching**: Compares request to agent descriptions
3. **Automatic Selection**: Chooses the most appropriate agent
4. **Manual Override**: Users can explicitly invoke with `@agent-name`

### Optimizing for Selection

**Action-Oriented Descriptions**:
```yaml
# ✅ Good - specific and action-oriented
description: Expert code reviewer specializing in security vulnerabilities and OWASP compliance. Use for security audits and authentication reviews.

# ❌ Poor - vague and generic
description: Helps with code and security stuff
```

**Domain Specificity**:
```yaml
# ✅ Good - clear domain specialization
description: React performance optimization specialist. Use when components render slowly or have memory leaks.

# ❌ Poor - too broad
description: Frontend helper for performance issues
```

**Invocation Triggers**:
```yaml
# ✅ Good - explicit when to use
description: Database migration specialist for PostgreSQL schema changes. Use when creating, modifying, or optimizing database schemas.

# ❌ Poor - unclear when to invoke
description: Knows about databases
```

---

## Best Practices from Anthropic

### 1. Description Quality

**From Anthropic Documentation**:
> "Make your description fields specific and action-oriented for best results."

**Best Practices**:
- Use 50-180 characters
- Include domain specialization
- Mention specific technologies/frameworks
- Specify when to invoke ("Use when...", "Use for...")
- Avoid vague terms like "helper", "assistant", "tool"

### 2. Tool Whitelisting

**From Anthropic Documentation**:
> "Whitelist when you need tight control."

**When to Whitelist**:
- Security-sensitive agents
- Agents that should not modify files
- Agents that don't need external access
- Production environments

**When to Inherit**:
- Development/exploratory agents
- Agents needing full capabilities
- Agents requiring MCP integrations

### 3. Separation of Concerns

**Best Practices**:
- Create specialized agents for specific tasks
- Avoid "jack-of-all-trades" agents
- Use multiple focused agents instead of one general agent
- Coordinate between agents using the Task tool

### 4. Team Collaboration

**Project-Level Agents**:
- Store in `.claude/agents/` directory
- Commit to version control
- Document in project README
- Maintain consistent naming with team

**User-Level Agents**:
- Store personal utilities in `~/.claude/agents/`
- Keep project-agnostic
- Don't commit to version control

---

## Release Information

### Sub-Agent Feature Release

**Release Date**: July 2025
**Announced By**: Anthropic

**From Release Announcement**:
> "Released by Anthropic in July 2025, this feature addresses the critical problem of 'context pollution'—where single AI conversations become muddled with unrelated tasks."

### Key Problem Solved: Context Pollution

**What is Context Pollution?**
- Single conversations handling multiple unrelated tasks
- Loss of focus and context switching
- Degraded quality as context grows
- Difficulty tracking different task threads

**How Sub-Agents Solve This**:
- **Separate context windows** for each sub-agent
- **Task-specific configurations** with specialized prompts
- **Isolated execution environments** prevent cross-contamination
- **Coordinated workflows** between specialized agents

### Feature Benefits

1. **Specialization**: Task-specific agents with domain expertise
2. **Context Management**: Separate contexts prevent pollution
3. **Tool Control**: Granular permissions for security
4. **Workflow Efficiency**: Coordinated multi-agent workflows
5. **Team Collaboration**: Shareable project-level agents

---

## Community Resources

### Official Anthropic Resources

- **Documentation**: https://docs.anthropic.com/en/docs/claude-code/sub-agents
- **SDK Reference**: https://docs.claude.com/en/docs/claude-code/sdk/subagents
- **Settings Guide**: https://docs.claude.com/en/docs/claude-code/settings

### Community Tutorials

#### Comprehensive Guides
- **Claude Code Frameworks & Sub-Agents: The Complete 2025 Developer's Guide**
  - URL: https://medianeth.dev/blog/claude-code-frameworks-subagents-2025
  - Coverage: Full framework overview, sub-agent creation, best practices

- **Practical Guide to Mastering Claude Code's Main Agent and Sub-Agents**
  - URL: https://jewelhuq.medium.com/practical-guide-to-mastering-claude-codes-main-agent-and-sub-agents-fd52952dcf00
  - Coverage: Step-by-step practical examples

#### Best Practices
- **Best Practices for Claude Code Subagents**
  - URL: https://www.pubnub.com/blog/best-practices-for-claude-code-sub-agents/
  - Coverage: Production-ready patterns, security, performance

#### Technical Deep Dives
- **Claude Agent Skills: A First Principles Deep Dive**
  - URL: https://leehanchung.github.io/blogs/2025/10/26/claude-skills-deep-dive/
  - Coverage: Skills layer architecture (related to sub-agents)

#### How-To Guides
- **How to Create and Use Subagents in Claude Code**
  - URL: https://www.cometapi.com/how-to-create-and-use-subagents-in-claude-code/
  - Coverage: Step-by-step creation tutorial

- **Claude Code's Custom Agent Framework Changes Everything**
  - URL: https://dev.to/therealmrmumba/claude-codes-custom-agent-framework-changes-everything-4o4m
  - Coverage: Custom framework implementation

---

## Official Specification Summary

Based on Anthropic's official documentation, here's the canonical sub-agent specification:

### Minimal Valid Agent

```yaml
---
name: agent-name
description: Description of what this agent does and when to use it
---

[Agent system prompt content]
```

### Full-Featured Agent

```yaml
---
name: agent-name
description: Specific, action-oriented description of agent purpose and when to invoke
tools: Tool1, Tool2, Tool3  # Whitelist for security
---

[Comprehensive system prompt with expertise, processes, and examples]
```

### File Location

```
User-level:    ~/.claude/agents/agent-name.md
Project-level: .claude/agents/agent-name.md
```

### Invocation

```
@agent-name [task description]
```

---

## Key Takeaways from Official Documentation

1. **YAML Frontmatter is Required**: Every agent needs `name` and `description`
2. **Tools are Optional**: Omitting `tools` grants full access; whitelisting restricts access
3. **Descriptions Drive Selection**: Specific, action-oriented descriptions improve automatic selection
4. **Storage is Flexible**: User-level for personal, project-level for teams
5. **Project Takes Precedence**: Project agents override user agents with same name
6. **MCP is Inherited**: Unless tools are whitelisted, agents get MCP access
7. **Context Isolation**: Each agent has separate context to prevent pollution

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | July 2025 | Initial sub-agent feature release by Anthropic |
| 2.0 | October 2025 | Skills layer introduction (autonomous background helpers) |
| 2.5 | November 2025 | Enhanced documentation and best practices |

---

## Additional Notes

### Official vs Community Standards

**Official Anthropic Specification**:
- 2 required fields: `name`, `description`
- 1 optional field: `tools`
- Simple YAML structure
- Flexible content format

**Community/Claude Code Tresor Extensions**:
- Additional required field: `model: inherit`
- Structured content sections (8+ sections)
- Skills integration patterns
- Dual documentation (agent + README)
- Tool selection guidelines
- Validation checklists

**Compatibility**: Claude Code Tresor agents are fully compatible with official Anthropic specification while adding structure and best practices.

---

## References

1. Anthropic. (2025, July). *Subagents - Claude Code Documentation*. Retrieved from https://docs.anthropic.com/en/docs/claude-code/sub-agents

2. Anthropic. (2025). *Subagents in the SDK - Claude Docs*. Retrieved from https://docs.claude.com/en/docs/claude-code/sdk/subagents

3. Anthropic. (2025). *Claude Code Settings*. Retrieved from https://docs.claude.com/en/docs/claude-code/settings

4. WinBuzzer. (2025, July 26). *Anthropic Rolls Out Claude Code 'Sub-Agents' to Streamline Complex AI Workflows*. Retrieved from https://winbuzzer.com/2025/07/26/anthropic-rolls-out-sub-agents-for-claude-code-to-streamline-complex-ai-workflows-xcxwbn/

---

**See Also**:
- [Sub-Agent Structure Documentation](SUB-AGENT-STRUCTURE.md)
- [Sources vs Agents Comparison](COMPARISON-ANALYSIS.md)
- [Migration Guide](../documentation/guides/migration.md)
