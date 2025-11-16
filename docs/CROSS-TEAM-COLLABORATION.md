# Cross-Team Collaboration Guide

> **How agents from different teams work together to accomplish complex tasks**
>
> **Version**: 2.6.0 | **Last Updated**: November 15, 2025

---

## Overview

This guide demonstrates how agents from different teams collaborate to accomplish complex, real-world tasks. Each pattern shows a complete workflow with specific agent invocations, sequencing, and expected outputs.

**Why Cross-Team Collaboration Matters**:
- Complex tasks require diverse expertise
- Sequential workflows build on each agent's strengths
- Proper sequencing ensures quality and efficiency
- Context sharing improves final outcomes

---

## 🔵 Engineering + 🎨 Design Collaboration

### Pattern 1: UI Feature Development

**Scenario**: Building a new dashboard interface for a SaaS analytics platform

**Teams**: Design + Engineering
**Duration**: 2-3 weeks
**Complexity**: Medium

**Workflow**:

```bash
# Step 1: UX Research (Design)
@ux-researcher Conduct user research for analytics dashboard - understand user needs and pain points

# Output: User personas, journey maps, usability requirements

# Step 2: UI Design (Design)
@ui-designer Create dashboard UI design with data visualizations, dark mode, and responsive layout

# Output: Figma designs, component specifications, Tailwind class suggestions

# Step 3: Frontend Implementation (Engineering)
@frontend-developer Implement dashboard UI using React and Tailwind. Reference: designs/dashboard.figma

# Output: React components, responsive layout, dark mode implementation

# Step 4: Configuration Review (Engineering)
@config-safety-reviewer Review theme switching configuration and localStorage usage

# Output: Configuration safety report, recommendations

# Step 5: Testing (Engineering)
@test-engineer Create comprehensive tests for dashboard components including dark mode and responsiveness

# Output: Component tests, visual regression tests, accessibility tests
```

**Key Success Factors**:
- ✅ UX research informs design decisions
- ✅ Design specs enable quick implementation
- ✅ Configuration review prevents production issues
- ✅ Testing ensures quality

---

### Pattern 2: Design System Creation

**Scenario**: Creating a comprehensive design system for an e-commerce platform

**Teams**: Design + Engineering
**Duration**: 4-6 weeks
**Complexity**: High

**Workflow**:

```bash
# Phase 1: Research & Foundation (Week 1-2)
@ux-researcher Research design system requirements - analyze existing patterns and user needs
@brand-guardian Define brand guidelines - colors, typography, visual language
@ui-designer Create design tokens and initial component library (buttons, forms, cards)

# Phase 2: Component Development (Week 3-4)
@frontend-developer Build React component library with TypeScript and Storybook
@frontend-ux-specialist Implement accessibility features (WCAG 2.1 AA, keyboard navigation, ARIA)

# Phase 3: Documentation & Testing (Week 5-6)
@docs-writer Create comprehensive component documentation with usage examples
@test-engineer Create visual regression tests and accessibility test suite
@performance-tuner Optimize component bundle size and runtime performance
```

**Deliverables**:
- Design tokens and guidelines
- 30+ React components
- Storybook documentation
- Accessibility compliance
- Test coverage >90%

---

### Pattern 3: Mobile App UI Optimization

**Scenario**: Improving mobile app user interface and performance

**Teams**: Design + Engineering
**Duration**: 1-2 weeks
**Complexity**: Medium

**Workflow**:

```bash
# Step 1: UX Audit
@ux-researcher Conduct usability testing for mobile app - identify friction points

# Step 2: Visual Redesign
@ui-designer Redesign problem areas with mobile-first approach and thumb-friendly interactions

# Step 3: Implementation
@mobile-developer Implement redesigned screens for iOS and Android

# Step 4: Performance
@performance-tuner Optimize mobile app performance - reduce startup time and memory usage

# Step 5: Validation
@ux-researcher Run usability tests on redesigned app - validate improvements
```

**Metrics**: Task completion +25%, App rating improved, Performance +40%

---

## 💜 Product + 🌱 Marketing Collaboration

### Pattern 1: Feature Launch Campaign

**Scenario**: Launching a major new feature with coordinated marketing

**Teams**: Product + Marketing + Engineering
**Duration**: 3-4 weeks
**Complexity**: High

**Workflow**:

```bash
# Pre-Launch Planning (Week 1)
@product-manager Plan feature launch timeline and success metrics
@prd-writer Create comprehensive PRD for "Smart Recommendations" feature
@competitive-intelligence Analyze how competitors position similar features

# Development (Week 2)
@backend-architect Design recommendation engine architecture
@ml-engineer Build recommendation ML model
@test-engineer Create ML model tests and API tests

# Marketing Preparation (Week 3)
@content-creator Write blog post, documentation, and feature announcement
@visual-storyteller Create infographic explaining recommendation engine
@instagram-curator Plan social media content calendar for launch week
@twitter-engager Prepare tweet thread explaining feature benefits

# Launch (Week 4)
@product-manager Coordinate launch across all channels
@growth-hacker Execute growth experiments (referral campaign, email sequence)
@analytics-reporter Monitor feature adoption and user engagement metrics
```

**Expected Results**:
- Feature adoption: 40% in first week
- Blog post views: 10K+
- Social media engagement: 5K+ impressions
- User feedback: NPS +15

---

### Pattern 2: Product Positioning Strategy

**Scenario**: Repositioning product in competitive market

**Teams**: Product + Marketing + Research
**Duration**: 2-3 weeks
**Complexity**: Medium

**Workflow**:

```bash
# Research Phase (Week 1)
@competitive-intelligence Conduct comprehensive competitor analysis
@market-research-analyst Analyze market trends and customer segments
@ux-researcher Gather customer feedback and pain points

# Strategy Phase (Week 2)
@product-manager Define new positioning strategy based on research
@business-strategist Create go-to-market strategy and messaging framework

# Execution Phase (Week 3)
@content-creator Develop new messaging across all channels
@growth-hacker Design acquisition campaigns targeting new positioning
@analytics-reporter Set up metrics tracking for positioning effectiveness
```

---

## 🏆 Leadership + 🌊 Operations Collaboration

### Pattern 1: Quarterly Business Planning

**Scenario**: Q1 planning with budget, strategy, and operations alignment

**Teams**: Leadership + Operations + Product
**Duration**: 2 weeks
**Complexity**: High

**Workflow**:

```bash
# Strategic Planning (Week 1)
@business-strategist Develop Q1 strategic objectives and key initiatives
@financial-analyst Create Q1 budget forecast with scenario planning
@risk-assessor Identify strategic and operational risks

# Operational Planning (Week 2)
@product-manager Translate strategy into product roadmap
@analytics-reporter Provide historical performance data and projections
@infrastructure-maintainer Assess infrastructure capacity for Q1 initiatives
@operations-optimizer Identify operational efficiency improvements
```

**Deliverables**:
- Q1 strategic plan with OKRs
- Detailed budget ($2.5M)
- Risk mitigation strategies
- Product roadmap aligned to strategy
- Infrastructure capacity plan

---

### Pattern 2: Cost Optimization Initiative

**Scenario**: Reducing operational costs while maintaining service quality

**Teams**: Leadership + Operations + Engineering
**Duration**: 3-4 weeks
**Complexity**: Medium

**Workflow**:

```bash
# Analysis Phase (Week 1)
@cost-optimizer Analyze current cost structure - identify optimization opportunities
@financial-analyst Calculate ROI for proposed cost-saving initiatives
@infrastructure-maintainer Analyze infrastructure usage and identify waste

# Planning Phase (Week 2)
@business-strategist Prioritize cost optimizations by business impact
@systems-architect Design cost-effective architecture alternatives

# Execution Phase (Week 3-4)
@cloud-architect Optimize cloud infrastructure costs (reserved instances, right-sizing)
@performance-tuner Optimize application performance to reduce resource usage
@analytics-reporter Monitor cost savings and service quality metrics
```

**Expected Savings**: 30% infrastructure costs ($150K/year), maintain 99.9% uptime

---

## 🤝 Multi-Team Workflows

### Pattern 1: Complete Product Development Lifecycle

**Scenario**: Building a new product feature from concept to production

**Teams**: All teams
**Duration**: 6-8 weeks
**Complexity**: Very High

**Workflow**:

```bash
# Discovery & Planning (Week 1-2)
@product-manager Define feature vision and success criteria
@competitive-intelligence Research competitor features and market opportunities
@ux-researcher Conduct user interviews and surveys
@financial-analyst Calculate feature ROI and budget requirements

# Design & Architecture (Week 3)
@systems-architect Design system architecture and technology stack
@ui-designer Create UI designs and component specifications
@security-auditor Define security requirements and threat model
@prd-writer Create comprehensive PRD with technical specifications

# Development (Week 4-5)
@backend-architect Implement backend API and database schema
@frontend-developer Build frontend components and integration
@mobile-developer Create mobile app screens (iOS + Android)

# Quality Assurance (Week 6)
@test-engineer Create comprehensive test suite (unit, integration, E2E)
@security-auditor Conduct security audit and penetration testing
@performance-tuner Profile and optimize application performance
@config-safety-reviewer Review all configuration for production safety

# Launch Preparation (Week 7)
@docs-writer Create user documentation and API documentation
@content-creator Write blog post and social media content
@visual-storyteller Create product demo video and infographics

# Launch & Growth (Week 8)
@product-manager Coordinate feature launch
@growth-hacker Execute growth campaigns and A/B tests
@analytics-reporter Monitor adoption metrics and user behavior
@customer-success-manager Create customer onboarding materials
```

**Deliverables**:
- Complete feature in production
- Comprehensive documentation
- Marketing materials
- Success metrics tracking
- User adoption plan

---

### Pattern 2: Incident Response & Recovery

**Scenario**: Critical production incident requiring cross-functional response

**Teams**: Engineering + Product + Operations + Leadership
**Duration**: Hours to days
**Complexity**: Critical

**Workflow**:

```bash
# Immediate Response (Hour 1)
@product-manager Assess business impact and coordinate response
@root-cause-analyzer Diagnose root cause of production incident
@infrastructure-maintainer Check infrastructure health and capacity

# Mitigation (Hour 2-4)
@backend-architect Design hotfix for critical issue
@security-auditor Assess if incident is security-related or breach
@customer-success-manager Draft customer communication

# Resolution (Hour 4-8)
@test-engineer Validate hotfix with emergency testing
@config-safety-reviewer Review configuration changes
@deployment-engineer Deploy fix to production with rollback plan

# Post-Incident (Day 2-3)
@root-cause-analyzer Create comprehensive RCA report
@docs-writer Document incident timeline and lessons learned
@systems-architect Design prevention measures and monitoring improvements
@business-strategist Assess business impact and customer communication strategy
```

**Success Criteria**: MTTR <4 hours, no data loss, clear communication, prevention measures

---

## Best Practices for Cross-Team Collaboration

### 1. Clear Context Handoffs

**Do This**:
```bash
@frontend-developer Implement user profile page. Context: @ui-designer created designs at designs/profile.figma with dark mode support and mobile-first layout.
```

**Not This**:
```bash
@frontend-developer Build profile page
```

**Why**: Context ensures consistency and reduces back-and-forth

---

### 2. Specify Dependencies

**Do This**:
```bash
# Sequential (dependencies)
@backend-architect Design API (must complete first)
@frontend-developer Implement UI (depends on API spec)
@test-engineer Test integration (depends on both)

# Parallel (independent)
@content-creator Write blog post (parallel)
@visual-storyteller Create graphics (parallel)
```

**Why**: Clear dependencies prevent blocking and enable parallel work

---

### 3. Share Outputs Explicitly

**Do This**:
```bash
@ui-designer Create dashboard design → Output: designs/dashboard.figma

@frontend-developer Implement dashboard using designs/dashboard.figma → Output: src/components/Dashboard/

@test-engineer Test Dashboard components in src/components/Dashboard/ → Output: tests/dashboard.spec.ts
```

**Why**: Explicit outputs enable next agent to find and use work

---

### 4. Define Success Metrics

**Do This**:
```bash
@product-manager Launch feature with success metrics:
- Adoption: 40% users in week 1
- Engagement: 10+ interactions per user
- Performance: <2s page load
- Quality: <1% error rate
```

**Why**: Measurable goals align all teams

---

## Common Collaboration Scenarios

### Scenario 1: "I need to build a new feature"

**Start With**:
1. @product-manager - Define requirements
2. @ux-researcher - Understand users
3. @ui-designer - Design interface

**Then**:
4. @backend-architect - Design API
5. @frontend-developer - Implement UI
6. @test-engineer - Ensure quality

**Finally**:
7. @docs-writer - Document
8. @content-creator - Announce
9. @analytics-reporter - Monitor

---

### Scenario 2: "I need to improve security"

**Start With**:
1. @security-auditor - Audit current security
2. @security-threat-analyst - Model threats

**Then**:
3. @systems-architect - Design secure architecture
4. @backend-architect - Implement security measures

**Finally**:
5. @test-engineer - Security testing
6. @compliance-officer - Verify compliance

---

### Scenario 3: "I need to optimize performance"

**Start With**:
1. @performance-tuner - Profile application
2. @analytics-reporter - Analyze usage patterns

**Then**:
3. @backend-architect - Optimize backend
4. @frontend-developer - Optimize frontend
5. @database-optimizer - Optimize queries

**Finally**:
6. @infrastructure-maintainer - Scale infrastructure
7. @test-engineer - Performance testing

---

## Agent Sequencing Guide

### Sequential Execution (Order Matters)

Use when one agent's output feeds into next agent:

```
Research → Design → Implement → Test → Deploy → Monitor
@ux-researcher → @ui-designer → @frontend-developer → @test-engineer → @deployment-engineer → @analytics-reporter
```

---

### Parallel Execution (Independent Work)

Use when agents work on different aspects simultaneously:

```
Backend Development || Frontend Development || Content Creation
@backend-architect || @frontend-developer || @content-creator
        ↓                    ↓                      ↓
   Backend API         Frontend UI          Marketing Materials
```

---

### Iterative Execution (Feedback Loops)

Use when agents review and refine each other's work:

```
Design → Review → Refine → Review → Approve
@ui-designer → @ux-researcher → @ui-designer → @frontend-ux-specialist → @product-manager
```

---

## Team Combination Matrix

| Primary Team | Works Best With | Common Workflows |
|--------------|-----------------|------------------|
| **Engineering** | Design, Product, Operations | Feature development, system optimization, incident response |
| **Design** | Engineering, Product, Marketing | UI/UX design, design systems, brand guidelines |
| **Marketing** | Product, Design, Research | Feature launches, content creation, growth campaigns |
| **Product** | Engineering, Design, Marketing | Feature planning, roadmap development, launch coordination |
| **Leadership** | Operations, Product, Research | Strategic planning, budget allocation, risk assessment |
| **Operations** | Leadership, Engineering, Product | Capacity planning, monitoring, optimization |
| **Research** | Product, Marketing, Leadership | Market analysis, user research, competitive intelligence |
| **AI/Automation** | Engineering, Product, Operations | ML features, automation workflows, intelligent systems |
| **Account/CS** | Product, Operations, Marketing | Customer success, account growth, support optimization |

---

## Quick Reference Workflows

### 🚀 Feature Development
```
@product-manager → @ui-designer → @backend-architect → @frontend-developer → @test-engineer → @docs-writer → @content-creator
```

### 🔒 Security Audit
```
@security-auditor → @security-threat-analyst → @systems-architect → @test-engineer → @compliance-officer
```

### 📈 Performance Optimization
```
@performance-tuner → @database-optimizer → @backend-architect → @infrastructure-maintainer → @analytics-reporter
```

### 🎨 Design System
```
@ux-researcher → @ui-designer → @frontend-developer → @docs-writer → @test-engineer
```

### 📊 Strategic Planning
```
@business-strategist → @financial-analyst → @product-manager → @analytics-reporter → @infrastructure-maintainer
```

### 🚀 Product Launch
```
@product-manager → @content-creator → @visual-storyteller → @growth-hacker → @analytics-reporter
```

---

## Best Practices

### 1. Start with Planning Agents

**Always begin with**:
- @product-manager for product planning
- @business-strategist for strategic planning
- @systems-architect for architecture planning
- @ux-researcher for user research

**Why**: Proper planning prevents rework and ensures alignment

---

### 2. Review Before Production

**Always review with**:
- @config-safety-reviewer for configuration
- @security-auditor for security
- @performance-tuner for performance
- @test-engineer for quality

**Why**: Catch issues before they reach users

---

### 3. Document Everything

**Always document with**:
- @docs-writer for technical documentation
- @prd-writer for requirements
- @content-creator for user-facing content

**Why**: Documentation enables future work and user adoption

---

### 4. Monitor and Optimize

**Always monitor with**:
- @analytics-reporter for usage metrics
- @infrastructure-maintainer for system health
- @customer-success-manager for user feedback

**Why**: Continuous improvement requires continuous measurement

---

## Anti-Patterns to Avoid

### ❌ Skipping Planning

**Bad**:
```bash
@frontend-developer Build dashboard  # No design, no requirements
```

**Good**:
```bash
@product-manager Define dashboard requirements
@ui-designer Create dashboard design
@frontend-developer Implement dashboard from design specs
```

---

### ❌ No Review Before Production

**Bad**:
```bash
@backend-architect Build API
# Deploy to production immediately
```

**Good**:
```bash
@backend-architect Build API
@security-auditor Review API for vulnerabilities
@performance-tuner Optimize API performance
@test-engineer Create comprehensive tests
# Then deploy
```

---

### ❌ Missing Context

**Bad**:
```bash
@test-engineer Create tests
```

**Good**:
```bash
@test-engineer Create tests for user authentication API in src/auth/. Reference: @backend-architect implemented OAuth2 flow with JWT tokens.
```

---

## Example: Complete E-Commerce Feature

**Feature**: Add "Buy Now, Pay Later" payment option

**Full Workflow**:

```bash
# Week 1: Planning & Research
@product-manager Evaluate BNPL feature - market demand, competitive landscape
@financial-analyst Calculate ROI for BNPL integration (processing fees, adoption rate)
@competitive-intelligence Research competitor BNPL implementations (Affirm, Klarna, Afterpay)
@legal-advisor Review BNPL legal requirements and disclosures

# Week 2: Design & Architecture
@systems-architect Design BNPL architecture - payment flow, risk assessment, data model
@ui-designer Create BNPL checkout UI with payment plan selection
@backend-architect Design BNPL API integration with Affirm/Klarna
@security-auditor Review BNPL security requirements and PCI compliance

# Week 3: Development
@backend-architect Implement BNPL API integration and webhook handling
@frontend-developer Build BNPL checkout UI with plan selection
@payment-integration Integrate Affirm SDK and configure payment flows
@database-optimizer Design efficient BNPL transaction tracking

# Week 4: Testing & Review
@test-engineer Create comprehensive BNPL test suite (happy path, edge cases, failures)
@security-auditor Audit BNPL implementation for security vulnerabilities
@performance-tuner Optimize BNPL checkout performance (<2s)
@config-safety-reviewer Review BNPL configuration (API keys, rate limits, timeouts)

# Week 5: Launch Preparation
@docs-writer Create BNPL documentation (user guide, API docs, troubleshooting)
@prd-writer Document BNPL requirements and acceptance criteria
@content-creator Write blog post: "Introducing Buy Now, Pay Later"
@visual-storyteller Create infographic explaining BNPL benefits

# Week 6: Launch & Monitor
@product-manager Coordinate BNPL launch
@growth-hacker Run BNPL adoption campaign (email, social media)
@analytics-reporter Monitor BNPL adoption, conversion rates, average order value
@customer-success-manager Create BNPL support documentation and FAQs
@financial-analyst Track BNPL revenue impact and processing costs
```

**Expected Results**:
- BNPL adoption: 25% of transactions in Month 1
- Average order value: +40% for BNPL orders
- Conversion rate: +15% overall
- Customer satisfaction: NPS +10

---

## Related Documentation

- [Agent Dependencies](AGENT-DEPENDENCIES.md) - Detailed agent relationships
- [Agent Categorization](AGENT-CATEGORIZATION.md) - Team organization
- [Agent Index](../subagents/AGENT-INDEX.md) - Complete agent catalog
- [Getting Started](../GETTING-STARTED.md) - Basic agent usage

---

## Quick Tips

💡 **Tip 1**: Use product/project management agents to orchestrate complex workflows
   - @product-manager for product features
   - @studio-producer for multi-team projects
   - @project-shipper for launch coordination

💡 **Tip 2**: Always validate with security, performance, and testing
   - @security-auditor before production
   - @performance-tuner before launch
   - @test-engineer throughout development

💡 **Tip 3**: Document as you go, not at the end
   - @docs-writer during development
   - @prd-writer during planning
   - @content-creator during feature development

---

**Created**: November 15, 2025
**Version**: 2.6.0
**Maintained By**: Claude Code Tresor Team
