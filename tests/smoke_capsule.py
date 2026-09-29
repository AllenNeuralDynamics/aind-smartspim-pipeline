#!/usr/bin/env python3
"""
Container smoke test: checks that each capsule's pinned code runs against
its pinned image, without data.

For every capsule in pipeline/main_slurm_v3.nf it pulls the image and,
inside it:
1. Checks that git is available (processes clone their code inside the container).
2. Clones the repo at the pinned ref.
3. Activates the conda env named in the entrypoint (code/run or code/run_slurm),
   if any, and imports the entrypoint's Python script. Every capsule
   script guards __main__, so this loads all of its dependencies
   without running it, and catches new code on an old image.
4. Checks that the Java jars on the process CLASSPATH exist (stitch, fuse).

Requires docker. Images are several GB each.

Usage: python3 tests/smoke_capsule.py [process ...]   (default: all capsules)
"""

import re
import subprocess
import sys
import urllib.request
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from check_capsule_refs import PIPELINE, VERSIONS_CONFIG, read_params, read_processes  # noqa: E402

IMPORT_SCRIPT = """
import importlib.util, sys
sys.path.insert(0, ".")
spec = importlib.util.spec_from_file_location("capsule_entrypoint", sys.argv[1])
spec.loader.exec_module(importlib.util.module_from_spec(spec))
print("imported", sys.argv[1])
"""


def capsules():
    """Unique (image, code) combinations; the dispatcher backs three processes"""
    params = read_params(VERSIONS_CONFIG)
    bodies = dict(re.findall(r"^process (\w+) \{(.*?)^\}", PIPELINE.read_text(), re.S | re.M))
    unique = {}
    for p in read_processes(PIPELINE):
        classpath = re.search(r"'CLASSPATH':\s*'([^']+)'", bodies[p["process"]])
        capsule = {
            **p,
            "tag": params[p["image_param"]],
            "ref": params[p["ref_param"]],
            "jar_dirs": [c.rstrip("/*") for c in classpath.group(1).split(":")] if classpath else [],
        }
        key = (capsule["image"], capsule["tag"], capsule["repo"], capsule["ref"], capsule["entrypoint"])
        unique.setdefault(key, {**capsule, "processes": []})["processes"].append(p["process"])
    return list(unique.values())


def entrypoint_commands(capsule):
    """Parses the conda env and Python script out of the capsule entrypoint"""
    url = f"https://raw.githubusercontent.com/{capsule['repo']}/{capsule['ref']}/code/{capsule['entrypoint']}"
    with urllib.request.urlopen(url, timeout=60) as response:
        text = response.read().decode()
    env = re.search(r"^\s*conda activate (\S+)", text, re.M)
    script = re.search(r"^\s*python\b.*?(\S+\.py)\b", text, re.M)
    if not script:
        raise ValueError(f"No python entrypoint found in {url}")
    return (env.group(1) if env else None), script.group(1)


def smoke(capsule):
    env, script = entrypoint_commands(capsule)
    activate = f"source /opt/conda/etc/profile.d/conda.sh && conda activate {env}" if env else "true"
    jar_checks = " && ".join(
        f'ls {d}/*.jar >/dev/null && echo "jars found in {d}"' for d in capsule["jar_dirs"]
    ) or "true"
    inner = f"""
set -euo pipefail
command -v git >/dev/null || {{ echo "git is not installed in the image"; exit 1; }}
git clone -q --depth 1 --branch {capsule['ref']} https://github.com/{capsule['repo']}.git /tmp/capsule
cd /tmp/capsule/code
{activate}
python -c '{IMPORT_SCRIPT}' {script}
{jar_checks}
"""
    image = f"ghcr.io/{capsule['image']}:{capsule['tag']}"
    print(f"\n=== {', '.join(capsule['processes'])}: {image} + {capsule['repo']}@{capsule['ref']}", flush=True)
    subprocess.run(["docker", "pull", "-q", "--platform", "linux/amd64", image], check=True)
    result = subprocess.run(
        ["docker", "run", "--rm", "--platform", "linux/amd64", "--entrypoint", "bash", image, "-c", inner]
    )
    return result.returncode == 0


def main():
    selected = set(sys.argv[1:])
    targets = [c for c in capsules() if not selected or selected & set(c["processes"])]
    if selected and not targets:
        sys.exit(f"No capsule runs any of: {', '.join(sorted(selected))}")

    failed = [", ".join(c["processes"]) for c in targets if not smoke(c)]
    if failed:
        print("\nSmoke test failed for:\n  " + "\n  ".join(failed))
        sys.exit(1)
    print(f"\nSmoke test passed for {len(targets)} capsule(s).")


if __name__ == "__main__":
    main()
