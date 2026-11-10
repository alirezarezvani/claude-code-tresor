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

# Build the upstream repo the installer pulls from. install.sh runs
# `git pull origin main`, so the bare repo must have a `main` branch.
# In CI, actions/checkout only creates the PR branch locally — origin/main
# exists as a remote-tracking ref but not as refs/heads/main, and bare clones
# only copy refs/heads/. Stage in a working clone where we can materialize
# main from origin/main (or HEAD as a self-test fallback).
WORK_CLONE="$TMP_ROOT/work"
LOCAL_BARE="$TMP_ROOT/repo.git"
git clone --quiet "$REPO_ROOT" "$WORK_CLONE"
if ! git -C "$WORK_CLONE" show-ref --verify --quiet refs/heads/main; then
  if git -C "$WORK_CLONE" show-ref --verify --quiet refs/remotes/origin/main; then
    git -C "$WORK_CLONE" branch main origin/main
  else
    git -C "$WORK_CLONE" branch main HEAD
  fi
fi
git clone --quiet --bare "$WORK_CLONE" "$LOCAL_BARE"
export TRESOR_REPO_URL="$LOCAL_BARE"

# Files a user might already have. The installer and updater must never
# delete them: only Tresor's own files may be replaced.
mkdir -p "$CLAUDE_CODE_DIR/commands" "$CLAUDE_CODE_DIR/agents"
echo "personal command" > "$CLAUDE_CODE_DIR/commands/my-own-command.md"
echo "personal agent"   > "$CLAUDE_CODE_DIR/agents/my-own-agent.md"

# A leftover from installers before v2.8.0, which must be cleaned up.
mkdir -p "$CLAUDE_CODE_DIR/commands/workflow-review"
echo "old layout" > "$CLAUDE_CODE_DIR/commands/workflow-review/review.md"

expected_commands=$(find "$REPO_ROOT/commands" -type f -name '*.md' ! -name 'README.md' | wc -l | tr -d ' ')

# Verify the installed layout. Called after every install/update so that
# re-runs are proven idempotent (no nested or duplicated copies).
assert_layout() {
  local stage="$1"

  local skills_n agents_n commands_n nested_n
  skills_n=$(find "$CLAUDE_CODE_DIR/skills" -name SKILL.md | wc -l | tr -d ' ')
  agents_n=$(find "$CLAUDE_CODE_DIR/agents" -maxdepth 1 -name '*.md' | wc -l | tr -d ' ')
  commands_n=$(find "$CLAUDE_CODE_DIR/commands" -maxdepth 1 -type f -name '*.md' | wc -l | tr -d ' ')
  nested_n=$(find "$CLAUDE_CODE_DIR/commands" -mindepth 1 -type d | wc -l | tr -d ' ')

  echo "[$stage] skills=$skills_n agents=$agents_n commands=$commands_n"

  # 8 skills, exactly once each (a nested copy would double the count)
  [ "$skills_n" -eq 8 ] || { echo "[$stage] expected 8 skills, got $skills_n"; exit 1; }
  # 8 core agents + the personal agent
  [ "$agents_n" -eq 9 ] || { echo "[$stage] expected 9 agent files, got $agents_n"; exit 1; }
  # every command as a flat file + the personal command
  [ "$commands_n" -eq $((expected_commands + 1)) ] || {
    echo "[$stage] expected $((expected_commands + 1)) command files, got $commands_n"; exit 1; }
  [ "$nested_n" -eq 0 ] || { echo "[$stage] commands must be flat files, found directories"; exit 1; }

  local name
  for name in scaffold review test-gen docs-gen audit prompt-create; do
    test -f "$CLAUDE_CODE_DIR/commands/$name.md" || { echo "[$stage] missing /$name"; exit 1; }
  done
  test ! -e "$CLAUDE_CODE_DIR/commands/README.md" || { echo "[$stage] README installed as a command"; exit 1; }
  test ! -e "$CLAUDE_CODE_DIR/subagents/subagents" || { echo "[$stage] nested subagents copy"; exit 1; }

  grep -q "personal command" "$CLAUDE_CODE_DIR/commands/my-own-command.md" \
    || { echo "[$stage] personal command was removed"; exit 1; }
  grep -q "personal agent" "$CLAUDE_CODE_DIR/agents/my-own-agent.md" \
    || { echo "[$stage] personal agent was removed"; exit 1; }
}

echo "=== smoke: install (fresh) ==="
bash "$REPO_ROOT/scripts/install.sh" >/dev/null
assert_layout "install"

subagents_n=$(find "$CLAUDE_CODE_DIR/subagents" -name agent.md | wc -l | tr -d ' ')
[ "$subagents_n" -ge 100 ] || { echo "expected the subagent library, got $subagents_n"; exit 1; }

echo "=== smoke: install (re-run, idempotent) ==="
bash "$REPO_ROOT/scripts/install.sh" >/dev/null
test -d "$CLAUDE_CODE_DIR/tresor" || { echo "tresor dir missing after re-install"; exit 1; }
assert_layout "re-install"

# Backup directory should be created on the re-run as a sibling of CLAUDE_CODE_DIR
backups=$(find "$(dirname "$CLAUDE_CODE_DIR")" -maxdepth 1 -type d \
  -name "$(basename "$CLAUDE_CODE_DIR").backup-*" | wc -l | tr -d ' ')
[ "$backups" -ge 1 ] || { echo "no backup created on re-install"; exit 1; }

echo "=== smoke: update (no changes upstream) ==="
bash "$REPO_ROOT/scripts/update.sh" >/dev/null
assert_layout "update"

echo "=== smoke: update --force ==="
# --force runs the full update path even though nothing changed upstream.
bash "$REPO_ROOT/scripts/update.sh" --force >/dev/null
assert_layout "update --force"

echo "=== smoke: rollback ==="
rm "$CLAUDE_CODE_DIR/commands/review.md"
bash "$REPO_ROOT/scripts/update.sh" --rollback >/dev/null
assert_layout "rollback"

echo "=== smoke: --agent activates library agents ==="
agents_before=$(find "$CLAUDE_CODE_DIR/agents" -maxdepth 1 -name '*.md' | wc -l | tr -d ' ')
bash "$REPO_ROOT/scripts/install.sh" --no-backup \
  --agent data-engineer --agent operations/support/customer-support >/dev/null
for name in data-engineer customer-support; do
  f="$CLAUDE_CODE_DIR/agents/$name.md"
  test -f "$f" || { echo "--agent did not install $name"; exit 1; }
  # Only fields Claude Code knows may stay; list values (tools) must survive.
  ! grep -qE '^(team|category|capabilities|enabled|max_iterations):' "$f" \
    || { echo "$name still has Tresor-only fields"; exit 1; }
done
grep -qE '^  - Read$' "$CLAUDE_CODE_DIR/agents/data-engineer.md" \
  || { echo "data-engineer lost its tools list"; exit 1; }
agents_after=$(find "$CLAUDE_CODE_DIR/agents" -maxdepth 1 -name '*.md' | wc -l | tr -d ' ')
[ "$agents_after" -eq $((agents_before + 2)) ] \
  || { echo "expected $((agents_before + 2)) agent files, got $agents_after"; exit 1; }
grep -q "personal agent" "$CLAUDE_CODE_DIR/agents/my-own-agent.md" \
  || { echo "--agent removed the personal agent"; exit 1; }

# Names used by two teams and unknown names must stop with an error.
if bash "$REPO_ROOT/scripts/install.sh" --no-backup --agent customer-support >/dev/null 2>&1; then
  echo "ambiguous --agent name was accepted"; exit 1
fi
if bash "$REPO_ROOT/scripts/install.sh" --no-backup --agent no-such-agent >/dev/null 2>&1; then
  echo "unknown --agent name was accepted"; exit 1
fi

echo "smoke install: OK"
