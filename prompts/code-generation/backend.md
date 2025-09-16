# Backend Code Generation Prompts ⚙️

Comprehensive prompt templates for generating robust, scalable backend code across different languages and frameworks.

## API Development

### REST API Endpoint
```
Create a RESTful API endpoint for [RESOURCE_NAME] using [FRAMEWORK] that:
- Implements [HTTP_METHODS] operations (GET, POST, PUT, DELETE)
- Uses [DATABASE_TYPE] for data persistence
- Has proper request/response validation
- Includes comprehensive error handling
- Has authentication/authorization using [AUTH_STRATEGY]
- Implements rate limiting and security headers
- Uses [LANGUAGE] with [TYPE_SYSTEM] (TypeScript, Python typing, etc.)
- Has proper logging and monitoring

Endpoint structure:
- Base path: [BASE_PATH]
- Resources: [RESOURCE_OPERATIONS]

Data model requirements:
- [MODEL_FIELD_1]: [TYPE] - [DESCRIPTION]
- [MODEL_FIELD_2]: [TYPE] - [DESCRIPTION]
- [MODEL_FIELD_3]: [TYPE] - [DESCRIPTION]

Business logic:
- [BUSINESS_RULE_1]
- [BUSINESS_RULE_2]

Please include:
1. Route handlers with full CRUD operations
2. Data validation schemas
3. Database models/entities
4. Middleware for auth and validation
5. Comprehensive error handling
6. Unit and integration tests
7. API documentation (OpenAPI/Swagger)
8. Logging and monitoring setup
```

**Variables:**
- `[RESOURCE_NAME]`: The API resource (e.g., "users", "products", "orders")
- `[FRAMEWORK]`: Express.js, FastAPI, Django REST, Spring Boot, etc.
- `[HTTP_METHODS]`: Which HTTP methods to implement
- `[DATABASE_TYPE]`: PostgreSQL, MongoDB, MySQL, etc.
- `[AUTH_STRATEGY]`: JWT, OAuth2, API keys, etc.
- `[LANGUAGE]`: JavaScript, Python, Java, C#, etc.
- `[TYPE_SYSTEM]`: TypeScript, Python typing hints, Java types, etc.

**Example:**
```
Create a RESTful API endpoint for products using Express.js that:
- Implements GET, POST, PUT, DELETE operations
- Uses PostgreSQL for data persistence
- Has proper request/response validation
- Includes comprehensive error handling
- Has authentication/authorization using JWT
- Implements rate limiting and security headers
- Uses TypeScript with strict type checking
- Has proper logging and monitoring

Endpoint structure:
- Base path: /api/v1/products
- Resources: CRUD operations with search and filtering

Data model requirements:
- name: string - Product name (required, 2-100 chars)
- price: number - Product price (required, positive)
- category: string - Product category (required, from enum)
- description: string - Product description (optional, max 500 chars)
- inStock: boolean - Availability status (required, default true)

Business logic:
- Products can only be updated by admin users or product owners
- Price changes require approval workflow for discounts > 20%

Please include:
1. Route handlers with full CRUD operations
2. Data validation schemas
3. Database models/entities
4. Middleware for auth and validation
5. Comprehensive error handling
6. Unit and integration tests
7. API documentation (OpenAPI/Swagger)
8. Logging and monitoring setup
```

### GraphQL API Schema
```
Create a GraphQL API for [DOMAIN] using [FRAMEWORK] that:
- Defines schemas for [ENTITY_LIST]
- Implements queries: [QUERY_LIST]
- Implements mutations: [MUTATION_LIST]
- Has proper type definitions and resolvers
- Includes authentication and authorization
- Has error handling with proper GraphQL errors
- Uses [DATABASE_TYPE] with proper data loaders
- Has subscription support for [REAL_TIME_FEATURES]

Schema requirements:
- [ENTITY_1] with fields: [FIELD_LIST]
- [ENTITY_2] with fields: [FIELD_LIST]
- Relationships: [RELATIONSHIP_DESCRIPTIONS]

Performance requirements:
- N+1 query prevention with DataLoader
- Query complexity analysis
- Rate limiting per user
- Caching strategy for frequent queries

Please include:
1. GraphQL schema definitions (SDL)
2. Resolver implementations
3. DataLoader setup for efficient querying
4. Authentication middleware
5. Subscription resolvers
6. Unit tests for resolvers
7. GraphQL Playground setup
8. Performance monitoring
```

### Microservice Architecture
```
Create a microservice for [SERVICE_PURPOSE] that:
- Uses [FRAMEWORK] and [LANGUAGE]
- Implements [SERVICE_RESPONSIBILITIES]
- Communicates via [COMMUNICATION_PATTERN] (REST, gRPC, message queues)
- Has proper service discovery and health checks
- Uses [DATABASE_TYPE] for data persistence
- Has comprehensive logging and metrics
- Includes circuit breaker and retry patterns
- Has proper containerization with Docker

Service boundaries:
- [BOUNDARY_1]: [DESCRIPTION]
- [BOUNDARY_2]: [DESCRIPTION]

Integration points:
- [INTEGRATION_1]: [METHOD] - [PURPOSE]
- [INTEGRATION_2]: [METHOD] - [PURPOSE]

Please include:
1. Service implementation with all endpoints
2. Docker configuration and compose file
3. Health check and readiness probes
4. Service configuration management
5. Inter-service communication setup
6. Monitoring and alerting configuration
7. Unit and integration tests
8. Service documentation and runbook
```

## Database Integration

### Database Layer with ORM
```
Create a database layer using [ORM] for [DATABASE_TYPE] that:
- Defines models for [ENTITY_LIST]
- Has proper relationships and constraints
- Implements [QUERY_PATTERNS] efficiently
- Has database migrations and seeding
- Uses connection pooling and optimization
- Has proper transaction management
- Includes soft deletes and audit trails
- Has comprehensive error handling

Entities to model:
- [ENTITY_1]: [DESCRIPTION] with fields [FIELD_LIST]
- [ENTITY_2]: [DESCRIPTION] with fields [FIELD_LIST]

Relationships:
- [RELATIONSHIP_1]: [TYPE] relationship between [ENTITY_A] and [ENTITY_B]
- [RELATIONSHIP_2]: [TYPE] relationship between [ENTITY_C] and [ENTITY_D]

Performance requirements:
- Query optimization for [COMMON_QUERIES]
- Indexing strategy for [KEY_FIELDS]
- Caching for frequently accessed data

Please include:
1. Model definitions with proper types
2. Migration files for schema creation
3. Seed data for development
4. Repository pattern implementation
5. Query optimization examples
6. Database configuration
7. Connection pooling setup
8. Testing with test database
```

### Database Query Optimization
```
Optimize database queries for [USE_CASE] with [DATABASE_TYPE]:
- Current performance issues: [PERFORMANCE_PROBLEMS]
- Query patterns: [QUERY_PATTERNS]
- Data volume: [DATA_SCALE]
- Performance targets: [PERFORMANCE_GOALS]

Current problematic queries:
[PASTE_SLOW_QUERIES_HERE]

Optimization requirements:
- Reduce query execution time by [IMPROVEMENT_TARGET]
- Improve concurrent user capacity to [USER_SCALE]
- Minimize memory usage during operations
- Maintain data consistency and integrity

Please provide:
1. Optimized query rewrites
2. Index recommendations with rationale
3. Schema modifications if needed
4. Caching strategy recommendations
5. Query execution plan analysis
6. Performance testing approach
7. Monitoring and alerting setup
8. Before/after performance comparisons
```

## Authentication & Authorization

### JWT Authentication System
```
Create a complete JWT authentication system using [FRAMEWORK] that:
- Implements user registration and login
- Uses [PASSWORD_STRATEGY] for password handling
- Has JWT token generation and validation
- Implements refresh token rotation
- Has role-based access control (RBAC)
- Includes password reset functionality
- Has rate limiting for auth endpoints
- Uses [DATABASE_TYPE] for user storage

User management features:
- [USER_FEATURE_1]
- [USER_FEATURE_2]
- [USER_FEATURE_3]

Security requirements:
- Password complexity validation
- Account lockout after failed attempts
- Secure password reset flow
- JWT token expiration and refresh
- HTTPS enforcement

Please include:
1. User model with proper validation
2. Authentication middleware
3. Password hashing and validation
4. JWT token management
5. Role and permission system
6. Password reset flow
7. Security headers and CORS
8. Authentication tests
9. Security documentation
```

### OAuth2 Integration
```
Create OAuth2 integration for [PROVIDER_LIST] using [FRAMEWORK] that:
- Supports OAuth2 authorization code flow
- Handles multiple OAuth providers: [PROVIDERS]
- Has proper token storage and management
- Includes user profile synchronization
- Has account linking functionality
- Implements proper error handling
- Has security best practices

OAuth providers to support:
- [PROVIDER_1]: [SCOPES_NEEDED]
- [PROVIDER_2]: [SCOPES_NEEDED]

User flow requirements:
- [FLOW_REQUIREMENT_1]
- [FLOW_REQUIREMENT_2]

Please include:
1. OAuth configuration for each provider
2. Authorization flow handlers
3. Token management system
4. User profile mapping
5. Account linking logic
6. Error handling for OAuth failures
7. Security considerations
8. Integration tests
```

## Message Queues & Event Processing

### Event-Driven Architecture
```
Create an event-driven system using [MESSAGE_BROKER] that:
- Handles [EVENT_TYPES] events
- Uses [MESSAGING_PATTERN] pattern (pub/sub, work queues, etc.)
- Has proper event serialization/deserialization
- Implements retry logic with dead letter queues
- Has event ordering guarantees where needed
- Includes monitoring and alerting
- Has proper error handling and logging

Events to handle:
- [EVENT_1]: [DESCRIPTION] - [PAYLOAD_STRUCTURE]
- [EVENT_2]: [DESCRIPTION] - [PAYLOAD_STRUCTURE]

Processing requirements:
- [PROCESSING_REQUIREMENT_1]
- [PROCESSING_REQUIREMENT_2]

Please include:
1. Event producer implementations
2. Event consumer/handler logic
3. Message broker configuration
4. Retry and error handling mechanisms
5. Event schema definitions
6. Monitoring and metrics setup
7. Integration tests for event flows
8. Scaling and performance considerations
```

### Background Job Processing
```
Create a background job processing system using [JOB_FRAMEWORK] that:
- Processes [JOB_TYPES] jobs
- Has proper job queuing and priority handling
- Implements retry logic with exponential backoff
- Has job monitoring and failure tracking
- Uses [STORAGE_BACKEND] for job persistence
- Has proper worker scaling capabilities
- Includes job scheduling and cron-like functionality

Job types to handle:
- [JOB_TYPE_1]: [DESCRIPTION] - [PROCESSING_REQUIREMENTS]
- [JOB_TYPE_2]: [DESCRIPTION] - [PROCESSING_REQUIREMENTS]

Performance requirements:
- Process [THROUGHPUT] jobs per minute
- Handle job failures gracefully
- Scale workers based on queue size

Please include:
1. Job definition and worker implementations
2. Queue configuration and management
3. Retry and failure handling logic
4. Job monitoring and metrics
5. Worker scaling configuration
6. Job scheduling setup
7. Testing for job processing
8. Performance optimization strategies
```

## API Documentation & Testing

### Comprehensive API Testing
```
Create a comprehensive test suite for [API_NAME] that:
- Covers all endpoints with [HTTP_METHODS]
- Has unit tests for business logic
- Includes integration tests for database operations
- Has end-to-end API tests
- Tests authentication and authorization
- Has performance and load testing
- Includes contract testing for external APIs
- Has proper test data management

Testing scenarios:
- [TEST_SCENARIO_1]
- [TEST_SCENARIO_2]
- [TEST_SCENARIO_3]

Test data requirements:
- [DATA_REQUIREMENT_1]
- [DATA_REQUIREMENT_2]

Please include:
1. Unit test suite with mocking
2. Integration tests with test database
3. API endpoint tests with various scenarios
4. Authentication and authorization tests
5. Error handling and edge case tests
6. Performance benchmark tests
7. Test data fixtures and factories
8. CI/CD pipeline test configuration
```

### API Documentation Generation
```
Create comprehensive API documentation for [API_NAME] that:
- Uses [DOCUMENTATION_TOOL] (OpenAPI, GraphQL docs, etc.)
- Documents all endpoints with examples
- Has proper request/response schemas
- Includes authentication requirements
- Has error code documentation
- Has SDK/client library examples
- Includes getting started guide
- Has interactive API explorer

Documentation sections needed:
- [SECTION_1]: [CONTENT_DESCRIPTION]
- [SECTION_2]: [CONTENT_DESCRIPTION]

API structure:
- [ENDPOINT_GROUP_1]: [DESCRIPTION]
- [ENDPOINT_GROUP_2]: [DESCRIPTION]

Please include:
1. OpenAPI/GraphQL schema definitions
2. Endpoint documentation with examples
3. Authentication and authorization guide
4. Error handling documentation
5. SDK examples in multiple languages
6. Getting started tutorial
7. API versioning strategy
8. Interactive documentation setup
```

## Security & Monitoring

### Security Hardening
```
Implement security measures for [APPLICATION_TYPE] that:
- Protects against [THREAT_LIST] threats
- Has proper input validation and sanitization
- Implements security headers and CORS
- Has rate limiting and DDoS protection
- Uses proper secrets management
- Has security logging and monitoring
- Includes vulnerability scanning
- Has proper data encryption

Security requirements:
- [SECURITY_REQUIREMENT_1]
- [SECURITY_REQUIREMENT_2]

Compliance standards:
- [COMPLIANCE_STANDARD] compliance

Please include:
1. Input validation and sanitization
2. Security middleware implementation
3. Secrets management setup
4. Security headers configuration
5. Rate limiting implementation
6. Security logging and monitoring
7. Vulnerability assessment tools
8. Security testing procedures
```

### Monitoring & Observability
```
Implement comprehensive monitoring for [SERVICE_NAME] that:
- Tracks [METRICS_LIST] metrics
- Has proper logging with [LOG_LEVEL] levels
- Implements distributed tracing
- Has health checks and alerting
- Uses [MONITORING_STACK] for observability
- Has performance profiling
- Includes business metrics tracking
- Has proper error tracking and reporting

Monitoring requirements:
- [MONITORING_REQUIREMENT_1]
- [MONITORING_REQUIREMENT_2]

Alerting rules:
- [ALERT_CONDITION_1]: [RESPONSE_ACTION]
- [ALERT_CONDITION_2]: [RESPONSE_ACTION]

Please include:
1. Metrics collection and export
2. Structured logging implementation
3. Distributed tracing setup
4. Health check endpoints
5. Alerting rules and thresholds
6. Dashboard configurations
7. Performance profiling setup
8. Error tracking integration
```

## Deployment & DevOps

### Docker Containerization
```
Create Docker configuration for [APPLICATION_TYPE] that:
- Uses [BASE_IMAGE] as base image
- Has multi-stage build optimization
- Implements proper security practices
- Has health checks and proper signals
- Uses [DEPENDENCY_MANAGER] for dependencies
- Has proper environment variable handling
- Includes development and production variants
- Has proper layer caching optimization

Application requirements:
- [APP_REQUIREMENT_1]
- [APP_REQUIREMENT_2]

Deployment environment:
- [DEPLOYMENT_TARGET] (Kubernetes, Docker Swarm, etc.)

Please include:
1. Multi-stage Dockerfile with optimization
2. Docker Compose for local development
3. Environment variable configuration
4. Health check implementation
5. Security best practices
6. Build and deployment scripts
7. Documentation for running locally
8. Production deployment considerations
```

### CI/CD Pipeline
```
Create a CI/CD pipeline for [APPLICATION_TYPE] using [CI_PLATFORM] that:
- Builds and tests code automatically
- Has [DEPLOYMENT_STAGES] deployment stages
- Implements proper testing gates
- Has automated security scanning
- Uses [DEPLOYMENT_METHOD] for deployment
- Has rollback capabilities
- Includes performance testing
- Has proper artifact management

Pipeline stages:
- [STAGE_1]: [DESCRIPTION]
- [STAGE_2]: [DESCRIPTION]
- [STAGE_3]: [DESCRIPTION]

Quality gates:
- [GATE_1]: [CRITERIA]
- [GATE_2]: [CRITERIA]

Please include:
1. CI/CD pipeline configuration
2. Build and test scripts
3. Deployment automation
4. Quality gate implementations
5. Security scanning integration
6. Rollback procedures
7. Monitoring integration
8. Pipeline documentation
```

---

**Pro Tips for Backend Code Generation:**
- Always specify the framework and language version
- Include comprehensive error handling
- Ask for proper logging and monitoring
- Specify authentication and authorization requirements
- Include database optimization considerations
- Request comprehensive testing strategies
- Mention scalability and performance requirements
- Include security best practices
- Ask for proper documentation
- Consider containerization and deployment needs