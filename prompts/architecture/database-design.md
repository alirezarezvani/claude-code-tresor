# Database Architecture Design Templates

Comprehensive database design prompts for creating scalable, performant, and maintainable data architectures with proper modeling and optimization strategies.

## 🗄️ Relational Database Schema Design

### Purpose
Design normalized, performant relational database schemas with proper indexing, constraints, and optimization strategies.

### Template
```
Design a relational database schema for [APPLICATION_DOMAIN] with the following requirements:

**Business Entities:**
- [ENTITY_1]: [Description and key attributes]
- [ENTITY_2]: [Description and key attributes]
- [ENTITY_3]: [Description and key attributes]
- [ENTITY_4]: [Description and key attributes]

**Business Rules:**
- [RULE_1]: [Business constraint or relationship]
- [RULE_2]: [Business constraint or relationship]
- [RULE_3]: [Business constraint or relationship]

**Performance Requirements:**
- Read Operations: [READ_VOLUME] queries/second
- Write Operations: [WRITE_VOLUME] inserts/updates/second
- Data Volume: [DATA_SIZE] records initially, [GROWTH_RATE] growth
- Query Complexity: [QUERY_TYPES] (simple lookups, complex joins, aggregations)

**Technical Constraints:**
- Database System: [POSTGRESQL/MYSQL/SQL_SERVER]
- Storage Budget: [STORAGE_LIMIT]
- Backup/Recovery RTO: [RECOVERY_TIME_OBJECTIVE]
- Compliance: [DATA_COMPLIANCE_REQUIREMENTS]

Please provide:
1. **Entity-Relationship Design**
   - Complete ERD with all entities and relationships
   - Primary and foreign key definitions
   - Cardinality specifications
   - Business rule enforcement through constraints

2. **Table Schema Definitions**
   - DDL statements with appropriate data types
   - Check constraints and validation rules
   - Trigger implementations for business logic
   - Audit trail and soft delete strategies

3. **Indexing Strategy**
   - Primary and unique indexes
   - Composite indexes for query optimization
   - Partial indexes for filtered queries
   - Index maintenance and monitoring

4. **Performance Optimization**
   - Query execution plan analysis
   - Partitioning strategies for large tables
   - Materialized views for complex aggregations
   - Database configuration recommendations

5. **Data Integrity & Security**
   - Referential integrity constraints
   - Data validation and sanitization
   - Access control and row-level security
   - Encryption for sensitive data

6. **Scalability Planning**
   - Read replica configuration
   - Sharding strategy if needed
   - Connection pooling setup
   - Archive and purge strategies
```

### Variables
- [APPLICATION_DOMAIN]: Domain area (e-commerce, CRM, inventory, etc.)
- [ENTITY_1/2/3/4]: Core business entities
- [RULE_1/2/3]: Business constraints and relationships
- [READ_VOLUME]: Expected read operations per second
- [WRITE_VOLUME]: Expected write operations per second
- [DATA_SIZE]: Initial data volume
- [GROWTH_RATE]: Expected data growth rate
- [QUERY_TYPES]: Types of queries the system will perform
- [STORAGE_LIMIT]: Storage constraints
- [RECOVERY_TIME_OBJECTIVE]: Maximum acceptable downtime

### Example
```
Design a relational database schema for an e-commerce platform with the following requirements:

**Business Entities:**
- Users: Customer accounts with profiles, preferences, and authentication
- Products: Catalog items with variants, pricing, and inventory
- Orders: Purchase transactions with items, payments, and shipping
- Reviews: Customer feedback and ratings for products

**Business Rules:**
- Users can place multiple orders, orders belong to one user
- Orders contain multiple products, products can be in multiple orders
- Users can review products they've purchased
- Product inventory must be tracked and decremented on orders

**Performance Requirements:**
- Read Operations: 1,000 queries/second (browsing, search)
- Write Operations: 100 inserts/updates/second (orders, inventory)
- Data Volume: 1M users, 100K products initially, 20% annual growth
- Query Complexity: Product search with filters, order history, sales analytics

**Technical Constraints:**
- Database System: PostgreSQL 14+
- Storage Budget: 1TB with 100GB monthly growth allowance
- Backup/Recovery RTO: 4 hours maximum downtime
- Compliance: PCI DSS for payment data, GDPR for user data
```

### Expected Output
- Complete ERD with normalized tables
- SQL DDL statements with proper data types and constraints
- Index strategy with performance justifications
- Query examples for common operations
- Scaling and maintenance recommendations

---

## 📊 NoSQL Database Design

### Purpose
Design document, key-value, or graph databases for specific use cases with proper data modeling and access patterns.

### Template
```
Design a [NOSQL_TYPE] database for [USE_CASE] with the following characteristics:

**Data Characteristics:**
- [DATA_STRUCTURE]: [Structured, semi-structured, unstructured]
- [DATA_VOLUME]: [Size estimates and growth projections]
- [DATA_VELOCITY]: [Real-time, batch, streaming]
- [DATA_VARIETY]: [Types of data and formats]

**Access Patterns:**
- [PRIMARY_QUERIES]: [Most frequent query types]
- [SECONDARY_QUERIES]: [Less frequent but important queries]
- [AGGREGATION_NEEDS]: [Analytics and reporting requirements]
- [REAL_TIME_NEEDS]: [Live data requirements]

**Technical Requirements:**
- [CONSISTENCY_MODEL]: [Strong, eventual, session consistency]
- [AVAILABILITY_NEEDS]: [Uptime requirements]
- [PARTITION_TOLERANCE]: [Geographic distribution needs]
- [SCALING_REQUIREMENTS]: [Horizontal scaling expectations]

For [DOCUMENT_STORES/KEY_VALUE/GRAPH] databases, provide:

1. **Data Model Design**
   - Document/record structure and schema
   - Denormalization strategies
   - Embedding vs referencing decisions
   - Data type selection and validation

2. **Collection/Table Organization**
   - Logical data organization
   - Partitioning and sharding keys
   - Index design for query patterns
   - Compound key strategies

3. **Query Optimization**
   - Primary access pattern optimization
   - Secondary index strategies
   - Aggregation pipeline design
   - Full-text search implementation

4. **Consistency & Transactions**
   - Transaction boundaries and scope
   - Eventual consistency handling
   - Conflict resolution strategies
   - Data validation and integrity

5. **Performance Tuning**
   - Read/write optimization
   - Caching strategies
   - Connection pooling
   - Monitoring and alerting

6. **Operations & Maintenance**
   - Backup and restore procedures
   - Data migration strategies
   - Capacity planning
   - Security and access control
```

### NoSQL Database Types
- **Document Stores**: MongoDB, CouchDB, DocumentDB
- **Key-Value**: Redis, DynamoDB, Riak
- **Column Family**: Cassandra, HBase
- **Graph**: Neo4j, Amazon Neptune, ArangoDB

---

## 🔄 Data Warehouse Design

### Purpose
Design data warehouses and data lakes for analytics, reporting, and business intelligence with proper dimensional modeling.

### Template
```
Design a data warehouse for [BUSINESS_DOMAIN] analytics with these requirements:

**Data Sources:**
- [OPERATIONAL_DB_1]: [Description and data volume]
- [OPERATIONAL_DB_2]: [Description and data volume]
- [EXTERNAL_APIS]: [Third-party data sources]
- [FILE_SOURCES]: [CSV, JSON, logs, etc.]

**Analytics Requirements:**
- [REPORTING_NEEDS]: [Daily, weekly, monthly reports]
- [KPI_TRACKING]: [Key performance indicators]
- [HISTORICAL_ANALYSIS]: [Trend analysis requirements]
- [REAL_TIME_ANALYTICS]: [Live dashboard needs]

**Business Dimensions:**
- [TIME_DIMENSION]: [How time affects analysis]
- [GEOGRAPHIC_DIMENSION]: [Location-based analysis]
- [CUSTOMER_DIMENSION]: [Customer segmentation needs]
- [PRODUCT_DIMENSION]: [Product analysis requirements]

Please design:
1. **Dimensional Model**
   - Star or snowflake schema design
   - Fact tables with measures and metrics
   - Dimension tables with hierarchies
   - Slowly changing dimension handling

2. **ETL/ELT Pipeline**
   - Data extraction strategies
   - Transformation and cleansing rules
   - Data quality validation
   - Loading schedules and dependencies

3. **Data Architecture**
   - Staging, ODS, and data mart layers
   - Data lineage and metadata management
   - Data governance and quality controls
   - Archive and retention policies

4. **Performance Optimization**
   - Partitioning strategies
   - Indexing and materialized views
   - Aggregation and pre-calculation
   - Query optimization techniques

5. **Analytics Infrastructure**
   - OLAP cube design
   - Reporting tool integration
   - Self-service analytics capabilities
   - Data visualization requirements

6. **Operational Considerations**
   - Monitoring and alerting
   - Backup and disaster recovery
   - Security and access control
   - Cost optimization strategies
```

---

## 🚀 High-Performance Database Design

### Purpose
Design databases optimized for high-throughput, low-latency applications with advanced performance techniques.

### Template
```
Design a high-performance database for [APPLICATION_TYPE] with these performance requirements:

**Performance Targets:**
- [THROUGHPUT]: [Transactions per second]
- [LATENCY]: [Response time requirements]
- [CONCURRENCY]: [Concurrent user/connection count]
- [AVAILABILITY]: [Uptime requirements]

**Workload Characteristics:**
- [READ_WRITE_RATIO]: [Percentage of reads vs writes]
- [QUERY_COMPLEXITY]: [Simple vs complex operations]
- [DATA_ACCESS_PATTERNS]: [Random vs sequential]
- [PEAK_USAGE_PATTERNS]: [Traffic spikes and patterns]

**Scalability Requirements:**
- [HORIZONTAL_SCALING]: [Multi-node requirements]
- [GEOGRAPHIC_DISTRIBUTION]: [Global deployment needs]
- [ELASTIC_SCALING]: [Auto-scaling requirements]
- [DISASTER_RECOVERY]: [RTO/RPO requirements]

Design optimization strategies for:

1. **Database Engine Optimization**
   - Storage engine selection and tuning
   - Memory allocation and buffer management
   - Connection pooling and threading
   - Configuration parameter optimization

2. **Schema Optimization**
   - Denormalization strategies
   - Partitioning and sharding design
   - Index optimization and maintenance
   - Data type optimization

3. **Query Performance**
   - Query plan optimization
   - Stored procedure design
   - Batch processing strategies
   - Caching layer integration

4. **Storage Optimization**
   - SSD vs HDD configuration
   - RAID configuration
   - Compression strategies
   - Archive tier management

5. **Replication & Distribution**
   - Master-slave replication setup
   - Multi-master configuration
   - Sharding key selection
   - Cross-region replication

6. **Monitoring & Tuning**
   - Performance metrics and KPIs
   - Slow query identification
   - Capacity planning
   - Automated tuning tools
```

---

## 🔐 Database Security Design

### Purpose
Design secure database architectures with comprehensive security controls and compliance measures.

### Template
```
Design a secure database architecture for [APPLICATION_TYPE] handling [DATA_SENSITIVITY] with these security requirements:

**Compliance Requirements:**
- [REGULATORY_COMPLIANCE]: [GDPR, HIPAA, SOX, PCI-DSS]
- [INDUSTRY_STANDARDS]: [ISO 27001, NIST Framework]
- [AUDIT_REQUIREMENTS]: [Logging and reporting needs]

**Threat Model:**
- [EXTERNAL_THREATS]: [Hackers, data breaches]
- [INTERNAL_THREATS]: [Insider threats, privilege abuse]
- [DATA_EXPOSURE_RISKS]: [Backup security, transmission]

**Data Classification:**
- [PUBLIC_DATA]: [Non-sensitive information]
- [INTERNAL_DATA]: [Business confidential]
- [RESTRICTED_DATA]: [PII, financial, health records]

Design security controls for:

1. **Access Control**
   - Role-based access control (RBAC)
   - Attribute-based access control (ABAC)
   - Principle of least privilege
   - Multi-factor authentication integration

2. **Data Protection**
   - Encryption at rest (TDE, column-level)
   - Encryption in transit (TLS/SSL)
   - Key management and rotation
   - Data masking and anonymization

3. **Network Security**
   - Database firewall configuration
   - Network segmentation
   - VPN and private connections
   - Intrusion detection systems

4. **Audit & Monitoring**
   - Database activity monitoring (DAM)
   - Audit trail configuration
   - Real-time threat detection
   - Compliance reporting automation

5. **Backup & Recovery Security**
   - Encrypted backup strategies
   - Secure offsite storage
   - Recovery testing procedures
   - Data retention policies

6. **Application Security**
   - SQL injection prevention
   - Parameterized query enforcement
   - Input validation and sanitization
   - Secure connection management
```

---

## 🌐 Multi-Tenant Database Design

### Purpose
Design database architectures supporting multiple tenants with proper isolation, scalability, and customization.

### Template
```
Design a multi-tenant database for [SAAS_APPLICATION] supporting [TENANT_COUNT] tenants with these requirements:

**Tenancy Requirements:**
- [ISOLATION_LEVEL]: [Shared DB, shared schema, separate schema, separate DB]
- [CUSTOMIZATION_NEEDS]: [Tenant-specific fields, workflows, business rules]
- [TENANT_SIZES]: [Small, medium, enterprise tenant profiles]
- [COMPLIANCE_VARIATIONS]: [Different regulatory requirements per tenant]

**Scalability Requirements:**
- [TENANT_GROWTH]: [New tenant onboarding rate]
- [DATA_GROWTH]: [Per-tenant data growth projections]
- [PERFORMANCE_ISOLATION]: [Preventing tenant interference]

Design patterns for:

1. **Tenancy Model Selection**
   - Shared database, shared schema
   - Shared database, separate schema
   - Separate database per tenant
   - Hybrid approaches for different tenant tiers

2. **Data Isolation Strategies**
   - Row-level security implementation
   - Schema-based separation
   - Application-level filtering
   - Database-level isolation

3. **Tenant Onboarding**
   - Automated provisioning process
   - Schema migration and customization
   - Data seeding and initialization
   - Configuration management

4. **Performance Management**
   - Resource allocation per tenant
   - Query performance isolation
   - Connection pool management
   - Monitoring and alerting per tenant

5. **Backup & Recovery**
   - Tenant-specific backup strategies
   - Point-in-time recovery capabilities
   - Cross-tenant data protection
   - Disaster recovery procedures

6. **Scalability Patterns**
   - Horizontal scaling strategies
   - Tenant migration procedures
   - Load balancing across instances
   - Elastic resource allocation
```

## 🎯 Usage Guidelines

### 1. Select the Right Template
- **Relational**: For ACID compliance, complex relationships
- **NoSQL**: For flexible schema, horizontal scaling
- **Data Warehouse**: For analytics and business intelligence
- **High-Performance**: For extreme scale and speed requirements
- **Security**: For sensitive data and compliance needs
- **Multi-Tenant**: For SaaS applications

### 2. Gather Requirements First
- Understand business rules and constraints
- Identify performance and scalability needs
- Determine compliance and security requirements
- Assess technical constraints and preferences

### 3. Iterate Design Process
- Start with conceptual model
- Refine to logical design
- Optimize physical implementation
- Validate with prototypes and testing

### 4. Consider Operational Aspects
- Monitoring and maintenance procedures
- Backup and disaster recovery
- Capacity planning and scaling
- Security and compliance ongoing requirements

Focus on creating database designs that not only meet current requirements but can evolve with changing business needs while maintaining performance and reliability.