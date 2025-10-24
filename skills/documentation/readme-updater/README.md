# README Updater Skill

> Auto-update README when project changes

## Quick Example

```bash
# You add Stripe integration
npm install stripe

# Skill suggests README update:
## Installation
npm install
npm install stripe  # For payment processing

## Environment Variables
STRIPE_SECRET_KEY=your_key
```

## What It Updates

- ✅ Installation instructions
- ✅ Features list
- ✅ Environment variables
- ✅ Setup steps
- ✅ Usage examples
- ✅ Configuration options

## Triggers

- New dependencies added
- Features implemented
- API changes
- Setup process changes
- Configuration file modifications

## Integration

Works with:
- **api-documenter skill**: Syncs API docs
- **@docs-writer sub-agent**: Full documentation
- **/docs-gen command**: Complete doc generation

See [SKILL.md](SKILL.md) for full documentation.
