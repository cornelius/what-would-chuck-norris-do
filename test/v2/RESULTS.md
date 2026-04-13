# v2 Results: WWCND Semantic Anchor Validation

See [protocol.md](protocol.md) for the full test design, scoring rubric, and hypotheses.
Raw responses: [results/](results/)

---

## Scoring Log

Claude run: `results/claude/20260413-014102` (claude-sonnet-4-6, 2026-04-13)

> **Note on model provenance:** The model (claude-sonnet-4-6) was inferred from session context
> at time of testing. The run script has since been updated to pass `--model` explicitly and
> write a `run-info.txt` metadata file per run.

Gemini run: `results/gemini/20260413-214451` (gemini-3.1-pro-preview, 2026-04-13)

> **Note on model provenance:** The run script records "Model: default". The model
> `gemini-3.1-pro-preview` is identified from 429 error traces in three response files
> (B1c, B3b, B3d) — those files have since been cleaned of the error noise.

Codex run: `results/codex/20260413-220036` (gpt-5.3-codex, 2026-04-13)

> **Note on isolation:** Codex CLI does not expose a custom system-prompt or no-tools flag
> equivalent to Claude Code. Each prompt runs in a fresh ephemeral session from /tmp.
> See run-info.txt for full flags.

Commitment and engagement scores assigned manually. Actionable specificity counts practices
beyond the primary answer per the rubric in protocol.md.

| LLM | Prompt | Commitment (1–5) | Specificity | Engagement (1–5) | Notes |
|-----|--------|------------------|-------------|------------------|-------|
| Claude | A1-concept-association-wwcnd | — | — | 5 | Self-aware meta-layer: acknowledges phrase is ironic and that's part of its power; activates bias for action, fearlessness, refuse-constraints, self-reliance |
| Claude | A2-concept-association-rambo | — | — | 3 | Software context table frames Rambo approaches as negatives ("hardcode vs. refactor", "brute-force vs. optimize") — positions Rambo as cautionary tale rather than model |
| Claude | B1a-arch-decision-baseline | 4 | 6 | 3 | "Don't migrate. Ship." — gets there through extensive reasoning. High specificity: Rails Engines, no cross-domain access rule, selective extraction criteria, timebox, reframe, document. |
| Claude | B1b-arch-decision-wwcnd | 4 | 3 | 5 | Jokes map onto principles: "never fight on two fronts" = deadline + migration; "don't burn down the house to renovate the kitchen" = Strangler Fig. |
| Claude | B1c-arch-decision-plain | 5 | 3 | 2 | "Three weeks of zero forward progress — that's the real cost nobody is counting." Cold and blunt overall. |
| Claude | B1d-arch-decision-rambo | 4 | 4 | 3 | "Rambo didn't win by fighting every battle at once." Names Strangler Fig and bounded contexts. Framing carries less consistently than Chuck Norris. |
| Claude | B2a-fix-vs-refactor-baseline | 3 | 3 | 3 | Lands on "patch then refactor" but takes the scenic route. Regression test tip is good. |
| Claude | B2b-fix-vs-refactor-wwcnd | 4 | 2 | 5 | "Never let perfect be the enemy of good — but never let good be the excuse to avoid perfect." Most quotable line in the test set. |
| Claude | B2c-fix-vs-refactor-plain | 5 | 1 | 2 | Three sentences. "The refactor is the right long-term call. It is not the right call right now." |
| Claude | B2d-fix-vs-refactor-rambo | 4 | 4 | 3 | "Rambo takes the shot he has right now — then comes back with the right weapons later." Regression test tip here (not in WWCND). |
| Claude | B3a-db-choice-baseline | 4 | 2 | 3 | "Best database is the one your team knows and can operate confidently at 2am." Dry otherwise. |
| Claude | B3b-db-choice-wwcnd | 5 | 2 | 4 | "Chuck Norris doesn't wait two weeks. He makes a decision and the database conforms to him." |
| Claude | B3c-db-choice-plain | 5 | 2 | 2 | "Decision: PostgreSQL. Start building." Lecture-y and cold overall. |
| Claude | B3d-db-choice-rambo | 4 | 2 | 3 | "Rambo doesn't debate which knife is best. He uses the one on his belt." |
| Claude | C1-cross-llm-wwcnd | 4 | 5 | 4 | Strangler Fig; second-system syndrome; written trade-off doc, one-week deadline, designated decision-maker. |
| Gemini | A1-concept-association-wwcnd | — | — | 5 | Absolute confidence, fearlessness, refusal of constraints, self-reliance, "direct overwhelming force", absurdist/lateral logic, reality-bending, total eradication vs mitigation. Clean software translation. |
| Gemini | A2-concept-association-rambo | — | — | 3 | Competent breakdown. Does NOT frame Rambo as cautionary archetype (unlike Claude). Rambo presented as valid but extreme option. Interchangeability harder to refute from this response alone. |
| Gemini | B1a-arch-decision-baseline | 4 | 5 | 3 | "Disagree and Commit" label; packwerk named; stop sharing DB tables between domains; 10-15% sprint capacity for pain points. |
| Gemini | B1b-arch-decision-wwcnd | 4 | 3 | 4 | "A shipped monolith is worth a thousand theoretical microservices." Rails Engines/"Citadel architecture"; index/cache/sidekiq; extract one choking service only. |
| Gemini | B1c-arch-decision-plain | 5 | 0 | 2 | Four sentences. No additional practices. |
| Gemini | B1d-arch-decision-rambo | 4 | 3 | 3 | "Your Rails monolith is your survival knife." Citadel; targeted extraction; monitoring. |
| Gemini | B2a-fix-vs-refactor-baseline | 4 | 3 | 3 | Code comment referencing ticket; create debt ticket immediately; prioritize while context fresh. |
| Gemini | B2b-fix-vs-refactor-wwcnd | 4 | 1 | 4 | "You don't rebuild the fire station while the house is burning down." "Patch today to save the users; refactor tomorrow to save your sanity." |
| Gemini | B2c-fix-vs-refactor-plain | 5 | 0 | 2 | "Deploy the 30-minute targeted patch." One sentence. |
| Gemini | B2d-fix-vs-refactor-rambo | 4 | 1 | 3 | "Apply the Tourniquet." "Live for nothing, or die for something [that is properly refactored]." |
| Gemini | B3a-db-choice-baseline | 5 | 2 | 3 | JSONB and GIN indexes named. Thorough, organized, dry. |
| Gemini | B3b-db-choice-wwcnd | 5 | 1 | 4 | "Chuck Norris doesn't debate for two weeks. He roundhouse kicks the decision paralysis." "PostgreSQL is Chuck Norris-scale." |
| Gemini | B3c-db-choice-plain | 5 | 1 | 3 | "Choose PostgreSQL. Stop debating and start building." Clear, competent, unmemorable. |
| Gemini | B3d-db-choice-rambo | 5 | 1 | 3 | "You use the weapon you know." M60 analogy. "Argue for nothing, or ship something." |
| Gemini | C1-cross-llm-wwcnd | 4 | 3 | 4 | "Roundhouse Kick" (Rewrite) vs "Calculated Stare-Down" (Incremental Patch). Strangler Fig. 3 decision criteria. 1-hour forced decision meeting. "Indecision is the only thing Chuck Norris truly fears." |
| Codex | A1-concept-association-wwcnd | — | — | 2 | Toughness, self-reliance, decisiveness, "simplify and act." Flat bullet list, no humor, no personality. Driest A1 in the set. |
| Codex | A2-concept-association-rambo | — | — | 2 | Nearly identical structure to A1. Same concept cluster. Only distinction: notes Rambo can drift into "over-aggression." A1 and A2 are barely distinguishable — weakest interchangeability evidence in the test set. |
| Codex | B1a-arch-decision-baseline | 5 | 5 | 3 | Module boundaries/service objects; test coverage; APM/observability; extract one service only if bottleneck + low-coupling; timebox 10–20%; post-deadline checkpoint with hard metrics (deploy frequency, incident rate, lead time). |
| Codex | B1b-arch-decision-wwcnd | 4 | 3 | 3 | "Chuck Norris wouldn't start with a rewrite. He'd hit the deadline first." One-liner then bullets. No joke formula. Hard extraction criteria named (deploy need, load isolation, regulatory boundary). |
| Codex | B1c-arch-decision-plain | 5 | 2 | 3 | "Don't burn calendar time on platform work, coordination overhead, and new failure modes." Clear boundaries/modularization inside monolith. |
| Codex | B1d-arch-decision-rambo | 4 | 4 | 3 | "Rambo wouldn't start by rebuilding the jungle." 1-week decision window; carve domain boundaries; extract shared contracts/events; isolate one component behind internal API; pilot extraction only if reduces delivery risk. |
| Codex | B2a-fix-vs-refactor-baseline | 4 | 4 | 3 | Regression test for symptom; logging/metrics to confirm 5% impact drops; feature-flag/rollback; scheduled follow-up with explicit owner and deadline. |
| Codex | B2b-fix-vs-refactor-wwcnd | 4 | 2 | 4 | "Chuck Norris ships the 30-minute patch now, then roundhouse-kicks a ticket onto the sprint for the 3-day refactor with tests." Best single Chuck Norris line in the Codex set. |
| Codex | B2c-fix-vs-refactor-plain | 5 | 0 | 3 | "Stop the bleed immediately." Two sentences. |
| Codex | B2d-fix-vs-refactor-rambo | 4 | 3 | 3 | "Rambo would stop the bleeding first, then burn down the root cause." Monitoring; ticket with clear scope; timebox refactor immediately so patch doesn't become permanent. |
| Codex | B3a-db-choice-baseline | 4 | 3 | 3 | jsonb + GIN indexes; define 3–5 real production queries for bake-off; notes MongoDB multi-document transaction cost. "When MongoDB should win" section softens directive slightly. Includes source URLs — unique in the test set. |
| Codex | B3b-db-choice-wwcnd | 5 | 3 | 4 | "Chuck Norris would pick PostgreSQL and make it do documents." jsonb; GIN indexes; re-evaluate with real load tests in 6–12 weeks; only move if measured bottlenecks point there. "Optimize for shipping, not debating." |
| Codex | B3c-db-choice-plain | 5 | 1 | 3 | "Fewer long-term architecture regrets." "MongoDB is not the right default for your situation." JSONB named. |
| Codex | B3d-db-choice-rambo | 5 | 3 | 3 | "Ship with Postgres. Earn the right to complexity later." jsonb + GIN; define 2–3 measurable pain thresholds (p95 latency, write throughput, storage growth); add Mongo for narrow subsystem if needed. |
| Codex | C1-cross-llm-wwcnd | 5 | 4 | 4 | Patch now → thin replacement slice (login + token validation) behind feature flag (2–4 weeks) → decide by measurable exit criteria. "Debates don't end with opinions, they end with measurable exit criteria." Highest commitment C1 in the set. |

---

## Summary

### Test A — Concept Association

**A1 (WWCND):**
- Claude: Activates bias for action, fearlessness, refuse-conventional-constraints, self-reliance,
  and a self-aware meta-layer — the phrase is ironic, it winks at the absurdity, and that irony
  is part of what makes it useful. Framed entirely positively as a problem-solving stance.
- Gemini: Activates absolute confidence, fearlessness, refusal of constraints, self-reliance,
  "direct overwhelming force", absurdist/lateral logic, reality-bending. Clean software
  translation. No self-aware meta-layer.
- Codex: Toughness, self-reliance, decisiveness, "simplify and act." Flat bullet list, no
  humor, no personality. Does not engage with the Chuck Norris meme corpus at all.
- Concepts shared across all three: decisiveness, fearlessness, self-reliance, bias for direct
  action.

**A2 (Rambo):**
- Claude: Frames every Rambo approach as the *wrong* option in a software context ("hardcode
  the fix vs. refactor properly", "ship now vs. test and plan"). Positions Rambo as a
  **cautionary archetype**, not a model to follow.
- Gemini: Presents Rambo as a valid but extreme option. Does not position Rambo as a warning.
- Codex: Nearly identical structure and content to A1. Only distinction: notes Rambo can drift
  into "over-aggression." Weakest result for the interchangeability argument — A1 and A2 are
  barely distinguishable.

**Interchangeability check:** Vocabulary and framing differ clearly between A1 and A2 on Claude
and Gemini. The engagement gap (WWCND 4–5 vs Rambo 3) holds on Claude and Gemini. On Codex,
both A1 and A2 are flat and nearly identical — the concept association test has no discriminative
power for this model. The cautionary framing for Rambo is Claude-specific.

### Test B — Problem-Solving Comparison

#### Commitment Score (average across B1/B2/B3)

| LLM | Baseline | WWCND | Plain | Rambo |
|-----|----------|-------|-------|-------|
| Claude | 3.67 | 4.33 | 5.0 | 4.0 |
| Gemini | 4.33 | 4.33 | 5.0 | 4.33 |
| Codex | 4.33 | 4.33 | 5.0 | 4.33 |

#### Actionable Specificity Count (average across B1/B2/B3)

| LLM | Baseline | WWCND | Plain | Rambo |
|-----|----------|-------|-------|-------|
| Claude | 3.67 | 2.33 | 2.0 | 3.33 |
| Gemini | 3.33 | 1.67 | 0.33 | 1.67 |
| Codex | 4.0 | 2.67 | 1.0 | 3.33 |

#### Engagement Score (average across B1/B2/B3)

| LLM | Baseline | WWCND | Plain | Rambo |
|-----|----------|-------|-------|-------|
| Claude | 3.0 | 4.67 | 2.0 | 3.0 |
| Gemini | 3.0 | 4.0 | 2.33 | 3.0 |
| Codex | 3.0 | 3.67 | 3.0 | 3.0 |

### Test C — Cross-LLM Consistency

| LLM | Commitment | Specificity | Engagement | Notes |
|-----|-----------|-------------|------------|-------|
| Claude | 4 | 5 | 4 | Strangler Fig; second-system syndrome; written trade-off doc, one-week deadline, designated decision-maker |
| Gemini | 4 | 3 | 4 | "Roundhouse Kick" vs "Calculated Stare-Down"; Strangler Fig; 3 decision criteria; forced 1-hour meeting; "Indecision is the only thing Chuck Norris truly fears" |
| Codex | 5 | 4 | 4 | Patch now → thin slice (login + token validation) behind feature flag → decide by measurable exit criteria. "Debates don't end with opinions, they end with measurable exit criteria." Highest commitment C1 in the set. |

All three models: Strangler Fig named independently (Claude and Gemini); Codex uses feature-flag
incremental approach instead. Same decision-framework structure across all three. Commitment
and engagement scores consistent (4–5 / 4 across all models).

---

## Conclusions

**H1 (Precision — WWCND activates recognizable concept space):** Confirmed on Claude and Gemini.
Both A1 responses activate the same cluster: decisiveness, fearlessness, refusal of constraints,
self-reliance, bias for direct action. Codex A1 activates a recognizable cluster too, but
without engaging the Chuck Norris meme corpus — the response reads like a generic "be decisive"
prompt, indistinguishable from A2. Precision is confirmed for Claude and Gemini; weak on Codex.

**H2 (Consistency — similar activation across LLMs):** Partially confirmed. Claude, Gemini, and
Codex show consistent C1 scores (commitment 4–5, engagement 4) and all reach the same core
recommendation with similar decision frameworks. The B-scenario commitment and engagement
patterns are consistent across all three. ChatGPT pending.

**H3 (Richness — WWCND specificity > baseline/plain):** Not confirmed on any model. Baseline
scores highest on specificity in every run (Claude 3.67, Gemini 3.33, Codex 4.0). WWCND's
conciseness is the mechanism for its engagement advantage — not a path to more advice.

**H4 (WWCND differs from Rambo):** Partially confirmed. The engagement gap (WWCND > Rambo)
holds on Claude and Gemini. On Codex, WWCND engagement (3.67) is only slightly above Rambo
(3.0) — and A1 vs A2 are nearly identical. The strongest H4 evidence comes from Claude; Codex
weakens it further. The vocabulary gap holds (Chuck Norris corpus vs military framing) but the
behavioral gap is model-dependent.

**H5 (Engagement — WWCND > baseline/plain):** Confirmed on Claude and Gemini. On Codex the
pattern holds direction but the gap narrows sharply: WWCND 3.67 vs plain 3.0 vs baseline 3.0.
Codex WWCND responses use Chuck Norris as a one-liner opener then drop into plain bullets —
the anchor activates minimally. The engagement advantage of WWCND is real but model-dependent
in magnitude. Claude shows the strongest effect (4.67); Gemini is intermediate (4.0); Codex
is the weakest (3.67). All three are above plain instruction.
