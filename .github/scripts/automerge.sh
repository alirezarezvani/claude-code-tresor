#!/usr/bin/env bash
# Merges a validated pull request into dev when the rules below allow it.
# Called by the `automerge` job in ci.yml after the Validate job passed
# for HEAD_SHA. Required env: GH_TOKEN PR HEAD_SHA HEAD_REF AUTHOR OWNER.
# Optional env: AUTO_RELEASE (repo variable), HAS_PAT.
#
# Rules:
#   - Kill switch DISABLED            -> do nothing
#   - label `hold`                    -> do nothing
#   - author not owner or a known bot -> do nothing (humans merge those)
#   - release-please PR               -> merge unless AUTO_RELEASE=false
#   - draft PR                        -> merge only with label `automerge`
#                                        (it is marked ready first)
#   - any other PR                    -> merge
set -euo pipefail

skip() { echo "::notice::auto-merge skipped: $1"; exit 0; }

killswitch=.github/WORKFLOW_KILLSWITCH
if [ -f "$killswitch" ] && grep -qE '^STATUS:[[:space:]]*DISABLED' "$killswitch"; then
  skip "workflows disabled by $killswitch"
fi

case "$AUTHOR" in
  "$OWNER" | "github-actions[bot]" | "dependabot[bot]") ;;
  *) skip "author '$AUTHOR' is not trusted for auto-merge" ;;
esac

# Read live state: labels or draft status may have changed since the
# run started.
state=$(gh pr view "$PR" --json isDraft,labels,state,headRefOid \
  --jq '[(.isDraft | tostring), ([.labels[].name] | join(",")), .state, .headRefOid] | join("|")')
IFS='|' read -r is_draft labels pr_state live_sha <<<"$state"

[ "$pr_state" = "OPEN" ] || skip "pull request is $pr_state"
[ "$live_sha" = "$HEAD_SHA" ] || skip "new commits were pushed; the next run decides"
[[ ",$labels," == *",hold,"* ]] && skip "label 'hold' is set"

if [[ "$HEAD_REF" == release-please--* && "${AUTO_RELEASE:-}" == "false" ]]; then
  skip "release PR waits for a manual merge (repo variable AUTO_RELEASE=false)"
fi

if [ "$is_draft" = "true" ]; then
  [[ ",$labels," == *",automerge,"* ]] || skip "draft without label 'automerge'"
  gh pr ready "$PR"
fi

if [ "${HAS_PAT:-false}" != "true" ]; then
  echo "::warning::RELEASE_PAT secret missing: merging with the default token, so release.yml will not run for this merge"
fi

gh pr merge "$PR" --merge --match-head-commit "$HEAD_SHA"
echo "::notice::merged #$PR into dev"
