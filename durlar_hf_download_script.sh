#!/bin/bash

################################################################################

# Dataset Downloader for DurLAR, Huggingface - (c) 2025 Li (Luis) Li, King's College London
# version v0.1.1 - 16 March, 2025

################################################################################

# === User Configuration (Modify as Needed) ===
DOWNLOAD_DIR="$HOME/DurLAR_dataset"  # Directory to store downloaded .tar parts
EXTRACT_DIR="$HOME/DurLAR_extracted" # Directory where extracted dataset will be stored
CLEANUP_AFTER_EXTRACTION=true  # Set to true to delete .tar files after extraction, false to keep them

# === Fixed Configuration (No Need to Modify) ===
HF_DATASET_ID="l1997i/DurLAR"  # The dataset ID on Hugging Face

# === Display the Configuration ===
echo "====================================="
echo " DurLAR Dataset Download Configuration"
echo "====================================="
echo "Dataset ID                 : $HF_DATASET_ID"
echo "Download Directory         : $DOWNLOAD_DIR"
echo "Extraction Directory       : $EXTRACT_DIR"
echo "Cleanup After Extraction   : $CLEANUP_AFTER_EXTRACTION"
echo "====================================="

# === Create necessary directories ===
mkdir -p "$DOWNLOAD_DIR"
mkdir -p "$EXTRACT_DIR"

# === Download the dataset ===
echo "Downloading dataset to $DOWNLOAD_DIR..."
huggingface-cli download "$HF_DATASET_ID" --repo-type dataset --local-dir "$DOWNLOAD_DIR" --resume
if [ $? -ne 0 ]; then
    echo "Dataset download failed. Please check your access permissions."
    exit 1
fi
echo "Download completed!"

# === Stream all parts into tar, extracting on the fly 
cd "$DOWNLOAD_DIR" || exit 1
echo "Streaming .tar parts directly to extractor..."
cat DurLAR_dataset.tar* | tar --use-compress-program="pigz -p $(nproc) -d" -xvf - -C "$EXTRACT_DIR"
if [ $? -ne 0 ]; then
    echo "Extraction failed! Please check the downloaded files."
    exit 1
fi
echo "Extraction completed successfully!"

# === Fixing directory structure ===
UNNECESSARY_DIR="$EXTRACT_DIR/home2/mznv82/dataset/DurLAR/dataset/DurLAR_raw"
if [ -d "$UNNECESSARY_DIR" ]; then
    echo "Fixing folder structure..."
    mv "$UNNECESSARY_DIR"/* "$EXTRACT_DIR"/  # Move contents to target directory
    rm -rf "$EXTRACT_DIR/home2"  # Remove unnecessary hierarchy
fi

# === Cleanup downloaded .tar files if enabled ===
if [ "$CLEANUP_AFTER_EXTRACTION" = true ]; then
    echo "Cleaning up downloaded .tar files..."
    rm -f DurLAR_dataset.tar*
    echo "Cleanup completed!"
fi

# === Final Message ===
echo "Dataset is ready in: $EXTRACT_DIR"
