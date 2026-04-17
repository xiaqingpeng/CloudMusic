# CLion QML 开发配置指南

## 前提条件

- CLion 2023.1 或更高版本
- Qt 6.2 或更高版本
- CMake 3.16 或更高版本

## 1. 安装 QML 插件

### 方法 1：通过 CLion 插件市场

1. 打开 CLion
2. 进入 `Settings/Preferences` → `Plugins`
3. 搜索 "QML"
4. 安装 "QML Support" 插件
5. 重启 CLion

### 方法 2：手动安装

1. 下载 QML 插件：https://plugins.jetbrains.com/plugin/13126-qml-support
2. `Settings/Preferences` → `Plugins` → ⚙️ → `Install Plugin from Disk`
3. 选择下载的插件文件
4. 重启 CLion

## 2. 配置 Qt 路径

### macOS

```bash
# 查找 Qt 安装路径
which qmake
# 输出: /opt/homebrew/bin/qmake

# 或者
brew --prefix qt6
# 输出: /opt/homebrew/opt/qt@6
```

### Linux (Ubuntu VM)

```bash
# 查找 Qt 安装路径
which qmake
# 输出: /usr/bin/qmake

# 或者
dpkg -L qt6-base-dev | grep bin/qmake
```

### 在 CLion 中配置

1. `Settings/Preferences` → `Build, Execution, Deployment` → `CMake`
2. 在 CMake options 中添加：
   ```
   -DCMAKE_PREFIX_PATH=/opt/homebrew/opt/qt@6
   ```
   或 Linux:
   ```
   -DCMAKE_PREFIX_PATH=/usr/lib/aarch64-linux-gnu/cmake/Qt6
   ```

## 3. 配置 QML 代码补全

### 设置 QML Import Paths

1. `Settings/Preferences` → `Languages & Frameworks` → `QML`
2. 点击 "+" 添加 QML 导入路径：

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

### 配置 qmldir 文件

确保项目中的 qmldir 文件正确配置：

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

## 4. 配置 CMake

### 确保 CMakeLists.txt 正确配置

项目的 `CMakeLists.txt` 已经配置好，包含：

```cmake
# 启用 Qt 自动工具
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

# 查找 Qt 组件
find_package(Qt6 6.2 REQUIRED COMPONENTS 
    Core
    Quick
    Qml
    Gui
    Network
    Multimedia
)

# QML 模块
qt_add_qml_module(appCloudMusic
    URI CloudMusic
    VERSION 1.0
    QML_FILES
        # ... QML 文件列表
)
```

### 重新加载 CMake

1. 点击 CLion 顶部的 "Reload CMake Project" 按钮
2. 或者 `Tools` → `CMake` → `Reload CMake Project`

## 5. 配置代码风格

### QML 代码格式化

1. `Settings/Preferences` → `Editor` → `Code Style` → `QML`
2. 配置缩进、空格等：
   - Tab size: 4
   - Indent: 4
   - Continuation indent: 4

### 推荐设置

```
Spaces:
  ✓ Before parentheses in function declaration
  ✓ Before left brace
  ✓ Around operators
  
Wrapping:
  ✓ Wrap long lines
  Right margin: 120
```

## 6. 配置运行/调试

### 创建运行配置

1. `Run` → `Edit Configurations`
2. 点击 "+" → `CMake Application`
3. 配置：
   - Name: `CloudMusic`
   - Target: `appCloudMusic`
   - Executable: `appCloudMusic`
   - Program arguments: (可选)
   - Working directory: `$ProjectFileDir$`

### 添加环境变量（可选）

在运行配置中添加环境变量：

```
QT_QPA_PLATFORM=xcb
QSG_INFO=1
QT_LOGGING_RULES=*.debug=true
```

### 调试配置

1. 使用相同的运行配置
2. 点击调试按钮 🐛
3. 设置断点：
   - C++ 代码：直接点击行号
   - QML 代码：需要启用 QML 调试

## 7. 启用 QML 调试

### 在 CMakeLists.txt 中

已经配置：

```cmake
target_compile_definitions(appCloudMusic PRIVATE
    $<$<CONFIG:Debug>:QT_QML_DEBUG>
)
```

### 运行时启用

```bash
# 启动应用并等待调试器连接
./appCloudMusic -qmljsdebugger=port:3768,block
```

## 8. 配置 QML Linter

### 启用 qmllint

1. 确保 qmllint 已安装：
   ```bash
   which qmllint
   ```

2. 在 CLion 中配置：
   - `Settings/Preferences` → `Tools` → `External Tools`
   - 点击 "+" 添加新工具
   - Name: `qmllint`
   - Program: `/opt/homebrew/bin/qmllint` (macOS) 或 `/usr/bin/qmllint` (Linux)
   - Arguments: `$FilePath$`
   - Working directory: `$ProjectFileDir$`

### 使用 qmllint

1. 右键点击 QML 文件
2. `External Tools` → `qmllint`
3. 查看输出窗口的警告和错误

## 9. 配置文件关联

### 确保 QML 文件正确识别

1. `Settings/Preferences` → `Editor` → `File Types`
2. 找到 "QML" 文件类型
3. 确保包含 `*.qml` 模式

## 10. 快捷键配置

### 推荐的 QML 快捷键

| 功能 | macOS | Linux/Windows |
|------|-------|---------------|
| 跳转到定义 | Cmd+B | Ctrl+B |
| 查找用法 | Cmd+Alt+F7 | Ctrl+Alt+F7 |
| 重命名 | Shift+F6 | Shift+F6 |
| 格式化代码 | Cmd+Alt+L | Ctrl+Alt+L |
| 优化导入 | Ctrl+Alt+O | Ctrl+Alt+O |
| 快速修复 | Alt+Enter | Alt+Enter |

## 11. 常见问题

### 1. QML 代码没有补全

**解决方案：**
1. 检查 QML Import Paths 是否正确配置
2. 重新加载 CMake 项目
3. 清理缓存：`File` → `Invalidate Caches / Restart`

### 2. 找不到 Qt 模块

**解决方案：**
```cmake
# 在 CMakeLists.txt 中添加
set(CMAKE_PREFIX_PATH "/opt/homebrew/opt/qt@6")
```

### 3. QML 文件显示为纯文本

**解决方案：**
1. 确保安装了 QML Support 插件
2. 检查文件关联：`Settings` → `Editor` → `File Types`

### 4. 无法调试 QML

**解决方案：**
1. 确保 Debug 配置中定义了 `QT_QML_DEBUG`
2. 使用 `-qmljsdebugger` 参数启动应用
3. 在 CLion 中连接到调试端口

### 5. qmldir 文件不生效

**解决方案：**
1. 确保 qmldir 文件在正确的位置
2. 检查 CMakeLists.txt 中的 RESOURCES 配置
3. 重新构建项目

## 12. 高级配置

### 配置 QML 格式化工具

创建 `.qmlformat.ini` 文件：

```ini
[General]
IndentWidth=4
LineLength=120
```

### 配置 QML 类型检查

在项目根目录创建 `.qmllint.ini`：

```ini
[General]
DisableDefaultImports=false
ResourcePath=src/ui

[Warnings]
UnqualifiedAccess=warning
UnusedImports=warning
```

### 使用 Qt Quick Compiler

在 CMakeLists.txt 中：

```cmake
# 启用 QML 缓存
set_target_properties(appCloudMusic PROPERTIES
    QT_QML_GENERATE_QMLCACHE ON
)
```

## 13. 推荐插件

除了 QML Support，还推荐安装：

1. **CMake** - CMake 语法高亮和补全（内置）
2. **Markdown** - 文档编写（内置）
3. **GitToolBox** - Git 增强工具
4. **.ignore** - .gitignore 文件支持

## 14. 性能优化

### 加速 CLion 索引

1. `Settings/Preferences` → `Build, Execution, Deployment` → `CMake`
2. 启用 "Reload CMake project on editing CMakeLists.txt or other CMake configuration files"
3. 排除不需要索引的目录：
   - `build/`
   - `.git/`
   - `node_modules/` (如果有)

### 增加内存

编辑 CLion 的 VM options：
1. `Help` → `Edit Custom VM Options`
2. 增加内存：
   ```
   -Xmx4096m
   -Xms1024m
   ```

## 15. 项目特定配置

### 本项目的配置文件

项目已包含：
- `.clang-format` - C++ 代码格式化
- `.gitignore` - Git 忽略规则
- `CMakeLists.txt` - CMake 配置

### 推荐的 CLion 配置

创建 `.idea/` 目录下的配置（已在 .gitignore 中）：
- 代码风格
- 运行配置
- 调试配置

## 参考资料

- [CLion 官方文档](https://www.jetbrains.com/help/clion/)
- [Qt CMake 手册](https://doc.qt.io/qt-6/cmake-manual.html)
- [QML 最佳实践](https://doc.qt.io/qt-6/qtquick-bestpractices.html)
- [CLion QML 支持](https://www.jetbrains.com/help/clion/qml-support.html)

## 快速检查清单

- [ ] 安装 QML Support 插件
- [ ] 配置 Qt 路径（CMAKE_PREFIX_PATH）
- [ ] 添加 QML Import Paths
- [ ] 重新加载 CMake 项目
- [ ] 测试 QML 代码补全
- [ ] 配置运行/调试配置
- [ ] 启用 QML 调试（QT_QML_DEBUG）
- [ ] 配置 qmllint
- [ ] 测试构建和运行

完成以上配置后，CLion 就可以完美支持 QML 开发了！
