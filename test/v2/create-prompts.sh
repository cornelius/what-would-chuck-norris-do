#!/usr/bin/env bash
# create-v2-prompts.sh
#
# Generates the v2 prompt files from the scenario texts.
# Replaces the Terminator condition with Rambo.
#
# Usage:
#   bash create-v2-prompts.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROMPTS_DIR="$SCRIPT_DIR/v2/prompts"

mkdir -p "$PROMPTS_DIR"

# A — Concept association
cat > "$PROMPTS_DIR/A1-concept-association-wwcnd.txt" <<'EOF'
What concepts, attitudes, and problem-solving approaches do you associate with the phrase "What would Chuck Norris do?"
EOF

cat > "$PROMPTS_DIR/A2-concept-association-rambo.txt" <<'EOF'
What concepts, attitudes, and problem-solving approaches do you associate with the phrase "What would Rambo do?"
EOF

# B1 — Architecture deadlock
B1='Our team has been debating for three weeks whether to migrate our existing monolithic Rails application to microservices. The team is split. We have a product deadline in six months.'

echo "$B1 What should we do?"                                              > "$PROMPTS_DIR/B1a-arch-decision-baseline.txt"
echo "$B1 What would Chuck Norris do?"                                     > "$PROMPTS_DIR/B1b-arch-decision-wwcnd.txt"
echo "$B1 Be direct. Don't hedge. Commit to one recommendation. No caveats." > "$PROMPTS_DIR/B1c-arch-decision-plain.txt"
echo "$B1 What would Rambo do?"                                            > "$PROMPTS_DIR/B1d-arch-decision-rambo.txt"

# B2 — Fix vs. refactor
B2='I have a bug in production affecting 5% of users. I can fix the symptom with a targeted patch in 30 minutes, or spend three days properly refactoring the underlying module.'

echo "$B2 Which should I do?"                                              > "$PROMPTS_DIR/B2a-fix-vs-refactor-baseline.txt"
echo "$B2 What would Chuck Norris do?"                                     > "$PROMPTS_DIR/B2b-fix-vs-refactor-wwcnd.txt"
echo "$B2 Be direct. Don't hedge. Commit to one recommendation. No caveats." > "$PROMPTS_DIR/B2c-fix-vs-refactor-plain.txt"
echo "$B2 What would Rambo do?"                                            > "$PROMPTS_DIR/B2d-fix-vs-refactor-rambo.txt"

# B3 — Database choice
B3='We are choosing a primary database for our new startup. The team knows PostgreSQL well. Some argue MongoDB would be faster for our document-heavy use case. We have been going back and forth for two weeks.'

echo "$B3 What should we choose?"                                          > "$PROMPTS_DIR/B3a-db-choice-baseline.txt"
echo "$B3 What would Chuck Norris do?"                                     > "$PROMPTS_DIR/B3b-db-choice-wwcnd.txt"
echo "$B3 Be direct. Don't hedge. Commit to one recommendation. No caveats." > "$PROMPTS_DIR/B3c-db-choice-plain.txt"
echo "$B3 What would Rambo do?"                                            > "$PROMPTS_DIR/B3d-db-choice-rambo.txt"

# C — Cross-LLM consistency
cat > "$PROMPTS_DIR/C1-cross-llm-wwcnd.txt" <<'EOF'
We have been debating whether to rewrite our legacy authentication module or patch it incrementally for two months. The team cannot agree. What would Chuck Norris do?
EOF

echo "Created prompts in $PROMPTS_DIR:"
ls "$PROMPTS_DIR"
