#!/bin/bash

# Script to convert PNG to macOS ICNS icon
# Usage: ./create-icns-from-png.sh <input-png> <output-icns>

set -e

INPUT_PNG="$1"
OUTPUT_ICNS="$2"

if [ -z "$INPUT_PNG" ] || [ -z "$OUTPUT_ICNS" ]; then
    echo "Usage: $0 <input-png> <output-icns>"
    exit 1
fi

if [ ! -f "$INPUT_PNG" ]; then
    echo "Error: Input PNG file not found: $INPUT_PNG"
    exit 1
fi

# Check input image size
INPUT_SIZE=$(sips -g pixelWidth "$INPUT_PNG" | tail -n1 | awk '{print $2}')
echo "Input image size: ${INPUT_SIZE}x${INPUT_SIZE}"

if [ "$INPUT_SIZE" -lt 512 ]; then
    echo "⚠️  WARNING: Input image is too small (${INPUT_SIZE}x${INPUT_SIZE})"
    echo "   For best quality, use at least 1024x1024 pixels"
    echo "   Current image will be upscaled, which may look blurry"
fi

# Create temporary directory for icon generation
TEMP_DIR=$(mktemp -d)
ICONSET_DIR="$TEMP_DIR/AppIcon.iconset"
mkdir -p "$ICONSET_DIR"

echo "Converting PNG to ICNS..."
echo "Input: $INPUT_PNG"
echo "Output: $OUTPUT_ICNS"

# If input is small, create a larger base image first
if [ "$INPUT_SIZE" -lt 1024 ]; then
    BASE_IMAGE="$TEMP_DIR/base_1024.png"
    sips -z 1024 1024 "$INPUT_PNG" --out "$BASE_IMAGE" > /dev/null 2>&1
    echo "Upscaled to 1024x1024 (may reduce quality)"
else
    BASE_IMAGE="$INPUT_PNG"
fi

# Generate PNG files at different sizes using sips
SIZES=(16 32 128 256 512)

for SIZE in "${SIZES[@]}"; do
    sips -z $SIZE $SIZE "$BASE_IMAGE" --out "$ICONSET_DIR/icon_${SIZE}x${SIZE}.png" > /dev/null 2>&1
    
    # Create @2x versions for Retina displays
    if [ $SIZE -le 512 ]; then
        SIZE2=$((SIZE * 2))
        sips -z $SIZE2 $SIZE2 "$BASE_IMAGE" --out "$ICONSET_DIR/icon_${SIZE}x${SIZE}@2x.png" > /dev/null 2>&1
    fi
done

# Create ICNS file
echo "Creating ICNS file..."
iconutil -c icns "$ICONSET_DIR" -o "$OUTPUT_ICNS"

# Clean up
rm -rf "$TEMP_DIR"

if [ "$INPUT_SIZE" -lt 512 ]; then
    echo "⚠️  Icon created but may appear blurry due to small source image"
    echo "   Recommendation: Replace resources/image/appicon.png with a 1024x1024 version"
else
    echo "✅ ICNS file created: $OUTPUT_ICNS"
fi
