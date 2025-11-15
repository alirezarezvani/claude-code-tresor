# Engineering Team Agents 🔵

> **Team Color**: Blue (#3B82F6)
>
> **Category**: Engineering
> **Total Agents**: 60+ specialists

---

## Overview

The Engineering team agents provide comprehensive technical expertise across all aspects of software development, from backend architecture to frontend implementation, mobile development, DevOps, security, testing, and performance optimization.

### Team Specializations

- **Backend Development** - APIs, microservices, databases
- **Frontend Development** - UI frameworks, state management
- **Mobile Development** - iOS, Android, cross-platform
- **DevOps & Infrastructure** - CI/CD, cloud, containers
- **Security** - Vulnerability assessment, secure coding
- **Testing & QA** - Test automation, quality assurance
- **Data Engineering** - ETL, data pipelines, analytics
- **Language Specialists** - 16+ programming languages
- **Architecture** - System design, technical strategy
- **Code Quality** - Reviews, refactoring, standards
- **Performance** - Profiling, optimization, scalability
- **Debugging** - Root cause analysis, troubleshooting
- **Documentation** - Technical writing, API docs

---

## Quick Navigation

### Core Engineering Agents

Located in `/agents/` (production-ready core agents):

| Agent | Subcategory | Specialization | Invocation |
|-------|-------------|----------------|------------|
| **systems-architect** | Architecture | System design, technology evaluation | `@systems-architect` |
| **config-safety-reviewer** | Code Quality | Configuration safety, production reliability | `@config-safety-reviewer` |
| **root-cause-analyzer** | Debugging | Comprehensive RCA, systematic debugging | `@root-cause-analyzer` |
| **security-auditor** | Security | Strategic security audit, OWASP compliance | `@security-auditor` |
| **test-engineer** | Testing | Comprehensive test strategy | `@test-engineer` |
| **performance-tuner** | Performance | Profiling, optimization | `@performance-tuner` |
| **refactor-expert** | Code Quality | SOLID principles, clean architecture | `@refactor-expert` |
| **docs-writer** | Documentation | Technical documentation, user guides | `@docs-writer` |

---

## Subcategories

### 1. Backend Development

**Path**: `subagents/engineering/backend/`

**Agents**:
- backend-architect
- backend-reliability-engineer
- api-documenter
- graphql-architect
- payment-integration
- database-admin
- database-optimizer
- sql-pro

**Use Cases**:
- RESTful API design
- Microservices architecture
- Database schema design
- GraphQL implementation
- Payment gateway integration
- Database optimization

---

### 2. Frontend Development

**Path**: `subagents/engineering/frontend/`

**Agents**:
- frontend-developer
- frontend-ux-specialist
- javascript-pro
- typescript-pro

**Use Cases**:
- React/Vue/Angular development
- Component architecture
- State management
- Frontend performance
- Responsive design

---

### 3. Mobile Development

**Path**: `subagents/engineering/mobile/`

**Agents**:
- ios-developer
- mobile-developer
- flutter-expert
- unity-developer

**Use Cases**:
- Native iOS development (Swift, SwiftUI)
- Cross-platform development (React Native, Flutter)
- Game development (Unity)
- Mobile app optimization

---

### 4. DevOps & Infrastructure

**Path**: `subagents/engineering/devops/`

**Agents**:
- deployment-engineer
- devops-troubleshooter
- terraform-specialist
- cloud-architect
- network-engineer
- incident-responder
- dx-optimizer
- infrastructure-maintainer

**Use Cases**:
- CI/CD pipeline setup
- Infrastructure as Code (Terraform)
- Cloud architecture (AWS, Azure, GCP)
- Container orchestration (Kubernetes)
- Network configuration
- Incident response
- Developer experience optimization

---

### 5. Security

**Path**: `subagents/engineering/security/`

**Core Agent**: security-auditor (strategic level)

**Skills**:
- security-auditor skill
- secret-scanner skill
- dependency-auditor skill

**Use Cases**:
- OWASP Top 10 vulnerability assessment
- Secure authentication (JWT, OAuth2)
- Threat modeling
- Compliance audits (PCI-DSS, HIPAA, GDPR)
- Security architecture review

---

### 6. Testing & QA

**Path**: `subagents/engineering/testing/`

**Agents**:
- test-engineer (core - comprehensive)
- qa-test-engineer
- test-automator
- api-tester
- performance-benchmarker

**Use Cases**:
- Test strategy and planning
- Unit/integration/E2E testing
- Test automation frameworks
- API contract testing
- Load and performance testing
- QA process optimization

---

### 7. Data Engineering

**Path**: `subagents/engineering/data/`

**Agents**:
- data-engineer
- data-scientist
- database-optimizer

**Use Cases**:
- ETL pipeline design
- Data warehouse architecture
- SQL optimization
- Data analysis and visualization
- Big data processing (Spark, Hadoop)

---

### 8. Language Specialists

**Path**: `subagents/engineering/languages/`

**16 Language Specialists**:
- python-pro
- javascript-pro
- typescript-pro
- java-pro
- golang-pro
- rust-pro
- ruby-pro
- php-pro
- c-pro
- cpp-pro
- csharp-pro
- scala-pro
- elixir-pro
- sql-pro
- minecraft-bukkit-pro

**Use Cases**: Language-specific best practices, idioms, frameworks, and optimization

---

### 9. Architecture

**Path**: `subagents/engineering/architecture/`

**Agents**:
- systems-architect (core)
- architect-review
- docs-architect

**Use Cases**:
- System design and architecture
- Architecture decision records (ADR)
- Technology stack evaluation
- Architectural pattern application
- Long-term technical strategy

---

### 10. Code Quality

**Path**: `subagents/engineering/code-quality/`

**Agents**:
- config-safety-reviewer (core - production safety)
- refactor-expert (core - clean code)
- code-reviewer (sources - general review)

**Use Cases**:
- Configuration safety review
- Code refactoring
- Clean code principles (SOLID, DRY, KISS)
- Technical debt reduction
- Code smell detection

---

### 11. Performance

**Path**: `subagents/engineering/performance/`

**Agents**:
- performance-tuner (core - primary)
- performance-engineer
- database-optimizer
- performance-benchmarker

**Use Cases**:
- Application profiling
- Bottleneck identification
- Performance optimization
- Scalability engineering
- Database query optimization
- Load testing and benchmarking

---

### 12. Debugging

**Path**: `subagents/engineering/debugging/`

**Agents**:
- root-cause-analyzer (core - comprehensive RCA)
- debugger (sources - quick debugging)
- error-detective

**Use Cases**:
- Root cause analysis
- Production incident investigation
- Performance debugging
- Memory leak detection
- Distributed system debugging

---

### 13. Documentation

**Path**: `subagents/engineering/documentation/`

**Agents**:
- docs-writer (core - comprehensive)
- api-documenter
- tutorial-engineer

**Use Cases**:
- API documentation (OpenAPI, Swagger)
- User guides and tutorials
- Architecture documentation
- README creation
- Technical writing

---

## Usage Examples

### System Architecture Design

```bash
@systems-architect Design a scalable e-commerce system for 100k concurrent users

# Agent will provide:
# - System architecture diagram
# - Technology stack recommendations
# - Scalability patterns
# - Database design
# - Caching strategy
# - Infrastructure requirements
```

### Configuration Safety Review

```bash
@config-safety-reviewer Review these database connection pool settings

# Agent will check:
# - Magic numbers (hardcoded values)
# - Pool size configuration
# - Timeout settings
# - Connection limit safety
# - Production risk assessment
```

### Root Cause Analysis

```bash
@root-cause-analyzer Production API is timing out under load

# Agent will:
# - Systematic investigation (5-step RCA)
# - Profiling strategy (CPU, memory, I/O)
# - Hypothesis generation
# - Root cause identification
# - Minimal-impact fix
# - Prevention strategy
```

### Security Audit

```bash
@security-auditor Full security audit of authentication system

# Agent will:
# - Invoke security-auditor skill for quick scan
# - OWASP Top 10 comprehensive analysis
# - Threat modeling
# - Compliance assessment
# - Remediation roadmap
```

### Comprehensive Testing

```bash
@test-engineer Create comprehensive test suite for UserService

# Agent will:
# - Invoke test-generator skill for scaffolding
# - Test strategy (unit, integration, E2E)
# - Test pyramid approach
# - Edge cases and property-based tests
# - Mock/stub recommendations
```

---

## Standards Integration

All engineering agents follow standards from `/standards/` folder:

- **JavaScript/TypeScript** - ESLint, Prettier, best practices
- **Git Workflows** - Conventional commits, branch strategies
- **Code Review** - Review checklists, quality standards
- **Testing** - Test pyramid, coverage standards
- **Security** - Secure coding standards, OWASP guidelines
- **Performance** - Performance budgets, optimization standards

---

## Related Categories

- **Design** → For UI/UX design work
- **Product** → For product requirements and strategy
- **Operations** → For business operations and analytics
- **AI & Automation** → For ML engineering and automation

---

## Color Code

🔵 **Blue (#3B82F6)** - All engineering agents use blue for team identification

Use this color in:
- Agent badges
- Documentation
- CLI output
- Visual tools

---

## Quick Reference

**When to Use Engineering Agents**:
- ✅ Software development tasks
- ✅ Technical architecture decisions
- ✅ Code quality improvements
- ✅ Performance optimization
- ✅ Security audits
- ✅ Testing and QA
- ✅ Infrastructure setup
- ✅ Debugging and troubleshooting

**Agent Selection Guide**:
1. **System design** → @systems-architect
2. **Config safety** → @config-safety-reviewer
3. **Complex bugs** → @root-cause-analyzer
4. **Security** → @security-auditor
5. **Testing** → @test-engineer
6. **Performance** → @performance-tuner
7. **Refactoring** → @refactor-expert
8. **Documentation** → @docs-writer

---

**See Also**:
- [Agent Inventory](../../docs/AGENT-INVENTORY.md)
- [Agent Dependencies](../../docs/AGENT-DEPENDENCIES.md)
- [Sub-Agent Structure](../../docs/SUB-AGENT-STRUCTURE.md)
