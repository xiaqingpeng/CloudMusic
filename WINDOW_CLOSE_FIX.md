# 窗口关闭卡死问题修复说明

## 🔍 问题原因

关闭按钮使用 `Qt.quit()` 直接强制退出，导致：
1. ❌ 音频播放器未停止
2. ❌ 资源未清理
3. ❌ 动画未完成
4. ❌ macOS窗口管理器冲突
5. ❌ 事件循环被强制中断

## ✅ 修复方案

### 1. WindowControl.qml 修改

**修改前**：
```qml
onClicked: Qt.quit()  // 直接强制退出
```

**修改后**：
```qml
onClicked: {
    // 优雅关闭：先关闭窗口，让Qt事件循环处理清理
    window.close()
}
```

### 2. MyWindowRect.qml 添加关闭事件处理

**新增**：
```qml
// ========== 优雅关闭处理 ==========
onClosing: function(close) {
    // 在这里可以添加清理逻辑
    console.log("窗口正在关闭，执行清理...")
    
    // 停止音频播放（如果有）
    if (typeof MusicPlayerViewModel !== 'undefined' && MusicPlayerViewModel.stop) {
        MusicPlayerViewModel.stop()
    }
    
    // 接受关闭事件
    close.accepted = true
    
    // 延迟退出，确保清理完成
    Qt.callLater(Qt.quit)
}
```

### 3. MusicPlayerViewModel.qml 添加stop方法

**新增**：
```qml
function stop() {
    // 停止播放并清理资源
    console.log("停止音频播放...")
    audioPlayer.stop()
    isPlaying = false
}
```

## 🎯 修复效果

### 修复前：
```
用户点击关闭按钮
    ↓
Qt.quit() 立即执行
    ↓
❌ 音频播放器仍在播放
❌ 资源未释放
❌ 窗口管理器冲突
    ↓
💥 卡死或崩溃
```

### 修复后：
```
用户点击关闭按钮
    ↓
window.close() 触发关闭事件
    ↓
onClosing 事件处理器执行
    ↓
✅ 停止音频播放
✅ 清理资源
✅ 接受关闭事件
    ↓
Qt.callLater(Qt.quit) 延迟退出
    ↓
✅ 优雅退出，不卡死
```

## 📋 测试步骤

1. **编译并运行应用**：
   ```bash
   cd build
   cmake --build .
   ./appCloudMusic.app/Contents/MacOS/appCloudMusic
   ```

2. **测试场景**：
   - ✅ 播放音乐时点击关闭按钮
   - ✅ 暂停状态下点击关闭按钮
   - ✅ 拖动进度条时点击关闭按钮
   - ✅ 打开播放列表时点击关闭按钮
   - ✅ 动画播放时点击关闭按钮

3. **预期结果**：
   - ✅ 应用立即响应
   - ✅ 音频停止播放
   - ✅ 窗口平滑关闭
   - ✅ 无卡顿或崩溃
   - ✅ 控制台输出清理日志

## 🔧 进一步优化（可选）

### 1. 添加关闭确认对话框

如果需要在关闭前确认：

```qml
// MyWindowRect.qml
property bool showCloseConfirmation: false

onClosing: function(close) {
    if (showCloseConfirmation) {
        close.accepted = false  // 先阻止关闭
        closeConfirmDialog.open()  // 显示确认对话框
    } else {
        // 执行清理
        if (typeof MusicPlayerViewModel !== 'undefined' && MusicPlayerViewModel.stop) {
            MusicPlayerViewModel.stop()
        }
        close.accepted = true
        Qt.callLater(Qt.quit)
    }
}
```

### 2. 添加关闭动画

```qml
// WindowControl.qml
onClicked: {
    // 添加淡出动画
    closeAnimation.start()
}

NumberAnimation {
    id: closeAnimation
    target: window
    property: "opacity"
    from: 1.0
    to: 0.0
    duration: 200
    onFinished: window.close()
}
```

### 3. 保存应用状态

```qml
onClosing: function(close) {
    // 保存播放位置
    if (MusicPlayerViewModel) {
        Settings.setValue("lastPosition", MusicPlayerViewModel.currentPosition)
        Settings.setValue("lastSongIndex", MusicPlayerViewModel.currentSongIndex)
    }
    
    // 保存窗口位置和大小
    Settings.setValue("windowX", window.x)
    Settings.setValue("windowY", window.y)
    Settings.setValue("windowWidth", window.width)
    Settings.setValue("windowHeight", window.height)
    
    // 执行清理
    MusicPlayerViewModel.stop()
    close.accepted = true
    Qt.callLater(Qt.quit)
}
```

## 🐛 故障排查

### 如果仍然卡死：

1. **检查控制台输出**：
   ```bash
   # 运行应用并查看日志
   ./appCloudMusic.app/Contents/MacOS/appCloudMusic 2>&1 | tee app.log
   ```

2. **检查是否有其他阻塞操作**：
   - 网络请求未取消
   - 定时器未停止
   - 动画未完成
   - 文件IO操作

3. **添加更多清理逻辑**：
   ```qml
   onClosing: function(close) {
       console.log("开始清理...")
       
       // 停止所有定时器
       progressTimer.stop()
       
       // 停止音频
       MusicPlayerViewModel.stop()
       
       // 取消网络请求（如果有）
       // NetworkManager.cancelAll()
       
       // 清理缓存（如果有）
       // CacheManager.clear()
       
       console.log("清理完成")
       close.accepted = true
       Qt.callLater(Qt.quit)
   }
   ```

4. **使用强制退出作为后备**：
   ```qml
   onClosing: function(close) {
       // 执行清理
       MusicPlayerViewModel.stop()
       close.accepted = true
       
       // 设置超时强制退出（防止清理卡住）
       var forceQuitTimer = Qt.createQmlObject(
           'import QtQuick; Timer { interval: 1000; repeat: false }',
           window
       )
       forceQuitTimer.triggered.connect(function() {
           console.warn("强制退出")
           Qt.quit()
       })
       forceQuitTimer.start()
       
       // 正常退出
       Qt.callLater(Qt.quit)
   }
   ```

## 📚 相关文档

- [Qt Window.closing 信号](https://doc.qt.io/qt-6/qml-qtquick-window-window.html#closing-signal)
- [Qt.quit() vs window.close()](https://doc.qt.io/qt-6/qtqml-javascript-qmlglobalobject.html#quit-method)
- [Qt 应用程序生命周期](https://doc.qt.io/qt-6/qguiapplication.html#details)

## ✅ 总结

**核心改进**：
1. ✅ 使用 `window.close()` 替代 `Qt.quit()`
2. ✅ 添加 `onClosing` 事件处理器
3. ✅ 停止音频播放器
4. ✅ 使用 `Qt.callLater()` 延迟退出
5. ✅ 确保资源清理完成

**预期效果**：
- ✅ 关闭按钮响应迅速
- ✅ 无卡顿或崩溃
- ✅ 资源正确释放
- ✅ 用户体验流畅

---

**修复日期**: 2026-04-29
**修复版本**: v1.0.1
**测试平台**: macOS (Apple Silicon)
