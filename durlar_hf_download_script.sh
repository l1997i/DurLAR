#!/bin/bash

################################################################################

# Dataset Downloader for DurLAR, Huggingface - (c) 2025 Li (Luis) Li, King's College London
# version v0.1.1 - 16 March, 2025

################################################################################

# === User Configuration (Modify as Needed) ===
HF_TOKEN="YOUR_HF_ACCESS_TOKEN"  # Set your Hugging Face access token
DOWNLOAD_DIR="$HOME/DurLAR_dataset"  # Directory to store downloaded .tar parts
EXTRACT_DIR="$HOME/DurLAR_extracted" # Directory where extracted dataset will be stored
CLEANUP_AFTER_EXTRACTION=true  # Set to true to delete .tar files after extraction, false to keep them

# === Fixed Configuration (No Need to Modify) ===
HF_DATASET_ID="l1997i/DurLAR"  # The dataset ID on Hugging Face

# === Create necessary directories ===
mkdir -p "$DOWNLOAD_DIR"
mkdir -p "$EXTRACT_DIR"

# === Authenticate with Hugging Face CLI ===
echo "Authenticating with Hugging Face..."
huggingface-cli login --token "$HF_TOKEN"
if [ $? -ne 0 ]; then
    echo "Hugging Face authentication failed. Please check your token."
    exit 1
fi
echo "Authentication successful!"

# === Download the dataset ===
echo "Downloading dataset to $DOWNLOAD_DIR..."
huggingface-cli download "$HF_DATASET_ID" --repo-type dataset --local-dir "$DOWNLOAD_DIR" --resume
if [ $? -ne 0 ]; then
    echo "Dataset download failed. Please check your access permissions."
    exit 1
fi
echo "Download completed!"

# === Merge tar parts into a single archive ===
echo "Merging .tar parts into a single archive..."
cd "$DOWNLOAD_DIR"
cat DurLAR_dataset.tar* > DurLAR_dataset.tar

# === Extract dataset using tar ===
echo "Extracting dataset to $EXTRACT_DIR..."
tar -xvf DurLAR_dataset.tar -C "$EXTRACT_DIR"
if [ $? -ne 0 ]; then
    echo "Extraction failed! Please check the downloaded files."
    exit 1
fi
echo "Extraction completed successfully!"

# === Cleanup downloaded .tar files if enabled ===
if [ "$CLEANUP_AFTER_EXTRACTION" = true ]; then
    echo "Cleaning up downloaded .tar files..."
    rm -f DurLAR_dataset.tar*
    echo "Cleanup completed!"
fi

# === Final Message ===
echo "Dataset is ready in: $EXTRACT_DIR"
