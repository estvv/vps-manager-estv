#!/bin/bash

URL="https://raw.githubusercontent.com/estvv/vps-manager-estv/main/Makefile"
DEST="$HOME/Makefile"

echo "Downloading the latest Makefile from GitHub..."

if curl -s -f -o "$DEST" "$URL"; then
    echo "Main Makefile updated successfully!"
else
    echo "Error: Unable to download the Makefile. Check the URL."
    exit 1
fi
