# Account & Customer Success Team Agents 💙

> **Team Color**: Cyan (#06B6D4)
>
> **Category**: Account & Customer Success
> **Total Agents**: 8 specialists

---

## Overview

The Account & Customer Success team agents provide comprehensive expertise in account management, customer success, support operations, and sales enablement. These agents help maximize customer value, reduce churn, and drive revenue growth through exceptional customer experiences.

### Team Specializations

- **Account Management** - Strategic account planning, revenue growth, relationship management
- **Customer Success** - Adoption optimization, value realization, retention strategies
- **Support** - Technical support analysis, issue resolution, product enablement
- **Sales** - Sales automation, technical sales support, solution architecture

---

## Subcategories

### 1. Account Management

**Path**: `subagents/account-customer-success/account-management/`

**Agents**:
- account-executive - Strategic account management focused on revenue growth, retention analysis, upsell/cross-sell opportunities
- managed-services-engineer - Ensure product-customer alignment, manage release updates, identify expansion opportunities

**Use Cases**:
- Strategic account planning
- Revenue growth and expansion
- Relationship management and executive alignment
- Retention analysis and risk mitigation
- Upsell and cross-sell opportunity identification
- Contract renewals and negotiations
- Product-customer alignment
- Release and update management
- Success plan development
- Quarterly business reviews (QBRs)

---

### 2. Customer Success

**Path**: `subagents/account-customer-success/customer-success/`

**Agents**:
- customer-success-manager - Analyze customer adoption patterns, assess value realization, plan for expansion, prevent churn
- retention-specialist - Customer retention analysis, churn reduction strategies, loyalty program development, engagement optimization

**Use Cases**:
- Customer onboarding and adoption
- Value realization tracking
- Adoption pattern analysis
- Expansion planning (upsell/cross-sell)
- Churn prediction and prevention
- Customer health scoring
- Retention strategy development
- Loyalty program design
- Engagement optimization
- Success metric tracking (NPS, CSAT, adoption rate)

---

### 3. Support

**Path**: `subagents/account-customer-success/support/`

**Agents**:
- customer-support - Analyze customer support issues, track resolution patterns, identify systemic problems
- product-engineer - Analyze customer use cases, map to product capabilities, identify gaps, provide workarounds

**Use Cases**:
- Support ticket analysis and trending
- Resolution pattern identification
- Systemic issue identification
- Root cause analysis for recurring problems
- Use case analysis and mapping
- Product capability assessment
- Gap analysis and workaround creation
- Technical troubleshooting
- Escalation management
- Support quality optimization

---

### 4. Sales

**Path**: `subagents/account-customer-success/sales/`

**Agents**:
- sales-automator - Draft cold emails, follow-ups, and proposal templates. Creates pricing presentations and ROI calculators
- sales-engineer - Technical sales support, solution architecture, demo preparation, proof-of-concept development

**Use Cases**:
- Sales email automation (cold emails, follow-ups)
- Proposal template creation
- Pricing presentation development
- ROI calculator creation
- Technical sales support
- Solution architecture for prospects
- Custom demo preparation
- Proof-of-concept (POC) development
- Technical discovery and requirements gathering
- Competitive differentiation in sales

---

## Usage Examples

### Strategic Account Management

```bash
@account-executive Develop strategic plan for enterprise account expansion

# Agent will provide:
# - Account health assessment
# - Relationship mapping (stakeholders, champions)
# - Revenue analysis and growth opportunities
# - Upsell/cross-sell recommendations
# - Risk mitigation strategies
# - QBR preparation materials
# - Success metrics and KPIs
# - 90-day action plan
```

### Customer Success Planning

```bash
@customer-success-manager Analyze customer adoption and plan for expansion

# Agent will:
# - Assess product adoption metrics
# - Identify underutilized features
# - Calculate value realization
# - Create adoption improvement plan
# - Identify expansion opportunities
# - Develop success milestones
# - Design engagement strategy
# - Track health score trends
```

### Churn Prevention

```bash
@retention-specialist Analyze churn risk and develop retention strategy

# Agent will:
# - Identify at-risk customers
# - Analyze churn indicators
# - Assess engagement patterns
# - Create retention playbook
# - Design win-back campaigns
# - Develop loyalty programs
# - Optimize onboarding experience
# - Track retention metrics
```

### Support Issue Analysis

```bash
@customer-support Analyze support tickets to identify systemic issues

# Agent will:
# - Aggregate and categorize tickets
# - Identify trending issues
# - Track resolution patterns
# - Perform root cause analysis
# - Recommend product improvements
# - Create knowledge base articles
# - Optimize support workflows
# - Measure support metrics (MTTR, CSAT)
```

### Product Gap Analysis

```bash
@product-engineer Map customer use cases to product capabilities

# Agent will:
# - Analyze customer requirements
# - Map to existing features
# - Identify capability gaps
# - Provide workaround solutions
# - Document enhancement requests
# - Prioritize feature needs
# - Create implementation roadmap
# - Bridge customer-product alignment
```

### Sales Email Automation

```bash
@sales-automator Create cold email sequence for enterprise prospects

# Agent will:
# - Research target persona
# - Craft compelling subject lines
# - Write personalized email templates
# - Design follow-up sequence
# - Create value propositions
# - Include social proof and case studies
# - Add clear CTAs
# - Optimize for response rates
```

### Technical Sales Support

```bash
@sales-engineer Prepare technical demo for enterprise prospect

# Agent will:
# - Conduct technical discovery
# - Map solution to requirements
# - Design demo architecture
# - Prepare demo environment
# - Create technical presentation
# - Develop POC plan
# - Handle technical objections
# - Document integration requirements
```

### Managed Services Operations

```bash
@managed-services-engineer Ensure product alignment for managed accounts

# Agent will:
# - Review product configuration
# - Assess feature utilization
# - Plan release updates
# - Identify optimization opportunities
# - Create expansion roadmap
# - Monitor health metrics
# - Coordinate with product team
# - Document success criteria
```

---

## Standards Integration

All Account & Customer Success agents follow standards from `/standards/` folder:
- **Customer Success** - Health score frameworks, playbook templates, success metrics
- **Account Management** - QBR templates, account planning frameworks, relationship mapping
- **Support Standards** - SLA definitions, ticket categorization, escalation procedures
- **Sales Enablement** - Email templates, proposal formats, demo scripts
- **Communication** - Customer communication guidelines, tone and voice standards

---

## Related Categories

- **Product** → For product strategy and feature requests
- **Marketing** → For customer communication and campaigns
- **Operations** → For support operations and analytics
- **Engineering** → For technical implementation and integrations
- **Leadership** → For strategic account planning and contract negotiations

---

## Color Code

💙 **Cyan (#06B6D4)** - All Account & Customer Success agents use cyan for team identification

Use this color in:
- Agent badges
- Documentation
- CLI output
- Visual tools

---

## Quick Reference

**When to Use Account & Customer Success Agents**:
- ✅ Strategic account planning and growth
- ✅ Customer adoption and value realization
- ✅ Churn prediction and prevention
- ✅ Support issue analysis and resolution
- ✅ Product-customer alignment
- ✅ Sales automation and enablement
- ✅ Technical sales support
- ✅ Relationship management and QBRs

**Agent Selection Guide**:
1. **Account growth** → @account-executive
2. **Product alignment** → @managed-services-engineer
3. **Adoption & expansion** → @customer-success-manager
4. **Retention & churn** → @retention-specialist
5. **Support analysis** → @customer-support
6. **Use case mapping** → @product-engineer
7. **Sales emails** → @sales-automator
8. **Technical sales** → @sales-engineer

---

**See Also**:
- [Agent Inventory](../../docs/AGENT-INVENTORY.md)
- [Agent Index](../AGENT-INDEX.md)
- [Complete Catalog](../README.md)
