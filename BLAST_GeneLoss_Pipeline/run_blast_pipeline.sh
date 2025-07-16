#!/bin/bash

#  STEP 1: User provides species name (e.g., "Geospiza fortis")
SPECIES_NAME="$1"

if [[ -z "$SPECIES_NAME" ]]; then
    echo "Please provide species name: ./run_pipeline.sh 'Geospiza fortis'"
    exit 1
fi

# 📁 Create folders if they don't exist
mkdir -p db blast_results blast_reports

# 📥 STEP 2: Download genome using entrez-direct
echo "🔍 Searching genome for: $SPECIES_NAME"
FTP_LINK=$(esearch -db assembly -query "$SPECIES_NAME[Organism]" | \
           efetch -format docsum | \
           xtract -pattern DocumentSummary -element FtpPath_RefSeq | head -n 1)

if [[ -z "$FTP_LINK" ]]; then
    echo "Genome FTP link not found for $SPECIES_NAME"
    exit 1
fi

# Construct genome filename
FNAME=$(basename "$FTP_LINK")
GENOME_GZ="${FNAME}_genomic.fna.gz"
GENOME_FNA="${FNAME}_genomic.fna"
GENOME_LOCAL="db/${SPECIES_NAME// /_}_genome.fna"

#  Download and unzip genome if not already there
if [[ ! -f "$GENOME_LOCAL" ]]; then
    echo "⬇️ Downloading genome..."
    wget "${FTP_LINK}/${GENOME_GZ}" -O "$GENOME_GZ"
    gunzip -c "$GENOME_GZ" > "$GENOME_LOCAL"
    rm "$GENOME_GZ"
else
    echo "✅ Genome already exists: $GENOME_LOCAL"
fi

# STEP 3: Run BLAST
QUERY="duck_query/PLGRKT_CDS.fasta"
BLAST_OUT="blast_results/DUCK_PLGRKT_vs_${SPECIES_NAME// /_}.txt"

echo " Running BLAST..."
blastn -query "$QUERY" -subject "$GENOME_LOCAL" -out "$BLAST_OUT" -outfmt 6

#  STEP 4: Generate HTML report using Python
REPORT_OUT="blast_reports/DUCK_PLGRKT_vs_${SPECIES_NAME// /_}.html"

echo "Generating HTML report..."
python3 make_html_report.py "$BLAST_OUT" "$REPORT_OUT"

echo "Done! Report saved at → $REPORT_OUT"
