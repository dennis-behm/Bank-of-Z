#!/usr/bin/env python3
"""Render a ZCodeScan SonarQube export (zcs_export_sonarqube.json) as GitHub-flavored Markdown.

Usage: zcodescan-summary.py <sonarqube.json> [--repo OWNER/REPO] [--sha SHA] [--max-per-rule N]
Markdown is written to stdout (append it to $GITHUB_STEP_SUMMARY).
"""
import argparse
import json
import re
from collections import Counter, defaultdict

SEVERITIES = ["BLOCKER", "HIGH", "MEDIUM", "LOW", "INFO"]
MARKER = {"BLOCKER": "🟥", "HIGH": "🟧", "MEDIUM": "🟨", "LOW": "🟦", "INFO": "⬜"}
MAX_SUMMARY_BYTES = 900_000  # GitHub limits a step summary to 1 MiB


def clean_html(text):
    """Rule descriptions use <br> for line breaks; turn them into plain text."""
    text = re.sub(r"<br\s*/?>", "\n", text or "")
    return re.sub(r"<[^>]+>", "", text).strip()


def esc(text):
    return (text or "").replace("|", "\\|").replace("\n", " ")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("report")
    ap.add_argument("--repo", default="")
    ap.add_argument("--sha", default="")
    ap.add_argument("--max-per-rule", type=int, default=25)
    args = ap.parse_args()

    with open(args.report, encoding="utf-8") as f:
        data = json.load(f)
    rules = {r["id"]: r for r in data.get("rules", [])}
    issues = data.get("issues", [])
    repo_name = args.repo.split("/")[-1] if args.repo else ""

    def severity(rule_id):
        impacts = rules.get(rule_id, {}).get("impacts") or [{}]
        return impacts[0].get("severity", "INFO")

    def quality(rule_id):
        impacts = rules.get(rule_id, {}).get("impacts") or [{}]
        return impacts[0].get("softwareQuality", "UNKNOWN")

    def rel_path(path):
        return path[len(repo_name) + 1:] if repo_name and path.startswith(repo_name + "/") else path

    def location(issue):
        loc = issue["primaryLocation"]
        line = loc.get("textRange", {}).get("startLine", 0)
        path = loc["filePath"]
        label = f"{rel_path(path)}:{line}"
        if args.repo and args.sha and repo_name and path.startswith(repo_name + "/"):
            url = f"https://github.com/{args.repo}/blob/{args.sha}/{rel_path(path)}#L{line}"
            return f"[{label}]({url})"
        return f"`{label}`"

    by_sev = Counter(severity(i["ruleId"]) for i in issues)
    by_quality = Counter(quality(i["ruleId"]) for i in issues)
    by_file = defaultdict(Counter)
    by_rule = defaultdict(list)
    for i in issues:
        by_file[rel_path(i["primaryLocation"]["filePath"])][severity(i["ruleId"])] += 1
        by_rule[i["ruleId"]].append(i)

    out = ["## ZCodeScan Static Analysis", ""]
    out.append(f"**{len(issues)}** issue(s) found by **{len(by_rule)}** of {len(rules)} rule(s) "
               f"in **{len(by_file)}** file(s).")
    out.append("")

    out += ["### By severity", "", "| Severity | Issues |", "|---|---:|"]
    for s in SEVERITIES:
        out.append(f"| {MARKER[s]} {s} | {by_sev.get(s, 0)} |")
    out.append("")

    out += ["### By software quality", "", "| Quality | Issues |", "|---|---:|"]
    for q, n in by_quality.most_common():
        out.append(f"| {q.title()} | {n} |")
    out.append("")

    out += ["### By file", "", "| File | " + " | ".join(SEVERITIES) + " | Total |",
            "|---|" + "---:|" * (len(SEVERITIES) + 1)]
    for path, c in sorted(by_file.items(), key=lambda kv: -sum(kv[1].values())):
        out.append(f"| `{path}` | " + " | ".join(str(c.get(s, 0)) or "0" for s in SEVERITIES)
                   + f" | {sum(c.values())} |")
    out.append("")

    out += ["### By rule", "", "| Severity | Rule | Rule ID | Issues |", "|---|---|---|---:|"]
    ordered = sorted(by_rule, key=lambda r: (SEVERITIES.index(severity(r)), -len(by_rule[r])))
    for rid in ordered:
        s = severity(rid)
        out.append(f"| {MARKER[s]} {s} | {esc(rules.get(rid, {}).get('name', rid))} | `{rid.rsplit('.', 1)[-1]}` | {len(by_rule[rid])} |")
    out.append("")

    out += ["### Details", ""]
    for rid in ordered:
        rule = rules.get(rid, {})
        s = severity(rid)
        group = by_rule[rid]
        out.append(f"<details><summary>{MARKER[s]} <b>{s}</b> – {esc(rule.get('name', rid))} "
                   f"({len(group)})</summary>")
        out.append("")
        out.append(f"`{rid}` · {quality(rid).title()}")
        out.append("")
        desc = clean_html(rule.get("description"))
        if desc:
            out += ["```", desc, "```", ""]
        for i in sorted(group, key=lambda x: (x["primaryLocation"]["filePath"],
                                              x["primaryLocation"].get("textRange", {}).get("startLine", 0)))[:args.max_per_rule]:
            out.append(f"- {location(i)}")
        if len(group) > args.max_per_rule:
            out.append(f"- … and {len(group) - args.max_per_rule} more (see the `zcs_export_sonarqube.json` in the build artifact)")
        out += ["", "</details>", ""]

    text = "\n".join(out) + "\n"
    if len(text.encode("utf-8")) > MAX_SUMMARY_BYTES:
        # drop the per-issue details if the summary would exceed the GitHub limit
        text = "\n".join(out[:out.index("### Details")]) + "\n\n_Details omitted: summary size limit reached._\n"
    print(text)


if __name__ == "__main__":
    main()
