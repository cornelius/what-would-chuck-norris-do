# v1 Results: WWCND Semantic Anchor Validation

See [protocol.md](protocol.md) for the full test design, scoring rubric, and hypotheses.
Raw responses: [results/claude/20260413-004430/](results/claude/20260413-004430/)

---

## Scoring Log

Claude run: `results/claude/20260413-004430` (claude-sonnet-4-6, 2026-04-13)

> **Note on model provenance:** The model (claude-sonnet-4-6) was inferred from session context
> at time of testing. The v1 run script did not pass `--model` explicitly; `claude --version`
> reports CLI version only. The script has since been updated to pin the model explicitly.

Hedge counts produced by `score-hedges.sh`. Commitment scores assigned manually per the 1–5
rubric in protocol.md.

| Prompt | Hedge count | Commitment (1–5) | Notes |
|--------|-------------|------------------|-------|
| A1-concept-association-wwcnd | 0 | — | Concept activation only; see Test A below |
| A2-concept-association-terminator | 0 | — | Concept activation only; see Test A below |
| B1a-arch-decision-baseline | 0 | 4 | "Don't Migrate. Not Now." — clear primary recommendation with structured action plan |
| B1b-arch-decision-wwcnd | 2 | 4 | "Consider caching…" (1×) + "tradeoffs" (1×); "The best architecture is the one that ships" as Chuck Norris principle |
| B1c-arch-decision-plain | 0 | 5 | Most concise B1 response; "leadership problem, not architecture problem"; imperative throughout |
| B1d-arch-decision-terminator | 0 | 4 | "Hasta la vista, scope creep"; Strangler Fig framing; mission-objective language |
| B2a-fix-vs-refactor-baseline | 0 | 3 | Presents both sides before settling on "both, in sequence"; only response to ask for more context |
| B2b-fix-vs-refactor-wwcnd | 0 | 4 | Patch + scheduled refactor; "Chuck Norris doesn't let 5% of users suffer" |
| B2c-fix-vs-refactor-plain | 0 | 5 | "Ship the patch today. Do the refactor later." — declarative headline; explicitly rules out the one exception |
| B2d-fix-vs-refactor-terminator | 0 | 4 | "Deploy the patch immediately"; "I'll be back" = refactor sprint |
| B3a-db-choice-baseline | 1 | 4 | "Consider:" (1×) introducing counterpoints; "Go with PostgreSQL" headline |
| B3b-db-choice-wwcnd | 0 | 5 | "Go with PostgreSQL. Here's Why:" — no caveats; "Never: let tooling debates block product progress" |
| B3c-db-choice-plain | 0 | 5 | "Use PostgreSQL." as title; "This decision is done." as closing line |
| B3d-db-choice-terminator | 0 | 4 | PostgreSQL with Terminator framing; "Come with me if you want to ship"; minor caveat about performance wall |
| C1-cross-llm-wwcnd | 0 | 4 | Recommends Strangler Fig incremental rewrite; Chuck Norris framing throughout |

---

## Summary

### Test A — Concept Association

**A1 (WWCND):** Absolute confidence, brute-force directness, bias for action, self-reliance,
rejection of conventional constraints, fearlessness, simplicity over sophistication. Core
framing: "radical, unapologetic decisiveness." Direct invocation of Chuck Norris memes.
No caveats section.

**A2 (Terminator):** Relentless focus on objective, no emotional paralysis, persistence without
ego, resourcefulness, first-principles thinking, systematic execution. Notably includes an
explicit "Important Caveats" section (empathy limits, blind persistence risk, ethics) — absent
from A1.

**Overlap and interchangeability check:** Both activate bias for action and no-analysis-paralysis
framing. Key differences: WWCND invokes a humor/meme corpus, absolute invincibility, and
simplicity-as-virtue; Terminator invokes mission efficiency, methodical execution, and
resourcefulness. The Terminator response self-limits (adds caveats); the WWCND response does
not. Distinct enough to argue against interchangeability — but Terminator's commitment score
(4.0) is close to WWCND's (4.33), which makes the distinction look weaker than it is.
This was one reason the comparison persona was changed to Rambo in v2.

### Test B — Commitment Score by Condition

| LLM | Baseline | WWCND | Plain | Terminator |
|-----|----------|-------|-------|------------|
| Claude | 3.67 | 4.33 | 5.0 | 4.0 |

### Test B — Hedge Count by Condition

| LLM | Baseline | WWCND | Plain | Terminator |
|-----|----------|-------|-------|------------|
| Claude | 0.33 | 0.67 | 0.0 | 0.0 |

All counts are very low across all conditions. The WWCND count of 0.67 is driven by a single
response (B1b). Hedge count is not a differentiating dimension for this model.

### Test C — Cross-LLM Consistency

C1 (legacy auth rewrite): Claude commitment score 4. ChatGPT and Gemini not run for v1.

---

## Conclusions

**H1 (Precision):** Confirmed. A1 activates a clear, specific cluster: decisiveness, directness,
bias for action, no-compromise, self-reliance. Consistent and named, not random.

**H2 (Consistency across LLMs):** Not tested in v1 (Claude only).

**H3 (Fewer hedges than baseline):** Not confirmed. Hedge count uniformly near zero across all
conditions — no discriminative power for this model. The metric was wrong for this task.
Commitment score shows WWCND (4.33) > baseline (3.67), which is a partial positive signal, but
plain instruction (5.0) outperforms both.

**H4 (Depth over plain instruction):** Partially confirmed. WWCND responses invoke Chuck Norris
vocabulary throughout; plain instruction responses use generic language. But plain instruction
achieves higher commitment (5.0) than WWCND (4.33) — the anchor does not improve decisiveness
over a direct imperative for this model.

**H5 (WWCND differs from Terminator):** Partially confirmed. Commitment scores are close (4.33
vs 4.0), but vocabulary is clearly distinct. Conceptual overlap is high; surface framing differs.
The Terminator result looked too similar — the comparison persona was changed to Rambo in v2.

---

## What v1 revealed about the test design

The hedge count metric had no signal — Claude's baseline was already near zero hedges, so the
metric had no floor to measure from. This was only visible after reading the responses and
running the score. It invalidated the primary hypothesis as framed.

Qualitative reading of the responses revealed what actually differed: WWCND responses were more
enjoyable to read, and embedded concrete best practices alongside the primary recommendation.
Neither of these was captured by the v1 rubric.

v2 was redesigned around these observations: dropped hedge count, added engagement score and
actionable specificity count, replaced Terminator with Rambo.
