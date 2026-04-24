#!/bin/bash

echo "========================================="
echo "安装 Qt Multimedia 依赖"
echo "========================================="
echo ""

# 检测 Linux 发行版
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "无法检测 Linux 发行版"
    exit 1
fi

echo "检测到系统: $OS"
echo ""

# 根据发行版安装
case $OS in
    ubuntu|debian)
        echo "安装 Qt6 Multimedia 和 GStreamer..."
        sudo apt-get update
        sudo apt-get install -y \
            qt6-multimedia-dev \
            libqt6multimedia6 \
            libqt6multimediawidgets6 \
            qml6-module-qtmultimedia \
            gstreamer1.0-tools \
            gstreamer1.0-plugins-base \
            gstreamer1.0-plugins-good \
            gstreamer1.0-plugins-bad \
            gstreamer1.0-plugins-ugly \
            gstreamer1.0-libav \
            gstreamer1.0-alsa \
            gstreamer1.0-pulseaudio \
            libgstreamer1.0-dev \
            libgstreamer-plugins-base1.0-dev
        ;;
    
    fedora|rhel|centos)
        echo "安装 Qt6 Multimedia 和 GStreamer..."
        sudo dnf install -y \
            qt6-qtmultimedia-devel \
            gstreamer1 \
            gstreamer1-plugins-base \
            gstreamer1-plugins-good \
            gstreamer1-plugins-bad-free \
            gstreamer1-plugins-ugly-free \
            gstreamer1-libav
        ;;
    
    arch|manjaro)
        echo "安装 Qt6 Multimedia 和 GStreamer..."
        sudo pacman -S --noconfirm \
            qt6-multimedia \
            gstreamer \
            gst-plugins-base \
            gst-plugins-good \
            gst-plugins-bad \
            gst-plugins-ugly \
            gst-libav
        ;;
    
    *)
        echo "不支持的发行版: $OS"
        echo "请手动安装 Qt6 Multimedia 和 GStreamer"
        exit 1
        ;;
esac

echo ""
echo "========================================="
echo "验证安装"
echo "========================================="
echo ""

# 验证 Qt Multimedia
echo "检查 Qt6 Multimedia QML 模块..."
QML_PATH=$(find /usr -name "QtMultimedia" -type d 2>/dev/null | grep qml | head -1)
if [ -n "$QML_PATH" ]; then
    echo "✓ 找到 QtMultimedia QML 模块: $QML_PATH"
else
    echo "✗ 未找到 QtMultimedia QML 模块"
    echo ""
    echo "可能需要设置 QML2_IMPORT_PATH:"
    echo "  export QML2_IMPORT_PATH=/usr/lib/x86_64-linux-gnu/qt6/qml"
fi

echo ""

# 验证 GStreamer
echo "检查 GStreamer..."
if command -v gst-inspect-1.0 &> /dev/null; then
    echo "✓ GStreamer 已安装"
    gst-inspect-1.0 --version | head -1
    
    # 检查 MP3 解码器
    if gst-inspect-1.0 mpg123audiodec &> /dev/null || gst-inspect-1.0 avdec_mp3 &> /dev/null; then
        echo "✓ MP3 解码器可用"
    else
        echo "✗ MP3 解码器不可用"
    fi
else
    echo "✗ GStreamer 未安装"
fi

echo ""
echo "========================================="
echo "下一步"
echo "========================================="
echo ""
echo "1. 重新构建项目:"
echo "   rm -rf build"
echo "   cmake -B build -S . -DCMAKE_BUILD_TYPE=Release"
echo "   cmake --build build"
echo ""
echo "2. 如果仍然找不到 QtMultimedia，设置环境变量:"
echo "   export QML2_IMPORT_PATH=/usr/lib/x86_64-linux-gnu/qt6/qml:/usr/lib/qt6/qml"
echo "   ./build/appCloudMusic"
echo ""
echo "3. 运行检查脚本验证:"
echo "   ./check_linux_audio.sh"
echo ""
