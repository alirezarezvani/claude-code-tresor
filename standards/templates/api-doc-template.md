# API Documentation Template 📡

A comprehensive template for creating clear, detailed API documentation that helps developers integrate with your API effectively.

## 📋 Complete API Documentation Template

```markdown
# API Name Documentation

## 📖 Overview

**Base URL:** `https://api.example.com/v1`

**API Version:** v1.0.0

**Last Updated:** March 15, 2024

### Description

Brief description of what the API does and its primary purpose.

### Key Features

- 🔒 **Secure**: OAuth 2.0 and API key authentication
- 🚀 **Fast**: Average response time <100ms
- 📊 **Reliable**: 99.9% uptime SLA
- 🔄 **Real-time**: WebSocket support for live updates
- 📱 **RESTful**: Standard HTTP methods and status codes

## 🚀 Quick Start

### 1. Get API Key

1. Sign up at [Developer Portal](https://developer.example.com)
2. Create a new application
3. Copy your API key from the dashboard

### 2. Make Your First Request

```bash
curl -X GET "https://api.example.com/v1/users" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json"
```

### 3. Test with Postman

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/your-collection-id)

## 🔐 Authentication

### API Key Authentication

Include your API key in the Authorization header:

```http
Authorization: Bearer YOUR_API_KEY
```

### OAuth 2.0 Flow

For applications requiring user authorization:

#### 1. Authorization URL
```
GET https://api.example.com/oauth/authorize?
  client_id=YOUR_CLIENT_ID&
  redirect_uri=YOUR_REDIRECT_URI&
  response_type=code&
  scope=read,write
```

#### 2. Exchange Code for Token
```bash
curl -X POST "https://api.example.com/oauth/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "grant_type=authorization_code" \
  -d "code=AUTHORIZATION_CODE" \
  -d "client_id=YOUR_CLIENT_ID" \
  -d "client_secret=YOUR_CLIENT_SECRET"
```

#### 3. Use Access Token
```http
Authorization: Bearer ACCESS_TOKEN
```

### Rate Limiting

- **Free Tier**: 1,000 requests per hour
- **Pro Tier**: 10,000 requests per hour
- **Enterprise**: Unlimited

Rate limit headers:
```http
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 999
X-RateLimit-Reset: 1609459200
```

## 📊 Base Information

### Request/Response Format

- **Content Type**: `application/json`
- **Character Encoding**: UTF-8
- **Date Format**: ISO 8601 (`2024-03-15T10:30:00Z`)

### Standard Headers

#### Request Headers
```http
Content-Type: application/json
Authorization: Bearer YOUR_API_KEY
User-Agent: YourApp/1.0.0
Accept: application/json
```

#### Response Headers
```http
Content-Type: application/json; charset=utf-8
X-Request-ID: 550e8400-e29b-41d4-a716-446655440000
X-Response-Time: 45ms
Cache-Control: no-cache
```

### HTTP Status Codes

| Code | Meaning | Description |
|------|---------|-------------|
| 200 | OK | Request successful |
| 201 | Created | Resource created successfully |
| 204 | No Content | Request successful, no content returned |
| 400 | Bad Request | Invalid request parameters |
| 401 | Unauthorized | Authentication required |
| 403 | Forbidden | Insufficient permissions |
| 404 | Not Found | Resource not found |
| 409 | Conflict | Resource conflict |
| 422 | Unprocessable Entity | Validation errors |
| 429 | Too Many Requests | Rate limit exceeded |
| 500 | Internal Server Error | Server error |
| 503 | Service Unavailable | Service temporarily unavailable |

## 📚 API Endpoints

### Users

#### Get All Users

```http
GET /v1/users
```

**Description:** Retrieve a paginated list of users.

**Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| page | integer | No | Page number (default: 1) |
| limit | integer | No | Items per page (default: 20, max: 100) |
| search | string | No | Search query for filtering |
| sort | string | No | Sort field (name, email, created_at) |
| order | string | No | Sort order (asc, desc) |

**Example Request:**
```bash
curl -X GET "https://api.example.com/v1/users?page=1&limit=10&search=john" \
  -H "Authorization: Bearer YOUR_API_KEY"
```

**Example Response:**
```json
{
  "success": true,
  "data": [
    {
      "id": "user_123",
      "name": "John Doe",
      "email": "john@example.com",
      "avatar": "https://example.com/avatars/john.jpg",
      "role": "user",
      "created_at": "2024-03-15T10:30:00Z",
      "updated_at": "2024-03-15T10:30:00Z"
    }
  ],
  "pagination": {
    "page": 1,
    "limit": 10,
    "total": 150,
    "pages": 15
  },
  "meta": {
    "request_id": "550e8400-e29b-41d4-a716-446655440000",
    "response_time": "45ms"
  }
}
```

#### Get User by ID

```http
GET /v1/users/{user_id}
```

**Description:** Retrieve a specific user by their ID.

**Path Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| user_id | string | Yes | Unique user identifier |

**Example Request:**
```bash
curl -X GET "https://api.example.com/v1/users/user_123" \
  -H "Authorization: Bearer YOUR_API_KEY"
```

**Example Response:**
```json
{
  "success": true,
  "data": {
    "id": "user_123",
    "name": "John Doe",
    "email": "john@example.com",
    "avatar": "https://example.com/avatars/john.jpg",
    "role": "user",
    "profile": {
      "bio": "Software developer",
      "location": "San Francisco, CA",
      "website": "https://johndoe.com"
    },
    "preferences": {
      "theme": "dark",
      "notifications": true,
      "language": "en"
    },
    "created_at": "2024-03-15T10:30:00Z",
    "updated_at": "2024-03-15T10:30:00Z"
  },
  "meta": {
    "request_id": "550e8400-e29b-41d4-a716-446655440000",
    "response_time": "23ms"
  }
}
```

#### Create User

```http
POST /v1/users
```

**Description:** Create a new user account.

**Request Body:**
```json
{
  "name": "Jane Smith",
  "email": "jane@example.com",
  "password": "securePassword123!",
  "role": "user",
  "profile": {
    "bio": "Designer and developer",
    "location": "New York, NY"
  }
}
```

**Required Fields:**
- `name` (string): User's full name
- `email` (string): Valid email address
- `password` (string): Password (min 8 characters)

**Optional Fields:**
- `role` (string): User role (default: "user")
- `profile` (object): Additional profile information

**Example Request:**
```bash
curl -X POST "https://api.example.com/v1/users" \
  -H "Authorization: Bearer YOUR_API_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Jane Smith",
    "email": "jane@example.com",
    "password": "securePassword123!"
  }'
```

**Example Response:**
```json
{
  "success": true,
  "data": {
    "id": "user_456",
    "name": "Jane Smith",
    "email": "jane@example.com",
    "role": "user",
    "created_at": "2024-03-15T11:00:00Z",
    "updated_at": "2024-03-15T11:00:00Z"
  },
  "meta": {
    "request_id": "550e8400-e29b-41d4-a716-446655440001",
    "response_time": "156ms"
  }
}
```

#### Update User

```http
PUT /v1/users/{user_id}
```

**Description:** Update an existing user's information.

**Path Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| user_id | string | Yes | Unique user identifier |

**Request Body:**
```json
{
  "name": "Jane Doe Smith",
  "profile": {
    "bio": "Senior Software Engineer",
    "location": "Boston, MA"
  },
  "preferences": {
    "theme": "light",
    "notifications": false
  }
}
```

#### Delete User

```http
DELETE /v1/users/{user_id}
```

**Description:** Permanently delete a user account.

**Path Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| user_id | string | Yes | Unique user identifier |

**Example Response:**
```json
{
  "success": true,
  "message": "User deleted successfully",
  "meta": {
    "request_id": "550e8400-e29b-41d4-a716-446655440002",
    "response_time": "89ms"
  }
}
```

### Products

#### Get All Products

```http
GET /v1/products
```

**Description:** Retrieve a list of products with filtering and pagination.

**Query Parameters:**

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| category | string | No | Filter by category |
| min_price | number | No | Minimum price filter |
| max_price | number | No | Maximum price filter |
| in_stock | boolean | No | Filter by stock availability |
| page | integer | No | Page number (default: 1) |
| limit | integer | No | Items per page (default: 20) |

**Example Request:**
```bash
curl -X GET "https://api.example.com/v1/products?category=electronics&min_price=100&in_stock=true" \
  -H "Authorization: Bearer YOUR_API_KEY"
```

## 🔧 Data Models

### User Object

```json
{
  "id": "string",              // Unique identifier
  "name": "string",            // Full name
  "email": "string",           // Email address
  "avatar": "string|null",     // Avatar URL
  "role": "string",            // User role (user, admin, moderator)
  "profile": {
    "bio": "string|null",      // Biography
    "location": "string|null", // Location
    "website": "string|null"   // Website URL
  },
  "preferences": {
    "theme": "string",         // UI theme (light, dark)
    "notifications": "boolean", // Email notifications
    "language": "string"       // Language code (en, es, fr)
  },
  "created_at": "string",      // ISO 8601 datetime
  "updated_at": "string"       // ISO 8601 datetime
}
```

### Product Object

```json
{
  "id": "string",              // Unique identifier
  "name": "string",            // Product name
  "description": "string",     // Product description
  "price": "number",           // Price in USD
  "currency": "string",        // Currency code
  "category": "string",        // Category name
  "images": ["string"],        // Array of image URLs
  "in_stock": "boolean",       // Stock availability
  "stock_quantity": "integer", // Available quantity
  "sku": "string",             // Stock keeping unit
  "created_at": "string",      // ISO 8601 datetime
  "updated_at": "string"       // ISO 8601 datetime
}
```

### Error Object

```json
{
  "success": false,
  "error": {
    "code": "string",          // Error code
    "message": "string",       // Human-readable message
    "details": "object|null"   // Additional error details
  },
  "meta": {
    "request_id": "string",    // Request identifier
    "response_time": "string"  // Response time
  }
}
```

## ❌ Error Handling

### Error Response Format

All error responses follow this structure:

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "The request data is invalid",
    "details": {
      "field": "email",
      "reason": "Invalid email format"
    }
  },
  "meta": {
    "request_id": "550e8400-e29b-41d4-a716-446655440000",
    "response_time": "12ms"
  }
}
```

### Common Error Codes

| Code | HTTP Status | Description |
|------|-------------|-------------|
| VALIDATION_ERROR | 422 | Request validation failed |
| UNAUTHORIZED | 401 | Authentication required |
| FORBIDDEN | 403 | Insufficient permissions |
| NOT_FOUND | 404 | Resource not found |
| RATE_LIMIT_EXCEEDED | 429 | Too many requests |
| INTERNAL_ERROR | 500 | Internal server error |
| SERVICE_UNAVAILABLE | 503 | Service temporarily unavailable |

### Validation Errors

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Validation failed for one or more fields",
    "details": {
      "errors": [
        {
          "field": "email",
          "message": "Email is required"
        },
        {
          "field": "password",
          "message": "Password must be at least 8 characters"
        }
      ]
    }
  },
  "meta": {
    "request_id": "550e8400-e29b-41d4-a716-446655440000",
    "response_time": "15ms"
  }
}
```

## 🔄 Webhooks

### Setup

1. Configure webhook URL in your dashboard
2. Choose events to subscribe to
3. Verify webhook endpoint with test event

### Event Types

| Event | Description |
|-------|-------------|
| user.created | New user account created |
| user.updated | User information updated |
| user.deleted | User account deleted |
| product.created | New product added |
| product.updated | Product information updated |
| order.created | New order placed |
| order.completed | Order fulfilled |

### Webhook Payload

```json
{
  "id": "evt_123",
  "type": "user.created",
  "created_at": "2024-03-15T10:30:00Z",
  "data": {
    "object": {
      "id": "user_123",
      "name": "John Doe",
      "email": "john@example.com"
    }
  }
}
```

### Verification

Verify webhook authenticity using the signature header:

```javascript
const crypto = require('crypto');

function verifyWebhook(payload, signature, secret) {
  const expectedSignature = crypto
    .createHmac('sha256', secret)
    .update(payload)
    .digest('hex');

  return signature === `sha256=${expectedSignature}`;
}
```

## 📊 Pagination

### Request Parameters

| Parameter | Type | Default | Max | Description |
|-----------|------|---------|-----|-------------|
| page | integer | 1 | - | Page number |
| limit | integer | 20 | 100 | Items per page |

### Response Format

```json
{
  "data": [...],
  "pagination": {
    "page": 1,
    "limit": 20,
    "total": 150,
    "pages": 8,
    "has_next": true,
    "has_prev": false,
    "next_page": 2,
    "prev_page": null
  }
}
```

### Cursor-based Pagination

For real-time data, use cursor-based pagination:

```http
GET /v1/messages?cursor=eyJpZCI6MTIzLCJ0aW1lc3RhbXAiOjE2MDk0NTkyMDB9&limit=20
```

## 🔍 Filtering and Sorting

### Filtering

Use query parameters for filtering:

```http
GET /v1/products?category=electronics&price_min=100&price_max=500&in_stock=true
```

### Sorting

Sort by any field with optional order:

```http
GET /v1/users?sort=created_at&order=desc
```

Multiple sort fields:

```http
GET /v1/users?sort=role,name&order=asc,asc
```

## 📱 SDKs and Libraries

### Official SDKs

#### JavaScript/Node.js
```bash
npm install @example/api-client
```

```javascript
import { ApiClient } from '@example/api-client';

const client = new ApiClient('YOUR_API_KEY');
const users = await client.users.list();
```

#### Python
```bash
pip install example-api-python
```

```python
from example_api import ApiClient

client = ApiClient('YOUR_API_KEY')
users = client.users.list()
```

#### PHP
```bash
composer require example/api-client
```

```php
use Example\ApiClient;

$client = new ApiClient('YOUR_API_KEY');
$users = $client->users->list();
```

### Community Libraries

- [Go SDK](https://github.com/community/go-example-api)
- [Ruby Gem](https://github.com/community/ruby-example-api)
- [C# SDK](https://github.com/community/csharp-example-api)

## 🧪 Testing

### Sandbox Environment

Test your integration using our sandbox:

**Base URL:** `https://sandbox-api.example.com/v1`

**Test API Key:** `test_sk_123abc456def789ghi`

### Test Data

Pre-populated test data available:

- Test users: `user_test_001` through `user_test_100`
- Test products: `prod_test_001` through `prod_test_050`

### Postman Collection

Import our Postman collection for easy testing:

[![Run in Postman](https://run.pstmn.io/button.svg)](https://app.getpostman.com/run-collection/your-collection-id)

## 📈 Monitoring and Analytics

### Response Headers

Monitor API performance using response headers:

```http
X-Response-Time: 45ms
X-Request-ID: 550e8400-e29b-41d4-a716-446655440000
X-Rate-Limit-Remaining: 999
X-Cache-Status: MISS
```

### Status Page

Check API status and performance: [status.example.com](https://status.example.com)

## 🔧 Troubleshooting

### Common Issues

#### 401 Unauthorized
- Check API key is correctly formatted
- Ensure API key has required permissions
- Verify API key is not expired

#### 429 Rate Limit Exceeded
- Implement exponential backoff
- Consider upgrading to higher tier
- Optimize request frequency

#### 422 Validation Error
- Check required fields are included
- Validate data types and formats
- Review field-specific requirements

### Debug Mode

Enable debug mode for detailed error information:

```http
X-Debug: true
```

Debug response includes additional information:

```json
{
  "debug": {
    "sql_queries": 3,
    "execution_time": "45ms",
    "memory_usage": "2.1MB"
  }
}
```

## 📞 Support

### Resources

- 📖 [Developer Portal](https://developer.example.com)
- 💬 [Community Forum](https://community.example.com)
- 📧 [Email Support](mailto:api-support@example.com)
- 📱 [Status Page](https://status.example.com)

### Contact Information

**API Support Team**
- Email: api-support@example.com
- Response Time: <24 hours
- Available: Monday-Friday, 9 AM - 6 PM PST

**Emergency Support** (Critical Issues)
- Email: emergency@example.com
- Phone: +1-555-API-HELP
- Available: 24/7

### SLA

- **Uptime**: 99.9%
- **Response Time**: <100ms (95th percentile)
- **Support Response**: <24 hours

---

**API Version:** v1.0.0
**Documentation Updated:** March 15, 2024
**Status:** [Operational](https://status.example.com)
```

## 🎯 Specialized API Documentation Templates

### 🔌 GraphQL API Template

```markdown
# GraphQL API Documentation

## 🚀 Endpoint

**GraphQL Endpoint:** `https://api.example.com/graphql`
**GraphQL Playground:** `https://api.example.com/playground`

## 📊 Schema

### Queries

#### Get User
```graphql
query GetUser($id: ID!) {
  user(id: $id) {
    id
    name
    email
    posts {
      id
      title
      content
    }
  }
}
```

#### Variables
```json
{
  "id": "user_123"
}
```

### Mutations

#### Create User
```graphql
mutation CreateUser($input: CreateUserInput!) {
  createUser(input: $input) {
    id
    name
    email
  }
}
```

#### Input Variables
```json
{
  "input": {
    "name": "John Doe",
    "email": "john@example.com"
  }
}
```

## 🔧 Error Handling

GraphQL errors are returned in the `errors` array:

```json
{
  "data": null,
  "errors": [
    {
      "message": "User not found",
      "locations": [{"line": 2, "column": 3}],
      "path": ["user"],
      "extensions": {
        "code": "USER_NOT_FOUND",
        "exception": {
          "stacktrace": ["Error: User not found", "..."]
        }
      }
    }
  ]
}
```
```

### 🌐 WebSocket API Template

```markdown
# WebSocket API Documentation

## 🔌 Connection

**WebSocket URL:** `wss://api.example.com/v1/ws`

### Authentication
```javascript
const ws = new WebSocket('wss://api.example.com/v1/ws', {
  headers: {
    'Authorization': 'Bearer YOUR_API_KEY'
  }
});
```

## 📨 Message Format

All messages use JSON format:

```json
{
  "type": "message_type",
  "id": "unique_message_id",
  "data": {
    // Message-specific data
  }
}
```

## 📊 Event Types

### Subscribe to Updates
```json
{
  "type": "subscribe",
  "id": "sub_001",
  "data": {
    "channel": "user_updates",
    "user_id": "user_123"
  }
}
```

### Receive Updates
```json
{
  "type": "user_updated",
  "id": "evt_001",
  "data": {
    "user_id": "user_123",
    "changes": {
      "name": "New Name"
    }
  }
}
```

## 🔧 Connection Management

### Heartbeat
Send ping every 30 seconds to maintain connection:

```json
{
  "type": "ping",
  "id": "ping_001"
}
```

Server responds with:

```json
{
  "type": "pong",
  "id": "ping_001"
}
```
```

## 📝 Documentation Best Practices

### Essential Elements
1. **Clear overview and purpose**
2. **Authentication instructions**
3. **Complete endpoint documentation**
4. **Request/response examples**
5. **Error handling guide**
6. **Rate limiting information**
7. **SDKs and code samples**

### Writing Tips
- Use consistent formatting
- Include realistic examples
- Provide error scenarios
- Keep it up-to-date
- Add interactive elements

### Tools for API Documentation
- **OpenAPI/Swagger**: Automated documentation
- **Postman**: Interactive collections
- **Insomnia**: API testing and documentation
- **GitBook**: Beautiful documentation sites
- **Slate**: Clean, responsive docs

This comprehensive API documentation template ensures developers can easily understand and integrate with your API.