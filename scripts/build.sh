#!/bin/bash

# CloudMusic 构建脚本

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"
BUILD_DIR="$PROJECT_ROOT/build"

echo "🎵 CloudMusic 构建脚本"
echo "======================="
echo ""

# 解析参数
BUILD_TYPE="Release"
CLEAN_BUILD=false
BUILD_TESTS=false
BUILD_DOCS=false

while [[ $# -gt 0 ]]; do
    case $1 in
        --debug)
            BUILD_TYPE="Debug"
            shift
            ;;
        --clean)
            CLEAN_BUILD=true
            shift
            ;;
        --tests)
            BUILD_TESTS=true
            shift
            ;;
        --docs)
            BUILD_DOCS=true
            shift
            ;;
        --help)
            echo "用法: $0 [选项]"
            echo ""
            echo "选项:"
            echo "  --debug     Debug 构建（默认 Release）"
            echo "  --clean     清理构建目录"
            echo "  --tests     启用测试"
            echo "  --docs      启用文档生成"
            echo "  --help      显示帮助信息"
            exit 0
            ;;
        *)
            echo "❌ 未知选项: $1"
            echo "使用 --help 查看帮助"
            exit 1
            ;;
    esac
done

# 清理构建目录
if [ "$CLEAN_BUILD" = true ]; then
    echo "🧹 清理构建目录..."
    rm -rf "$BUILD_DIR"
fi

# 创建构建目录
if [ ! -d "$BUILD_DIR" ]; then
    echo "📁 创建构建目录..."
    mkdir -p "$BUILD_DIR"
fi

# 进入构建目录
cd "$BUILD_DIR"

# 配置 CMake 选项
CMAKE_OPTIONS="-DCMAKE_BUILD_TYPE=$BUILD_TYPE"

if [ "$BUILD_TESTS" = true ]; then
    CMAKE_OPTIONS="$CMAKE_OPTIONS -DBUILD_TESTS=ON"
fi

if [ "$BUILD_DOCS" = true ]; then
    CMAKE_OPTIONS="$CMAKE_OPTIONS -DBUILD_DOCS=ON"
fi

echo "⚙️  配置项目..."
echo "   构建类型: $BUILD_TYPE"
echo "   测试: $([ "$BUILD_TESTS" = true ] && echo "启用" || echo "禁用")"
echo "   文档: $([ "$BUILD_DOCS" = true ] && echo "启用" || echo "禁用")"
echo ""

cmake $CMAKE_OPTIONS ..

echo ""
echo "🔨 编译项目..."
echo ""

cmake --build . --config $BUILD_TYPE

echo ""
echo "✅ 构建完成！"
echo ""
echo "运行应用程序:"
echo "  ./appCloudMusic.app/Contents/MacOS/appCloudMusic"
echo ""
echo "或使用快速启动脚本:"
echo "  $SCRIPT_DIR/run.sh"
