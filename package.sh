#!/bin/bash

# CloudMusic DMG Packaging Script
# Similar to KMP's ./gradlew :composeApp:packageDmg

set -e

echo "🎵 CloudMusic - Building and Packaging for macOS"
echo "================================================"

# Configuration
BUILD_DIR="build"
BUILD_TYPE="Release"

# Step 1: Configure CMake
echo ""
echo "📦 Step 1: Configuring CMake..."
cmake -B "$BUILD_DIR" -DCMAKE_BUILD_TYPE="$BUILD_TYPE"

# Step 2: Build the application
echo ""
echo "🔨 Step 2: Building application..."
cmake --build "$BUILD_DIR" --config "$BUILD_TYPE"

# Step 3: Deploy Qt dependencies
echo ""
echo "📚 Step 3: Deploying Qt dependencies..."
cmake --build "$BUILD_DIR" --target deploy

# Step 4: Create DMG
echo ""
echo "💿 Step 4: Creating DMG installer..."
cmake --build "$BUILD_DIR" --target packageDmg

echo ""
echo "✅ Done! DMG package created in: $BUILD_DIR/CloudMusic-0.1.dmg"
echo ""
echo "You can now install the app by:"
echo "  1. Opening the DMG file"
echo "  2. Dragging CloudMusic to Applications folder"
