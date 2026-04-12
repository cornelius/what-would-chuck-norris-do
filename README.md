# What Would Chuck Norris Do?

**A semantic anchor for decisive, no-compromise problem-solving.**

This repository documents the proposal of "What Would Chuck Norris Do?" (WWCND) as a semantic anchor for the [Semantic Anchors](https://llm-coding.github.io/Semantic-Anchors/) catalog, the subsequent rejection, the research and counter-arguments we assembled, and the empirical test we are running to support the case.

## The Anchor

> Chuck Norris would not compromise and finds the quickest, most effective solution without hesitation, against all odds. Asking a model to put itself in Chuck's shoes leads it to force through a problem and come up with a maybe extreme but most effective solution.

The phrase draws on the Chuck Norris meme corpus — a vast, culturally consistent body of internet folklore documenting a specific archetype: unstoppable force, absolute decisiveness, zero tolerance for hedging, maximum directness. For software work, this translates into cutting through analysis paralysis, committing to a single course of action, and refusing to over-engineer.

## Status

| Event | Link |
|---|---|
| Anchor proposed (Issue #426) | [LLM-Coding/Semantic-Anchors#426](https://github.com/LLM-Coding/Semantic-Anchors/issues/426) |
| Copilot implementation (PR #428) | [LLM-Coding/Semantic-Anchors#428](https://github.com/LLM-Coding/Semantic-Anchors/pull/428) |
| Both declined | See above |
| Counter-argument in progress | This repository |

## Repository Structure

```
case/    Research, rejection analysis, and counter-arguments
test/    Empirical test protocol and results
```

### Case

- [01 · GitHub History](case/01-github-history.md) — Timeline of events, direct quotes, what was said and by whom
- [02 · Rejection Analysis](case/02-rejection-analysis.md) — Detailed breakdown of each rejection reason
- [03 · Counter-Arguments](case/03-counter-arguments.md) — Evidence-based response to every objection
- [04 · Corpus and Precedents](case/04-corpus-and-precedents.md) — Attribution evidence and catalog precedents that support the case

### Test

- [Test Overview and Procedure](test/README.md) — What we are testing, why, and how to run it
- [Test Protocol](test/protocol.md) — Research questions, conditions, scenarios, scoring rubric
