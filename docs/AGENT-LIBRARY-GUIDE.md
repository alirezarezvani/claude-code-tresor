# Claude Code Tresor - Agent Library Guide

> **Complete guide to 141 professional AI agents for software development**
>
> **Version**: 2.6.0 | **Last Updated**: November 15, 2025
> **Agents**: 141 (8 core + 133 subagents) | **Quality**: 9.7/10

---

## Table of Contents

1. [Overview](#overview)
2. [Quick Start](#quick-start)
3. [Agent Catalog by Category](#agent-catalog-by-category)
4. [Color System](#color-system)
5. [How Agents Work Together](#how-agents-work-together)
6. [Cross-Team Collaboration](#cross-team-collaboration)
7. [Agent Directory Structure](#agent-directory-structure)
8. [Finding the Right Agent](#finding-the-right-agent)

---

## Overview

Claude Code Tresor provides 141 specialized AI agents organized into 10 professional team categories. Each agent is an expert in a specific domain, providing focused assistance for software development, design, marketing, product management, and business operations.

### What's Inside

- **8 Core Agents**: Production-ready specialists for essential development tasks
- **133 Subagents**: Organized by team and functional area
- **10 Categories**: Color-coded for easy identification
- **40+ Subcategories**: Precise specialization areas
- **100% Validated**: All agents tested and verified

### Repository Quality

- **YAML Validity**: 100% (all 133 agents)
- **Content Quality**: 9.7/10 (EXCELLENT)
- **Organization**: 100% (perfect categorization)
- **Cross-References**: 100% (all links valid)

---

## Quick Start

### Find an Agent

**By Category**:
```bash
ls subagents/engineering/     # 54 engineering agents
ls subagents/design/ui/        # UI design agents
ls subagents/marketing/social/ # Social media agents
```

**By Name**:
```bash
find subagents -name "*architect*"  # All architect agents
find subagents -name "*test*"       # All testing agents
```

**By Catalog**:
```bash
cat subagents/AGENT-INDEX.md    # Complete alphabetical index
```

### Invoke an Agent

```bash
# General syntax
@agent-name {specific task description}

# Examples
@systems-architect Design scalable e-commerce system for 100k users
@python-pro Optimize this Python function for performance
@ui-designer Create modern dashboard UI with dark mode
@financial-analyst Calculate ROI for marketing automation feature
```

### Browse by Team

```
🔵 Engineering  → Software development, architecture, testing
🎨 Design       → UI/UX design, visual design, branding
🌱 Marketing    → Content, social media, growth, SEO
💜 Product      → Product management, requirements, research
🏆 Leadership   → Finance, strategy, risk, compliance
🌊 Operations   → Analytics, support, infrastructure
🔶 Research     → Market research, competitive intelligence
🧠 AI/Automation → AI/ML engineering, automation, prompts
💙 Account/CS   → Account management, customer success
⭐ Core         → Production-ready core specialists
```

---

## Agent Catalog by Category

### ⭐ Core Agents (8 agents)

**Purpose**: Production-ready specialists for essential development tasks
**Color**: Gold (#FFD700)

| Agent | Specialization | Use For |
|-------|----------------|---------|
| **systems-architect** | System design & technical strategy | Architecture reviews, technology evaluation, scalability planning |
| **config-safety-reviewer** | Configuration safety & production reliability | Configuration review, magic numbers, pool sizes, timeout validation |
| **root-cause-analyzer** | Comprehensive RCA & debugging | Production incidents, complex bugs, performance issues |
| **security-auditor** | Security vulnerability assessment | OWASP Top 10, authentication, threat modeling, compliance |
| **test-engineer** | Comprehensive test strategy | Unit/integration/E2E testing, coverage analysis, test pyramid |
| **performance-tuner** | Performance profiling & optimization | Bottleneck identification, frontend/backend optimization, load testing |
| **refactor-expert** | Code refactoring & clean architecture | SOLID principles, code smells, technical debt reduction |
| **docs-writer** | Technical documentation specialist | API docs, user guides, architecture documentation |

---

### 🔵 Engineering Agents (54 agents)

**Purpose**: Software development, architecture, and technical expertise
**Color**: Blue (#3B82F6)

#### Languages (15 agents)
- python-pro, javascript-pro, typescript-pro, java-pro, golang-pro, rust-pro
- ruby-pro, php-pro, c-pro, cpp-pro, csharp-pro, scala-pro, elixir-pro, sql-pro
- minecraft-bukkit-pro (specialized)

#### Backend (8 agents)
- backend-architect, backend-reliability-engineer, api-documenter, graphql-architect
- payment-integration, database-admin, database-optimizer, error-detective

#### DevOps (8 agents)
- deployment-engineer, devops-troubleshooter, terraform-specialist, cloud-architect
- network-engineer, incident-responder, dx-optimizer, infrastructure-maintainer

#### Testing (7 agents)
- qa-test-engineer, test-automator, api-tester, performance-benchmarker
- test-results-analyzer, tool-evaluator, workflow-optimizer

#### Other Subcategories
- Mobile (4), Frontend (3), Data (2), Architecture (2), Documentation (2)
- Debugging (1), Security (1), Code Quality (1)

---

### 🎨 Design Agents (7 agents)

**Purpose**: UI/UX design, visual design, and branding
**Color**: Magenta (#EC4899)

- **UI Design** (2): ui-designer, ui-ux-analyst
- **UX Research** (2): ux-researcher, experience-analyzer
- **Visual Design** (2): visual-storyteller, whimsy-injector
- **Brand** (1): brand-guardian

---

### 🌱 Marketing Agents (11 agents)

**Purpose**: Content marketing, growth, and social media
**Color**: Green (#10B981)

- **Content** (4): content-creator, content-marketer, content-writer, tutorial-engineer
- **Social Media** (4): instagram-curator, tiktok-strategist, twitter-engager, reddit-community-builder
- **Growth** (2): growth-hacker, customer-acquisition
- **SEO** (1): app-store-optimizer

---

### 💜 Product Agents (9 agents)

**Purpose**: Product management, requirements, and strategy
**Color**: Purple (#8B5CF6)

- **Management** (4): product-manager, sprint-prioritizer, studio-producer, project-shipper
- **Requirements** (2): prd-writer, requirements-generator
- **Research** (2): feedback-synthesizer, trend-researcher
- **Analytics** (1): experiment-tracker

---

### 🏆 Leadership Agents (14 agents)

**Purpose**: Finance, business strategy, risk, and compliance
**Color**: Gold (#F59E0B)

- **Finance** (7): financial-analyst, cost-optimizer, investment-analyst, pricing-strategist
  quant-analyst, risk-manager, finance-tracker
- **Strategy** (3): business-strategist, business-analyst, partnership-strategist
- **Compliance** (3): compliance-officer, legal-advisor, legal-compliance-checker
- **Risk** (1): risk-assessor

---

### 🌊 Operations Agents (6 agents)

**Purpose**: Business operations, analytics, and support
**Color**: Teal (#14B8A6)

- **Analytics** (2): analytics-reporter, revenue-analyst
- **Infrastructure** (2): infrastructure-maintainer, operations-optimizer
- **Support** (2): support-responder, customer-support

---

### 🔶 Research Agents (7 agents)

**Purpose**: Market research and competitive intelligence
**Color**: Orange (#F97316)

- **Market** (5): competitive-intelligence, business-model-analyzer, tam-market-sizing
  reddit-intelligence, market-research-analyst
- **Data** (2): deep-research-specialist, search-specialist

---

### 🧠 AI & Automation Agents (9 agents)

**Purpose**: AI/ML engineering and automation
**Color**: Indigo (#6366F1)

- **Automation** (3): automation-architect, integration-specialist, workflow-analyst
- **AI Engineering** (2): ai-engineer, ai-workflow-designer
- **ML Engineering** (2): ml-engineer, mlops-engineer
- **Prompts** (2): prompt-engineer, prompt-engineer-advanced

---

### 💙 Account & Customer Success Agents (8 agents)

**Purpose**: Account management and customer success
**Color**: Cyan (#06B6D4)

- **Account Management** (2): account-executive, managed-services-engineer
- **Customer Success** (2): customer-success-manager, retention-specialist
- **Support** (2): customer-support, product-engineer
- **Sales** (2): sales-engineer, sales-automator

---

## Color System

All agents are color-coded by team for easy identification:

| Team | Color | Hex Code | Emoji | Count |
|------|-------|----------|-------|-------|
| Core | Gold | #FFD700 | ⭐ | 8 |
| Engineering | Blue | #3B82F6 | 🔵 | 54 |
| Design | Magenta | #EC4899 | 🎨 | 7 |
| Marketing | Green | #10B981 | 🌱 | 11 |
| Product | Purple | #8B5CF6 | 💜 | 9 |
| Leadership | Gold | #F59E0B | 🏆 | 14 |
| Operations | Teal | #14B8A6 | 🌊 | 6 |
| Research | Orange | #F97316 | 🔶 | 7 |
| AI/Automation | Indigo | #6366F1 | 🧠 | 9 |
| Account/CS | Cyan | #06B6D4 | 💙 | 8 |

**Usage**: Colors appear in documentation, CLI output, and visual tools for quick team identification.

---

## How Agents Work Together

### Skill-Agent Coordination

**Core agents** integrate with autonomous skills for comprehensive analysis:

Example (from refactor-expert):
```
1. [Invoke code-reviewer skill] - Quick code smell detection
2. [Invoke test-generator skill] - Test coverage check
3. Expert refactoring analysis - Deep architectural improvements
```

**Skill Usage Statistics**:
- code-reviewer skill: 5 core agents
- test-generator skill: 5 core agents
- security-auditor skill: 3 core agents
- All other skills: 1-2 agents each

---

### Agent-to-Agent Collaboration

**Strategic agents** coordinate with specialists:

Example (from systems-architect):
```
@systems-architect → May coordinate with:
  - @security-auditor (security architecture)
  - @performance-tuner (scalability validation)
  - @backend-architect (API design)
  - @cloud-architect (infrastructure)
  - @test-engineer (testability)
```

---

### Intentional Duplicate Agents

**3 agents exist in multiple locations** for different contexts:

1. **tutorial-engineer**
   - engineering/documentation: Technical tutorials and code documentation
   - marketing/content: Educational marketing content and user guides

2. **infrastructure-maintainer**
   - engineering/devops: Technical infrastructure (servers, containers, networking)
   - operations/infrastructure: Business operations infrastructure and monitoring

3. **customer-support**
   - account-customer-success/support: Direct customer support interactions
   - operations/support: Support operations, processes, and analytics

**All duplicates are intentional** - same name, different specialized contexts.

---

## Cross-Team Collaboration

### Engineering + Design

**UI Feature Development**:
```bash
@ux-researcher → User research
@ui-designer → UI design specifications
@frontend-developer → Implementation
@test-engineer → Quality assurance
```

**Design System Creation**:
```bash
@ui-designer → Component designs
@frontend-developer → Component library
@docs-writer → Documentation
@test-engineer → Visual regression tests
```

---

### Product + Marketing

**Feature Launch**:
```bash
@product-manager → Plan launch
@prd-writer → Requirements
@content-creator → Launch content
@growth-hacker → Growth strategy
@analytics-reporter → Success metrics
```

---

### Leadership + Operations

**Strategic Planning**:
```bash
@business-strategist → Strategy
@financial-analyst → Budget
@analytics-reporter → Operational data
@infrastructure-maintainer → Capacity assessment
```

---

## Agent Directory Structure

```
subagents/
├── core/ (8 agents)
├── engineering/ (54 agents in 12 subcategories)
├── design/ (7 agents in 4 subcategories)
├── marketing/ (11 agents in 4 subcategories)
├── product/ (9 agents in 4 subcategories)
├── leadership/ (14 agents in 4 subcategories)
├── operations/ (6 agents in 3 subcategories)
├── research/ (7 agents in 2 subcategories)
├── ai-automation/ (9 agents in 4 subcategories)
└── account-customer-success/ (8 agents in 4 subcategories)
```

**Total**: 10 categories, 40+ subcategories, 133 subagents

---

## Finding the Right Agent

### By Task Type

| Need | Agent(s) | Category |
|------|----------|----------|
| **System Design** | @systems-architect | Core |
| **Code Review** | @config-safety-reviewer | Core |
| **Debugging** | @root-cause-analyzer | Core |
| **Security** | @security-auditor | Core |
| **Testing** | @test-engineer | Core |
| **Performance** | @performance-tuner | Core |
| **Refactoring** | @refactor-expert | Core |
| **Documentation** | @docs-writer | Core |
| **Backend APIs** | @backend-architect | Engineering |
| **Frontend UI** | @frontend-developer, @ui-designer | Engineering, Design |
| **Mobile Apps** | @ios-developer, @mobile-developer, @flutter-expert | Engineering |
| **Data & ML** | @data-engineer, @ml-engineer, @ai-engineer | Engineering, AI |
| **Product Planning** | @product-manager, @prd-writer | Product |
| **User Research** | @ux-researcher, @experience-analyzer | Design |
| **Content Creation** | @content-creator, @visual-storyteller | Marketing, Design |
| **Financial Analysis** | @financial-analyst, @cost-optimizer | Leadership |
| **Market Research** | @competitive-intelligence, @market-research-analyst | Research |

### By Programming Language

- Python: @python-pro
- JavaScript/TypeScript: @javascript-pro, @typescript-pro
- Java: @java-pro
- Go: @golang-pro
- Rust: @rust-pro
- C/C++: @c-pro, @cpp-pro
- C#: @csharp-pro
- Ruby: @ruby-pro
- PHP: @php-pro
- Scala: @scala-pro
- Elixir: @elixir-pro
- SQL: @sql-pro

### Common Workflows

**Feature Development**:
```
@product-manager → @ui-designer → @backend-architect → 
@frontend-developer → @test-engineer → @docs-writer
```

**Security Audit**:
```
@security-auditor → @security-threat-analyst → 
@test-engineer → @compliance-officer
```

**Performance Optimization**:
```
@performance-tuner → @database-optimizer → 
@infrastructure-maintainer → @analytics-reporter
```

---

## Navigation Tips

### For Software Engineers

**Use Core Agents**:
- @systems-architect - System design
- @config-safety-reviewer - Configuration review
- @security-auditor - Security review
- @test-engineer - Testing strategy
- @performance-tuner - Performance optimization
- @refactor-expert - Code refactoring

**Use Language Specialists**:
- @python-pro, @java-pro, @typescript-pro, etc.

**Use Domain Specialists**:
- @backend-architect, @frontend-developer, @mobile-developer
- @database-optimizer, @api-documenter, @graphql-architect

### For Product Teams

**Product Management**:
- @product-manager - Sprint planning, roadmap
- @prd-writer - Requirements documentation
- @sprint-prioritizer - Backlog prioritization

**Product Research**:
- @ux-researcher - User research
- @feedback-synthesizer - User feedback analysis
- @trend-researcher - Market trends

### For Design Teams

**UI/UX**:
- @ui-designer - Interface design
- @ux-researcher - User research
- @experience-analyzer - UX analysis

**Visual & Brand**:
- @visual-storyteller - Visual narratives
- @brand-guardian - Brand consistency
- @whimsy-injector - Delightful design elements

### For Marketing Teams

**Content**:
- @content-creator, @content-marketer
- @tutorial-engineer - Educational content

**Social Media**:
- @instagram-curator, @tiktok-strategist
- @twitter-engager, @reddit-community-builder

**Growth**:
- @growth-hacker, @customer-acquisition

---

## Additional Resources

- **Complete Agent Index**: See `subagents/AGENT-INDEX.md`
- **Category READMEs**: Each category has detailed README in `subagents/{category}/README.md`
- **Technical Reference**: See `TECHNICAL-REFERENCE.md` for developer documentation
- **Project History**: See `PROJECT-HISTORY.md` for development timeline

---

**Version**: 2.6.0
**Last Updated**: November 15, 2025
**Maintained By**: Alireza Rezvani
**License**: MIT
