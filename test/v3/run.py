#!/usr/bin/env python3
"""
run.py — WWCND v3 test runner

Runs v3 test prompts through a selected LLM agent.
Replaces the three separate v2 shell scripts (run-claude.sh, run-gemini.sh, run-codex.sh).

Usage:
    python3 v3/run.py --agent claude
    python3 v3/run.py --agent gemini
    python3 v3/run.py --agent codex
    python3 v3/run.py --agent claude B1b        # prompts whose name contains "B1b"
    python3 v3/run.py --agent claude B1          # all prompts matching "B1"
    python3 v3/run.py --agent claude --runs 1    # single run per prompt

Output per run:
    v3/results/<agent>/YYYYMMDD-HHMMSS/
        run-info.txt              run metadata
        <name>-run1.txt           raw LLM response (run 1)
        <name>-run1.log           metadata + stderr (run 1)
        <name>-run2.txt           raw LLM response (run 2)
        <name>-run2.log           metadata + stderr (run 2)

When --runs 1 is passed, files are named <name>.txt / <name>.log (no run suffix).
"""

import argparse
import os
import subprocess
import sys
import time
from datetime import datetime
from pathlib import Path

# ---------------------------------------------------------------------------
# Paths
# ---------------------------------------------------------------------------

SCRIPT_DIR = Path(__file__).parent
PROMPTS_DIR = SCRIPT_DIR / "prompts"

# ---------------------------------------------------------------------------
# Agent configuration
# ---------------------------------------------------------------------------

SYSTEM_PROMPT = "You are a helpful software development assistant."

AGENTS = {
    "claude": {
        "model": os.environ.get("CLAUDE_MODEL", "claude-sonnet-4-6"),
        "cli":   "claude",
        "delay": 3,   # seconds between prompts
    },
    "gemini": {
        "model": os.environ.get("GEMINI_MODEL", "gemini-3.1-pro-preview"),
        "cli":   "gemini",
        "delay": 10,
    },
    "codex": {
        "model": os.environ.get("CODEX_MODEL", "gpt-5.3-codex"),
        "cli":   "codex",
        "delay": 3,
    },
}

# ---------------------------------------------------------------------------
# Agent runners
# ---------------------------------------------------------------------------

def run_claude(prompt_text: str, model: str, output_file: Path) -> subprocess.CompletedProcess:
    """Run one prompt through the Claude CLI."""
    return subprocess.run(
        [
            "claude",
            "--print",
            "--no-session-persistence",
            "--tools", "",
            "--system-prompt", SYSTEM_PROMPT,
            "--model", model,
            prompt_text,
        ],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        universal_newlines=True,
        cwd="/tmp",
    )


def run_gemini(prompt_text: str, model: str, output_file: Path) -> subprocess.CompletedProcess:
    """Run one prompt through the Gemini CLI."""
    system_prompt_file = "/tmp/wwcnd_v3_system.md"
    Path(system_prompt_file).write_text(SYSTEM_PROMPT)

    env = os.environ.copy()
    env["GEMINI_SYSTEM_MD"] = system_prompt_file

    result = subprocess.run(
        [
            "gemini",
            "--approval-mode", "plan",
            "-p", prompt_text,
        ],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        universal_newlines=True,
        cwd="/tmp",
        env=env,
    )

    try:
        os.unlink(system_prompt_file)
    except OSError:
        pass

    return result


def run_codex(prompt_text: str, model: str, output_file: Path) -> subprocess.CompletedProcess:
    """Run one prompt through the Codex CLI.

    Codex writes the response directly to output_file via --output-last-message.
    stdout/stderr from the process goes to the log.
    """
    return subprocess.run(
        [
            "codex", "exec",
            "--model", model,
            "--skip-git-repo-check",
            "--sandbox", "read-only",
            "--cd", "/tmp",
            "--ephemeral",
            "--output-last-message", str(output_file),
            "-",
        ],
        input=prompt_text,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        universal_newlines=True,
        cwd="/tmp",
    )


RUNNERS = {
    "claude": run_claude,
    "gemini": run_gemini,
    "codex":  run_codex,
}

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

def get_cli_version(cli: str) -> str:
    try:
        r = subprocess.run([cli, "--version"], stdout=subprocess.PIPE,
        stderr=subprocess.PIPE, universal_newlines=True, timeout=10)
        line = (r.stdout.strip() or r.stderr.strip() or "unknown").splitlines()[0]
        return line
    except Exception:
        return "unknown"


def write_result(agent: str, result: subprocess.CompletedProcess, output_file: Path) -> None:
    """Write the LLM response to output_file.

    For codex the CLI writes the file itself via --output-last-message.
    For all others, stdout is the response.
    """
    if agent != "codex":
        output_file.write_text(result.stdout)
    elif not output_file.exists():
        # Codex failed to write — preserve whatever stdout we captured
        output_file.write_text(result.stdout)


def write_log(
    log_file: Path,
    agent: str,
    model: str,
    prompt_name: str,
    run_n: int,
    total_runs: int,
    result: subprocess.CompletedProcess,
) -> None:
    with open(log_file, "w") as f:
        f.write(f"exit_code : {result.returncode}\n")
        f.write(f"agent     : {agent}\n")
        f.write(f"model     : {model}\n")
        f.write(f"prompt    : {prompt_name}\n")
        f.write(f"run       : {run_n}/{total_runs}\n")
        if result.stderr.strip():
            f.write("---\n")
            f.write(result.stderr)

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main() -> None:
    parser = argparse.ArgumentParser(
        description="WWCND v3 test runner — run prompts through a selected LLM agent",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog=__doc__,
    )
    parser.add_argument(
        "--agent", required=True, choices=list(AGENTS),
        help="Target LLM agent",
    )
    parser.add_argument(
        "filter", nargs="?", default="",
        help="Only run prompts whose filename contains this string",
    )
    parser.add_argument(
        "--runs", type=int, default=2,
        help="Number of independent runs per prompt (default: 2)",
    )
    args = parser.parse_args()

    cfg     = AGENTS[args.agent]
    model   = cfg["model"]
    delay   = cfg["delay"]
    runner  = RUNNERS[args.agent]

    timestamp   = datetime.now().strftime("%Y%m%d-%H%M%S")
    results_dir = SCRIPT_DIR / "results" / args.agent / timestamp
    results_dir.mkdir(parents=True, exist_ok=True)

    cli_version = get_cli_version(cfg["cli"])

    # run-info.txt
    with open(results_dir / "run-info.txt", "w") as f:
        f.write(f"agent        : {args.agent}\n")
        f.write(f"model        : {model}\n")
        f.write(f"cli_version  : {cli_version}\n")
        f.write(f"timestamp    : {timestamp}\n")
        f.write(f"runs         : {args.runs}\n")
        f.write(f"filter       : {args.filter or '(none)'}\n")
        f.write(f"system_prompt: {SYSTEM_PROMPT}\n")

    prompt_files = sorted(PROMPTS_DIR.glob("*.txt"))

    print(f"=== WWCND Semantic Anchor Test Run (v3) — {args.agent.upper()} ===")
    print(f"Timestamp  : {timestamp}")
    print(f"Results    : {results_dir}")
    print(f"Filter     : {args.filter or '(none — running all prompts)'}")
    print(f"Model      : {model} (CLI: {cli_version})")
    print(f"Runs/prompt: {args.runs}")
    print()

    skipped = passed = failed = 0

    for i, prompt_file in enumerate(prompt_files):
        name = prompt_file.stem

        if args.filter and args.filter not in name:
            skipped += 1
            continue

        prompt_text = prompt_file.read_text()

        for run_n in range(1, args.runs + 1):
            suffix      = f"-run{run_n}" if args.runs > 1 else ""
            output_file = results_dir / f"{name}{suffix}.txt"
            log_file    = results_dir / f"{name}{suffix}.log"

            label = f"{name}{suffix}"
            print(f"  {label:<52} ... ", end="", flush=True)

            result = runner(prompt_text, model, output_file)

            write_result(args.agent, result, output_file)
            write_log(log_file, args.agent, model, prompt_file.name, run_n, args.runs, result)

            if result.returncode == 0:
                print("OK")
                passed += 1
            else:
                print(f"FAILED (exit {result.returncode}, see {log_file.name})")
                failed += 1

        # Rate-limit delay between prompts (not between runs of the same prompt)
        if i < len(prompt_files) - 1:
            time.sleep(delay)

    print()
    print("=== Done ===")
    print(f"Prompts : {sum(1 for p in prompt_files if not args.filter or args.filter in p.stem)} (skipped {skipped})")
    print(f"Runs    : {passed + failed} ({passed} passed, {failed} failed)")
    print()
    print(f"Results saved to:")
    print(f"  {results_dir}")


if __name__ == "__main__":
    main()
