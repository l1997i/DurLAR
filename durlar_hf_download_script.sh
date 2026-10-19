#!/bin/bash

################################################################################

# Dataset Downloader for DurLAR, Huggingface - (c) 2025 Li (Luis) Li, King's College London
# version v0.1.2 - updated for the new `hf` CLI (huggingface_hub >= 0.34)

################################################################################

set -o pipefail  # Make pipelines fail if any stage fails (e.g. cat | tar)

# === User Configuration (Modify as Needed) ===
DOWNLOAD_DIR="$HOME/DurLAR_dataset"  # Directory to store downloaded .tar parts
EXTRACT_DIR="$HOME/DurLAR_extracted" # Directory where extracted dataset will be stored
CLEANUP_AFTER_EXTRACTION=true  # Set to true to delete .tar files after extraction, false to keep them

# === Fixed Configuration (No Need to Modify) ===
HF_DATASET_ID="l1997i/DurLAR"  # The dataset ID on Hugging Face

# === Check dependencies ===
if ! command -v hf >/dev/null 2>&1; then
    echo "The 'hf' CLI was not found."
    echo "Install or upgrade it with:  pip install -U \"huggingface_hub[cli]\""
    exit 1
fi
if ! command -v pigz >/dev/null 2>&1; then
    echo "'pigz' was not found. Please install it (e.g. 'sudo apt install pigz')."
    exit 1
fi

# === Display the Configuration ===
echo "====================================="
echo " DurLAR Dataset Download Configuration"
echo "====================================="
echo "Dataset ID                 : $HF_DATASET_ID"
echo "Download Directory         : $DOWNLOAD_DIR"
echo "Extraction Directory       : $EXTRACT_DIR"
echo "Cleanup After Extraction   : $CLEANUP_AFTER_EXTRACTION"
echo "====================================="

# === Check authentication (DurLAR is a gated dataset) ===
if ! hf auth whoami >/dev/null 2>&1; then
    echo "You are not logged in to Hugging Face."
    echo "Run 'hf auth login' (or set the HF_TOKEN environment variable) and try again."
    exit 1
fi

# === Create necessary directories ===
mkdir -p "$DOWNLOAD_DIR"
mkdir -p "$EXTRACT_DIR"

# === Download the dataset ===
# Note: resuming interrupted downloads is automatic in the new CLI, so --resume is no longer needed.
echo "Downloading dataset to $DOWNLOAD_DIR..."
if ! hf download "$HF_DATASET_ID" --repo-type dataset --local-dir "$DOWNLOAD_DIR"; then
    echo "Dataset download failed. Please check your access permissions."
    exit 1
fi
echo "Download completed!"

# === Stream all parts into tar, extracting on the fly ===
cd "$DOWNLOAD_DIR" || exit 1
echo "Streaming .tar parts directly to extractor..."
if ! cat DurLAR_dataset.tar* | tar --use-compress-program="pigz -p $(nproc) -d" -xvf - -C "$EXTRACT_DIR"; then
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
