#!/bin/bash

directory="/Volumes/NICENANO"

echo "Waiting for board to enter bootloader mode"

while [ ! -d "$directory" ]; do
    sleep 1  # Adjust the sleep duration based on your needs
done

echo "Board detected."

# Prompt 
read -p "Which side is connected? (left/right): " user_input

# Convert the input to lowercase for case-insensitive comparison
user_input_lower=$(echo "$user_input" | tr '[:upper:]' '[:lower:]')

# Source directory
source_directory=$(pwd)

# Extension to search for
file_extension=".uf2"

# Check the user's input
case "$user_input_lower" in
    left|l)
        echo "left side chosen"

        left_firmware_file=$(ls *left*"$file_extension" | head -n 1)

        if [ -n "$left_firmware_file" ]; then
            echo "Flashing file: $left_firmware_file"
            mv $left_firmware_file $directory
        else
            echo "No matching file found with extension '$file_extension'"
            exit 1
        fi
        ;;
    right|r)
         echo "right side chosen"

        right_firmware_file=$(ls *right*"$file_extension" | head -n 1)

        if [ -n "$right_firmware_file" ]; then
            echo "Flashing file: $right_firmware_file"
            mv $right_firmware_file $directory
        else
            echo "No matching file found with extension '$file_extension'"
            exit 1
        fi
        ;;
    *)
        echo "Invalid input. Please enter 'yes' or 'no'."
        ;;
esac
