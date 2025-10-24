# Python Style Guide 🐍

A comprehensive Python coding standard based on PEP 8 with extended guidelines for modern Python development, type hints, and best practices.

## 📋 Table of Contents

- [Code Layout](#code-layout)
- [Naming Conventions](#naming-conventions)
- [Type Hints](#type-hints)
- [Code Structure](#code-structure)
- [Best Practices](#best-practices)
- [Tooling Configuration](#tooling-configuration)

## 📐 Code Layout

### Indentation and Line Length
```python
# ✅ Good: 4 spaces for indentation
def calculate_total_price(items, tax_rate=0.08, discount=0.0):
    subtotal = sum(item.price * item.quantity for item in items)
    tax_amount = subtotal * tax_rate
    discount_amount = subtotal * discount
    return subtotal + tax_amount - discount_amount

# ✅ Good: Line breaks for long expressions (max 88 characters)
very_long_variable_name = some_function_with_long_name(
    argument_one,
    argument_two,
    argument_three,
    argument_four,
)

# ✅ Good: Align with opening delimiter
result = some_function(
    first_argument, second_argument,
    third_argument, fourth_argument
)
```

### Imports
```python
# ✅ Good: Import order
# 1. Standard library imports
import os
import sys
from pathlib import Path
from typing import Dict, List, Optional, Union

# 2. Related third-party imports
import requests
from sqlalchemy import Column, Integer, String
from pydantic import BaseModel

# 3. Local application/library specific imports
from myapp.models import User
from myapp.services.auth import AuthService
from myapp.utils.logger import get_logger

# ✅ Good: Absolute imports preferred
from myapp.services.user_service import UserService

# ❌ Bad: Relative imports (avoid when possible)
from ..services.user_service import UserService
```

### Blank Lines
```python
# ✅ Good: Two blank lines around top-level classes and functions
import os


class UserService:
    """Service for managing user operations."""

    def __init__(self, database_url: str) -> None:
        self.database_url = database_url


def standalone_function() -> None:
    """A standalone utility function."""
    pass


class AnotherClass:
    """Another top-level class."""

    def method_one(self) -> None:
        """First method."""
        pass

    def method_two(self) -> None:
        """Second method with single blank line separation."""
        pass
```

## 🏷️ Naming Conventions

### Variables and Functions
```python
# ✅ Good: snake_case for variables and functions
user_name = "john_doe"
max_retry_count = 3

def calculate_total_price(items: List[Item]) -> float:
    """Calculate the total price including tax and discounts."""
    return sum(item.price * item.quantity for item in items)

def is_user_authenticated(user_id: str) -> bool:
    """Check if user is authenticated."""
    return auth_service.check_authentication(user_id)

# ❌ Bad: camelCase or PascalCase for variables/functions
userName = "john_doe"  # Don't do this
def calculateTotalPrice(items): pass  # Don't do this
```

### Classes and Exceptions
```python
# ✅ Good: PascalCase for classes
class UserService:
    """Service for handling user operations."""

    def __init__(self, database_connection: DatabaseConnection) -> None:
        self._database = database_connection

class PaymentProcessor:
    """Handles payment processing operations."""
    pass

# ✅ Good: Exception classes end with 'Error'
class ValidationError(Exception):
    """Raised when data validation fails."""

    def __init__(self, message: str, field: str) -> None:
        super().__init__(message)
        self.field = field

class UserNotFoundError(Exception):
    """Raised when a user cannot be found."""
    pass
```

### Constants
```python
# ✅ Good: SCREAMING_SNAKE_CASE for constants
MAX_UPLOAD_SIZE = 10 * 1024 * 1024  # 10MB
API_BASE_URL = "https://api.example.com"
DEFAULT_TIMEOUT_SECONDS = 30

# ✅ Good: Use Enum for related constants
from enum import Enum

class UserRole(Enum):
    ADMIN = "admin"
    USER = "user"
    MODERATOR = "moderator"

class OrderStatus(Enum):
    PENDING = "pending"
    CONFIRMED = "confirmed"
    SHIPPED = "shipped"
    DELIVERED = "delivered"
    CANCELLED = "cancelled"
```

### Private Methods and Attributes
```python
class UserService:
    def __init__(self, api_key: str) -> None:
        self._api_key = api_key  # Protected (internal use)
        self.__secret_token = None  # Private (name mangling)

    def get_user(self, user_id: str) -> User:
        """Public method."""
        return self._fetch_user_data(user_id)

    def _fetch_user_data(self, user_id: str) -> User:
        """Protected method - internal implementation detail."""
        headers = self._build_headers()
        # Implementation

    def _build_headers(self) -> Dict[str, str]:
        """Protected helper method."""
        return {"Authorization": f"Bearer {self._api_key}"}
```

## 🔷 Type Hints

### Basic Type Hints
```python
from typing import Dict, List, Optional, Union, Tuple, Set

# ✅ Good: Basic type hints
def process_user_data(
    user_id: str,
    age: int,
    is_active: bool,
    score: float
) -> Dict[str, Union[str, int, bool, float]]:
    """Process user data and return formatted result."""
    return {
        "id": user_id,
        "age": age,
        "active": is_active,
        "score": score
    }

# ✅ Good: Collection type hints
def get_user_names(users: List[User]) -> List[str]:
    """Extract names from list of users."""
    return [user.name for user in users]

def count_by_role(users: List[User]) -> Dict[str, int]:
    """Count users by their role."""
    counts: Dict[str, int] = {}
    for user in users:
        counts[user.role] = counts.get(user.role, 0) + 1
    return counts
```

### Advanced Type Hints
```python
from typing import Protocol, TypeVar, Generic, Callable, Any

# ✅ Good: Protocol for structural typing
class Drawable(Protocol):
    def draw(self) -> None:
        """Draw the object."""
        ...

def render_shape(shape: Drawable) -> None:
    """Render any drawable shape."""
    shape.draw()

# ✅ Good: Generic types
T = TypeVar('T')

class Repository(Generic[T]):
    """Generic repository pattern."""

    def __init__(self, model_class: type[T]) -> None:
        self.model_class = model_class

    def find_by_id(self, id: str) -> Optional[T]:
        """Find entity by ID."""
        # Implementation
        return None

# ✅ Good: Callable type hints
def apply_operation(
    numbers: List[int],
    operation: Callable[[int], int]
) -> List[int]:
    """Apply operation to each number."""
    return [operation(num) for num in numbers]

# Usage
squared = apply_operation([1, 2, 3], lambda x: x ** 2)
```

### Union Types and Optional
```python
from typing import Union, Optional

# ✅ Good: Use Optional for nullable values
def find_user(user_id: str) -> Optional[User]:
    """Find user by ID, return None if not found."""
    # Implementation
    return None

# ✅ Good: Union types for multiple possible types
def process_id(user_id: Union[str, int]) -> str:
    """Process user ID regardless of type."""
    return str(user_id)

# ✅ Better: Use Python 3.10+ union syntax when available
def process_id_modern(user_id: str | int) -> str:
    """Process user ID with modern union syntax."""
    return str(user_id)
```

### Dataclasses and Pydantic Models
```python
from dataclasses import dataclass, field
from typing import List, Optional
from pydantic import BaseModel, validator

# ✅ Good: Dataclass for simple data containers
@dataclass
class User:
    """Represents a user in the system."""
    id: str
    name: str
    email: str
    age: int
    is_active: bool = True
    tags: List[str] = field(default_factory=list)

# ✅ Good: Pydantic for data validation
class UserCreateRequest(BaseModel):
    """Request model for creating a user."""
    name: str
    email: str
    age: int

    @validator('email')
    def validate_email(cls, v: str) -> str:
        """Validate email format."""
        if '@' not in v:
            raise ValueError('Invalid email format')
        return v.lower()

    @validator('age')
    def validate_age(cls, v: int) -> int:
        """Validate age range."""
        if v < 0 or v > 150:
            raise ValueError('Age must be between 0 and 150')
        return v
```

## 🏗️ Code Structure

### Class Design
```python
from abc import ABC, abstractmethod
from typing import Protocol

# ✅ Good: Well-structured class with clear organization
class UserService:
    """Service for managing user operations."""

    # Class constants
    MAX_LOGIN_ATTEMPTS = 3
    DEFAULT_SESSION_TIMEOUT = 3600

    def __init__(
        self,
        repository: UserRepository,
        logger: Logger,
        config: AppConfig
    ) -> None:
        """Initialize the user service."""
        self._repository = repository
        self._logger = logger
        self._config = config
        self._login_attempts: Dict[str, int] = {}

    # Public interface methods
    async def create_user(self, user_data: UserCreateRequest) -> User:
        """Create a new user."""
        self._validate_user_data(user_data)

        user = await self._repository.create(user_data)
        self._logger.info(f"User created: {user.id}")

        return user

    async def authenticate_user(
        self,
        email: str,
        password: str
    ) -> Optional[User]:
        """Authenticate user with email and password."""
        if self._is_account_locked(email):
            raise AccountLockedError(f"Account locked: {email}")

        user = await self._repository.find_by_email(email)
        if not user or not self._verify_password(password, user.password_hash):
            self._increment_login_attempts(email)
            return None

        self._reset_login_attempts(email)
        return user

    # Private helper methods
    def _validate_user_data(self, user_data: UserCreateRequest) -> None:
        """Validate user data before creation."""
        if not user_data.email or '@' not in user_data.email:
            raise ValidationError("Invalid email format")

    def _is_account_locked(self, email: str) -> bool:
        """Check if account is locked due to failed attempts."""
        return self._login_attempts.get(email, 0) >= self.MAX_LOGIN_ATTEMPTS

    def _verify_password(self, password: str, password_hash: str) -> bool:
        """Verify password against hash."""
        # Implementation
        return True
```

### Error Handling
```python
# ✅ Good: Custom exception hierarchy
class UserServiceError(Exception):
    """Base exception for user service errors."""
    pass

class ValidationError(UserServiceError):
    """Raised when input validation fails."""

    def __init__(self, message: str, field: Optional[str] = None) -> None:
        super().__init__(message)
        self.field = field

class UserNotFoundError(UserServiceError):
    """Raised when a user cannot be found."""

    def __init__(self, user_id: str) -> None:
        super().__init__(f"User not found: {user_id}")
        self.user_id = user_id

# ✅ Good: Proper exception handling
async def get_user_safely(user_id: str) -> Optional[User]:
    """Get user with proper error handling."""
    try:
        return await user_service.get_user(user_id)
    except UserNotFoundError:
        logger.warning(f"User not found: {user_id}")
        return None
    except Exception as e:
        logger.error(f"Unexpected error getting user {user_id}: {e}")
        raise
```

### Context Managers
```python
from contextlib import contextmanager, asynccontextmanager
from typing import Iterator, AsyncIterator

# ✅ Good: Custom context manager
@contextmanager
def database_transaction() -> Iterator[DatabaseConnection]:
    """Context manager for database transactions."""
    conn = get_database_connection()
    trans = conn.begin()
    try:
        yield conn
        trans.commit()
    except Exception:
        trans.rollback()
        raise
    finally:
        conn.close()

# ✅ Good: Async context manager
@asynccontextmanager
async def async_database_transaction() -> AsyncIterator[AsyncDatabaseConnection]:
    """Async context manager for database transactions."""
    conn = await get_async_database_connection()
    trans = await conn.begin()
    try:
        yield conn
        await trans.commit()
    except Exception:
        await trans.rollback()
        raise
    finally:
        await conn.close()

# Usage
async def create_user_with_transaction(user_data: UserCreateRequest) -> User:
    """Create user within a transaction."""
    async with async_database_transaction() as conn:
        user = await conn.users.create(user_data)
        await conn.audit_log.create({
            "action": "user_created",
            "user_id": user.id
        })
        return user
```

## ⭐ Best Practices

### Function Design
```python
# ✅ Good: Single responsibility, clear purpose
def calculate_shipping_cost(
    weight: float,
    distance: float,
    shipping_method: str
) -> float:
    """Calculate shipping cost based on weight, distance, and method."""
    base_rate = SHIPPING_RATES[shipping_method]
    weight_factor = weight * WEIGHT_MULTIPLIER
    distance_factor = distance * DISTANCE_MULTIPLIER

    return base_rate + weight_factor + distance_factor

# ✅ Good: Use keyword arguments for clarity
def create_user_account(
    *,  # Force keyword-only arguments
    name: str,
    email: str,
    age: int,
    is_admin: bool = False,
    send_welcome_email: bool = True
) -> User:
    """Create a new user account."""
    # Implementation

# Usage
user = create_user_account(
    name="John Doe",
    email="john@example.com",
    age=30,
    is_admin=False
)
```

### List Comprehensions and Generators
```python
# ✅ Good: Simple list comprehensions
active_users = [user for user in users if user.is_active]
user_names = [user.name.upper() for user in active_users]

# ✅ Good: Generator expressions for memory efficiency
total_score = sum(user.score for user in users if user.is_active)

# ✅ Good: Complex logic in separate function
def is_eligible_for_promotion(user: User) -> bool:
    """Check if user is eligible for promotion."""
    return (
        user.is_active and
        user.score >= 100 and
        user.days_since_signup >= 30
    )

eligible_users = [user for user in users if is_eligible_for_promotion(user)]

# ❌ Bad: Complex logic in comprehension
eligible_users = [
    user for user in users
    if user.is_active and user.score >= 100 and user.days_since_signup >= 30
]
```

### String Formatting
```python
# ✅ Good: f-strings for simple formatting
name = "John"
age = 30
message = f"Hello {name}, you are {age} years old"

# ✅ Good: f-strings with expressions
total = f"Total: ${price * quantity:.2f}"

# ✅ Good: format() for complex formatting
template = "User {name} has {count} {item_type}{plural}"
message = template.format(
    name=user.name,
    count=item_count,
    item_type="message",
    plural="s" if item_count != 1 else ""
)

# ✅ Good: Multi-line f-strings
query = f"""
    SELECT id, name, email
    FROM users
    WHERE age >= {min_age}
    AND is_active = {is_active}
    ORDER BY created_at DESC
"""
```

### Async/Await Patterns
```python
import asyncio
from typing import List

# ✅ Good: Proper async function definition
async def fetch_user_data(user_id: str) -> User:
    """Fetch user data asynchronously."""
    async with httpx.AsyncClient() as client:
        response = await client.get(f"/api/users/{user_id}")
        response.raise_for_status()
        return User(**response.json())

# ✅ Good: Concurrent operations with asyncio.gather
async def fetch_multiple_users(user_ids: List[str]) -> List[User]:
    """Fetch multiple users concurrently."""
    tasks = [fetch_user_data(user_id) for user_id in user_ids]
    return await asyncio.gather(*tasks)

# ✅ Good: Error handling with asyncio
async def fetch_user_safely(user_id: str) -> Optional[User]:
    """Fetch user with error handling."""
    try:
        return await fetch_user_data(user_id)
    except httpx.HTTPStatusError as e:
        if e.response.status_code == 404:
            return None
        raise
    except Exception as e:
        logger.error(f"Failed to fetch user {user_id}: {e}")
        raise
```

## 🛠️ Tooling Configuration

### Black Configuration
```toml
# pyproject.toml
[tool.black]
line-length = 88
target-version = ['py39']
include = '\.pyi?$'
extend-exclude = '''
/(
  # directories
  \.eggs
  | \.git
  | \.hg
  | \.mypy_cache
  | \.tox
  | \.venv
  | build
  | dist
)/
'''
```

### Isort Configuration
```toml
# pyproject.toml
[tool.isort]
profile = "black"
multi_line_output = 3
line_length = 88
known_first_party = ["myapp"]
known_third_party = ["fastapi", "pydantic", "sqlalchemy"]
sections = ["FUTURE", "STDLIB", "THIRDPARTY", "FIRSTPARTY", "LOCALFOLDER"]
```

### Flake8 Configuration
```ini
# .flake8
[flake8]
max-line-length = 88
extend-ignore = E203, W503
exclude = .git,__pycache__,docs/source/conf.py,old,build,dist
max-complexity = 10
```

### MyPy Configuration
```toml
# pyproject.toml
[tool.mypy]
python_version = "3.9"
warn_return_any = true
warn_unused_configs = true
disallow_untyped_defs = true
disallow_incomplete_defs = true
check_untyped_defs = true
disallow_untyped_decorators = true
no_implicit_optional = true
warn_redundant_casts = true
warn_unused_ignores = true
warn_no_return = true
warn_unreachable = true
strict_equality = true
```

### Pytest Configuration
```toml
# pyproject.toml
[tool.pytest.ini_options]
testpaths = ["tests"]
python_files = ["test_*.py", "*_test.py"]
python_classes = ["Test*"]
python_functions = ["test_*"]
addopts = [
    "--strict-markers",
    "--strict-config",
    "--cov=src",
    "--cov-report=html",
    "--cov-report=term-missing",
]
```

## 📝 Documentation

### Docstring Style (Google Style)
```python
def calculate_compound_interest(
    principal: float,
    rate: float,
    time: int,
    compound_frequency: int = 1
) -> float:
    """Calculate compound interest.

    Args:
        principal: The initial amount of money.
        rate: The annual interest rate (as a decimal).
        time: The time period in years.
        compound_frequency: Number of times interest is compounded per year.
            Defaults to 1 (annually).

    Returns:
        The final amount after compound interest.

    Raises:
        ValueError: If any of the numeric arguments are negative.

    Examples:
        >>> calculate_compound_interest(1000, 0.05, 10)
        1628.89

        >>> calculate_compound_interest(1000, 0.05, 10, 12)
        1643.62
    """
    if principal < 0 or rate < 0 or time < 0:
        raise ValueError("All numeric arguments must be non-negative")

    return principal * (1 + rate / compound_frequency) ** (compound_frequency * time)
```

## 🎯 Quick Reference Checklist

### Before Committing
- [ ] Code formatted with Black
- [ ] Imports sorted with isort
- [ ] Type hints on all functions
- [ ] Docstrings for public functions
- [ ] No flake8 violations
- [ ] MyPy passes without errors
- [ ] Tests written and passing

### Code Review Checklist
- [ ] Functions have single responsibility
- [ ] Error handling is appropriate
- [ ] Type hints are accurate and helpful
- [ ] Variable names are descriptive
- [ ] No magic numbers or strings
- [ ] Async/await used correctly
- [ ] Performance considerations addressed

This Python style guide ensures clean, maintainable, and pythonic code that follows modern Python best practices and type safety principles.