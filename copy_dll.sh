#!/bin/bash

# Script to copy all .dll files from bin to ../Assets/Plugins/x86_64
# This script should be placed in the SpotObserver-release directory

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

SOURCE_DIR="$SCRIPT_DIR/bin"
DEST_DIR="$SCRIPT_DIR/../Assets/Plugins/x86_64"

# Check if source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Source directory '$SOURCE_DIR' does not exist"
    exit 1
fi

# Create destination directory if it doesn't exist
mkdir -p "$DEST_DIR"

# Count .dll files
DLL_COUNT=$(find "$SOURCE_DIR" -maxdepth 1 -name "*.dll" -type f | wc -l)

if [ "$DLL_COUNT" -eq 0 ]; then
    echo "No .dll files found in $SOURCE_DIR"
    exit 0
fi

echo "Found $DLL_COUNT .dll file(s) in $SOURCE_DIR"
echo "Copying to $DEST_DIR..."

# Copy all .dll files
cp "$SOURCE_DIR"/*.dll "$DEST_DIR/" 2>/dev/null

if [ $? -eq 0 ]; then
    echo "Successfully copied $DLL_COUNT .dll file(s)"
else
    echo "Error: Failed to copy some files"
    exit 1
fi
