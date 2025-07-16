#!bin/bash
head -n 1 "sequence (1).fasta" | grep "^>"
Used grep to filter out all lines beginning with >.
grep -v "^>" "sequence (1).fasta"
Removed all newline characters using tr to convert the multi-line sequence into a single line.
grep -v "^>" "sequence (1).fasta" | tr -d '\n' > sequence_single_line.txt
Here is full code:-
root@DESKTOP-DOHB37O:/mnt/c/users/swasti# vi sequence_file.sh
#!/bin/bash
# Check if the first line is a FASTA header
head -n 1 "/mnt/c/Users/Swasti/Downloads/sequence (1).fasta" | grep "^>"
# Remove headers and join sequence lines into one line, save to new file
grep -v "^>" "/mnt/c/Users/Swasti/Downloads/sequence (1).fasta" | tr -d '\n' > "/mnt/c/Users/Swasti/Downloads/sequence_single_line.txt"
root@DESKTOP-DOHB37O:/mnt/c/users/swasti# chmod +x sequence_file.sh
root@DESKTOP-DOHB37O:/mnt/c/users/swasti# ./sequence_file.sh
>PUHP01001126.1 Colletotrichum shisoi strain PG-2018a scaffold842, whole genome shotgun sequence
