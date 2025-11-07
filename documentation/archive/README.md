# Archive

This directory contains obsolete documentation files that have been superseded by the new documentation structure.

## Purpose

These files are preserved for historical reference but are no longer maintained. All relevant information has been migrated to the current documentation structure.

## Directory Structure

```
archive/
├── tests/       # Test files and validation results
├── planning/    # Planning documents and implementation summaries
└── README.md    # This file
```

---

## Migration Information

**Date:** November 7, 2025
**Reason:** Documentation consolidation and reorganization
**New Structure:** See `documentation/README.md` for current structure

### What Was Migrated

**Test Files (archive/tests/):**
- Workflow validation tests → No longer needed (workflows in production)
- Branch protection tests → No longer needed (branch protection active)

**Planning Files (archive/planning/):**
- Implementation summaries → Consolidated into workflow documentation
- Enhancement plans → Completed or superseded

---

## Current Documentation

For current documentation, see:

- **[Documentation Index →](../README.md)** - Master navigation
- **[Guides →](../guides/)** - User guides (installation, getting-started, etc.)
- **[Reference →](../reference/)** - Technical reference (skills, agents, commands)
- **[Workflows →](../workflows/)** - Workflow documentation (git, automation, etc.)

---

## Accessing Archive Files

Archive files remain accessible for reference:

```bash
# List archive contents
ls -la documentation/archive/

# View archive file
cat documentation/archive/tests/WORKFLOW-TEST-SUCCESS.md
```

**Note:** Archive files are not updated. Refer to current documentation for latest information.

---

**Last Updated:** November 7, 2025
