# Windows 平台图标资源修复

## 问题描述
在 Windows 平台上运行时，SVG 图标无法加载，出现以下错误：
```
QML QQuickImage: Cannot open: qrc:/CloudMusic/src/resources/icons/xxx.svg
```

而在 macOS 和 Linux 上运行正常。

## 根本原因
1. **资源文件配置不完整**：`src/img.qrc` 文件中没有包含 SVG 图标资源
2. **CMakeLists.txt 配置问题**：图标资源没有被正确添加到 Qt 资源系统

## 解决方案

### 1. 更新 `src/img.qrc` 文件
已添加图标资源到 QRC 文件中：
```xml
<qresource prefix="/CloudMusic/src/resources">
    <file>resources/icons/left.svg</file>
    <file>resources/icons/down.svg</file>
    <file>resources/icons/down_s.svg</file>
    <file>resources/icons/people.svg</file>
    <file>resources/icons/mic.svg</file>
    <file>resources/icons/setting.svg</file>
    <file>resources/icons/music.svg</file>
</qresource>
```

### 2. 更新 `CMakeLists.txt`
已添加独立的图标资源配置：
```cmake
qt_add_resources(appCloudMusic "icons"
    PREFIX "/CloudMusic"
    BASE "${CMAKE_SOURCE_DIR}"
    FILES
        ${ICON_RESOURCES}
)
```

## 在 Windows 上重新构建

### 步骤 1: 清理构建目录
```bash
# 在项目根目录执行
rmdir /s /q build
```

### 步骤 2: 重新配置 CMake
```bash
mkdir build
cd build
cmake .. -G "MinGW Makefiles" -DCMAKE_BUILD_TYPE=Debug
```

### 步骤 3: 重新编译
```bash
cmake --build .
```

### 步骤 4: 运行应用
```bash
.\appCloudMusic.exe
```

## 验证修复
运行应用后，应该不再看到以下错误：
- ❌ `Cannot open: qrc:/CloudMusic/src/resources/icons/xxx.svg`

所有图标应该正常显示：
- ✅ 设置图标
- ✅ 下载图标
- ✅ 换肤图标
- ✅ 麦克风图标
- ✅ 音乐图标
- ✅ 左箭头图标

## 为什么 macOS/Linux 没问题？
macOS 和 Linux 使用的是 Qt 的 QML 模块资源系统（通过 `qt_add_qml_module`），它会自动处理资源路径。而 Windows 的 MinGW 构建可能需要显式的 QRC 文件配置。

## 其他注意事项
1. 确保所有 SVG 文件都存在于 `src/resources/icons/` 目录
2. 如果添加新的图标，需要同时更新：
   - `src/img.qrc`
   - `CMakeLists.txt` 中的 `ICON_RESOURCES` 变量
3. Windows 上的路径分隔符使用 `/` 而不是 `\`
