#!/bin/bash

echo "========================================="
echo "Linux 音频环境检查"
echo "========================================="
echo ""

# 1. 检查 GStreamer
echo "1. 检查 GStreamer..."
if command -v gst-inspect-1.0 &> /dev/null; then
    echo "   ✓ GStreamer 已安装"
    gst-inspect-1.0 --version | head -1
else
    echo "   ✗ GStreamer 未安装"
    echo "   安装命令: sudo apt-get install gstreamer1.0-tools gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly"
fi
echo ""

# 2. 检查 MP3 解码器
echo "2. 检查 MP3 解码器..."
if gst-inspect-1.0 mpg123audiodec &> /dev/null; then
    echo "   ✓ MP3 解码器可用 (mpg123)"
elif gst-inspect-1.0 avdec_mp3 &> /dev/null; then
    echo "   ✓ MP3 解码器可用 (libav)"
else
    echo "   ✗ MP3 解码器不可用"
    echo "   安装命令: sudo apt-get install gstreamer1.0-plugins-ugly gstreamer1.0-libav"
fi
echo ""

# 3. 检查音频输出插件
echo "3. 检查音频输出..."
if gst-inspect-1.0 autoaudiosink &> /dev/null; then
    echo "   ✓ autoaudiosink 可用"
else
    echo "   ✗ autoaudiosink 不可用"
fi

if gst-inspect-1.0 pulsesink &> /dev/null; then
    echo "   ✓ pulsesink 可用"
else
    echo "   ✗ pulsesink 不可用"
fi

if gst-inspect-1.0 alsasink &> /dev/null; then
    echo "   ✓ alsasink 可用"
else
    echo "   ✗ alsasink 不可用"
fi
echo ""

# 4. 检查 PulseAudio
echo "4. 检查音频服务器..."
if command -v pulseaudio &> /dev/null; then
    echo "   ✓ PulseAudio 已安装"
    if pulseaudio --check; then
        echo "   ✓ PulseAudio 正在运行"
    else
        echo "   ✗ PulseAudio 未运行"
        echo "   启动命令: pulseaudio --start"
    fi
elif command -v pipewire &> /dev/null; then
    echo "   ✓ PipeWire 已安装"
else
    echo "   ✗ 未找到音频服务器"
fi
echo ""

# 5. 检查音频设备
echo "5. 检查音频设备..."
if command -v aplay &> /dev/null; then
    echo "   可用的音频设备:"
    aplay -l | grep "^card" | head -5
else
    echo "   ✗ aplay 不可用"
fi
echo ""

# 6. 检查用户组
echo "6. 检查用户权限..."
if groups | grep -q audio; then
    echo "   ✓ 用户在 audio 组中"
else
    echo "   ✗ 用户不在 audio 组中"
    echo "   添加命令: sudo usermod -a -G audio $USER"
    echo "   (需要注销并重新登录)"
fi
echo ""

# 7. 测试 MP3 文件
echo "7. 测试 MP3 文件..."
if [ -f "src/resources/5156edu-2054-6162.mp3" ]; then
    echo "   ✓ MP3 文件存在"
    
    if command -v gst-play-1.0 &> /dev/null; then
        echo "   测试播放 (3秒)..."
        timeout 3 gst-play-1.0 src/resources/5156edu-2054-6162.mp3 &> /dev/null
        if [ $? -eq 124 ]; then
            echo "   ✓ 播放测试成功"
        else
            echo "   ✗ 播放测试失败"
        fi
    else
        echo "   ⚠ gst-play-1.0 不可用，跳过播放测试"
    fi
else
    echo "   ✗ MP3 文件不存在"
fi
echo ""

# 8. 检查 Qt Multimedia
echo "8. 检查 Qt Multimedia..."
APP_PATH=""
if [ -f "build/Desktop-Debug/appCloudMusic" ]; then
    APP_PATH="build/Desktop-Debug/appCloudMusic"
elif [ -f "build/appCloudMusic" ]; then
    APP_PATH="build/appCloudMusic"
elif [ -f "build/Desktop-Release/appCloudMusic" ]; then
    APP_PATH="build/Desktop-Release/appCloudMusic"
fi

if [ -n "$APP_PATH" ]; then
    echo "   ✓ 应用已构建: $APP_PATH"
    
    # 检查是否链接了 Qt6Multimedia
    if ldd "$APP_PATH" 2>/dev/null | grep -q Qt6Multimedia; then
        echo "   ✓ Qt6Multimedia 已链接"
    else
        echo "   ✗ Qt6Multimedia 未链接"
    fi
else
    echo "   ⚠ 应用未构建"
    echo "   构建命令: cmake --build build"
fi
echo ""

# 9. 建议
echo "========================================="
echo "建议操作:"
echo "========================================="

MISSING=0

if ! command -v gst-inspect-1.0 &> /dev/null; then
    echo "• 安装 GStreamer:"
    echo "  sudo apt-get install gstreamer1.0-tools gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-ugly gstreamer1.0-libav"
    MISSING=1
fi

if ! gst-inspect-1.0 mpg123audiodec &> /dev/null && ! gst-inspect-1.0 avdec_mp3 &> /dev/null; then
    echo "• 安装 MP3 解码器:"
    echo "  sudo apt-get install gstreamer1.0-plugins-ugly gstreamer1.0-libav"
    MISSING=1
fi

if ! groups | grep -q audio; then
    echo "• 添加用户到 audio 组:"
    echo "  sudo usermod -a -G audio $USER"
    echo "  然后注销并重新登录"
    MISSING=1
fi

if [ $MISSING -eq 0 ]; then
    echo "✓ 所有依赖都已满足！"
    echo ""
    echo "运行应用:"
    if [ -f "build/appCloudMusic" ]; then
        echo "  ./build/appCloudMusic"
    elif [ -f "build/Desktop-Release/appCloudMusic" ]; then
        echo "  ./build/Desktop-Release/appCloudMusic"
    else
        echo "  ./build/Desktop-Debug/appCloudMusic"
    fi
    echo ""
    echo "启用调试日志:"
    echo "  export GST_DEBUG=3"
    echo "  export QT_LOGGING_RULES=\"qt.multimedia*=true\""
    if [ -f "build/appCloudMusic" ]; then
        echo "  ./build/appCloudMusic"
    else
        echo "  ./build/Desktop-Release/appCloudMusic"
    fi
fi

echo ""
echo "========================================="
