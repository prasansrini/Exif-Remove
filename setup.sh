#!/bin/bash

if [ -f "output/exif" ]; then
    rm -rf output/exif || exit 1
fi

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo "Python is not installed. Please install Python from https://www.python.org/downloads/"
    exit 1
fi

# Check if pip is installed
if ! command -v pip3 &> /dev/null; then
    echo "Pip is not installed. Installing pip..."
    python3 -m ensurepip --upgrade
fi

# Install the required packages
pip3 install Pillow pyinstaller

# Run pyinstaller on exif.py
pyinstaller exif.py --log-level ERROR || exit 1

# Copy the output file to the desired location
if [ -f "dist/exif/exif" ]; then
    cp "dist/exif/exif" "output/exif" || exit 1
fi

# Remove the dist and build directories
rm -rf dist
rm -rf build

echo "Process complete."
