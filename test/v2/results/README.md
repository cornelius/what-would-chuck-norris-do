# v2 Raw Results

One `.txt` file per prompt per LLM run, named after the prompt file.

```
results/
├── claude/
│   └── 20260413-014102/     claude-sonnet-4-6 (model inferred — see RESULTS.md)
│       └── ... (15 files)
├── gemini/
│   └── 20260413-214451/     gemini-3.1-pro-preview (identified from error traces)
│       └── ... (15 files)
└── codex/
    └── 20260413-220036/     gpt-5.3-codex (see run-info.txt)
        └── ... (15 files + run-info.txt)
```

Scores and analysis: [../RESULTS.md](../RESULTS.md)
