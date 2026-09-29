#!/usr/bin/env python3
"""
Verifies that every capsule referenced by pipeline/main_slurm_v3.nf can
actually be fetched at runtime.

For each process it checks that:
1. The container image tag exists on GHCR.
2. The image is built for linux/amd64 (the SLURM nodes).
3. The git repository has the tag the process clones.
4. A GitHub Release exists for that tag.
5. That tag contains the entrypoint the process executes (code/run or code/run_slurm).

Stub tests skip process scripts, so this is the only CI check that
catches a wrong repo URL, a missing release tag or an unpublished image.

Set GITHUB_TOKEN to avoid the unauthenticated GitHub API rate limit.

Usage: python3 tests/check_capsule_refs.py
"""

import functools
import json
import os
import re
import subprocess
import sys
import urllib.error
import urllib.request
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
PIPELINE = ROOT / "pipeline" / "main_slurm_v3.nf"
VERSIONS_CONFIG = ROOT / "pipeline" / "versions.config"

MANIFEST_TYPES = ", ".join(
    [
        "application/vnd.oci.image.index.v1+json",
        "application/vnd.oci.image.manifest.v1+json",
        "application/vnd.docker.distribution.manifest.list.v2+json",
        "application/vnd.docker.distribution.manifest.v2+json",
    ]
)


def read_params(path):
    """Reads `name = "value"` assignments from versions.config"""
    return dict(re.findall(r'(\w+)\s*=\s*"([^"]+)"', path.read_text()))


def read_processes(path):
    """Extracts the container image and cloned repo of every process"""
    text = path.read_text()
    processes = []
    for match in re.finditer(r"^process (\w+) \{(.*?)^\}", text, re.S | re.M):
        name, body = match.groups()
        image = re.search(r'container "ghcr\.io/([^:"]+):\$\{params\.(\w+)\}"', body)
        clone = re.search(
            r"--branch \$\{params\.(\w+)\}.*?\"https://github\.com/([^\"]+?)\.git\"",
            body,
            re.S,
        )
        entrypoint = re.search(r"chmod \+x (\S+)", body)
        if not image or not clone or not entrypoint:
            raise ValueError(f"Could not parse container/clone/entrypoint for process '{name}'")
        processes.append(
            {
                "process": name,
                "image": image.group(1),
                "image_param": image.group(2),
                "repo": clone.group(2),
                "ref_param": clone.group(1),
                "entrypoint": entrypoint.group(1),
            }
        )
    return processes


def fetch(url, headers=None):
    """Returns (status, parsed JSON body or None)"""
    request = urllib.request.Request(url, headers=headers or {}, method="GET")
    try:
        with urllib.request.urlopen(request, timeout=60) as response:
            body = response.read()
            try:
                return response.status, json.loads(body)
            except ValueError:
                return response.status, None
    except urllib.error.HTTPError as e:
        return e.code, None


def http_status(url, headers=None):
    return fetch(url, headers)[0]


@functools.lru_cache(maxsize=None)
def image_platforms(image, tag):
    """Returns the set of os/arch platforms of an image tag, or None if the tag is missing"""
    _, token = fetch(f"https://ghcr.io/token?scope=repository:{image}:pull")
    auth = {"Authorization": f"Bearer {token['token']}"}
    status, manifest = fetch(
        f"https://ghcr.io/v2/{image}/manifests/{tag}", {**auth, "Accept": MANIFEST_TYPES}
    )
    if status != 200:
        return None
    if "manifests" in manifest:
        return {
            f"{m['platform']['os']}/{m['platform']['architecture']}"
            for m in manifest["manifests"]
            if m.get("platform", {}).get("os") not in (None, "unknown")
        }
    _, config = fetch(f"https://ghcr.io/v2/{image}/blobs/{manifest['config']['digest']}", auth)
    return {f"{config.get('os')}/{config.get('architecture')}"}


@functools.lru_cache(maxsize=None)
def release_exists(repo, ref):
    headers = {"Accept": "application/vnd.github+json"}
    if os.getenv("GITHUB_TOKEN"):
        headers["Authorization"] = f"Bearer {os.environ['GITHUB_TOKEN']}"
    return http_status(f"https://api.github.com/repos/{repo}/releases/tags/{ref}", headers) == 200


@functools.lru_cache(maxsize=None)
def git_tag_exists(repo, ref):
    result = subprocess.run(
        ["git", "ls-remote", "--exit-code", f"https://github.com/{repo}.git", f"refs/tags/{ref}"],
        capture_output=True,
        text=True,
    )
    return result.returncode == 0


@functools.lru_cache(maxsize=None)
def entrypoint_exists(repo, ref, entrypoint):
    return http_status(f"https://raw.githubusercontent.com/{repo}/{ref}/code/{entrypoint}") == 200


def main():
    params = read_params(VERSIONS_CONFIG)
    errors = []

    for p in read_processes(PIPELINE):
        tag = params.get(p["image_param"])
        ref = params.get(p["ref_param"])
        label = f"{p['process']:<22}"

        if tag is None or ref is None:
            errors.append(f"{label} {p['image_param']}/{p['ref_param']} missing from versions.config")
            continue

        platforms = image_platforms(p["image"], tag)
        checks = [
            (f"image {p['image']}:{tag}", platforms is not None),
            (f"image platform linux/amd64 (has {sorted(platforms or [])})", "linux/amd64" in (platforms or ())),
            (f"tag {p['repo']}@{ref}", git_tag_exists(p["repo"], ref)),
            (f"release {p['repo']}@{ref}", release_exists(p["repo"], ref)),
            (f"code/{p['entrypoint']} @ {ref}", entrypoint_exists(p["repo"], ref, p["entrypoint"])),
        ]
        for what, ok in checks:
            print(f"{label} {'OK     ' if ok else 'MISSING'} {what}")
            if not ok:
                errors.append(f"{label} {what}")

    if errors:
        print("\nCapsule reference problems (missing images, tags or entrypoints fail at runtime;\n"
              "every pinned ref must also be a published GitHub Release):\n  " + "\n  ".join(errors))
        sys.exit(1)
    print("\nAll capsule images, platforms, tags, releases and entrypoints resolve.")


if __name__ == "__main__":
    main()
