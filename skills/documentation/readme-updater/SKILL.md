---
name: readme-updater
description: Keep README files current with project changes. Use when project structure changes, features added, or setup instructions modified. Suggests README updates based on code changes. Triggers on significant project changes, new features, dependency changes.
allowed-tools: Read, Write, Edit, Grep
---

# README Updater Skill

Keep your README current with project changes.

## When I Activate

- ✅ New features added
- ✅ Project structure changes
- ✅ Dependencies added/removed
- ✅ Setup instructions change
- ✅ User mentions README or documentation
- ✅ Configuration files modified

## What I Update

### README Sections

**Installation:**
- New dependencies
- Setup steps
- Prerequisites
- Environment variables

**Features:**
- New capabilities
- Functionality changes
- Feature deprecation

**Usage:**
- API changes
- New examples
- Updated screenshots

**Configuration:**
- New options
- Environment variables
- Config file changes

## Examples

### New Feature Addition

```bash
# You add authentication:
git diff
# + auth.service.ts
# + login.component.tsx
# + JWT middleware

# I suggest README update:
## Features
- ✨ User authentication with JWT  # NEW
- 🔐 Role-based access control    # NEW
- User management
- Dashboard
```

### New Dependency

```bash
# You add: npm install stripe

# I suggest:
## Installation

```bash
npm install
npm install stripe  # Added for payment processing
```

## Environment Variables
```bash
STRIPE_SECRET_KEY=your_stripe_key  # Required for payments
```
```

### Setup Instructions

```bash
# You modify docker-compose.yml

# I update README:
## Development Setup

```bash
# 1. Clone repository
git clone [url]

# 2. Install dependencies
npm install

# 3. Start services (UPDATED)
docker-compose up -d  # Now includes Redis cache

# 4. Run migrations
npm run migrate
```
```

## Detection Logic

### Change Analysis

I detect these changes automatically:
- **package.json** → Update dependencies section
- **New routes** → Update API documentation
- **.env.example** → Update environment variables
- **docker-compose.yml** → Update setup instructions
- **New features** → Update features list

### Section Mapping

```yaml
Code Change → README Section:
  - New API endpoint → Usage / API Reference
  - New dependency → Installation
  - New env var → Configuration
  - New feature → Features list
  - Architecture change → Architecture section
```

## Intelligent Updates

### Keep Structure

I maintain your README structure:
- Preserve emoji style
- Keep formatting consistent
- Maintain tone and voice
- Respect existing organization

### Add Missing Sections

```markdown
# Suggested additions:

## Prerequisites
- Node.js 18+
- Docker (for development)
- PostgreSQL 14+

## Environment Variables
```bash
DATABASE_URL=postgresql://localhost/mydb
API_KEY=your_api_key
```

## Testing
```bash
npm test
```
```

### Update Examples

```markdown
# Before:
```javascript
const result = api.getUsers();
```

# After (API changed):
```javascript
const result = await api.getUsers({ page: 1, limit: 10 });
```
```

## Version Compatibility

I track version-specific documentation:

```markdown
## Requirements

- Node.js 18+ (updated from 16+)
- TypeScript 5.0+ (new requirement)
- React 18+ (unchanged)
```

## Changelog Integration

I can sync with CHANGELOG.md:

```markdown
## Recent Changes

See [CHANGELOG.md](CHANGELOG.md) for detailed version history.

### Latest (v2.1.0)
- ✨ Added user authentication
- 🔧 Fixed memory leak in data processing
- 📝 Updated API documentation
```

## Screenshot Management

```markdown
# I suggest when UI changes:
## Screenshots

![Dashboard](screenshots/dashboard.png)
*Updated: 2025-10-24 - New authentication panel*

![User Profile](screenshots/profile.png)
*New feature - user profile management*
```

## Relationship with @docs-writer

**Me (Skill):** Keep README current with code changes
**@docs-writer (Sub-Agent):** Comprehensive documentation strategy

### Workflow
1. I detect changes
2. I suggest README updates
3. For full docs → Invoke **@docs-writer** sub-agent
4. Sub-agent creates complete documentation

## Sandboxing Compatibility

**Works without sandboxing:** ✅ Yes
**Works with sandboxing:** ✅ Yes

- **Filesystem**: Writes to README.md
- **Network**: None required
- **Configuration**: None required

## Best Practices

1. **Keep it current** - Update README with every feature
2. **Be specific** - Include version numbers, prerequisites
3. **Add examples** - Show actual usage, not just API
4. **Include troubleshooting** - Common issues and solutions
5. **Badge status** - Keep build/coverage badges current

## README Templates

### Basic Structure

```markdown
# Project Name

Brief description

## Features
- Feature 1
- Feature 2

## Installation
```bash
npm install
```

## Usage
```javascript
// Example
```

## Configuration
Environment variables needed

## Contributing
How to contribute

## License
MIT
```

### Comprehensive Structure

```markdown
# Project Name
> Tagline

[Badges]

## Table of Contents
- Features
- Installation
- Usage
- API Reference
- Configuration
- Development
- Testing
- Deployment
- Contributing
- License

[Sections with detailed content]
```

## Integration

### With /docs-gen Command

```bash
/docs-gen --format markdown

# Generates:
# 1. README.md (via me)
# 2. Full documentation site (via @docs-writer)
# 3. API reference (via api-documenter)
```

### With CI/CD

```yaml
# .github/workflows/docs.yml
- name: Update README
  run: |
    # Skill suggests updates based on changes
    # Review and commit
```

## Customization

Add company-specific README standards:

```bash
cp -r ~/.claude/skills/documentation/readme-updater \
      ~/.claude/skills/documentation/company-readme-updater

# Edit to add:
# - Company README template
# - Required sections
# - Badge standards
```

## Related Tools

- **api-documenter skill**: API documentation
- **@docs-writer sub-agent**: Comprehensive docs
- **git-commit-helper skill**: Commit messages for updates
- **/docs-gen command**: Full documentation generation
