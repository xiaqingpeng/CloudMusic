#!/bin/bash

# QML 性能分析脚本

# 自动查找构建目录
if [ -d "build/unknown-Debug/appCloudMusic.app" ]; then
    APP_PATH="build/unknown-Debug/appCloudMusic.app/Contents/MacOS/appCloudMusic"
elif [ -d "build/appCloudMusic.app" ]; then
    APP_PATH="build/appCloudMusic.app/Contents/MacOS/appCloudMusic"
else
    echo "❌ 找不到应用程序，请先构建项目"
    echo "提示：运行 cmake --build build"
    exit 1
fi

echo "🔍 启动 QML 性能分析..."
echo "📱 应用路径: $APP_PATH"
echo ""

# 设置性能分析环境变量
export QSG_RENDER_LOOP=basic
export QSG_INFO=1
export QT_LOGGING_RULES="qt.qml.binding.removal.info=true"

# 启动应用并启用 QML Profiler
echo "📊 性能分析选项："
echo "  1. 基础性能监控（直接运行）"
echo "  2. 渲染性能分析 - 过度绘制（直接运行）"
echo "  3. 渲染性能分析 - 批次（直接运行）"
echo "  4. 内存分配跟踪（直接运行）"
echo "  5. 等待 Qt Creator 连接（用于 QML Profiler）"
echo ""
read -p "选择分析模式 (1-5): " choice

case $choice in
    1)
        echo "启动基础性能监控..."
        echo "💡 查看终端输出的性能数据"
        ./${APP_PATH}
        ;;
    2)
        echo "启动渲染性能分析（过度绘制）..."
        echo "💡 红色区域 = 过度绘制严重"
        export QSG_VISUALIZE=overdraw
        ./${APP_PATH}
        ;;
    3)
        echo "启动渲染性能分析（批次）..."
        echo "💡 查看渲染批次数量和合并情况"
        export QSG_VISUALIZE=batches
        ./${APP_PATH}
        ;;
    4)
        echo "启动内存分配跟踪..."
        echo "💡 查看终端输出的内存统计"
        export QV4_MM_STATS=1
        export QSG_RENDER_TIMING=1
        ./${APP_PATH}
        ;;
    5)
        echo "等待 Qt Creator 连接..."
        echo "💡 在 Qt Creator 中点击 Analyze → QML Profiler"
        echo "💡 应用会在连接后启动"
        ./${APP_PATH} -qmljsdebugger=port:3768,block
        ;;
    *)
        echo "无效选择"
        exit 1
        ;;
esac
