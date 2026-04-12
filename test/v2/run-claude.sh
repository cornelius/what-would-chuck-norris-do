#!/usr/bin/env bash
# run-claude.sh (v2)
#
# Runs WWCND v2 test prompts through Claude in isolated sessions.
# Each prompt is a fresh conversation with no shared context.
#
# Usage:
#   bash v2/run-claude.sh                  # run all prompts
#   bash v2/run-claude.sh B1b              # run one prompt by name (partial match)
#   bash v2/run-claude.sh B1               # run all prompts matching "B1"
#
# Output:
#   v2/results/claude/YYYYMMDD-HHMMSS/
#   One .txt file per prompt, named after the prompt file.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROMPTS_DIR="$SCRIPT_DIR/prompts"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
RESULTS_DIR="$SCRIPT_DIR/results/claude/$TIMESTAMP"

SYSTEM_PROMPT="You are a helpful software development assistant."

CLAUDE_FLAGS=(
    --print
    --no-session-persistence
    --tools ""
    --system-prompt "$SYSTEM_PROMPT"
)

FILTER="${1:-}"

mkdir -p "$RESULTS_DIR"

echo "=== WWCND Semantic Anchor Test Run (v2) ==="
echo "Timestamp : $TIMESTAMP"
echo "Results   : $RESULTS_DIR"
echo "Filter    : ${FILTER:-"(none — running all prompts)"}"
echo "Model     : $(claude --version 2>/dev/null || echo 'unknown')"
echo ""

ORIGINAL_DIR="$(pwd)"
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

    if claude "${CLAUDE_FLAGS[@]}" "$prompt_content" > "$output_file" 2>&1; then
        echo "OK"
        PASS=$((PASS + 1))
    else
        echo "FAILED (exit $?)"
        FAIL=$((FAIL + 1))
    fi

    sleep 3
done

cd "$ORIGINAL_DIR"

echo ""
echo "=== Done ==="
echo "Passed  : $PASS"
echo "Failed  : $FAIL"
echo "Skipped : $SKIP"
echo ""
echo "Results saved to:"
echo "  $RESULTS_DIR"
echo ""
echo "Next steps:"
echo "  1. Score responses using the rubric in v2/protocol.md"
echo "  2. Record scores in v2/results/README.md"
echo "  3. Run the same prompts manually in ChatGPT and Gemini"
