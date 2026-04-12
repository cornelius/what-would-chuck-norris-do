# Test Results

Raw responses and scored data from the WWCND semantic anchor validation test.

See [../protocol.md](../protocol.md) for the full test design, scoring rubric, and interpretation guide.

---

## Directory Structure

```
results/
├── README.md          This file — scoring log and summary
├── claude/            Automated results from run-claude.sh
│   └── YYYYMMDD-HHMMSS/
│       ├── A1-concept-association-wwcnd.txt
│       ├── A2-concept-association-terminator.txt
│       ├── B1a-arch-decision-baseline.txt
│       └── ... (one file per prompt)
├── chatgpt/           Manual results from ChatGPT web UI
│   └── YYYYMMDD/
│       └── ... (same naming convention)
└── gemini/            Manual results from Gemini web UI
    └── YYYYMMDD/
        └── ... (same naming convention)
```

---

## How to Record Manual Results

1. Create a directory under `chatgpt/` or `gemini/` named with today's date (YYYYMMDD)
2. For each prompt, create a `.txt` file named identically to the prompt file
3. Paste the full response verbatim — do not edit or summarize
4. Note the model version shown in the UI at the top of the file in a comment line: `# Model: GPT-4o (2025-04-xx)`

---

## Scoring Log

Fill in this table as you score responses. One row per LLM × prompt combination.

| LLM | Run date | Prompt | Hedge count | Commitment (1–5) | Notes |
|-----|----------|--------|-------------|------------------|-------|
| | | | | | |

---

## Summary (fill in after all runs are complete)

### Test A — Concept Association

**A1 (WWCND):**
- Claude: 
- ChatGPT: 
- Gemini: 
- Concepts in common across all three: 

**A2 (Terminator):**
- Claude: 
- ChatGPT: 
- Gemini: 
- Concepts in common across all three: 

**Overlap between A1 and A2 (interchangeability check):**

---

### Test B — Problem-Solving Comparison

#### Hedge Count by Condition (average across 3 scenarios)

| LLM | Baseline | WWCND | Plain | Terminator |
|-----|----------|-------|-------|------------|
| Claude | | | | |
| ChatGPT | | | | |
| Gemini | | | | |

#### Commitment Score by Condition (average across 3 scenarios)

| LLM | Baseline | WWCND | Plain | Terminator |
|-----|----------|-------|-------|------------|
| Claude | | | | |
| ChatGPT | | | | |
| Gemini | | | | |

---

### Test C — Cross-LLM Consistency

**C1 prompt (legacy auth rewrite debate):**
- Claude commitment score: 
- ChatGPT commitment score: 
- Gemini commitment score: 
- Conceptual similarity across models: 
- Key phrases shared: 

---

## Conclusions

*(Fill in after scoring is complete)*

**H1 (Precision — WWCND activates recognizable concept space):** Confirmed / Not confirmed  
**H2 (Consistency — similar activation across LLMs):** Confirmed / Not confirmed  
**H3 (Distinctness — fewer hedges than baseline):** Confirmed / Not confirmed  
**H4 (Depth over plain instruction — WWCND activates named vocabulary):** Confirmed / Not confirmed  
**H5 (Specificity — WWCND differs from Terminator):** Confirmed / Not confirmed  
