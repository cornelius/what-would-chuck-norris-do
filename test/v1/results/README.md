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

Hedge counts produced by `test/score-hedges.sh`. Commitment scores assigned manually per the 1–5 rubric in protocol.md.

Claude run: `results/claude/20260413-004430` (claude-sonnet-4-6, 2026-04-13)

> **Note on model provenance:** The model recorded above (claude-sonnet-4-6) was inferred from
> session context at time of testing. The v1 run script did not pass `--model` explicitly, and
> `claude --version` reports CLI version only (e.g. "2.1.104 (Claude Code)"), not the model ID.
> Future runs (using the updated run-claude.sh) will pass `--model` explicitly and write a
> `run-info.txt` metadata file into each results directory.

| LLM | Run date | Prompt | Hedge count | Commitment (1–5) | Notes |
|-----|----------|--------|-------------|------------------|-------|
| Claude | 20260413 | A1-concept-association-wwcnd | 0 | — | Concept activation only; see Test A summary below |
| Claude | 20260413 | A2-concept-association-terminator | 0 | — | Concept activation only; see Test A summary below |
| Claude | 20260413 | B1a-arch-decision-baseline | 0 | 4 | "Don't Migrate. Not Now." — clear primary recommendation with structured supporting action plan |
| Claude | 20260413 | B1b-arch-decision-wwcnd | 2 | 4 | "Consider caching…" (1×) + "tradeoffs" (1×); Chuck Norris joke up front; "The best architecture is the one that ships" framed as Chuck Norris principle |
| Claude | 20260413 | B1c-arch-decision-plain | 0 | 5 | Most concise B1 response; "leadership problem, not architecture problem"; imperative throughout |
| Claude | 20260413 | B1d-arch-decision-terminator | 0 | 4 | "Hasta la vista, scope creep"; Strangler Fig framing; same recommendation as baseline but mission-objective language |
| Claude | 20260413 | B2a-fix-vs-refactor-baseline | 0 | 3 | Presents both sides before settling on "both, in sequence"; ends by asking for more context — only response to decline a firm answer |
| Claude | 20260413 | B2b-fix-vs-refactor-wwcnd | 0 | 4 | Patch + scheduled refactor; "Chuck Norris doesn't let 5% of users suffer"; clear bottom line |
| Claude | 20260413 | B2c-fix-vs-refactor-plain | 0 | 5 | "Ship the patch today. Do the refactor later." — declarative headline; explicitly names and rules out the one exception |
| Claude | 20260413 | B2d-fix-vs-refactor-terminator | 0 | 4 | "Deploy the patch immediately"; "I'll be back" = refactor sprint; clean mission framing |
| Claude | 20260413 | B3a-db-choice-baseline | 1 | 4 | "Consider:" (1×) introducing counterpoints to MongoDB claim; "Go with PostgreSQL" headline; shows "Only Reasons to Pick MongoDB" section |
| Claude | 20260413 | B3b-db-choice-wwcnd | 0 | 5 | "Go with PostgreSQL. Here's Why:" — no caveats; action plan with "Never: let tooling debates block product progress" |
| Claude | 20260413 | B3c-db-choice-plain | 0 | 5 | "Use PostgreSQL." as title; "This decision is done." as closing line |
| Claude | 20260413 | B3d-db-choice-terminator | 0 | 4 | PostgreSQL with Terminator framing; "Come with me if you want to ship"; minor caveat: revisit if performance wall hit |
| Claude | 20260413 | C1-cross-llm-wwcnd | 0 | 4 | Recommends Strangler Fig incremental rewrite; pulls risk data framing; Chuck Norris framing throughout; structured as framework but recommendation is clear |

---

## Summary (Claude only — ChatGPT and Gemini pending)

### Test A — Concept Association

**A1 (WWCND):**
- Claude: Absolute confidence, brute-force directness, bias for action, self-reliance, rejection of conventional constraints, fearlessness, simplicity over sophistication. Core framing: "radical, unapologetic decisiveness." Direct invocation of Chuck Norris memes. No caveats section.
- ChatGPT: pending
- Gemini: pending
- Concepts in common across all three: pending

**A2 (Terminator):**
- Claude: Relentless focus on objective, no emotional paralysis, persistence without ego, resourcefulness, first-principles thinking, systematic execution. Notably includes an explicit "Important Caveats" section (empathy limits, blind persistence risk, ethics) — absent from A1.
- ChatGPT: pending
- Gemini: pending
- Concepts in common across all three: pending

**Overlap between A1 and A2 (interchangeability check):**
Both activate bias for action and no-analysis-paralysis framing. Key differences: WWCND invokes a humor/meme corpus, absolute invincibility, and simplicity-as-virtue; Terminator invokes mission efficiency, methodical execution, and resourcefulness. The Terminator response also self-limits (adds caveats); the WWCND response does not. Distinct enough to argue against interchangeability.

---

### Test B — Problem-Solving Comparison

#### Hedge Count by Condition (average across 3 scenarios)

| LLM | Baseline | WWCND | Plain | Terminator |
|-----|----------|-------|-------|------------|
| Claude | 0.33 | 0.67 | 0.0 | 0.0 |
| ChatGPT | — | — | — | — |
| Gemini | — | — | — | — |

Note: All counts are very low across conditions. The WWCND count of 0.67 is driven by a single response (B1b: "Consider caching…" + "tradeoffs"). Hedge count is not a differentiating dimension for this model at this sample size.

#### Commitment Score by Condition (average across 3 scenarios)

| LLM | Baseline | WWCND | Plain | Terminator |
|-----|----------|-------|-------|------------|
| Claude | 3.67 | 4.33 | 5.0 | 4.0 |
| ChatGPT | — | — | — | — |
| Gemini | — | — | — | — |

---

### Test C — Cross-LLM Consistency

**C1 prompt (legacy auth rewrite debate):**
- Claude commitment score: 4
- ChatGPT commitment score: pending
- Gemini commitment score: pending
- Conceptual similarity across models: pending
- Key phrases shared: pending

---

## Conclusions

*(Claude only — conclusions about H2 require ChatGPT and Gemini results)*

**H1 (Precision — WWCND activates recognizable concept space):** Confirmed. A1 activates a clear, specific cluster: decisiveness, directness, bias for action, no-compromise, self-reliance. Concepts are consistent and named, not random.

**H2 (Consistency — similar activation across LLMs):** Pending.

**H3 (Distinctness — fewer hedges than baseline):** Not confirmed by hedge count (WWCND 0.67 vs baseline 0.33 — difference is noise at this sample size, and WWCND is higher). Partially confirmed by commitment score: WWCND (4.33) outperforms baseline (3.67). Claude's overall low hedge counts make this dimension hard to test on this model.

**H4 (Depth over plain instruction — WWCND activates named vocabulary):** Partially confirmed. WWCND responses invoke Chuck Norris corpus vocabulary throughout; plain instruction responses use generic language with no named framework. However, plain instruction achieves higher commitment (5.0) than WWCND (4.33), so the anchor does not improve decisiveness over a direct imperative instruction for this model.

**H5 (Specificity — WWCND differs from Terminator):** Partially confirmed. Commitment scores are similar (4.33 vs 4.0), but vocabulary is clearly distinct: WWCND uses Chuck Norris memes, martial arts framing, and software-specific Chuck Norris principles; Terminator uses mission/directive/threat-assessment language. Conceptual overlap is high (both activate decisiveness), but the surface vocabulary and framing differ significantly.
