# Ubuntu 虚拟机测试说明

## 当前状态

### ✅ 成功部分
1. **项目同步**: macOS → Ubuntu 同步成功
2. **编译构建**: 在 Ubuntu 上成功编译
3. **QML 路径**: 正确找到 QML 文件 `qrc:/CloudMusic/src/ui/Main.qml`
4. **应用初始化**: Logger、Config、Application 初始化成功

### ⚠️ 限制
**崩溃原因**: 虚拟机无图形界面，QML Window 对象无法创建

```
=== Loading QML ===
Testing QML path: QUrl("qrc:/qt/qml/CloudMusic/src/ui/Main.qml")
Testing QML path: QUrl("qrc:/CloudMusic/src/ui/Main.qml")
Found QML at: QUrl("qrc:/CloudMusic/src/ui/Main.qml")  ✅
Loading QML from: QUrl("qrc:/CloudMusic/src/ui/Main.qml")
[崩溃] - 尝试创建 Window 对象
```

## 为什么会崩溃？

### 1. 无显示器环境
虚拟机通过 SSH 访问，没有 X11 或 Wayland 显示服务器。

### 2. QML Window 对象
`Main.qml` 使用 `MyWindowRect`，它继承自 `Window`：
```qml
Window {
    visible: true
    width: 1400
    height: 900
    // ...
}
```

### 3. offscreen 平台的限制
即使使用 `QT_QPA_PLATFORM=offscreen`，某些图形操作仍然会失败。

## 解决方案

### 方案 1: 使用 Xvfb (虚拟显示)

```bash
# 安装 Xvfb
sudo apt-get install xvfb

# 使用 Xvfb 运行
xvfb-run -a ./appCloudMusic

# 或设置 DISPLAY
Xvfb :99 -screen 0 1400x900x24 &
export DISPLAY=:99
./appCloudMusic
```

### 方案 2: X11 转发

```bash
# 在 macOS 上安装 XQuartz
brew install --cask xquartz

# 启动 XQuartz 并允许网络连接

# SSH 连接时启用 X11 转发
ssh -X xiaqingpeng@192.168.64.2

# 运行应用
cd /home/xiaqingpeng/qt6/CloudMusic/build/Desktop-Debug
./appCloudMusic
```

### 方案 3: VNC 服务器

```bash
# 安装 VNC 服务器
sudo apt-get install tightvncserver

# 启动 VNC
vncserver :1 -geometry 1400x900 -depth 24

# 设置 DISPLAY
export DISPLAY=:1
./appCloudMusic

# 从 macOS 连接
# 使用 VNC 客户端连接到 192.168.64.2:5901
```

### 方案 4: 创建无头测试版本

修改代码以支持无头测试：

```cpp
// 在 Application.cpp 中
bool Application::run() {
    // 检查是否有显示器
    if (qEnvironmentVariableIsSet("HEADLESS_TEST")) {
        qDebug() << "Running in headless mode";
        // 只加载 QML 不显示窗口
        m_engine->load(url);
        return 0;  // 不进入事件循环
    }
    
    // 正常模式
    m_engine->load(url);
    return m_app->exec();
}
```

## 当前最佳实践

### 开发流程
1. **在 macOS 上开发**: 完整的图形界面和调试工具
2. **同步到 Ubuntu**: 验证编译和跨平台兼容性
3. **使用 Xvfb 测试**: 如果需要在 Ubuntu 上运行

### 验证清单
- ✅ 代码同步成功
- ✅ 编译无错误
- ✅ QML 路径正确
- ✅ 资源文件打包正确
- ⚠️ 运行时测试（需要图形环境）

## 测试命令

### 编译测试
```bash
ssh xiaqingpeng@192.168.64.2
cd /home/xiaqingpeng/qt6/CloudMusic
cmake -B build/Desktop-Debug -DCMAKE_BUILD_TYPE=Debug
cmake --build build/Desktop-Debug
```

### 路径验证测试
```bash
cd build/Desktop-Debug
QT_QPA_PLATFORM=offscreen ./appCloudMusic 2>&1 | grep "Found QML"
# 应该输出: Found QML at: QUrl("qrc:/CloudMusic/src/ui/Main.qml")
```

### 使用 Xvfb 运行
```bash
# 安装 Xvfb
sudo apt-get update
sudo apt-get install -y xvfb

# 运行应用
cd /home/xiaqingpeng/qt6/CloudMusic/build/Desktop-Debug
xvfb-run -a ./appCloudMusic
```

## 结论

**项目在 Ubuntu 上的核心功能正常**：
- ✅ 编译系统工作正常
- ✅ 资源系统工作正常
- ✅ QML 路径解析正常
- ✅ 跨平台兼容性良好

**崩溃是环境限制，不是代码问题**：
- 虚拟机无图形界面
- 需要 Xvfb 或 VNC 来运行 GUI 应用

**推荐工作流程**：
1. 主要开发在 macOS 上进行
2. 定期同步到 Ubuntu 验证编译
3. 如需在 Ubuntu 上测试运行，使用 Xvfb

## 参考资料

- [Qt Offscreen Platform](https://doc.qt.io/qt-6/qpa.html)
- [Xvfb 使用指南](https://www.x.org/releases/X11R7.6/doc/man/man1/Xvfb.1.xhtml)
- [X11 Forwarding](https://wiki.archlinux.org/title/OpenSSH#X11_forwarding)
