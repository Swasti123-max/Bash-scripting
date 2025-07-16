!/bin/bash
read -p "Enter your sequence:" name     #inputs sequence
total=$(echo "$name" | grep -o '[ATGCN]' | wc -l)    #Counts the entire sequence
number=$(echo "$name" | grep -o '[CG]' | wc -l)      #Counts G and C
echo "Total number of nucleotides: $total"
echo "Number of G and C bases: $number"
percen=$(echo "scale=2; ($number/$total) " | bc)     #calculates GC fraction and assigns two decimal places (using scale)
percent=$(echo "$percen*100" | bc)                   #calculates percentage of GC
echo "GC content: $percent%"
