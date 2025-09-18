# CI/CD Pipeline Workflow 🔄

A comprehensive guide for implementing robust CI/CD pipelines using Claude Code Tresor utilities. This workflow covers everything from code commit to production deployment with automated testing, security scanning, and deployment strategies.

## 📋 Overview

This workflow demonstrates enterprise-grade CI/CD pipeline implementation using modern DevOps practices and Claude Code Tresor's specialized utilities for maximum automation and reliability.

### 🎯 Pipeline Goals

- **Automated Quality Gates**: Prevent low-quality code from reaching production
- **Security First**: Integrate security scanning at every stage
- **Fast Feedback**: Provide rapid feedback to developers
- **Reliable Deployments**: Ensure consistent, rollback-capable deployments
- **Monitoring & Observability**: Track pipeline and application performance

### 🔧 Utilities Used

- **Commands**: `/review`, `/test-gen`, `/docs-gen`
- **Agents**: `@security-auditor`, `@performance-tuner`, `@test-engineer`, `@architect`

## 🏗️ Pipeline Architecture

### Multi-Stage Pipeline Structure

```mermaid
graph TD
    A[Code Commit] --> B[Pre-commit Hooks]
    B --> C[Build Stage]
    C --> D[Unit Tests]
    D --> E[Code Quality]
    E --> F[Security Scan]
    F --> G[Integration Tests]
    G --> H[Deploy to Staging]
    H --> I[E2E Tests]
    I --> J[Performance Tests]
    J --> K[Security Tests]
    K --> L[Deploy to Production]
    L --> M[Health Checks]
    M --> N[Monitoring]
```

## 🚀 Phase 1: Pre-commit & Build Stage

### Step 1: Pre-commit Hooks Setup

Configure Git hooks to run quality checks before commits:

```bash
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.4.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-merge-conflict
      - id: check-yaml
      - id: check-json

  - repo: https://github.com/psf/black
    rev: 22.3.0
    hooks:
      - id: black

  - repo: https://github.com/pycqa/isort
    rev: 5.12.0
    hooks:
      - id: isort

  - repo: local
    hooks:
      - id: claude-review
        name: Claude Code Review
        entry: claude-code
        args: ['/review', '--scope', 'staged', '--checks', 'security,quality']
        language: system
        pass_filenames: false
```

### Step 2: Build Configuration

#### GitHub Actions Workflow

```yaml
# .github/workflows/ci-cd.yml
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main, develop]

env:
  NODE_VERSION: '18'
  PYTHON_VERSION: '3.11'
  REGISTRY: ghcr.io
  IMAGE_NAME: ${{ github.repository }}

jobs:
  build:
    name: Build and Test
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4
        with:
          fetch-depth: 0

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: 'npm'

      - name: Install dependencies
        run: npm ci

      - name: Build application
        run: npm run build

      - name: Cache build artifacts
        uses: actions/cache@v3
        with:
          path: |
            dist/
            node_modules/
          key: ${{ runner.os }}-build-${{ github.sha }}

  unit-tests:
    name: Unit Tests
    runs-on: ubuntu-latest
    needs: build

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Restore cache
        uses: actions/cache@v3
        with:
          path: |
            dist/
            node_modules/
          key: ${{ runner.os }}-build-${{ github.sha }}

      - name: Run unit tests
        run: npm run test:unit -- --coverage

      - name: Upload coverage reports
        uses: codecov/codecov-action@v3
        with:
          file: ./coverage/coverage.xml
          flags: unittests

  code-quality:
    name: Code Quality & Security
    runs-on: ubuntu-latest
    needs: build

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Restore cache
        uses: actions/cache@v3
        with:
          path: |
            dist/
            node_modules/
          key: ${{ runner.os }}-build-${{ github.sha }}

      - name: Claude Code Review
        run: |
          /review --scope all --checks security,performance,quality,configuration \
            --agents @code-reviewer,@security-auditor,@performance-tuner

      - name: ESLint
        run: npm run lint

      - name: TypeScript Check
        run: npm run type-check

      - name: SonarCloud Scan
        uses: SonarSource/sonarcloud-github-action@master
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
          SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
```

### Step 3: Automated Code Review Integration

```bash
# Use Claude Code utilities in CI
@code-reviewer Review all staged changes for:
- Code quality and maintainability
- Design patterns and best practices
- Error handling and logging
- Performance implications
- TypeScript type safety

@security-auditor Scan for security vulnerabilities:
- OWASP Top 10 compliance
- Dependency vulnerabilities
- Secret detection
- Input validation
- Authentication flaws
```

## 🔒 Phase 2: Security & Quality Gates

### Step 4: Security Scanning Pipeline

```yaml
  security-scan:
    name: Security Scanning
    runs-on: ubuntu-latest
    needs: build

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Run Snyk Security Scan
        uses: snyk/actions/node@master
        env:
          SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}
        with:
          args: --severity-threshold=high

      - name: SAST with CodeQL
        uses: github/codeql-action/init@v2
        with:
          languages: javascript, typescript

      - name: Claude Security Audit
        run: |
          @security-auditor Perform comprehensive security audit including:
          - Authentication and authorization
          - Input validation and sanitization
          - SQL injection prevention
          - XSS protection
          - CSRF protection
          - Secure headers configuration
          - Dependency vulnerability assessment

      - name: Container Security Scan
        uses: aquasecurity/trivy-action@master
        with:
          image-ref: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }}
          format: 'sarif'
          output: 'trivy-results.sarif'

      - name: Upload Security Results
        uses: github/codeql-action/upload-sarif@v2
        if: always()
        with:
          sarif_file: 'trivy-results.sarif'
```

### Step 5: Performance Testing

```yaml
  performance-tests:
    name: Performance Testing
    runs-on: ubuntu-latest
    needs: [unit-tests, code-quality]

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup test environment
        run: |
          docker-compose -f docker-compose.test.yml up -d
          sleep 30

      - name: Generate Performance Tests
        run: |
          /test-gen --type performance --framework locust --scenarios load,stress,spike \
            --endpoints /api/v1/users,/api/v1/products,/api/v1/orders \
            --concurrent-users 100,500,1000

      - name: Run Load Tests
        run: |
          locust --host=http://localhost:3000 \
            --users=100 \
            --spawn-rate=10 \
            --run-time=300s \
            --html=performance-report.html

      - name: Performance Analysis
        run: |
          @performance-tuner Analyze performance test results and provide recommendations for:
          - Response time optimization
          - Database query performance
          - Memory usage optimization
          - Caching strategies
          - Scalability improvements

      - name: Upload Performance Reports
        uses: actions/upload-artifact@v3
        with:
          name: performance-reports
          path: performance-report.html
```

## 🧪 Phase 3: Integration & End-to-End Testing

### Step 6: Integration Testing

```yaml
  integration-tests:
    name: Integration Tests
    runs-on: ubuntu-latest
    needs: [unit-tests, code-quality]

    services:
      postgres:
        image: postgres:15
        env:
          POSTGRES_PASSWORD: test_password
          POSTGRES_USER: test_user
          POSTGRES_DB: test_db
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5

      redis:
        image: redis:7
        options: >-
          --health-cmd "redis-cli ping"
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Restore cache
        uses: actions/cache@v3
        with:
          path: |
            dist/
            node_modules/
          key: ${{ runner.os }}-build-${{ github.sha }}

      - name: Generate Integration Tests
        run: |
          /test-gen --type integration --framework jest \
            --scenarios database,api,auth,cache \
            --include-fixtures --include-mocks

      - name: Run Database Migrations
        run: npm run db:migrate
        env:
          DATABASE_URL: postgresql://test_user:test_password@postgres:5432/test_db

      - name: Run Integration Tests
        run: npm run test:integration
        env:
          DATABASE_URL: postgresql://test_user:test_password@postgres:5432/test_db
          REDIS_URL: redis://redis:6379

      - name: Test Engineering Review
        run: |
          @test-engineer Review integration test results and enhance coverage for:
          - Cross-service communication
          - Database transaction integrity
          - Cache consistency
          - Error propagation
          - Concurrent request handling
```

### Step 7: End-to-End Testing

```yaml
  e2e-tests:
    name: E2E Tests
    runs-on: ubuntu-latest
    needs: integration-tests

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Start application stack
        run: |
          docker-compose -f docker-compose.e2e.yml up -d
          ./scripts/wait-for-services.sh

      - name: Generate E2E Tests
        run: |
          /test-gen --type e2e --framework playwright \
            --scenarios user-journey,admin-workflow,checkout-process \
            --browsers chrome,firefox,safari

      - name: Run Playwright Tests
        run: npx playwright test
        env:
          BASE_URL: http://localhost:3000

      - name: Upload Test Results
        uses: actions/upload-artifact@v3
        if: always()
        with:
          name: playwright-report
          path: playwright-report/
```

## 🚀 Phase 4: Deployment Stages

### Step 8: Staging Deployment

```yaml
  deploy-staging:
    name: Deploy to Staging
    runs-on: ubuntu-latest
    needs: [integration-tests, performance-tests, security-scan]
    if: github.ref == 'refs/heads/develop'

    environment:
      name: staging
      url: https://staging.example.com

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Configure AWS credentials
        uses: aws-actions/configure-aws-credentials@v2
        with:
          aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
          aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
          aws-region: us-east-1

      - name: Build and push Docker image
        run: |
          docker build -t ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:staging-${{ github.sha }} .
          docker push ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:staging-${{ github.sha }}

      - name: Deploy to ECS
        run: |
          aws ecs update-service \
            --cluster staging-cluster \
            --service api-service \
            --task-definition staging-api:${{ github.sha }}

      - name: Wait for deployment
        run: |
          aws ecs wait services-stable \
            --cluster staging-cluster \
            --services api-service

      - name: Health Check
        run: |
          curl -f https://staging.example.com/health || exit 1

      - name: Smoke Tests
        run: npm run test:smoke -- --env=staging
```

### Step 9: Production Deployment

```yaml
  deploy-production:
    name: Deploy to Production
    runs-on: ubuntu-latest
    needs: [deploy-staging, e2e-tests]
    if: github.ref == 'refs/heads/main'

    environment:
      name: production
      url: https://api.example.com

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Architecture Review
        run: |
          @architect Review production deployment configuration:
          - Infrastructure scaling requirements
          - Database performance optimization
          - CDN and caching strategy
          - Monitoring and alerting setup
          - Disaster recovery planning

      - name: Blue-Green Deployment
        run: |
          # Deploy to blue environment
          ./scripts/deploy-blue-green.sh \
            --environment=production \
            --image=${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}:${{ github.sha }} \
            --target=blue

      - name: Health Checks
        run: |
          ./scripts/health-check.sh --environment=blue
          ./scripts/load-test.sh --environment=blue --duration=300s

      - name: Switch Traffic
        run: |
          ./scripts/switch-traffic.sh --from=green --to=blue

      - name: Post-deployment Tests
        run: |
          npm run test:production
          ./scripts/canary-analysis.sh

      - name: Cleanup Green Environment
        run: |
          ./scripts/cleanup-environment.sh --target=green
```

## 📊 Phase 5: Monitoring & Observability

### Step 10: Monitoring Setup

```yaml
  setup-monitoring:
    name: Setup Monitoring
    runs-on: ubuntu-latest
    needs: deploy-production

    steps:
      - name: Configure Application Monitoring
        run: |
          # Setup DataDog/New Relic monitoring
          curl -X POST "https://api.datadoghq.com/api/v1/check_run" \
            -H "Content-Type: application/json" \
            -H "DD-API-KEY: ${{ secrets.DATADOG_API_KEY }}" \
            -d '{
              "check": "app.health",
              "host_name": "production-api",
              "status": 0,
              "message": "Application deployed successfully"
            }'

      - name: Setup Alerts
        run: |
          # Configure monitoring alerts
          ./scripts/setup-alerts.sh \
            --environment=production \
            --thresholds="response_time:100ms,error_rate:1%,cpu:80%"

      - name: Performance Baseline
        run: |
          @performance-tuner Establish performance baselines for production:
          - Response time targets
          - Throughput expectations
          - Resource utilization limits
          - Error rate thresholds
          - Database performance metrics
```

### Step 11: Documentation Generation

```yaml
  update-documentation:
    name: Update Documentation
    runs-on: ubuntu-latest
    needs: deploy-production

    steps:
      - name: Generate API Documentation
        run: |
          /docs-gen api --format openapi --output docs/api.yml \
            --include-examples --auth-flows --rate-limits

      - name: Generate Deployment Documentation
        run: |
          @docs-writer Create deployment documentation including:
          - Environment configuration guide
          - Monitoring and alerting setup
          - Troubleshooting guide
          - Rollback procedures
          - Performance tuning guide

      - name: Update Release Notes
        run: |
          ./scripts/generate-release-notes.sh \
            --from=${{ github.event.before }} \
            --to=${{ github.sha }} \
            --output=RELEASE_NOTES.md

      - name: Deploy Documentation
        run: |
          # Deploy to documentation site
          aws s3 sync docs/ s3://docs.example.com/
          aws cloudfront create-invalidation \
            --distribution-id E1234567890 \
            --paths "/*"
```

## 🔧 Advanced Pipeline Features

### Step 12: Feature Flags Integration

```yaml
  feature-flags:
    name: Feature Flags Management
    runs-on: ubuntu-latest

    steps:
      - name: Update Feature Flags
        run: |
          # Update LaunchDarkly/Split.io feature flags
          curl -X PATCH "https://app.launchdarkly.com/api/v2/flags/default/new-checkout-flow" \
            -H "Authorization: ${{ secrets.LAUNCHDARKLY_TOKEN }}" \
            -H "Content-Type: application/json" \
            -d '{
              "patch": [
                {
                  "op": "replace",
                  "path": "/environments/production/on",
                  "value": true
                }
              ]
            }'

      - name: Gradual Rollout
        run: |
          ./scripts/gradual-rollout.sh \
            --feature=new-checkout-flow \
            --percentage=10 \
            --duration=1h
```

### Step 13: Automated Rollback

```yaml
  automated-rollback:
    name: Automated Rollback
    runs-on: ubuntu-latest
    if: failure()

    steps:
      - name: Trigger Rollback
        run: |
          echo "Deployment failed, initiating rollback..."
          ./scripts/rollback.sh \
            --environment=production \
            --to-version=previous

      - name: Verify Rollback
        run: |
          ./scripts/health-check.sh --environment=production
          ./scripts/smoke-test.sh --environment=production

      - name: Notify Team
        run: |
          curl -X POST ${{ secrets.SLACK_WEBHOOK }} \
            -H 'Content-type: application/json' \
            -d '{
              "text": "🚨 Production deployment failed and rolled back automatically",
              "channel": "#engineering",
              "username": "CI/CD Bot"
            }'
```

## 📊 Pipeline Metrics & KPIs

### Performance Metrics

```bash
# Track deployment metrics
@performance-tuner Analyze CI/CD pipeline performance:
- Build time optimization
- Test execution time
- Deployment duration
- Mean time to recovery (MTTR)
- Change failure rate
- Deployment frequency
```

### Quality Metrics

```bash
# Monitor quality gates
@test-engineer Track testing effectiveness:
- Test coverage percentage
- Test execution time
- Flaky test identification
- Test failure analysis
- Code quality scores
- Security vulnerability detection rate
```

## 🔄 Continuous Improvement

### Weekly Pipeline Review

```bash
@architect Review CI/CD pipeline efficiency and recommend improvements for:
- Pipeline speed optimization
- Resource utilization
- Cost optimization
- Security enhancement
- Reliability improvements
- Developer experience
```

### Monthly Security Audit

```bash
@security-auditor Audit CI/CD pipeline security:
- Secret management review
- Access control validation
- Vulnerability scanning effectiveness
- Compliance verification
- Security tool configuration
- Pipeline security best practices
```

## 🎯 Best Practices Implemented

### Security
- **Secret Management**: All secrets stored in GitHub Secrets/AWS SSM
- **Least Privilege**: Minimal permissions for CI/CD processes
- **Security Scanning**: Automated vulnerability detection
- **Compliance**: SOC 2/GDPR compliance checks

### Performance
- **Parallel Execution**: Tests run in parallel for faster feedback
- **Caching**: Aggressive caching of dependencies and artifacts
- **Resource Optimization**: Right-sized compute resources
- **Incremental Builds**: Only build what changed

### Reliability
- **Health Checks**: Comprehensive health verification
- **Rollback Capability**: Automated rollback on failure
- **Blue-Green Deployment**: Zero-downtime deployments
- **Monitoring**: Real-time pipeline and application monitoring

### Developer Experience
- **Fast Feedback**: Quick notification of failures
- **Clear Reporting**: Detailed test and quality reports
- **Easy Debugging**: Accessible logs and artifacts
- **Self-Service**: Developers can trigger deployments

## 📈 Success Metrics

### Deployment Metrics
- **Deployment Frequency**: Multiple times per day
- **Lead Time**: <30 minutes from commit to production
- **Change Failure Rate**: <5%
- **Mean Time to Recovery**: <15 minutes

### Quality Metrics
- **Test Coverage**: >95%
- **Security Scan Success**: 100% vulnerability detection
- **Code Quality Score**: A+ rating
- **Zero Critical Issues**: No critical bugs in production

This comprehensive CI/CD pipeline workflow demonstrates how Claude Code Tresor utilities integrate with modern DevOps practices to create reliable, secure, and efficient deployment pipelines.