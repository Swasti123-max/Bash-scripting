import pandas as pd, glob, os

query_len = 1092          # length of duck PLGRKT CDS (adjust!)

rows = []
for f in glob.glob("blast_results/DUCK_PLGRKT_vs_*.txt"):
    sp = os.path.basename(f).split("_vs_")[1].rsplit(".",1)[0].replace("_"," ")
    df = pd.read_csv(f, sep="\t", header=None)
    if df.empty:
        rows.append((sp, 0, 0, "Lost"))
        continue
    best = df.iloc[0]
    ident = best[2]
    aln_len = best[3]
    cov = 100*aln_len/query_len
    if ident >= 90 and cov >= 80:
        status = "Conserved"
    elif ident >= 50 and cov >= 10:
        status = "Partial"
    else:
        status = "Lost"
    rows.append((sp, ident, cov, status))

pd.DataFrame(rows, columns=["Species","%Identity","Coverage","Status"])\
  .sort_values("Coverage")\
  .to_csv("plgrkt_summary_cov.csv", index=False)

