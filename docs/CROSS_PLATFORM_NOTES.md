# 跨平台开发笔记

## Qt 资源路径差异

### 问题描述
在不同平台和 Qt 版本上，QML 资源的路径前缀可能不同：

- **macOS (Qt 6.10.1)**: `qrc:/qt/qml/CloudMusic/src/ui/Main.qml`
- **Ubuntu (Qt 6.4.2)**: `qrc:/CloudMusic/src/ui/Main.qml`

### 解决方案
在 `Application.cpp` 中实现了多路径尝试机制：

```cpp
QStringList possiblePaths = {
    "qrc:/qt/qml/CloudMusic/src/ui/Main.qml",  // macOS Qt 6.10
    "qrc:/CloudMusic/src/ui/Main.qml",         // Linux Qt 6.4
    "qrc:///CloudMusic/src/ui/Main.qml"        // 备用路径
};

for (const QString& path : possiblePaths) {
    QUrl testUrl(path);
    if (QFile::exists(testUrl.toString().replace("qrc:", ":"))) {
        url = testUrl;
        break;
    }
}
```

## 平台差异

### macOS
- Qt 版本: 6.10.1
- 架构: ARM64 (Apple Silicon)
- 资源前缀: `/qt/qml/`
- 图形系统: Cocoa
- 构建工具: Xcode Command Line Tools

### Ubuntu (虚拟机)
- Qt 版本: 6.4.2
- 架构: ARM64 (aarch64)
- 资源前缀: 无额外前缀
- 图形系统: X11/Wayland
- 构建工具: GCC/Clang

## 测试方法

### macOS
```bash
# 正常运行（有图形界面）
./build/unknown-Debug/appCloudMusic.app/Contents/MacOS/appCloudMusic
```

### Ubuntu (无图形界面)
```bash
# 使用 offscreen 平台插件测试
cd /home/xiaqingpeng/qt6/CloudMusic/build/Desktop-Debug
QT_QPA_PLATFORM=offscreen ./appCloudMusic

# 或使用 timeout 避免挂起
timeout 3 env QT_QPA_PLATFORM=offscreen ./appCloudMusic
```

## 同步开发

### macOS → Ubuntu
```bash
# 使用同步脚本
./sync-to-vm.sh

# 或手动同步
rsync -avz --exclude 'build/' --exclude '.git/' \
  /Applications/qingpengxia/qt/qt6/qml/CloudMusic/ \
  xiaqingpeng@192.168.64.2:/home/xiaqingpeng/qt6/CloudMusic/
```

### 在 Ubuntu 上构建
```bash
ssh xiaqingpeng@192.168.64.2
cd /home/xiaqingpeng/qt6/CloudMusic
cmake -B build/Desktop-Debug -DCMAKE_BUILD_TYPE=Debug
cmake --build build/Desktop-Debug
```

## 已知问题

### 1. Ubuntu 虚拟机无图形界面
**问题**: 运行时报错 `could not connect to display`

**解决方案**:
- 使用 `QT_QPA_PLATFORM=offscreen` 环境变量
- 或安装 X11 转发: `ssh -X xiaqingpeng@192.168.64.2`
- 或使用 VNC 连接虚拟机

### 2. Qt 版本差异
**问题**: macOS 使用 Qt 6.10.1，Ubuntu 使用 Qt 6.4.2

**影响**:
- 资源路径前缀不同
- 某些 API 可能有差异
- QML 模块加载机制略有不同

**解决方案**:
- 使用多路径尝试机制
- 避免使用特定版本的新特性
- 保持代码兼容 Qt 6.2+

### 3. 构建目录差异
- **macOS**: `build/unknown-Debug/`
- **Ubuntu**: `build/Desktop-Debug/`

这是 Qt Creator 在不同平台上的默认设置。

## 最佳实践

### 1. 资源路径
- 不要硬编码资源路径
- 使用相对路径或模块导入
- 实现路径自动检测机制

### 2. 平台检测
```cpp
#ifdef Q_OS_MACOS
    // macOS 特定代码
#elif defined(Q_OS_LINUX)
    // Linux 特定代码
#elif defined(Q_OS_WIN)
    // Windows 特定代码
#endif
```

### 3. 测试
- 在所有目标平台上测试
- 使用 CI/CD 自动化测试
- 保持构建配置一致

## 调试技巧

### 查看 QML 导入路径
```cpp
qDebug() << "Import paths:";
for (const QString& path : m_engine->importPathList()) {
    qDebug() << "  " << path;
}
```

### 检查资源是否存在
```cpp
QFile file(":/path/to/resource");
if (file.exists()) {
    qDebug() << "Resource exists";
}
```

### 列出所有资源
```bash
# 在构建目录中
strings appCloudMusic | grep "\.qml"
```

## 性能对比

### 启动时间
- **macOS**: ~1.5 秒
- **Ubuntu (虚拟机)**: ~2.0 秒

### 内存使用
- **macOS**: ~120 MB
- **Ubuntu**: ~100 MB (无图形界面)

### 编译时间
- **macOS**: ~30 秒
- **Ubuntu**: ~45 秒

## 参考资料

- [Qt 跨平台开发指南](https://doc.qt.io/qt-6/topics-app-development.html)
- [Qt 资源系统](https://doc.qt.io/qt-6/resources.html)
- [QML 模块](https://doc.qt.io/qt-6/qtqml-modules-topic.html)
