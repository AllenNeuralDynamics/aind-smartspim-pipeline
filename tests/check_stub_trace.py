#!/usr/bin/env python3
"""
Checks a stub run's Nextflow trace file against tests/stub/expected_tasks.json.

Used by `make stub-direct` (plain `nextflow -stub-run`, no nf-test/Java 17).
nf-test runs the same expectations in tests/stub/pipeline.nf.test.

Usage: python3 tests/check_stub_trace.py <trace.txt> <results_path>
"""

import csv
import json
import sys
from collections import Counter
from pathlib import Path

EXPECTED = Path(__file__).resolve().parent / "stub" / "expected_tasks.json"


def main():
    trace_path, results_path = Path(sys.argv[1]), Path(sys.argv[2])
    expected = {k: v for k, v in json.loads(EXPECTED.read_text()).items() if not k.startswith("_")}

    with trace_path.open() as f:
        rows = list(csv.DictReader(f, delimiter="\t"))

    failed = [r["name"] for r in rows if r["status"] != "COMPLETED"]
    actual = Counter(r["name"].split(" ")[0] for r in rows)

    errors = [f"task not COMPLETED: {name}" for name in failed]
    for process in sorted(set(expected) | set(actual)):
        if actual[process] != expected.get(process, 0):
            errors.append(f"{process}: expected {expected.get(process, 0)} tasks, got {actual[process]}")
    if not (results_path / "processing.json").exists():
        errors.append(f"processing.json was not published to {results_path}")

    if errors:
        print("Stub run check failed:\n  " + "\n  ".join(errors))
        sys.exit(1)
    print(f"Stub run OK: {sum(actual.values())} tasks across {len(actual)} processes, processing.json published.")


if __name__ == "__main__":
    main()
