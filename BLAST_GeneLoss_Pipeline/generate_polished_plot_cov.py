import pandas as pd
import matplotlib.pyplot as plt

# Load data from the new CSV
df = pd.read_csv("plgrkt_summary_cov.csv")
df = df.sort_values(by="Coverage", ascending=True)

# Color by gene status
color_map = {"Conserved": "#4CAF50", "Partial": "#FFC107", "Lost": "#F44336"}
colors = df["Status"].map(color_map)

plt.figure(figsize=(12, 7))
bars = plt.barh(df["Species"], df["%Identity"], color=colors)
plt.xlabel("Percent Identity", fontsize=12)
plt.title("PLGRKT Gene Status Across Bird Species", fontsize=16)
plt.grid(axis='x', linestyle='--', alpha=0.5)
plt.xlim(0, 100)

for bar in bars:
    width = bar.get_width()
    plt.text(width + 1, bar.get_y() + bar.get_height() / 2, f"{width:.1f}%", va="center", fontsize=10)

plt.tight_layout()
plt.savefig("PLGRKT_colored_barplot.png", dpi=300)
