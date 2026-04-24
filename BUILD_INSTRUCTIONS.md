# 构建说明

## 问题：构建类型不匹配

错误信息：
```
No "Debug" CMake configuration found. Available configuration: "Release".
```

## 解决方案

### 方案 1: 在 Qt Creator 中更改构建类型

1. 在 Qt Creator 左侧点击 "Projects" 图标（扳手图标）
2. 在 "Build Settings" 下找到 "Build type" 或 "CMAKE_BUILD_TYPE"
3. 将其改为 "Release"
4. 点击 "Build" → "Rebuild Project"

### 方案 2: 使用命令行构建（推荐）

```bash
# 清理旧的构建
rm -rf build

# 重新配置为 Release 模式
cmake -B build -S . -DCMAKE_BUILD_TYPE=Release

# 构建
cmake --build build

# 运行
./build/appCloudMusic
```

### 方案 3: 构建 Debug 版本

```bash
# 清理旧的构建
rm -rf build

# 配置为 Debug 模式
cmake -B build -S . -DCMAKE_BUILD_TYPE=Debug

# 构建
cmake --build build

# 运行
./build/appCloudMusic
```

## 快速测试音频

### 1. 检查音频环境
```bash
./check_linux_audio.sh
```

### 2. 构建应用
```bash
cmake -B build -S . -DCMAKE_BUILD_TYPE=Release
cmake --build build
```

### 3. 运行应用（带调试日志）
```bash
export GST_DEBUG=3
export QT_LOGGING_RULES="qt.multimedia*=true"
./build/appCloudMusic
```

### 4. 测试 MP3 文件
```bash
# 使用 GStreamer 测试
gst-play-1.0 src/resources/5156edu-2054-6162.mp3

# 或使用 mpg123
mpg123 src/resources/5156edu-2054-6162.mp3
```

## 常见问题

### Q: 找不到应用文件
A: 检查构建目录：
```bash
find build -name "appCloudMusic" -type f
```

### Q: 没有声音
A: 
1. 先运行 `./check_linux_audio.sh` 检查依赖
2. 确保安装了 GStreamer 和 MP3 插件：
   ```bash
   sudo apt-get install gstreamer1.0-plugins-ugly gstreamer1.0-libav
   ```
3. 测试系统音频：
   ```bash
   speaker-test -t wav -c 2
   ```

### Q: 缺少 GStreamer
A: 安装完整的 GStreamer：
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
    gstreamer1.0-pulseaudio
```

## 验证音频功能

运行应用后：
1. 点击底部播放栏的播放按钮
2. 查看控制台日志，应该看到：
   ```
   🎵 Attempting to play audio...
   Device: [设备名称]
   Volume: 1
   Muted: false
   ```
3. 应该能听到音乐播放

## 调试技巧

### 启用详细的 GStreamer 日志
```bash
export GST_DEBUG=4
export GST_DEBUG_FILE=/tmp/gst-debug.log
./build/appCloudMusic
```

然后查看日志：
```bash
less /tmp/gst-debug.log
```

### 检查 Qt Multimedia 是否正确链接
```bash
ldd ./build/appCloudMusic | grep Qt6Multimedia
```

应该看到类似：
```
libQt6Multimedia.so.6 => /usr/lib/x86_64-linux-gnu/libQt6Multimedia.so.6
```
