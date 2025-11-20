# Tresor Workflow Framework - Complete Guide

> Advanced workflow management system for complex development tasks

**Version:** 2.7.0
**Last Updated:** November 19, 2025

---

## 🎯 What is Tresor Workflow Framework?

Tresor Workflow Framework is an integrated system of 5 slash commands that work together to handle:
- **Meta-prompting** - Generate and execute optimized prompts for complex tasks
- **Todo management** - Capture ideas and resume work without losing context
- **Context handoff** - Seamlessly continue work across sessions

**Key Features:**
- ✅ Automatic agent detection and suggestions (uses all 133 Tresor agents)
- ✅ Fresh sub-agent contexts for parallel/sequential execution
- ✅ Structured todo format with full conversation context
- ✅ Comprehensive session handoff for zero information loss

---

## 📦 Framework Components

### 5 Workflow Commands

| Command | Purpose | When to Use |
|---------|---------|-------------|
| **`/prompt-create`** | Generate optimized prompts | Complex tasks requiring expert prompts |
| **`/prompt-run`** | Execute prompts in sub-agents | Running generated prompts (parallel/sequential) |
| **`/todo-add`** | Capture ideas with context | Spotting issues mid-conversation |
| **`/todo-check`** | Resume work on todos | Reviewing and selecting todos to work on |
| **`/handoff-create`** | Create session handoff | Pausing work or context getting full |

---

## 🚀 Command Details

### 1. `/prompt-create` - Meta-Prompting

**Purpose:** Generate expert-level prompts optimized for Claude Code.

**Usage:**
```bash
/prompt-create [task description]
```

**What It Does:**
1. Analyzes your task to determine complexity and optimal structure
2. Reads `CLAUDE.md` to understand project-specific standards
3. Suggests appropriate Tresor agents based on task type
4. Generates XML-structured prompt with:
   - Clear objectives and context
   - Specific requirements and constraints
   - Verification and success criteria
5. Saves to `./prompts/[number]-[name].md`
6. Offers to run the prompt immediately or save for later

**Example:**
```bash
/prompt-create Design scalable microservices architecture for e-commerce platform with 100k users

# Output:
# ✓ Saved prompt to ./prompts/001-microservices-architecture.md
#
# This prompt suggests invoking:
# - @systems-architect (primary)
# - @backend-architect
# - @cloud-architect
#
# What's next?
# 1. Run prompt now
# 2. Review/edit prompt first
# 3. Save for later
```

**Best For:**
- Complex architectural decisions
- Multi-step implementation tasks
- Tasks requiring expert-level prompts
- Work that benefits from structured planning

**Integration:**
- References Tresor's `CLAUDE.md` for project standards
- Suggests agents from `subagents/AGENT-INDEX.md`
- Follows anti-overengineering principles
- Includes maintainability constraints (300 line limit, file economy)

---

### 2. `/prompt-run` - Prompt Execution

**Purpose:** Execute generated prompts in fresh sub-agent contexts.

**Usage:**
```bash
# Run single prompt
/prompt-run [number]

# Run most recent prompt
/prompt-run

# Run multiple prompts in parallel
/prompt-run 001 002 003 --parallel

# Run multiple prompts sequentially
/prompt-run 001 002 003 --sequential
```

**What It Does:**
1. Reads prompt(s) from `./prompts/` directory
2. Launches sub-agent(s) with fresh context
3. **Parallel mode:** All agents run simultaneously (single message with multiple Task calls)
4. **Sequential mode:** Agents run one after another (waits for completion before next)
5. Archives completed prompts to `./prompts/completed/`
6. Returns consolidated results

**Example:**
```bash
# Parallel execution (independent tasks)
/prompt-run 001 002 003 --parallel

# Output:
# ✓ Executed in PARALLEL:
#   - ./prompts/001-setup-auth.md
#   - ./prompts/002-setup-api.md
#   - ./prompts/003-setup-ui.md
#
# ✓ All archived to ./prompts/completed/
#
# Results:
# - Auth module: JWT implementation complete
# - API endpoints: 15 endpoints created
# - UI components: 8 components scaffolded
```

**Best For:**
- Executing complex multi-step workflows
- Parallel execution of independent modules
- Sequential execution of dependent tasks
- Keeping main conversation lean (fresh sub-agent contexts)

**Parallel vs Sequential:**

**Use Parallel When:**
- Tasks are independent (no shared files)
- No data dependencies between tasks
- Want maximum speed

**Use Sequential When:**
- Tasks depend on each other
- Shared file modifications
- One task needs output from previous task

---

### 3. `/todo-add` - Capture Ideas

**Purpose:** Capture issues, ideas, and tasks without breaking flow.

**Usage:**
```bash
# With explicit description
/todo-add [description]

# Infer from conversation
/todo-add
```

**What It Does:**
1. Reads `TO-DOS.md` (creates if doesn't exist)
2. Checks for duplicates
3. Extracts context from conversation:
   - Problem or task description
   - Relevant file paths with line numbers
   - Technical details (errors, conflicts, root cause)
4. Appends structured todo with timestamp
5. Confirms and offers to continue original work

**Structured Format:**
```markdown
## Context Title - 2025-11-19 14:23

- **[Action] [Component]** - Brief description. **Problem:** What's wrong/why needed. **Files:** path/to/file.ts:123-145, path/to/file2.py:67. **Solution:** Approach hints (optional).
```

**Example:**
```bash
# During code review, spot issue
/todo-add Fix N+1 query in user API

# Output:
# ✓ Saved to TO-DOS.md
#
# Added:
# ## Fix Database Query - 2025-11-19 14:23
# - **Optimize N+1 queries in user API** - Multiple database queries in loop causing performance degradation. **Problem:** Each user fetch triggers separate query for profile data. **Files:** src/api/users.ts:45-67. **Solution:** Use JOIN or eager loading.
#
# Would you like to continue with [previous task]?
```

**Best For:**
- Spotting issues during code review
- Capturing improvement ideas mid-conversation
- Noting technical debt for later
- Quick context capture without derailing current work

**Integration:**
- Auto-detects Tresor components (agents, skills, commands)
- Preserves full conversation context
- Structured format for easy resumption

---

### 4. `/todo-check` - Resume Work

**Purpose:** Review todos and resume work with complete context.

**Usage:**
```bash
/todo-check
```

**What It Does:**
1. Reads `TO-DOS.md`
2. Displays compact numbered list (title + date)
3. User selects a todo
4. Loads full context:
   - Complete todo description (Problem, Files, Solution)
   - Section heading for additional context
   - Brief summary of relevant files
5. **Detects Tresor agents** based on:
   - File paths (e.g., `api/` → backend agents)
   - Todo content keywords (e.g., "database" → @database-optimizer)
   - Domain patterns (e.g., `ui/` → @ui-designer)
6. Offers action options:
   - Invoke suggested agent and start
   - Invoke relevant skill (if applicable)
   - Work on it directly
   - Brainstorm approach first
   - Put it back and browse other todos

**Example:**
```bash
/todo-check

# Output:
# Outstanding Todos:
#
# 1. Optimize N+1 queries in user API (2025-11-19 14:23)
# 2. Add GDPR consent flow (2025-11-18 10:15)
# 3. Refactor auth module (2025-11-17 09:30)
#
# Reply with the number of the todo you'd like to work on.

# User selects: 1

# Output:
# ## Fix Database Query - 2025-11-19 14:23
# - **Optimize N+1 queries in user API** - Multiple database queries in loop causing performance degradation. **Problem:** Each user fetch triggers separate query for profile data. **Files:** src/api/users.ts:45-67. **Solution:** Use JOIN or eager loading.
#
# File Summary:
# - src/api/users.ts: Express route handlers for user endpoints
#
# This looks like database/backend work. Would you like to:
#
# 1. Invoke @database-optimizer and start
# 2. Invoke @performance-tuner and start
# 3. Work on it directly
# 4. Brainstorm approach first
# 5. Put it back and browse other todos
#
# Reply with the number of your choice.
```

**Best For:**
- Resuming work after breaks
- Reviewing accumulated technical debt
- Getting agent suggestions for captured issues
- Maintaining context across sessions

**Agent Detection Patterns:**
- **Database files** (`db/`, `migrations/`, `*.sql`) → @database-optimizer, @sql-pro
- **API files** (`api/`, `routes/`, `controllers/`) → @backend-architect, @api-documenter
- **Frontend files** (`components/`, `ui/`, `*.jsx`) → @frontend-developer, @ui-designer
- **Security keywords** ("auth", "security", "vulnerability") → @security-auditor
- **Performance keywords** ("slow", "optimize", "performance") → @performance-tuner
- **Testing files** (`__tests__/`, `*.test.ts`) → @test-engineer

**See:** [Complete agent list](subagents/AGENT-INDEX.md) for all 133 detectable agents.

---

### 5. `/handoff-create` - Session Handoff

**Purpose:** Create comprehensive handoff document for work continuation.

**Usage:**
```bash
/handoff-create
```

**What It Does:**
1. Analyzes entire conversation history
2. Captures comprehensive context:
   - **Original task:** What was initially requested
   - **Work completed:** All artifacts, changes, actions, findings, decisions
   - **Work remaining:** Specific next steps with locations and dependencies
   - **Attempted approaches:** What didn't work and why
   - **Critical context:** Decisions, constraints, discoveries, assumptions
   - **Current state:** Status of deliverables, temporary changes, open questions
3. Writes to `whats-next.md` with XML structure
4. Enables resumption with **zero information loss**

**Example:**
```bash
# After 2 hours of work on complex feature
/handoff-create

# Output:
# ✓ Created comprehensive handoff document: whats-next.md
#
# Summary:
# - Original task: Implement user authentication system
# - Work completed: JWT setup, user model, 3 API endpoints
# - Work remaining: Password reset flow, email verification, tests
# - Attempted approaches: Tried bcrypt (too slow), switched to argon2
# - Critical context: Must support OAuth2 later (architecture decision)
# - Current state: 60% complete, API endpoints functional but untested
#
# Next session: Load whats-next.md to continue exactly where you left off.
```

**Best For:**
- Pausing complex multi-session work
- Context approaching token limits
- Handing off work to another developer
- Documenting decisions and progress

**Complements Tresor Memory Bank:**

| Document | Scope | Updated | Purpose |
|----------|-------|---------|---------|
| `projectbrief.md` | Project | Rarely | Vision, goals, taxonomy |
| `productContext.md` | Tech stack | Occasionally | Architectural decisions, conventions |
| `activeContext.md` | Current priorities | Regularly | Daily/weekly work tracking |
| **`whats-next.md`** | **Session** | **Per session** | **Detailed task handoff** |

**Usage Pattern:**
- Use Tresor Memory Bank for **long-term** project context
- Use `/handoff-create` for **session-specific** task handoff
- Load both in next session for **complete continuity**

---

## 🔄 Workflow Patterns

### Pattern 1: Complex Feature Implementation

**Scenario:** Building a new feature with multiple components

**Workflow:**
```bash
# Step 1: Generate expert prompts for each component
/prompt-create Implement user authentication backend API
/prompt-create Implement user authentication frontend UI
/prompt-create Create tests for authentication system

# Step 2: Execute prompts in parallel (independent components)
/prompt-run 001 002 003 --parallel

# Step 3: If work spans multiple sessions
/handoff-create

# Step 4 (next session): Load context and continue
# [Load whats-next.md]
/prompt-run 004  # Continue with remaining prompts
```

**Benefits:**
- Parallel execution speeds up implementation
- Fresh contexts prevent token limit issues
- Complete handoff ensures no information loss

---

### Pattern 2: Todo-Driven Development

**Scenario:** Accumulating technical debt and improvement ideas

**Workflow:**
```bash
# During code review
/todo-add Fix N+1 query in user API

# During feature work
/todo-add Add error handling to payment processor

# During security audit
/todo-add Implement rate limiting on login endpoint

# Later: Review and work on todos
/todo-check
# → Select todo #1
# → System suggests @database-optimizer
# → Invoke agent and fix issue
```

**Benefits:**
- Capture issues without breaking flow
- Agent suggestions speed up issue resolution
- Structured format ensures complete context

---

### Pattern 3: Research → Prompt → Execute

**Scenario:** Complex task requiring research and planning

**Workflow:**
```bash
# Step 1: Capture initial idea
/todo-add Research microservices migration strategy

# Step 2: When ready, generate expert prompt
/prompt-create Design microservices migration for monolithic e-commerce app
# → Prompt suggests: @systems-architect, @backend-architect, @cloud-architect

# Step 3: Execute prompt with suggested agents
/prompt-run 001
# → Sub-agent invokes @systems-architect for comprehensive analysis

# Step 4: If research reveals multiple implementation paths
/prompt-create Implement service A (user service)
/prompt-create Implement service B (order service)
/prompt-create Implement service C (payment service)

# Step 5: Execute in parallel
/prompt-run 002 003 004 --parallel

# Step 6: If work extends over multiple days
/handoff-create
# → Next session: Load and continue
```

**Benefits:**
- Structured approach to complex problems
- Expert prompts ensure thoroughness
- Parallel execution for speed
- Handoff for multi-day work

---

### Pattern 4: Sequential Pipeline

**Scenario:** Tasks with dependencies (must run in order)

**Workflow:**
```bash
# Step 1: Generate prompts for sequential pipeline
/prompt-create Setup database schema and migrations
/prompt-create Create API endpoints using schema
/prompt-create Build UI components consuming API
/prompt-create Write end-to-end tests

# Step 2: Execute sequentially (each depends on previous)
/prompt-run 001 002 003 004 --sequential
# → 001 completes → 002 starts → 002 completes → 003 starts → etc.

# Benefits:
# - Correct execution order enforced
# - Each step has full context from previous step
# - Single command handles entire pipeline
```

**Benefits:**
- Enforces correct dependency order
- Each step builds on previous step's output
- Single command orchestrates entire pipeline

---

### Pattern 5: Exploration → Capture → Execute

**Scenario:** Exploring codebase and finding improvements

**Workflow:**
```bash
# While exploring codebase
# [Reading files, understanding architecture]

/todo-add Database queries not indexed - users table
/todo-add Unused imports in 12 files - cleanup needed
/todo-add Missing error logging in payment flow

# Later: Batch review todos
/todo-check
# → See all captured improvements
# → Select and fix systematically
```

**Benefits:**
- Capture discoveries without losing exploration flow
- Batch-fix similar issues
- Systematic debt reduction

---

## 🎯 Best Practices

### When to Use `/prompt-create`

**✅ Use when:**
- Task is complex and benefits from expert prompting
- Need structured approach with clear objectives
- Want to leverage Tresor's 133-agent ecosystem
- Task requires specific constraints or validation

**❌ Don't use when:**
- Task is trivial (just do it directly)
- You already know exactly what to do
- Single-line code change

### When to Use Parallel vs Sequential Execution

**Parallel (`--parallel`):**
```bash
✅ Independent modules (auth, API, UI)
✅ No shared file modifications
✅ No data dependencies
✅ Want maximum speed
```

**Sequential (`--sequential`):**
```bash
✅ Tasks depend on each other
✅ Shared file modifications
✅ One needs output from previous
✅ Pipeline workflows (setup → build → test)
```

### When to Use `/todo-add` vs `/handoff-create`

**`/todo-add`:**
- Quick captures (< 5 minutes per issue)
- Multiple independent improvements
- Technical debt
- Future enhancements

**`/handoff-create`:**
- Complex multi-hour work
- Session ending
- Context approaching limits
- Work handoff to another dev

---

## 🔗 Integration with Tresor Ecosystem

### Agents (133 Total)

Tresor Workflow Framework automatically detects and suggests agents from:
- **Core agents** (8): systems-architect, config-safety-reviewer, etc.
- **Engineering** (54): backend-architect, frontend-developer, database-optimizer, etc.
- **Design** (7): ui-designer, ux-researcher, etc.
- **Product** (9): product-manager, product-analyst, etc.
- **Leadership** (14): cto, vp-engineering, etc.
- **And 6 more teams** (41 agents)

**See:** [Complete Agent Catalog](subagents/README.md)

### Skills (8 Total)

Skills work alongside workflow commands:
- **code-reviewer** - Real-time code quality (complements `/review`)
- **test-generator** - Auto-suggest tests (complements `/test-gen`)
- **security-auditor** - OWASP scanning (complements agent security audits)
- **And 5 more skills**

**See:** [Skills Guide](skills/README.md)

### Other Commands (4 Total)

Workflow commands complement:
- **`/scaffold`** - Project scaffolding
- **`/review`** - Code review automation
- **`/test-gen`** - Test generation
- **`/docs-gen`** - Documentation generation

---

## 📊 Performance Tips

### Optimize Token Usage

**Problem:** Long conversations hit token limits

**Solutions:**
1. Use `/handoff-create` to offload context
2. Execute complex tasks in fresh sub-agent contexts (`/prompt-run`)
3. Keep main conversation focused on orchestration

### Speed Up Execution

**Problem:** Sequential execution is slow

**Solutions:**
1. Identify independent tasks
2. Use `--parallel` flag for simultaneous execution
3. Break monolithic tasks into parallelizable sub-tasks

### Improve Context Quality

**Problem:** Resumed work lacks context

**Solutions:**
1. Use structured todo format (Problem, Files, Solution)
2. Capture context immediately (don't rely on memory)
3. Use `/handoff-create` for comprehensive handoffs

---

## 🆘 Troubleshooting

### Issue: Agent suggestions not appearing

**Cause:** `/todo-check` can't find `subagents/` directory

**Solution:**
```bash
# Verify subagents directory exists
ls subagents/

# Reinstall if missing
./scripts/install.sh --agents
```

---

### Issue: Parallel execution runs sequentially

**Cause:** Multiple Task calls not in single message

**Solution:** `/prompt-run` handles this automatically. If custom implementation:
```bash
# Wrong (sequential)
Task tool for prompt 001
[wait for response]
Task tool for prompt 002

# Correct (parallel)
Task tool for prompt 001
Task tool for prompt 002
Task tool for prompt 003
[All in single message]
```

---

### Issue: Prompts not found

**Cause:** `./prompts/` directory doesn't exist

**Solution:**
```bash
# Create prompts directory
mkdir -p ./prompts/

# Regenerate prompt
/prompt-create [task]
```

---

## 📚 Related Documentation

- **[Navigation Guide](NAVIGATION.md)** - Find your way around Tresor
- **[Migration Guide](MIGRATION.md)** - Upgrade from v2.6 or earlier
- **[Agent Catalog](subagents/README.md)** - Browse all 133 agents
- **[Getting Started](documentation/guides/getting-started.md)** - New user guide

---

## 🚀 Quick Reference Card

```bash
# Meta-Prompting
/prompt-create [task]              # Generate expert prompt
/prompt-run [numbers] --parallel   # Execute in parallel
/prompt-run [numbers] --sequential # Execute sequentially

# Todo Management
/todo-add [description]            # Capture idea
/todo-check                        # Review & resume todos

# Context Handoff
/handoff-create                    # Create session handoff

# Typical Workflow
1. /prompt-create [complex task]
2. /prompt-run [numbers] --parallel
3. /todo-add [issues found during work]
4. /handoff-create [before ending session]
5. Next session: Load whats-next.md
6. /todo-check [resume captured issues]
```

---

**Version:** 2.7.0
**Last Updated:** November 19, 2025
**License:** MIT
**Author:** Alireza Rezvani
