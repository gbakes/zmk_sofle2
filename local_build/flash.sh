#!/bin/bash
cd /Users/george.baker/Library/Mobile Documents/com~apple~CloudDocs/Documents/2. Projects/zmk_sofle2/local_build
sh download_artifact.sh
directory="/Volumes/NICENANO"

# Check if the directory exists
if [ -d "$directory" ]; then
    echo "Board in Bootloader mode at $directory."
else
    # Prompt the user to create the directory
    echo "Board not detected."
    echo "Removing .uf2 files.."
    rm *.uf2
    exit 1
fi

echo "Starting to flash first board"
sh load_firmware.sh
echo "Starting to flash second board"
sh load_firmware.sh
rm *.uf2
