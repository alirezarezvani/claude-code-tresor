# /docs-gen - Automated Documentation Generation

> **Author**: Alireza Rezvani
> **Version**: 1.0.0
> **Created**: September 16, 2025

Generate comprehensive, maintainable documentation from code using AI-powered analysis and industry best practices. Create API docs, architecture diagrams, user guides, and technical references that stay synchronized with code.

## Overview

The `/docs-gen` command is a documentation expert specializing in creating comprehensive, maintainable documentation from code. It extracts information from code, creates clear explanations, and maintains consistency across documentation types, generating living documentation that stays synchronized with code.

## Key Features

- **Code Analysis Documentation**: Extract API endpoints, schemas, and function documentation
- **Architecture Visualization**: Generate system, sequence, and component diagrams
- **Interactive Documentation**: Create API playgrounds and interactive examples
- **Multi-Format Output**: Support for Markdown, HTML, PDF, OpenAPI, GitBook, and more
- **CI/CD Integration**: Automated documentation updates and deployment

## Usage

### Basic Usage

```bash
# Generate comprehensive documentation for project
/docs-gen

# Generate API documentation
/docs-gen --type api --format openapi

# Generate README with all sections
/docs-gen --type readme --sections all --badges

# Generate user guide
/docs-gen --type guide --format gitbook --output docs/
```

### Advanced Usage

```bash
# Generate with architecture diagrams
/docs-gen --type reference --include-diagrams --format html

# Generate with interactive examples
/docs-gen --type api --interactive --playground

# Generate and deploy to GitHub Pages
/docs-gen --type guide --format html --deploy github-pages
```

## Code Analysis for Documentation

### API Documentation Extraction

**Automatic Endpoint Detection**
```python
# The command automatically detects and documents:
# FastAPI endpoints
@app.get("/users/{user_id}")
async def get_user(user_id: int) -> User:
    """
    Retrieve a user by ID.

    Args:
        user_id: The unique identifier for the user

    Returns:
        User: The user object with all details

    Raises:
        HTTPException: If user not found (404)

    Examples:
        GET /users/123 -> Returns user with ID 123
    """
    return await user_service.get_user(user_id)
```

**Generated API Documentation**
```yaml
# Auto-generated OpenAPI specification
paths:
  /users/{user_id}:
    get:
      summary: Retrieve a user by ID
      description: |
        Retrieve a user by their unique identifier. Returns complete user
        profile including personal information and account status.
      operationId: get_user
      parameters:
        - name: user_id
          in: path
          required: true
          description: The unique identifier for the user
          schema:
            type: integer
            minimum: 1
      responses:
        '200':
          description: User retrieved successfully
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/User'
              examples:
                example_user:
                  value:
                    id: 123
                    name: "John Doe"
                    email: "john@example.com"
        '404':
          description: User not found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Error'
```

### Type and Schema Documentation

**Pydantic Model Extraction**
```python
# Automatically documents data models
class User(BaseModel):
    """
    User model representing a system user.

    Attributes:
        id: Unique user identifier
        email: User's email address (must be valid email format)
        username: Unique username (3-30 characters, alphanumeric)
        full_name: User's display name
        is_active: Whether the user account is active
        created_at: Account creation timestamp
        updated_at: Last modification timestamp
    """
    id: int = Field(..., description="Unique user identifier", gt=0)
    email: EmailStr = Field(..., description="User's email address")
    username: str = Field(..., min_length=3, max_length=30,
                         description="Unique username (alphanumeric only)")
    full_name: str = Field(..., description="User's display name")
    is_active: bool = Field(default=True, description="Account status")
    created_at: datetime = Field(default_factory=datetime.utcnow)
    updated_at: datetime = Field(default_factory=datetime.utcnow)
```

**Generated Schema Documentation**
```yaml
# Auto-generated schema documentation
components:
  schemas:
    User:
      type: object
      description: User model representing a system user
      required:
        - id
        - email
        - username
        - full_name
      properties:
        id:
          type: integer
          minimum: 1
          description: Unique user identifier
        email:
          type: string
          format: email
          description: User's email address
        username:
          type: string
          minLength: 3
          maxLength: 30
          pattern: '^[a-zA-Z0-9]+$'
          description: Unique username (alphanumeric only)
        full_name:
          type: string
          description: User's display name
        is_active:
          type: boolean
          default: true
          description: Account status
        created_at:
          type: string
          format: date-time
          description: Account creation timestamp
        updated_at:
          type: string
          format: date-time
          description: Last modification timestamp
```

## Architecture Documentation

### System Architecture Diagrams

**Mermaid Diagram Generation**
```mermaid
graph TB
    subgraph "Frontend Layer"
        UI[React UI]
        Mobile[Mobile App]
        API_Gateway[API Gateway]
    end

    subgraph "Application Layer"
        Auth[Auth Service]
        Users[User Service]
        Orders[Order Service]
        Payments[Payment Service]
        Notifications[Notification Service]
    end

    subgraph "Data Layer"
        PostgresMain[(PostgreSQL)]
        Redis[(Redis Cache)]
        Elasticsearch[(Elasticsearch)]
        S3[S3 Storage]
    end

    subgraph "Message Queue"
        Kafka[Apache Kafka]
    end

    UI --> API_Gateway
    Mobile --> API_Gateway
    API_Gateway --> Auth
    API_Gateway --> Users
    API_Gateway --> Orders

    Orders --> Payments
    Payments --> Kafka
    Kafka --> Notifications

    Users --> PostgresMain
    Users --> Redis
    Orders --> PostgresMain
    Orders --> Elasticsearch
    Notifications --> S3

    style UI fill:#e1f5fe
    style Users fill:#f3e5f5
    style PostgresMain fill:#e8f5e8
    style Kafka fill:#fff3e0
```

### Component Documentation

**Auto-Generated Component Docs**
```markdown
## System Components

### User Service
**Purpose**: Manages user accounts, authentication, and profiles

**Responsibilities**:
- User registration and authentication
- Profile management and updates
- Role-based access control (RBAC)
- Password reset and account recovery
- Session management and JWT tokens

**Technology Stack**:
- **Language**: Python 3.11
- **Framework**: FastAPI 0.104.1
- **Database**: PostgreSQL 15
- **Cache**: Redis 7.0
- **Authentication**: JWT with refresh tokens
- **Validation**: Pydantic v2

**API Endpoints**:
- `POST /users` - Create new user account
- `GET /users/{id}` - Retrieve user details
- `PUT /users/{id}` - Update user information
- `DELETE /users/{id}` - Deactivate user account
- `POST /auth/login` - User authentication
- `POST /auth/refresh` - Refresh JWT token
- `POST /auth/logout` - Invalidate session

**Dependencies**:
- PostgreSQL for persistent user data storage
- Redis for session caching and rate limiting
- Email service for notifications and verification
- Auth service for token validation

**Configuration**:
```yaml
user_service:
  port: 8001
  database:
    host: postgres.internal
    port: 5432
    name: users_db
    max_connections: 100
  redis:
    host: redis.internal
    port: 6379
    db: 0
  jwt:
    secret: ${JWT_SECRET}
    access_token_expire_minutes: 30
    refresh_token_expire_days: 30
  rate_limiting:
    requests_per_minute: 100
    burst_size: 10
```

**Monitoring & Metrics**:
- Response time: P95 < 200ms
- Error rate: < 1%
- Active sessions: Real-time count
- Registration rate: Daily/hourly metrics
```

## Interactive Documentation

### API Playground Generation

**Swagger UI Integration**
```html
<!DOCTYPE html>
<html>
<head>
    <title>API Documentation - Interactive Playground</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swagger-ui-dist@latest/swagger-ui.css">
    <style>
        .swagger-ui .topbar { display: none; }
        .swagger-ui .info hgroup.main h2 small {
            background: #89bf04;
            color: white;
        }
    </style>
</head>
<body>
    <div id="swagger-ui"></div>

    <script src="https://cdn.jsdelivr.net/npm/swagger-ui-dist@latest/swagger-ui-bundle.js"></script>
    <script>
        window.onload = function() {
            const ui = SwaggerUIBundle({
                url: "/api/openapi.json",
                dom_id: '#swagger-ui',
                deepLinking: true,
                presets: [
                    SwaggerUIBundle.presets.apis,
                    SwaggerUIBundle.presets.standalone
                ],
                plugins: [
                    SwaggerUIBundle.plugins.DownloadUrl
                ],
                layout: "StandaloneLayout",
                defaultModelExpandDepth: 2,
                defaultModelsExpandDepth: 2,
                displayRequestDuration: true,
                onComplete: function() {
                    // Auto-populate with demo API key
                    ui.preauthorizeApiKey("apiKey", "demo-api-key-12345");

                    // Add custom styling
                    const style = document.createElement('style');
                    style.innerHTML = `
                        .swagger-ui .scheme-container {
                            background: linear-gradient(45deg, #667eea 0%, #764ba2 100%);
                            padding: 20px;
                            border-radius: 8px;
                            margin: 20px 0;
                        }
                    `;
                    document.head.appendChild(style);
                }
            });
            window.ui = ui;
        }
    </script>
</body>
</html>
```

### Code Examples Generator

**Multi-Language Examples**
```python
def generate_code_examples(endpoint, languages=['python', 'javascript', 'curl', 'php']):
    """Generate code examples for API endpoints in multiple languages"""
    examples = {}

    # Python example with requests
    examples['python'] = f'''
import requests
import json

url = "https://api.example.com{endpoint['path']}"
headers = {{
    "Authorization": "Bearer YOUR_API_KEY",
    "Content-Type": "application/json",
    "User-Agent": "MyApp/1.0"
}}

# Make the request
response = requests.{endpoint['method'].lower()}(url, headers=headers)

# Handle the response
if response.status_code == 200:
    data = response.json()
    print(f"Success: {{data}}")
else:
    print(f"Error {{response.status_code}}: {{response.text}}")
'''

    # JavaScript example with fetch
    examples['javascript'] = f'''
const apiUrl = 'https://api.example.com{endpoint['path']}';

const response = await fetch(apiUrl, {{
    method: '{endpoint['method']}',
    headers: {{
        'Authorization': 'Bearer YOUR_API_KEY',
        'Content-Type': 'application/json',
        'User-Agent': 'MyApp/1.0'
    }}
}});

if (response.ok) {{
    const data = await response.json();
    console.log('Success:', data);
}} else {{
    console.error('Error:', response.status, await response.text());
}}
'''

    # cURL example
    examples['curl'] = f'''
curl -X {endpoint['method']} https://api.example.com{endpoint['path']} \\
    -H "Authorization: Bearer YOUR_API_KEY" \\
    -H "Content-Type: application/json" \\
    -H "User-Agent: MyApp/1.0" \\
    -w "\\nResponse Code: %{{http_code}}\\nTotal Time: %{{time_total}}s\\n"
'''

    # PHP example
    examples['php'] = f'''
<?php
$url = 'https://api.example.com{endpoint['path']}';
$headers = [
    'Authorization: Bearer YOUR_API_KEY',
    'Content-Type: application/json',
    'User-Agent: MyApp/1.0'
];

$ch = curl_init();
curl_setopt($ch, CURLOPT_URL, $url);
curl_setopt($ch, CURLOPT_CUSTOMREQUEST, '{endpoint['method']}');
curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);

$response = curl_exec($ch);
$httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
curl_close($ch);

if ($httpCode === 200) {{
    $data = json_decode($response, true);
    echo "Success: " . json_encode($data, JSON_PRETTY_PRINT);
}} else {{
    echo "Error $httpCode: $response";
}}
?>
'''

    return examples
```

## Comprehensive Documentation Generation

### README Generation

**Complete README Template**
```markdown
# ${PROJECT_NAME}

${BADGES}

> ${SHORT_DESCRIPTION}

${HERO_IMAGE}

## 🌟 Features

${FEATURES_LIST}

## 📋 Table of Contents

- [Installation](#installation)
- [Quick Start](#quick-start)
- [API Reference](#api-reference)
- [Architecture](#architecture)
- [Configuration](#configuration)
- [Development](#development)
- [Testing](#testing)
- [Deployment](#deployment)
- [Contributing](#contributing)
- [License](#license)

## 🚀 Installation

### Prerequisites

Before installing, ensure you have:

- Python 3.8+ installed
- PostgreSQL 12+ running
- Redis 6+ available
- Node.js 16+ (for frontend components)

### Package Installation

#### Using pip (Recommended)
```bash
pip install ${PACKAGE_NAME}
```

#### Using Docker
```bash
# Pull the official image
docker pull ${DOCKER_IMAGE}

# Run with default configuration
docker run -p 8000:8000 ${DOCKER_IMAGE}

# Run with custom environment
docker run -p 8000:8000 \\
  -e DATABASE_URL=postgresql://user:pass@host:5432/db \\
  -e REDIS_URL=redis://host:6379/0 \\
  ${DOCKER_IMAGE}
```

#### From Source
```bash
# Clone the repository
git clone https://github.com/${GITHUB_ORG}/${REPO_NAME}.git
cd ${REPO_NAME}

# Create virtual environment
python -m venv venv
source venv/bin/activate  # On Windows: venv\\Scripts\\activate

# Install dependencies
pip install -r requirements.txt
pip install -e .

# Run database migrations
python manage.py migrate

# Start the development server
python manage.py runserver
```

## ⚡ Quick Start

### Basic Usage

```python
${QUICK_START_CODE}

# Example: Create a new user
from ${PACKAGE_NAME} import UserService

# Initialize the service
user_service = UserService()

# Create a user
user = user_service.create_user({
    "email": "user@example.com",
    "username": "johndoe",
    "full_name": "John Doe",
    "password": "secure_password123"
})

print(f"User created with ID: {user.id}")
```

### Configuration

```python
# config.py
import os
from pydantic import BaseSettings

class Settings(BaseSettings):
    database_url: str = os.getenv("DATABASE_URL", "sqlite:///app.db")
    redis_url: str = os.getenv("REDIS_URL", "redis://localhost:6379")
    secret_key: str = os.getenv("SECRET_KEY", "your-secret-key-here")
    debug: bool = os.getenv("DEBUG", "false").lower() == "true"

    class Config:
        env_file = ".env"

settings = Settings()
```

## 📚 Documentation

### Full Documentation
Complete documentation is available at: **[https://docs.${PROJECT_DOMAIN}](https://docs.${PROJECT_DOMAIN})**

### API Reference
- **[REST API Documentation](./docs/api/README.md)** - Complete API reference
- **[Python SDK Reference](./docs/sdk/python.md)** - Python library documentation
- **[JavaScript SDK Reference](./docs/sdk/javascript.md)** - JavaScript/TypeScript library
- **[CLI Reference](./docs/cli/README.md)** - Command-line interface guide

### Guides & Tutorials
- **[Getting Started Guide](./docs/guides/getting-started.md)** - Step-by-step setup
- **[Architecture Overview](./docs/guides/architecture.md)** - System design and components
- **[Best Practices](./docs/guides/best-practices.md)** - Recommended usage patterns
- **[Troubleshooting](./docs/guides/troubleshooting.md)** - Common issues and solutions

## 🏗️ Architecture

${ARCHITECTURE_DIAGRAM}

### System Components

| Component | Purpose | Technology |
|-----------|---------|------------|
| API Gateway | Request routing and rate limiting | Kong/nginx |
| User Service | User management and authentication | Python/FastAPI |
| Database | Data persistence | PostgreSQL |
| Cache | Session and data caching | Redis |
| Queue | Async task processing | Celery/Redis |

## ⚙️ Configuration

### Environment Variables

| Variable | Description | Default | Required |
|----------|-------------|---------|----------|
| `DATABASE_URL` | PostgreSQL connection string | - | Yes |
| `REDIS_URL` | Redis connection string | `redis://localhost:6379` | Yes |
| `SECRET_KEY` | Application secret key | - | Yes |
| `DEBUG` | Enable debug mode | `false` | No |
| `LOG_LEVEL` | Logging level | `INFO` | No |
| `MAX_CONNECTIONS` | Max database connections | `100` | No |

### Configuration File

```yaml
# config.yaml
database:
  url: ${DATABASE_URL}
  pool_size: 20
  max_overflow: 0
  pool_timeout: 30

redis:
  url: ${REDIS_URL}
  max_connections: 50
  socket_timeout: 5

logging:
  level: INFO
  format: "%(asctime)s - %(name)s - %(levelname)s - %(message)s"
  handlers:
    - console
    - file

security:
  secret_key: ${SECRET_KEY}
  jwt_expiry: 3600
  password_min_length: 8
```

## 🛠️ Development

### Setting up Development Environment

```bash
# Clone and setup
git clone https://github.com/${GITHUB_ORG}/${REPO_NAME}.git
cd ${REPO_NAME}

# Setup pre-commit hooks
pip install pre-commit
pre-commit install

# Install development dependencies
pip install -r requirements-dev.txt

# Run tests
pytest

# Start development server with hot reload
uvicorn main:app --reload --host 0.0.0.0 --port 8000
```

### Code Style

We use the following tools for code quality:

- **[Black](https://github.com/psf/black)** - Code formatting
- **[isort](https://pycqa.github.io/isort/)** - Import sorting
- **[Flake8](https://flake8.pycqa.org/)** - Linting
- **[mypy](http://mypy-lang.org/)** - Type checking

```bash
# Format code
black .
isort .

# Check code quality
flake8 .
mypy .

# Run all checks
make lint
```

### Database Migrations

```bash
# Create a new migration
alembic revision --autogenerate -m "Add user table"

# Apply migrations
alembic upgrade head

# Rollback migration
alembic downgrade -1
```

## 🧪 Testing

### Running Tests

```bash
# Run all tests
pytest

# Run with coverage
pytest --cov=src --cov-report=html

# Run specific test file
pytest tests/test_users.py

# Run with verbose output
pytest -v

# Run integration tests
pytest tests/integration/

# Run performance tests
pytest tests/performance/ --benchmark-only
```

### Test Structure

```
tests/
├── unit/           # Unit tests
├── integration/    # Integration tests
├── e2e/           # End-to-end tests
├── performance/   # Performance tests
├── fixtures/      # Test fixtures
└── conftest.py    # Test configuration
```

## 🚀 Deployment

### Docker Deployment

```dockerfile
# Dockerfile
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

### Kubernetes Deployment

```yaml
# k8s-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ${APP_NAME}
spec:
  replicas: 3
  selector:
    matchLabels:
      app: ${APP_NAME}
  template:
    metadata:
      labels:
        app: ${APP_NAME}
    spec:
      containers:
      - name: ${APP_NAME}
        image: ${DOCKER_IMAGE}
        ports:
        - containerPort: 8000
        env:
        - name: DATABASE_URL
          valueFrom:
            secretKeyRef:
              name: app-secrets
              key: database-url
        - name: REDIS_URL
          valueFrom:
            secretKeyRef:
              name: app-secrets
              key: redis-url
```

### Environment Setup

```bash
# Production deployment
export DATABASE_URL="postgresql://user:pass@prod-db:5432/app"
export REDIS_URL="redis://prod-redis:6379/0"
export SECRET_KEY="your-production-secret"
export DEBUG="false"

# Deploy with Docker Compose
docker-compose -f docker-compose.prod.yml up -d

# Deploy to Kubernetes
kubectl apply -f k8s-deployment.yaml
kubectl apply -f k8s-service.yaml
kubectl apply -f k8s-ingress.yaml
```

## 📊 Monitoring & Observability

### Health Checks

```python
# Health check endpoint
@app.get("/health")
async def health_check():
    return {
        "status": "healthy",
        "timestamp": datetime.utcnow().isoformat(),
        "version": "1.0.0",
        "database": await check_database(),
        "redis": await check_redis()
    }
```

### Metrics

Key metrics to monitor:

- **Response time**: P50, P95, P99
- **Error rate**: 4xx and 5xx responses
- **Throughput**: Requests per second
- **Database**: Connection pool usage, query time
- **Cache**: Hit rate, memory usage

## 🤝 Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

### Development Workflow

1. **Fork** the repository
2. **Create** a feature branch (`git checkout -b feature/amazing-feature`)
3. **Commit** your changes (`git commit -m 'Add amazing feature'`)
4. **Push** to the branch (`git push origin feature/amazing-feature`)
5. **Open** a Pull Request

### Code of Conduct

This project follows the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md).

## 📄 License

This project is licensed under the ${LICENSE} License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

${ACKNOWLEDGMENTS}

---

<div align="center">

**[Website](https://${PROJECT_DOMAIN})** •
**[Documentation](https://docs.${PROJECT_DOMAIN})** •
**[API Reference](https://api.${PROJECT_DOMAIN}/docs)** •
**[Support](mailto:support@${PROJECT_DOMAIN})**

Made with ❤️ by the ${PROJECT_NAME} team

</div>
```

## Documentation CI/CD

### Automated Documentation Pipeline

**GitHub Actions Integration**
```yaml
name: Generate and Deploy Documentation

on:
  push:
    branches: [main]
    paths:
      - 'src/**'
      - 'docs/**'
      - 'README.md'
  pull_request:
    branches: [main]
  workflow_dispatch:

jobs:
  generate-docs:
    runs-on: ubuntu-latest
    permissions:
      contents: write
      pages: write
      id-token: write

    steps:
    - name: Checkout repository
      uses: actions/checkout@v4
      with:
        fetch-depth: 0

    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: '3.11'

    - name: Set up Node.js
      uses: actions/setup-node@v4
      with:
        node-version: '18'

    - name: Install documentation dependencies
      run: |
        pip install -r requirements-docs.txt
        npm install -g @redocly/cli
        npm install -g mermaid-cli

    - name: Generate API documentation
      run: |
        # Extract OpenAPI specification from code
        python scripts/extract_openapi.py > docs/api/openapi.json

        # Generate interactive API docs
        redocly build-docs docs/api/openapi.json \\
          --output docs/api/index.html \\
          --theme=openapi

        # Generate API client SDKs
        redocly generate-code docs/api/openapi.json \\
          --output docs/sdk/ \\
          --lang python,javascript,go

    - name: Generate architecture diagrams
      run: |
        # Convert Mermaid diagrams to images
        mmdc -i docs/architecture/system-overview.mmd \\
             -o docs/architecture/system-overview.png \\
             --theme dark --backgroundColor transparent

        mmdc -i docs/architecture/data-flow.mmd \\
             -o docs/architecture/data-flow.png \\
             --theme dark --backgroundColor transparent

    - name: Generate code documentation
      run: |
        # Generate Python API reference
        sphinx-build -b html docs/source docs/build/html

        # Generate TypeScript documentation (if applicable)
        typedoc --out docs/build/typescript src/

    - name: Generate user documentation
      run: |
        # Build GitBook-style documentation
        gitbook build docs/ docs/build/

        # Generate PDF documentation
        prince docs/build/index.html -o docs/build/documentation.pdf

    - name: Run documentation quality checks
      run: |
        # Check for broken links
        markdown-link-check docs/**/*.md

        # Validate OpenAPI specification
        swagger-codegen validate -i docs/api/openapi.json

        # Check documentation coverage
        python scripts/docs_coverage.py

    - name: Deploy to GitHub Pages
      if: github.ref == 'refs/heads/main'
      uses: peaceiris/actions-gh-pages@v3
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        publish_dir: ./docs/build
        enable_jekyll: false
        cname: docs.example.com

    - name: Update documentation metrics
      run: |
        # Generate documentation analytics
        python scripts/docs_analytics.py

        # Update documentation health dashboard
        curl -X POST "${{ secrets.DOCS_WEBHOOK_URL }}" \\
          -H "Content-Type: application/json" \\
          -d '{"status": "updated", "timestamp": "'$(date -Iseconds)'"}'

    - name: Notify team
      if: success()
      uses: 8398a7/action-slack@v3
      with:
        status: success
        text: '📚 Documentation updated successfully! View at https://docs.example.com'
      env:
        SLACK_WEBHOOK_URL: ${{ secrets.SLACK_WEBHOOK }}
```

## Documentation Quality Checks

### Coverage Analysis

**Documentation Coverage Tool**
```python
import ast
import glob
import os
from typing import Dict, List, Tuple

class DocumentationCoverage:
    """Analyze documentation coverage for codebase"""

    def __init__(self, source_path: str = "src/", docs_path: str = "docs/"):
        self.source_path = source_path
        self.docs_path = docs_path
        self.results = {
            'total_functions': 0,
            'documented_functions': 0,
            'total_classes': 0,
            'documented_classes': 0,
            'total_modules': 0,
            'documented_modules': 0,
            'missing_docs': [],
            'quality_score': 0.0
        }

    def analyze_coverage(self) -> Dict:
        """Perform comprehensive documentation coverage analysis"""

        # Analyze Python files
        for file_path in glob.glob(f"{self.source_path}/**/*.py", recursive=True):
            if self._should_skip_file(file_path):
                continue

            self._analyze_python_file(file_path)

        # Analyze TypeScript files (if applicable)
        for file_path in glob.glob(f"{self.source_path}/**/*.ts", recursive=True):
            if self._should_skip_file(file_path):
                continue

            self._analyze_typescript_file(file_path)

        # Calculate coverage scores
        self._calculate_coverage_scores()

        # Generate detailed report
        return self._generate_report()

    def _analyze_python_file(self, file_path: str) -> None:
        """Analyze documentation coverage for Python file"""
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                tree = ast.parse(f.read())
        except (SyntaxError, UnicodeDecodeError):
            return

        # Check module docstring
        self.results['total_modules'] += 1
        if ast.get_docstring(tree):
            self.results['documented_modules'] += 1
        else:
            self._add_missing_doc('module', file_path, 1)

        # Analyze functions and classes
        for node in ast.walk(tree):
            if isinstance(node, ast.FunctionDef):
                self._check_function_documentation(node, file_path)
            elif isinstance(node, ast.ClassDef):
                self._check_class_documentation(node, file_path)

    def _check_function_documentation(self, node: ast.FunctionDef, file_path: str) -> None:
        """Check if function has adequate documentation"""
        self.results['total_functions'] += 1

        docstring = ast.get_docstring(node)
        if docstring:
            # Check docstring quality
            if self._is_quality_docstring(docstring, node):
                self.results['documented_functions'] += 1
            else:
                self._add_missing_doc('function', file_path, node.lineno,
                                    f"{node.name} - poor docstring quality")
        else:
            self._add_missing_doc('function', file_path, node.lineno, node.name)

    def _is_quality_docstring(self, docstring: str, node: ast.FunctionDef) -> bool:
        """Assess docstring quality"""
        quality_checks = {
            'has_description': len(docstring.strip()) > 10,
            'has_args_section': 'Args:' in docstring or 'Parameters:' in docstring,
            'has_returns_section': 'Returns:' in docstring or 'Return:' in docstring,
            'has_examples': 'Example' in docstring or '>>>' in docstring
        }

        # Require description always
        if not quality_checks['has_description']:
            return False

        # Functions with parameters should document them
        if len(node.args.args) > 1:  # Excluding 'self'
            if not quality_checks['has_args_section']:
                return False

        # Functions with returns should document them
        if node.returns or any('return' in ast.dump(n) for n in ast.walk(node)):
            if not quality_checks['has_returns_section']:
                return False

        return True

    def _generate_report(self) -> Dict:
        """Generate comprehensive documentation report"""
        report = {
            **self.results,
            'coverage_by_type': {
                'functions': (
                    self.results['documented_functions'] /
                    max(self.results['total_functions'], 1) * 100
                ),
                'classes': (
                    self.results['documented_classes'] /
                    max(self.results['total_classes'], 1) * 100
                ),
                'modules': (
                    self.results['documented_modules'] /
                    max(self.results['total_modules'], 1) * 100
                )
            },
            'recommendations': self._generate_recommendations(),
            'file_analysis': self._analyze_files_by_coverage()
        }

        return report

    def _generate_recommendations(self) -> List[str]:
        """Generate actionable recommendations"""
        recommendations = []

        if self.results['quality_score'] < 70:
            recommendations.append(
                "📚 Documentation coverage is below 70%. Focus on documenting "
                "public APIs and core business logic first."
            )

        if len(self.results['missing_docs']) > 10:
            recommendations.append(
                "⚠️ Many items lack documentation. Consider using automated "
                "docstring generation tools to bootstrap documentation."
            )

        undocumented_functions = (
            self.results['total_functions'] - self.results['documented_functions']
        )
        if undocumented_functions > 5:
            recommendations.append(
                f"🔧 {undocumented_functions} functions need documentation. "
                "Start with public methods and complex algorithms."
            )

        return recommendations
```

## Parameters

### Required
- None (analyzes current project structure)

### Optional
- `--type`: Documentation type (`api`, `readme`, `guide`, `reference`, `changelog`)
- `--format`: Output format (`markdown`, `html`, `pdf`, `openapi`, `gitbook`)
- `--output`: Output directory or file path
- `--include`: Specific files or directories to include
- `--template`: Documentation template to use
- `--sections`: Sections to include in generated docs
- `--interactive`: Generate interactive documentation with examples
- `--deploy`: Automatically deploy to specified platform
- `--coverage`: Generate documentation coverage report

## Integration with Other Commands

The `/docs-gen` command works seamlessly with other utilities:

```bash
# Document after scaffolding
/scaffold fastapi-service user-api
/docs-gen --type api --format openapi --interactive

# Generate comprehensive project documentation
/scaffold react-app frontend
/docs-gen --type readme --sections all --badges
/docs-gen --type guide --format gitbook --deploy

# Document with architecture review
/docs-gen --type reference --include-diagrams
/review --checks documentation --scope docs/
```

## Best Practices

### For Documentation Generation
1. **Living Documentation**: Keep docs synchronized with code changes
2. **User-Focused**: Write for your audience, not just for completeness
3. **Interactive Examples**: Include runnable code examples
4. **Visual Elements**: Use diagrams and screenshots where helpful

### For Documentation Maintenance
1. **Automated Updates**: Use CI/CD to keep documentation current
2. **Quality Checks**: Validate links, examples, and formatting
3. **Version Management**: Maintain docs for multiple versions
4. **Analytics**: Track documentation usage and user feedback

## Troubleshooting

### Common Issues

**Code analysis fails**
- Ensure source code is syntactically valid
- Check file encoding (UTF-8 recommended)
- Verify import dependencies are available

**Generated documentation is incomplete**
- Review docstring format and completeness
- Check that all required files are included
- Validate template configuration

**Deployment fails**
- Verify deployment credentials and permissions
- Check output format compatibility with target platform
- Review CI/CD pipeline configuration

---

**Remember**: Great documentation is a force multiplier for your project. The `/docs-gen` command ensures your documentation is comprehensive, current, and compelling.