#!/bin/bash

# Step 1: Create output folder
mkdir -p duck_query

# Step 2: Define gene and organism
GENE="PLGRKT"
ORGANISM="Anas platyrhynchos"

echo " Downloading CDS FASTA for $GENE in $ORGANISM..."

# Step 3: Search and download
esearch -db nucleotide -query "${GENE}[Gene] AND ${ORGANISM}[Organism] AND cds" |
  efetch -format fasta_cds_na > "duck_query/${GENE}_CDS.fasta"

# Step 4: Check and confirm
if [[ -s "duck_query/${GENE}_CDS.fasta" ]]; then
    echo "Download complete: duck_query/${GENE}_CDS.fasta"
else
    echo " No CDS FASTA found for ${GENE} in ${ORGANISM}."
fi
