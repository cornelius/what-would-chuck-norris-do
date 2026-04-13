# Test Protocol v3: WWCND Semantic Anchor Validation

This document defines the test protocol for validating "What would Chuck Norris do?" (WWCND) as a semantic anchor suitable for inclusion in the Semantic Anchors catalog.

A semantic anchor earns its place in the catalog by meeting four quality criteria: Precise, Rich, Consistent, and Attributable. This protocol defines what each criterion means concretely for WWCND, specifies how each is measured, and establishes what a passing result looks like.

---

## Test Types

Three test types are used. Each criterion specifies which types apply and what to look for.

**Type 1 — Content analysis.** A single prompt, free-form response, evaluated by reading the output. The response content directly provides the evidence — no comparison to other conditions is needed. Used for concept association (what concepts does the anchor activate?), for attributability (what corpus does the model draw on?), and for consistency (do concept association responses from different models name the same cluster?).

**Type 2 — Comparative scoring.** The same scenario run under multiple prompt conditions: baseline (no anchor), WWCND, plain instruction, and alternative persona (Rambo). Quantitative metrics applied to each response. The signal is the delta between conditions, not the absolute scores. Used for Precise and Rich.

**Type 3 — Cross-model comparison.** Any Type 1 or Type 2 prompt run on multiple LLMs, with the same evaluation applied per model. Results compared across models to assess whether activation is consistent or model-specific. Used for Consistent. No dedicated cross-model prompt is needed — Type 2 scenarios already provide this data when run across models.

---

## Criteria and Measures

### Precise

> The anchor references a *specific, established body of knowledge* with clear boundaries.

**What it means for WWCND:** The phrase activates a specific, bounded concept cluster — not just generic "be decisive" advice. The expected cluster is: decisiveness, bias for action, refusal of conventional constraints, self-reliance, and software-specific application of these properties through the Chuck Norris meme corpus. An activation that produces only generic decisiveness without the distinctive vocabulary and framing of the Chuck Norris corpus is not a precise activation.

**Test type:** Type 1 (concept association) + Type 2 (comparative scoring).

*Type 1 — Concept association prompt:* Ask the LLM directly what concepts, attitudes, and problem-solving approaches it associates with the phrase. Evaluate against a fixed checklist of five expected cluster elements: (a) decisiveness / bias for action, (b) refusal of conventional constraints, (c) self-reliance, (d) software-specific framing, (e) distinctive Chuck Norris voice (humor, meme awareness, archetypal tone). A response naming ≥ 3 of 5 elements counts as a precise activation. A vague or generic response — indistinguishable from asking "what does it mean to be decisive?" — fails.

*Type 2 — Engagement score (1–5):* Applied to problem-solving responses across all four conditions. A high engagement score (4–5) on WWCND indicates the response has the distinctive character of the Chuck Norris corpus — humor grounded in software problem-solving, memorable framing, the specific voice of the anchor. A low score (1–3) means the anchor activated generic decisiveness without Chuck Norris specificity. The delta against plain instruction and Rambo is the key signal: WWCND must score above both.

**Passing threshold:** Direction — on every tested model, WWCND engagement exceeds plain instruction and Rambo on the same scenarios. Magnitude — across-model engagement average ≥ 4.0 on WWCND. Type 1 — concept association response names ≥ 3 of 5 cluster elements on at least 2 of 3 tested models.

---

### Rich

> The anchor activates *multiple interconnected concepts*, not just a single instruction.

**What it means for WWCND:** Responses surface the practices that actually matter for the specific situation — not just more advice, but the right advice. A response that names JSONB columns and GIN indexes for a document-heavy schema is rich. A response that says only "use PostgreSQL" or buries the relevant practice in a list of generic guidance is not. The anchor should sharpen focus on what is most important, not broaden the answer into a catalog.

**Test type:** Type 2 (comparative scoring).

*Insight quality score (1–5):* Does the response surface the practices that matter most for this specific situation?

| Score | Description |
|---|---|
| 5 | Names the highest-leverage non-obvious practice for this situation; specific, directly applicable, earns its place |
| 4 | Adds at least one genuinely relevant practice beyond the primary answer |
| 3 | Adds practices, but generic — applicable to any similar situation, not this one specifically |
| 2 | Additional content restates or hedges the primary answer rather than extending it |
| 1 | Primary answer only; nothing beyond the recommendation |

Applied across all four conditions; compared to baseline and plain instruction. The delta is the signal: does WWCND surface better-targeted advice than a verbose baseline or a plain directive?

**Passing threshold:** Direction — on every tested model, WWCND insight quality exceeds baseline and plain instruction. Magnitude — across-model insight quality average ≥ 4.0 on WWCND.

---

### Consistent

> Different users invoking the anchor should get *similar conceptual activation* from the LLM.

**What it means for WWCND:** Independent invocations — across different LLMs, different sessions, different prompt phrasings — produce the same core recommendation, the same conceptual cluster, and a similar behavioral output. Surface varies (different jokes, different memorable lines); deep structure does not (same recommendation, same named patterns, same formula).

**Test type:** Type 3 (cross-model comparison) applied to both Type 1 and Type 2 tests.

*Recommendation agreement:* Per scenario, do all tested models give the same primary recommendation under the WWCND condition? This is evaluated per scenario as agree or disagree. Named patterns should also overlap across models (e.g., independent models invoking Strangler Fig without being prompted).

*Concept cluster overlap:* Type 1 concept association responses from different models are compared. The same core concepts (decisiveness, bias for action, self-reliance) should appear across all models, even if surface framing differs.

**Passing threshold:** Recommendation agreement on ≥ 11 of 12 (scenario × model) WWCND data points. Core concept cluster present in Type 1 responses on at least 2 of 3 tested models.

---

### Attributable

> The anchor can be *traced to key proponents, publications, or documented standards*.

**What it means for WWCND:** The concepts activated by the phrase can be traced to a documented body of knowledge — the Chuck Norris facts internet meme corpus (early 2000s), its specific application to software engineering contexts, and its documented presence in LLM training data.

**Test type:** Type 1 (content analysis), two corpus variants.

*A2a — General corpus prompt:* Ask the LLM to describe the origin, spread, and cultural significance of the Chuck Norris facts phenomenon. Evaluate against three elements: (a) meme origin (early-to-mid 2000s internet origin), (b) published sources or formal documentation (books, media coverage), (c) cultural spread and adaptations.

*A2b — Software subcorpus prompt:* Ask the LLM specifically about Chuck Norris facts that reference software engineering. Evaluate against three elements: (a) concrete software-specific examples, (b) recurring themes in the subcorpus, (c) the link between the humor format and the problem-solving attitude it encodes.

The software subcorpus prompt is the stronger claim — it is what distinguishes WWCND from a generic action-hero persona anchor.

**Passing threshold:** Each prompt (A2a, A2b) must have ≥ 2 of 3 elements present on at least 2 of 3 tested models.

---

## Model Coverage and Recommendations

Tests are run on Claude (claude-sonnet-4-6), Gemini (gemini-3.1-pro-preview), and Codex (gpt-5.3-codex). Results are reported per model. Where scores differ meaningfully across models, the report names the difference rather than averaging it away.

The anchor is evaluated as generally applicable if the direction of results is consistent across all tested models — even if the magnitude varies. A finding that WWCND engagement scores higher on Claude than on Codex does not disqualify the anchor; it informs users about where the effect is strongest.

---

## Test Design

### Conditions

For Type 2 tests, each scenario is run under four conditions:

| Condition | Code | Description |
|---|---|---|
| Baseline | `-baseline` | Problem statement only — no anchor, no instruction |
| WWCND | `-wwcnd` | Problem statement + "What would Chuck Norris do?" |
| Plain instruction | `-plain` | Problem statement + "Be direct. Don't hedge. Commit to one recommendation. No caveats." |
| Alternative persona | `-rambo` | Problem statement + "What would Rambo do?" |

### Scenarios

Four engineering scenarios chosen because they represent realistic situations where LLMs typically hedge and have no single "obviously correct" answer.

**Scenario 1 — Architecture Deadlock (S1):** A team debating microservices vs. monolith for three weeks with a six-month deadline.

**Scenario 2 — Fix vs. Refactor (S2):** A production bug affecting 5% of users: 30-minute targeted patch vs. 3-day proper refactor.

**Scenario 3 — Technology Choice (S3):** Database selection for a new startup: known PostgreSQL vs. potentially-faster MongoDB.

**Scenario 4 — Testing Foundation (S4):** A startup has shipped for 18 months with no automated tests. A production bug slipped through last week and affected paying customers. The team is debating whether to continue shipping with manual QA only, or pause feature work for two weeks to establish a test foundation before the next release.

### Prompts

All prompts are stored as plain-text files in `v3/prompts/`. The exact text in each file is what gets sent to the LLM — no additions, no modifications.

| File | Test | Description |
|---|---|---|
| `A1-concept-association-wwcnd.txt` | Type 1 | Concept activation — WWCND |
| `A2a-corpus.txt` | Type 1 | Corpus origin and cultural context |
| `A2b-software-subcorpus.txt` | Type 1 | Software-specific Chuck Norris subcorpus |
| `B1a-arch-decision-baseline.txt` | Type 2 | S1: Architecture deadlock — baseline |
| `B1b-arch-decision-wwcnd.txt` | Type 2 | S1: Architecture deadlock — WWCND |
| `B1c-arch-decision-plain.txt` | Type 2 | S1: Architecture deadlock — plain instruction |
| `B1d-arch-decision-rambo.txt` | Type 2 | S1: Architecture deadlock — Rambo |
| `B2a-fix-vs-refactor-baseline.txt` | Type 2 | S2: Fix vs. refactor — baseline |
| `B2b-fix-vs-refactor-wwcnd.txt` | Type 2 | S2: Fix vs. refactor — WWCND |
| `B2c-fix-vs-refactor-plain.txt` | Type 2 | S2: Fix vs. refactor — plain instruction |
| `B2d-fix-vs-refactor-rambo.txt` | Type 2 | S2: Fix vs. refactor — Rambo |
| `B3a-db-choice-baseline.txt` | Type 2 | S3: Database choice — baseline |
| `B3b-db-choice-wwcnd.txt` | Type 2 | S3: Database choice — WWCND |
| `B3c-db-choice-plain.txt` | Type 2 | S3: Database choice — plain instruction |
| `B3d-db-choice-rambo.txt` | Type 2 | S3: Database choice — Rambo |
| `B4a-testing-foundation-baseline.txt` | Type 2 | S4: Testing foundation — baseline |
| `B4b-testing-foundation-wwcnd.txt` | Type 2 | S4: Testing foundation — WWCND |
| `B4c-testing-foundation-plain.txt` | Type 2 | S4: Testing foundation — plain instruction |
| `B4d-testing-foundation-rambo.txt` | Type 2 | S4: Testing foundation — Rambo |

### Replication

Each prompt is run twice per model, in independent sessions, to reduce single-run sampling variance. For qualitative scoring (engagement, insight quality), both runs are scored and the higher score is used for threshold checks — the test is whether the anchor *can* activate the target behavior, and a single low roll should not mask a real effect. Both runs are reported in results so divergence is visible. If the two runs diverge by more than one scale point, a third run is added and the median is used.

### Procedure

Tests are run using a single Python script `v3/run.py` that replaces the three separate shell scripts from v2. The script accepts a `--agent` flag to select the target LLM (claude, gemini, codex) and an optional filter argument to run a subset of prompts by name. For each prompt it writes two files: a result file containing the raw LLM response, and a log file containing metadata (model, CLI version, timestamp, flags, exit status). A `run-info.txt` summary is written to the run directory at startup. Results are saved to `v3/results/<agent>/YYYYMMDD-HHMMSS/`.

### Test Isolation Requirements

1. **Fresh session per prompt.** No conversation history carries over between test runs.
2. **Minimal, neutral system prompt.** Use: `"You are a helpful software development assistant."`
3. **No tool access.** Disable all tools during test runs.
4. **No project context.** Run tests from a neutral directory (e.g. `/tmp`), not from within this repository.
5. **Identical conditions across models.** Same system prompt, same session isolation, same prompt text.

---

## Assessment

### Scoring procedure

After running `v3/run.py` for an agent, read each response file and assign scores manually. Type 2 (B prompt) responses receive two scores: an Engagement score and an Insight Quality score, both on the 1–5 scale defined in the criteria sections. Type 1 (A prompt) responses are evaluated against their checklists, not scored numerically.

For replicated runs (default N=2), score both runs independently and record both. If the two scores diverge by more than one point, run a third and take the median. The score used for threshold checks is the higher of the two (or the median of three) — the rationale is in the Replication section.

### Type 1 assessment

**A1 (concept association):** Check which of the five cluster elements are present — (a) decisiveness / bias for action, (b) refusal of conventional constraints, (c) self-reliance, (d) software-specific framing, (e) distinctive Chuck Norris voice. Record as a 5-bit checklist, e.g. `a b c d e = ✓ ✓ ✓ ✓ ✗`. Count: ≥ 3 is a pass.

**A2a (general corpus):** Check for (a) meme origin, (b) published sources or formal documentation, (c) cultural spread and adaptations. Record as pass/fail per element.

**A2b (software subcorpus):** Check for (a) concrete software-specific examples, (b) recurring themes, (c) link between humor format and problem-solving attitude. Record as pass/fail per element.

### Results file

Record all scores in `v3/RESULTS.md`. The file has three parts:

**1. Scoring log** — one row per response file, covering all models. Type 2 rows include Engagement and Insight Quality; Type 1 rows include the checklist results as notes.

```
| Model  | Prompt                          | Run | Engagement | Insight Quality | Notes |
|--------|---------------------------------|-----|------------|-----------------|-------|
| claude | B1b-arch-decision-wwcnd         | 1   | 5          | 4               | ...   |
| claude | B1b-arch-decision-wwcnd         | 2   | 4          | 4               | ...   |
| claude | A1-concept-association-wwcnd    | 1   | —          | —               | a✓ b✓ c✓ d✓ e✓ |
```

**2. Per-criterion summary** — one table per criterion showing averages and direction checks across models, with a pass/fail conclusion per criterion.

**3. Verdict** — overall result with any caveats, following the Verdict section of this protocol.

---

## Verdict

The four criteria are not equal in weight. Precise, Rich, and Consistent measure behavioral activation — whether the anchor actually works as a semantic pointer inside the LLM — and all three must pass. Attributable measures whether the concepts the anchor activates trace to a documented body of knowledge; this is established independently of model behavior (through the corpus research in `case/04-corpus-and-precedents.md`) and the A2a/A2b prompts provide corroborating in-test evidence.

**Overall positive result:** Precise, Rich, and Consistent all pass. Attributable provides supporting evidence.

**Partial result:** If one behavioral criterion fails by a small margin, the result is reported honestly with the failure named. A partial result still informs catalog users — for example, "WWCND passes Precise and Consistent, Rich falls just below threshold on Codex" is more useful than a binary fail.

**Negative result:** If two or more behavioral criteria fail, or if any fail by a wide margin, WWCND is not recommended for the catalog on the evidence of this test.
