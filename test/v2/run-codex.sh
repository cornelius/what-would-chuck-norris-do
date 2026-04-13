#!/usr/bin/env bash
# run-codex.sh (v2)
#
# Runs WWCND v2 test prompts through Codex in isolated sessions.
# Each prompt is a fresh conversation with no shared context.
#
# Usage:
#   bash v2/run-codex.sh                  # run all prompts
#   bash v2/run-codex.sh B1b              # run one prompt by name (partial match)
#   bash v2/run-codex.sh B1               # run all prompts matching "B1"
#
# Output:
#   v2/results/codex/YYYYMMDD-HHMMSS/
#   One .txt file per prompt, named after the prompt file.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROMPTS_DIR="$SCRIPT_DIR/prompts"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
RESULTS_DIR="$SCRIPT_DIR/results/codex/$TIMESTAMP"

MODEL="${CODEX_MODEL:-gpt-5.3-codex}"
FILTER="${1:-}"

mkdir -p "$RESULTS_DIR"

CLI_VERSION="$(codex --version 2>/dev/null || echo 'unknown')"

cat > "$RESULTS_DIR/run-info.txt" <<EOF
model       : $MODEL
cli_version : $CLI_VERSION
timestamp   : $TIMESTAMP
filter      : ${FILTER:-"(none)"}
cwd         : /tmp
flags       : exec --skip-git-repo-check --sandbox read-only --cd /tmp --ephemeral --output-last-message
note        : Codex CLI does not currently expose a no-tools or custom system-prompt flag analogous to Claude Code.
note        : This runner isolates each prompt in a fresh ephemeral session and avoids repo context by running in /tmp.
note        : If you need to relocate Codex state for a sandboxed environment, export CODEX_HOME before running this script.
EOF

echo "=== WWCND Semantic Anchor Test Run (v2) - CODEX ==="
echo "Timestamp : $TIMESTAMP"
echo "Results   : $RESULTS_DIR"
echo "Filter    : ${FILTER:-"(none — running all prompts)"}"
echo "Model     : $MODEL (CLI: $CLI_VERSION)"
echo ""

PASS=0
FAIL=0
SKIP=0

for prompt_file in "$PROMPTS_DIR"/*.txt; do
    name="$(basename "$prompt_file" .txt)"

    if [[ -n "$FILTER" && "$name" != *"$FILTER"* ]]; then
        SKIP=$((SKIP + 1))
        continue
    fi

    output_file="$RESULTS_DIR/$name.txt"
    log_file="$RESULTS_DIR/$name.log"

    printf "%-45s ... " "$name"

    if codex exec \
        --model "$MODEL" \
        --skip-git-repo-check \
        --sandbox read-only \
        --cd /tmp \
        --ephemeral \
        --output-last-message "$output_file" \
        - < "$prompt_file" > "$log_file" 2>&1; then
        echo "OK"
        PASS=$((PASS + 1))
    else
        status=$?
        echo "FAILED (exit $status, see $(basename "$log_file"))"
        FAIL=$((FAIL + 1))
    fi

    sleep 3
done

echo ""
echo "=== Done ==="
echo "Passed  : $PASS"
echo "Failed  : $FAIL"
echo "Skipped : $SKIP"
echo ""
echo "Results saved to:"
echo "  $RESULTS_DIR"
