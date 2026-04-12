#!/usr/bin/env bash
# score-hedges.sh
#
# Counts hedge phrases in test result files per the rubric in protocol.md.
#
# Usage:
#   bash score-hedges.sh <results-dir>          # summary table
#   bash score-hedges.sh -v <results-dir>       # verbose: show matched phrases

set -euo pipefail

VERBOSE=0
if [[ "${1:-}" == "-v" ]]; then
  VERBOSE=1
  shift
fi

RESULTS_DIR="${1:-}"

if [[ -z "$RESULTS_DIR" ]]; then
  echo "Usage: $0 [-v] <results-dir>" >&2
  exit 1
fi

PHRASES=(
  "it depends"
  "could"
  "might"
  "consider"
  "you may"
  "you might"
  "on the other hand"
  "alternatively"
  "trade-off"
  "tradeoffs"
  "pros and cons"
  "factors to consider"
  "depends on"
  "worth noting"
  "keep in mind"
  "there are several"
  "various options"
)

printf "%-45s  %s\n" "File" "Hedge count"
printf "%-45s  %s\n" "----" "-----------"

for f in "$RESULTS_DIR"/*.txt; do
  name="$(basename "$f" .txt)"
  content="$(cat "$f" | tr '[:upper:]' '[:lower:]')"
  total=0
  matches=()

  for phrase in "${PHRASES[@]}"; do
    n=$(echo "$content" | grep -oiP "\b${phrase}\b" | wc -l || true)
    if [[ "$n" -gt 0 ]]; then
      total=$((total + n))
      matches+=("'$phrase' x$n")
    fi
  done

  # "however" only when introducing a caveat (followed by comma or space, not at sentence start)
  h=$(echo "$content" | grep -oP '(?<!\. )however[, ]' | wc -l || true)
  if [[ "$h" -gt 0 ]]; then
    total=$((total + h))
    matches+=("'however' (caveat) x$h")
  fi

  printf "%-45s  %d\n" "$name" "$total"
  if [[ "$VERBOSE" -eq 1 && "${#matches[@]}" -gt 0 ]]; then
    for m in "${matches[@]}"; do
      printf "  %s\n" "$m"
    done
  fi
done
