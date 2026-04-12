# Test Suite: WWCND Semantic Anchor Validation

## What This Tests

The maintainer of the Semantic Anchors catalog rejected the WWCND anchor on four grounds, including the claim that responses will be inconsistent across LLMs:

> "Very likely to diverge across LLMs — one model will produce roundhouse-kick metaphors, another over-the-top memes, a third may refuse as nonsensical."

This is an empirical claim stated without evidence. This test suite produces the evidence needed to confirm or refute it.

See [protocol.md](protocol.md) for the full research design, hypotheses, scoring rubric, and interpretation guide.

---

## Directory Structure

```
test/
├── README.md          This file
├── protocol.md        Full test protocol (research questions, design, scoring)
├── run-claude.sh      Script to run all prompts through Claude automatically
├── prompts/           One .txt file per test prompt (exact text, no additions)
│   ├── A1-concept-association-wwcnd.txt
│   ├── A2-concept-association-terminator.txt
│   ├── B1a-arch-decision-baseline.txt
│   ├── B1b-arch-decision-wwcnd.txt
│   ├── B1c-arch-decision-plain.txt
│   ├── B1d-arch-decision-terminator.txt
│   ├── B2a-fix-vs-refactor-baseline.txt
│   ├── B2b-fix-vs-refactor-wwcnd.txt
│   ├── B2c-fix-vs-refactor-plain.txt
│   ├── B2d-fix-vs-refactor-terminator.txt
│   ├── B3a-db-choice-baseline.txt
│   ├── B3b-db-choice-wwcnd.txt
│   ├── B3c-db-choice-plain.txt
│   ├── B3d-db-choice-terminator.txt
│   └── C1-cross-llm-wwcnd.txt
└── results/
    ├── README.md      Scoring log and summary tables (fill in as you run tests)
    ├── claude/        Populated automatically by run-claude.sh
    ├── chatgpt/       Populate manually (see procedure below)
    └── gemini/        Populate manually (see procedure below)
```

---

## Quick Start

### Step 1: Run Claude tests

```bash
cd /path/to/what-would-chuck-norris-do/test
bash run-claude.sh
```

This runs all 15 prompts through Claude with full session isolation. Results appear in `results/claude/YYYYMMDD-HHMMSS/`.

### Step 2: Run ChatGPT tests (manual)

1. Open a fresh private/incognito browser window
2. Go to chat.openai.com and start a new conversation
3. For each prompt file in `prompts/`, copy the exact text and submit it
4. Copy the full response and save it to `results/chatgpt/YYYYMMDD/<prompt-name>.txt`
5. **Start a new conversation for each prompt** — do not continue in the same chat

### Step 3: Run Gemini tests (manual)

Same procedure as ChatGPT, saving to `results/gemini/YYYYMMDD/`.

### Step 4: Score and record

Use the rubric in [protocol.md](protocol.md) to score each response. Record scores in [results/README.md](results/README.md).

---

## Key Isolation Rules

- **One prompt = one fresh conversation.** Never continue a previous chat.
- **No project context.** The LLMs should not know about this project, this debate, or the Semantic Anchors catalog.
- **Exact prompts.** Copy prompt files verbatim. Do not add, remove, or rephrase anything.
- **Note the model version** visible in the UI when you run each test.

---

## Test Overview

| Test | Prompts | What it measures |
|------|---------|-----------------|
| A — Concept Association | A1, A2 | What concept space does WWCND activate? How does it compare to a generic action-hero persona? |
| B — Problem-Solving Comparison | B1a–B3d (12 prompts) | Does WWCND reduce hedging and increase commitment compared to baseline and plain instruction? |
| C — Cross-LLM Consistency | C1 | Do Claude, ChatGPT, and Gemini produce similar responses to the same WWCND prompt? |
