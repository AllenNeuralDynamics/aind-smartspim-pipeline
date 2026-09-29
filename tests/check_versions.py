#!/usr/bin/env python3
"""
Fails if pipeline/versions.config is stale with respect to
environment/versions.env.

The expected file is rendered with environment/render_versions_config.sh
(the same generator submit_pipeline_to_slurm.sh uses) and compared
byte-for-byte, so every ver_* and ref_* entry is covered.

Usage: python3 tests/check_versions.py
Fix:   make versions
"""

import difflib
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
RENDER = ROOT / "environment" / "render_versions_config.sh"
COMMITTED = ROOT / "pipeline" / "versions.config"


def main():
    with tempfile.TemporaryDirectory() as tmp:
        expected_path = Path(tmp) / "versions.config"
        subprocess.run(["bash", str(RENDER), str(expected_path)], check=True)
        expected = expected_path.read_text()

    committed = COMMITTED.read_text()
    if committed == expected:
        print("versions.config is up to date.")
        return

    diff = difflib.unified_diff(
        committed.splitlines(keepends=True),
        expected.splitlines(keepends=True),
        fromfile="pipeline/versions.config (committed)",
        tofile="pipeline/versions.config (from versions.env)",
    )
    sys.stdout.writelines(diff)
    print("\nversions.config is stale. Fix: run `make versions` and commit both files.")
    sys.exit(1)


if __name__ == "__main__":
    main()
