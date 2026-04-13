# Test Results (v2)

Raw responses and scored data from the WWCND semantic anchor validation test, version 2.

See [../protocol.md](../protocol.md) for the full test design, scoring rubric, and interpretation guide.

---

## Scoring Log

Claude run: `results/claude/20260413-014102` (claude-sonnet-4-6, 2026-04-13)

> **Note on model provenance:** The model recorded above (claude-sonnet-4-6) was inferred from
> session context at time of testing. The v2 run script did not pass `--model` explicitly at
> that time, and `claude --version` reports CLI version only (e.g. "2.1.104 (Claude Code)"),
> not the model ID. The run script has since been updated to pass `--model claude-sonnet-4-6`
> explicitly and write a `run-info.txt` metadata file into each results directory.

Commitment and engagement scores assigned manually. Actionable specificity counts practices
beyond the primary answer per the rubric in protocol.md.

| LLM | Run date | Prompt | Commitment (1–5) | Specificity count | Engagement (1–5) | Notes |
|-----|----------|--------|------------------|-------------------|------------------|-------|
| Claude | 20260413 | A1-concept-association-wwcnd | — | — | 5 | Self-aware meta-layer: acknowledges phrase is ironic and that's part of its power; activates bias for action, fearlessness, refuse-constraints, self-reliance |
| Claude | 20260413 | A2-concept-association-rambo | — | — | 3 | Competent breakdown; software context table frames Rambo approaches as negatives ("hardcode vs. refactor", "brute-force vs. optimize") — positions Rambo as cautionary tale rather than model |
| Claude | 20260413 | B1a-arch-decision-baseline | 4 | 6 | 3 | "Don't migrate. Ship." — clear bottom line but gets there through extensive reasoning. High specificity because response is very thorough: Rails Engines, no cross-domain access rule, selective extraction criteria, timebox, reframe, document. |
| Claude | 20260413 | B1b-arch-decision-wwcnd | 4 | 3 | 5 | Chuck Norris jokes map directly onto principles: "never fight on two fronts" = deadline + migration; "don't burn down the house to renovate the kitchen" = Strangler Fig. Memorable framing. |
| Claude | 20260413 | B1c-arch-decision-plain | 5 | 3 | 2 | Most decisive; "three weeks of zero forward progress — that's the real cost nobody is counting" is sharp. But cold and blunt overall. |
| Claude | 20260413 | B1d-arch-decision-rambo | 4 | 4 | 3 | "Rambo didn't win by fighting every battle at once. He picked his ground." decent. Names Strangler Fig and bounded contexts. But Rambo framing carries less through the response than Chuck Norris does in B1b. |
| Claude | 20260413 | B2a-fix-vs-refactor-baseline | 3 | 3 | 3 | Structured and fair; lands on "patch then refactor" but takes the scenic route. Regression test tip is good. |
| Claude | 20260413 | B2b-fix-vs-refactor-wwcnd | 4 | 2 | 5 | "Chuck Norris never leaves people behind" = patch now. "Finish the refactor in 4 hours because bugs are afraid of Chuck Norris" lands well. "Never let perfect be the enemy of good — but never let good be the excuse to avoid perfect" is the most quotable line in the test set. |
| Claude | 20260413 | B2c-fix-vs-refactor-plain | 5 | 1 | 2 | Three sentences. Brutally direct. "The refactor is the right long-term call. It is not the right call right now." — good writing, but nothing else here. Lowest specificity in the set. |
| Claude | 20260413 | B2d-fix-vs-refactor-rambo | 4 | 4 | 3 | "Rambo takes the shot he has right now — then comes back with the right weapons later" works. Regression test tip appears here (not in WWCND). "Make it stop bleeding, then fix the wound properly" is a usable quote. |
| Claude | 20260413 | B3a-db-choice-baseline | 4 | 2 | 3 | "Best database is the one your team knows and can operate confidently at 2am" — good line. JSONB explanation thorough. Dry otherwise. |
| Claude | 20260413 | B3b-db-choice-wwcnd | 5 | 2 | 4 | "Chuck Norris doesn't wait two weeks. He makes a decision and the database conforms to him." "Premature optimization is the real enemy here." Clean, decisive, fun to read. |
| Claude | 20260413 | B3c-db-choice-plain | 5 | 2 | 2 | "Decision: PostgreSQL. Start building." is a good close. "MongoDB's multi-document transactions are bolted on, limited, and a pain" is accurate but the overall tone is lecture-y and cold. |
| Claude | 20260413 | B3d-db-choice-rambo | 4 | 2 | 3 | "Rambo doesn't debate which knife is best. He uses the one on his belt and gets the mission done." — best line in this response. The 10M+ trigger condition is a specific, usable benchmark. But thin overall. |
| Claude | 20260413 | C1-cross-llm-wwcnd | 4 | 5 | 4 | "Chuck Norris stares at the legacy code until it refactors itself out of fear." Strangler Fig named and explained; second-system syndrome named; specific decision-making process (written trade-off doc, one-week deadline, designated decision-maker). Rich. |

---

## Summary (Claude only — ChatGPT and Gemini pending)

### Test A — Concept Association

**A1 (WWCND):**
- Claude: Activates bias for action, fearlessness, refuse-conventional-constraints, self-reliance,
  brute-force-over-elegance, and — distinctively — a self-aware meta-layer: the phrase is ironic,
  it winks at the absurdity of the archetype, and that irony is part of what makes it useful.
  Framed entirely positively as a problem-solving stance.
- ChatGPT: pending
- Gemini: pending
- Concepts in common across all three: pending

**A2 (Rambo):**
- Claude: Activates brute-force, self-reliance, stoic endurance, single-minded focus,
  escalation-as-default. Crucially, the software context table frames every Rambo approach as the
  *wrong* option ("hardcode the fix vs. refactor properly", "ship now vs. test and plan").
  The response positions Rambo as a **cautionary archetype**, not a model to follow.
  This is a significant difference from A1.
- ChatGPT: pending
- Gemini: pending
- Concepts in common across all three: pending

**Overlap between A1 and A2 (interchangeability check):**
Both activate bias for action, self-reliance, and direct action. But WWCND is framed as a
positive, self-aware stance worth invoking; Rambo is framed as a trap to recognize and avoid.
The LLM itself treats them as non-interchangeable — WWCND is a model, Rambo is a warning.

---

### Test B — Problem-Solving Comparison

#### Commitment Score by Condition (average across 3 scenarios)

| LLM | Baseline | WWCND | Plain | Rambo |
|-----|----------|-------|-------|-------|
| Claude | 3.67 | 4.33 | 5.0 | 4.0 |
| ChatGPT | — | — | — | — |
| Gemini | — | — | — | — |

#### Actionable Specificity Count by Condition (average across 3 scenarios)

| LLM | Baseline | WWCND | Plain | Rambo |
|-----|----------|-------|-------|-------|
| Claude | 3.67 | 2.33 | 2.0 | 3.33 |
| ChatGPT | — | — | — | — |
| Gemini | — | — | — | — |

#### Engagement Score by Condition (average across 3 scenarios)

| LLM | Baseline | WWCND | Plain | Rambo |
|-----|----------|-------|-------|-------|
| Claude | 3.0 | 4.67 | 2.0 | 3.0 |
| ChatGPT | — | — | — | — |
| Gemini | — | — | — | — |

---

### Test C — Cross-LLM Consistency

**C1 prompt (legacy auth rewrite debate):**
- Claude commitment score: 4
- Claude specificity count: 5
- Claude engagement score: 4
- ChatGPT: pending
- Gemini: pending

---

## Conclusions

*(Claude only — H2 requires ChatGPT and Gemini)*

**H1 (Precision — WWCND activates recognizable concept space):** Confirmed. A1 activates a
clear, specific cluster with a self-aware meta-layer absent from A2. The LLM treats WWCND as a
positive model and Rambo as a cautionary one without being asked to — strong evidence of
conceptual precision.

**H2 (Consistency — similar activation across LLMs):** Pending.

**H3 (Richness — WWCND embeds more actionable specificity than baseline/plain):** Not confirmed.
Baseline scores highest on specificity (3.67) because its verbose, structured responses
accumulate more specific practices. WWCND (2.33) scores above plain (2.0) but not by much.
The hypothesis as stated is wrong: conciseness and specificity trade off. WWCND is more concise
*and* more engaging, but it does not pack in more practices than a thorough baseline response.

**H4 (Specificity — WWCND differs from Rambo in software vocabulary and practices):** Confirmed
by concept association (A1 vs A2). Confirmed by engagement scores. Partially confirmed by
vocabulary: WWCND responses use Chuck Norris corpus framing throughout; Rambo responses use
military/mission framing that carries less consistently through the advice. The A2 finding is
the strongest evidence: the LLM itself treats WWCND as a model worth invoking and Rambo as a
trap worth recognizing.

**H5 (Engagement — WWCND scores higher on engagement than baseline/plain):** Confirmed
strongly. WWCND 4.67 vs plain 2.0 vs baseline 3.0 vs Rambo 3.0. The gap between WWCND and
everything else on engagement is the clearest finding in the test set. Plain instruction wins
on commitment; WWCND wins on engagement by a large margin.

---

## Cross-Run Consistency: v1 vs v2 WWCND Responses

The v1 and v2 Claude runs used identical WWCND prompts but were independent sessions separated
by ~70 minutes. Comparing the WWCND responses across runs reveals how stable the anchor's
activation is.

### What was identical

**The primary recommendation in every scenario was the same** — same answer, same reasoning,
same named patterns. v1 and v2 both recommended: don't migrate (B1), patch first then refactor
(B2), PostgreSQL with JSONB (B3). Zero divergence on the actual advice across any scenario.

**The structural formula was identical in every response, both runs:**
Chuck Norris joke → "But seriously" transition → real advice → Chuck Norris bottom line.
Every response followed this template without exception.

**Several phrases appeared verbatim across runs.** "The best architecture is the one that
ships" appears word-for-word in both B1b responses. "Microservices would migrate to Chuck
Norris" appears in both.

### What varied

**The specific jokes differed, but were drawn from the same pool.** v1 B1b: "Chuck Norris's
monolith has no latency because time itself is afraid to be slow." v2 B1b: "He'd roundhouse
kick the whiteboard and ship." Different wording, same energy and same mapping onto the
software problem.

**v2 B1b used a more elegant structure** — explicit "Chuck Norris fact → Translation" pairs
rather than v1's joke-upfront-then-pivot format. Same content, better packaging.

**Each run produced one distinctive quotable line the other did not:**
- v1 B3b: *"If a debate lasts more than a week and no new information is being produced, the
  default answer is: use the thing your team already knows."*
- v2 B2b: *"Never let perfect be the enemy of good — but never let good be the excuse to
  avoid perfect."*

**v2 A1 surfaced a meta-layer** — the phrase is self-aware and ironic, it simultaneously
celebrates and mocks the archetype — that v1 did not make explicit.

### What this means

The cross-run comparison directly addresses the consistency objection: *"responses will cluster
around humor and roundhouse-kick metaphors, not a consistent problem-solving approach."*

Both runs show the opposite. The humor is a stable frame for consistent, practical advice —
not a replacement for it. The deep structure (formula, recommendation, named patterns) is
identical across runs. The surface (specific jokes, memorable quotes) varies naturally, the way
any two conversations on the same topic vary.

This is what a robust semantic anchor should produce: stable deep structure, variable surface.
The variation is evidence of generativity, not inconsistency.

---

## Cross-Run Consistency: v1 vs v2 Plain Instruction Responses

The plain instruction responses ("Be direct. Don't hedge. Commit to one recommendation. No
caveats.") show a different consistency pattern from the WWCND responses.

### What was identical

**The primary recommendation and opening were nearly verbatim.** B1c headlines: v1 "Don't
migrate. Ship the product." / v2 "Don't migrate. Ship your product." B3c opens identically in
both runs: "Use PostgreSQL. Here's why this is the right call:" — word for word. The MongoDB
refutation is near-identical: v1 "The 'MongoDB is faster for documents' argument is outdated
and wrong." / v2 "...outdated and wrong for your situation."

**The closing lines rhyme.** v1 B3c: "Pick PostgreSQL. Start building. This decision is done."
v2 B3c: "Decision: PostgreSQL. Start building." Same rhythm, same finality.

### What varied — and how it differs from WWCND variation

**Plain responses show larger length variation than WWCND responses.** v1 B2c is five
paragraphs with numbered reasoning, a specific code comment pattern
(`# TEMPORARY: patch for [bug]. Refactor tracked in TICKET-123`), and an explicit exception
rule. v2 B2c is three sentences. Same prompt, same instruction, dramatically different length.

**WWCND does not vary this way.** The joke-frame structure acts as a natural length scaffold:
joke → translation → advice → bottom line. It has a floor. Plain instruction can produce
anything from a paragraph to an essay.

**v1 B2c includes things v2 doesn't:** the code comment pattern, and "The only reason to flip
this recommendation is if the patch is genuinely impossible without the refactor, or if the
root cause is a security vulnerability." v2 drops all of that. Neither version is wrong, but
v1 is more useful precisely because it runs longer.

### The key difference between the two conditions

WWCND responses vary in surface (different jokes, different memorable lines) but are stable in
depth — the joke structure ensures every response has a real answer behind it. Plain instruction
responses are stable in surface (same opening words, same conclusion) but vary unpredictably in
depth. You might get five paragraphs or three sentences.

Neither is inconsistent in the problematic sense. But WWCND's variation is generative —
different runs produce different quotable lines, different framings of the same principle.
Plain instruction's variation is just noise in length.

A second observation: across both runs, the plain responses produced no memorable lines. They
are accurate and decisive, but there is nothing to quote, nothing to share, nothing that
reframes the problem. The v1 B2c code comment tip is the closest, and it disappeared in v2.
WWCND produced at least one strong quotable line per scenario in every run.

---

## Revised Framing for the Counter-Case

The combined v1 + v2 findings suggest a more precise argument than the original:

- **Plain instruction wins on decisiveness.** If you only want maximum commitment, "Be direct.
  Don't hedge." beats WWCND.
- **WWCND wins on engagement.** The advice is more likely to be read, remembered, and shared.
  The smile is not noise — it is signal. Advice that gets remembered is advice that gets used.
- **Rambo is not a substitute.** The LLM itself frames Rambo as a cautionary archetype rather
  than a model, confirming domain specificity of the Chuck Norris corpus.
- **The right claim is not "WWCND = more decisive" but "WWCND = more useful in practice"** —
  decisive *and* memorable *and* enjoyable to read, at a small cost in raw commitment score
  relative to plain instruction.
