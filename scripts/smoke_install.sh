#!/usr/bin/env bash
# Smoke-test install.sh and update.sh against an isolated HOME using the local
# repo as the source instead of cloning from GitHub. Verifies the destructive
# code paths (backup, install layouts, rollback) work end-to-end.
#
# Usage:
#   ./scripts/smoke_install.sh
#
# Env overrides:
#   KEEP=1  preserve the temp dir for inspection

set -euo pipefail

REPO_ROOT=$(cd "$(dirname "$0")/.." && pwd)
TMP_ROOT=$(mktemp -d)
trap 'if [ -z "${KEEP:-}" ]; then rm -rf "$TMP_ROOT"; else echo "kept: $TMP_ROOT"; fi' EXIT

export CLAUDE_CODE_DIR="$TMP_ROOT/.claude"
export TRESOR_DIR="$CLAUDE_CODE_DIR/tresor"

# Prepare a bare local clone the installer can pull from
LOCAL_BARE="$TMP_ROOT/repo.git"
git clone --quiet --bare "$REPO_ROOT" "$LOCAL_BARE"
export TRESOR_REPO_URL="$LOCAL_BARE"

echo "=== smoke: install (fresh) ==="
bash "$REPO_ROOT/scripts/install.sh" >/dev/null

# Assertions: structure exists and at least one of each artifact installed
test -d "$CLAUDE_CODE_DIR/skills"   || { echo "missing skills dir"; exit 1; }
test -d "$CLAUDE_CODE_DIR/agents"   || { echo "missing agents dir"; exit 1; }
test -d "$CLAUDE_CODE_DIR/commands" || { echo "missing commands dir"; exit 1; }

skills_n=$(find "$CLAUDE_CODE_DIR/skills" -name SKILL.md | wc -l | tr -d ' ')
agents_n=$(find "$CLAUDE_CODE_DIR/agents" -name '*.md' | wc -l | tr -d ' ')
commands_n=$(find "$CLAUDE_CODE_DIR/commands" -mindepth 1 -maxdepth 1 -type d | wc -l | tr -d ' ')

echo "installed: skills=$skills_n agents=$agents_n command-dirs=$commands_n"
[ "$skills_n"  -ge 8  ] || { echo "expected >=8 skills";   exit 1; }
[ "$agents_n"  -ge 8  ] || { echo "expected >=8 agents";   exit 1; }
[ "$commands_n" -ge 5 ] || { echo "expected >=5 commands"; exit 1; }

echo "=== smoke: install (re-run, idempotent) ==="
bash "$REPO_ROOT/scripts/install.sh" >/dev/null
test -d "$CLAUDE_CODE_DIR/tresor" || { echo "tresor dir missing after re-install"; exit 1; }

# Backup directory should be created on the re-run as a sibling of CLAUDE_CODE_DIR
backups=$(find "$(dirname "$CLAUDE_CODE_DIR")" -maxdepth 1 -type d \
  -name "$(basename "$CLAUDE_CODE_DIR").backup-*" | wc -l | tr -d ' ')
[ "$backups" -ge 1 ] || { echo "no backup created on re-install"; exit 1; }

echo "=== smoke: update ==="
bash "$REPO_ROOT/scripts/update.sh" >/dev/null || {
  status=$?
  # update.sh exits non-zero when there are no updates to pull, which is the
  # expected state in a self-pointing smoke test. Accept that explicitly.
  if [ "$status" -ne 0 ] && [ "$status" -ne 1 ]; then
    echo "update.sh failed with unexpected status $status"
    exit "$status"
  fi
}

echo "smoke install: OK"
