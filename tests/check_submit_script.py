#!/usr/bin/env python3
"""
Checks that pipeline/deployment.env.example, pipeline/submit_pipeline_to_slurm.sh
and pipeline/main_slurm_v3.nf agree, without SLURM or a real Nextflow run.

The submit script runs against a throwaway copy of the repo with a fake
`nextflow` on PATH that records its arguments and environment. It is run
twice:
1. Every variable in deployment.env.example set to a unique value. Each one
   must reach Nextflow, either in its arguments or as an exported variable.
   Every --param passed must be declared by main_slurm_v3.nf, and every
   variable exported for the containers must be in envWhitelist.
2. Only the required variables set. No optional --param may be passed and no
   optional variable exported.

Usage: python3 tests/check_submit_script.py
"""

import os
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
EXAMPLE = ROOT / "pipeline" / "deployment.env.example"
SUBMIT = "pipeline/submit_pipeline_to_slurm.sh"
PIPELINE = ROOT / "pipeline" / "main_slurm_v3.nf"
SLURM_CONFIG = ROOT / "pipeline" / "nextflow_slurm.config"

# Read by Nextflow itself (main_slurm_v3.nf / nextflow_slurm.config), not by the containers
NEXTFLOW_ENV = {"DATA_PATH", "RESULTS_PATH"}

FAKE_NEXTFLOW = """#!/usr/bin/env bash
printf '%s\\n' "$@" > "$CAPTURE_DIR/argv"
env > "$CAPTURE_DIR/env"
"""


def example_variables():
    """Returns (required, optional) variable names from deployment.env.example"""
    required, optional = [], []
    for line in EXAMPLE.read_text().splitlines():
        match = re.match(r"^(#\s*)?([A-Z][A-Z0-9_]*)=", line)
        if match:
            (optional if match.group(1) else required).append(match.group(2))
    return required, optional


def declared_params():
    text = PIPELINE.read_text()
    return set(re.findall(r"\bparams\.(\w+)", text))


def env_whitelist():
    block = re.search(r"envWhitelist\s*=\s*\[(.*?)\]", SLURM_CONFIG.read_text(), re.S).group(1)
    return set(re.findall(r"'([A-Z0-9_]+)'", block))


def run_submit(values, workdir):
    """Runs the submit script with the given deployment.env values; returns (argv, env)"""
    root = workdir / "repo"
    shutil.rmtree(root, ignore_errors=True)
    for folder in ("environment", "pipeline"):
        shutil.copytree(ROOT / folder, root / folder)

    deployment_env = workdir / "deployment.env"
    lines = [f'PIPELINE_PATH="{root}"'] + [f'{k}="{v}"' for k, v in values.items()]
    deployment_env.write_text("\n".join(lines) + "\n")

    bin_dir = workdir / "bin"
    bin_dir.mkdir(exist_ok=True)
    fake = bin_dir / "nextflow"
    fake.write_text(FAKE_NEXTFLOW)
    fake.chmod(0o755)

    capture = workdir / "capture"
    shutil.rmtree(capture, ignore_errors=True)
    capture.mkdir()

    names = set(values) | {"PIPELINE_PATH"}
    env = {k: v for k, v in os.environ.items() if k not in names}
    env.update(
        PATH=f"{bin_dir}{os.pathsep}{os.environ['PATH']}",
        DEPLOYMENT_ENV=str(deployment_env),
        CAPTURE_DIR=str(capture),
    )
    result = subprocess.run(["bash", str(root / SUBMIT)], env=env, capture_output=True, text=True)
    if result.returncode != 0:
        raise RuntimeError(f"submit script failed:\n{result.stdout}{result.stderr}")

    argv = (capture / "argv").read_text().splitlines()
    captured_env = dict(
        line.split("=", 1) for line in (capture / "env").read_text().splitlines() if "=" in line
    )
    return argv, captured_env


def passed_params(argv):
    return {a[2:] for a in argv if a.startswith("--")}


def main():
    required, optional = example_variables()
    params, whitelist = declared_params(), env_whitelist()
    errors = []

    with tempfile.TemporaryDirectory() as tmp:
        workdir = Path(tmp)

        # 1. Every variable set: each must reach Nextflow
        values = {name: f"SENTINEL_{name}" for name in required + optional if name != "PIPELINE_PATH"}
        argv, env = run_submit(values, workdir)
        for name, value in values.items():
            in_args = any(value in arg for arg in argv)
            exported = env.get(name) == value
            if not in_args and not exported:
                errors.append(f"{name} is set in deployment.env but never reaches Nextflow")
            if exported and not in_args and name not in NEXTFLOW_ENV and name not in whitelist:
                errors.append(f"{name} is exported but not in envWhitelist, so containers never see it")
        for param in sorted(passed_params(argv) - params):
            errors.append(f"--{param} is passed but main_slurm_v3.nf doesn't declare params.{param}")
        print(f"all variables set:  {len(passed_params(argv))} params passed, "
              f"{sum(env.get(n) == v for n, v in values.items())} variables exported")

        # 2. Only required variables set: nothing optional may leak through
        values = {name: f"SENTINEL_{name}" for name in required if name != "PIPELINE_PATH"}
        argv, env = run_submit(values, workdir)
        baseline = passed_params(argv)
        for name in optional:
            if name in env:
                errors.append(f"optional {name} is exported even though it is unset")
        for arg in argv:
            if any(arg == f"SENTINEL_{name}" for name in optional):
                errors.append(f"optional value {arg} is passed even though it is unset")
        print(f"only required set:  {len(baseline)} params passed")

    if errors:
        print("\nDeployment config is inconsistent:\n  " + "\n  ".join(errors))
        sys.exit(1)
    print("\ndeployment.env.example, submit_pipeline_to_slurm.sh and main_slurm_v3.nf agree.")


if __name__ == "__main__":
    main()
