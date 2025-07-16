#!/usr/bin/env python3
"""
make_html_report.py
Convert a BLAST tabular file (outfmt 6) into a full‑length, nicely‑styled
HTML table.

Usage
-----
    # activate your virtual‑env if you have one
    python3 make_html_report.py
"""
import sys
import pandas as pd
from pathlib import Path

BLAST_TXT = sys.argv[1]            # Take input from command line
HTML_REPORT = sys.argv[2]          # Take output file from command line


# ──── EDIT ONLY THESE TWO LINES FOR EACH NEW COMPARISON ────── #
# ──── EDIT ONLY THESE TWO LINES FOR EACH NEW COMPARISON ────── #

# ───────────────────────────────────────────────────────────── #

# ───────────────────────────────────────────────────────────── #

# Ensure output folder exists
Path(HTML_REPORT).parent.mkdir(exist_ok=True)

# Column names for BLAST outfmt 6
COLUMNS = [
    "Query ID", "Subject ID", "% Identity", "Alignment Length",
    "Mismatches", "Gap Opens", "Q. Start", "Q. End",
    "S. Start", "S. End", "E‑value", "Bit Score"
]

# Load BLAST file
df = pd.read_csv(BLAST_TXT, sep="\t", header=None, names=COLUMNS)

# Build HTML
html = f"""<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>BLAST Report – {Path(BLAST_TXT).stem}</title>
  <style>
    body  {{ font-family: Arial, sans-serif; padding: 30px; background:#f7f7f7; }}
    h1    {{ color:#2c3e50; }}
    table {{ border-collapse:collapse; width:100%; background:#fff; }}
    th,td {{ border:1px solid #ddd; padding:8px 10px; text-align:center; }}
    th    {{ background:#3498db; color:#fff; }}
    tr:nth-child(even) {{ background:#f2f2f2; }}
  </style>
</head>
<body>
  <h1>🧬 BLAST Report – {Path(BLAST_TXT).stem}</h1>
  {df.to_html(index=False, escape=False)}
</body>
</html>"""

# Write file
with open(HTML_REPORT, "w") as fh:
    fh.write(html)

print(f"✅ HTML report created → {HTML_REPORT}")


