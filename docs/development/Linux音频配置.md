# Linux 音频配置指南

## 系统要求

### 1. 检查 GStreamer 安装

Qt Multimedia 在 Linux 上依赖 GStreamer。检查是否已安装：

```bash
# 检查 GStreamer 版本
gst-inspect-1.0 --version

# 检查必需的插件
gst-inspect-1.0 playbin
gst-inspect-1.0 autoaudiosink
gst-inspect-1.0 mpg123audiodec  # MP3 解码器
```

### 2. 安装必需的包

如果缺少组件，安装以下包：

#### Ubuntu/Debian
```bash
sudo apt-get update
sudo apt-get install -y \
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
```

#### Fedora/RHEL
```bash
sudo dnf install -y \
    gstreamer1 \
    gstreamer1-plugins-base \
    gstreamer1-plugins-good \
    gstreamer1-plugins-bad-free \
    gstreamer1-plugins-ugly-free \
    gstreamer1-libav
```

### 3. 检查音频系统

```bash
# 检查 PulseAudio
pulseaudio --check
pulseaudio --version

# 或检查 PipeWire（较新的系统）
pactl info

# 列出音频输出设备
pactl list sinks short
```

## 测试音频

### 1. 测试系统音频
```bash
# 使用 speaker-test
speaker-test -t wav -c 2

# 使用 aplay
aplay /usr/share/sounds/alsa/Front_Center.wav
```

### 2. 测试 MP3 文件
```bash
# 使用 GStreamer 直接播放
gst-play-1.0 src/resources/5156edu-2054-6162.mp3

# 或使用 mpg123
mpg123 src/resources/5156edu-2054-6162.mp3
```

### 3. 测试 Qt Multimedia

创建简单测试：
```bash
# 启用 GStreamer 调试
export GST_DEBUG=3
export QT_LOGGING_RULES="qt.multimedia*=true"

# 运行应用
./build/Desktop-Debug/appCloudMusic
```

## 常见问题

### 问题 1: 缺少 MP3 解码器

**错误信息**:
```
Missing decoder: MPEG-1 Layer 3 (MP3)
```

**解决方案**:
```bash
# Ubuntu
sudo apt-get install gstreamer1.0-plugins-ugly

# Fedora
sudo dnf install gstreamer1-plugins-ugly-free
```

### 问题 2: 没有音频输出

**检查**:
```bash
# 检查音频设备
aplay -l

# 检查 PulseAudio 状态
systemctl --user status pulseaudio

# 重启 PulseAudio
systemctl --user restart pulseaudio
```

### 问题 3: 权限问题

**解决方案**:
```bash
# 将用户添加到 audio 组
sudo usermod -a -G audio $USER

# 注销并重新登录
```

### 问题 4: Qt 找不到 GStreamer 插件

**检查插件路径**:
```bash
export GST_PLUGIN_PATH=/usr/lib/x86_64-linux-gnu/gstreamer-1.0
export GST_PLUGIN_SYSTEM_PATH=/usr/lib/x86_64-linux-gnu/gstreamer-1.0
```

## 调试步骤

### 1. 启用详细日志
```bash
export GST_DEBUG=4
export QT_LOGGING_RULES="qt.multimedia*=true"
./build/Desktop-Debug/appCloudMusic 2>&1 | tee audio_debug.log
```

### 2. 检查 GStreamer 管道
```bash
# 测试简单的音频管道
gst-launch-1.0 filesrc location=src/resources/5156edu-2054-6162.mp3 ! \
    decodebin ! audioconvert ! autoaudiosink
```

### 3. 检查 Qt 插件
```bash
# 查找 Qt Multimedia 插件
find /usr -name "*multimedia*" -type f 2>/dev/null | grep -i plugin

# 检查是否加载
export QT_DEBUG_PLUGINS=1
./build/Desktop-Debug/appCloudMusic 2>&1 | grep -i multimedia
```

## CMakeLists.txt 配置

确保 CMakeLists.txt 包含：

```cmake
find_package(Qt6 REQUIRED COMPONENTS
    Core
    Quick
    Qml
    Gui
    Network
    Multimedia
)

target_link_libraries(appCloudMusic PRIVATE
    Qt6::Multimedia
)
```

## 环境变量

在 `~/.bashrc` 或启动脚本中添加：

```bash
# GStreamer 配置
export GST_PLUGIN_PATH=/usr/lib/x86_64-linux-gnu/gstreamer-1.0
export GST_PLUGIN_SYSTEM_PATH=/usr/lib/x86_64-linux-gnu/gstreamer-1.0

# Qt Multimedia 日志（开发时）
# export QT_LOGGING_RULES="qt.multimedia*=true"
```

## 验证清单

- [ ] GStreamer 已安装 (`gst-inspect-1.0 --version`)
- [ ] MP3 插件已安装 (`gst-inspect-1.0 mpg123audiodec`)
- [ ] 音频系统正常 (`speaker-test -t wav -c 2`)
- [ ] MP3 文件可播放 (`gst-play-1.0 file.mp3`)
- [ ] Qt Multimedia 已链接
- [ ] 用户在 audio 组中
- [ ] PulseAudio/PipeWire 运行正常

## 参考资料

- [GStreamer Documentation](https://gstreamer.freedesktop.org/documentation/)
- [Qt Multimedia on Linux](https://doc.qt.io/qt-6/qtmultimedia-platform-notes.html#linux)
- [PulseAudio Documentation](https://www.freedesktop.org/wiki/Software/PulseAudio/)
