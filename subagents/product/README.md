# Product Team Agents 💜

> **Team Color**: Purple (#8B5CF6)
>
> **Category**: Product
> **Total Agents**: 9 specialists

---

## Overview

The Product team agents provide comprehensive expertise in product management, requirements gathering, user research, and analytics. These agents help transform ideas into well-defined products, manage feature development, and ensure successful product launches.

### Team Specializations

- **Product Management** - Feature orchestration, launch management, sprint planning
- **Requirements** - PRD creation, requirements generation, testable specifications
- **Research** - Market trends, user feedback synthesis, experimentation
- **Analytics** - Product analytics, feedback analysis, experiment tracking

---

## Subcategories

### 1. Product Management

**Path**: `subagents/marketing/management/`

**Agents**:
- product-manager - Product management orchestrator for coordinating specialized agents to deliver complete features
- project-shipper - Launch orchestrator for release management, go-to-market execution, and stakeholder communication
- sprint-prioritizer - Sprint planning specialist for maximizing value delivery in 6-day cycles
- studio-producer - Studio orchestrator for cross-team coordination, resource optimization, and workflow engineering

**Use Cases**:
- Feature planning and coordination
- Release management and launches
- Sprint planning and prioritization
- Cross-team collaboration
- Resource allocation and optimization
- Stakeholder communication
- Roadmap planning and execution
- Value delivery maximization

---

### 2. Requirements

**Path**: `subagents/marketing/requirements/`

**Agents**:
- prd-writer - Product requirements specialist for creating comprehensive PRDs with testable requirements
- requirements-generator - Product requirements generator for transforming ideas into structured PRDs

**Use Cases**:
- Writing comprehensive PRDs
- Transforming feature ideas into requirements
- Creating testable specifications
- Defining acceptance criteria
- Technical requirements documentation
- User story creation
- Requirements validation
- Stakeholder alignment

---

### 3. Research

**Path**: `subagents/marketing/research/`

**Agents**:
- trend-researcher - Market trend analyst for identifying viral opportunities and emerging behaviors
- feedback-synthesizer - User feedback analyst for synthesizing multi-source feedback into actionable insights

**Use Cases**:
- Market trend identification
- Viral opportunity detection
- Emerging behavior analysis
- User feedback synthesis
- Multi-source data analysis
- Actionable insight generation
- Product-market fit validation
- Feature opportunity identification

---

### 4. Analytics

**Path**: `subagents/marketing/analytics/`

**Agents**:
- experiment-tracker - Experiment orchestrator for A/B testing, feature experiments, and data-driven iteration

**Use Cases**:
- A/B test design and execution
- Feature experiment planning
- Data-driven iteration
- Hypothesis validation
- Experiment analysis and reporting
- Statistical significance testing
- Conversion optimization
- Success metric tracking

---

## Usage Examples

### Feature Development Orchestration

```bash
@product-manager Build a new user onboarding flow with gamification

# Agent will:
# - Coordinate requirements (@prd-writer)
# - Plan technical implementation (@systems-architect)
# - Design user experience (@ui-ux-designer)
# - Create test strategy (@test-engineer)
# - Plan launch execution (@project-shipper)
# - Define success metrics
```

### Product Requirements Documentation

```bash
@prd-writer Create a PRD for our new AI-powered search feature

# Agent will provide:
# - Comprehensive PRD structure
# - User stories and personas
# - Functional requirements
# - Non-functional requirements
# - Testable acceptance criteria
# - Success metrics and KPIs
# - Technical constraints
# - Launch timeline
```

### Sprint Planning

```bash
@sprint-prioritizer Prioritize features for our 6-day sprint

# Agent will:
# - Assess value vs effort for each feature
# - Apply prioritization frameworks (RICE, MoSCoW)
# - Maximize value delivery
# - Balance quick wins with long-term goals
# - Create sprint backlog
# - Define sprint goals
# - Identify dependencies
```

### Market Trend Research

```bash
@trend-researcher Identify emerging trends in AI productivity tools

# Agent will:
# - Analyze market trends and patterns
# - Identify viral opportunities
# - Track emerging behaviors
# - Monitor competitor movements
# - Predict future trends
# - Provide strategic recommendations
```

### User Feedback Analysis

```bash
@feedback-synthesizer Synthesize user feedback from support tickets, surveys, and interviews

# Agent will:
# - Aggregate multi-source feedback
# - Identify common themes and patterns
# - Prioritize pain points
# - Extract actionable insights
# - Recommend feature improvements
# - Create user personas from data
```

### Experiment Design

```bash
@experiment-tracker Design an A/B test for our new pricing page

# Agent will:
# - Define hypothesis and goals
# - Design experiment structure
# - Determine sample size and duration
# - Create variation specifications
# - Define success metrics
# - Plan statistical analysis
# - Set up tracking and monitoring
```

### Launch Management

```bash
@project-shipper Plan the launch of our mobile app

# Agent will:
# - Create launch checklist
# - Coordinate stakeholders
# - Plan go-to-market strategy
# - Design communication plan
# - Manage dependencies
# - Track launch metrics
# - Plan post-launch iteration
```

---

## Standards Integration

All product agents follow standards from `/standards/` folder:
- **Product Development** - PRD templates, requirement formats, user story structure
- **Agile Methodologies** - Sprint planning, backlog management, estimation
- **Experimentation** - A/B testing frameworks, statistical analysis, success metrics
- **Analytics** - Product metrics, KPIs, tracking implementation
- **Launch Management** - Go-to-market checklists, stakeholder communication

---

## Related Categories

- **Engineering** → For technical implementation and architecture
- **Design** → For user experience and interface design
- **Marketing** → For go-to-market and content strategy
- **Research** → For market intelligence and competitive analysis
- **Leadership** → For business strategy and financial planning

---

## Color Code

💜 **Purple (#8B5CF6)** - All product agents use purple for team identification

Use this color in:
- Agent badges
- Documentation
- CLI output
- Visual tools

---

## Quick Reference

**When to Use Product Agents**:
- ✅ Feature planning and development
- ✅ Writing product requirements
- ✅ Sprint planning and prioritization
- ✅ Product launches and releases
- ✅ Market trend research
- ✅ User feedback analysis
- ✅ A/B testing and experimentation
- ✅ Cross-team coordination

**Agent Selection Guide**:
1. **Feature orchestration** → @product-manager
2. **Launch management** → @project-shipper
3. **Sprint planning** → @sprint-prioritizer
4. **Team coordination** → @studio-producer
5. **PRD creation** → @prd-writer
6. **Requirements generation** → @requirements-generator
7. **Trend research** → @trend-researcher
8. **Feedback synthesis** → @feedback-synthesizer
9. **Experiment design** → @experiment-tracker

---

**See Also**:
- [Agent Inventory](../../docs/AGENT-INVENTORY.md)
- [Agent Index](../AGENT-INDEX.md)
- [Complete Catalog](../README.md)
