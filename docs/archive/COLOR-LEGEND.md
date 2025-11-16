# Agent Color Legend & Visual System

> **Visual identification system for Claude Code Tresor agents**
>
> **Last Updated**: November 15, 2025 | **Version**: 2.5.0

---

## Overview

The color coding system provides visual identification for agent categories, making it easy to recognize which team an agent belongs to at a glance.

---

## Color Palette

### Team Colors

| Team | Color Name | Hex Code | RGB | Usage |
|------|------------|----------|-----|-------|
| **Engineering** | Blue | `#3B82F6` | `rgb(59, 130, 246)` | Software development, architecture, testing |
| **Design** | Magenta/Pink | `#EC4899` | `rgb(236, 72, 153)` | UI/UX design, branding, visual |
| **Marketing** | Green | `#10B981` | `rgb(16, 185, 129)` | Content, growth, social media |
| **Product** | Purple | `#8B5CF6` | `rgb(139, 92, 246)` | Product management, requirements |
| **Leadership** | Gold | `#F59E0B` | `rgb(245, 158, 11)` | Finance, strategy, compliance |
| **Operations** | Teal | `#14B8A6` | `rgb(20, 184, 166)` | Analytics, support, operations |
| **Research** | Orange | `#F97316` | `rgb(249, 115, 22)` | Market research, intelligence |
| **AI/Automation** | Indigo | `#6366F1` | `rgb(99, 102, 241)` | AI/ML, automation, prompts |
| **Account/CS** | Cyan | `#06B6D4` | `rgb(6, 182, 212)` | Account mgmt, customer success |
| **Core** | Gold | `#FFD700` | `rgb(255, 215, 0)` | Production-ready core agents |

---

## Visual Representation

### Color Swatches

```
🔵 Engineering     #3B82F6  ████████
🎨 Design          #EC4899  ████████
🌱 Marketing       #10B981  ████████
💜 Product         #8B5CF6  ████████
🏆 Leadership      #F59E0B  ████████
🌊 Operations      #14B8A6  ████████
🔶 Research        #F97316  ████████
🧠 AI/Automation   #6366F1  ████████
💙 Account/CS      #06B6D4  ████████
⭐ Core            #FFD700  ████████
```

---

## Usage Guidelines

### 1. YAML Frontmatter

Add color to agent YAML frontmatter:

```yaml
---
name: systems-architect
description: Expert system architect...
tools: Read, Write, Edit, Grep, Glob, Bash, WebFetch, Task
model: inherit
color: blue          # Team color
category: engineering
subcategory: architecture
---
```

### 2. Documentation

Use color indicators in documentation:

```markdown
## Engineering Agents 🔵

- **systems-architect** (Blue) - System design specialist
- **config-safety-reviewer** (Blue) - Configuration safety
```

### 3. CLI Output

Use ANSI color codes in terminal output:

```bash
# Blue for engineering agents
\033[34m@systems-architect\033[0m

# Magenta for design agents
\033[35m@ui-designer\033[0m

# Green for marketing agents
\033[32m@content-creator\033[0m
```

### 4. IDE Integration

**VS Code** - Set file icons by color:

```json
{
  "files.associations": {
    "**/engineering/*.md": "engineering-agent",
    "**/design/*.md": "design-agent",
    "**/marketing/*.md": "marketing-agent"
  },
  "workbench.colorCustomizations": {
    "engineering-agent.foreground": "#3B82F6",
    "design-agent.foreground": "#EC4899",
    "marketing-agent.foreground": "#10B981"
  }
}
```

---

## Application Examples

### Agent Badges

**Markdown Badges**:

```markdown
![Engineering](https://img.shields.io/badge/Engineering-3B82F6?style=flat&logo=code&logoColor=white)
![Design](https://img.shields.io/badge/Design-EC4899?style=flat&logo=figma&logoColor=white)
![Marketing](https://img.shields.io/badge/Marketing-10B981?style=flat&logo=google&logoColor=white)
```

**HTML Badges**:

```html
<span style="background-color: #3B82F6; color: white; padding: 4px 8px; border-radius: 4px;">
  🔵 Engineering
</span>
```

### Category Headers

```markdown
# 🔵 Engineering Team Agents

# 🎨 Design Team Agents

# 🌱 Marketing Team Agents
```

### Directory Icons

Use emojis as visual indicators:

```
subagents/
├── 🔵 engineering/
├── 🎨 design/
├── 🌱 marketing/
├── 💜 product/
├── 🏆 leadership/
├── 🌊 operations/
├── 🔶 research/
├── 🧠 ai-automation/
└── 💙 account-customer-success/
```

---

## Color Accessibility

### WCAG Compliance

All colors meet WCAG AA standards for accessibility:

| Color | Contrast (on white) | Contrast (on black) | WCAG Rating |
|-------|---------------------|---------------------|-------------|
| Blue #3B82F6 | 4.9:1 | 4.3:1 | AA ✅ |
| Magenta #EC4899 | 4.1:1 | 5.1:1 | AA ✅ |
| Green #10B981 | 3.5:1 | 6.0:1 | AA ✅ |
| Purple #8B5CF6 | 4.7:1 | 4.5:1 | AA ✅ |
| Gold #F59E0B | 2.8:1 | 7.5:1 | AA (on black) ✅ |
| Teal #14B8A6 | 3.2:1 | 6.5:1 | AA ✅ |
| Orange #F97316 | 3.1:1 | 6.8:1 | AA ✅ |
| Indigo #6366F1 | 5.2:1 | 4.0:1 | AA ✅ |
| Cyan #06B6D4 | 3.4:1 | 6.2:1 | AA ✅ |

### Color Blind Modes

**Deuteranopia (Red-Green)**: Use shapes/icons in addition to colors
**Protanopia (Red-Green)**: Use text labels alongside colors
**Tritanopia (Blue-Yellow)**: Avoid relying solely on blue/yellow distinction

**Recommendation**: Always combine colors with text labels or icons.

---

## Implementation

### CSS Variables

```css
:root {
  --color-engineering: #3B82F6;
  --color-design: #EC4899;
  --color-marketing: #10B981;
  --color-product: #8B5CF6;
  --color-leadership: #F59E0B;
  --color-operations: #14B8A6;
  --color-research: #F97316;
  --color-ai-automation: #6366F1;
  --color-account-cs: #06B6D4;
  --color-core: #FFD700;
}

.agent-badge-engineering {
  background-color: var(--color-engineering);
  color: white;
  padding: 4px 12px;
  border-radius: 4px;
}
```

### Tailwind CSS

```javascript
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
      colors: {
        'agent-engineering': '#3B82F6',
        'agent-design': '#EC4899',
        'agent-marketing': '#10B981',
        'agent-product': '#8B5CF6',
        'agent-leadership': '#F59E0B',
        'agent-operations': '#14B8A6',
        'agent-research': '#F97316',
        'agent-ai': '#6366F1',
        'agent-cs': '#06B6D4',
        'agent-core': '#FFD700',
      }
    }
  }
}
```

---

## Terminal Colors

### ANSI Color Codes

```bash
# Engineering (Blue)
ENGINEERING='\033[34m'
# Design (Magenta)
DESIGN='\033[35m'
# Marketing (Green)
MARKETING='\033[32m'
# Product (Purple - Bright Magenta)
PRODUCT='\033[95m'
# Leadership (Yellow)
LEADERSHIP='\033[33m'
# Operations (Cyan)
OPERATIONS='\033[36m'
# Research (Bright Red/Orange)
RESEARCH='\033[91m'
# AI/Automation (Bright Blue)
AI='\033[94m'
# Account/CS (Bright Cyan)
ACCOUNT='\033[96m'
# Reset
RESET='\033[0m'

# Usage
echo -e "${ENGINEERING}@systems-architect${RESET}"
echo -e "${DESIGN}@ui-designer${RESET}"
```

---

## Color Meaning & Psychology

### Color Associations

| Color | Team | Association | Why |
|-------|------|-------------|-----|
| **Blue** | Engineering | Trust, stability, technical | Traditional tech color, reliable |
| **Magenta** | Design | Creativity, innovation, beauty | Creative industries standard |
| **Green** | Marketing | Growth, prosperity, action | Growth-focused, positive action |
| **Purple** | Product | Luxury, wisdom, strategy | Strategic thinking, premium |
| **Gold** | Leadership | Success, achievement, value | Executive level, high value |
| **Teal** | Operations | Balance, efficiency, calm | Operational efficiency |
| **Orange** | Research | Discovery, enthusiasm, energy | Research and exploration |
| **Indigo** | AI/Automation | Intelligence, depth, future | Advanced technology |
| **Cyan** | Account/CS | Communication, clarity, trust | Customer-facing, trustworthy |

---

## Quick Reference

### Find Agent Color

```bash
# From YAML frontmatter
grep "^color:" subagents/engineering/systems-architect.md

# From category
# Engineering = Blue
# Design = Magenta
# Marketing = Green
# etc.
```

### Apply Color in Documentation

```markdown
## 🔵 Engineering
Use `#3B82F6` or emoji 🔵

## 🎨 Design
Use `#EC4899` or emoji 🎨

## 🌱 Marketing
Use `#10B981` or emoji 🌱
```

---

## See Also

- [Agent Categorization](AGENT-CATEGORIZATION.md)
- [Agent Inventory](AGENT-INVENTORY.md)
- [Subagents README](../subagents/README.md)
- [Engineering README](../subagents/engineering/README.md)

---

**Version**: 2.5.0
**Last Updated**: November 15, 2025
