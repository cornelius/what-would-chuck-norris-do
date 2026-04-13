# Test Suite: WWCND Semantic Anchor Validation

Empirical tests addressing the consistency and richness objections raised in the Semantic
Anchors catalog rejection.

---

## Results

| Document | Contents |
|----------|----------|
| [v1/RESULTS.md](v1/RESULTS.md) | v1 scoring log, summaries, conclusions, and what v1 revealed about the test design |
| [v2/RESULTS.md](v2/RESULTS.md) | v2 scoring log (Claude + Gemini), summaries, conclusions for H1–H5 |
| [COMPARISON.md](COMPARISON.md) | Cross-version evolution, cross-run consistency, cross-LLM patterns, revised counter-case framing |

---

## Test Versions

### v1 — Hedge Count / Commitment / Corpus Activation

Measured hedge count, commitment score, and corpus activation. Comparison persona: Terminator.

Finding: hedge counts uniformly near zero — metric had no signal for this model. Commitment:
plain (5.0) > WWCND (4.33) > Terminator (4.0) > baseline (3.67). Qualitative reading revealed
the real differentiators — engagement and embedded best practices — which the v1 rubric missed.

→ [v1/protocol.md](v1/protocol.md) | [v1/RESULTS.md](v1/RESULTS.md) | [v1/results/](v1/results/)

### v2 — Actionable Specificity / Commitment / Engagement

Drops hedge count. Adds actionable specificity count and engagement score. Comparison persona
changed from Terminator to Rambo. Runs: Claude, Gemini, Codex.

Finding: WWCND wins on engagement (4.0–4.67) vs plain (2.0–2.33) consistently across both
scored LLMs and all three scenarios. Plain wins on commitment. Baseline wins on specificity.

→ [v2/protocol.md](v2/protocol.md) | [v2/RESULTS.md](v2/RESULTS.md) | [v2/results/](v2/results/)

---

## Scripts

| Script | Purpose |
|--------|---------|
| `v2/run-claude.sh` | Run all v2 prompts through Claude (automated) |
| `v2/run-gemini.sh` | Run all v2 prompts through Gemini (automated) |
| `v2/run-codex.sh` | Run all v2 prompts through Codex (automated) |
| `v2/create-prompts.sh` | Regenerate all v2 prompt files from scenario texts |
| `v1/score-hedges.sh` | Count hedge phrases in v1 result files |
