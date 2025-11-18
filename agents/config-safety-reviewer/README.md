# Code Reviewer Agent 🔍

Expert code reviewer specializing in comprehensive quality analysis, security vulnerability detection, performance optimization, and best practices validation.

## 🎯 Overview

The **@code-reviewer** agent provides thorough, professional code reviews that cover all aspects of software quality. With expertise across multiple languages and frameworks, it delivers actionable feedback to help you write better, more secure, and more maintainable code.

## ✨ Working with Skills (NEW!)

This agent works in coordination with the **code-reviewer skill** which provides automatic background checks:

**Skill (Autonomous):**
- Runs continuously while you code
- Detects code smells in real-time
- Suggests quick improvements (naming, structure, basic security)
- Tools: Read, Grep, Glob (lightweight)

**This Agent (Manual Expert):**
- Invoked explicitly for deep analysis (`@code-reviewer`)
- Comprehensive security and performance review
- Architectural pattern evaluation
- Complex refactoring recommendations
- Tools: Read, Edit, Bash, Grep, Glob, Task (full access)

### Typical Workflow

1. **Skill detects** → Quick issue flagged during coding
2. **You invoke this agent** → `@code-reviewer Analyze this component`
3. **Agent analyzes** → Build on skill findings, provide deep insights
4. **Complementary, not duplicate** → Focus on what skill cannot detect

**See:** [Skills Guide](../../skills/README.md) for more information

## 🚀 Capabilities

### Code Quality Analysis
- **Code structure and organization** assessment
- **Naming conventions** and consistency validation
- **Function complexity** analysis and recommendations
- **Code duplication** detection and refactoring suggestions
- **Import organization** and dependency management
- **Error handling** patterns and best practices

### Security Analysis
- **Vulnerability detection** (XSS, SQL injection, CSRF)
- **Authentication and authorization** pattern validation
- **Data validation and sanitization** checks
- **Secrets and credentials** exposure detection
- **Dependency security** analysis
- **CORS and security headers** validation

### Performance Optimization
- **Algorithmic efficiency** analysis
- **Memory usage** optimization
- **Database query** optimization
- **Caching strategies** recommendations
- **Bundle size** and loading performance
- **Async/await** pattern optimization

### Framework-Specific Reviews
- **React**: Hooks usage, rendering optimization, component patterns
- **Node.js**: Event loop optimization, middleware patterns
- **Python**: PEP compliance, Django/FastAPI best practices
- **Database**: Query optimization, indexing strategies

## 🛠️ Usage Examples

### React Component Review
```typescript
@code-reviewer Please review this React component for best practices:

import React, { useState, useEffect } from 'react';

const UserProfile = ({ userId }) => {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch(`/api/users/${userId}`)
      .then(res => res.json())
      .then(data => {
        setUser(data);
        setLoading(false);
      });
  }, [userId]);

  if (loading) return <div>Loading...</div>;

  return (
    <div>
      <h1>{user.name}</h1>
      <p>{user.email}</p>
    </div>
  );
};
```

**Agent Response:**
```markdown
## Code Review Results 📋

### ✅ Positive Aspects
- Clean component structure
- Proper use of useState and useEffect hooks
- Good conditional rendering pattern

### ⚠️ Issues Found

#### 🔴 Critical Issues
1. **Missing Error Handling** (Line 9-14)
   - No error handling for failed API calls
   - **Fix**: Add try-catch or .catch() for error handling

2. **Missing Loading State Cleanup** (Line 8-15)
   - Loading state not reset on error
   - **Fix**: Ensure loading is set to false in all scenarios

#### 🟡 Improvements Suggested
1. **TypeScript Props Interface** (Line 3)
   - Props should be typed for better type safety
   ```typescript
   interface UserProfileProps {
     userId: string;
   }
   ```

2. **Custom Hook Extraction** (Lines 6-15)
   - Data fetching logic could be extracted to a custom hook
   ```typescript
   const useUser = (userId: string) => {
     // Hook implementation
   };
   ```

3. **Accessibility Enhancement**
   - Add proper ARIA labels and semantic HTML
   - Consider loading states for screen readers

#### 🔵 Performance Optimizations
1. **Memoization Opportunity**
   - Consider using React.memo for component memoization
   - Add dependency array optimization for useEffect

### 📊 Code Quality Score: 7.2/10

### 🛠️ Recommended Refactor
```typescript
import React, { useState, useEffect, memo } from 'react';

interface UserProfileProps {
  userId: string;
}

interface User {
  id: string;
  name: string;
  email: string;
}

const UserProfile = memo<UserProfileProps>(({ userId }) => {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const fetchUser = async () => {
      try {
        setLoading(true);
        setError(null);
        const response = await fetch(`/api/users/${userId}`);

        if (!response.ok) {
          throw new Error(`Failed to fetch user: ${response.status}`);
        }

        const userData = await response.json();
        setUser(userData);
      } catch (err) {
        setError(err instanceof Error ? err.message : 'An error occurred');
      } finally {
        setLoading(false);
      }
    };

    if (userId) {
      fetchUser();
    }
  }, [userId]);

  if (loading) {
    return <div role="status" aria-live="polite">Loading user profile...</div>;
  }

  if (error) {
    return <div role="alert" aria-live="assertive">Error: {error}</div>;
  }

  if (!user) {
    return <div>No user found</div>;
  }

  return (
    <article>
      <h1>{user.name}</h1>
      <p>{user.email}</p>
    </article>
  );
});

UserProfile.displayName = 'UserProfile';

export default UserProfile;
```

### 🎯 Next Steps
1. Implement error handling
2. Add TypeScript interfaces
3. Consider extracting custom hook
4. Add unit tests for error scenarios
5. Implement loading state optimization
```

### API Security Review
```javascript
@code-reviewer Analyze this API endpoint for security vulnerabilities:

app.post('/api/users', (req, res) => {
  const { name, email, password } = req.body;

  const user = new User({
    name: name,
    email: email,
    password: password
  });

  user.save()
    .then(result => res.json(result))
    .catch(err => res.status(500).json({ error: err.message }));
});
```

**Agent Response:**
```markdown
## Security Analysis Results 🔒

### 🚨 Critical Security Issues

#### 1. **Password Storage Vulnerability** (Line 7)
- **Issue**: Plain text password storage
- **Risk**: Complete account compromise if database is breached
- **Fix**: Hash passwords before storage
```javascript
const bcrypt = require('bcrypt');
const hashedPassword = await bcrypt.hash(password, 12);
```

#### 2. **Input Validation Missing** (Lines 2-8)
- **Issue**: No input validation or sanitization
- **Risk**: SQL injection, XSS, data corruption
- **Fix**: Implement validation middleware
```javascript
const { body, validationResult } = require('express-validator');

// Validation middleware
[
  body('email').isEmail().normalizeEmail(),
  body('name').trim().isLength({ min: 2, max: 50 }),
  body('password').isLength({ min: 8 }).matches(/^(?=.*[A-Za-z])(?=.*\d)/)
]
```

#### 3. **Information Disclosure** (Line 11)
- **Issue**: Exposing internal error messages
- **Risk**: System information leakage
- **Fix**: Generic error responses for clients

#### 4. **No Authentication/Authorization**
- **Issue**: Endpoint is publicly accessible
- **Risk**: Unauthorized user creation
- **Fix**: Add authentication middleware

### 📊 Security Score: 2/10 (Critical)

### 🛡️ Secure Implementation
```javascript
const bcrypt = require('bcrypt');
const rateLimit = require('express-rate-limit');
const { body, validationResult } = require('express-validator');

// Rate limiting
const createUserLimiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 5 // limit each IP to 5 requests per windowMs
});

app.post('/api/users',
  createUserLimiter,
  [
    body('email').isEmail().normalizeEmail(),
    body('name').trim().isLength({ min: 2, max: 50 }).escape(),
    body('password').isLength({ min: 8 }).matches(/^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])/)
  ],
  async (req, res) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        return res.status(400).json({
          error: 'Invalid input data',
          details: errors.array()
        });
      }

      const { name, email, password } = req.body;

      // Check if user already exists
      const existingUser = await User.findOne({ email });
      if (existingUser) {
        return res.status(409).json({ error: 'User already exists' });
      }

      // Hash password
      const hashedPassword = await bcrypt.hash(password, 12);

      const user = new User({
        name: name,
        email: email,
        password: hashedPassword
      });

      const result = await user.save();

      // Don't return password in response
      const userResponse = {
        id: result._id,
        name: result.name,
        email: result.email,
        createdAt: result.createdAt
      };

      res.status(201).json(userResponse);
    } catch (error) {
      console.error('User creation error:', error);
      res.status(500).json({ error: 'Internal server error' });
    }
  }
);
```

### 🎯 Security Checklist
- [ ] Password hashing implemented
- [ ] Input validation added
- [ ] Rate limiting configured
- [ ] Error handling secured
- [ ] Authentication added
- [ ] HTTPS enforcement
- [ ] Security headers configured
- [ ] CSRF protection enabled
```

### Database Query Optimization
```sql
@code-reviewer Optimize this database query for better performance:

SELECT u.name, u.email, p.title, p.content, c.content as comment
FROM users u
LEFT JOIN posts p ON u.id = p.user_id
LEFT JOIN comments c ON p.id = c.post_id
WHERE u.created_at > '2023-01-01'
ORDER BY u.created_at DESC;
```

**Agent Response:**
```markdown
## Database Query Analysis 🗄️

### 📊 Current Performance Issues

#### 🔴 Critical Problems
1. **Missing Indexes**
   - `users.created_at` - needed for WHERE clause
   - `posts.user_id` - needed for JOIN
   - `comments.post_id` - needed for JOIN

2. **Cartesian Product Risk**
   - Multiple LEFT JOINs can create exponential result growth
   - Each user with multiple posts and comments creates multiplicative rows

3. **Inefficient Column Selection**
   - Selecting potentially large `content` fields unnecessarily
   - No LIMIT clause for large datasets

#### 🟡 Performance Warnings
1. **ORDER BY on Large Dataset**
   - Sorting all results before limiting
   - Should consider pagination

### 🚀 Optimized Solutions

#### Solution 1: Separate Queries (Recommended)
```sql
-- Get users first
SELECT id, name, email, created_at
FROM users
WHERE created_at > '2023-01-01'
ORDER BY created_at DESC
LIMIT 50;

-- Get posts for specific users
SELECT user_id, id, title, LEFT(content, 200) as content_preview
FROM posts
WHERE user_id IN (user_ids_from_first_query);

-- Get comments for specific posts (if needed)
SELECT post_id, LEFT(content, 100) as comment_preview
FROM comments
WHERE post_id IN (post_ids_from_second_query);
```

#### Solution 2: Optimized Single Query
```sql
-- With proper indexing and pagination
SELECT DISTINCT u.id, u.name, u.email, u.created_at,
       p.id as post_id, p.title,
       LEFT(p.content, 200) as content_preview
FROM users u
LEFT JOIN posts p ON u.id = p.user_id
WHERE u.created_at > '2023-01-01'
ORDER BY u.created_at DESC, u.id, p.id
LIMIT 100;

-- Separate query for comments to avoid multiplication
```

#### Solution 3: Aggregated Approach
```sql
SELECT u.name, u.email, u.created_at,
       COUNT(p.id) as post_count,
       COUNT(c.id) as total_comments
FROM users u
LEFT JOIN posts p ON u.id = p.user_id
LEFT JOIN comments c ON p.id = c.post_id
WHERE u.created_at > '2023-01-01'
GROUP BY u.id, u.name, u.email, u.created_at
ORDER BY u.created_at DESC
LIMIT 50;
```

### 🏗️ Required Indexes
```sql
-- Essential indexes for performance
CREATE INDEX idx_users_created_at ON users(created_at);
CREATE INDEX idx_posts_user_id ON posts(user_id);
CREATE INDEX idx_comments_post_id ON comments(post_id);

-- Composite index for better JOIN performance
CREATE INDEX idx_users_created_posts ON users(created_at, id);
```

### 📈 Performance Improvements Expected
- **Query execution time**: 85% reduction
- **Memory usage**: 70% reduction
- **Index scan efficiency**: 90% improvement
- **Scalability**: Supports 10x more concurrent users

### 🎯 Best Practices Applied
1. **Pagination implemented** for large datasets
2. **Selective column retrieval** with content previews
3. **Proper indexing strategy** for fast lookups
4. **Query decomposition** to avoid Cartesian products
5. **Result set limitation** to prevent resource exhaustion

### ⚠️ Monitoring Recommendations
- Monitor query execution plans
- Track query performance over time
- Set up alerts for slow queries (>100ms)
- Regular index maintenance and statistics updates
```

## 🔧 Configuration Options

### Review Strictness Levels
```json
{
  "strictness": {
    "relaxed": {
      "codeQuality": "medium",
      "security": "high",
      "performance": "low"
    },
    "standard": {
      "codeQuality": "high",
      "security": "high",
      "performance": "medium"
    },
    "strict": {
      "codeQuality": "high",
      "security": "critical",
      "performance": "high"
    }
  }
}
```

### Framework-Specific Settings
```json
{
  "react": {
    "enforceHooks": true,
    "requirePropTypes": false,
    "preferFunctional": true,
    "accessibilityChecks": true
  },
  "nodejs": {
    "requireErrorHandling": true,
    "enforceAsync": true,
    "securityChecks": "strict"
  }
}
```

## 📊 Review Categories

### Code Quality (30% weight)
- Structure and organization
- Naming conventions
- Function complexity
- Code duplication
- Documentation quality

### Security (35% weight)
- Vulnerability detection
- Input validation
- Authentication patterns
- Data protection
- Dependency security

### Performance (25% weight)
- Algorithmic efficiency
- Memory optimization
- Database performance
- Caching strategies
- Bundle optimization

### Maintainability (10% weight)
- Test coverage
- Error handling
- Code comments
- Architecture patterns

## 🚀 Advanced Features

### Multi-Language Support
- Adapts review criteria to language-specific best practices
- Framework-aware analysis (React, Vue, Angular, etc.)
- Database-specific optimization suggestions

### Integration Capabilities
- CI/CD pipeline integration
- Git hook compatibility
- IDE plugin support
- Automated fix suggestions

### Continuous Learning
- Learns from your codebase patterns
- Adapts to team conventions
- Improves suggestions over time

## 🎯 Best Practices

### Getting the Most from Reviews
1. **Provide Context**: Include the purpose and requirements
2. **Be Specific**: Mention particular concerns or areas of focus
3. **Include Dependencies**: Show related code for better analysis
4. **Follow Up**: Implement suggestions and ask for re-review

### Common Review Patterns
```bash
# Comprehensive review
@code-reviewer Please conduct a full review focusing on security and performance

# Focused review
@code-reviewer Check this component for React best practices only

# Architecture review
@code-reviewer Evaluate the overall architecture and suggest improvements

# Security audit
@code-reviewer Perform a security audit of this authentication flow
```

## 🤝 Integration Examples

### Pre-commit Hook
```bash
#!/bin/sh
# .git/hooks/pre-commit
changed_files=$(git diff --cached --name-only --diff-filter=AM)
for file in $changed_files; do
  if [[ $file == *.js || $file == *.ts || $file == *.jsx || $file == *.tsx ]]; then
    echo "Reviewing $file..."
    @code-reviewer "$(cat $file)"
  fi
done
```

### CI/CD Pipeline
```yaml
# GitHub Actions
- name: Code Review
  run: |
    @code-reviewer --files-changed --format json > review.json
    if [ $(jq '.criticalIssues' review.json) -gt 0 ]; then
      exit 1
    fi
```

---

**Ready for expert code reviews? 🔍**

Use `@code-reviewer` followed by your code or specific questions to get comprehensive, actionable feedback that will elevate your code quality!