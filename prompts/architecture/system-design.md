# System Architecture Design Templates

A comprehensive collection of system design prompts for planning scalable, maintainable architectures with evidence-based decision making.

## 🏗️ Microservices Architecture Design

### Purpose
Design a comprehensive microservices architecture with proper service boundaries, communication patterns, and deployment strategies.

### Template
```
Design a microservices architecture for [SYSTEM_TYPE] that needs to handle [SCALE_REQUIREMENTS] with the following business requirements:

**Functional Requirements:**
- [FEATURE_1]: [Description]
- [FEATURE_2]: [Description]
- [FEATURE_3]: [Description]

**Non-Functional Requirements:**
- Scale: [USER_COUNT] concurrent users, [REQUEST_VOLUME] requests/second
- Availability: [UPTIME_REQUIREMENT]
- Latency: [RESPONSE_TIME_TARGET]
- Data Consistency: [CONSISTENCY_REQUIREMENTS]

**Technical Constraints:**
- Technology Stack: [PREFERRED_TECHNOLOGIES]
- Cloud Provider: [AWS/GCP/Azure/Multi-cloud]
- Budget: [BUDGET_CONSTRAINTS]
- Team Size: [DEVELOPMENT_TEAM_SIZE]

Please provide:
1. **Service Decomposition Strategy**
   - Bounded contexts and service boundaries
   - Domain-driven design considerations
   - Data ownership and encapsulation

2. **Communication Patterns**
   - Synchronous vs asynchronous communication
   - API design and versioning strategy
   - Event-driven architecture patterns

3. **Data Architecture**
   - Database per service pattern
   - Data synchronization strategies
   - CQRS and event sourcing considerations

4. **Infrastructure Design**
   - Container orchestration (Kubernetes/Docker Swarm)
   - Service mesh implementation
   - Load balancing and service discovery

5. **Deployment Strategy**
   - CI/CD pipeline design
   - Blue-green vs canary deployments
   - Monitoring and observability stack

6. **Risk Assessment**
   - Failure scenarios and mitigation strategies
   - Performance bottlenecks identification
   - Security considerations and threats

Include architectural diagrams, technology justifications, and implementation roadmap.
```

### Variables
- [SYSTEM_TYPE]: Type of system (e-commerce, social media, fintech, etc.)
- [SCALE_REQUIREMENTS]: Expected scale (users, traffic, data volume)
- [FEATURE_1/2/3]: Core business features to support
- [USER_COUNT]: Number of concurrent users
- [REQUEST_VOLUME]: Requests per second target
- [UPTIME_REQUIREMENT]: Availability target (99.9%, 99.99%, etc.)
- [RESPONSE_TIME_TARGET]: Latency requirements
- [CONSISTENCY_REQUIREMENTS]: Data consistency needs
- [PREFERRED_TECHNOLOGIES]: Technology stack preferences
- [BUDGET_CONSTRAINTS]: Financial limitations
- [DEVELOPMENT_TEAM_SIZE]: Team capacity

### Example
```
Design a microservices architecture for an e-commerce platform that needs to handle high traffic with the following business requirements:

**Functional Requirements:**
- User Management: Registration, authentication, profile management
- Product Catalog: Browse, search, filtering, recommendations
- Order Processing: Cart, checkout, payment, fulfillment tracking
- Inventory Management: Stock tracking, supplier integration
- Customer Support: Help desk, chat, returns processing

**Non-Functional Requirements:**
- Scale: 100,000 concurrent users, 10,000 requests/second during peak
- Availability: 99.99% uptime (52 minutes downtime/year)
- Latency: <200ms API response time, <2s page load time
- Data Consistency: Eventual consistency acceptable for catalog, strong consistency for payments

**Technical Constraints:**
- Technology Stack: Node.js/TypeScript, React, PostgreSQL, Redis
- Cloud Provider: AWS
- Budget: $50,000/month infrastructure
- Team Size: 15 developers across 3 teams
```

### Expected Output
- Service boundary definitions with clear responsibilities
- Communication flow diagrams
- Technology stack recommendations with justifications
- Deployment architecture with scaling strategies
- Risk assessment and mitigation plans

---

## 🎯 Event-Driven Architecture Design

### Purpose
Design event-driven systems with proper event modeling, message flows, and consistency patterns.

### Template
```
Design an event-driven architecture for [BUSINESS_DOMAIN] with the following characteristics:

**Event Sources:**
- [EVENT_SOURCE_1]: [Description of events generated]
- [EVENT_SOURCE_2]: [Description of events generated]
- [EVENT_SOURCE_3]: [Description of events generated]

**Business Processes:**
- [PROCESS_1]: [Workflow description]
- [PROCESS_2]: [Workflow description]
- [PROCESS_3]: [Workflow description]

**Consistency Requirements:**
- [STRICT_CONSISTENCY_AREAS]: Areas requiring immediate consistency
- [EVENTUAL_CONSISTENCY_AREAS]: Areas where eventual consistency is acceptable
- [COMPENSATION_PATTERNS]: Required compensating actions

**Performance Requirements:**
- Event Throughput: [EVENTS_PER_SECOND]
- Processing Latency: [MAX_PROCESSING_TIME]
- Durability: [DATA_LOSS_TOLERANCE]

Please design:
1. **Event Model**
   - Event types and schemas
   - Event versioning strategy
   - Event store design

2. **Message Infrastructure**
   - Event bus/broker selection and configuration
   - Partitioning and scaling strategy
   - Dead letter queue handling

3. **Saga Patterns**
   - Long-running transaction coordination
   - Compensation and rollback strategies
   - State management approaches

4. **CQRS Implementation**
   - Command and query separation
   - Read model optimization
   - Projection strategies

5. **Monitoring & Debugging**
   - Event tracing and correlation
   - Business process monitoring
   - Error handling and recovery
```

### Variables
- [BUSINESS_DOMAIN]: Domain area (finance, logistics, healthcare, etc.)
- [EVENT_SOURCE_1/2/3]: Systems or processes generating events
- [PROCESS_1/2/3]: Business workflows to support
- [EVENTS_PER_SECOND]: Event volume requirements
- [MAX_PROCESSING_TIME]: Latency constraints
- [DATA_LOSS_TOLERANCE]: Durability requirements

---

## 🔄 API Architecture Design

### Purpose
Design comprehensive API architectures including REST, GraphQL, and event-driven APIs with proper versioning and governance.

### Template
```
Design an API architecture for [APPLICATION_TYPE] serving [CLIENT_TYPES] with these requirements:

**API Types Needed:**
- [REST_APIS]: [Description of REST endpoints needed]
- [GRAPHQL_APIS]: [Description of GraphQL schemas needed]
- [STREAMING_APIS]: [Description of real-time data needs]
- [WEBHOOK_APIS]: [Description of event notifications needed]

**Client Requirements:**
- [WEB_APP]: [Specific needs for web application]
- [MOBILE_APP]: [Specific needs for mobile applications]
- [THIRD_PARTY]: [Partner integration requirements]
- [INTERNAL_SERVICES]: [Service-to-service communication needs]

**Technical Requirements:**
- Authentication: [AUTH_METHODS]
- Rate Limiting: [RATE_LIMIT_STRATEGY]
- Caching: [CACHE_REQUIREMENTS]
- Documentation: [DOCS_REQUIREMENTS]

Please provide:
1. **API Design Strategy**
   - Resource modeling and URI design
   - HTTP method usage and status codes
   - Request/response format standards

2. **GraphQL Schema Design**
   - Type definitions and relationships
   - Query optimization strategies
   - Subscription patterns for real-time data

3. **Authentication & Authorization**
   - OAuth2/JWT implementation
   - API key management
   - Fine-grained permissions

4. **Version Management**
   - Versioning strategy (URL, header, content negotiation)
   - Deprecation policies
   - Backward compatibility approaches

5. **Performance Optimization**
   - Caching strategies (HTTP cache, application cache)
   - Rate limiting and throttling
   - Pagination and filtering patterns

6. **Documentation & Developer Experience**
   - OpenAPI specification
   - Interactive documentation
   - SDK generation strategy
```

---

## 🛡️ Security Architecture Design

### Purpose
Design comprehensive security architecture with defense-in-depth principles and threat modeling.

### Template
```
Design a security architecture for [SYSTEM_TYPE] handling [DATA_SENSITIVITY] with these requirements:

**Security Requirements:**
- [COMPLIANCE_STANDARDS]: [GDPR, HIPAA, SOC2, etc.]
- [THREAT_MODEL]: [Key threats and attack vectors]
- [DATA_CLASSIFICATION]: [Public, internal, confidential, restricted]

**Technical Environment:**
- [INFRASTRUCTURE]: [Cloud, on-premise, hybrid]
- [USER_BASE]: [Internal users, external customers, partners]
- [INTEGRATION_POINTS]: [Third-party services and APIs]

Please design:
1. **Identity & Access Management**
   - Authentication mechanisms
   - Authorization models (RBAC, ABAC)
   - Single sign-on (SSO) strategy

2. **Data Protection**
   - Encryption at rest and in transit
   - Key management strategy
   - Data loss prevention (DLP)

3. **Network Security**
   - Network segmentation
   - Firewall rules and WAF configuration
   - VPN and secure communication channels

4. **Application Security**
   - Secure coding practices
   - Input validation and output encoding
   - Session management

5. **Monitoring & Incident Response**
   - Security event monitoring (SIEM)
   - Threat detection and response
   - Audit logging and compliance reporting

6. **Business Continuity**
   - Backup and disaster recovery
   - High availability design
   - Incident response procedures
```

---

## 📊 Data Architecture Design

### Purpose
Design scalable data architecture including data lakes, warehouses, and real-time processing pipelines.

### Template
```
Design a data architecture for [BUSINESS_DOMAIN] with the following data characteristics:

**Data Sources:**
- [TRANSACTIONAL_DATA]: [Volume, velocity, variety]
- [STREAMING_DATA]: [Real-time data streams]
- [EXTERNAL_DATA]: [Third-party data sources]
- [UNSTRUCTURED_DATA]: [Documents, images, logs]

**Use Cases:**
- [ANALYTICS_REQUIREMENTS]: [Reporting and BI needs]
- [ML_REQUIREMENTS]: [Machine learning and AI use cases]
- [OPERATIONAL_REQUIREMENTS]: [Real-time operational needs]

Please design:
1. **Data Storage Strategy**
   - Data lake vs data warehouse approach
   - Storage formats and compression
   - Partitioning and indexing strategies

2. **Data Processing Pipeline**
   - Batch processing workflows
   - Stream processing architecture
   - ETL/ELT patterns and tools

3. **Data Governance**
   - Data catalog and metadata management
   - Data quality monitoring
   - Privacy and compliance controls

4. **Analytics & ML Platform**
   - Feature store design
   - Model training and deployment
   - A/B testing infrastructure

5. **Performance & Scalability**
   - Query optimization strategies
   - Caching and materialized views
   - Auto-scaling policies
```

---

## 🚀 Performance Architecture Design

### Purpose
Design high-performance architectures with optimization strategies for latency, throughput, and scalability.

### Template
```
Design a performance-optimized architecture for [SYSTEM_TYPE] with these performance requirements:

**Performance Targets:**
- [LATENCY_REQUIREMENTS]: [Response time targets]
- [THROUGHPUT_REQUIREMENTS]: [Requests per second]
- [SCALABILITY_REQUIREMENTS]: [Growth projections]
- [AVAILABILITY_REQUIREMENTS]: [Uptime targets]

**Performance Constraints:**
- [BUDGET_CONSTRAINTS]: [Infrastructure cost limits]
- [TECHNICAL_CONSTRAINTS]: [Technology limitations]
- [GEOGRAPHICAL_CONSTRAINTS]: [Global distribution requirements]

Please provide:
1. **Caching Strategy**
   - Multi-layer caching architecture
   - Cache invalidation patterns
   - CDN integration strategy

2. **Database Optimization**
   - Read replica configuration
   - Sharding and partitioning
   - Query optimization techniques

3. **Load Balancing & Scaling**
   - Horizontal vs vertical scaling strategies
   - Auto-scaling policies
   - Load balancer configuration

4. **Performance Monitoring**
   - Key performance indicators (KPIs)
   - Real-time monitoring dashboards
   - Performance alerting thresholds

5. **Optimization Techniques**
   - Code-level optimizations
   - Infrastructure optimizations
   - Network performance tuning
```

## 🎨 Usage Guidelines

### 1. Choose the Right Template
- **Microservices**: For distributed system design
- **Event-Driven**: For asynchronous, loosely-coupled systems
- **API Architecture**: For service interface design
- **Security**: For comprehensive security planning
- **Data Architecture**: For data-intensive applications
- **Performance**: For high-performance requirements

### 2. Customize Variables
- Replace [BRACKETED_VARIABLES] with your specific requirements
- Provide realistic scale and performance numbers
- Include actual technology preferences and constraints

### 3. Iterate and Refine
- Start with high-level design
- Drill down into specific components
- Validate assumptions with prototypes
- Get feedback from stakeholders

### 4. Document Decisions
- Record architectural decisions and rationale
- Update designs as requirements evolve
- Maintain architecture decision records (ADRs)

Focus on creating architectures that are not just technically sound, but also economically viable and organizationally sustainable.