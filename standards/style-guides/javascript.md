# JavaScript Style Guide 📜

A comprehensive style guide for modern JavaScript development, covering ES6+ features, best practices, and common patterns.

## 🎯 Overview

This style guide promotes:
- **Readability**: Clear, self-documenting code
- **Consistency**: Uniform style across the codebase
- **Maintainability**: Easy to modify and extend
- **Performance**: Efficient JavaScript patterns
- **Modern Standards**: ES6+ features and best practices

## 📏 Formatting Rules

### Indentation and Spacing
```javascript
// ✅ Good: 2 spaces for indentation
function calculateTotal(items) {
  const total = items.reduce((sum, item) => {
    return sum + item.price;
  }, 0);

  return total;
}

// ❌ Bad: 4 spaces or tabs
function calculateTotal(items) {
    const total = items.reduce((sum, item) => {
        return sum + item.price;
    }, 0);

    return total;
}
```

### Line Length
- **Maximum**: 100 characters per line
- **Rationale**: Improves readability and allows side-by-side editing

```javascript
// ✅ Good: Break long lines appropriately
const userPreferences = getUserPreferences({
  userId: currentUser.id,
  includeDefaults: true,
  validatePermissions: true
});

// ❌ Bad: Long line that's hard to read
const userPreferences = getUserPreferences({ userId: currentUser.id, includeDefaults: true, validatePermissions: true });
```

### Semicolons
- **Rule**: Always use semicolons
- **Rationale**: Prevents ASI (Automatic Semicolon Insertion) issues

```javascript
// ✅ Good: Explicit semicolons
const message = 'Hello, world!';
const numbers = [1, 2, 3, 4, 5];

// ❌ Bad: Missing semicolons
const message = 'Hello, world!'
const numbers = [1, 2, 3, 4, 5]
```

### Trailing Commas
- **Rule**: Use trailing commas in multiline structures
- **Rationale**: Cleaner diffs, easier to add/remove items

```javascript
// ✅ Good: Trailing commas
const config = {
  apiUrl: 'https://api.example.com',
  timeout: 5000,
  retries: 3, // <- trailing comma
};

const colors = [
  'red',
  'green',
  'blue', // <- trailing comma
];

// ❌ Bad: No trailing commas
const config = {
  apiUrl: 'https://api.example.com',
  timeout: 5000,
  retries: 3
};
```

## 🔤 Naming Conventions

### Variables and Functions
- **Style**: camelCase
- **Descriptive**: Use intention-revealing names
- **No abbreviations**: Prefer clarity over brevity

```javascript
// ✅ Good: Clear, descriptive names
const userAccountBalance = 1500.75;
const isEmailVerified = true;
const maxRetryAttempts = 3;

function calculateMonthlyPayment(principal, rate, term) {
  return (principal * rate) / (1 - Math.pow(1 + rate, -term));
}

function validateEmailAddress(email) {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

// ❌ Bad: Unclear, abbreviated names
const uab = 1500.75;
const isEmlVer = true;
const maxRetAttempts = 3;

function calcMP(p, r, t) {
  return (p * r) / (1 - Math.pow(1 + r, -t));
}

function valEml(e) {
  return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(e);
}
```

### Constants
- **Style**: SCREAMING_SNAKE_CASE for module-level constants
- **Grouping**: Group related constants in objects

```javascript
// ✅ Good: Well-named constants
const API_BASE_URL = 'https://api.example.com/v1';
const MAX_FILE_SIZE = 10 * 1024 * 1024; // 10MB
const DEFAULT_TIMEOUT = 30000;

// Group related constants
const HTTP_STATUS = {
  OK: 200,
  NOT_FOUND: 404,
  INTERNAL_SERVER_ERROR: 500,
};

const COLORS = {
  PRIMARY: '#007bff',
  SUCCESS: '#28a745',
  DANGER: '#dc3545',
};

// ❌ Bad: Unclear constant names
const URL = 'https://api.example.com/v1';
const MAX_SIZE = 10485760;
const TIMEOUT = 30000;
```

### Classes
- **Style**: PascalCase
- **Descriptive**: Use noun phrases that describe the entity

```javascript
// ✅ Good: Clear class names
class UserAccountManager {
  constructor(userId) {
    this.userId = userId;
    this.preferences = new Map();
  }

  updatePreference(key, value) {
    this.preferences.set(key, value);
  }
}

class PaymentProcessor {
  processPayment(amount, paymentMethod) {
    // Implementation
  }
}

// ❌ Bad: Unclear class names
class UAM {
  // ...
}

class Processor {
  // Too generic
}
```

### Files and Directories
- **Style**: kebab-case for files, camelCase for directories
- **Descriptive**: File names should indicate content

```bash
# ✅ Good: Clear file structure
src/
├── components/
│   ├── user-profile.js
│   ├── payment-form.js
│   └── navigation-bar.js
├── services/
│   ├── api-client.js
│   ├── auth-service.js
│   └── data-validator.js
└── utils/
    ├── date-helpers.js
    ├── string-utils.js
    └── math-functions.js

# ❌ Bad: Unclear naming
src/
├── comp/
│   ├── up.js
│   ├── pf.js
│   └── nav.js
├── svc/
│   ├── api.js
│   ├── auth.js
│   └── val.js
```

## 🏗️ Code Structure

### Function Declaration vs Expression
- **Preference**: Function expressions for consistency with arrow functions
- **Hoisting**: Be aware of hoisting differences

```javascript
// ✅ Good: Consistent function expressions
const calculateTax = (amount, rate) => {
  return amount * rate;
};

const processOrder = function(order) {
  // Complex logic here
  return processedOrder;
};

// ✅ Also good: Function declarations for main functions
function initializeApp() {
  setupEventListeners();
  loadUserData();
  renderUI();
}

// ❌ Bad: Mixing styles inconsistently
function calculateTax(amount, rate) {
  return amount * rate;
}

const processOrder = (order) => {
  // Inconsistent with above
};
```

### Arrow Functions
- **Use when**: Function is short and doesn't need `this` binding
- **Avoid when**: Function is complex or needs its own `this` context

```javascript
// ✅ Good: Appropriate arrow function usage
const numbers = [1, 2, 3, 4, 5];
const doubled = numbers.map(n => n * 2);
const evens = numbers.filter(n => n % 2 === 0);

const processUser = (user) => ({
  id: user.id,
  name: user.name.toUpperCase(),
  isActive: user.status === 'active'
});

// ✅ Good: Regular function when this context is needed
const eventHandler = {
  count: 0,

  handleClick: function() {
    this.count++; // Needs this context
    console.log(`Clicked ${this.count} times`);
  }
};

// ❌ Bad: Arrow function where this is needed
const eventHandler = {
  count: 0,

  handleClick: () => {
    this.count++; // this is undefined!
  }
};
```

### Object and Array Destructuring
- **Use destructuring** for cleaner code
- **Provide defaults** where appropriate

```javascript
// ✅ Good: Destructuring with defaults
const { name, age = 25, email } = user;
const [first, second, ...rest] = items;

function processUserData({
  userId,
  preferences = {},
  isActive = true
}) {
  // Function body
}

// ✅ Good: Nested destructuring
const {
  user: { name, email },
  settings: { theme = 'light' }
} = response;

// ❌ Bad: Not using destructuring
const name = user.name;
const age = user.age || 25;
const email = user.email;

const first = items[0];
const second = items[1];
const rest = items.slice(2);
```

## 🚀 Modern JavaScript Features

### Template Literals
- **Use template literals** for string interpolation
- **Multi-line strings** instead of concatenation

```javascript
// ✅ Good: Template literals
const greeting = `Hello, ${userName}!`;
const query = `
  SELECT name, email, created_at
  FROM users
  WHERE status = '${status}'
  AND created_at > '${startDate}'
`;

const html = `
  <div class="user-card">
    <h3>${user.name}</h3>
    <p>${user.email}</p>
  </div>
`;

// ❌ Bad: String concatenation
const greeting = 'Hello, ' + userName + '!';
const query = 'SELECT name, email, created_at ' +
  'FROM users ' +
  'WHERE status = \'' + status + '\' ' +
  'AND created_at > \'' + startDate + '\'';
```

### Async/Await vs Promises
- **Prefer async/await** for better readability
- **Use Promise.all** for concurrent operations

```javascript
// ✅ Good: Clean async/await
async function fetchUserData(userId) {
  try {
    const user = await api.getUser(userId);
    const preferences = await api.getUserPreferences(userId);
    const permissions = await api.getUserPermissions(userId);

    return {
      user,
      preferences,
      permissions
    };
  } catch (error) {
    console.error('Failed to fetch user data:', error);
    throw error;
  }
}

// ✅ Good: Concurrent operations
async function fetchAllUserData(userId) {
  try {
    const [user, preferences, permissions] = await Promise.all([
      api.getUser(userId),
      api.getUserPreferences(userId),
      api.getUserPermissions(userId)
    ]);

    return { user, preferences, permissions };
  } catch (error) {
    console.error('Failed to fetch user data:', error);
    throw error;
  }
}

// ❌ Bad: Promise chains when async/await is clearer
function fetchUserData(userId) {
  return api.getUser(userId)
    .then(user => {
      return api.getUserPreferences(userId)
        .then(preferences => {
          return api.getUserPermissions(userId)
            .then(permissions => {
              return { user, preferences, permissions };
            });
        });
    })
    .catch(error => {
      console.error('Failed to fetch user data:', error);
      throw error;
    });
}
```

### Modules (ES6 Import/Export)
- **Use named exports** for utilities and components
- **Default exports** for main functionality

```javascript
// ✅ Good: utils/math-helpers.js
export const add = (a, b) => a + b;
export const multiply = (a, b) => a * b;
export const PI = 3.14159;

export function calculateCircleArea(radius) {
  return PI * radius * radius;
}

// ✅ Good: services/user-service.js (default export for main class)
class UserService {
  constructor(apiClient) {
    this.api = apiClient;
  }

  async getUser(id) {
    return this.api.get(`/users/${id}`);
  }
}

export default UserService;

// ✅ Good: Importing
import UserService from './services/user-service.js';
import { add, multiply, calculateCircleArea } from './utils/math-helpers.js';

// ❌ Bad: CommonJS in ES6 environment
const UserService = require('./services/user-service.js');
const { add, multiply } = require('./utils/math-helpers.js');
```

## 🎯 Best Practices

### Error Handling
- **Always handle errors** explicitly
- **Provide meaningful error messages**
- **Use custom error types** when appropriate

```javascript
// ✅ Good: Comprehensive error handling
class ValidationError extends Error {
  constructor(field, value) {
    super(`Invalid value '${value}' for field '${field}'`);
    this.name = 'ValidationError';
    this.field = field;
    this.value = value;
  }
}

async function createUser(userData) {
  try {
    validateUserData(userData);

    const user = await api.createUser(userData);
    return user;
  } catch (error) {
    if (error instanceof ValidationError) {
      // Handle validation errors specifically
      console.error(`Validation failed: ${error.message}`);
      throw error;
    }

    if (error.status === 409) {
      throw new Error('User already exists');
    }

    // Log unexpected errors
    console.error('Unexpected error creating user:', error);
    throw new Error('Failed to create user');
  }
}

function validateUserData(userData) {
  if (!userData.email || !isValidEmail(userData.email)) {
    throw new ValidationError('email', userData.email);
  }

  if (!userData.name || userData.name.length < 2) {
    throw new ValidationError('name', userData.name);
  }
}

// ❌ Bad: Poor error handling
async function createUser(userData) {
  const user = await api.createUser(userData); // No error handling
  return user;
}

function validateUserData(userData) {
  if (!userData.email) {
    throw new Error('Bad email'); // Vague error message
  }
}
```

### Performance Considerations
- **Avoid unnecessary computations** in loops
- **Use appropriate data structures**
- **Minimize DOM manipulations**

```javascript
// ✅ Good: Efficient operations
function processLargeDataset(items) {
  // Pre-compute expensive operations
  const itemsById = new Map(items.map(item => [item.id, item]));
  const categories = new Set(items.map(item => item.category));

  return items.map(item => {
    // Fast lookup instead of array.find()
    const relatedItem = itemsById.get(item.relatedId);

    return {
      ...item,
      categoryCount: categories.size,
      hasRelated: Boolean(relatedItem)
    };
  });
}

// Batch DOM operations
function updateUserList(users) {
  const fragment = document.createDocumentFragment();

  users.forEach(user => {
    const element = createUserElement(user);
    fragment.appendChild(element);
  });

  // Single DOM operation
  document.getElementById('user-list').appendChild(fragment);
}

// ❌ Bad: Inefficient operations
function processLargeDataset(items) {
  return items.map(item => {
    // Expensive operation inside loop
    const categories = items.map(i => i.category);
    const uniqueCategories = [...new Set(categories)];

    // O(n) operation for each item
    const relatedItem = items.find(i => i.id === item.relatedId);

    return {
      ...item,
      categoryCount: uniqueCategories.length,
      hasRelated: Boolean(relatedItem)
    };
  });
}

// Multiple DOM operations
function updateUserList(users) {
  const container = document.getElementById('user-list');

  users.forEach(user => {
    const element = createUserElement(user);
    container.appendChild(element); // DOM operation in loop
  });
}
```

### Memory Management
- **Remove event listeners** when done
- **Clear timeouts and intervals**
- **Avoid memory leaks** with closures

```javascript
// ✅ Good: Proper cleanup
class ComponentManager {
  constructor() {
    this.eventHandlers = new Map();
    this.timers = new Set();
  }

  addEventHandler(element, event, handler) {
    element.addEventListener(event, handler);

    // Track for cleanup
    if (!this.eventHandlers.has(element)) {
      this.eventHandlers.set(element, new Map());
    }
    this.eventHandlers.get(element).set(event, handler);
  }

  startTimer(callback, delay) {
    const timerId = setTimeout(callback, delay);
    this.timers.add(timerId);
    return timerId;
  }

  cleanup() {
    // Remove all event listeners
    this.eventHandlers.forEach((events, element) => {
      events.forEach((handler, event) => {
        element.removeEventListener(event, handler);
      });
    });

    // Clear all timers
    this.timers.forEach(timerId => {
      clearTimeout(timerId);
    });

    this.eventHandlers.clear();
    this.timers.clear();
  }
}

// ❌ Bad: Memory leaks
class BadComponentManager {
  constructor() {
    this.data = new Map();
  }

  addEventHandler(element, event, handler) {
    element.addEventListener(event, handler);
    // No cleanup tracking - memory leak!
  }

  processData(items) {
    items.forEach(item => {
      // Closure captures entire items array
      const timer = setTimeout(() => {
        this.data.set(item.id, item); // Keeps reference forever
      }, 1000);
      // Timer never cleared - memory leak!
    });
  }
}
```

## 🛠️ Tool Configuration

### ESLint Configuration
```json
{
  "extends": [
    "eslint:recommended",
    "@typescript-eslint/recommended"
  ],
  "parserOptions": {
    "ecmaVersion": 2022,
    "sourceType": "module"
  },
  "rules": {
    "semi": ["error", "always"],
    "quotes": ["error", "single"],
    "comma-dangle": ["error", "always-multiline"],
    "no-unused-vars": "error",
    "no-console": "warn",
    "prefer-const": "error",
    "no-var": "error",
    "object-shorthand": "error",
    "prefer-template": "error",
    "prefer-arrow-callback": "error"
  }
}
```

### Prettier Configuration
```json
{
  "semi": true,
  "singleQuote": true,
  "tabWidth": 2,
  "useTabs": false,
  "printWidth": 100,
  "trailingComma": "es5",
  "bracketSpacing": true,
  "arrowParens": "avoid"
}
```

### Package.json Scripts
```json
{
  "scripts": {
    "lint": "eslint src/**/*.js",
    "lint:fix": "eslint src/**/*.js --fix",
    "format": "prettier --write src/**/*.js",
    "format:check": "prettier --check src/**/*.js"
  }
}
```

## 📚 Additional Resources

### Recommended Reading
- [Airbnb JavaScript Style Guide](https://github.com/airbnb/javascript)
- [MDN JavaScript Guide](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide)
- [Clean Code JavaScript](https://github.com/ryanmcdermott/clean-code-javascript)
- [JavaScript: The Good Parts](https://www.oreilly.com/library/view/javascript-the-good/9780596517748/)

### Tools and Extensions
- **ESLint**: Linting and code quality
- **Prettier**: Code formatting
- **Husky**: Git hooks for automated checks
- **Jest**: Testing framework
- **Babel**: JavaScript transpilation

---

**Remember**: These are guidelines, not absolute rules. The most important thing is consistency within your team and project. Adapt these standards to fit your specific needs and context.