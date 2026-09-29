#!/usr/bin/env python3
"""
Compares the CodeOcean pipeline with pipeline/main_slurm_v3.nf.

The CodeOcean side is read from .codeocean/nextflow.json (the spec
CodeOcean generates main.nf from); main.nf itself is never parsed or
linted. The SLURM side is parsed from main_slurm_v3.nf.

For every process it compares:
- Input edges: (source process/dataset, glob, target folder, collect/flatten)
- Capsule arguments
- Capsule version (CO capsule name vs the numeric part of ref_*)

Every difference must be listed, with a reason, in
tests/parity_allowlist.json. Unlisted differences fail, and so do
allowlist entries that no longer match anything, so the list can't go
stale. A failure means main_slurm_v3.nf needs updating (or the
difference needs a documented reason) — never main.nf.

Usage: python3 tests/check_parity.py
"""

import json
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from check_capsule_refs import read_params, read_processes  # noqa: E402

ROOT = Path(__file__).resolve().parents[1]
CO_SPEC = ROOT / ".codeocean" / "nextflow.json"
CO_DATASETS = ROOT / ".codeocean" / "datasets.json"
SLURM_PIPELINE = ROOT / "pipeline" / "main_slurm_v3.nf"
VERSIONS_CONFIG = ROOT / "pipeline" / "versions.config"
ALLOWLIST = Path(__file__).resolve().parent / "parity_allowlist.json"

# SLURM params that point at the same data as the CodeOcean dataset mounts
SLURM_DATASET_PARAMS = {
    "params.lightsheet_dataset": "dataset",
    "cell_models_path": "models",
}


def edge_key(source, glob, target, op):
    return f"{source}:{glob or '*'} -> {target.strip('/') or '.'} [{op}]"


def version_of(text):
    match = re.search(r"(\d+\.\d+\.\d+)", text or "")
    return match.group(1) if match else None


def co_process_name(capsule_name, arguments, process_map):
    """Maps a CodeOcean capsule to its SLURM process (None if it has no counterpart)"""
    base = re.sub(r"-\d+\.\d+\.\d+.*$", "", capsule_name)
    target = process_map.get(base)
    if isinstance(target, dict):
        mode = (arguments or [""])[0]
        return target.get(mode)
    return target


def read_codeocean(process_map):
    spec = json.loads(CO_SPEC.read_text())
    mounts = {d["id"]: d["mount"] for d in json.loads(CO_DATASETS.read_text())["attached_datasets"]}
    dataset_kind = {
        "smartspim_dataset": "dataset",
        "smartspim_production_models": "models",
    }

    names = {}
    for p in spec["processes"]:
        capsule = p["capsule"]
        names[p["name"]] = co_process_name(capsule["name"], capsule.get("arguments"), process_map)

    processes = {}
    for p in spec["processes"]:
        capsule = p["capsule"]
        mapped = names[p["name"]] or f"<co:{p['name']}>"
        edges = set()
        for i in p.get("inputs", []):
            op = "collect" if i.get("collect") else "flatten" if i.get("flatten") else "-"
            source_path = i.get("source_path") or ""
            if i["type"] == "dataset":
                mount = mounts[i["source_id"]]
                source = dataset_kind.get(mount, "template")
                glob = source_path[len(mount):].strip("/")
            else:
                source = names.get(i["source_id"]) or f"<co:{i['source_id']}>"
                glob = source_path
            edges.add(edge_key(source, glob, i.get("target_path") or "", op))
        processes[mapped] = {
            "co_name": p["name"],
            "unmapped": names[p["name"]] is None,
            "edges": edges,
            "arguments": " ".join(capsule.get("arguments") or []),
            "version": version_of(capsule["name"]),
        }
    return processes


def read_slurm():
    text = SLURM_PIPELINE.read_text()
    params = read_params(VERSIONS_CONFIG)
    refs = {p["process"]: params.get(p["ref_param"]) for p in read_processes(SLURM_PIPELINE)}

    # Dataset channels: NAME = channel.fromPath(<param> + "/<path>", ...)
    channel_sources = {}
    for name, param, path in re.findall(
        r'^(\w+)\s*=\s*channel\.fromPath\(([\w.]+)\s*\+\s*"([^"]*)"', text, re.M
    ):
        channel_sources[name] = (SLURM_DATASET_PARAMS.get(param, param), path.strip("/"))

    blocks = re.findall(r"^process (\w+) \{(.*?)^\}", text, re.S | re.M)

    # Process outputs: path '<glob>' into <channel>[, <channel>]
    for name, body in blocks:
        for glob, channels in re.findall(r"path '([^']+)' into ([\w, ]+)", body):
            for channel in channels.split(","):
                channel_sources[channel.strip()] = (name, glob.replace("capsule/results/", "", 1))

    processes = {}
    for name, body in blocks:
        edges = set()
        for target, channel, op in re.findall(
            r"path '([^']+)' from (\w+)(?:\.(collect|flatten)\(\))?", body
        ):
            if channel not in channel_sources:
                raise ValueError(f"{name}: input channel '{channel}' has no producer")
            source, glob = channel_sources[channel]
            edges.add(edge_key(source, glob, target.replace("capsule/data", "", 1), op or "-"))
        run = re.search(r"^[ \t]*\./run\w*(?:[ \t]+(.*))?$", body, re.M)
        processes[name] = {
            "edges": edges,
            "arguments": (run.group(1) or "").strip() if run else "",
            "version": version_of(refs.get(name)),
        }
    return processes


def compare(co, slurm):
    differences = []
    for name in sorted(set(co) | set(slurm)):
        if name not in slurm:
            differences.append(f"missing-process:{co[name]['co_name']}")
            continue
        if name not in co:
            differences.append(f"extra-process:{name}")
            continue
        c, s = co[name], slurm[name]
        differences += [f"missing-edge:{name}:{e}" for e in sorted(c["edges"] - s["edges"])]
        differences += [f"extra-edge:{name}:{e}" for e in sorted(s["edges"] - c["edges"])]
        if c["arguments"] != s["arguments"]:
            differences.append(f"arguments:{name}:co={c['arguments']!r} slurm={s['arguments']!r}")
        if c["version"] != s["version"]:
            differences.append(f"version:{name}:co={c['version']} slurm={s['version']}")
    return differences


def main():
    allowlist = json.loads(ALLOWLIST.read_text())
    allowed = {entry["key"]: entry["reason"] for entry in allowlist["allowed"]}

    differences = compare(read_codeocean(allowlist["process_map"]), read_slurm())

    unexpected = [d for d in differences if d not in allowed]
    stale = [k for k in allowed if k not in differences]

    for d in differences:
        print(f"{'allowed   ' if d in allowed else 'UNEXPECTED'} {d}")

    if unexpected or stale:
        if unexpected:
            print("\nUnexpected CodeOcean <-> SLURM differences (update main_slurm_v3.nf, "
                  "or add them to tests/parity_allowlist.json with a reason):")
            print("\n".join(f"  {d}" for d in unexpected))
        if stale:
            print("\nAllowlist entries that no longer match any difference (remove them):")
            print("\n".join(f"  {k}" for k in stale))
        sys.exit(1)

    print(f"\nParity OK: {len(differences)} documented differences, none unexpected.")


if __name__ == "__main__":
    main()
