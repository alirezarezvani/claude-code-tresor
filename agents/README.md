# Claude Code Tresor - Core Agents (Backward Compatibility)

> **⚠️ NOTICE:** This directory is maintained for backward compatibility only.
> **Primary Location:** All agents are now organized in `/subagents/` (v2.7.0+)
> **Migration Path:** The `agent.md` files in this directory are symlinks to `/subagents/core/`

---

## 📦 Directory Structure (v2.7.0)

As of v2.7.0, Claude Code Tresor uses a unified agent structure:

```
subagents/                     # PRIMARY LOCATION (133 total agents)
├── core/                      # 8 core production agents
│   ├── config-safety-reviewer/
│   ├── systems-architect/
│   ├── root-cause-analyzer/
│   ├── security-auditor/
│   ├── test-engineer/
│   ├── performance-tuner/
│   ├── refactor-expert/
│   └── docs-writer/
├── engineering/               # 54 engineering specialists
├── design/                    # 7 design specialists
├── marketing/                 # 11 marketing specialists
├── product/                   # 9 product specialists
├── leadership/                # 14 leadership specialists
├── operations/                # 6 operations specialists
├── research/                  # 7 research specialists
├── ai-automation/             # 9 AI/ML specialists
└── account-customer-success/  # 8 account & CS specialists
```

**See:** [Complete Agent Catalog →](../subagents/README.md) | [Agent Index →](../subagents/AGENT-INDEX.md)

---

## 🤖 Core Agents (8 Total)

These 8 agents are duplicated here for backward compatibility. The authoritative versions are in `/subagents/core/`.

| Agent | Expertise | Location |
|-------|-----------|----------|
| **@config-safety-reviewer** | Configuration safety & production reliability | [subagents/core/config-safety-reviewer](../subagents/core/config-safety-reviewer/) |
| **@systems-architect** | System design & technology evaluation | [subagents/core/systems-architect](../subagents/core/systems-architect/) |
| **@root-cause-analyzer** | Comprehensive RCA & systematic debugging | [subagents/core/root-cause-analyzer](../subagents/core/root-cause-analyzer/) |
| **@security-auditor** | Security assessment & OWASP compliance | [subagents/core/security-auditor](../subagents/core/security-auditor/) |
| **@test-engineer** | Testing strategies & QA | [subagents/core/test-engineer](../subagents/core/test-engineer/) |
| **@performance-tuner** | Performance optimization & profiling | [subagents/core/performance-tuner](../subagents/core/performance-tuner/) |
| **@refactor-expert** | Code refactoring & clean architecture | [subagents/core/refactor-expert](../subagents/core/refactor-expert/) |
| **@docs-writer** | Technical documentation & user guides | [subagents/core/docs-writer](../subagents/core/docs-writer/) |

---

## 🚀 Quick Usage Examples

### Invoke Agents
```bash
# Works from either location (thanks to symlinks)
@systems-architect Design scalable e-commerce architecture for 100k users
@config-safety-reviewer Review database connection pool configuration
@security-auditor Analyze this authentication module for vulnerabilities
```

### Discover Extended Agents
```bash
# Browse 125 additional specialists in /subagents/
@database-optimizer   # Engineering team
@ui-designer          # Design team
@content-strategist   # Marketing team
@product-analyst      # Product team
@cto                  # Leadership team
```

**See:** [Complete List of 133 Agents →](../subagents/AGENT-INDEX.md)

---

## 🔧 Technical Details

### Symlink Structure (v2.7.0)

Each agent directory in `/agents/` contains:
- `README.md` - Original documentation (preserved for reference)
- `agent.md` - **Symlink** to `../../subagents/core/[agent-name]/agent.md`

**Example:**
```bash
agents/systems-architect/
├── README.md       # Original documentation
└── agent.md        # Symlink → ../../subagents/core/systems-architect/agent.md
```

This ensures:
- ✅ Backward compatibility for existing installations
- ✅ Single source of truth in `/subagents/core/`
- ✅ No duplication of agent logic
- ✅ Seamless updates via symlinks

### Installation

The installation script (`scripts/install.sh`) automatically:
1. Installs agents from `/subagents/core/` (primary location)
2. Creates symlinks in `/agents/` for backward compatibility
3. Updates Claude Code's agent registry

```bash
./scripts/install.sh --agents  # Installs all 8 core agents
```

---

## 📚 Documentation

### Quick Links
- **[Agent Catalog →](../subagents/README.md)** - Complete list of all 133 agents
- **[Agent Index →](../subagents/AGENT-INDEX.md)** - Searchable catalog with descriptions
- **[Getting Started →](../documentation/guides/getting-started.md)** - First-time user guide
- **[Technical Reference →](../documentation/reference/agents.md)** - Agent architecture details

### Migration Guide (for v2.4/v2.5 users)

**Agent Naming Changes (v2.5.0)**:
| Old Name (v2.4) | New Name (v2.5+) | Status |
|-----------------|------------------|--------|
| `@code-reviewer` | `@config-safety-reviewer` | ⚠️ Breaking |
| `@debugger` | `@root-cause-analyzer` | ⚠️ Breaking |
| `@architect` | `@systems-architect` | ⚠️ Breaking |

**Location Changes (v2.7.0)**:
- Primary location: `/agents/` → `/subagents/core/` (backward compatible via symlinks)

**No Action Required:** Symlinks ensure existing scripts and workflows continue to work.

---

## ⚠️ Deprecation Timeline

| Version | Status | Action |
|---------|--------|--------|
| **v2.7.0** (Current) | `/agents/` maintained with symlinks | ✅ Fully backward compatible |
| **v2.8.x** (2026 Q1) | `/agents/` marked deprecated | ⚠️ Migration warnings added |
| **v3.0.0** (2026 Q2) | `/agents/` removed | ❌ Breaking change |

**Recommendation:** Update your workflows to reference `/subagents/core/` to prepare for v3.0.0.

---

## 🆘 Support

- **[FAQ →](../documentation/reference/faq.md)** - Common questions
- **[Troubleshooting →](../documentation/guides/troubleshooting.md)** - Fix common issues
- **[GitHub Issues](https://github.com/alirezarezvani/claude-code-tresor/issues)** - Report bugs
- **[GitHub Discussions](https://github.com/alirezarezvani/claude-code-tresor/discussions)** - Ask questions

---

**Version:** 2.7.0
**Last Updated:** November 19, 2025
**License:** MIT
**Author:** Alireza Rezvani
