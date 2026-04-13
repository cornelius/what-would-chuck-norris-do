#!/usr/bin/env bash
# run-claude.sh
#
# Runs WWCND test prompts through Claude in isolated sessions.
# Each prompt is a fresh conversation with no shared context.
#
# Usage:
#   bash run-claude.sh                  # run all prompts
#   bash run-claude.sh B1b              # run one prompt by name (partial match)
#   bash run-claude.sh B1               # run all prompts matching "B1"
#
# Requirements:
#   - claude CLI available in PATH (Claude Code)
#   - Run from a neutral directory (the script changes to /tmp during runs)
#
# Output:
#   test/results/claude/YYYYMMDD-HHMMSS/
#   One .txt file per prompt, named after the prompt file.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROMPTS_DIR="$SCRIPT_DIR/prompts"
TIMESTAMP="$(date +%Y%m%d-%H%M%S)"
RESULTS_DIR="$SCRIPT_DIR/results/claude/$TIMESTAMP"

# Neutral system prompt — matches realistic usage context without
# injecting knowledge about this project or the WWCND debate.
SYSTEM_PROMPT="You are a helpful software development assistant."

MODEL="claude-sonnet-4-6"

# Claude flags for test isolation:
#   --print                   Non-interactive, returns response and exits
#   --no-session-persistence  No history saved or loaded between runs
#   --tools ""                Disable all tools (web search, file access, etc.)
#   --system-prompt           Minimal neutral context, no project knowledge
#   --model                   Explicit model pin — 'claude --version' reports CLI version
#                             only, not the model. Without --model the default may change
#                             between runs, making cross-run comparison invalid.
#
# Note: --bare is intentionally omitted. It skips keychain reads, which breaks
# OAuth-based Claude Code subscriptions. Running from /tmp already prevents
# CLAUDE.md discovery; --no-session-persistence handles session isolation.
CLAUDE_FLAGS=(
    --print
    --no-session-persistence
    --tools ""
    --system-prompt "$SYSTEM_PROMPT"
    --model "$MODEL"
)

# Filter: if an argument is given, only run prompts whose filename contains it.
FILTER="${1:-}"

mkdir -p "$RESULTS_DIR"

CLI_VERSION="$(claude --version 2>/dev/null || echo 'unknown')"

# Save run metadata so results are self-documenting
cat > "$RESULTS_DIR/run-info.txt" <<EOF
model       : $MODEL
cli_version : $CLI_VERSION
timestamp   : $TIMESTAMP
system_prompt: $SYSTEM_PROMPT
flags       : --print --no-session-persistence --tools "" --system-prompt --model $MODEL
filter      : ${FILTER:-"(none)"}
EOF

echo "=== WWCND Semantic Anchor Test Run ==="
echo "Timestamp : $TIMESTAMP"
echo "Results   : $RESULTS_DIR"
echo "Filter    : ${FILTER:-"(none — running all prompts)"}"
echo "Model     : $MODEL (CLI: $CLI_VERSION)"
echo ""

# Run from /tmp to ensure no project-specific CLAUDE.md is picked up
# (--bare handles this, but this is a belt-and-suspenders measure)
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

    # Brief pause between requests to avoid rate limiting
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
echo "  1. Review responses in $RESULTS_DIR"
echo "  2. Score each response using the rubric in test/protocol.md"
echo "  3. Record scores in test/results/README.md"
echo "  4. Run the same prompts manually in ChatGPT and Gemini (see protocol)"
