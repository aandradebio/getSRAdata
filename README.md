# SRA Data Downloader

This script automates the process of downloading data from the Sequence Read Archive (SRA) based on a list of BioProject IDs.

## Usage

1. Ensure you have the necessary tools installed: `prefetch`, `fasterq-dump`, `pigz`.
2. Create a file named `PRJNA.txt` containing BioProject IDs, with each ID on a new line.
3. Run the script using the following command:

    ```bash
    ./download_data.sh
    ```

## Script Overview

The script performs the following steps:

- Reads BioProject IDs from a file (`PRJNA.txt`).
- Creates a folder for each BioProject.
- Fetches SRR accession numbers for each BioProject.
- Downloads data for each SRR accession in parallel, using `prefetch`, `fasterq-dump`, and `pigz`.

## Requirements

- [prefetch](https://trace.ncbi.nlm.nih.gov/Traces/sra/sra.cgi?view=software)
- [fasterq-dump](https://github.com/ncbi/sra-tools/wiki/HowTo:-fasterq-dump)
- [pigz](https://zlib.net/pigz/)

## Notes

- The script assumes that you have the required tools installed and configured.
- The data will be downloaded to the same directory where the script is executed.

Feel free to customize the script and this README according to your specific needs.

## Author
Amanda Araújo Serrão de Andrade
aandradebio@gmail.com

Feel free to contact me, open an issue, or a pull request.
