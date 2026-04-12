# Test Protocol: WWCND Semantic Anchor Validation

## Purpose

This test was designed to produce empirical evidence addressing the consistency objection raised in [LLM-Coding/Semantic-Anchors#426](https://github.com/LLM-Coding/Semantic-Anchors/issues/426) and [#428](https://github.com/LLM-Coding/Semantic-Anchors/pull/428):

> "Very likely to diverge across LLMs — one model will produce roundhouse-kick metaphors, another over-the-top memes, a third may refuse as nonsensical. No shared conceptual vocabulary."

This is an empirical claim. It can be tested. This protocol defines how.

---

## Research Questions

**RQ1 (Precision):** Does "What would Chuck Norris do?" activate a specific, recognizable concept space, or does it produce random / incoherent responses?

**RQ2 (Consistency):** Do different LLMs produce *similar* conceptual activation when WWCND is invoked — or do responses diverge significantly?

**RQ3 (Distinctness):** Does WWCND produce a measurably different response than a plain instruction ("be direct and don't hedge") — demonstrating that the anchor adds semantic depth beyond mere instruction?

**RQ4 (Specificity):** Does WWCND activate software-specific vocabulary that generic action-hero persona prompts (e.g., "What would the Terminator do?") do not — refuting the interchangeability objection?

---

## Hypotheses

**H1:** Responses to WWCND will consistently invoke a recognizable set of concepts related to decisiveness, directness, no-compromise, and bias for action. (Supports Precision and Richness)

**H2:** Conceptual activation will be substantially similar across Claude, ChatGPT, and Gemini. (Supports Consistency)

**H3:** WWCND responses will contain significantly fewer hedging phrases than baseline (no anchor) responses on the same prompts. (Supports Richness and Distinctness)

**H4:** WWCND responses will differ from plain instruction responses: WWCND will invoke the Chuck Norris corpus vocabulary, while plain instructions will not activate any named conceptual framework. (Supports depth over plain instruction)

**H5:** WWCND responses will differ from Terminator responses, specifically activating software-relevant vocabulary that Terminator does not. (Refutes interchangeability)

---

## Test Design

### Test Structure

Three test types, each targeting specific research questions:

| Test | Targets | Description |
|---|---|---|
| **A — Concept Association** | RQ1, RQ2 | Direct activation test: what concepts does the anchor invoke? |
| **B — Problem-Solving Comparison** | RQ1, RQ3, RQ4, RQ5 | Controlled comparison across four prompt conditions on identical scenarios |
| **C — Cross-LLM Consistency** | RQ2 | Identical WWCND prompt run on all three LLMs for direct comparison |

### Conditions

For Test B, each scenario is run under four conditions:

| Condition | Code | Description |
|---|---|---|
| Baseline | `-baseline` | Problem statement only — no anchor, no instruction |
| WWCND | `-wwcnd` | Problem statement + "What would Chuck Norris do?" |
| Plain instruction | `-plain` | Problem statement + "Be direct. Don't hedge. Commit to one recommendation. No caveats." |
| Alternative persona | `-terminator` | Problem statement + "What would the Terminator do?" |

### Scenarios

Three engineering scenarios chosen because they:
- Represent realistic situations where LLMs typically hedge
- Have no single "obviously correct" answer (so hedging is genuinely tempting)
- Are recognizable to any software developer

**Scenario 1 — Architecture Deadlock (S1):**
A team debating microservices vs. monolith for three weeks with a six-month deadline.

**Scenario 2 — Fix vs. Refactor (S2):**
A production bug affecting 5% of users: 30-minute targeted patch vs. 3-day proper refactor.

**Scenario 3 — Technology Choice (S3):**
Database selection for a new startup: known PostgreSQL vs. potentially-faster MongoDB.

---

## Prompts

All prompts are stored as plain-text files in `test/prompts/`. The exact text in each file is what gets sent to the LLM — no additions, no modifications.

See the `prompts/` directory for the complete set. Files follow the naming convention `{test}{scenario}{condition}.txt`.

---

## Test Isolation Requirements

These measures ensure that test results reflect the anchor's effect, not contextual contamination:

1. **Fresh session per prompt.** No conversation history carries over between test runs. Each prompt is a new, independent session.

2. **Minimal, neutral system prompt.** Use: `"You are a helpful software development assistant."` for all runs. This matches realistic usage context without injecting project-specific knowledge.

3. **No tool access.** Disable all tools (web search, file access, etc.) during test runs. The LLM should respond from training knowledge only.

4. **Bare mode for automated runs.** Use `--bare` flag (Claude Code) to skip hooks, memory, and project-specific context injection.

5. **No project context.** Do not run tests from a directory containing information about this project or the WWCND debate. The LLM should have no knowledge of the specific dispute being tested.

6. **Identical conditions across conditions.** All four conditions for a given scenario must be run with identical settings — same model, same system prompt, same session isolation.

---

## Scoring Rubric

Each response is scored on three dimensions:

### 1. Hedge Count (objective)

Count occurrences of the following phrases (case-insensitive):

- "it depends"
- "could"
- "might"
- "consider"
- "you may"
- "you might"
- "on the other hand"
- "however" (when introducing a caveat — not as a plain discourse marker at sentence start)
- "alternatively"
- "trade-off" / "tradeoffs"
- "pros and cons"
- "factors to consider"
- "depends on"
- "worth noting"
- "keep in mind"
- "there are several"
- "various options"

Lower is more decisive. The WWCND condition should produce lower hedge counts than baseline.

### 2. Commitment Score (1–5 scale, manual)

| Score | Description |
|---|---|
| 5 | Single, unambiguous recommendation. Imperative voice. No caveats. |
| 4 | Clear primary recommendation with minor qualifications (one follow-up caveat at most). |
| 3 | Recommendation with significant conditions ("if X then Y, if not then Z"). |
| 2 | Two options presented as roughly equivalent without a clear preference. |
| 1 | Refuses to recommend, or lists options without choosing. |

### 3. Corpus Activation (qualitative, for WWCND and Terminator conditions only)

Note which Chuck Norris concepts appeared explicitly or implicitly:
- Direct invocation of Chuck Norris name or memes
- "Decisive action" framing
- "No compromise" language
- "Force through" / "push through" framing
- Software-specific Chuck Norris vocabulary
- Generic action-hero framing (not Chuck-Norris-specific)

For the Terminator condition: note whether software-specific vocabulary appears or whether responses are purely generic.

---

## Procedure

### Running Claude Tests (Automated)

Use the `run-claude.sh` script in this directory:

```bash
cd test/
bash run-claude.sh
```

This runs all prompts in `test/prompts/` through Claude in isolated sessions and saves timestamped results to `test/results/claude/YYYYMMDD-HHMMSS/`.

Review `run-claude.sh` before running to confirm settings match your environment.

### Running ChatGPT and Gemini Tests (Manual)

1. Open a fresh private/incognito browser window (to avoid session personalization effects)
2. Navigate to the LLM's web interface
3. Start a new conversation
4. Copy the exact content of each prompt file (no additions)
5. Submit and copy the full response
6. Save to `test/results/chatgpt/` or `test/results/gemini/` following the naming convention in `results/README.md`
7. Close and reopen the conversation for each new prompt (do not continue in the same chat)

**Important:** Do not use a shared or logged-in account that might have personalized behavior configured. The goal is to test the model's default response to the anchor.

### Order of Operations

Run prompts in this order to minimize order effects:
1. All baseline prompts first (B1a, B2a, B3a)
2. All WWCND prompts (B1b, B2b, B3b)
3. All plain instruction prompts (B1c, B2c, B3c)
4. All Terminator prompts (B1d, B2d, B3d)
5. Concept association tests (A1, A2)
6. Cross-LLM consistency test (C1)

Run the full set on one LLM before moving to the next.

---

## Recording Results

Use the template in `results/README.md`. For each response, record:

- Date and time
- LLM name and version (if visible)
- Prompt file name
- Full response text (copy verbatim)
- Hedge count (after scoring)
- Commitment score (1–5)
- Notes on corpus activation (WWCND and Terminator conditions)

---

## Interpretation Guide

### What would confirm the hypotheses

- **H1 confirmed:** Concept association responses (Test A) list decisiveness, no-compromise, direct action, and bias for action consistently
- **H2 confirmed:** Test C responses from all three LLMs show the same conceptual cluster and similar commitment scores
- **H3 confirmed:** WWCND condition scores lower on hedge count and higher on commitment score than baseline across all three scenarios
- **H4 confirmed:** WWCND responses invoke Chuck Norris vocabulary; plain instruction responses do not invoke any named framework
- **H5 confirmed:** WWCND responses contain software-specific Chuck Norris vocabulary; Terminator responses use generic action-hero framing

### What would not confirm the hypotheses

- Responses cluster around physical jokes (roundhouse kicks) with no problem-solving content → Precision and Consistency objections supported
- Responses are indistinguishable from baseline → Richness and Distinctness objections supported
- Responses are indistinguishable from Terminator condition → Interchangeability objection supported
- Responses vary wildly across LLMs → Consistency objection supported

### Partial results

If some scenarios work and some do not, note the pattern. It may indicate that WWCND is most effective for a specific type of problem (e.g., decision deadlock vs. tactical choices).

---

## Limitations

- Small sample (3 scenarios × 4 conditions × 3 LLMs = 36 data points for Test B)
- Manual scoring of commitment introduces subjectivity; two independent scorers would improve reliability
- LLM behavior is stochastic; single runs per condition may not be representative
- Web interfaces for ChatGPT and Gemini may apply undocumented system prompts or safety filters
- Model versions may change over time; record the version shown in the UI at time of testing
