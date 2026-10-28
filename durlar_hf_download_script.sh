#!/bin/bash

################################################################################

# Dataset Downloader for DurLAR, Huggingface - (c) 2025 Li (Luis) Li, King's College London
# version v0.1.2 - updated for the new `hf` CLI (tested with huggingface_hub 2.3.0)

################################################################################

# `set -o pipefail` below is bash-only; dash aborts on it with "Illegal option".
if [ -z "${BASH_VERSION:-}" ]; then
    echo "This script requires bash. Run it with:  bash $0"
    exit 1
fi

set -o pipefail  # Make pipelines fail if any stage fails (e.g. cat | tar)

# === User Configuration (Modify as Needed) ===
DOWNLOAD_DIR="$HOME/DurLAR_dataset"  # Directory to store downloaded .tar parts
EXTRACT_DIR="$HOME/DurLAR_extracted" # Directory where extracted dataset will be stored
CLEANUP_AFTER_EXTRACTION=true  # Set to true to delete .tar files after extraction, false to keep them

# === Fixed Configuration (No Need to Modify) ===
HF_DATASET_ID="l1997i/DurLAR"  # The dataset ID on Hugging Face
EXPECTED_PARTS=400  # DurLAR_dataset.taraa ... DurLAR_dataset.tarpj at dataset revision 2787ba6

# === Check dependencies ===
if ! command -v hf >/dev/null 2>&1; then
    echo "The 'hf' CLI was not found."
    echo "Install or upgrade it with:  pip install -U huggingface_hub"
    exit 1
fi
if ! command -v pigz >/dev/null 2>&1; then
    echo "'pigz' was not found. Please install it (e.g. 'sudo apt install pigz')."
    exit 1
fi
NPROC=$(nproc 2>/dev/null || sysctl -n hw.ncpu 2>/dev/null || echo 4)  # nproc is missing on macOS

# === Display the Configuration ===
echo "====================================="
echo " DurLAR Dataset Download Configuration"
echo "====================================="
echo "Dataset ID                 : $HF_DATASET_ID"
echo "Download Directory         : $DOWNLOAD_DIR"
echo "Extraction Directory       : $EXTRACT_DIR"
echo "Cleanup After Extraction   : $CLEANUP_AFTER_EXTRACTION"
echo "====================================="

# === Check authentication (informational only) ===
# The dataset can currently be downloaded anonymously, so a missing login is not fatal.
# Older huggingface_hub releases (< 1.9) print "Not logged in" but exit 0, hence the grep.
if whoami_out=$(hf auth whoami 2>&1) && ! printf '%s\n' "$whoami_out" | grep -qi 'not logged in'; then
    echo "Hugging Face login detected."
else
    echo "Note: no working Hugging Face login detected; downloading anonymously (lower rate limits)."
    echo "      Run 'hf auth login' or set HF_TOKEN if the download fails with an access error."
fi

# === Create necessary directories ===
mkdir -p "$DOWNLOAD_DIR"
mkdir -p "$EXTRACT_DIR"

# === Download the dataset ===
# Re-running the script skips parts that are already complete.
# A part that was interrupted is downloaded again from the start.
echo "Downloading dataset to $DOWNLOAD_DIR..."
if ! hf download "$HF_DATASET_ID" --repo-type dataset --local-dir "$DOWNLOAD_DIR"; then
    echo "Dataset download failed (see the error above). Re-run the script to resume."
    exit 1
fi
echo "Download completed!"

cd "$DOWNLOAD_DIR" || exit 1

# === Check that every part is present ===
# hf may exit 0 without downloading anything when the Hub is unreachable and the
# local dir is not empty (huggingface_hub < 1.22), so count the parts ourselves.
shopt -s nullglob
PARTS=(DurLAR_dataset.tar[a-z][a-z])  # split(1) suffixes only, so stray files cannot match
shopt -u nullglob
if [ "${#PARTS[@]}" -ne "$EXPECTED_PARTS" ]; then
    echo "Expected $EXPECTED_PARTS archive parts in $DOWNLOAD_DIR, found ${#PARTS[@]}."
    echo "The download is incomplete. Re-run the script to resume it."
    exit 1
fi

# === Stream all parts into tar, extracting on the fly ===
echo "Streaming .tar parts directly to extractor..."
if ! cat "${PARTS[@]}" | tar --use-compress-program="pigz -p $NPROC -d" -xvf - -C "$EXTRACT_DIR"; then
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
    rm -f "${PARTS[@]}"
    echo "Cleanup completed!"
fi

# === Final Message ===
echo "Dataset is ready in: $EXTRACT_DIR"
