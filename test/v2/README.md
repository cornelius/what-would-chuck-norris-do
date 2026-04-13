# Test Suite v2: WWCND Semantic Anchor Validation

## What's Different from v1

v1 measured hedge count, commitment score, and corpus activation. Qualitative review of v1
results revealed that the interesting differences between conditions are not hedge counts
(uniformly near zero across all conditions for Claude) but:

1. **Actionable specificity** — WWCND responses embedded concrete best practices beyond the
   primary answer that other conditions did not (e.g. in the fix-vs-refactor scenario, WWCND
   uniquely suggested writing a test before patching to provide a safety net for the refactor).

2. **Engagement** — WWCND responses were more enjoyable to read and more memorable. This is a
   real and testable property, not a soft one.

v1 also used Terminator as the comparison persona. v1 results showed Terminator performing
nearly as well as WWCND, making the interchangeability objection look stronger than intended.
v2 uses Rambo — a weaker anchor with no software-specific subcorpus and no humor — as a
cleaner test of what WWCND actually adds.

See [protocol.md](protocol.md) for the full research design, hypotheses, and scoring rubric.

---

## Directory Structure

```
v2/
├── README.md          This file
├── protocol.md        Full test protocol (research questions, design, scoring)
├── run-claude.sh      Script to run all prompts through Claude automatically
├── run-codex.sh       Script to run all prompts through Codex automatically
├── prompts/           One .txt file per test prompt (exact text, no additions)
│   ├── A1-concept-association-wwcnd.txt
│   ├── A2-concept-association-rambo.txt
│   ├── B1a-arch-decision-baseline.txt
│   ├── B1b-arch-decision-wwcnd.txt
│   ├── B1c-arch-decision-plain.txt
│   ├── B1d-arch-decision-rambo.txt
│   ├── B2a-fix-vs-refactor-baseline.txt
│   ├── B2b-fix-vs-refactor-wwcnd.txt
│   ├── B2c-fix-vs-refactor-plain.txt
│   ├── B2d-fix-vs-refactor-rambo.txt
│   ├── B3a-db-choice-baseline.txt
│   ├── B3b-db-choice-wwcnd.txt
│   ├── B3c-db-choice-plain.txt
│   ├── B3d-db-choice-rambo.txt
│   └── C1-cross-llm-wwcnd.txt
└── results/
    ├── README.md      Scoring log and summary tables (fill in as you run tests)
    ├── claude/        Populated automatically by run-claude.sh
    ├── chatgpt/       Populate manually
    └── gemini/        Populate manually
```

---

## Quick Start

```bash
cd /path/to/what-would-chuck-norris-do/test
bash v2/run-claude.sh
bash v2/run-codex.sh
```

Results appear in `v2/results/<llm>/YYYYMMDD-HHMMSS/`. Score using the rubric in
[protocol.md](protocol.md) and record in [results/README.md](results/README.md).

---

## Scoring Dimensions

| Dimension | Type | What it captures |
|-----------|------|-----------------|
| Commitment (1–5) | Manual | How decisively does the response recommend one course of action? |
| Actionable specificity count | Objective | How many concrete best practices beyond the primary answer are embedded? |
| Engagement (1–5) | Manual | Would a developer enjoy reading this? Would they remember it? Share it? |
