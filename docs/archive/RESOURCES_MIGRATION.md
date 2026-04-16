# 资源文件迁移文档

## 迁移概述
将 `resources` 目录下的所有资源文件迁移到 `src` 目录，以符合企业级项目的标准目录结构。

## 迁移详情

### 目录结构变更

#### 迁移前
```
resources/
├── image/
│   └── appicon.png
├── qml/
│   └── src/
│       ├── Main.qml
│       ├── bottompage/
│       ├── commonui/
│       ├── leftpage/
│       ├── righpage/
│       ├── theme/
│       └── viewmodels/
└── qrc/
    └── icon/
        ├── down.svg
        ├── down_s.svg
        ├── left.svg
        ├── mic.svg
        ├── music.svg
        ├── people.svg
        └── setting.svg
```

#### 迁移后
```
src/
├── core/                    # 核心模块
├── models/                  # 数据模型
├── services/                # 服务层
├── utils/                   # 工具类
├── ui/                      # QML 界面文件（原 resources/qml/src）
│   ├── Main.qml
│   ├── bottompage/
│   ├── commonui/
│   ├── leftpage/
│   ├── righpage/
│   ├── theme/
│   └── viewmodels/
└── resources/               # 资源文件
    ├── icons/               # 图标文件（原 resources/qrc/icon）
    │   ├── down.svg
    │   ├── down_s.svg
    │   ├── left.svg
    │   ├── mic.svg
    │   ├── music.svg
    │   ├── people.svg
    │   └── setting.svg
    └── images/              # 图片文件（原 resources/image）
        └── appicon.png
```

## 文件路径更新

### 1. CMakeLists.txt 更新

#### QML 文件路径
```cmake
# 旧路径
resources/qml/src/Main.qml
resources/qml/src/leftpage/MyLeftRect.qml
...

# 新路径
src/ui/Main.qml
src/ui/leftpage/MyLeftRect.qml
...
```

#### 资源文件路径
```cmake
# 旧路径
resources/qrc/icon/left.svg
resources/image/appicon.png

# 新路径
src/resources/icons/left.svg
src/resources/images/appicon.png
```

#### macdeployqt qmldir 路径
```cmake
# 旧路径
-qmldir="${CMAKE_SOURCE_DIR}/resources/qml/src"

# 新路径
-qmldir="${CMAKE_SOURCE_DIR}/src/ui"
```

### 2. Application.cpp 更新

```cpp
// 旧路径
const QUrl url(QStringLiteral("qrc:/qt/qml/CloudMusic/resources/qml/src/Main.qml"));

// 新路径
const QUrl url(QStringLiteral("qrc:/qt/qml/CloudMusic/src/ui/Main.qml"));
```

### 3. QML 文件中的图标路径更新

所有 QML 文件中的图标引用路径已批量更新：

```qml
// 旧路径
source: "qrc:/qt/qml/CloudMusic/resources/qrc/icon/music.svg"
iconSource: "qrc:/qt/qml/CloudMusic/resources/qrc/icon/left.svg"

// 新路径
source: "qrc:/qt/qml/CloudMusic/src/resources/icons/music.svg"
iconSource: "qrc:/qt/qml/CloudMusic/src/resources/icons/left.svg"
```

## 迁移步骤

1. 创建新目录结构
```bash
mkdir -p src/ui src/resources/icons src/resources/images
```

2. 复制文件
```bash
cp -r resources/qml/src/* src/ui/
cp -r resources/qrc/icon/* src/resources/icons/
cp -r resources/image/* src/resources/images/
```

3. 更新 CMakeLists.txt
   - 更新所有 QML 文件路径
   - 更新资源文件路径
   - 更新 macdeployqt qmldir 路径

4. 更新 Application.cpp
   - 更新 Main.qml 加载路径

5. 批量更新 QML 文件中的图标路径
```bash
find src/ui -name "*.qml" -type f -exec sed -i '' 's|qrc:/qt/qml/CloudMusic/resources/qrc/icon|qrc:/qt/qml/CloudMusic/src/resources/icons|g' {} +
```

6. 重新配置和构建
```bash
cmake -B build/unknown-Debug -DCMAKE_BUILD_TYPE=Debug
cmake --build build/unknown-Debug
```

7. 删除旧的 resources 目录
```bash
rm -rf resources
```

## 验证结果

✅ 应用程序成功启动
✅ QML 界面正常加载
✅ 所有图标正常显示
✅ 构建无错误和警告

## 优势

1. **标准化目录结构**：符合企业级项目的标准实践
2. **更好的组织**：UI 代码和资源文件都在 src 目录下
3. **清晰的分类**：icons 和 images 分开存放
4. **易于维护**：所有源代码和资源在同一个顶级目录下

## 注意事项

- Qt 资源系统的路径前缀为 `qrc:/qt/qml/CloudMusic/`
- 所有路径都是相对于项目根目录
- QML 文件路径变更后需要重新配置 CMake
- 图标路径更新需要在所有 QML 文件中进行
