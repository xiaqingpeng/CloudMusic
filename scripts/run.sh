#!/bin/bash

# CloudMusic 快速启动脚本

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
BUILD_DIR="$PROJECT_ROOT/build"

echo "🎵 CloudMusic 启动脚本"
echo "======================="
echo ""

# 检查构建目录
if [ ! -d "$BUILD_DIR" ]; then
    echo "❌ 构建目录不存在，请先运行 scripts/build.sh"
    exit 1
fi

# 检查可执行文件
if [ ! -f "$BUILD_DIR/appCloudMusic.app/Contents/MacOS/appCloudMusic" ]; then
    echo "❌ 可执行文件不存在，请先运行 scripts/build.sh"
    exit 1
fi

echo "✅ 启动 CloudMusic..."
echo ""

# 运行应用程序
"$BUILD_DIR/appCloudMusic.app/Contents/MacOS/appCloudMusic"
