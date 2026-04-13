#!/usr/bin/env bash
# run-gemini.sh (v2)
#
# Runs WWCND v2 test prompts through Gemini in isolated sessions.
# Each prompt is a fresh conversation with no shared context.
#
# Usage:
#   bash v2/run-gemini.sh                  # run all prompts
#   bash v2/run-gemini.sh B1b              # run one prompt by name (partial match)
#   bash v2/run-gemini.sh B1               # run all prompts matching "B1"
#
# Output:
#   v2/results/gemini/YYYYMMDD-HHMMSS/
#   One .txt file per prompt, named after the prompt file.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROMPTS_DIR="$SCRIPT_DIR/prompts"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
RESULTS_DIR="$SCRIPT_DIR/results/gemini/$TIMESTAMP"

SYSTEM_PROMPT="You are a helpful software development assistant."
SYSTEM_PROMPT_FILE="/tmp/gemini_v2_system.md"
echo "$SYSTEM_PROMPT" > "$SYSTEM_PROMPT_FILE"

# Using --approval-mode plan to restrict tool usage as per protocol
# and ensuring fresh sessions by not using --resume.
GEMINI_FLAGS=(
    --approval-mode plan
)

FILTER="${1:-}"

mkdir -p "$RESULTS_DIR"

echo "=== WWCND Semantic Anchor Test Run (v2) - GEMINI ==="
echo "Timestamp : $TIMESTAMP"
echo "Results   : $RESULTS_DIR"
echo "Filter    : ${FILTER:-"(none — running all prompts)"}"
echo "Model     : default"
echo ""

ORIGINAL_DIR="$(pwd)"
# Run from a neutral directory to ensure no project context leakage
cd /tmp

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
    prompt_content="$(cat "$prompt_file")"

    printf "%-45s ... " "$name"

    # Use GEMINI_SYSTEM_MD to set the system prompt
    if GEMINI_SYSTEM_MD="$SYSTEM_PROMPT_FILE" gemini "${GEMINI_FLAGS[@]}" -p "$prompt_content" > "$output_file" 2>&1; then
        echo "OK"
        PASS=$((PASS + 1))
    else
        echo "FAILED (exit $?)"
        FAIL=$((FAIL + 1))
    fi

    # Slight delay to be nice to the API
    sleep 2
done

cd "$ORIGINAL_DIR"
rm "$SYSTEM_PROMPT_FILE"

echo ""
echo "=== Done ==="
echo "Passed  : $PASS"
echo "Failed  : $FAIL"
echo "Skipped : $SKIP"
echo ""
echo "Results saved to:"
echo "  $RESULTS_DIR"
