# Scaffold Command

Generate project structures, components, and boilerplate code with industry best practices and modern tooling.

## 📖 Overview

The `/scaffold` command automates the creation of project structures, components, and boilerplate code across multiple frameworks and languages. It follows best practices, includes proper testing setups, and generates clean, maintainable code.

## 🚀 Usage

```bash
/scaffold <type> <name> [options]
```

### Required Parameters
- **`type`** - Type of scaffold to generate (see [Supported Types](#supported-types))
- **`name`** - Name of the project/component to create

### Optional Parameters
- **`--framework`** - Specific framework version or variant
- **`--features`** - Comma-separated list of features to include
- **`--output-dir`** - Custom output directory (default: current directory)
- **`--template`** - Use a specific template variant

## 🛠️ Supported Types

### Frontend Components
```bash
# React Components
/scaffold react-component UserProfile --hooks --tests --stories
/scaffold react-hook useUserData --tests
/scaffold react-context AuthContext --provider

# Vue Components
/scaffold vue-component UserCard --composition-api --tests
/scaffold vue-composable useAuth --tests

# Angular Components
/scaffold angular-component user-profile --standalone --tests
/scaffold angular-service user.service --tests
```

### Full Applications
```bash
# Next.js Applications
/scaffold next-app ecommerce-site --typescript --tailwind --auth
/scaffold next-app blog --app-router --mdx --cms

# Express.js APIs
/scaffold express-api user-service --typescript --auth --docker
/scaffold express-api graphql-api --apollo --prisma --tests

# Node.js CLI Tools
/scaffold node-cli task-manager --typescript --commander --tests
```

### Backend Services
```bash
# Go Services
/scaffold go-service user-api --gin --gorm --docker
/scaffold go-cli file-processor --cobra --tests

# Python Packages
/scaffold python-package data-processor --fastapi --pydantic --tests
/scaffold python-cli image-optimizer --click --poetry

# Rust Applications
/scaffold rust-cli json-parser --clap --serde --tests
/scaffold rust-service web-api --axum --tokio
```

## ✨ Features

### Code Quality Features
- **`--tests`** - Generate comprehensive test suites
- **`--lint`** - Include linting configuration (ESLint, Prettier, etc.)
- **`--ci`** - Add CI/CD pipeline configuration
- **`--git`** - Initialize git repository with proper .gitignore

### Development Features
- **`--typescript`** - Use TypeScript instead of JavaScript
- **`--docker`** - Include Docker configuration
- **`--docs`** - Generate documentation templates
- **`--examples`** - Include usage examples

### Framework-Specific Features
- **`--hooks`** - Use React hooks (functional components)
- **`--stories`** - Generate Storybook stories
- **`--auth`** - Include authentication setup
- **`--db`** - Include database configuration
- **`--api`** - Include API integration setup

## 📋 Examples

### React Development

#### Functional Component with Hooks
```bash
/scaffold react-component UserProfile --hooks --tests --stories

# Generated structure:
src/components/UserProfile/
├── UserProfile.tsx
├── UserProfile.test.tsx
├── UserProfile.stories.tsx
├── UserProfile.module.css
└── index.ts
```

#### Custom Hook
```bash
/scaffold react-hook useUserData --tests

# Generated structure:
src/hooks/useUserData/
├── useUserData.ts
├── useUserData.test.ts
└── index.ts
```

### API Development

#### Express.js REST API
```bash
/scaffold express-api task-service --typescript --auth --docker --tests

# Generated structure:
task-service/
├── src/
│   ├── controllers/
│   ├── middleware/
│   ├── models/
│   ├── routes/
│   └── services/
├── tests/
├── docker-compose.yml
├── Dockerfile
├── package.json
└── tsconfig.json
```

#### GraphQL API
```bash
/scaffold express-api user-graphql --apollo --prisma --tests

# Generated structure:
user-graphql/
├── src/
│   ├── resolvers/
│   ├── schema/
│   ├── datasources/
│   └── types/
├── prisma/
├── tests/
└── apollo.config.js
```

### Full Stack Applications

#### Next.js with TypeScript and Tailwind
```bash
/scaffold next-app portfolio --typescript --tailwind --auth --cms

# Generated structure:
portfolio/
├── src/
│   ├── app/
│   ├── components/
│   ├── lib/
│   └── types/
├── prisma/
├── public/
├── tailwind.config.js
└── next.config.js
```

## 🎨 Templates

### Template Variants
- **`minimal`** - Basic structure with essential files only
- **`standard`** - Includes common development tools and configurations
- **`complete`** - Full-featured setup with all best practices
- **`enterprise`** - Enterprise-ready with advanced tooling and patterns

### Custom Templates
```bash
# Use a specific template
/scaffold react-component Button --template minimal
/scaffold next-app dashboard --template enterprise
```

## 🔧 Configuration

### Global Configuration
Create a `.scaffoldrc` file in your project root:

```json
{
  "defaultTemplate": "standard",
  "outputDir": "src",
  "features": {
    "typescript": true,
    "tests": true,
    "lint": true
  },
  "frameworks": {
    "react": "18.x",
    "next": "14.x",
    "express": "4.x"
  }
}
```

### Project-Specific Templates
```bash
# Create custom templates in .scaffold/templates/
.scaffold/
└── templates/
    ├── my-component/
    └── my-api/
```

## 🧪 Generated Code Quality

### Code Standards
- **ESLint + Prettier** configuration
- **TypeScript** strict mode enabled
- **Import organization** and path mapping
- **Consistent naming** conventions

### Testing Setup
- **Unit tests** with Jest/Vitest
- **Integration tests** for APIs
- **Component testing** with Testing Library
- **E2E tests** setup with Playwright/Cypress

### Development Tools
- **Hot reloading** configuration
- **Environment variables** setup
- **Build optimization** configuration
- **Source maps** for debugging

## 🚨 Error Handling

### Common Issues

**Template not found**
```bash
Error: Template 'custom' not found
Available templates: minimal, standard, complete, enterprise
```

**Invalid type**
```bash
Error: Type 'invalid-type' is not supported
Run '/scaffold --list-types' to see available types
```

**Directory already exists**
```bash
Warning: Directory 'UserProfile' already exists
Use --overwrite to replace existing files
```

## 🔍 Advanced Usage

### Batch Scaffolding
```bash
# Create multiple components at once
/scaffold batch --config scaffold-config.json

# scaffold-config.json:
{
  "components": [
    {
      "type": "react-component",
      "name": "Header",
      "features": ["hooks", "tests"]
    },
    {
      "type": "react-component",
      "name": "Footer",
      "features": ["hooks", "tests"]
    }
  ]
}
```

### Interactive Mode
```bash
# Start interactive scaffolding
/scaffold --interactive

# Prompts:
# ? What type of scaffold? (react-component)
# ? Component name? UserProfile
# ? Include tests? (Y/n)
# ? Include Storybook stories? (Y/n)
```

### Custom Hooks
```bash
# Add custom hooks to generated code
/scaffold react-component UserCard --hooks pre-commit,code-gen
```

## 📊 Analytics

Track scaffolding patterns and optimize templates:
- **Most used types**: React components, Express APIs, Next.js apps
- **Popular features**: TypeScript, tests, Docker
- **Template preferences**: Standard (60%), Complete (30%), Minimal (10%)

## 🤝 Contributing

Want to add new scaffold types or improve existing ones?

1. **Add new templates** in `templates/` directory
2. **Update configuration** in `command.json`
3. **Add documentation** with examples
4. **Include tests** for template validation

### Template Structure
```
templates/new-type/
├── template.json          # Template configuration
├── files/                 # Template files
│   ├── {{name}}.template  # Templated files
│   └── static/           # Static files
└── hooks/                # Generation hooks
    ├── pre-generate.js
    └── post-generate.js
```

---

**Ready to scaffold your next project? 🚀**

Use `/scaffold --help` for quick reference or explore the examples above to get started!