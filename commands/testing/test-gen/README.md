# /test-gen - Comprehensive Test Harness Generator

> **Author**: Alireza Rezvani
> **Version**: 1.0.0
> **Created**: September 16, 2025

Generate comprehensive, maintainable, and efficient test suites for modern applications with industry best practices, covering unit, integration, end-to-end, performance, and security testing.

## Overview

The `/test-gen` command is a testing expert that creates comprehensive testing frameworks covering unit, integration, end-to-end, performance, and security testing with industry best practices. It designs testing frameworks that ensure code quality and reliability with appropriate tools, patterns, and automation.

## Key Features

- **Testing Framework Selection**: Choose optimal frameworks based on technology stack
- **Complete Test Coverage**: Unit, integration, e2e, performance, and security tests
- **Intelligent Test Generation**: AI-powered test case discovery and edge case detection
- **Framework Integration**: Jest, Vitest, Cypress, Playwright, and more
- **CI/CD Ready**: Automated pipeline integration and coverage reporting

## Usage

### Basic Usage

```bash
# Generate comprehensive test suite for current project
/test-gen

# Generate tests for specific file
/test-gen --file src/utils/helpers.ts

# Generate tests with specific framework
/test-gen --framework jest --coverage 90

# Generate specific test types
/test-gen --type unit,integration,e2e
```

### Advanced Usage

```bash
# Complete test harness setup
/test-gen --setup --framework jest --coverage 95 --mocks

# Generate performance tests
/test-gen --type performance --file src/services/dataProcessor.ts

# Security testing focus
/test-gen --type security --include-vulnerabilities
```

## Testing Framework Selection

The command automatically selects optimal testing frameworks based on your technology stack:

### Python Projects
```python
# Automatically detected and configured:
- Unit Testing: pytest
- Mocking: pytest-mock, unittest.mock
- Property Testing: hypothesis
- Load Testing: locust
- Contract Testing: pact-python
- Security Testing: bandit, safety
- API Testing: requests, httpx
- Async Testing: pytest-asyncio
```

### JavaScript/TypeScript Projects
```javascript
// Automatically detected and configured:
- Unit Testing: jest, vitest
- Mocking: jest, sinon
- Property Testing: fast-check
- Load Testing: artillery, k6
- Contract Testing: pact-js
- Security Testing: npm audit, snyk
- API Testing: supertest, axios
- E2E Testing: playwright, cypress
```

### Java Projects
```java
// Automatically detected and configured:
- Unit Testing: junit5, testng
- Mocking: mockito, powermock
- Property Testing: jqwik
- Load Testing: gatling, jmeter
- Contract Testing: pact-jvm
- Security Testing: spotbugs, dependency-check
- API Testing: rest-assured
- Integration Testing: testcontainers
```

## Complete Testing Implementation

### Python Testing Framework

**Project Structure**
```
project/
├── src/
│   ├── api/
│   │   ├── __init__.py
│   │   ├── routes.py
│   │   └── models.py
│   ├── services/
│   │   ├── __init__.py
│   │   ├── user_service.py
│   │   └── payment_service.py
│   └── utils/
│       ├── __init__.py
│       └── validators.py
├── tests/
│   ├── conftest.py
│   ├── unit/
│   │   ├── test_services.py
│   │   ├── test_utils.py
│   │   └── test_models.py
│   ├── integration/
│   │   ├── test_api_endpoints.py
│   │   ├── test_database.py
│   │   └── test_external_services.py
│   ├── e2e/
│   │   ├── test_user_flows.py
│   │   └── test_payment_flows.py
│   ├── performance/
│   │   ├── test_load.py
│   │   └── test_stress.py
│   ├── security/
│   │   ├── test_auth.py
│   │   └── test_input_validation.py
│   └── fixtures/
│       ├── __init__.py
│       ├── data_factories.py
│       └── test_data.py
├── pytest.ini
├── requirements-test.txt
└── .github/workflows/test.yml
```

**Test Configuration**
```ini
# pytest.ini
[tool:pytest]
minversion = 7.0
addopts =
    -ra
    --strict-markers
    --strict-config
    --cov=src
    --cov-report=term-missing:skip-covered
    --cov-report=html:htmlcov
    --cov-report=xml
    --cov-fail-under=90
    --junitxml=pytest-results.xml
    --tb=short
    -p no:warnings
testpaths = tests
python_files = test_*.py
python_classes = Test*
python_functions = test_*
markers =
    unit: Unit tests
    integration: Integration tests
    e2e: End-to-end tests
    slow: Slow tests
    security: Security tests
    performance: Performance tests
    smoke: Smoke tests
    regression: Regression tests
```

### Advanced Test Configuration

**conftest.py - Comprehensive Test Setup**
```python
import pytest
import asyncio
import tempfile
import shutil
from pathlib import Path
from unittest.mock import Mock, AsyncMock
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from fastapi.testclient import TestClient
import redis
from datetime import datetime, timedelta
import factory
from faker import Faker

fake = Faker()

# Pytest configuration
def pytest_configure(config):
    """Configure pytest with custom settings"""
    config.addinivalue_line("markers", "vcr: mark test to use VCR cassettes")
    config.addinivalue_line("markers", "freeze_time: mark test to freeze time")

@pytest.fixture(scope="session")
def event_loop():
    """Create an instance of the default event loop for the test session"""
    loop = asyncio.get_event_loop_policy().new_event_loop()
    yield loop
    loop.close()

# Database fixtures
@pytest.fixture(scope="session")
def test_db_engine():
    """Create test database engine"""
    engine = create_engine("sqlite:///:memory:", connect_args={"check_same_thread": False})
    Base.metadata.create_all(engine)
    yield engine
    engine.dispose()

@pytest.fixture
def db_session(test_db_engine):
    """Create database session for test"""
    connection = test_db_engine.connect()
    transaction = connection.begin()
    session = sessionmaker(bind=connection)()

    yield session

    session.close()
    transaction.rollback()
    connection.close()

# API client fixtures
@pytest.fixture
def api_client():
    """Create test API client"""
    with TestClient(app) as client:
        yield client

@pytest.fixture
def authenticated_client(api_client, test_user):
    """Create authenticated API client"""
    login_data = {"email": test_user.email, "password": "testpass123"}
    response = api_client.post("/auth/login", json=login_data)
    token = response.json()["access_token"]

    api_client.headers.update({"Authorization": f"Bearer {token}"})
    yield api_client
```

### Unit Testing Implementation

**Comprehensive Unit Tests**
```python
import pytest
from unittest.mock import Mock, patch, AsyncMock
from datetime import datetime, timedelta
from hypothesis import given, strategies as st

from src.services.user_service import UserService
from src.models.user import User
from src.exceptions import UserNotFoundError, DuplicateEmailError

class TestUserService:
    """Test suite for UserService"""

    @pytest.fixture
    def user_service(self, db_session):
        """Create UserService instance"""
        return UserService(db_session)

    @pytest.fixture
    def sample_user_data(self):
        """Sample user data for testing"""
        return {
            "email": "test@example.com",
            "username": "testuser",
            "full_name": "Test User",
            "password": "securepass123"
        }

    def test_create_user_success(self, user_service, sample_user_data):
        """Test successful user creation"""
        user = user_service.create_user(sample_user_data)

        assert user.email == sample_user_data["email"]
        assert user.username == sample_user_data["username"]
        assert user.full_name == sample_user_data["full_name"]
        assert user.is_active is True
        assert user.created_at is not None
        assert hasattr(user, 'hashed_password') is False

    def test_create_user_duplicate_email(self, user_service, sample_user_data):
        """Test user creation with duplicate email"""
        user_service.create_user(sample_user_data)

        with pytest.raises(DuplicateEmailError) as exc_info:
            user_service.create_user(sample_user_data)

        assert "already exists" in str(exc_info.value)

    @pytest.mark.parametrize("invalid_email", [
        "invalid-email", "@example.com", "test@", "", None
    ])
    def test_create_user_invalid_email(self, user_service, sample_user_data, invalid_email):
        """Test user creation with invalid email formats"""
        sample_user_data["email"] = invalid_email

        with pytest.raises(ValueError):
            user_service.create_user(sample_user_data)

    @given(
        email=st.emails(),
        username=st.text(min_size=3, max_size=30),
        full_name=st.text(min_size=1, max_size=100)
    )
    def test_create_user_property_based(self, user_service, email, username, full_name):
        """Property-based test for user creation"""
        user_data = {
            "email": email,
            "username": username,
            "full_name": full_name,
            "password": "validpassword123"
        }

        user = user_service.create_user(user_data)

        assert user.email == email
        assert user.username == username
        assert user.full_name == full_name
```

### Integration Testing Implementation

**API Integration Tests**
```python
import pytest
import json
from datetime import datetime, timedelta
from unittest.mock import patch

class TestUserAPIEndpoints:
    """Integration tests for User API endpoints"""

    def test_create_user_endpoint(self, api_client):
        """Test user creation endpoint"""
        user_data = {
            "email": "newuser@example.com",
            "username": "newuser",
            "password": "securepass123",
            "full_name": "New User"
        }

        response = api_client.post("/api/v1/users/", json=user_data)

        assert response.status_code == 201
        data = response.json()
        assert data["email"] == user_data["email"]
        assert data["username"] == user_data["username"]
        assert "id" in data
        assert "password" not in data

    def test_create_user_validation_error(self, api_client):
        """Test user creation with validation errors"""
        invalid_data = {
            "email": "invalid-email",
            "username": "ab",  # Too short
            "password": "123"  # Too short
        }

        response = api_client.post("/api/v1/users/", json=invalid_data)

        assert response.status_code == 422
        errors = response.json()["detail"]
        assert any("email" in error["loc"] for error in errors)
        assert any("username" in error["loc"] for error in errors)
        assert any("password" in error["loc"] for error in errors)

    def test_rate_limiting(self, api_client):
        """Test API rate limiting"""
        responses = []
        for i in range(102):  # Exceed rate limit of 100
            user_data = {
                "email": f"test{i}@example.com",
                "username": f"user{i}",
                "password": "securepass123"
            }
            response = api_client.post("/api/v1/users/", json=user_data)
            responses.append(response)

        status_codes = [r.status_code for r in responses]
        assert 429 in status_codes  # Too Many Requests
```

### End-to-End Testing Implementation

**Playwright E2E Tests**
```python
import pytest
from playwright.async_api import async_playwright, Page
import asyncio

@pytest.mark.e2e
class TestUserFlows:
    """End-to-end tests for user workflows"""

    @pytest.fixture
    async def browser_page(self):
        """Create browser page for testing"""
        async with async_playwright() as p:
            browser = await p.chromium.launch(headless=True)
            page = await browser.new_page()
            yield page
            await browser.close()

    @pytest.mark.asyncio
    async def test_user_registration_flow(self, browser_page: Page):
        """Test complete user registration flow"""
        await browser_page.goto("http://localhost:3000/register")

        await browser_page.fill('[data-testid="email-input"]', 'e2e@example.com')
        await browser_page.fill('[data-testid="username-input"]', 'e2euser')
        await browser_page.fill('[data-testid="password-input"]', 'securepass123')
        await browser_page.fill('[data-testid="confirm-password-input"]', 'securepass123')

        await browser_page.click('[data-testid="register-button"]')

        await browser_page.wait_for_url("**/dashboard")

        welcome_text = await browser_page.text_content('[data-testid="welcome-message"]')
        assert "Welcome, e2euser" in welcome_text
```

### Performance Testing Implementation

**Load Testing with Locust**
```python
import pytest
import asyncio
import aiohttp
import time
from statistics import mean, median
import locust
from locust import HttpUser, task, between

class APILoadTest(HttpUser):
    """Locust load test for API endpoints"""

    wait_time = between(1, 3)
    host = "http://localhost:8000"

    def on_start(self):
        """Setup for each user"""
        user_data = {
            "email": f"loadtest{int(time.time())}@example.com",
            "username": f"loaduser{int(time.time())}",
            "password": "loadtest123"
        }

        response = self.client.post("/api/v1/users/", json=user_data)
        if response.status_code == 201:
            login_data = {
                "email": user_data["email"],
                "password": user_data["password"]
            }
            login_response = self.client.post("/api/v1/auth/login", json=login_data)
            if login_response.status_code == 200:
                token = login_response.json()["access_token"]
                self.client.headers.update({"Authorization": f"Bearer {token}"})

    @task(3)
    def get_user_profile(self):
        """Test getting user profile"""
        self.client.get("/api/v1/users/me")

    @task(2)
    def list_users(self):
        """Test listing users"""
        self.client.get("/api/v1/users/?limit=10")

    @task(1)
    def update_profile(self):
        """Test updating user profile"""
        update_data = {"full_name": "Updated Name"}
        self.client.put("/api/v1/users/me", json=update_data)

@pytest.mark.performance
class TestAPIPerformance:
    """Performance tests for API endpoints"""

    @pytest.mark.asyncio
    async def test_concurrent_user_creation(self):
        """Test concurrent user creation performance"""
        async def create_user(session, user_id):
            user_data = {
                "email": f"perf{user_id}@example.com",
                "username": f"perfuser{user_id}",
                "password": "perftest123"
            }

            start_time = time.time()
            async with session.post("http://localhost:8000/api/v1/users/", json=user_data) as response:
                end_time = time.time()
                return {
                    "status": response.status,
                    "duration": end_time - start_time,
                    "user_id": user_id
                }

        async with aiohttp.ClientSession() as session:
            tasks = [create_user(session, i) for i in range(100)]
            results = await asyncio.gather(*tasks)

        successful_requests = [r for r in results if r["status"] == 201]
        durations = [r["duration"] for r in successful_requests]

        assert len(successful_requests) >= 95  # 95% success rate
        assert mean(durations) < 1.0  # Average response time < 1s
        assert max(durations) < 5.0   # Max response time < 5s
        assert median(durations) < 0.5  # Median response time < 0.5s
```

### Security Testing Implementation

**Comprehensive Security Tests**
```python
import pytest
import jwt
from datetime import datetime, timedelta
from unittest.mock import patch

@pytest.mark.security
class TestAuthenticationSecurity:
    """Security tests for authentication system"""

    def test_password_hashing(self, user_service):
        """Test password is properly hashed"""
        user_data = {
            "email": "security@example.com",
            "username": "securityuser",
            "password": "plainpassword123"
        }

        user = user_service.create_user(user_data)

        assert user.hashed_password != user_data["password"]
        assert len(user.hashed_password) > 50  # Bcrypt hashes are long
        assert user.hashed_password.startswith("$2b$")  # Bcrypt format

    def test_jwt_token_expiration(self, api_client, test_user):
        """Test JWT token expiration"""
        api_client.post("/api/v1/users/", json=test_user)
        login_response = api_client.post("/api/v1/auth/login", json={
            "email": test_user["email"],
            "password": test_user["password"]
        })
        token = login_response.json()["access_token"]

        decoded = jwt.decode(token, options={"verify_signature": False})
        exp_timestamp = decoded["exp"]
        exp_datetime = datetime.fromtimestamp(exp_timestamp)

        assert exp_datetime > datetime.utcnow()  # Token not expired
        assert exp_datetime < datetime.utcnow() + timedelta(days=8)  # Reasonable expiry

    def test_sql_injection_prevention(self, api_client):
        """Test SQL injection prevention"""
        sql_injection_payloads = [
            "test'; DROP TABLE users; --",
            "test' OR '1'='1",
            "test' UNION SELECT * FROM users --",
        ]

        for payload in sql_injection_payloads:
            user_data = {
                "email": f"{payload}@example.com",
                "username": payload,
                "password": "testpass123"
            }
            response = api_client.post("/api/v1/users/", json=user_data)

            assert response.status_code in [400, 422]  # Validation error, not SQL error

    def test_xss_prevention(self, api_client):
        """Test XSS prevention in API responses"""
        xss_payloads = [
            "<script>alert('xss')</script>",
            "javascript:alert('xss')",
            "<img src=x onerror=alert('xss')>",
        ]

        for payload in xss_payloads:
            user_data = {
                "email": "xsstest@example.com",
                "username": "xssuser",
                "full_name": payload,
                "password": "testpass123"
            }
            response = api_client.post("/api/v1/users/", json=user_data)

            if response.status_code == 201:
                response_text = response.text
                assert "<script>" not in response_text
                assert "javascript:" not in response_text
                assert "onerror=" not in response_text
```

## JavaScript/TypeScript Testing Framework

### Jest Configuration

**Complete Jest Setup**
```javascript
// jest.config.js
module.exports = {
  preset: 'ts-jest',
  testEnvironment: 'node',
  roots: ['<rootDir>/src', '<rootDir>/tests'],
  testMatch: [
    '**/__tests__/**/*.+(ts|tsx|js)',
    '**/*.(test|spec).+(ts|tsx|js)'
  ],
  transform: {
    '^.+\\.(ts|tsx)$': 'ts-jest'
  },
  collectCoverageFrom: [
    'src/**/*.{ts,tsx}',
    '!src/**/*.d.ts',
    '!src/types/**/*'
  ],
  coverageDirectory: 'coverage',
  coverageReporters: ['text', 'lcov', 'html'],
  coverageThreshold: {
    global: {
      branches: 80,
      functions: 80,
      lines: 80,
      statements: 80
    }
  },
  setupFilesAfterEnv: ['<rootDir>/tests/setup.ts'],
  testTimeout: 10000,
  maxWorkers: '50%'
};
```

### Advanced TypeScript Testing

**Unit Testing with Jest**
```typescript
import { UserService } from '../../src/services/userService';
import { PrismaClient } from '@prisma/client';
import bcrypt from 'bcryptjs';
import { jest } from '@jest/globals';

jest.mock('@prisma/client');
const mockPrisma = {
  user: {
    create: jest.fn(),
    findUnique: jest.fn(),
    findFirst: jest.fn(),
    findMany: jest.fn(),
    update: jest.fn(),
    delete: jest.fn()
  }
};

describe('UserService', () => {
  let userService: UserService;

  beforeEach(() => {
    (PrismaClient as jest.MockedClass<typeof PrismaClient>).mockImplementation(() => mockPrisma as any);
    userService = new UserService();
  });

  describe('createUser', () => {
    it('should create user successfully', async () => {
      const userData = {
        email: 'test@example.com',
        username: 'testuser',
        password: 'password123',
        fullName: 'Test User'
      };

      const mockUser = {
        id: '1',
        email: userData.email,
        username: userData.username,
        fullName: userData.fullName,
        isActive: true,
        createdAt: new Date(),
        updatedAt: new Date()
      };

      mockPrisma.user.findFirst.mockResolvedValue(null);
      mockPrisma.user.create.mockResolvedValue(mockUser);

      const result = await userService.createUser(userData);

      expect(result).toEqual(mockUser);
      expect(mockPrisma.user.create).toHaveBeenCalledWith({
        data: expect.objectContaining({
          email: userData.email,
          username: userData.username,
          fullName: userData.fullName,
          hashedPassword: expect.any(String),
          isActive: true
        })
      });
    });
  });
});
```

### Property-Based Testing with fast-check

**Comprehensive Property Tests**
```typescript
import fc from 'fast-check';
import { validateEmail, validateUsername } from '../../src/utils/validation';

describe('User Validation - Property Tests', () => {
  describe('validateEmail', () => {
    it('should always return boolean', () => {
      fc.assert(fc.property(
        fc.emailAddress(),
        (email) => {
          const result = validateEmail(email);
          expect(typeof result).toBe('boolean');
        }
      ));
    });

    it('should accept valid email formats', () => {
      fc.assert(fc.property(
        fc.emailAddress(),
        (email) => {
          expect(validateEmail(email)).toBe(true);
        }
      ));
    });

    it('should reject strings without @ symbol', () => {
      fc.assert(fc.property(
        fc.string().filter(s => !s.includes('@')),
        (invalidEmail) => {
          expect(validateEmail(invalidEmail)).toBe(false);
        }
      ));
    });
  });
});
```

## CI/CD Integration

### GitHub Actions Workflow

**Complete Testing Pipeline**
```yaml
name: Comprehensive Test Suite

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

env:
  NODE_ENV: test
  DATABASE_URL: postgresql://postgres:postgres@localhost:5432/test_db

jobs:
  test:
    runs-on: ubuntu-latest

    strategy:
      matrix:
        python-version: [3.9, 3.10, 3.11]
        node-version: [16, 18, 20]

    services:
      postgres:
        image: postgres:15
        env:
          POSTGRES_PASSWORD: postgres
          POSTGRES_DB: test_db
        options: >-
          --health-cmd pg_isready
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
        ports:
          - 5432:5432

      redis:
        image: redis:7
        options: >-
          --health-cmd "redis-cli ping"
          --health-interval 10s
          --health-timeout 5s
          --health-retries 5
        ports:
          - 6379:6379

    steps:
    - uses: actions/checkout@v4

    - name: Set up Python ${{ matrix.python-version }}
      uses: actions/setup-python@v4
      with:
        python-version: ${{ matrix.python-version }}

    - name: Set up Node.js ${{ matrix.node-version }}
      uses: actions/setup-node@v4
      with:
        node-version: ${{ matrix.node-version }}

    - name: Install dependencies
      run: |
        pip install -r requirements.txt
        pip install -r requirements-test.txt
        npm ci

    - name: Lint code
      run: |
        flake8 src tests
        black --check src tests
        npm run lint

    - name: Run security scans
      run: |
        bandit -r src
        npm audit --audit-level high
        safety check

    - name: Run unit tests
      run: |
        pytest tests/unit/ -v --cov=src --cov-report=xml
        npm run test:unit -- --coverage --ci --watchAll=false

    - name: Run integration tests
      run: |
        pytest tests/integration/ -v
        npm run test:integration

    - name: Run end-to-end tests
      run: |
        pytest tests/e2e/ -v
        npm run test:e2e

    - name: Upload coverage to Codecov
      uses: codecov/codecov-action@v3
      with:
        files: ./coverage.xml,./coverage/lcov.info
        fail_ci_if_error: true
```

## Advanced Features

### Test Data Management

**Data Factories**
```python
import factory
from datetime import datetime, timedelta
from faker import Faker
import random

fake = Faker()

class UserFactory(factory.Factory):
    class Meta:
        model = dict

    id = factory.Sequence(lambda n: n)
    email = factory.LazyAttribute(lambda obj: fake.email())
    username = factory.LazyAttribute(lambda obj: fake.user_name())
    full_name = factory.LazyAttribute(lambda obj: fake.name())
    is_active = True
    created_at = factory.LazyFunction(datetime.utcnow)

    @factory.post_generation
    def password(obj, create, extracted, **kwargs):
        if extracted:
            obj['password'] = extracted
        else:
            obj['password'] = fake.password(length=12)

class TestDataGenerator:
    @staticmethod
    def generate_test_users(count=10, user_type='standard'):
        """Generate test users of different types"""
        factories = {
            'standard': UserFactory,
            'admin': AdminUserFactory,
            'inactive': InactiveUserFactory
        }

        factory_class = factories.get(user_type, UserFactory)
        return factory_class.build_batch(count)
```

### Contract Testing

**Pact Implementation**
```python
import pytest
from pact import Consumer, Provider, Like, EachLike, Term
import requests

@pytest.fixture
def pact():
    """Create Pact consumer"""
    pact = Consumer('UserServiceClient').has_pact_with(Provider('UserServiceAPI'))
    pact.start()
    yield pact
    pact.stop()

class TestUserServiceContract:
    """Contract tests for User Service API"""

    def test_get_user_success(self, pact):
        """Test contract for successful user retrieval"""
        expected_response = {
            'id': Like(123),
            'email': Like('user@example.com'),
            'username': Like('testuser'),
            'full_name': Like('Test User'),
            'is_active': Like(True),
            'created_at': Term(r'\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}', '2024-01-01T12:00:00')
        }

        (pact
         .given('user with ID 123 exists')
         .upon_receiving('a request for user 123')
         .with_request('GET', '/api/v1/users/123')
         .will_respond_with(200, body=expected_response))

        with pact:
            response = requests.get('http://localhost:1234/api/v1/users/123')

        assert response.status_code == 200
        assert response.json()['id'] == 123
```

## Parameters

### Required
- None (analyzes current project context)

### Optional
- `--file`: Specific file to generate tests for
- `--type`: Test types (`unit`, `integration`, `e2e`, `performance`, `security`)
- `--framework`: Testing framework (`jest`, `pytest`, `cypress`, `playwright`)
- `--coverage`: Target coverage percentage (default: 80)
- `--mocks`: Include mock generation for dependencies
- `--output-dir`: Custom output directory for test files
- `--setup`: Initialize complete testing framework
- `--ci`: Generate CI/CD integration files

## Integration with Other Commands

The `/test-gen` command works seamlessly with other utilities:

```bash
# Generate tests after scaffolding
/scaffold react-component UserProfile
/test-gen --file src/components/UserProfile.tsx --type unit,component

# Security-focused testing
/security-scan src/
/test-gen --type security --include-vulnerabilities

# Performance testing integration
/test-gen --type performance --benchmark
```

## Best Practices

### For Test Generation
1. **Comprehensive Coverage**: Include unit, integration, e2e, and security tests
2. **Realistic Data**: Use factories and fixtures for test data
3. **Proper Mocking**: Mock external dependencies appropriately
4. **Performance Consideration**: Include performance benchmarks

### For Test Maintenance
1. **Clear Naming**: Use descriptive test names and organize by functionality
2. **Independent Tests**: Ensure tests don't depend on each other
3. **Fast Execution**: Keep unit tests fast, slow tests separate
4. **Regular Updates**: Keep tests updated with code changes

## Troubleshooting

### Common Issues

**Framework not detected**
- Ensure package.json or requirements.txt exists
- Check supported framework list

**Coverage threshold not met**
- Review generated tests for completeness
- Add tests for uncovered branches

**Test execution timeout**
- Optimize slow tests or increase timeout
- Separate performance tests from unit tests

---

**Remember**: Comprehensive testing is the foundation of reliable software. The `/test-gen` command ensures your code is battle-tested and production-ready.