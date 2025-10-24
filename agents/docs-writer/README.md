# Documentation Writer Agent 📚

Expert technical documentation specialist creating comprehensive, user-friendly documentation that bridges the gap between complex technical concepts and practical understanding.

## 🎯 Overview

The **@docs-writer** agent specializes in creating clear, actionable documentation for diverse audiences. From API references to user tutorials, it transforms complex technical information into accessible, well-structured content that helps users succeed.

## ✨ Working with Skills (NEW!)

This agent works in coordination with **two documentation skills** that handle automatic updates:

**api-documenter Skill (Autonomous):**
- Auto-generates OpenAPI/Swagger specs from code comments
- Extracts endpoint documentation from framework decorators
- Creates basic request/response examples
- Tools: Read, Write, Grep (lightweight)

**readme-updater Skill (Autonomous):**
- Keeps README.md current with project changes
- Updates installation steps when dependencies change
- Adds new features to Features section automatically
- Updates configuration docs when env vars added
- Tools: Read, Write, Edit, Grep (lightweight)

**This Agent (Manual Expert):**
- Invoked explicitly for comprehensive documentation sites (`@docs-writer`)
- User guides, tutorials, troubleshooting sections
- Architecture documentation and decision records (ADRs)
- Migration guides and deployment documentation
- Tools: Read, Write, Edit, Bash, Grep, Glob, WebFetch (full access)

### Typical Workflow

1. **Skills maintain** → API specs and README stay current automatically
2. **You invoke this agent** → `@docs-writer Create user guide with tutorials`
3. **Agent creates** → Comprehensive documentation building on skill-generated basics
4. **Complementary, not duplicate** → Focus on user-facing content, architecture, guides

**See:** [Skills Guide](../../skills/README.md) for more information

## 🚀 Capabilities

### Documentation Types
- **API Documentation** - Complete endpoint references with examples
- **User Guides** - Step-by-step tutorials and walkthroughs
- **Technical References** - Comprehensive function and class documentation
- **README Files** - Project overviews and getting-started guides
- **Troubleshooting Guides** - Problem-solving documentation
- **Architecture Documentation** - System design and decision records
- **Integration Guides** - Third-party service integration instructions
- **Release Notes** - Version updates and changelog creation

### Multi-Audience Support
- **End Users** - Simple, task-oriented documentation
- **Developers** - Technical implementation details
- **System Administrators** - Deployment and configuration guides
- **Product Managers** - Feature specifications and requirements
- **QA Engineers** - Testing procedures and acceptance criteria

### Output Formats
- **Markdown** - GitHub-friendly documentation
- **HTML** - Rich web-based documentation
- **OpenAPI/Swagger** - Interactive API documentation
- **PDF** - Professional, printable documentation
- **Wiki** - Collaborative documentation platforms

## 🛠️ Usage Examples

### API Documentation
```javascript
@docs-writer Create comprehensive API documentation for this endpoint:

// POST /api/users/:userId/profile
router.post('/api/users/:userId/profile', auth, upload.single('avatar'), async (req, res) => {
  try {
    const { userId } = req.params;
    const { name, email, bio, preferences } = req.body;
    const avatarFile = req.file;

    // Validate user permissions
    if (req.user.id !== userId && !req.user.isAdmin) {
      return res.status(403).json({ error: 'Insufficient permissions' });
    }

    // Process avatar upload
    let avatarUrl = null;
    if (avatarFile) {
      avatarUrl = await uploadToCloudinary(avatarFile);
    }

    // Update user profile
    const updatedUser = await User.findByIdAndUpdate(
      userId,
      {
        name,
        email,
        bio,
        preferences: JSON.parse(preferences || '{}'),
        avatar: avatarUrl
      },
      { new: true, runValidators: true }
    ).select('-password');

    res.json({
      success: true,
      user: updatedUser
    });

  } catch (error) {
    if (error.name === 'ValidationError') {
      return res.status(400).json({ error: error.message });
    }
    res.status(500).json({ error: 'Internal server error' });
  }
});
```

**Agent Response:**
```markdown
# User Profile API

## Update User Profile

Updates a user's profile information including personal details and avatar image.

### Endpoint
```http
POST /api/users/{userId}/profile
```

### Authentication
Requires valid JWT token in Authorization header.
- Users can only update their own profile
- Admin users can update any profile

### Parameters

#### Path Parameters
| Parameter | Type   | Required | Description |
|-----------|--------|----------|-------------|
| userId    | string | Yes      | Unique user identifier |

#### Request Headers
| Header        | Type   | Required | Description |
|---------------|--------|----------|-------------|
| Authorization | string | Yes      | Bearer JWT token |
| Content-Type  | string | Yes      | multipart/form-data |

#### Request Body (Form Data)
| Field       | Type   | Required | Description | Constraints |
|-------------|--------|----------|-------------|-------------|
| name        | string | No       | User's display name | 2-50 characters |
| email       | string | No       | User's email address | Valid email format |
| bio         | string | No       | User biography | Max 500 characters |
| preferences | string | No       | JSON string of user preferences | Valid JSON |
| avatar      | file   | No       | Profile image upload | JPG/PNG, max 5MB |

### Request Example

```bash
curl -X POST "https://api.example.com/api/users/123/profile" \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..." \
  -F "name=John Doe" \
  -F "email=john.doe@example.com" \
  -F "bio=Software developer passionate about clean code" \
  -F "preferences={\"theme\":\"dark\",\"notifications\":true}" \
  -F "avatar=@profile.jpg"
```

### Response Format

#### Success Response (200 OK)
```json
{
  "success": true,
  "user": {
    "id": "123",
    "name": "John Doe",
    "email": "john.doe@example.com",
    "bio": "Software developer passionate about clean code",
    "avatar": "https://cloudinary.com/image/upload/v1234567890/avatars/user123.jpg",
    "preferences": {
      "theme": "dark",
      "notifications": true
    },
    "updatedAt": "2025-09-16T10:30:00Z"
  }
}
```

### Error Responses

#### Validation Error (400 Bad Request)
```json
{
  "error": "Validation failed: Email format is invalid"
}
```

#### Permission Denied (403 Forbidden)
```json
{
  "error": "Insufficient permissions"
}
```

#### User Not Found (404 Not Found)
```json
{
  "error": "User not found"
}
```

#### Server Error (500 Internal Server Error)
```json
{
  "error": "Internal server error"
}
```

### Usage Examples

#### JavaScript/Axios
```javascript
const updateProfile = async (userId, profileData) => {
  const formData = new FormData();
  formData.append('name', profileData.name);
  formData.append('email', profileData.email);
  formData.append('bio', profileData.bio);
  formData.append('preferences', JSON.stringify(profileData.preferences));

  if (profileData.avatar) {
    formData.append('avatar', profileData.avatar);
  }

  try {
    const response = await axios.post(
      `/api/users/${userId}/profile`,
      formData,
      {
        headers: {
          'Authorization': `Bearer ${authToken}`,
          'Content-Type': 'multipart/form-data'
        }
      }
    );

    return response.data;
  } catch (error) {
    throw new Error(error.response.data.error);
  }
};
```

#### Python/Requests
```python
import requests

def update_user_profile(user_id, auth_token, profile_data, avatar_file=None):
    url = f"https://api.example.com/api/users/{user_id}/profile"

    headers = {
        'Authorization': f'Bearer {auth_token}'
    }

    data = {
        'name': profile_data.get('name'),
        'email': profile_data.get('email'),
        'bio': profile_data.get('bio'),
        'preferences': json.dumps(profile_data.get('preferences', {}))
    }

    files = {}
    if avatar_file:
        files['avatar'] = open(avatar_file, 'rb')

    try:
        response = requests.post(url, headers=headers, data=data, files=files)
        response.raise_for_status()
        return response.json()
    except requests.exceptions.RequestException as e:
        raise Exception(f"Profile update failed: {e}")
    finally:
        if avatar_file and 'avatar' in files:
            files['avatar'].close()
```

### Implementation Notes

#### Security Considerations
- File uploads are validated for type and size
- User permissions are checked before updates
- Input sanitization prevents XSS attacks
- Rate limiting recommended for file uploads

#### Performance Considerations
- Avatar uploads are processed asynchronously
- Large files may take additional processing time
- Consider implementing progress indicators for file uploads

#### Best Practices
- Validate file types on both client and server
- Provide clear error messages for validation failures
- Implement retry logic for failed uploads
- Cache user profile data appropriately

### Testing

#### Test Cases to Consider
- Valid profile updates with all fields
- Partial updates (only some fields)
- File upload with various formats and sizes
- Permission validation for different user roles
- Error handling for invalid data
- Network timeout scenarios

#### Example Test
```javascript
describe('Profile Update API', () => {
  test('updates profile with valid data', async () => {
    const profileData = {
      name: 'Updated Name',
      bio: 'New bio text'
    };

    const response = await request(app)
      .post('/api/users/123/profile')
      .set('Authorization', `Bearer ${validToken}`)
      .field('name', profileData.name)
      .field('bio', profileData.bio)
      .expect(200);

    expect(response.body.success).toBe(true);
    expect(response.body.user.name).toBe(profileData.name);
  });
});
```

### Related Endpoints
- `GET /api/users/{userId}` - Get user profile
- `DELETE /api/users/{userId}/avatar` - Remove avatar
- `GET /api/users/{userId}/preferences` - Get user preferences

### Changelog
- **v1.2.0**: Added preferences field support
- **v1.1.0**: Added avatar upload functionality
- **v1.0.0**: Initial profile update endpoint
```

### README Generation
```bash
@docs-writer Generate a comprehensive README for this React component library:

Project: UI Component Library
Features:
- 20+ reusable components
- TypeScript support
- Storybook integration
- Jest testing
- Styled-components theming
- Accessibility compliance
```

**Agent Response:**
```markdown
# React UI Component Library 🎨

> A comprehensive collection of accessible, customizable React components built with TypeScript and styled-components.

[![npm version](https://badge.fury.io/js/@company/ui-components.svg)](https://www.npmjs.com/package/@company/ui-components)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Coverage Status](https://coveralls.io/repos/github/company/ui-components/badge.svg?branch=main)](https://coveralls.io/github/company/ui-components?branch=main)
[![Build Status](https://github.com/company/ui-components/workflows/CI/badge.svg)](https://github.com/company/ui-components/actions)

## ✨ Features

- 🧩 **20+ Components** - Battle-tested, production-ready components
- 🔷 **TypeScript First** - Full type safety and excellent developer experience
- 🎨 **Themeable** - Customizable design system with styled-components
- ♿ **Accessible** - WCAG 2.1 AA compliant components
- 📚 **Storybook** - Interactive component documentation and playground
- 🧪 **Well Tested** - Comprehensive Jest and React Testing Library coverage
- 📦 **Tree Shakeable** - Import only what you need
- 🌍 **i18n Ready** - Internationalization support built-in

## 🚀 Quick Start

### Installation

```bash
# npm
npm install @company/ui-components

# yarn
yarn add @company/ui-components

# pnpm
pnpm add @company/ui-components
```

### Setup

```typescript
import React from 'react';
import { ThemeProvider, Button, Card } from '@company/ui-components';

function App() {
  return (
    <ThemeProvider>
      <Card>
        <Button variant="primary">Get Started</Button>
      </Card>
    </ThemeProvider>
  );
}

export default App;
```

## 📚 Documentation

- 🎮 **[Interactive Storybook](https://storybook.company.com)** - Explore all components
- 📖 **[API Reference](./docs/api.md)** - Detailed component documentation
- 🎨 **[Design System](./docs/design-system.md)** - Colors, typography, spacing
- ♿ **[Accessibility Guide](./docs/accessibility.md)** - WCAG compliance details

## 🧩 Available Components

### Layout Components
- **Container** - Responsive content wrapper
- **Grid** - Flexible CSS Grid system
- **Stack** - Vertical spacing component
- **Divider** - Visual content separator

### Form Components
- **Button** - Primary action component
- **Input** - Text input with validation
- **TextArea** - Multi-line text input
- **Select** - Dropdown selection
- **Checkbox** - Boolean input control
- **Radio** - Single selection control
- **Switch** - Toggle control

### Data Display
- **Card** - Content container
- **Table** - Data table with sorting
- **List** - Ordered and unordered lists
- **Badge** - Status indicators
- **Avatar** - User profile images
- **Tooltip** - Contextual information

### Navigation
- **Menu** - Navigation menu system
- **Breadcrumb** - Hierarchical navigation
- **Pagination** - Page navigation control
- **Tabs** - Content organization

### Feedback
- **Alert** - Contextual messages
- **Modal** - Dialog overlays
- **Toast** - Notification system
- **Progress** - Loading indicators
- **Skeleton** - Content placeholders

## 💡 Usage Examples

### Basic Button Usage
```typescript
import { Button } from '@company/ui-components';

<Button
  variant="primary"
  size="large"
  disabled={false}
  onClick={() => console.log('Clicked!')}
>
  Click me
</Button>
```

### Form with Validation
```typescript
import { Input, Button, Card } from '@company/ui-components';

function LoginForm() {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');

  return (
    <Card>
      <Input
        type="email"
        label="Email"
        value={email}
        onChange={setEmail}
        required
        error={emailError}
      />
      <Input
        type="password"
        label="Password"
        value={password}
        onChange={setPassword}
        required
        error={passwordError}
      />
      <Button type="submit" variant="primary" fullWidth>
        Sign In
      </Button>
    </Card>
  );
}
```

### Custom Theming
```typescript
import { ThemeProvider, createTheme } from '@company/ui-components';

const customTheme = createTheme({
  colors: {
    primary: '#007acc',
    secondary: '#6c757d',
    success: '#28a745',
    danger: '#dc3545',
    warning: '#ffc107',
    info: '#17a2b8',
  },
  typography: {
    fontFamily: '"Inter", sans-serif',
    fontSize: {
      sm: '0.875rem',
      base: '1rem',
      lg: '1.125rem',
      xl: '1.25rem',
    },
  },
  spacing: {
    xs: '0.25rem',
    sm: '0.5rem',
    md: '1rem',
    lg: '1.5rem',
    xl: '2rem',
  },
});

function App() {
  return (
    <ThemeProvider theme={customTheme}>
      {/* Your app components */}
    </ThemeProvider>
  );
}
```

## 🛠️ Development

### Prerequisites
- Node.js 16+ and npm 7+
- Git

### Setup Development Environment

```bash
# Clone the repository
git clone https://github.com/company/ui-components.git
cd ui-components

# Install dependencies
npm install

# Start development server
npm run dev

# Open Storybook
npm run storybook
```

### Available Scripts

```bash
# Development
npm run dev          # Start development server
npm run storybook    # Launch Storybook

# Building
npm run build        # Build for production
npm run build:watch  # Build with file watching

# Testing
npm run test         # Run tests
npm run test:watch   # Run tests in watch mode
npm run test:coverage # Generate coverage report

# Linting & Formatting
npm run lint         # ESLint check
npm run lint:fix     # Fix ESLint issues
npm run format       # Prettier formatting
npm run type-check   # TypeScript checking
```

### Project Structure

```
src/
├── components/          # Component implementations
│   ├── Button/
│   │   ├── Button.tsx
│   │   ├── Button.test.tsx
│   │   ├── Button.stories.tsx
│   │   └── index.ts
│   └── ...
├── theme/              # Design system tokens
│   ├── colors.ts
│   ├── typography.ts
│   └── spacing.ts
├── utils/              # Utility functions
├── hooks/              # Custom React hooks
└── index.ts           # Main exports

docs/                   # Documentation
├── api.md
├── design-system.md
└── accessibility.md

.storybook/            # Storybook configuration
```

## 🧪 Testing

We use Jest and React Testing Library for comprehensive testing:

```bash
# Run all tests
npm run test

# Run tests with coverage
npm run test:coverage

# Run tests in watch mode
npm run test:watch
```

### Writing Tests

```typescript
import { render, screen, fireEvent } from '@testing-library/react';
import { Button } from '../Button';

describe('Button', () => {
  test('renders with correct text', () => {
    render(<Button>Click me</Button>);
    expect(screen.getByText('Click me')).toBeInTheDocument();
  });

  test('handles click events', () => {
    const handleClick = jest.fn();
    render(<Button onClick={handleClick}>Click me</Button>);

    fireEvent.click(screen.getByText('Click me'));
    expect(handleClick).toHaveBeenCalledTimes(1);
  });
});
```

## ♿ Accessibility

All components follow WCAG 2.1 AA guidelines:

- **Keyboard Navigation** - Full keyboard support
- **Screen Reader** - ARIA labels and descriptions
- **Focus Management** - Visible focus indicators
- **Color Contrast** - Meets contrast requirements
- **Semantic HTML** - Proper HTML structure

### Accessibility Testing
```bash
# Run accessibility tests
npm run test:a11y

# Audit with axe-core
npm run audit:accessibility
```

## 🎨 Design Tokens

Our design system is built on consistent tokens:

### Colors
```typescript
const colors = {
  primary: {
    50: '#e3f2fd',
    100: '#bbdefb',
    500: '#2196f3', // Primary
    900: '#0d47a1',
  },
  semantic: {
    success: '#4caf50',
    warning: '#ff9800',
    error: '#f44336',
    info: '#2196f3',
  },
};
```

### Typography
```typescript
const typography = {
  fontFamily: {
    sans: '"Inter", system-ui, sans-serif',
    mono: '"Fira Code", monospace',
  },
  fontSize: {
    xs: '0.75rem',
    sm: '0.875rem',
    base: '1rem',
    lg: '1.125rem',
    xl: '1.25rem',
  },
};
```

## 📦 Contributing

We welcome contributions! Please see our [Contributing Guide](CONTRIBUTING.md) for details.

### Quick Contribution Steps
1. Fork the repository
2. Create a feature branch: `git checkout -b feature/amazing-component`
3. Make your changes and add tests
4. Run the test suite: `npm run test`
5. Submit a pull request

### Component Guidelines
- Follow existing patterns and naming conventions
- Include TypeScript types and interfaces
- Write comprehensive tests (aim for 90%+ coverage)
- Add Storybook stories with all variants
- Document props and usage examples
- Ensure accessibility compliance

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Support

- 📖 **[Documentation](https://ui.company.com/docs)** - Comprehensive guides
- 🐛 **[Issues](https://github.com/company/ui-components/issues)** - Bug reports and feature requests
- 💬 **[Discussions](https://github.com/company/ui-components/discussions)** - Community support
- 📧 **[Email](mailto:ui-components@company.com)** - Direct support

## 🗺️ Roadmap

### Version 2.0 (Q4 2025)
- [ ] Dark mode theme variants
- [ ] Advanced data visualization components
- [ ] Motion and animation system
- [ ] Mobile-optimized components

### Version 2.1 (Q1 2026)
- [ ] Form validation framework
- [ ] Drag and drop utilities
- [ ] Advanced table features
- [ ] Component composition patterns

## ⭐ Show Your Support

If this library helps your project, please consider:
- ⭐ Starring the repository
- 🐛 Reporting bugs and suggesting features
- 🤝 Contributing improvements
- 📢 Sharing with your team

---

**Built with ❤️ by the UI Team at Company**

*Making beautiful, accessible interfaces simple for everyone.*
```

### Troubleshooting Guide
```typescript
@docs-writer Create a troubleshooting guide for this error handling system:

class ErrorHandler {
  static handleError(error, context = {}) {
    const errorInfo = {
      message: error.message,
      stack: error.stack,
      timestamp: new Date().toISOString(),
      context,
      type: error.constructor.name
    };

    switch (error.constructor.name) {
      case 'ValidationError':
        return this.handleValidationError(error, errorInfo);
      case 'DatabaseError':
        return this.handleDatabaseError(error, errorInfo);
      case 'NetworkError':
        return this.handleNetworkError(error, errorInfo);
      case 'AuthenticationError':
        return this.handleAuthError(error, errorInfo);
      default:
        return this.handleGenericError(error, errorInfo);
    }
  }
}
```

**Agent Response:**
```markdown
# Error Handling Troubleshooting Guide 🔧

This guide helps you diagnose and resolve common issues with the application's error handling system.

## 📋 Quick Diagnosis

### Is Your Error Being Caught?
1. Check if error appears in console/logs
2. Verify error handler is properly imported
3. Ensure try-catch blocks are in place
4. Confirm error handling middleware is configured

### Common Symptoms
- **Silent failures** - Errors not logged or displayed
- **Generic error messages** - Specific error types not handled
- **Stack trace missing** - Error context information lost
- **Repeated errors** - Same error occurring multiple times

## 🔍 Error Types & Solutions

### 1. ValidationError

#### Symptoms
```javascript
ValidationError: Required field 'email' is missing
ValidationError: Invalid email format
ValidationError: Password must be at least 8 characters
```

#### Common Causes
- Missing required form fields
- Invalid data format
- Client-side validation bypassed
- Schema validation rules not met

#### Solutions

**✅ Check Input Validation**
```javascript
// Ensure proper validation before submission
const validateUserData = (userData) => {
  if (!userData.email) {
    throw new ValidationError('Email is required');
  }

  if (!isValidEmail(userData.email)) {
    throw new ValidationError('Invalid email format');
  }

  if (userData.password && userData.password.length < 8) {
    throw new ValidationError('Password must be at least 8 characters');
  }
};
```

**✅ Frontend Form Validation**
```javascript
// Add client-side validation
const handleSubmit = async (formData) => {
  try {
    validateUserData(formData);
    await submitForm(formData);
  } catch (error) {
    if (error instanceof ValidationError) {
      setFormErrors(error.message);
      return;
    }
    throw error; // Re-throw non-validation errors
  }
};
```

**✅ Server-Side Validation**
```javascript
// Ensure server validates all inputs
app.post('/api/users', (req, res) => {
  try {
    validateUserData(req.body);
    // Process valid data
  } catch (error) {
    if (error instanceof ValidationError) {
      return res.status(400).json({
        error: 'Validation failed',
        details: error.message
      });
    }
    throw error;
  }
});
```

### 2. DatabaseError

#### Symptoms
```javascript
DatabaseError: Connection timeout
DatabaseError: Duplicate key violation
DatabaseError: Table 'users' doesn't exist
DatabaseError: Foreign key constraint failed
```

#### Common Causes
- Database connection issues
- Query syntax errors
- Schema mismatches
- Constraint violations

#### Solutions

**✅ Connection Troubleshooting**
```javascript
// Check database connection
const testConnection = async () => {
  try {
    await db.ping();
    console.log('Database connection successful');
  } catch (error) {
    console.error('Database connection failed:', error);
    // Implement retry logic
    setTimeout(testConnection, 5000);
  }
};
```

**✅ Query Error Handling**
```javascript
// Handle specific database errors
const createUser = async (userData) => {
  try {
    return await db.users.create(userData);
  } catch (error) {
    if (error.code === 'SQLITE_CONSTRAINT_UNIQUE') {
      throw new ValidationError('User with this email already exists');
    }

    if (error.code === 'CONNECTION_TIMEOUT') {
      throw new DatabaseError('Database is currently unavailable. Please try again.');
    }

    throw new DatabaseError(`Database operation failed: ${error.message}`);
  }
};
```

**✅ Migration Check**
```bash
# Ensure database schema is up to date
npm run migrate
npm run seed  # If applicable
```

### 3. NetworkError

#### Symptoms
```javascript
NetworkError: Failed to fetch
NetworkError: Request timeout
NetworkError: Network unreachable
NetworkError: CORS policy violation
```

#### Common Causes
- API endpoint unavailable
- Network connectivity issues
- CORS configuration problems
- Request timeout

#### Solutions

**✅ API Availability Check**
```javascript
// Check if API is reachable
const checkAPIHealth = async () => {
  try {
    const response = await fetch('/api/health');
    if (!response.ok) {
      throw new Error(`API returned ${response.status}`);
    }
    return true;
  } catch (error) {
    throw new NetworkError('API is currently unavailable');
  }
};
```

**✅ Retry Logic**
```javascript
// Implement exponential backoff
const fetchWithRetry = async (url, options, maxRetries = 3) => {
  let lastError;

  for (let attempt = 1; attempt <= maxRetries; attempt++) {
    try {
      const response = await fetch(url, {
        ...options,
        timeout: 10000 // 10 second timeout
      });

      if (response.ok) {
        return response;
      }

      throw new Error(`HTTP ${response.status}: ${response.statusText}`);

    } catch (error) {
      lastError = error;

      if (attempt === maxRetries) {
        break;
      }

      // Exponential backoff: wait 1s, 2s, 4s...
      await new Promise(resolve =>
        setTimeout(resolve, Math.pow(2, attempt - 1) * 1000)
      );
    }
  }

  throw new NetworkError(`Request failed after ${maxRetries} attempts: ${lastError.message}`);
};
```

**✅ CORS Configuration**
```javascript
// Server-side CORS setup
app.use(cors({
  origin: process.env.ALLOWED_ORIGINS?.split(',') || 'http://localhost:3000',
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization']
}));
```

### 4. AuthenticationError

#### Symptoms
```javascript
AuthenticationError: Invalid token
AuthenticationError: Token expired
AuthenticationError: Unauthorized access
AuthenticationError: Invalid credentials
```

#### Common Causes
- Expired JWT tokens
- Invalid login credentials
- Missing authorization headers
- Token format issues

#### Solutions

**✅ Token Validation**
```javascript
// Client-side token handling
const handleAuthError = (error) => {
  if (error instanceof AuthenticationError) {
    // Clear invalid token
    localStorage.removeItem('authToken');

    // Redirect to login
    window.location.href = '/login';

    // Show user-friendly message
    toast.error('Your session has expired. Please log in again.');
  }
};
```

**✅ Token Refresh**
```javascript
// Automatic token refresh
const refreshToken = async () => {
  try {
    const refreshToken = localStorage.getItem('refreshToken');
    const response = await fetch('/api/auth/refresh', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ refreshToken })
    });

    if (!response.ok) {
      throw new AuthenticationError('Failed to refresh token');
    }

    const { accessToken } = await response.json();
    localStorage.setItem('authToken', accessToken);

    return accessToken;
  } catch (error) {
    handleAuthError(error);
    throw error;
  }
};
```

**✅ Request Interceptor**
```javascript
// Axios interceptor for automatic token refresh
axios.interceptors.response.use(
  (response) => response,
  async (error) => {
    const originalRequest = error.config;

    if (error.response?.status === 401 && !originalRequest._retry) {
      originalRequest._retry = true;

      try {
        const newToken = await refreshToken();
        originalRequest.headers.Authorization = `Bearer ${newToken}`;
        return axios(originalRequest);
      } catch (refreshError) {
        handleAuthError(refreshError);
        return Promise.reject(refreshError);
      }
    }

    return Promise.reject(error);
  }
);
```

## 🔧 Debugging Tools

### 1. Error Logging Enhancement
```javascript
// Enhanced error logging
const logError = (error, context) => {
  const logData = {
    timestamp: new Date().toISOString(),
    error: {
      name: error.constructor.name,
      message: error.message,
      stack: error.stack
    },
    context: {
      userId: context.userId,
      action: context.action,
      url: window?.location?.href,
      userAgent: navigator?.userAgent,
      ...context
    }
  };

  console.error('Error occurred:', logData);

  // Send to monitoring service
  if (process.env.NODE_ENV === 'production') {
    sendToErrorTracking(logData);
  }
};
```

### 2. Error Boundary Component
```javascript
// React Error Boundary
class ErrorBoundary extends React.Component {
  constructor(props) {
    super(props);
    this.state = { hasError: false, error: null };
  }

  static getDerivedStateFromError(error) {
    return { hasError: true, error };
  }

  componentDidCatch(error, errorInfo) {
    logError(error, {
      component: 'ErrorBoundary',
      errorInfo
    });
  }

  render() {
    if (this.state.hasError) {
      return (
        <div className="error-fallback">
          <h2>Something went wrong</h2>
          <details>
            <summary>Error details</summary>
            <pre>{this.state.error?.message}</pre>
          </details>
          <button onClick={() => window.location.reload()}>
            Refresh Page
          </button>
        </div>
      );
    }

    return this.props.children;
  }
}
```

### 3. Development Error Panel
```javascript
// Development-only error panel
if (process.env.NODE_ENV === 'development') {
  window.addEventListener('error', (event) => {
    console.group('🚨 Global Error Caught');
    console.error('Error:', event.error);
    console.error('File:', event.filename);
    console.error('Line:', event.lineno);
    console.error('Column:', event.colno);
    console.groupEnd();
  });

  window.addEventListener('unhandledrejection', (event) => {
    console.group('🚨 Unhandled Promise Rejection');
    console.error('Reason:', event.reason);
    console.groupEnd();
  });
}
```

## 📊 Monitoring & Prevention

### 1. Error Rate Monitoring
```javascript
// Track error rates
const errorMetrics = {
  total: 0,
  byType: {},

  track(error) {
    this.total++;
    const type = error.constructor.name;
    this.byType[type] = (this.byType[type] || 0) + 1;

    // Alert if error rate is high
    if (this.total % 10 === 0) {
      this.checkThresholds();
    }
  },

  checkThresholds() {
    const recentErrors = this.getRecentErrors();
    if (recentErrors > 5) {
      this.alertHighErrorRate(recentErrors);
    }
  }
};
```

### 2. Health Checks
```javascript
// Application health monitoring
const healthCheck = {
  async database() {
    try {
      await db.ping();
      return { status: 'healthy', responseTime: Date.now() };
    } catch (error) {
      return { status: 'unhealthy', error: error.message };
    }
  },

  async external_apis() {
    const checks = await Promise.allSettled([
      fetch('/api/service1/health'),
      fetch('/api/service2/health')
    ]);

    return {
      status: checks.every(c => c.status === 'fulfilled') ? 'healthy' : 'degraded',
      details: checks
    };
  }
};
```

## 🚨 Emergency Procedures

### When All Else Fails

1. **Check System Status**
   ```bash
   # System resources
   top
   df -h
   free -m
   ```

2. **Review Recent Logs**
   ```bash
   # Application logs
   tail -f /var/log/app.log

   # System logs
   journalctl -f
   ```

3. **Restart Services**
   ```bash
   # Restart application
   sudo systemctl restart myapp

   # Restart database
   sudo systemctl restart postgresql
   ```

4. **Contact Support**
   - Include error logs and context
   - Provide steps to reproduce
   - Note the timestamp of the issue

## 📞 Getting Help

### When to Escalate
- **Critical errors** affecting multiple users
- **Security-related** authentication errors
- **Data loss** potential in database errors
- **System unavailability** network/infrastructure issues

### Support Channels
- 🔧 **Technical Issues**: [GitHub Issues](https://github.com/company/project/issues)
- 💬 **Quick Questions**: [Slack #dev-support](https://company.slack.com/channels/dev-support)
- 🚨 **Critical Issues**: [On-call Engineer](tel:+1-555-0123)
- 📧 **Email Support**: [support@company.com](mailto:support@company.com)

### Information to Include
1. **Error message** and full stack trace
2. **Steps to reproduce** the issue
3. **Environment details** (dev/staging/prod)
4. **User context** (if user-specific)
5. **Recent changes** that might be related

---

**Remember**: Most errors are fixable with systematic debugging. Take it step by step! 🛠️
```

## 🎯 Documentation Best Practices

### Structure Guidelines
1. **Clear Hierarchy** - Use consistent heading levels
2. **Scannable Content** - Bullet points, code blocks, tables
3. **Progressive Disclosure** - Basic to advanced information
4. **Cross-References** - Link related sections
5. **Visual Elements** - Diagrams, screenshots, examples

### Writing Style
- **Active Voice** - Clear, direct instructions
- **Concise Language** - Eliminate unnecessary words
- **User-Focused** - Address reader's needs directly
- **Consistent Terminology** - Use standard terms throughout

### Content Types

#### API Documentation
- Complete endpoint reference
- Request/response examples
- Error code explanations
- Authentication requirements
- Rate limiting information

#### User Guides
- Step-by-step tutorials
- Common use cases
- Troubleshooting sections
- Best practices
- Tips and tricks

#### Technical References
- Complete function/class documentation
- Parameter descriptions
- Return value specifications
- Usage examples
- Related functions/classes

## 🤝 Integration Examples

### Confluence Integration
```bash
# Export documentation to Confluence
@docs-writer --format confluence --upload --space "DEV"
```

### GitHub Wiki Integration
```bash
# Generate GitHub Wiki pages
@docs-writer --format wiki --output ./wiki/
```

### GitBook Integration
```bash
# Create GitBook-compatible documentation
@docs-writer --format gitbook --structure book
```

---

**Ready to create exceptional documentation? 📚**

Use `@docs-writer` followed by your code or documentation requirements to generate clear, comprehensive, and user-friendly documentation that helps your users succeed!