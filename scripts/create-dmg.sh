#!/bin/bash

# Script to create a DMG installer for macOS
# Usage: ./create-dmg.sh <app-bundle-path> <output-dmg-path> <app-name>

set -e

APP_BUNDLE="$1"
OUTPUT_DMG="$2"
APP_NAME="$3"

if [ -z "$APP_BUNDLE" ] || [ -z "$OUTPUT_DMG" ] || [ -z "$APP_NAME" ]; then
    echo "Usage: $0 <app-bundle-path> <output-dmg-path> <app-name>"
    exit 1
fi

# Check if app bundle exists
if [ ! -d "$APP_BUNDLE" ]; then
    echo "Error: App bundle not found at $APP_BUNDLE"
    exit 1
fi

# Create temporary directory for DMG contents
TEMP_DIR=$(mktemp -d)
echo "Creating temporary directory: $TEMP_DIR"

# Copy app bundle to temp directory
echo "Copying app bundle..."
cp -R "$APP_BUNDLE" "$TEMP_DIR/"

# Create Applications symlink
echo "Creating Applications symlink..."
ln -s /Applications "$TEMP_DIR/Applications"

# Remove old DMG if exists
if [ -f "$OUTPUT_DMG" ]; then
    echo "Removing old DMG..."
    rm "$OUTPUT_DMG"
fi

# Create DMG
echo "Creating DMG..."
hdiutil create -volname "$APP_NAME" \
    -srcfolder "$TEMP_DIR" \
    -ov -format UDZO \
    "$OUTPUT_DMG"

# Clean up
echo "Cleaning up..."
rm -rf "$TEMP_DIR"

echo "DMG created successfully: $OUTPUT_DMG"
