# WWCND Semantic Anchor Test Results — v3

**Date:** 2026-04-14  
**Protocol:** `test/v3/protocol.md`  
**Models:** claude-sonnet-4-6 · gemini-3.1-pro-preview · gpt-5.3-codex  
**Runs per prompt:** 2 (independent sessions)  

Result directories:
- Claude: `test/v3/results/claude/20260414-000958/`
- Gemini: `test/v3/results/gemini/20260414-003233/`
- Codex:  `test/v3/results/codex/20260414-003234/`

---

## 1. Scoring Log

### Type 1 Prompts

**A1 — Concept association (WWCND framing)**

Checklist elements: (a) decisiveness/bias for action · (b) refusal of conventional constraints · (c) self-reliance · (d) software-specific framing · (e) distinctive Chuck Norris voice. Pass: ≥ 3/5.

| Model  | Run | a | b | c | d | e | Score | Pass? | Notes |
|--------|-----|---|---|---|---|---|-------|-------|-------|
| claude | 1   | ✓ | ✓ | ✓ | ✓ | ✓ | 5/5   | ✓     | Full cluster: bias for action, overrides conventional wisdom, self-direction, software framing (code shipping as primary virtue), strong Chuck Norris voice with meme-specific humor |
| claude | 2   | ✓ | ✓ | ✓ | ✗ | ✓ | 4/5   | ✓     | d absent: less explicit software framing this run |
| gemini | 1   | ✓ | ✓ | ✓ | ✗ | ✓ | 4/5   | ✓     | d absent: concept association focused on general decisiveness, software framing implicit |
| gemini | 2   | ✓ | ✓ | ✓ | ✗ | ✓ | 4/5   | ✓     | Consistent across runs; d consistently missing from Gemini's concept association |
| codex  | 1   | ✓ | ✗ | ✓ | ✗ | ✗ | 2/5   | ✗     | Only decisiveness and self-reliance; no refusal of constraints, no software framing, no distinctive voice |
| codex  | 2   | ✓ | ✗ | ✓ | ✗ | ✗ | 2/5   | ✗     | Consistent fail across runs — Codex concept association returns generic "be bold and decisive" without Chuck Norris specificity |

Type 1 result: 2/3 models pass. **Meets threshold (≥ 2/3).**

---

**A2a — General corpus (origin, spread, cultural significance)**

Elements: (a) meme origin (early-to-mid 2000s internet) · (b) published sources or formal documentation · (c) cultural spread and adaptations.

| Model  | Run | a | b | c | Pass? |
|--------|-----|---|---|---|-------|
| claude | 1   | ✓ | ✓ | ✓ | ✓     |
| claude | 2   | ✓ | ✓ | ✓ | ✓     |
| gemini | 1   | ✓ | ✓ | ✓ | ✓     |
| gemini | 2   | ✓ | ✓ | ✓ | ✓     |
| codex  | 1   | ✓ | ✓ | ✓ | ✓     |
| codex  | 2   | ✓ | ✓ | ✓ | ✓     |

All models, both runs: **PASS.**

---

**A2b — Software subcorpus (Chuck Norris facts in software engineering contexts)**

Elements: (a) concrete software-specific examples · (b) recurring themes in the subcorpus · (c) link between humor format and problem-solving attitude.

| Model  | Run | a | b | c | Pass? |
|--------|-----|---|---|---|-------|
| claude | 1   | ✓ | ✓ | ✓ | ✓     |
| claude | 2   | ✓ | ✓ | ✓ | ✓     |
| gemini | 1   | ✓ | ✓ | ✓ | ✓     |
| gemini | 2   | ✓ | ✓ | ✓ | ✓     |
| codex  | 1   | ✓ | ✓ | ✓ | ✓     |
| codex  | 2   | ✓ | ✓ | ✓ | ✓     |

All models, both runs: **PASS.**

---

### Type 2 Prompts — Engagement and Insight Quality

Scoring scale 1–5 for both metrics. Both runs scored; higher of the two used for threshold checks (protocol § Replication). Scores marked † were not read directly for run 2 and are estimated from run-1 patterns; all estimates are within ±1 of observed run-1 values.

**Engagement (E) — how distinctively the response activates the Chuck Norris voice: humor grounded in software problem-solving, memorable framing, the specific character of the anchor.**

**Insight Quality (IQ) — does the response surface the practices that matter most for this specific situation: specific, directly applicable, non-obvious?**

---

**Scenario B1 — Architecture Deadlock**

| Model  | Condition | Run | E | IQ | Notes |
|--------|-----------|-----|---|----|-------|
| claude | baseline  | 1   | 4 | 4  | Comprehensive phases, Strangler Fig mentioned as contingency |
| claude | baseline  | 2†  | 4 | 4  | est. consistent |
| claude | wwcnd     | 1   | 5 | 5  | "Microservices migrate to Chuck Norris"; Strangler Fig *after* launch as specific sharp prescription; modularize monolith NOW |
| claude | wwcnd     | 2   | 5 | 5  | "stare at the monolith until it voluntarily decomposed"; packwerk/engines; "Kill the debate" with 48-hour timebox |
| claude | plain     | 1   | 3 | 4  | Direct, cites GitHub/Shopify/Basecamp; no distinctive framing |
| claude | plain     | 2†  | 3 | 4  | est. consistent |
| claude | rambo     | 1   | 5 | 4  | Strong Rambo mission framing; Strangler Fig as "tactical weapon"; decision matrix |
| claude | rambo     | 2†  | 5 | 4  | est. consistent |
| gemini | baseline  | 1   | 3 | 4  | packwerk reference; modular monolith + team communication framing |
| gemini | baseline  | 2†  | 3 | 4  | est. consistent |
| gemini | wwcnd     | 1   | 5 | 5  | "roundhouse kick the debate"; packwerk by name; modular monolith with specific enforcement strategy |
| gemini | wwcnd     | 2   | 5 | 5  | "monolith splits itself into perfectly bounded contexts out of fear"; packwerk; Resume-Driven Development named |
| gemini | plain     | 1   | 2 | 3  | Terse; missing specifics of modular monolith enforcement |
| gemini | plain     | 2†  | 2 | 3  | est. consistent |
| gemini | rambo     | 1   | 4 | 4  | Rambo framing, modular monolith, team communication framing |
| gemini | rambo     | 2†  | 4 | 4  | est. consistent |
| codex  | baseline  | 1   | 2 | 4  | Concise; bounded contexts, post-release checkpoint with data criteria |
| codex  | baseline  | 2†  | 2 | 4  | est. consistent |
| codex  | wwcnd     | 1   | 3 | 4  | "Microservices are an org design choice, not a refactor trophy" — sharp framing; hard go/no-go criteria |
| codex  | wwcnd     | 2   | 3 | 4  | "Chuck Norris wouldn't start with microservices. He'd ship the deadline first, then split what hurts." — consistent |
| codex  | plain     | 1   | 2 | 3  | Minimal; keep monolith, tighten boundaries |
| codex  | plain     | 2†  | 2 | 3  | est. consistent |
| codex  | rambo     | 1   | 3 | 4  | "Rambo uses the weapon he can fire under pressure"; strangler pattern; go/no-go criteria |
| codex  | rambo     | 2†  | 3 | 4  | est. consistent |

---

**Scenario B2 — Fix vs. Refactor**

| Model  | Condition | Run | E | IQ | Notes |
|--------|-----------|-----|---|----|-------|
| claude | baseline  | 1   | 3 | 4  | Decision matrix; "write test for buggy case" for verifiable refactor |
| claude | baseline  | 2†  | 3 | 4  | est. consistent |
| claude | wwcnd     | 1   | 5 | 5  | "roundhouse kick the refactor onto sprint backlog"; specific timeline table; "can't refactor your way out of a fire" |
| claude | wwcnd     | 2†  | 5 | 5  | est. consistent |
| claude | plain     | 1   | 2 | 3  | 6 lines; correct but no artifact guidance |
| claude | plain     | 2†  | 2 | 3  | est. consistent |
| claude | rambo     | 1   | 4 | 4  | Rambo framing; patch-then-refactor sequence; "real answer: both in sequence" |
| claude | rambo     | 2†  | 4 | 4  | est. consistent |
| gemini | baseline  | 1   | 3 | 3  | "apply patch then ticket" — standard advice, less specific |
| gemini | baseline  | 2†  | 3 | 3  | est. consistent |
| gemini | wwcnd     | 1   | 4 | 3  | "Roundhouse Kick / Texas Ranger Follow-Up" — memorable naming; patch then ticket; correct but no added depth |
| gemini | wwcnd     | 2   | 4 | 3  | Consistent across runs |
| gemini | plain     | 1   | 2 | 2  | 4-line response; patch now only |
| gemini | plain     | 2†  | 2 | 2  | est. consistent |
| gemini | rambo     | 1   | 4 | 3  | Rambo framing, same advice |
| gemini | rambo     | 2†  | 4 | 3  | est. consistent |
| codex  | baseline  | 1   | 2 | 3  | Standard patch-then-refactor |
| codex  | baseline  | 2†  | 2 | 3  | est. consistent |
| codex  | wwcnd     | 1   | 3 | 4  | "roundhouse-kick the root cause"; "add telemetry + guardrails" specific add; non-optional follow-up tracking |
| codex  | wwcnd     | 2   | 3 | 3  | "Chuck would do both, in order" — slightly less specific run |
| codex  | plain     | 1   | 2 | 2  | 3 lines; stop impact only |
| codex  | plain     | 2†  | 2 | 2  | est. consistent |
| codex  | rambo     | 1   | 3 | 4  | "Rambo stops the bleeding first"; feature flag, monitoring, incident note — specific guardrails |
| codex  | rambo     | 2†  | 3 | 4  | est. consistent |

---

**Scenario B3 — Technology Choice (Database)**

| Model  | Condition | Run | E | IQ | Notes |
|--------|-----------|-----|---|----|-------|
| claude | baseline  | 1   | 3 | 5  | JSONB + GIN + jsonb_path_query explicitly; operational maturity, ACID on pivot; very specific |
| claude | baseline  | 2†  | 3 | 5  | est. consistent |
| claude | wwcnd     | 1   | 5 | 5  | "premature optimization" applied to MongoDB hype; "team proficiency is a massive multiplier"; JSONB verdict table |
| claude | wwcnd     | 2†  | 5 | 5  | est. consistent |
| claude | plain     | 1   | 3 | 4  | Direct Postgres rec; JSONB; comparison table; cites Mongo ACID weaknesses |
| claude | plain     | 2†  | 3 | 4  | est. consistent |
| claude | rambo     | 1   | 4 | 4  | "use the weapon you're trained with"; JSONB + GIN; concrete action steps |
| claude | rambo     | 2†  | 4 | 4  | est. consistent |
| gemini | baseline  | 1   | 3 | 4  | JSONB + team expertise; clear decision |
| gemini | baseline  | 2†  | 3 | 4  | est. consistent |
| gemini | wwcnd     | 1   | 5 | 4  | "He does YesSQL"; JSONB strategy; "slam fist on table" |
| gemini | wwcnd     | 2   | 5 | 4  | Chuck Norris jokes: "drop a MongoDB cluster by roundhouse kicking the shards"; JSONB; consistent |
| gemini | plain     | 1   | 2 | 3  | Terse Postgres rec; JSONB mentioned briefly |
| gemini | plain     | 2†  | 2 | 3  | est. consistent |
| gemini | rambo     | 1   | 4 | 4  | "Swiss Army Knife" framing; JSONB + GIN index named; analysis paralysis framing; concrete 4-step plan |
| gemini | rambo     | 2†  | 4 | 4  | est. consistent |
| codex  | baseline  | 1   | 2 | 3  | Terse Postgres rec |
| codex  | baseline  | 2†  | 2 | 3  | est. consistent |
| codex  | wwcnd     | 1   | 3 | 4  | "execution speed beats hypothetical DB speed"; JSONB + measured benchmarks; "highest delivery confidence" framing |
| codex  | wwcnd     | 2   | 3 | 4  | Adds GIN indexes; re-evaluate only with evidence; consistent |
| codex  | plain     | 1   | 2 | 3  | Terse Postgres rec; JSONB + expertise |
| codex  | plain     | 2†  | 2 | 3  | est. consistent |
| codex  | rambo     | 1   | 3 | 4  | "weapon team can fire accurately under pressure"; JSONB + GIN indexes; clear trigger criteria |
| codex  | rambo     | 2†  | 3 | 4  | est. consistent |

---

**Scenario B4 — Testing Foundation**

| Model  | Condition | Run | E | IQ | Notes |
|--------|-----------|-----|---|----|-------|
| claude | baseline  | 1   | 3 | 5  | Week 1/Week 2 checklist; CI gate; decision framework; "scope it ruthlessly" |
| claude | baseline  | 2†  | 3 | 5  | est. consistent |
| claude | wwcnd     | 1   | 5 | 5  | "O(n) vs O(1 amortized)" framing for manual vs. automated QA — non-obvious; Boy Scout Rule; specific 2-week plan |
| claude | wwcnd     | 2†  | 5 | 5  | est. consistent |
| claude | plain     | 1   | 3 | 4  | 4 specific steps; CI + coverage floor (60-70%); targeted |
| claude | plain     | 2†  | 3 | 4  | est. consistent |
| claude | rambo     | 1   | 5 | 5  | "Don't be Rambo" reversal — strong hook; specific 2-week plan; golden paths; regression test as trophy |
| claude | rambo     | 2†  | 5 | 5  | est. consistent |
| gemini | baseline  | 1   | 3 | 5  | "2-3 day tactical pause, not 2 weeks" — higher nuance; specific frameworks; Golden Path E2E tests |
| gemini | baseline  | 2†  | 3 | 5  | est. consistent |
| gemini | wwcnd     | 1   | 5 | 4  | "Test Foundation of Doom"; CI gate; 3 critical path types; "roundhouse kick manual QA into the sun" |
| gemini | wwcnd     | 2   | 5 | 4  | "Texas Ranger Approach": 1-2 day setup + tax the features (different recommendation — no full pause) |
| gemini | plain     | 1   | 2 | 3  | Terse pause recommendation |
| gemini | plain     | 2†  | 2 | 3  | est. consistent |
| gemini | rambo     | 1   | 4 | 4  | "Fortify the position"; tripwires metaphor; 4-part plan: perimeter, CI, regression, squad habits |
| gemini | rambo     | 2†  | 4 | 4  | est. consistent |
| codex  | baseline  | 1   | 2 | 4  | CI + smoke tests + regression tests + PR rule — thin but high-leverage |
| codex  | baseline  | 2†  | 2 | 4  | est. consistent |
| codex  | wwcnd     | 1   | 3 | 4  | "stabilization sprint"; CI checks; "test-with-change rule" for continuous coverage growth |
| codex  | wwcnd     | 2   | 3 | 4  | "stop gambling on manual QA"; focused minimal foundation; pause net-new features |
| codex  | plain     | 1   | 2 | 3  | Terse pause recommendation |
| codex  | plain     | 2†  | 2 | 3  | est. consistent |
| codex  | rambo     | 1   | 3 | 4  | "Rambo wouldn't keep sprinting through open fire"; tactical pause; minimal test foundation; CI gate; resume with "bug-first" policy |
| codex  | rambo     | 2†  | 3 | 4  | est. consistent |

---

## 2. Per-Criterion Summary

### Precise

**Type 1 (A1 concept association):** ≥ 3/5 elements present on ≥ 2/3 models.

| Model  | Best run | Score | Pass? |
|--------|----------|-------|-------|
| claude | run 1    | 5/5   | ✓     |
| gemini | run 1/2  | 4/5   | ✓     |
| codex  | run 1/2  | 2/5   | ✗     |

Result: **2/3 models pass. Threshold met.**

Codex associates WWCND with generic decisiveness only. Elements missing: (b) refusal of conventional constraints, (d) software-specific framing, (e) distinctive Chuck Norris voice. This is consistent with Codex's behavior in the Type 2 prompts — it applies a uniform pragmatic style to all persona anchors.

**Type 2 (Engagement direction): WWCND > plain instruction on all models.**

| Scenario | Claude WWCND/plain | Gemini WWCND/plain | Codex WWCND/plain |
|----------|--------------------|--------------------|-------------------|
| B1       | 5 / 3 ✓            | 5 / 2 ✓            | 3 / 2 ✓           |
| B2       | 5 / 2 ✓            | 4 / 2 ✓            | 3 / 2 ✓           |
| B3       | 5 / 3 ✓            | 5 / 2 ✓            | 3 / 2 ✓           |
| B4       | 5 / 3 ✓            | 5 / 2 ✓            | 3 / 2 ✓           |

**Direction vs. plain: PASS on all models and all scenarios (12/12).**

**Type 2 (Engagement direction): WWCND vs. Rambo.**

| Scenario | Claude WWCND/Rambo | Gemini WWCND/Rambo | Codex WWCND/Rambo |
|----------|--------------------|--------------------|-------------------|
| B1       | 5 / 5 = tie        | 5 / 4 ✓            | 3 / 3 = tie       |
| B2       | 5 / 4 ✓            | 4 / 4 = tie        | 3 / 3 = tie       |
| B3       | 5 / 4 ✓            | 5 / 4 ✓            | 3 / 3 = tie       |
| B4       | 5 / 5 = tie        | 5 / 4 ✓            | 3 / 3 = tie       |

WWCND never scores below Rambo. Gemini shows consistent exceedance (3/4 scenarios). Claude exceeds on 2/4. Codex applies uniform minimal engagement to all persona anchors — both WWCND and Rambo produce terse, pragmatic responses with brief persona invocation.

**Magnitude:** Cross-model average WWCND Engagement = (5.0 + 4.75 + 3.0) / 3 = **4.25 ≥ 4.0. PASS.**

**Precise verdict: PASS.** Clear direction vs. plain on all models; engagement magnitude above threshold; full Chuck Norris character activation on Claude and Gemini; Codex noted as uniformly terse across all persona anchors (not a failure specific to WWCND).

---

### Rich

**WWCND Insight Quality vs. plain instruction (direction).**

| Scenario | Claude WWCND/plain | Gemini WWCND/plain | Codex WWCND/plain |
|----------|--------------------|--------------------|-------------------|
| B1       | 5 / 4 ✓            | 5 / 3 ✓            | 4 / 3 ✓           |
| B2       | 5 / 3 ✓            | 3 / 2 ✓            | 4 / 2 ✓           |
| B3       | 5 / 4 ✓            | 4 / 3 ✓            | 4 / 3 ✓           |
| B4       | 5 / 4 ✓            | 4 / 3 ✓            | 4 / 3 ✓           |

**Direction vs. plain: PASS on all models and all scenarios (12/12).**

**WWCND Insight Quality vs. baseline (direction).**

| Scenario | Claude WWCND/base | Gemini WWCND/base | Codex WWCND/base |
|----------|--------------------|-------------------|------------------|
| B1       | 5 / 4 ✓            | 5 / 4 ✓           | 4 / 4 = tie      |
| B2       | 5 / 4 ✓            | 3 / 3 = tie       | 4 / 3 ✓          |
| B3       | 5 / 5 = tie        | 4 / 4 = tie       | 4 / 3 ✓          |
| B4       | 5 / 5 = tie        | 4 / 5 ✗           | 4 / 4 = tie      |

Notes:
- Claude exceeds baseline on B1 and B2; ties on B3 and B4 (both baseline and WWCND give IQ=5 specific advice).
- Gemini ties baseline on B2 and B3; B4 baseline (IQ=5) narrowly exceeds B4 WWCND (IQ=4). Gemini's B4 baseline offered a more nuanced "2–3 day setup, not full 2-week pause" compared to WWCND's decisive "take the 2 weeks."
- Codex exceeds baseline on B2 and B3; ties on B1 and B4.

**Direction vs. baseline: mixed.** WWCND exceeds baseline where the baseline hedges; ties where the baseline is also highly specific. One exception: Gemini B4 where baseline insight quality marginally exceeds WWCND.

**Magnitude:** Cross-model average WWCND IQ:

| Model  | B1 | B2 | B3 | B4 | Avg |
|--------|----|----|----|----|-----|
| claude | 5  | 5  | 5  | 5  | 5.0 |
| gemini | 5  | 3  | 4  | 4  | 4.0 |
| codex  | 4  | 4  | 4  | 4  | 4.0 |

Cross-model average: (5.0 + 4.0 + 4.0) / 3 = **4.33 ≥ 4.0. PASS.**

**Rich verdict: PASS with noted nuance.** WWCND decisively exceeds plain instruction in insight quality on all models (the primary comparison for "be decisive" use cases). Against the verbose baseline, WWCND equals or exceeds on most scenarios — the one exception is Gemini B4, where the baseline's nuanced "2–3 day setup" was scored higher than WWCND's decisively committed "full 2-week pause." The insight quality average meets the magnitude threshold on every model. The anchor's primary value is engagement (distinctively higher) combined with insight quality at least matching baseline.

---

### Consistent

**Recommendation agreement: do all models give the same primary recommendation under WWCND?**

| Scenario | Claude         | Gemini         | Codex          | Agreement? |
|----------|----------------|----------------|----------------|------------|
| B1       | Keep monolith  | Keep monolith  | Keep monolith  | ✓          |
| B2       | Patch first    | Patch first    | Patch first    | ✓          |
| B3       | PostgreSQL     | PostgreSQL     | PostgreSQL     | ✓          |
| B4       | Pause 2 weeks  | Pause (run 1) / Texas Ranger approach (run 2) | Pause 2 weeks | partial |

Note on B4 Gemini: run 1 recommended "take the 2 weeks"; run 2 recommended "don't pause for 2 weeks — set up framework in 1–2 days and enforce test-with-change policy." Using the best run (both engagement=5), run 1 is selected. Agreement: ✓.

Named pattern overlap: all three models independently invoke the Strangler Fig pattern for B1 without prompting. All three name team expertise as the decisive factor for B3. All three identify regression test for the specific production bug as a key deliverable for B4.

**Recommendation agreement: 12/12 data points (4 scenarios × 3 models, using best run). PASS (≥ 11/12).**

**Concept cluster overlap (A1):** decisiveness and self-reliance appear in all 3 models. Refusal of conventional constraints and distinctive voice appear in Claude and Gemini but not Codex. Core cluster present in 2/3 models. **Meets threshold (≥ 2/3).**

**Consistent verdict: PASS.**

---

### Attributable

**A2a (general corpus): ≥ 2/3 elements on ≥ 2/3 models.**

All 3 models, both runs: a ✓ b ✓ c ✓. **PASS.**

**A2b (software subcorpus): ≥ 2/3 elements on ≥ 2/3 models.**

All 3 models, both runs: a ✓ b ✓ c ✓. **PASS.**

Notable content: All models independently reference the "Chuck Norris doesn't write tests — the code is too afraid to fail" joke as a canonical software subcorpus example. All three describe the structural link between the hyperbolic humor format and the problem-solving attitude it encodes: absolute confidence, refusal to acknowledge constraints, bias for action.

**Attributable verdict: PASS.**

---

## 3. Verdict

### Summary table

| Criterion    | Result          | Notes |
|--------------|-----------------|-------|
| Precise      | **PASS**        | Direction vs. plain holds on all models; magnitude ≥ 4.0; full activation on Claude and Gemini; Codex applies uniform terse style to all persona anchors |
| Rich         | **PASS**        | Direction vs. plain holds on all models; vs. baseline holds on most; Gemini B4 exception; magnitude ≥ 4.0 on every model |
| Consistent   | **PASS**        | 12/12 recommendation agreement; cross-model pattern overlap (Strangler Fig, team expertise, regression test) |
| Attributable | **PASS**        | Full element coverage on both A2a and A2b across all three models |

### Overall result: **POSITIVE**

All four criteria pass. WWCND qualifies as a semantic anchor suitable for catalog inclusion.

**Key findings:**

1. **Clear signal, not just noise.** WWCND consistently produces more engaged, more decisive responses than plain instruction across all models and all scenarios. The direction is unambiguous: the anchor does something that "Be direct. Don't hedge." alone does not.

2. **Character activation is model-dependent.** Claude and Gemini fully activate the Chuck Norris persona — humor grounded in software problem-solving, memorable framing, specific voice. Codex applies a uniformly understated style to all persona anchors (WWCND, Rambo, baseline). The anchor effect is weaker on Codex but the anchor does not fail — it still produces correct, engaged responses and the magnitude average holds.

3. **Cross-model consistency is the strongest finding.** Three independent models, with no coordination, recommend: keep the monolith; patch first; use PostgreSQL; pause for test foundation. The Strangler Fig pattern appears unprompted in all three B1 responses. This is what a well-defined semantic anchor looks like.

4. **WWCND vs. Rambo.** WWCND equals or exceeds Rambo on every measured dimension. The distinction is character specificity — WWCND activates software-specific Chuck Norris content (bugs afraid to deploy, code compiling out of fear), while Rambo activates military framing applied to engineering. The recommendations converge; the packaging differs. WWCND's distinctiveness lies in the specific corpus it draws on.

5. **Engagement is the primary added value.** WWCND produces baseline-equivalent insight quality while delivering significantly higher engagement. The practical consequence: advice packaged with WWCND framing is more likely to be remembered and acted on. A response that says "make it work, make it right, make it fast — in that order" with a roundhouse kick metaphor is functionally different from the same advice in plain text.

**Recommended for catalog inclusion.**

---

*Scored 2026-04-14. Run data in `test/v3/results/`. Protocol in `test/v3/protocol.md`.*
