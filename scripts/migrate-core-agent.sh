#!/bin/bash

# migrate-core-agent.sh - Migrate a core agent to subagents/core/
# Usage: ./migrate-core-agent.sh agent-name "capability1" "capability2" "capability3"

set -e

AGENT_NAME=$1
shift
CAPABILITIES=("$@")

SOURCE_DIR="/Users/rezarezvani/projects/claude-code-tresor/agents"
TARGET_DIR="/Users/rezarezvani/projects/claude-code-tresor/subagents/core"

echo "Migrating $AGENT_NAME..."

# Create target directory
mkdir -p "$TARGET_DIR/$AGENT_NAME"

# Read source file
SOURCE_FILE="$SOURCE_DIR/$AGENT_NAME.md"
TARGET_FILE="$TARGET_DIR/$AGENT_NAME/agent.md"

if [ ! -f "$SOURCE_FILE" ]; then
    echo "Error: Source file not found: $SOURCE_FILE"
    exit 1
fi

# Extract description from source YAML
DESCRIPTION=$(grep "^description:" "$SOURCE_FILE" | sed 's/^description: //')
# Extract tools from source YAML
TOOLS=$(grep "^tools:" "$SOURCE_FILE" | sed 's/^tools: //')

# Read full content (skip frontmatter)
CONTENT=$(awk '/^---$/{ if (++count == 2) { p=1; next } } p' "$SOURCE_FILE")

# Build capabilities YAML array
CAPS_YAML=""
for cap in "${CAPABILITIES[@]}"; do
    CAPS_YAML+="  - \"$cap\"\n"
done

# Create new frontmatter
cat > "$TARGET_FILE" << EOF
---
name: "$AGENT_NAME"
description: "$DESCRIPTION"
category: "core"
team: "engineering"
color: "#FFD700"
tools: $TOOLS
model: claude-opus-4
enabled: true
capabilities:
$(echo -e "$CAPS_YAML")max_iterations: 50
---

$CONTENT
EOF

# Copy README if exists
if [ -f "$SOURCE_DIR/$AGENT_NAME/README.md" ]; then
    cp "$SOURCE_DIR/$AGENT_NAME/README.md" "$TARGET_DIR/$AGENT_NAME/"
    echo "  ✓ Copied README.md"
fi

echo "  ✓ Migrated to $TARGET_FILE"
echo "  ✓ Complete!"
