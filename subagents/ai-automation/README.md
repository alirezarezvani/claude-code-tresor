# AI & Automation Team Agents 🧠

> **Team Color**: Indigo (#6366F1)
>
> **Category**: AI & Automation
> **Total Agents**: 9 specialists

---

## Overview

The AI & Automation team agents provide comprehensive expertise in artificial intelligence, machine learning, automation architecture, and prompt engineering. These agents help build intelligent systems, automate workflows, and implement cutting-edge AI solutions.

### Team Specializations

- **AI Engineering** - LLM applications, RAG systems, agent orchestration, AI workflow design
- **ML Engineering** - Machine learning models, MLOps, production ML systems
- **Automation** - Enterprise automation, workflow optimization, system integration
- **Prompt Engineering** - LLM optimization, prompt design, AI system enhancement

---

## Subcategories

### 1. AI Engineering

**Path**: `subagents/ai-automation/ai-engineering/`

**Agents**:
- ai-engineer - Build LLM applications, RAG systems, and prompt pipelines. Implements vector search, agent orchestration
- ai-workflow-designer - AI-powered workflow design, intelligent automation, human-AI collaboration optimization

**Use Cases**:
- LLM application development
- RAG (Retrieval Augmented Generation) implementation
- Vector database integration (Pinecone, Weaviate, Milvus)
- Agent orchestration and multi-agent systems
- Prompt pipeline engineering
- AI workflow design and optimization
- Human-AI collaboration systems
- Intelligent automation architecture
- LLM API integration (OpenAI, Anthropic, Cohere)
- Semantic search implementation

---

### 2. ML Engineering

**Path**: `subagents/ai-automation/ml-engineering/`

**Agents**:
- ml-engineer - Machine learning model development, MLOps implementation, production ML systems
- mlops-engineer - ML infrastructure automation, model deployment pipelines, experiment tracking, production monitoring

**Use Cases**:
- Machine learning model development
- Model training and fine-tuning
- MLOps pipeline implementation
- Model deployment and serving
- Experiment tracking (MLflow, Weights & Biases)
- Model monitoring and drift detection
- A/B testing for models
- Feature engineering and selection
- Hyperparameter optimization
- Production ML infrastructure
- Model versioning and registry
- CI/CD for ML systems

---

### 3. Automation

**Path**: `subagents/ai-automation/automation/`

**Agents**:
- automation-architect - Enterprise automation strategy, intelligent automation architecture, RPA implementation
- integration-specialist - API design, system integration, data flow optimization, comprehensive integration strategy
- workflow-analyst - Process mapping, automation opportunity analysis, workflow optimization, efficiency improvement

**Use Cases**:
- Enterprise automation strategy
- RPA (Robotic Process Automation) implementation
- Workflow automation design
- System integration and API orchestration
- Process mapping and analysis
- Automation opportunity identification
- Data flow optimization
- Integration architecture design
- API gateway implementation
- Event-driven automation
- Business process automation
- Workflow efficiency improvement

---

### 4. Prompt Engineering

**Path**: `subagents/ai-automation/prompts/`

**Agents**:
- prompt-engineer - Optimizes prompts for LLMs and AI systems. Use when building AI features, improving agent performance
- prompt-engineer-advanced - Advanced prompt engineering, LLM optimization, AI system architecture, complex prompt patterns

**Use Cases**:
- LLM prompt optimization
- Few-shot learning prompt design
- Chain-of-thought prompting
- System message engineering
- Prompt template creation
- Prompt testing and validation
- Token optimization
- Context management strategies
- Multi-turn conversation design
- Advanced prompt patterns (ReAct, Tree of Thoughts)
- Prompt injection prevention
- Output format engineering

---

## Usage Examples

### Building RAG Applications

```bash
@ai-engineer Build a RAG system for our documentation

# Agent will provide:
# - Vector database setup (Pinecone/Weaviate)
# - Document chunking strategy
# - Embedding model selection
# - Retrieval pipeline implementation
# - LLM integration (GPT-4/Claude)
# - Context optimization
# - Response generation logic
# - Evaluation metrics
```

### AI Workflow Design

```bash
@ai-workflow-designer Design an AI-powered customer support workflow

# Agent will:
# - Map current support process
# - Identify automation opportunities
# - Design multi-agent orchestration
# - Implement human-in-the-loop checkpoints
# - Optimize AI-human handoffs
# - Create escalation logic
# - Define success metrics
# - Build monitoring dashboard
```

### ML Model Development

```bash
@ml-engineer Build a recommendation system for our e-commerce platform

# Agent will:
# - Define recommendation algorithm
# - Design feature engineering pipeline
# - Implement model training
# - Set up A/B testing framework
# - Create model evaluation metrics
# - Optimize for production deployment
# - Handle cold-start problem
# - Implement real-time inference
```

### MLOps Pipeline Implementation

```bash
@mlops-engineer Set up MLOps infrastructure for model deployment

# Agent will:
# - Design CI/CD pipeline for ML
# - Implement model registry
# - Set up experiment tracking (MLflow)
# - Configure model serving (TensorFlow Serving)
# - Implement monitoring and alerting
# - Handle model versioning
# - Set up drift detection
# - Create rollback mechanisms
```

### Enterprise Automation Strategy

```bash
@automation-architect Design enterprise automation strategy for finance department

# Agent will:
# - Assess current manual processes
# - Identify automation opportunities
# - Design RPA implementation roadmap
# - Evaluate automation platforms
# - Calculate ROI and cost savings
# - Plan phased implementation
# - Design governance framework
# - Create change management plan
```

### System Integration

```bash
@integration-specialist Integrate CRM, billing, and support systems

# Agent will:
# - Map data flows between systems
# - Design API integration architecture
# - Implement event-driven patterns
# - Handle data transformation
# - Set up error handling and retry logic
# - Create monitoring and logging
# - Optimize performance
# - Document integration flows
```

### Workflow Analysis

```bash
@workflow-analyst Analyze and optimize our invoice processing workflow

# Agent will:
# - Map current process flow
# - Identify bottlenecks and inefficiencies
# - Calculate time and cost metrics
# - Recommend automation opportunities
# - Design optimized workflow
# - Estimate efficiency gains
# - Create implementation roadmap
# - Define success KPIs
```

### Advanced Prompt Engineering

```bash
@prompt-engineer-advanced Optimize prompts for our AI content generation system

# Agent will:
# - Analyze current prompt performance
# - Implement advanced patterns (ReAct, CoT)
# - Optimize token usage
# - Design few-shot examples
# - Create prompt templates
# - Implement prompt chaining
# - Set up A/B testing
# - Monitor and iterate
```

---

## Standards Integration

All AI & Automation agents follow standards from `/standards/` folder:
- **AI Development** - LLM best practices, prompt engineering standards, safety guidelines
- **ML Engineering** - Model development lifecycle, evaluation metrics, deployment standards
- **MLOps** - CI/CD for ML, model monitoring, versioning practices
- **Automation** - Workflow design patterns, integration standards, error handling
- **Testing** - AI system testing, model validation, prompt testing frameworks

---

## Related Categories

- **Engineering** → For infrastructure and backend implementation
- **Product** → For AI feature planning and product strategy
- **Operations** → For process automation and optimization
- **Research** → For AI research and model selection
- **Leadership** → For AI strategy and ROI analysis

---

## Color Code

🧠 **Indigo (#6366F1)** - All AI & Automation agents use indigo for team identification

Use this color in:
- Agent badges
- Documentation
- CLI output
- Visual tools

---

## Quick Reference

**When to Use AI & Automation Agents**:
- ✅ Building LLM applications and RAG systems
- ✅ Designing AI-powered workflows
- ✅ Developing ML models and pipelines
- ✅ Implementing MLOps infrastructure
- ✅ Enterprise automation strategy
- ✅ System integration and API orchestration
- ✅ Workflow analysis and optimization
- ✅ Prompt engineering and optimization

**Agent Selection Guide**:
1. **LLM applications** → @ai-engineer
2. **AI workflows** → @ai-workflow-designer
3. **ML models** → @ml-engineer
4. **MLOps infrastructure** → @mlops-engineer
5. **Enterprise automation** → @automation-architect
6. **System integration** → @integration-specialist
7. **Workflow optimization** → @workflow-analyst
8. **Basic prompt optimization** → @prompt-engineer
9. **Advanced prompts** → @prompt-engineer-advanced

---

**See Also**:
- [Agent Inventory](../../docs/AGENT-INVENTORY.md)
- [Agent Index](../AGENT-INDEX.md)
- [Complete Catalog](../README.md)
