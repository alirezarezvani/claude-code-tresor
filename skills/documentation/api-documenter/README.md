# API Documenter Skill

> Auto-generate OpenAPI/Swagger specs from code

## Quick Example

```javascript
// You write:
/**
 * Get user by ID
 */
app.get('/api/users/:id', async (req, res) => {
  const user = await User.findById(req.params.id);
  res.json(user);
});

// Skill generates OpenAPI spec automatically
```

## What It Generates

- ✅ OpenAPI 3.0 specifications
- ✅ Request/response schemas
- ✅ Example payloads
- ✅ Error responses
- ✅ Authentication docs

## Frameworks Supported

- Express.js, FastAPI, Django REST
- Spring Boot, Gin, Rails

## Integration

```javascript
// Use with Swagger UI
const spec = require('./openapi.json');
app.use('/api-docs', swaggerUi.setup(spec));
```

See [SKILL.md](SKILL.md) for full documentation.
