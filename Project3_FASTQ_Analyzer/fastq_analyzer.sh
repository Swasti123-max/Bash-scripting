#!/bin/bash

# FASTQ Analyzer Script
# Usage: ./fastq_analyzer.sh input.fastq

input_file="$1"

if [[ ! -f "$input_file" ]]; then
    echo "Error: File '$input_file' not found!"
    exit 1
fi

echo "Analyzing FASTQ file: $input_file"

total_reads=0
total_gc=0
total_bases=0
quality_scores=0
quality_lines=0

while read -r header && read -r sequence && read -r plus && read -r quality
do
    ((total_reads++))
    
    # Count G and C
    gc_count=$(echo "$sequence" | grep -o '[GCgc]' | wc -l)
    base_count=${#sequence}
    ((total_gc += gc_count))
    ((total_bases += base_count))

    # Convert ASCII to Phred quality score (Sanger encoding, offset 33)
    for (( i=0; i<${#quality}; i++ )); do
        score=$(printf "%d" "'${quality:$i:1}")
        ((quality_scores += score - 33))
        ((quality_lines++))
    done

done < "$input_file"

avg_quality=$(echo "scale=2; $quality_scores / $quality_lines" | bc)
gc_percent=$(echo "scale=2; ($total_gc / $total_bases) * 100" | bc)

# Output summary
echo -e "\n--- Summary ---"
echo "Total Reads       : $total_reads"
echo "Total Bases       : $total_bases"
echo "GC Content (%)    : $gc_percent"
echo "Avg Quality Score : $avg_quality"

# Save to file
output_file="${input_file%.fastq}_summary.txt"
{
    echo "File: $input_file"
    echo "Total Reads: $total_reads"
    echo "Total Bases: $total_bases"
    echo "GC Content (%): $gc_percent"
    echo "Avg Quality Score: $avg_quality"
} > "$output_file"

echo -e "\nSaved summary to: $output_file"
