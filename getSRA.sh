#!/bin/bash

# Path to the file containing BioProject IDs
bioprojects_file="PRJNA.txt"

# Function to download SRR accession
download_srr() {
    local acc="$1"
    local project="$2"
    
    echo "Downloading data for accession: $acc"
    
    # Prefetch the SRR accession
    prefetch "$acc" --max-size 100GB
    
    # Download the fastq data using fasterq-dump
    fasterq-dump "$acc" --split-files --skip-technical --threads 3 --outdir "./$project"
    pigz "${acc}_1.fastq" "${acc}_2.fastq"

    echo "Finished downloading data for accession: $acc"
}

# Loop through each BioProject ID in the file
while IFS= read -r project; do
    # Create a folder for the current BioProject
    mkdir -p "./$project"
    cd "./$project"
    echo "Created folder for BioProject: $project"

    # Fetch the list of SRR accession numbers for the current BioProject
    accessions=$(esearch -db sra -query "$project" | efetch -format runinfo | cut -d ',' -f 1 | grep SRR)
    echo "Fetched accessions for BioProject: $project"

    # Download data for each SRR accession in parallel
    for acc in $accessions; do
        download_srr "$acc" "$project" &
    done

    # Wait for all background processes to finish
    wait
    
    echo "Finished processing BioProject: $project"
done < "$bioprojects_file"

