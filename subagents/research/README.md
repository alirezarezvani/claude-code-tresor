# Research Team Agents 🔶

> **Team Color**: Orange (#F97316)
>
> **Category**: Research
> **Total Agents**: 7 specialists

---

## Overview

The Research team agents provide comprehensive expertise in market research, competitive intelligence, and data analysis. These agents help make informed strategic decisions through systematic investigation, market analysis, and comprehensive research methodologies.

### Team Specializations

- **Market Research** - Market intelligence, competitive analysis, business model research, TAM sizing
- **Data Research** - Deep research, systematic investigation, web search expertise

---

## Subcategories

### 1. Market Research

**Path**: `subagents/research/market/`

**Agents**:
- market-research-analyst - Comprehensive market intelligence, competitive analysis, industry trends, business research
- competitive-intelligence - Comprehensive competitive analysis and market positioning insights with competitor mapping, feature benchmarking
- business-model-analyzer - Research monetization strategies, analyze business models, evaluate pricing approaches
- tam-market-sizing - Comprehensive market sizing analysis, total addressable market (TAM) calculations, market opportunity assessment
- reddit-intelligence - Analyze Reddit communities for market intelligence, user sentiment, pain point extraction, trend identification

**Use Cases**:
- Market opportunity assessment
- Competitive landscape analysis
- Industry trend identification
- Competitor feature benchmarking
- Business model research and analysis
- Pricing strategy research
- TAM/SAM/SOM calculations
- Market segmentation analysis
- User sentiment analysis from communities
- Pain point identification
- Trend detection and validation
- Go-to-market strategy research

---

### 2. Data Research

**Path**: `subagents/research/data/`

**Agents**:
- deep-research-specialist - Conduct systematic, comprehensive investigations on complex topics requiring multi-source validation
- search-specialist - Expert web researcher using advanced search techniques, query optimization, domain filtering

**Use Cases**:
- Systematic research on complex topics
- Multi-source data validation
- Academic and technical research
- Comprehensive literature reviews
- Advanced web search and discovery
- Query optimization and refinement
- Domain-specific research
- Information synthesis and analysis
- Fact-checking and verification
- Research report creation

---

## Usage Examples

### Market Opportunity Assessment

```bash
@market-research-analyst Analyze the market opportunity for AI-powered developer tools

# Agent will provide:
# - Market size estimation (TAM/SAM/SOM)
# - Industry trends and growth projections
# - Key market segments
# - Customer personas and needs
# - Regulatory considerations
# - Market entry barriers
# - Competitive landscape overview
# - Strategic recommendations
```

### Competitive Intelligence

```bash
@competitive-intelligence Analyze our top 5 competitors in the SaaS analytics space

# Agent will:
# - Create competitor matrix
# - Feature-by-feature comparison
# - Pricing analysis and positioning
# - Technology stack investigation
# - Market positioning assessment
# - Strengths and weaknesses analysis
# - Differentiation opportunities
# - Strategic recommendations
```

### Business Model Research

```bash
@business-model-analyzer Research monetization strategies for developer platforms

# Agent will:
# - Analyze successful business models
# - Compare pricing approaches (freemium, usage-based, tiered)
# - Evaluate monetization tactics
# - Assess revenue potential
# - Identify pricing psychology factors
# - Recommend optimal strategy
# - Provide case studies and examples
```

### Market Sizing

```bash
@tam-market-sizing Calculate TAM for our B2B SaaS product targeting mid-market

# Agent will:
# - Define target market segments
# - Calculate TAM (Total Addressable Market)
# - Calculate SAM (Serviceable Available Market)
# - Calculate SOM (Serviceable Obtainable Market)
# - Apply top-down and bottom-up approaches
# - Validate with multiple data sources
# - Provide growth projections
# - Document assumptions and methodology
```

### Community Intelligence

```bash
@reddit-intelligence Analyze Reddit discussions about project management tools

# Agent will:
# - Identify relevant subreddits
# - Extract user pain points
# - Analyze sentiment and preferences
# - Identify feature requests
# - Track trending topics
# - Map user personas
# - Discover unmet needs
# - Provide actionable insights
```

### Deep Research Investigation

```bash
@deep-research-specialist Research best practices for implementing RAG systems

# Agent will:
# - Conduct comprehensive literature review
# - Analyze academic papers and whitepapers
# - Review case studies and implementations
# - Validate information across sources
# - Synthesize findings and insights
# - Create structured research report
# - Provide implementation recommendations
# - Document sources and references
```

### Advanced Web Search

```bash
@search-specialist Find recent case studies on AI adoption in healthcare

# Agent will:
# - Optimize search queries
# - Apply advanced search operators
# - Filter by domain and date
# - Validate source credibility
# - Extract relevant information
# - Synthesize findings
# - Provide structured results
# - Include citations and links
```

---

## Standards Integration

All research agents follow standards from `/standards/` folder:
- **Research Methodologies** - Systematic investigation frameworks, validation protocols
- **Data Analysis** - Statistical methods, data quality standards, citation practices
- **Competitive Analysis** - Competitor tracking frameworks, benchmarking standards
- **Market Research** - Market sizing methodologies, segmentation approaches
- **Reporting** - Research report templates, executive summary formats

---

## Related Categories

- **Leadership** → For business strategy and investment decisions
- **Product** → For product strategy and market fit validation
- **Marketing** → For market positioning and messaging
- **Operations** → For business analytics and metrics
- **AI/Automation** → For AI-powered research and data processing

---

## Color Code

🔶 **Orange (#F97316)** - All research agents use orange for team identification

Use this color in:
- Agent badges
- Documentation
- CLI output
- Visual tools

---

## Quick Reference

**When to Use Research Agents**:
- ✅ Market opportunity assessment
- ✅ Competitive intelligence gathering
- ✅ Business model research
- ✅ Market sizing and TAM calculation
- ✅ Community sentiment analysis
- ✅ Deep technical research
- ✅ Advanced web search and discovery
- ✅ Industry trend identification

**Agent Selection Guide**:
1. **Market research** → @market-research-analyst
2. **Competitive analysis** → @competitive-intelligence
3. **Business models** → @business-model-analyzer
4. **Market sizing** → @tam-market-sizing
5. **Reddit intelligence** → @reddit-intelligence
6. **Deep research** → @deep-research-specialist
7. **Web search** → @search-specialist

---

**See Also**:
- [Agent Inventory](../../docs/AGENT-INVENTORY.md)
- [Agent Index](../AGENT-INDEX.md)
- [Complete Catalog](../README.md)
