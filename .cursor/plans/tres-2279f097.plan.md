<!-- 2279f097-4e2b-4f96-80cc-5e90782fecd3 0e269a2f-0e5b-4bde-873d-12274991a4cd -->
# Claude Code Tresor Enhancement Roadmap

## Foundations & Memory Bank

- Stand up mandatory memory bank (`projectbrief.md`, `productContext.md`, `activeContext.md`, etc.) to persist architecture, tech stack, and progress context.
- Capture current taxonomy of skills, agents, commands, and scripts so all follow-on decisions share the same source of truth.

## Metadata & Packaging Alignment

- Reconcile installer expectations with actual asset formats by either generating `agent.json`/`command.json` files or teaching `scripts/install.sh` to consume the Markdown frontmatter so agents deploy correctly.
```130:147:scripts/install.sh
        # Copy all agent directories
        find "$agents_src" -mindepth 1 -maxdepth 1 -type d | while read -r agent_dir; do
            local agent_name=$(basename "$agent_dir")

            # Skip README-only directories
            if [ -f "$agent_dir/agent.json" ]; then
                log "Installing agent: $agent_name"
                cp -r "$agent_dir" "$agents_dest/$agent_name"
            fi
        done
```

- Audit documentation vs. real inventory so directories like `commands/README.md` stop advertising non-existent commands (e.g. `/refactor`, `/deploy`).
```29:47:commands/README.md
- **`/refactor`** - Automated code refactoring with best practices
- **`/optimize`** - Performance analysis and optimization suggestions
...
- **`/deploy`** - Deployment automation and verification
```

- Generate machine-readable indexes (YAML/JSON) for skills, agents, and subagents to power search, validation, and future tooling.

## Ecosystem & Automation Expansion

- Design a metadata-driven CLI (e.g. `tresor`) that can list, preview, install, and update skills/agents/commands/subagents from the repo and the `sources/` library.
- Introduce reusable command/agent templates so contributors can scaffold new utilities with validation hooks.
- Build orchestration blueprints showing how autonomous skills feed subagents and commands for key workflows (code review, release, incident response).

## Documentation & Adoption Experience

- Produce a role-based navigation hub that maps typical Claude Code personas (solo dev, team lead, agency) to specific utilities and workflows.
- Collapse duplicated docs (e.g. multiple READMEs per feature) into concise playbooks with deep links to authoritative references.
- Add outcome-focused quick-starts and video-ready scripts that demonstrate end-to-end flows using bundled assets.

## Quality Assurance & Release Management

- Add automated tests/linters for installer scripts and metadata consistency; validate every PR via CI.
- Capture usage analytics & feedback loops (changelogs, release notes, telemetry opt-in) to guide prioritization.
- Formalize versioning and release cadence with signed tags, update scripts, and migration notes for breaking changes.

## Implementation Todos

- baseline: Establish memory bank & repository audit
- packaging: Align installer, metadata, and docs with actual assets
- automation: Build CLI tooling and workflow orchestration patterns
- docs: Redesign documentation & onboarding experience
- quality: Add automated validation, testing, and release process