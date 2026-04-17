# Qt Creator 代码提示优化指南

## 问题诊断

Qt Creator 代码提示不灵敏的常见原因：

1. ❌ QML Language Server 未启用或配置错误
2. ❌ Kit 配置不正确（没有有效的 Qt 版本）
3. ❌ QML 模块路径未正确配置
4. ❌ 项目索引未完成
5. ❌ CMake 配置错误

## 快速修复

### 1. 检查 Kit 配置

**问题症状：**
```
Current kit does not have a valid Qt version, disabling QML Language Server.
```

**解决方案：**

1. 打开 `Preferences/Settings` → `Kits` → `Qt Versions`
2. 点击 "Add" 添加 Qt 版本
3. 选择 qmake 路径：
   - **macOS**: `/opt/homebrew/bin/qmake`
   - **Linux**: `/usr/bin/qmake`
4. 点击 "Apply"

5. 切换到 `Kits` 标签
6. 选择或创建一个 Kit
7. 设置 Qt version 为刚添加的版本
8. 点击 "Apply" 和 "OK"

### 2. 启用 QML Language Server

1. `Preferences/Settings` → `Qt Quick` → `QML/JS Editing`
2. 确保勾选：
   - ✅ Enable QML Language Server
   - ✅ Use QML Language Server for code completion
3. 点击 "Apply"

### 3. 配置 QML Import Paths

1. 右键点击项目 → `Properties` → `QML`
2. 添加 QML Import Paths：

**macOS:**
```
/opt/homebrew/opt/qt@6/qml
/opt/homebrew/lib/qt6/qml
```

**Linux:**
```
/usr/lib/aarch64-linux-gnu/qt6/qml
/usr/share/qt6/qml
```

**项目路径:**
```
${PROJECT_DIR}/src/ui
${PROJECT_DIR}/src/ui/theme
${PROJECT_DIR}/src/ui/viewmodels
```

### 4. 重新加载项目

1. 关闭项目：`File` → `Close Project`
2. 重新打开：`File` → `Open Project`
3. 等待 CMake 配置完成
4. 等待代码模型索引完成（查看右下角进度条）

### 5. 清理缓存

如果以上方法无效，清理缓存：

```bash
# macOS
rm -rf ~/Library/Application\ Support/QtProject/qtcreator
rm -rf ~/.config/QtProject/qtcreator

# Linux
rm -rf ~/.config/QtProject/qtcreator
rm -rf ~/.local/share/QtProject/qtcreator
```

然后重启 Qt Creator。

## 详细配置步骤

### 步骤 1：验证 Qt 安装

**macOS:**
```bash
# 检查 qmake
which qmake
# 输出: /opt/homebrew/bin/qmake

# 检查版本
qmake -version
# 输出: QMake version 3.1
#       Using Qt version 6.x.x

# 检查 QML 模块
ls /opt/homebrew/opt/qt@6/qml
```

**Linux:**
```bash
# 检查 qmake
which qmake
# 输出: /usr/bin/qmake

# 检查版本
qmake -version

# 检查 QML 模块
ls /usr/lib/aarch64-linux-gnu/qt6/qml
```

### 步骤 2：配置 CMake

确保 `CMakeLists.txt` 正确配置：

```cmake
# 设置 Qt 路径（如果需要）
set(CMAKE_PREFIX_PATH "/opt/homebrew/opt/qt@6")

# 查找 Qt 组件
find_package(Qt6 6.2 REQUIRED COMPONENTS 
    Core
    Quick
    Qml
    Gui
)

# 启用自动工具
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

# QML 模块
qt_add_qml_module(appCloudMusic
    URI CloudMusic
    VERSION 1.0
    QML_FILES
        # ... 你的 QML 文件
)
```

### 步骤 3：配置 qmldir 文件

确保每个 QML 模块都有 `qmldir` 文件：

**src/ui/theme/qmldir:**
```
module CloudMusic.Theme
singleton Theme 1.0 Theme.qml
```

**src/ui/viewmodels/qmldir:**
```
module CloudMusic.ViewModels
singleton SearchViewModel 1.0 SearchViewModel.qml
singleton MusicPlayerViewModel 1.0 MusicPlayerViewModel.qml
singleton ContentViewModel 1.0 ContentViewModel.qml
```

### 步骤 4：重新配置 CMake

在 Qt Creator 中：

1. 点击左侧的 "Projects" 按钮
2. 选择 "Build" 标签
3. 点击 "CMake" 部分的 "Re-configure with Initial Parameters"
4. 等待配置完成

### 步骤 5：验证 QML Language Server

1. 打开一个 QML 文件
2. 查看右下角状态栏
3. 应该显示 "QML Language Server: Running"

如果显示 "Disabled"，检查：
- Kit 是否有有效的 Qt 版本
- QML Language Server 是否启用

## 优化代码提示

### 1. 调整代码补全设置

`Preferences/Settings` → `Text Editor` → `Completion`

推荐设置：
- ✅ Automatically insert matching characters
- ✅ Automatically insert brackets
- ✅ Surround text selection on typing quote or bracket
- Case sensitivity: First Letter
- Completion trigger: Automatically (300 ms)

### 2. 调整 QML 设置

`Preferences/Settings` → `Qt Quick` → `QML/JS Editing`

推荐设置：
- ✅ Enable QML Language Server
- ✅ Use QML Language Server for code completion
- ✅ Auto-format on file save
- ✅ Enable auto-insertion of quotes
- ✅ Enable auto-insertion of brackets

### 3. 配置代码风格

`Preferences/Settings` → `Qt Quick` → `Code Style`

```
Indentation:
  Tab size: 4
  Indent size: 4
  
Alignment:
  ✅ Align properties
  ✅ Align object definitions
```

### 4. 启用语法检查

`Preferences/Settings` → `Qt Quick` → `QML/JS Editing`

- ✅ Enable qmllint
- qmllint path: `/opt/homebrew/bin/qmllint` (macOS) 或 `/usr/bin/qmllint` (Linux)

## 常见问题解决

### 问题 1：提示 "QML Language Server: Disabled"

**原因：** Kit 没有有效的 Qt 版本

**解决方案：**
1. `Preferences` → `Kits` → `Qt Versions`
2. 添加正确的 qmake 路径
3. 在 Kits 中选择该 Qt 版本
4. 重新打开项目

### 问题 2：导入的模块没有代码提示

**原因：** QML Import Paths 未配置

**解决方案：**
1. 右键项目 → `Properties` → `QML`
2. 添加模块路径
3. 重新加载项目

### 问题 3：自定义组件没有提示

**原因：** 缺少 qmldir 文件

**解决方案：**
1. 在组件目录创建 `qmldir` 文件
2. 声明模块和组件
3. 在 CMakeLists.txt 中添加到 RESOURCES

### 问题 4：提示延迟很高

**原因：** 项目索引未完成或性能问题

**解决方案：**
1. 等待索引完成（查看右下角进度）
2. 排除不需要的目录：
   - 右键 `build` 目录 → `Exclude from Project`
3. 增加 Qt Creator 内存：
   ```bash
   # 编辑配置文件
   # macOS: ~/Library/Application Support/QtProject/qtcreator/QtCreator.ini
   # Linux: ~/.config/QtProject/qtcreator/QtCreator.ini
   
   # 添加或修改
   [General]
   MaxRecentFiles=20
   ```

### 问题 5：某些 Qt 类型没有提示

**原因：** CMakeLists.txt 中缺少对应的 Qt 组件

**解决方案：**
```cmake
find_package(Qt6 REQUIRED COMPONENTS
    Core
    Quick
    Qml
    Gui
    Network      # 如果使用网络功能
    Multimedia   # 如果使用多媒体
    Widgets      # 如果使用 Widgets
)
```

## 性能优化

### 1. 排除不需要的目录

右键点击以下目录 → `Exclude from Project`：
- `build/`
- `.git/`
- `node_modules/` (如果有)

### 2. 禁用不需要的插件

`Help` → `About Plugins`

可以禁用：
- Android 支持（如果不开发 Android）
- iOS 支持（如果不开发 iOS）
- Python 支持（如果不使用）

### 3. 调整索引设置

`Preferences/Settings` → `C++` → `Code Model`

- Indexer threads: 根据 CPU 核心数调整（建议 4-8）
- ✅ Skip indexing big files (>5MB)

## 快捷键

### 代码补全相关

| 功能 | macOS | Linux/Windows |
|------|-------|---------------|
| 触发补全 | Ctrl+Space | Ctrl+Space |
| 参数提示 | Cmd+Shift+D | Ctrl+Shift+D |
| 快速修复 | Cmd+. | Alt+Enter |
| 跳转到定义 | F2 或 Cmd+Click | F2 或 Ctrl+Click |
| 查找用法 | Cmd+Shift+U | Ctrl+Shift+U |
| 重命名 | Cmd+Shift+R | Ctrl+Shift+R |

### 导航相关

| 功能 | macOS | Linux/Windows |
|------|-------|---------------|
| 切换头文件/源文件 | F4 | F4 |
| 打开定位器 | Cmd+K | Ctrl+K |
| 切换文档 | Cmd+Tab | Ctrl+Tab |
| 返回上次位置 | Cmd+[ | Alt+Left |
| 前进到下次位置 | Cmd+] | Alt+Right |

## 验证配置

### 测试代码提示

创建一个测试 QML 文件：

```qml
import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle {
    width: 400
    height: 300
    
    // 测试 1: 输入 "Text" 应该有补全提示
    Text {
        // 测试 2: 输入 "text: " 应该有属性提示
        text: "Hello"
        
        // 测试 3: 输入 "color: " 应该有颜色提示
        color: "blue"
        
        // 测试 4: 输入 "anchors." 应该有锚点提示
        anchors.centerIn: parent
    }
    
    // 测试 5: 输入 "Button" 应该有 Controls 组件提示
    Button {
        text: "Click"
        // 测试 6: 输入 "onClicked: " 应该有信号提示
        onClicked: {
            // 测试 7: 输入 "console." 应该有方法提示
            console.log("clicked")
        }
    }
}
```

如果以上所有测试都有正确的代码提示，说明配置成功！

## 调试 QML Language Server

### 启用日志

1. `Help` → `About Plugins` → 搜索 "QML"
2. 确保 "QmlJSTools" 插件已启用

2. 查看日志：
   ```bash
   # macOS
   tail -f ~/Library/Application\ Support/QtProject/qtcreator/logs/qml-language-server.log
   
   # Linux
   tail -f ~/.local/share/QtProject/qtcreator/logs/qml-language-server.log
   ```

### 手动启动 Language Server

```bash
# 查找 qmlls
which qmlls

# 手动启动测试
qmlls --help
```

## 推荐配置总结

### 必须配置
- ✅ 添加 Qt 版本（qmake 路径）
- ✅ 配置 Kit 使用该 Qt 版本
- ✅ 启用 QML Language Server
- ✅ 添加 QML Import Paths

### 推荐配置
- ✅ 启用 qmllint
- ✅ 配置代码风格
- ✅ 调整补全延迟（300ms）
- ✅ 排除 build 目录

### 性能优化
- ✅ 禁用不需要的插件
- ✅ 调整索引线程数
- ✅ 跳过大文件索引

## 检查清单

完成以下检查，确保代码提示正常工作：

- [ ] Qt 版本已添加并配置正确
- [ ] Kit 使用了有效的 Qt 版本
- [ ] QML Language Server 已启用
- [ ] QML Import Paths 已配置
- [ ] qmldir 文件存在且正确
- [ ] CMake 配置成功
- [ ] 项目索引已完成
- [ ] 测试文件中代码提示正常工作
- [ ] 状态栏显示 "QML Language Server: Running"

如果所有检查都通过，代码提示应该非常灵敏了！

## 配置 Qt 文档

### 问题：显示 "No documentation available"

**原因：** Qt 文档未安装或未配置

### 解决方案 1：安装 Qt 文档（推荐）

**macOS (Homebrew):**
```bash
# Qt 6 文档包通常不在 Homebrew 中
# 需要从 Qt 官网下载或使用在线文档
```

**使用在线文档：**
1. `Preferences/Settings` → `Help` → `Documentation`
2. 点击 "Add"
3. 选择 "Register Documentation from URL"
4. 输入：`https://doc.qt.io/qt-6/`

### 解决方案 2：下载离线文档

**下载 Qt 6 文档包：**

1. **官方文档包下载**
   - 访问：https://download.qt.io/online/qtsdkrepository/
   - 导航到：`mac_x64/desktop/qt6_xxx/` (macOS) 或 `linux_x64/desktop/qt6_xxx/` (Linux)
   - 查找 `Documentation` 文件夹
   - 下载 `.7z` 文件并解压

2. **直接下载链接（Qt 6.10）**
   
   **macOS/Linux 通用文档：**
   ```bash
   # 创建文档目录
   mkdir -p ~/Qt/Docs/Qt-6.10
   cd ~/Qt/Docs/Qt-6.10
   
   # 下载核心文档（示例链接，需要根据实际版本调整）
   # 访问 https://download.qt.io/online/qtsdkrepository/mac_x64/desktop/qt6_6100/
   # 下载 qt.qt6.6100.doc.qtcore 等文档包
   ```

3. **使用 Qt Online Installer**
   
   如果你有 Qt 账号：
   - 下载 Qt Online Installer：https://www.qt.io/download-qt-installer
   - 运行安装器
   - 选择 "Add or remove components"
   - 展开 Qt 6.x，勾选：
     - ✅ Documentation（整体文档包，包含所有模块）
   - 安装到默认位置

4. **在 Qt Creator 中添加文档**
   
   安装后，文档通常在：
   - **macOS**: `~/Qt/Docs/Qt-6.x/`
   - **Linux**: `~/Qt/Docs/Qt-6.x/`
   
   Qt Creator 通常会自动检测并加载文档。
   
   如需手动添加：
   ```
   Preferences → Help → Documentation → Add
   ```
   
   选择整个文档目录或单个 `.qch` 文件：
   - `qtcore.qch` - Qt Core 文档
   - `qtquick.qch` - Qt Quick 文档
   - `qtqml.qch` - QML 文档
   - `qtquickcontrols.qch` - Qt Quick Controls 文档
   - `qtgui.qch` - Qt GUI 文档
   - `qtnetwork.qch` - Qt Network 文档
   - `qtmultimedia.qch` - Qt Multimedia 文档
   - 等等...

**注意：** Qt Maintenance Tool 安装的是完整文档包，包含所有 Qt 模块的文档，不需要单独选择模块。

**推荐安装的文档包：**
```
必需：
✅ qtcore.qch          - Qt Core API
✅ qtquick.qch         - Qt Quick 组件
✅ qtqml.qch           - QML 语言
✅ qtquickcontrols.qch - Qt Quick Controls

推荐：
✅ qtgui.qch           - GUI 相关
✅ qtnetwork.qch       - 网络功能
✅ qtmultimedia.qch    - 多媒体功能

可选：
□ qtwidgets.qch        - Widgets (如果不用可不装)
□ qtwebengine.qch      - Web 引擎
□ qt3d.qch             - 3D 功能
```

**快速下载脚本（macOS/Linux）：**

```bash
#!/bin/bash
# 下载 Qt 6 文档

DOC_VERSION="6.10"
DOC_DIR="$HOME/Qt/Docs/Qt-${DOC_VERSION}"
BASE_URL="https://download.qt.io/online/qtsdkrepository"

mkdir -p "$DOC_DIR"
cd "$DOC_DIR"

echo "📚 下载 Qt ${DOC_VERSION} 文档..."
echo "注意：需要根据实际版本调整 URL"
echo ""
echo "手动下载步骤："
echo "1. 访问: ${BASE_URL}"
echo "2. 选择平台: mac_x64 或 linux_x64"
echo "3. 进入: desktop/qt6_${DOC_VERSION//.}/qt.qt6.${DOC_VERSION//.}.doc/"
echo "4. 下载所需的文档包"
echo ""
echo "或使用 Qt Maintenance Tool 安装"
```

**验证文档安装：**

```bash
# 检查文档文件
ls -lh ~/Qt/Docs/Qt-6.*/

# 应该看到类似：
# qtcore.qch
# qtquick.qch
# qtqml.qch
# qtquickcontrols.qch
```

### 解决方案 3：使用 Qt Maintenance Tool

如果你是通过 Qt 官方安装器安装的：

1. 运行 Qt Maintenance Tool
2. 选择 "Add or remove components"
3. 勾选 "Qt 6.x" → "Documentation"
4. 安装文档

### 解决方案 4：配置在线帮助

`Preferences/Settings` → `Help` → `General`

- ✅ On context help: Use External Viewer
- External viewer: 选择浏览器
- 或者使用 Qt Assistant（如果已安装）

### 验证文档配置

1. 在 QML 文件中，将光标放在 `Text` 上
2. 按 `F1` 或 `Cmd+?` (macOS) / `Ctrl+?` (Linux)
3. 应该显示 Text 组件的文档

### 常用文档快捷键

| 功能 | macOS | Linux/Windows |
|------|-------|---------------|
| 查看文档 | F1 或 Cmd+? | F1 |
| 搜索文档 | Cmd+Shift+? | Ctrl+Shift+? |
| 打开 Qt Assistant | - | - |

### 在线文档链接

如果离线文档不可用，可以直接访问在线文档：

- **Qt Quick**: https://doc.qt.io/qt-6/qtquick-index.html
- **QML Types**: https://doc.qt.io/qt-6/qmltypes.html
- **Text**: https://doc.qt.io/qt-6/qml-qtquick-text.html
- **Rectangle**: https://doc.qt.io/qt-6/qml-qtquick-rectangle.html
- **Controls**: https://doc.qt.io/qt-6/qtquickcontrols-index.html

## 参考资料

- [Qt Creator 官方文档](https://doc.qt.io/qtcreator/)
- [QML Language Server](https://doc.qt.io/qt-6/qtqml-tooling-qmlls.html)
- [Qt Quick 最佳实践](https://doc.qt.io/qt-6/qtquick-bestpractices.html)
