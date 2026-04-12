# Test Suite: WWCND Semantic Anchor Validation

Empirical tests addressing the consistency and richness objections raised in the Semantic
Anchors catalog rejection.

---

## Versions

### v1 — Hedge Count / Commitment / Corpus Activation

**Status:** Complete (Claude). ChatGPT and Gemini pending.

Measured hedge count, commitment score (1–5), and corpus activation. Comparison persona:
Terminator.

Key finding: hedge counts were uniformly near zero across all conditions for Claude, making
that dimension non-differentiating. Commitment scores: plain instruction (5.0) > WWCND (4.33)
> Terminator (4.0) > baseline (3.67). Qualitative review found WWCND responses embedded
concrete best practices and were more enjoyable to read — neither of which the v1 rubric captured.

→ [v1/README.md](v1/README.md) | [v1/protocol.md](v1/protocol.md) | [v1/results/](v1/results/)

### v2 — Actionable Specificity / Commitment / Engagement

**Status:** Ready to run.

Drops hedge count. Adds actionable specificity count (concrete best practices beyond the
primary answer) and engagement score (1–5). Comparison persona changed from Terminator to
Rambo — a weaker anchor with no software-specific subcorpus, providing a cleaner contrast.

→ [v2/README.md](v2/README.md) | [v2/protocol.md](v2/protocol.md) | [v2/results/](v2/results/)

---

## Shared Scripts

| Script | Purpose |
|--------|---------|
| `v2/create-prompts.sh` | Generates all v2 prompt files from scenario texts |
| `v1/score-hedges.sh` | Counts hedge phrases in v1 result files |
