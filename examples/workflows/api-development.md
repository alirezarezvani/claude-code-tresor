# API Development Workflow 🚀

A comprehensive workflow for developing robust, scalable APIs using Claude Code Tresor utilities. This workflow demonstrates the integration of slash commands, specialized agents, and best practices for professional API development.

## 📋 Overview

This workflow covers the complete API development lifecycle from planning to deployment, utilizing Claude Code Tresor's specialized utilities for maximum efficiency and quality.

### 🎯 Workflow Goals

- **Quality First**: Ensure code quality through automated reviews and testing
- **Security Focus**: Implement security best practices from day one
- **Performance Optimized**: Build scalable, high-performance APIs
- **Documentation Driven**: Maintain comprehensive documentation throughout
- **Test-Driven Development**: Ensure reliability through comprehensive testing

### 🔧 Utilities Used

- **Commands**: `/scaffold`, `/review`, `/test-gen`, `/docs-gen`
- **Agents**: `@architect`, `@code-reviewer`, `@test-engineer`, `@docs-writer`, `@security-auditor`, `@performance-tuner`

## 🏗️ Phase 1: Architecture & Planning

### Step 1: System Design with @architect

Start by defining your API architecture using the specialized architect agent:

```bash
@architect Design a RESTful API for an e-commerce platform with the following requirements:
- User authentication and authorization
- Product catalog management
- Shopping cart functionality
- Order processing
- Payment integration
- Inventory management
- Real-time notifications

Consider:
- Microservices vs monolithic architecture
- Database design (PostgreSQL + Redis)
- Caching strategy
- Rate limiting
- Error handling patterns
- API versioning strategy
```

**Expected Output:**
- System architecture diagram
- Database schema design
- API endpoint structure
- Technology stack recommendations
- Performance considerations
- Security requirements

### Step 2: Project Scaffolding

Use the scaffold command to create the project structure:

```bash
/scaffold express-api ecommerce-api --features auth,validation,logging,testing,documentation --database postgresql --cache redis --testing jest --docs openapi
```

**Generated Structure:**
```
ecommerce-api/
├── src/
│   ├── controllers/
│   ├── models/
│   ├── middleware/
│   ├── routes/
│   ├── services/
│   ├── utils/
│   └── config/
├── tests/
├── docs/
├── scripts/
└── docker/
```

### Step 3: Initial Architecture Review

```bash
@architect Review the generated project structure and recommend improvements for:
- Folder organization
- Configuration management
- Dependency injection patterns
- Error handling structure
- Logging strategy
```

## 🏭 Phase 2: Core Development

### Step 4: Database Schema Implementation

Create database models and migrations:

```bash
/scaffold database-model User --fields "id:uuid,email:string:unique,password:string,firstName:string,lastName:string,role:enum:user|admin,createdAt:timestamp,updatedAt:timestamp" --relations "hasMany:orders,hasOne:profile"

/scaffold database-model Product --fields "id:uuid,name:string,description:text,price:decimal,sku:string:unique,categoryId:uuid,stockQuantity:integer,isActive:boolean" --relations "belongsTo:category,hasMany:orderItems"

/scaffold database-model Order --fields "id:uuid,userId:uuid,status:enum:pending|confirmed|shipped|delivered|cancelled,totalAmount:decimal,shippingAddress:json,createdAt:timestamp" --relations "belongsTo:user,hasMany:orderItems"
```

### Step 5: API Endpoint Development

Implement core API endpoints:

```javascript
// src/controllers/userController.js
class UserController {
  async register(req, res) {
    try {
      const { email, password, firstName, lastName } = req.body;

      // Validate input
      const validationResult = await validateUserInput(req.body);
      if (!validationResult.isValid) {
        return res.status(400).json({ errors: validationResult.errors });
      }

      // Check if user exists
      const existingUser = await User.findOne({ where: { email } });
      if (existingUser) {
        return res.status(409).json({ error: 'User already exists' });
      }

      // Hash password
      const hashedPassword = await bcrypt.hash(password, 12);

      // Create user
      const user = await User.create({
        email,
        password: hashedPassword,
        firstName,
        lastName,
        role: 'user'
      });

      // Generate JWT token
      const token = jwt.sign(
        { userId: user.id, email: user.email, role: user.role },
        process.env.JWT_SECRET,
        { expiresIn: '24h' }
      );

      res.status(201).json({
        message: 'User created successfully',
        user: {
          id: user.id,
          email: user.email,
          firstName: user.firstName,
          lastName: user.lastName,
          role: user.role
        },
        token
      });
    } catch (error) {
      logger.error('User registration error:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  }

  async login(req, res) {
    try {
      const { email, password } = req.body;

      // Find user
      const user = await User.findOne({ where: { email } });
      if (!user) {
        return res.status(401).json({ error: 'Invalid credentials' });
      }

      // Verify password
      const isValidPassword = await bcrypt.compare(password, user.password);
      if (!isValidPassword) {
        return res.status(401).json({ error: 'Invalid credentials' });
      }

      // Generate JWT token
      const token = jwt.sign(
        { userId: user.id, email: user.email, role: user.role },
        process.env.JWT_SECRET,
        { expiresIn: '24h' }
      );

      res.json({
        message: 'Login successful',
        user: {
          id: user.id,
          email: user.email,
          firstName: user.firstName,
          lastName: user.lastName,
          role: user.role
        },
        token
      });
    } catch (error) {
      logger.error('User login error:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  }
}
```

### Step 6: Security Implementation with @security-auditor

```bash
@security-auditor Review the authentication implementation and provide security recommendations for:
- Password hashing strategy
- JWT token security
- Input validation
- SQL injection prevention
- Rate limiting for auth endpoints
- Session management
- OWASP Top 10 compliance

Also audit the overall API security including:
- Headers security (CORS, CSP, etc.)
- Environment variable management
- Error message sanitization
- API key management
```

### Step 7: Code Review with @code-reviewer

```bash
@code-reviewer Perform a comprehensive review of the user authentication module focusing on:
- Code quality and maintainability
- Error handling patterns
- Async/await usage
- Database query optimization
- Logging implementation
- Configuration management
- TypeScript type safety (if applicable)
```

## 🧪 Phase 3: Testing & Quality Assurance

### Step 8: Test Generation

Generate comprehensive tests for the API:

```bash
/test-gen --file src/controllers/userController.js --framework jest --type unit,integration --coverage 95 --scenarios happy-path,edge-cases,error-conditions

/test-gen --api-endpoints /users/register,/users/login --framework supertest --type api --include-auth --load-testing
```

**Generated Test Example:**
```javascript
// tests/controllers/userController.test.js
describe('UserController', () => {
  describe('POST /users/register', () => {
    it('should create a new user successfully', async () => {
      const userData = {
        email: 'test@example.com',
        password: 'securePassword123!',
        firstName: 'John',
        lastName: 'Doe'
      };

      const response = await request(app)
        .post('/api/v1/users/register')
        .send(userData)
        .expect(201);

      expect(response.body).toHaveProperty('user');
      expect(response.body).toHaveProperty('token');
      expect(response.body.user.email).toBe(userData.email);
      expect(response.body.user).not.toHaveProperty('password');
    });

    it('should reject registration with invalid email', async () => {
      const userData = {
        email: 'invalid-email',
        password: 'securePassword123!',
        firstName: 'John',
        lastName: 'Doe'
      };

      const response = await request(app)
        .post('/api/v1/users/register')
        .send(userData)
        .expect(400);

      expect(response.body).toHaveProperty('errors');
    });

    it('should reject registration with existing email', async () => {
      // Create user first
      await User.create({
        email: 'existing@example.com',
        password: 'hashedPassword',
        firstName: 'Existing',
        lastName: 'User'
      });

      const userData = {
        email: 'existing@example.com',
        password: 'securePassword123!',
        firstName: 'John',
        lastName: 'Doe'
      };

      const response = await request(app)
        .post('/api/v1/users/register')
        .send(userData)
        .expect(409);

      expect(response.body.error).toBe('User already exists');
    });
  });
});
```

### Step 9: Test Engineering Review

```bash
@test-engineer Review the generated tests and enhance them with:
- Additional edge cases and boundary conditions
- Performance testing scenarios
- Security testing (injection attacks, etc.)
- Load testing for high concurrency
- Integration testing with database
- Mocking strategies for external services
- Test data factories and fixtures
```

### Step 10: Performance Optimization

```bash
@performance-tuner Analyze the API implementation and provide optimizations for:
- Database query performance
- Caching implementation (Redis)
- Connection pooling
- Response compression
- Rate limiting strategies
- Memory usage optimization
- API response times
- Concurrent request handling
```

## 📚 Phase 4: Documentation

### Step 11: API Documentation Generation

```bash
/docs-gen api --format openapi --include-examples --auth-flows --error-codes --rate-limits --versioning

/docs-gen postman-collection --endpoints all --include-auth --environment development,staging,production
```

### Step 12: Documentation Enhancement

```bash
@docs-writer Create comprehensive API documentation including:
- Getting started guide for developers
- Authentication flow documentation
- Endpoint reference with examples
- Error handling guide
- Rate limiting documentation
- SDK usage examples
- Troubleshooting guide
- API versioning strategy
```

## 🔄 Phase 5: Review & Integration

### Step 13: Comprehensive Code Review

```bash
/review --scope staged --checks security,performance,configuration,testing --agents @code-reviewer,@security-auditor,@performance-tuner

# Review specific aspects
@code-reviewer Review the complete API implementation for:
- Code organization and maintainability
- Error handling consistency
- Logging implementation
- Configuration management
- Database interaction patterns

@security-auditor Perform final security audit:
- Authentication implementation
- Authorization checks
- Input validation
- SQL injection prevention
- XSS protection
- Rate limiting
- OWASP compliance

@performance-tuner Final performance review:
- Database query optimization
- Caching implementation
- Response time optimization
- Memory usage analysis
- Scalability considerations
```

### Step 14: Integration Testing

```bash
/test-gen --type integration --scenarios end-to-end --include auth-flow,product-catalog,order-processing --framework jest

@test-engineer Create comprehensive integration tests covering:
- Full user registration and authentication flow
- Product catalog browsing and searching
- Shopping cart operations
- Order creation and processing
- Payment flow integration
- Error scenario handling
```

## 🚀 Phase 6: Deployment Preparation

### Step 15: Environment Configuration

Set up environment-specific configurations:

```javascript
// src/config/database.js
module.exports = {
  development: {
    username: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    host: process.env.DB_HOST,
    port: process.env.DB_PORT || 5432,
    dialect: 'postgresql',
    logging: console.log
  },
  test: {
    username: process.env.TEST_DB_USER,
    password: process.env.TEST_DB_PASSWORD,
    database: process.env.TEST_DB_NAME,
    host: process.env.TEST_DB_HOST,
    port: process.env.TEST_DB_PORT || 5432,
    dialect: 'postgresql',
    logging: false
  },
  production: {
    username: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    host: process.env.DB_HOST,
    port: process.env.DB_PORT || 5432,
    dialect: 'postgresql',
    logging: false,
    pool: {
      max: 20,
      min: 5,
      acquire: 30000,
      idle: 10000
    }
  }
};
```

### Step 16: Docker Configuration

```dockerfile
# Dockerfile
FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Copy source code
COPY . .

# Create non-root user
RUN addgroup -g 1001 -S nodejs
RUN adduser -S nextjs -u 1001

# Change ownership
RUN chown -R nextjs:nodejs /app
USER nextjs

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1

# Start application
CMD ["npm", "start"]
```

```yaml
# docker-compose.yml
version: '3.8'

services:
  api:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - DB_HOST=postgres
      - DB_USER=api_user
      - DB_PASSWORD=secure_password
      - DB_NAME=ecommerce_api
      - REDIS_URL=redis://redis:6379
      - JWT_SECRET=${JWT_SECRET}
    depends_on:
      - postgres
      - redis
    restart: unless-stopped

  postgres:
    image: postgres:15-alpine
    environment:
      - POSTGRES_USER=api_user
      - POSTGRES_PASSWORD=secure_password
      - POSTGRES_DB=ecommerce_api
    volumes:
      - postgres_data:/var/lib/postgresql/data
    restart: unless-stopped

  redis:
    image: redis:7-alpine
    volumes:
      - redis_data:/data
    restart: unless-stopped

volumes:
  postgres_data:
  redis_data:
```

### Step 17: Final Security Audit

```bash
@security-auditor Perform final production readiness security audit:
- Environment variable security
- Docker security configuration
- Database connection security
- Rate limiting configuration
- HTTPS/TLS setup
- API key management
- Logging security (no sensitive data)
- Error message sanitization
- Production environment hardening
```

## 📊 Phase 7: Monitoring & Maintenance

### Step 18: Monitoring Setup

```javascript
// src/middleware/monitoring.js
const prometheus = require('prom-client');

// Create metrics
const httpRequestDuration = new prometheus.Histogram({
  name: 'http_request_duration_seconds',
  help: 'Duration of HTTP requests in seconds',
  labelNames: ['method', 'route', 'status_code']
});

const httpRequestTotal = new prometheus.Counter({
  name: 'http_requests_total',
  help: 'Total number of HTTP requests',
  labelNames: ['method', 'route', 'status_code']
});

module.exports = (req, res, next) => {
  const start = Date.now();

  res.on('finish', () => {
    const duration = (Date.now() - start) / 1000;
    const route = req.route ? req.route.path : req.url;

    httpRequestDuration
      .labels(req.method, route, res.statusCode)
      .observe(duration);

    httpRequestTotal
      .labels(req.method, route, res.statusCode)
      .inc();
  });

  next();
};
```

### Step 19: Health Checks

```javascript
// src/routes/health.js
const express = require('express');
const router = express.Router();

router.get('/health', async (req, res) => {
  try {
    // Check database connection
    await sequelize.authenticate();

    // Check Redis connection
    await redis.ping();

    res.json({
      status: 'healthy',
      timestamp: new Date().toISOString(),
      services: {
        database: 'connected',
        cache: 'connected',
        api: 'running'
      }
    });
  } catch (error) {
    res.status(503).json({
      status: 'unhealthy',
      timestamp: new Date().toISOString(),
      error: error.message
    });
  }
});

router.get('/metrics', (req, res) => {
  res.set('Content-Type', prometheus.register.contentType);
  res.end(prometheus.register.metrics());
});
```

## 🎯 Best Practices Applied

### Code Quality
- **Consistent Error Handling**: Centralized error handling middleware
- **Input Validation**: Joi/Yup schema validation for all inputs
- **Type Safety**: TypeScript implementation for better maintainability
- **Code Reviews**: Automated reviews using @code-reviewer agent

### Security
- **Authentication**: JWT-based authentication with refresh tokens
- **Authorization**: Role-based access control (RBAC)
- **Input Sanitization**: SQL injection and XSS prevention
- **Rate Limiting**: Prevent API abuse and DoS attacks
- **Security Headers**: CORS, CSP, and other security headers

### Performance
- **Database Optimization**: Indexed queries and connection pooling
- **Caching**: Redis for frequently accessed data
- **Response Compression**: Gzip compression for API responses
- **Pagination**: Limit large data sets to improve response times

### Documentation
- **OpenAPI Specification**: Complete API documentation
- **Code Comments**: Comprehensive inline documentation
- **README**: Clear setup and usage instructions
- **Examples**: Practical usage examples for developers

### Testing
- **Unit Tests**: Comprehensive unit test coverage (>95%)
- **Integration Tests**: End-to-end workflow testing
- **Load Testing**: Performance under high load
- **Security Testing**: Vulnerability assessment

## 📈 Success Metrics

### Performance Targets
- **Response Time**: <100ms for 95% of requests
- **Throughput**: 1000+ requests per second
- **Uptime**: 99.9% availability
- **Error Rate**: <0.1% of requests

### Quality Metrics
- **Test Coverage**: >95% code coverage
- **Security Score**: A+ rating from security scanners
- **Code Quality**: No critical issues in static analysis
- **Documentation**: 100% API endpoint documentation

### Development Efficiency
- **Time to Deploy**: <30 minutes from code to production
- **Bug Fix Time**: <24 hours average resolution
- **Feature Development**: 50% faster with utility usage
- **Code Review Time**: <2 hours average review cycle

## 🔄 Continuous Improvement

### Regular Reviews
```bash
# Weekly performance review
@performance-tuner Analyze API performance metrics and recommend optimizations

# Monthly security audit
@security-auditor Review security logs and update security measures

# Quarterly architecture review
@architect Evaluate current architecture and recommend improvements for scaling
```

### Automated Maintenance
- **Dependency Updates**: Automated security patch updates
- **Performance Monitoring**: Continuous performance tracking
- **Security Scanning**: Daily vulnerability scans
- **Code Quality**: Automated code quality checks on every commit

This comprehensive API development workflow demonstrates how Claude Code Tresor utilities work together to create professional, scalable, and maintainable APIs following industry best practices.