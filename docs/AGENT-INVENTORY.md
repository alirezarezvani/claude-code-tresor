# Claude Code Tresor - Complete Agent Inventory

> **Comprehensive catalog of all 137 agents in sources/agents/ directory**
>
> **Last Updated**: November 15, 2025 | **Version**: 2.5.0

---

## Table of Contents

1. [Inventory Summary](#inventory-summary)
2. [Root Level Agents](#root-level-agents-62-agents)
3. [Core Agents](#core-agents-14-agents)
4. [AI Automation Specialists](#ai-automation-specialists-6-agents)
5. [Design Agents](#design-agents-5-agents)
6. [Finance & Strategy](#finance--strategy-7-agents)
7. [Growth & Revenue Operations](#growth--revenue-operations-7-agents)
8. [Marketing Agents](#marketing-agents-7-agents)
9. [Operations Agents](#operations-agents-5-agents)
10. [Market Research Agents](#market-research-agents-5-agents)
11. [Product Agents](#product-agents-3-agents)
12. [Project Management](#project-management-3-agents)
13. [Specialized Agents](#specialized-agents-4-agents)
14. [Testing Agents](#testing-agents-5-agents)
15. [Account Team Agents](#account-team-agents-5-agents)
16. [Quick Reference Tables](#quick-reference-tables)

---

## Inventory Summary

### Total Count: **137 Agents**

| Category | Count | Directory |
|----------|-------|-----------|
| Root Level Agents | 62 | `sources/agents/` |
| Core Agents | 14 | `sources/agents/core/` |
| AI Automation Specialists | 6 | `sources/agents/ai-automation-specialists/` |
| Design Agents | 5 | `sources/agents/design/` |
| Finance & Strategy | 7 | `sources/agents/finance-strategy/` |
| Growth & Revenue Operations | 7 | `sources/agents/growth-revenue-operations/` |
| Marketing Agents | 7 | `sources/agents/marketing/` |
| Operations Agents | 5 | `sources/agents/operations/` |
| Market Research Agents | 5 | `sources/agents/market-research-agents/` |
| Product Agents | 3 | `sources/agents/product/` |
| Project Management | 3 | `sources/agents/project-management/` |
| Specialized Agents | 4 | `sources/agents/specialized-agents/` |
| Testing Agents | 5 | `sources/agents/testing/` |
| Account Team Agents | 5 | `sources/agents/account-team-agents/` |

### Total Size

- **Lines of Code**: 11,533+ lines
- **Total Size**: ~624 KB
- **Average Agent Size**: ~84 lines / ~4.5 KB

### Model Distribution

- **Sonnet** (Default): ~110 agents (80%)
- **Opus** (Complex): ~10 agents (7%)
- **Haiku** (Simple): ~5 agents (4%)
- **Unspecified**: ~12 agents (9%)

---

## Root Level Agents (62 Agents)

**Location**: `sources/agents/`

### Development & Architecture (25 agents)

| # | Agent Name | Model | File Size | Primary Focus |
|---|------------|-------|-----------|---------------|
| 1 | **code-reviewer** | sonnet | 6.0 KB | Configuration security, production reliability |
| 2 | **debugger** | - | 0.8 KB | Debugging specialist, test failures |
| 3 | **security-auditor** | opus | 1.2 KB | Vulnerabilities, JWT, OAuth2, encryption |
| 4 | **test-automator** | - | 1.1 KB | Test suites, unit/integration/e2e |
| 5 | **backend-architect** | sonnet | 1.2 KB | RESTful APIs, microservices, schemas |
| 6 | **frontend-developer** | sonnet | 1.3 KB | React components, layouts, state management |
| 7 | **architect-review** | opus | 1.8 KB | Architectural consistency, SOLID principles |
| 8 | **api-documenter** | - | 1.1 KB | OpenAPI, Swagger, developer docs |
| 9 | **graphql-architect** | sonnet | 1.1 KB | GraphQL schemas, resolvers, federation |
| 10 | **docs-architect** | opus | 3.7 KB | Technical documentation, architecture guides |
| 11 | **cloud-architect** | sonnet | 1.2 KB | AWS/Azure/GCP, infrastructure, cloud costs |
| 12 | **error-detective** | sonnet | 1.3 KB | Error patterns, logs, stack traces |
| 13 | **database-optimizer** | sonnet | 1.2 KB | SQL optimization, indexes, migrations |
| 14 | **database-admin** | sonnet | 1.2 KB | Database operations, backups, replication |
| 15 | **performance-engineer** | - | 1.1 KB | Profiling, bottlenecks, caching |
| 16 | **deployment-engineer** | sonnet | 1.3 KB | CI/CD pipelines, Docker, Kubernetes |
| 17 | **devops-troubleshooter** | sonnet | 1.1 KB | Production debugging, logs, incidents |
| 18 | **incident-responder** | - | 1.9 KB | Production incidents, urgency handling |
| 19 | **network-engineer** | sonnet | 1.2 KB | Network debugging, load balancers, CDN |
| 20 | **terraform-specialist** | sonnet | 1.3 KB | Terraform modules, IaC, state management |
| 21 | **legacy-modernizer** | - | 1.2 KB | Legacy system refactoring, modernization |
| 22 | **dx-optimizer** | sonnet | 1.5 KB | Developer experience, tooling, workflows |
| 23 | **payment-integration** | sonnet | 1.2 KB | Stripe, PayPal, subscriptions, compliance |
| 24 | **mermaid-expert** | sonnet | 1.2 KB | Mermaid diagrams, flowcharts, ERDs |
| 25 | **ui-ux-designer** | - | 1.2 KB | UI designs, design systems, aesthetics |

### Programming Languages (16 agents)

| # | Agent Name | Model | File Size | Language Focus |
|---|------------|-------|-----------|----------------|
| 26 | **python-pro** | sonnet | 1.3 KB | Idiomatic Python, decorators, async |
| 27 | **javascript-pro** | sonnet | 1.2 KB | ES6+, async patterns, Node.js |
| 28 | **typescript-pro** | sonnet | 1.6 KB | TypeScript, generics, advanced types |
| 29 | **java-pro** | sonnet | 1.4 KB | Modern Java, streams, JVM optimization |
| 30 | **golang-pro** | sonnet | 1.2 KB | Go idioms, goroutines, channels |
| 31 | **rust-pro** | sonnet | 1.2 KB | Rust ownership, lifetimes, safe concurrency |
| 32 | **ruby-pro** | - | 1.3 KB | Ruby, metaprogramming, Rails, gems |
| 33 | **php-pro** | - | 2.1 KB | PHP, modern features, Laravel patterns |
| 34 | **c-pro** | sonnet | 1.2 KB | C language, memory management, systems |
| 35 | **cpp-pro** | sonnet | 1.4 KB | Modern C++, RAII, smart pointers |
| 36 | **csharp-pro** | sonnet | 1.7 KB | C#, records, pattern matching, async |
| 37 | **scala-pro** | - | 5.1 KB | Scala, functional programming, Spark |
| 38 | **elixir-pro** | sonnet | 1.5 KB | Elixir, OTP patterns, Phoenix |
| 39 | **sql-pro** | sonnet | 1.2 KB | Complex SQL, CTEs, window functions |
| 40 | **minecraft-bukkit-pro** | sonnet | 4.5 KB | Minecraft plugins, Bukkit, Spigot |
| 41 | **unity-developer** | - | 1.7 KB | Unity games, optimization, scripting |

### Mobile & Frontend Frameworks (3 agents)

| # | Agent Name | Model | File Size | Framework Focus |
|---|------------|-------|-----------|----------------|
| 42 | **ios-developer** | sonnet | 1.2 KB | Native iOS, SwiftUI, App Store |
| 43 | **mobile-developer** | sonnet | 1.1 KB | React Native, Flutter, native integrations |
| 44 | **flutter-expert** | - | 2.6 KB | Flutter, Dart, state management, animations |

### AI & Machine Learning (4 agents)

| # | Agent Name | Model | File Size | AI/ML Focus |
|---|------------|-------|-----------|-------------|
| 45 | **ai-engineer** | opus | 1.3 KB | LLM applications, RAG systems, prompt engineering |
| 46 | **ml-engineer** | - | 1.1 KB | ML pipelines, model serving, features |
| 47 | **mlops-engineer** | opus | 2.0 KB | ML pipelines, experiment tracking, MLflow |
| 48 | **prompt-engineer** | - | 3.2 KB | Prompt optimization, LLM tuning |

### Data & Research (3 agents)

| # | Agent Name | Model | File Size | Data Focus |
|---|------------|-------|-----------|------------|
| 49 | **data-scientist** | haiku | 0.9 KB | SQL, BigQuery, data analysis |
| 50 | **data-engineer** | sonnet | 1.1 KB | ETL pipelines, data warehouses, Spark |
| 51 | **search-specialist** | haiku | 1.9 KB | Web research, advanced search, verification |

### Business & Strategy (6 agents)

| # | Agent Name | Model | File Size | Business Focus |
|---|------------|-------|-----------|----------------|
| 52 | **business-analyst** | haiku | 0.9 KB | Metrics, KPIs, dashboards, forecasts |
| 53 | **quant-analyst** | opus | 1.3 KB | Financial models, trading strategies, risk |
| 54 | **risk-manager** | opus | 1.4 KB | Portfolio risk, hedging, stop-losses |
| 55 | **legal-advisor** | haiku | 1.9 KB | Legal docs, GDPR, privacy policies |
| 56 | **customer-support** | - | 0.9 KB | Customer support, issue resolution |
| 57 | **sales-automator** | - | 0.9 KB | Sales automation, lead management |

### Content & Documentation (2 agents)

| # | Agent Name | Model | File Size | Content Focus |
|---|------------|-------|-----------|---------------|
| 58 | **content-marketer** | haiku | 1.0 KB | Blog posts, social media, SEO |
| 59 | **tutorial-engineer** | opus | 4.4 KB | Educational content, step-by-step guides |

### Specialized Tools (3 agents)

| # | Agent Name | Model | File Size | Specialization |
|---|------------|-------|-----------|----------------|
| 60 | **reference-builder** | - | 4.75 KB | Reference implementation systems |
| 61 | **context-manager** | - | 2.0 KB | Context management, knowledge handling |
| 62 | **dx-optimizer** | sonnet | 1.5 KB | Developer experience, tooling, workflows |

---

## Core Agents (14 Agents)

**Location**: `sources/agents/core/`

**Purpose**: Foundational/fundamental roles with comprehensive capabilities

| # | Agent Name | Model | Description |
|---|------------|-------|-------------|
| 1 | **senior-software-engineer** | opus | Senior-level engineering expertise across full stack |
| 2 | **backend-reliability-engineer** | sonnet | Backend systems reliability and resilience |
| 3 | **qa-test-engineer** | sonnet | QA specialist with adversarial testing mindset |
| 4 | **security-threat-analyst** | sonnet | Threat modeling and attack pattern analysis |
| 5 | **systems-architect** | sonnet | Long-term system evolution and maintainability |
| 6 | **frontend-ux-specialist** | sonnet | Frontend development with UX focus |
| 7 | **code-analyzer-debugger** | sonnet | Systematic investigation and evidence-based debugging |
| 8 | **code-refactoring-expert** | sonnet | Code smells, incremental improvements, safety |
| 9 | **performance-optimizer** | sonnet | Optimization strategies (measure, optimize, verify) |
| 10 | **deep-research-specialist** | sonnet | In-depth research and analysis |
| 11 | **prd-writer** | sonnet | Product Requirements Document creation |
| 12 | **product-manager-orchestrator** | sonnet | Product management orchestration and strategy |
| 13 | **technical-mentor-guide** | sonnet | Technical mentoring and guidance |
| 14 | **content-marketer-writer** | sonnet | Content marketing and writing |

---

## AI Automation Specialists (6 Agents)

**Location**: `sources/agents/ai-automation-specialists/`

**Suffix**: `-aa`

**Purpose**: AI-powered automation and workflow optimization

| # | Agent Name | Model | Color | Description |
|---|------------|-------|-------|-------------|
| 1 | **ai-workflow-designer-aa** | sonnet | lavender | AI workflow design and automation |
| 2 | **automation-architect-aa** | sonnet | - | Automation architecture and strategy |
| 3 | **integration-specialist-aa** | sonnet | - | System integration with AI focus |
| 4 | **ml-engineer-aa** | sonnet | - | Machine learning engineering for automation |
| 5 | **prompt-engineer-aa** | sonnet | - | Prompt engineering for automation workflows |
| 6 | **workflow-analyst-aa** | sonnet | - | Workflow analysis and optimization |

---

## Design Agents (5 Agents)

**Location**: `sources/agents/design/`

**Purpose**: UI/UX design, visual design, and brand work

| # | Agent Name | Model | Color | Tools | Description |
|---|------------|-------|-------|-------|-------------|
| 1 | **ui-designer** | sonnet | magenta | Write, Read, MultiEdit, WebSearch, WebFetch | User interface design specialist |
| 2 | **ux-researcher** | sonnet | - | - | UX research and user insights |
| 3 | **brand-guardian** | sonnet | - | - | Brand consistency and guidelines |
| 4 | **visual-storyteller** | sonnet | - | - | Visual narrative and storytelling |
| 5 | **whimsy-injector** | sonnet | yellow | Read, Write, MultiEdit, Grep, Glob | Playful design elements and delight |

---

## Finance & Strategy (7 Agents)

**Location**: `sources/agents/finance-strategy/`

**Suffix**: `-fs`

**Purpose**: Financial analysis, strategy, and risk management

| # | Agent Name | Model | Color | Description |
|---|------------|-------|-------|-------------|
| 1 | **financial-analyst-fs** | sonnet | green | Financial analysis and modeling |
| 2 | **cost-optimizer-fs** | sonnet | - | Cost optimization and efficiency |
| 3 | **investment-analyst-fs** | sonnet | - | Investment analysis and recommendations |
| 4 | **pricing-strategist-fs** | sonnet | - | Pricing strategy and optimization |
| 5 | **business-strategist-fs** | sonnet | blue | Business strategy and planning |
| 6 | **compliance-officer-fs** | sonnet | - | Financial compliance and regulations |
| 7 | **risk-assessor-fs** | sonnet | - | Risk assessment and mitigation |

---

## Growth & Revenue Operations (7 Agents)

**Location**: `sources/agents/growth-revenue-operations/`

**Suffix**: `-gr`

**Purpose**: Revenue growth, customer acquisition, and retention

| # | Agent Name | Model | Description |
|---|------------|-------------|
| 1 | **growth-hacker-gr** | sonnet | Growth hacking strategies and tactics |
| 2 | **customer-acquisition-gr** | sonnet | Customer acquisition optimization |
| 3 | **retention-specialist-gr** | sonnet | Customer retention and churn reduction |
| 4 | **revenue-analyst-gr** | sonnet | Revenue analysis and forecasting |
| 5 | **sales-engineer-gr** | sonnet | Technical sales engineering |
| 6 | **operations-optimizer-gr** | sonnet | Operations efficiency and optimization |
| 7 | **partnership-strategist-gr** | sonnet | Partnership development and strategy |

---

## Marketing Agents (7 Agents)

**Location**: `sources/agents/marketing/`

**Purpose**: Content marketing, social media, and growth

| # | Agent Name | Model | Description |
|---|------------|-------------|
| 1 | **growth-hacker** | sonnet | Growth hacking and viral marketing |
| 2 | **content-creator** | sonnet | Content creation across platforms |
| 3 | **instagram-curator** | sonnet | Instagram content strategy |
| 4 | **tiktok-strategist** | sonnet | TikTok content and growth |
| 5 | **twitter-engager** | sonnet | Twitter/X engagement strategy |
| 6 | **reddit-community-builder** | sonnet | Reddit community management |
| 7 | **app-store-optimizer** | sonnet | App Store Optimization (ASO) |

---

## Operations Agents (5 Agents)

**Location**: `sources/agents/operations/`

**Purpose**: Business operations, analytics, and compliance

| # | Agent Name | Model | Color | Tools | Description |
|---|------------|-------|-------|-------|-------------|
| 1 | **analytics-reporter** | sonnet | blue | Write, Read, MultiEdit, WebSearch, Grep | Analytics reporting and insights |
| 2 | **finance-tracker** | sonnet | orange | Write, Read, MultiEdit, WebSearch, Grep | Financial tracking and reporting |
| 3 | **infrastructure-maintainer** | sonnet | purple | Write, Read, MultiEdit, WebSearch, Grep, Bash | Infrastructure maintenance |
| 4 | **legal-compliance-checker** | sonnet | red | Write, Read, MultiEdit, WebSearch, Grep | Legal compliance verification |
| 5 | **support-responder** | sonnet | green | Write, Read, MultiEdit, WebSearch, Grep | Support ticket response |

---

## Market Research Agents (5 Agents)

**Location**: `sources/agents/market-research-agents/`

**Suffix**: `-mx`

**Purpose**: Market intelligence and competitive analysis

| # | Agent Name | Model | Description |
|---|------------|-------------|
| 1 | **competitive-intelligence-mx** | sonnet | Competitive intelligence gathering |
| 2 | **experience-analyzer-mx** | sonnet | Customer experience analysis |
| 3 | **reddit-intelligence-mx** | sonnet | Reddit-based market intelligence |
| 4 | **tam-market-sizing-mx** | sonnet | Total addressable market sizing |
| 5 | **business-model-analyzer-mx** | sonnet | Business model analysis |

---

## Product Agents (3 Agents)

**Location**: `sources/agents/product/`

**Purpose**: Product management and strategy

| # | Agent Name | Model | Color | Tools | Description |
|---|------------|-------|-------|-------|-------------|
| 1 | **feedback-synthesizer** | sonnet | orange | Read, Write, Grep, WebFetch, MultiEdit | User feedback synthesis |
| 2 | **sprint-prioritizer** | sonnet | indigo | Write, Read, TodoWrite, Grep | Sprint planning and prioritization |
| 3 | **trend-researcher** | sonnet | purple | WebSearch, WebFetch, Read, Write, Grep | Trend research and analysis |

---

## Project Management (3 Agents)

**Location**: `sources/agents/project-management/`

**Purpose**: Project coordination and execution

| # | Agent Name | Model | Color | Tools | Description |
|---|------------|-------|-------|-------|-------------|
| 1 | **studio-producer** | sonnet | green | Read, Write, MultiEdit, Grep, Glob, TodoWrite | Studio/project production management |
| 2 | **project-shipper** | sonnet | - | - | Project delivery and shipping |
| 3 | **experiment-tracker** | sonnet | - | - | Experiment tracking and analysis |

---

## Specialized Agents (4 Agents)

**Location**: `sources/agents/specialized-agents/`

**Purpose**: Cross-functional specialized roles

| # | Agent Name | Model | Color | Description |
|---|------------|-------|-------------|
| 1 | **ui-ux-analyst** | sonnet | - | UI/UX analysis and recommendations |
| 2 | **product-requirements-generator** | sonnet | - | PRD generation and refinement |
| 3 | **market-research-analyst** | sonnet | purple | Market research and insights |
| 4 | **content-marketer-writer** | sonnet | pink | Content marketing writing |

---

## Testing Agents (5 Agents)

**Location**: `sources/agents/testing/`

**Purpose**: Testing, QA, and validation

| # | Agent Name | Model | Color | Tools | Description |
|---|------------|-------|-------|-------|-------------|
| 1 | **api-tester** | sonnet | - | - | API testing specialist |
| 2 | **performance-benchmarker** | sonnet | - | - | Performance benchmarking |
| 3 | **test-results-analyzer** | sonnet | - | - | Test results analysis |
| 4 | **tool-evaluator** | sonnet | - | - | Tool evaluation and comparison |
| 5 | **workflow-optimizer** | sonnet | teal | Read, Write, Bash, TodoWrite, MultiEdit, Grep | Workflow optimization |

---

## Account Team Agents (5 Agents)

**Location**: `sources/agents/account-team-agents/`

**Suffix**: `-at` (some)

**Purpose**: Customer-facing roles and account management

| # | Agent Name | Model | Color | Description |
|---|------------|-------|-------------|
| 1 | **account-executive-revenue-at** | sonnet | red | Revenue-focused account management |
| 2 | **customer-success-manager** | sonnet | - | Customer success and onboarding |
| 3 | **customer-support-at** | sonnet | - | Customer support specialist |
| 4 | **product-engineer-at** | sonnet | - | Product engineering for accounts |
| 5 | **managed-services-engineer** | sonnet | - | Managed services delivery |

---

## Quick Reference Tables

### By Model Type

| Model | Count | Use Case |
|-------|-------|----------|
| **sonnet** | ~110 | Default for most agents (cost-effective, good performance) |
| **opus** | ~10 | Complex tasks requiring deep analysis |
| **haiku** | ~5 | Simple/quick tasks |
| **unspecified** | ~12 | Inherit default |

### By File Size

| Size Range | Count | Examples |
|------------|-------|----------|
| **< 1 KB** | 15 | debugger, customer-support, business-analyst |
| **1-2 KB** | 90+ | Most language-specific and domain agents |
| **2-4 KB** | 20+ | flutter-expert, prompt-engineer, tutorial-engineer |
| **4+ KB** | 12+ | code-reviewer, scala-pro, reference-builder, minecraft-bukkit-pro |

### By Tool Assignment

| Tool Set | Count | Examples |
|----------|-------|----------|
| **No explicit tools** | ~115 | Inherits defaults |
| **Write, Read, MultiEdit, WebSearch, Grep** | 10+ | Operations agents |
| **Extended with Bash/TodoWrite** | 5+ | infrastructure-maintainer, studio-producer |
| **WebFetch included** | 6+ | ui-designer, trend-researcher, feedback-synthesizer |

### By Color Assignment

| Color | Count | Use Case |
|-------|-------|----------|
| **blue** | 2 | Analytics, strategy |
| **green** | 3 | Finance, support, production |
| **orange** | 2 | Finance tracking, feedback |
| **purple** | 3 | Infrastructure, research, market analysis |
| **red** | 2 | Compliance, revenue |
| **magenta** | 1 | UI design |
| **pink** | 1 | Content marketing |
| **yellow** | 1 | Whimsy/delight |
| **lavender** | 1 | AI workflow |
| **teal** | 1 | Workflow optimization |
| **indigo** | 1 | Sprint prioritization |
| **None** | ~115 | No color assignment |

---

## Naming Patterns

### Language Specialists (Pattern: `{language}-pro`)
- python-pro, javascript-pro, typescript-pro, java-pro, golang-pro, rust-pro, ruby-pro, php-pro, c-pro, cpp-pro, csharp-pro, scala-pro, elixir-pro, sql-pro

### Role-Based (Pattern: `{role}-{domain}`)
- backend-architect, frontend-developer, cloud-architect, graphql-architect, docs-architect
- deployment-engineer, devops-troubleshooter, network-engineer, performance-engineer

### Function-Based (Pattern: `{action}-{target}`)
- code-reviewer, database-optimizer, error-detective, legacy-modernizer, dx-optimizer

### Categorical Suffixes
- **-aa**: AI automation specialists (6 agents)
- **-fs**: Finance & strategy (7 agents)
- **-gr**: Growth & revenue operations (7 agents)
- **-mx**: Market research (5 agents)
- **-at**: Account team (some agents)

---

## Statistics Summary

### Overall Metrics
- **Total Agents**: 137
- **Total Lines**: 11,533+
- **Total Size**: ~624 KB
- **Average Size**: ~4.5 KB per agent
- **Directories**: 13 (root + 12 subdirectories)

### Distribution
- **Root Level**: 45% (62 agents)
- **Categorized**: 55% (75 agents in subdirectories)

### Specialization
- **General Purpose**: 30% (engineering, architecture, testing)
- **Language-Specific**: 12% (16 language specialists)
- **Business/Operations**: 35% (finance, marketing, operations, product)
- **AI/Automation**: 8% (AI and ML focused)
- **Design/UX**: 4% (design and user experience)
- **Specialized**: 11% (domain-specific niche roles)

---

## File Structure Reference

```
sources/agents/
├── [62 root-level .md files]
├── account-team-agents/
│   └── [5 agents]
├── ai-automation-specialists/
│   └── [6 agents]
├── core/
│   └── [14 agents]
├── design/
│   └── [5 agents]
├── finance-strategy/
│   └── [7 agents]
├── growth-revenue-operations/
│   └── [7 agents]
├── market-research-agents/
│   └── [5 agents]
├── marketing/
│   └── [7 agents]
├── operations/
│   └── [5 agents]
├── product/
│   └── [3 agents]
├── project-management/
│   └── [3 agents]
├── specialized-agents/
│   └── [4 agents]
└── testing/
    └── [5 agents]
```

---

## Next Steps

- See [AGENT-CATEGORIZATION.md](AGENT-CATEGORIZATION.md) for proposed organization
- See [AGENT-DEPENDENCIES.md](AGENT-DEPENDENCIES.md) for agent relationships
- See [DUPLICATE-ANALYSIS.md](DUPLICATE-ANALYSIS.md) for conflict resolution

---

**See Also**:
- [Sub-Agent Structure](SUB-AGENT-STRUCTURE.md)
- [Comparison Analysis](COMPARISON-ANALYSIS.md)
- [Anthropic Reference](ANTHROPIC-REFERENCE.md)
