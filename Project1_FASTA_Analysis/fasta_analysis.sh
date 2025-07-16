root@DESKTOP-DOHB37O:~# cd /mnt/c/Users/Swasti/OneDrive/Desktop/fasta\ files
root@DESKTOP-DOHB37O:/mnt/c/Users/Swasti/OneDrive/Desktop/fasta files# ls
 fasta.sh  'sequence (3).fasta'  'sequence (4).fasta'  'sequence (5).fasta'
root@DESKTOP-DOHB37O:/mnt/c/Users/Swasti/OneDrive/Desktop/fasta files# vi fasta.sh


#!/bin/bash #shebang line tells the system to use the bash shell to run this script

for file in *.fasta; do #this a starts for loop that goes through each file in the current directoru ending with.fasta and file is the variable that will hold each filename one by one
    echo "==============================" #prints a visual separator for clarity in the output
    echo "File: $file" #displays the name of the current file that is going to be processd

    # Count how many sequences (lines starting with ">")
    seq_count=$(grep -c "^>" "$file") #uses grep -c "^>" to count how many lines start with > in the file

    # Count all base characters (excluding headers and newlines)
    base_count=$(grep -v "^>" "$file" | tr -d '\n' | wc -c) #grep -v "^>" "$file" removes all the header line those starting with > tr -d '\n' deletes all the newline characters to make it a continous string and wc -c counts the humber of characters, which gives the total number of base pairs this basically tells us how many A,T,G,C are present in total

    # Avoid division by zero
    if [ "$seq_count" -eq 0 ]; then #if there are no sequences(zero headers), we set the average length to 0
        average=0
    else
        average=$(echo "$base_count / $seq_count" | bc)
    fi #else if there are sequences, calculate the average length by dividing total bases by number of sequences. bc is a calculator tool in linux

    echo "Number of sequences: $seq_count"
    echo "Total base pairs: $base_count"
    echo "Average length: $average"
    echo "=============================="
done


~                                                                           ~
:wq
root@DESKTOP-DOHB37O:/mnt/c/Users/Swasti/OneDrive/Desktop/fasta files# chmod + fasta.sh
root@DESKTOP-DOHB37O:/mnt/c/Users/Swasti/OneDrive/Desktop/fasta files# ./fasta.sh
