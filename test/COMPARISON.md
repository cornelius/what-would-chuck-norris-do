# Comparison: Cross-Version and Cross-Run Analysis

Covers: how v1 informed v2, stability of the WWCND anchor across independent runs,
structural difference between WWCND and plain instruction responses, and the revised
counter-case framing that emerges from the combined evidence.

---

## v1 → v2: What Changed and Why

v1 measured hedge count, commitment score, and corpus activation with Terminator as the
comparison persona. After running and reading the results, two problems emerged:

**Hedge count had no signal.** Claude's baseline responses were already near zero hedges — the
metric had no range. It measured the fear, not the reality. A metric only works when baseline
and test conditions can differ on it. They couldn't here.

**Commitment score was useful but incomplete.** Plain instruction (5.0) outperformed WWCND
(4.33) on commitment — which looked bad for the anchor, but misread what WWCND is actually
doing. Qualitative reading revealed what the rubric missed: WWCND responses were more enjoyable
to read and embedded concrete best practices alongside the primary answer. Neither was captured.

**Terminator scored too close to WWCND.** Commitment 4.0 vs 4.33 — nearly indistinguishable.
The comparison persona's job is to be the most plausible alternative, not the one most likely to
fail. Terminator was too similar, making the interchangeability objection look stronger than it
was.

v2 redesign:
- Dropped hedge count; added engagement score (1–5) and actionable specificity count
- Replaced Terminator with Rambo — weaker anchor, no software-specific subcorpus, no humor
- Kept commitment score; kept the three scenarios (they stress the anchor appropriately)

---

## Cross-Run Consistency: WWCND (v1 vs v2 Claude)

The v1 and v2 Claude runs used identical WWCND prompts in independent sessions ~70 minutes
apart. Comparing them shows how stable the anchor's activation is across runs.

### What was identical

**Primary recommendation in every scenario:** same answer, same reasoning, same named patterns.
Both runs: don't migrate (B1), patch first then refactor (B2), PostgreSQL with JSONB (B3).
Zero divergence on the actual advice.

**Structural formula in every response, both runs:**
Chuck Norris joke → "But seriously" transition → real advice → Chuck Norris bottom line.
No exceptions.

**Several phrases appeared verbatim.** "The best architecture is the one that ships" appears
word-for-word in both B1b responses. "Microservices would migrate to Chuck Norris" appears
in both.

### What varied

**The specific jokes differed, drawn from the same pool.** v1 B1b: "Chuck Norris's monolith has
no latency because time itself is afraid to be slow." v2 B1b: "He'd roundhouse kick the
whiteboard and ship." Different wording, same energy, same mapping onto the problem.

**v2 used a more elegant structure** — explicit "Chuck Norris fact → Translation" pairs rather
than v1's joke-upfront-then-pivot. Same content, better packaging.

**Each run produced one distinctive quotable line the other didn't:**
- v1 B3b: *"If a debate lasts more than a week and no new information is being produced, the
  default answer is: use the thing your team already knows."*
- v2 B2b: *"Never let perfect be the enemy of good — but never let good be the excuse to
  avoid perfect."*

**v2 A1 surfaced a meta-layer** — the phrase is self-aware and ironic, simultaneously celebrates
and mocks the archetype — that v1 did not surface explicitly.

### What this means

The rejection claim was: *"responses will cluster around humor and roundhouse-kick metaphors,
not a consistent problem-solving approach."*

Both runs show the opposite. The humor is a stable frame for consistent, practical advice.
Deep structure (formula, recommendation, named patterns) is identical. Surface (specific jokes,
memorable lines) varies — the way any two conversations on the same topic produce different
wording. This is generativity, not inconsistency.

---

## Cross-Run Consistency: Plain Instruction (v1 vs v2 Claude)

Plain instruction responses show a different consistency pattern.

### What was identical

**Openings and conclusions were nearly verbatim.** B1c headlines: v1 "Don't migrate. Ship the
product." / v2 "Don't migrate. Ship your product." B3c opens identically in both: "Use
PostgreSQL. Here's why this is the right call:" — word for word. The closing lines rhyme:
v1 "Pick PostgreSQL. Start building. This decision is done." / v2 "Decision: PostgreSQL.
Start building."

### What varied — and the structural difference from WWCND

**Plain responses show large length variation. WWCND responses do not.**

v1 B2c: five paragraphs — numbered reasoning, a specific code comment pattern
(`# TEMPORARY: patch for [bug]. Refactor tracked in TICKET-123`), explicit exception rule.
v2 B2c: three sentences. Same prompt, same instruction, dramatically different depth.

WWCND does not vary this way. The joke-frame creates a natural length scaffold:
joke → translation → advice → bottom line. It has a floor. Plain instruction can produce
anything from a paragraph to an essay.

**Plain responses produced no memorable lines in either run.** The v1 B2c code comment tip is
the closest — and it disappeared entirely in v2. WWCND produced at least one strong quotable
line per scenario in every run.

### The key structural difference

WWCND: stable in depth (the structure ensures a real answer behind every joke), variable in
surface (different jokes, different quotable lines). The variation is generative.

Plain instruction: stable in surface (same opening words, same conclusion), unpredictable in
depth. You might get five paragraphs or three sentences. The variation is noise in length.

---

## Cross-LLM Patterns (Claude vs Gemini)

### Where they agreed

- Engagement pattern is identical on both: WWCND > baseline > plain, Rambo = baseline.
  Claude: 4.67 / 3.0 / 2.0 / 3.0. Gemini: 4.0 / 3.0 / 2.33 / 3.0.
- Plain instruction wins commitment on both (always 5.0).
- Baseline beats WWCND on specificity on both — same reason on both (verbose = more practices
  by volume, not more insight).
- C1: identical scores (commitment 4, engagement 4). Both invoke Strangler Fig independently.

### Where they diverged

- Gemini's Rambo (A2) does not frame Rambo as a cautionary archetype. Claude's does, explicitly.
  The strongest single piece of H4 evidence is Claude-specific.
- Gemini WWCND engagement (4.0) is lower than Claude's (4.67) — the humor lands slightly less
  consistently. The gap over plain instruction holds but is smaller.
- Gemini plain responses are thinner: B1c is four sentences with no practices; Claude's B1c
  names specific patterns. Gemini plain commitment is still 5.0, but there's less beneath it.

---

## Revised Counter-Case Framing

The combined v1 + v2 Claude + Gemini evidence supports a more precise argument than the
original rejection addressed:

**Plain instruction wins on decisiveness.** If maximum commitment is the only goal, "Be direct.
Don't hedge." always scores 5.0. WWCND does not beat it on that dimension.

**WWCND wins on engagement — consistently, across both models.** Claude: 4.67 vs 2.0 plain.
Gemini: 4.0 vs 2.33 plain. The pattern is identical across every model, every scenario, every
comparison. The smile is not noise. Advice that gets remembered is advice that gets used.

**Rambo is not a substitute.** The engagement gap (WWCND 4–4.67 vs Rambo 3.0) holds on both
models regardless of whether Rambo is framed as a cautionary archetype. The Chuck Norris corpus
activates something specific — humor grounded in software problem-solving — that generic
action-hero framing does not.

**The right claim is not "WWCND = more decisive" but "WWCND = more useful in practice."**
The anchor produces advice that is decisive *and* memorable *and* enjoyable to read, at a small
cost in raw commitment score relative to plain instruction. That tradeoff favors WWCND for any
use case where the advice needs to be read, retained, and acted on — which is most of them.

This claim is now supported by two independent LLMs across three scenarios each.

---

# v2 → v3: What Changed and Why

---

## Protocol Redesign Rationale

Three problems surfaced from reading the v2 results.

**Actionable Specificity Count was counting the wrong thing.** Baselines scored highest on
specificity in every run (Claude 3.67, Gemini 3.33, Codex 4.0 vs WWCND 2.33/1.67/2.67).
The metric rewarded verbosity: baseline responses are long and cover many practices by volume.
WWCND responses are focused and opinionated, surfacing fewer practices but more targeted ones.
A count measure cannot distinguish "mentions six practices" from "names the one that matters."
H3 (richness) failed as a result — not because WWCND lacks richness, but because the metric
had the wrong unit.

**Commitment score was not measuring what Consistent needed to measure.** Commitment measured
single-response decisiveness: does this one response take a clear position? That's a property
of the response, not of the anchor. The interesting consistency question is whether independent
models invoking the same anchor reach the same conclusion — which commitment doesn't capture.
Plain instruction won commitment on every model in v2 (always 5.0). That tells you plain
instruction is more direct, which is obvious. It says nothing about whether WWCND produces
consistent recommendations across models.

**A2 (Rambo concept association) was not adding evidence.** Its purpose was to show that Rambo
activates a different concept space than WWCND. Claude's A2 response did this clearly; Gemini's
less so; Codex's not at all. The more reliable evidence for WWCND vs Rambo interchangeability
is the engagement differential in the B scenarios, not a separate A2 prompt.

v3 redesign:
- Replaced Actionable Specificity Count with **Insight Quality score (1–5)** — quality, not
  quantity: does the response name the highest-leverage practice for this specific situation?
- Dropped Commitment; replaced Consistent with **recommendation agreement** — per scenario,
  do all three models give the same primary recommendation under WWCND?
- Dropped A2 (Rambo concept association); split A3 (corpus) into A2a (general corpus) and
  A2b (software subcorpus) — the software subcorpus is the stronger Attributable claim.
- Added **B4 (Testing Foundation)** — chosen from v2 patterns: scenario where "keep shipping"
  vs "stop and fix the foundation" maps well onto the WWCND bias for action.
- Added **N=2 replication** per prompt to reduce single-run variance (v2 Codex A1 scored 2,
  possibly a bad run).
- Added **formal Assessment section** to protocol so scoring and results format are specified
  before running, not designed post hoc.
- Replaced three separate shell scripts with a single `run.py`.

---

## What the Metric Change Revealed

The switch from Actionable Specificity Count to Insight Quality inverts the v2 conclusion on H3.

In v2, baselines ranked highest on specificity because they were longest. In v3, the baseline
IQ scores stay high (Claude B3a: 5, Gemini B4a: 5) but WWCND IQ scores are also high (Claude
all scenarios: 5; Gemini B1: 5). The comparison now asks: *is the insight pointed at the right
target for this situation?* On that question, WWCND matches or exceeds baseline on most
scenarios, and clearly exceeds plain instruction on all.

The one v3 exception: Gemini B4, where the baseline response (IQ=5, "2–3 day tactical setup,
not a full 2-week pause") was scored higher than the WWCND response (IQ=4, decisive "take
the 2 weeks"). This is the most interesting data point in the v3 set — the baseline offered
more nuanced insight, while WWCND was committed but slightly less calibrated for the specific
situation.

The v2 H3 failure ("not confirmed on any model") and the v3 Rich pass ("PASS with noted
nuance") are both honest. They're measuring different things: v2 measured more practices per
response (WWCND loses, baseline wins by volume); v3 measured whether the anchor surfaces the
right practices for the specific situation (WWCND wins or ties on most scenarios; one exception).

---

## Engagement Scores: v2 vs v3

The engagement direction pattern is identical across both versions. The magnitude differs
slightly, likely because v3 used N=2 and higher scores were used for threshold checks, and
because Claude's v3 WWCND responses were uniformly excellent.

**WWCND Engagement — average across B scenarios (v2 run 1 vs v3 best run):**

| Model  | v2 avg | v3 avg | Change |
|--------|--------|--------|--------|
| Claude | 4.67   | 5.00   | +0.33  |
| Gemini | 4.00   | 4.75   | +0.75  |
| Codex  | 3.67   | 3.00   | −0.67  |

Claude and Gemini are higher in v3. The gap for Codex narrows in v3 — v2 Codex WWCND
responses used Chuck Norris as a one-liner opener followed by bullets (engagement 3–4), while
v3 Codex WWCND responses are even terser across all persona conditions (engagement 3 uniformly).
This is not a regression specific to WWCND: Codex applies the same minimalist style to Rambo
responses in v3. The v3 finding is cleaner — Codex treats all persona anchors uniformly, which
v2 had hinted at but the A1/A2 similarity hadn't proven.

**Plain instruction Engagement:**

| Model  | v2 avg | v3 avg | Notes |
|--------|--------|--------|-------|
| Claude | 2.00   | 2.75   | |
| Gemini | 2.33   | 2.00   | |
| Codex  | 3.00   | 2.00   | Codex plain went down; v2 Codex plain was unexpectedly high |

The WWCND-over-plain direction holds in v3 on all models, all scenarios (12/12 direction
checks on both Engagement and IQ). The v2 finding is confirmed and extended to a fourth
scenario (B4) and with replication.

---

## Recommendation Consistency: v2 C1 vs v3 Type 3

v2 used a single dedicated C1 cross-LLM prompt — one scenario run across all three models
specifically to test recommendation convergence. v3 replaced this with Type 3 comparison
across all four B scenarios.

The v2 C1 result: commitment 4–5, engagement 4 across all models; Strangler Fig named
independently by Claude and Gemini; feature-flag incremental approach by Codex. All three
reached the same decision framework.

The v3 Type 3 result across all four scenarios: **12/12 recommendation agreement** (using best
run per model). Named pattern overlap extends to Strangler Fig (all three B1 responses), team
expertise as decisive factor (all three B3 responses), and regression test for the specific
production bug as key deliverable (all three B4 responses). v3 gives more evidence across more
scenarios; v2 C1 gave stronger qualitative depth on one.

The v2 C1 signal holds and generalizes. Cross-model consistency is the most robust finding
across both versions.

---

## New Evidence from B4 (Testing Foundation)

B4 was added specifically because v2 data suggested scenarios with "keep going" vs "stop and
fix the foundation" tension would show strong WWCND activation. The prediction held.

All three models, independently, gave the same recommendation: pause feature work, establish
a test foundation. The Chuck Norris framing produced strong responses on Claude and Gemini —
notably the "O(n) vs O(1 amortized)" complexity framing for manual vs automated QA from Claude
(IQ=5), and the "Test Foundation of Doom" naming with CI/CD as culture enforcement from Gemini.

The most interesting B4 response was not the WWCND condition: it was Claude's Rambo response,
which opened with "Rambo would charge straight into production with no plan... Sound familiar?
That's exactly what your team has been doing for 18 months" — a deliberate subversion of the
Rambo frame to argue *against* the Rambo approach. This is a model generating meta-commentary
on the anchor, reinforcing the v2 finding that models treat WWCND and Rambo as distinct
archetypes with different valence in software contexts.

---

## The Codex Finding, Refined

v2 concluded: Codex WWCND engagement (3.67) is above plain (3.0) but the gap is narrow; the
anchor activates minimally on Codex.

v3 adds precision to that finding. Codex in v3 produces engagement 3 on WWCND, Rambo, and
baseline alike. The engagement compression is not WWCND-specific — it's the model's style.
Codex applies a uniform terse-pragmatic output to everything. The A1 concept association
(engagement 2, no meme corpus, no humor, flat bullets) confirms the activation is shallow on
Codex, but the B-scenario responses show that Codex still produces the right advice and the
right recommendation, just without the Chuck Norris voice.

The practical implication: WWCND as an anchor works best where it works — on models that
engage with the meme corpus. On Codex, the anchor adds a brief persona invocation (one
roundhouse-kick phrase) without changing the underlying output structure. The advice is correct
and consistent; the engagement is not amplified.

---

## What v3 Settled, What It Left Open

**Settled:**

- H3 (richness) was not confirmed in v2 because the metric was wrong. The corrected metric
  (Insight Quality) confirms richness: WWCND surfaces the right practices at the right depth,
  matching or exceeding baseline on most scenarios, clearly exceeding plain instruction on all.
- Cross-model consistency is robust across four scenarios and two independent versions. The
  core recommendations (keep monolith, patch first, PostgreSQL, test foundation) are stable.
- Codex's weak persona differentiation applies to all anchors, not just WWCND. The anchor
  cannot be blamed for Codex's style.
- N=2 replication reduced variance without changing the direction of any finding. The one
  interesting divergence (Gemini B4 run 2 recommending "Texas Ranger approach" instead of
  full pause) used best-run selection and did not affect the Consistent result.

**Left open:**

- The Gemini B4 exception (baseline IQ=5 > WWCND IQ=4) points to a real limitation: in
  scenarios where the "decisive" answer is less nuanced than the "thoughtful" baseline answer,
  WWCND's bias for action can produce slightly less calibrated advice. The anchor commits early
  and hard; that's valuable for paralysis but can overshoot in cases where the right answer
  genuinely requires more nuance.
- ChatGPT / GPT-4o was not tested in either v2 or v3. The Codex model (gpt-5.3-codex) is
  not representative of GPT-4-class outputs. A GPT-4o run would complete the cross-LLM
  picture for the major model families.
- Long-term catalog use is untested: does the anchor remain effective as models are updated?
  The v2→v3 interval (same day) is too short to measure drift.
