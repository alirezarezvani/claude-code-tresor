---
name: todo-check
description: List outstanding todos and select one to work on
argument-hint: (no arguments)
allowed-tools: [Read, Edit, Glob]
model: inherit
enabled: true
---

# Check Todos

## Instructions

1. Read TO-DOS.md in the working directory (if doesn't exist, say "No outstanding todos" and exit)

2. Parse and display todos:
   - Extract all list items starting with `- **` (active todos)
   - If none exist, say "No outstanding todos" and exit
   - Display compact numbered list showing:
     - Number (for selection)
     - Bold title only (part between `**` markers)
     - Date from h2 heading above it
   - Prompt: "Reply with the number of the todo you'd like to work on."
   - Wait for user to reply with a number

3. Load full context for selected todo:
   - Display complete line with all fields (Problem, Files, Solution)
   - Display h2 heading (topic + date) for additional context
   - Read and briefly summarize relevant files mentioned

4. Check for established workflows and Tresor agents:
   - Read CLAUDE.md (if exists) to understand project-specific workflows and rules
   - **Detect Tresor's agent ecosystem**:
     - Scan `subagents/` directory for 141 specialized agents
     - Match todo file paths to Tresor categories:
       * `subagents/engineering/` or `src/`, `api/`, `backend/` → Engineering agents
       * `subagents/design/` or `ui/`, `components/`, `design/` → Design agents
       * `skills/` → Skill development work
       * `commands/` → Command development work
       * `agents/` → Core agent work
   - **Suggest specific Tresor agents** based on todo content and file paths:
     * Database-related → @database-optimizer, @sql-pro
     * API/Backend → @backend-architect, @api-documenter
     * Frontend/UI → @frontend-developer, @ui-designer
     * Performance → @performance-tuner
     * Security → @security-auditor
     * Testing → @test-engineer
     * See `subagents/AGENT-INDEX.md` for all 141 agents
   - Look for `.claude/skills/` directory for skill-based workflows
   - Check CLAUDE.md for explicit workflow requirements

5. Present action options to user:
   - **If Tresor agent match found**: "This looks like [domain] work. Would you like to:\n\n1. Invoke @{tresor-agent} and start\n2. Invoke {skill-name} skill (if applicable)\n3. Work on it directly\n4. Brainstorm approach first\n5. Put it back and browse other todos\n\nReply with the number of your choice."
   - **If matching skill/workflow found (but no Tresor agent)**: "This looks like [domain] work. Would you like to:\n\n1. Invoke [skill-name] skill and start\n2. Work on it directly\n3. Brainstorm approach first\n4. Put it back and browse other todos\n\nReply with the number of your choice."
   - **If no workflow match**: "Would you like to:\n\n1. Start working on it\n2. Brainstorm approach first\n3. Put it back and browse other todos\n\nReply with the number of your choice."
   - Wait for user response

6. Handle user choice:
   - **Option "Invoke Tresor agent" or "Invoke skill" or "Start working"**: Remove todo from TO-DOS.md (and h2 heading if section becomes empty), then begin work (invoke Tresor agent or skill if applicable, or proceed directly)
   - **Option "Brainstorm approach"**: Keep todo in file, could invoke @systems-architect or @{relevant-agent} for planning assistance
   - **Option "Put it back"**: Keep todo in file, return to step 2 to display the full list again

## Display Format

```
Outstanding Todos:

1. Add structured format to add-to-todos (2025-11-15 14:23)
2. Create check-todos command (2025-11-15 14:23)
3. Fix cookie-extractor MCP workflow (2025-11-14 09:15)

Reply with the number of the todo you'd like to work on.
```
