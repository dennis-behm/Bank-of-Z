#!/usr/bin/env python3
"""Merge multiple Cobertura XML reports into a single report.

Usage: merge-cobertura.py <input-dir> <output-file> [--pattern GLOB]

All files matching GLOB (default: *CCCOBERTURA.xml) below <input-dir> are merged.
Hits are summed per file name and line number, so a line counts as covered if
the summed hits are above 0.
"""
import argparse
import glob
import sys
import xml.etree.ElementTree as ET


def main():
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("input_dir")
    parser.add_argument("output_file")
    parser.add_argument("--pattern", default="*CCCOBERTURA.xml")
    args = parser.parse_args()

    files = glob.glob(f"{args.input_dir}/**/{args.pattern}", recursive=True)
    if not files:
        sys.exit("No Cobertura report found")
    print(f"Merging {len(files)} Cobertura report(s)")

    hits = {}  # filename -> {line number: summed hits}
    for f in files:
        for c in ET.parse(f).getroot().iter("class"):
            d = hits.setdefault(c.get("filename"), {})
            for line in c.iter("line"):
                n, h = int(line.get("number")), int(line.get("hits"))
                d[n] = d.get(n, 0) + h

    tot_c = tot_v = 0
    root = ET.Element("coverage", {"version": "1", "timestamp": "0", "branch-rate": "0",
                                   "branches-covered": "0", "branches-valid": "0", "complexity": "0"})
    ET.SubElement(ET.SubElement(root, "sources"), "source").text = "."
    package = ET.SubElement(ET.SubElement(root, "packages"), "package", name="")
    classes = ET.SubElement(package, "classes")
    for fn, d in sorted(hits.items()):
        cov = sum(1 for h in d.values() if h > 0)
        tot_c += cov
        tot_v += len(d)
        c = ET.SubElement(classes, "class", name=fn, filename=fn,
                          **{"line-rate": str(cov / len(d) if d else 0)})
        ET.SubElement(c, "methods")
        ls = ET.SubElement(c, "lines")
        for n in sorted(d):
            ET.SubElement(ls, "line", number=str(n), hits=str(d[n]))

    rate = str(tot_c / tot_v if tot_v else 0)
    package.set("line-rate", rate)
    root.set("line-rate", rate)
    root.set("lines-covered", str(tot_c))
    root.set("lines-valid", str(tot_v))
    ET.ElementTree(root).write(args.output_file, xml_declaration=True, encoding="UTF-8")


if __name__ == "__main__":
    main()
