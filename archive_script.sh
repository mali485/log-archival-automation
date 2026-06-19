#!/bin/bash
# ------------------------------------------------------------------
# Script Name:  archive_script.sh
# Description:  Automates log archival and storage optimization using Gzip
# Author:       Muhammad Ali
# ------------------------------------------------------------------

# --- Configuration ---
BASE_DIR="/home/ubuntu/archive_project"
ARCHIVE_DIR="/home/ubuntu/archive_project/archive"
DAYS=10
SIZE="20M"

# Step 1: Ensure the archive directory exists
if [ ! -d "$ARCHIVE_DIR" ]; then
    mkdir -p "$ARCHIVE_DIR"
fi
echo "Scanning for files..."

# Step 2: Search for files matching criteria (Older than 10 days OR larger than 20MB)
FILES_LIST=$(find "$BASE_DIR" -maxdepth 1 -type f \( -mtime +$DAYS -o -size +$SIZE \))

# Step 3: Error Handling - Check if any files were found
if [ -z "$FILES_LIST" ]; then
    echo "No files found matching the criteria. Execution stopped."
    exit 0
fi

# Step 4: Process matching files
echo "$FILES_LIST" | while read -r FILE; do
    echo "Processing: $FILE"
    gzip "$FILE"
    mv "$FILE.gz" "$ARCHIVE_DIR"
    echo "Successfully archived: $FILE.gz"
done

echo "Success! Archiving process completed."
