# 项目重构迁移指南

本文档说明如何从旧的 CMakeLists.txt 迁移到新的企业级项目结构。

## 主要变更

### 1. CMakeLists.txt 优化

**旧版本：**
```cmake
cmake_minimum_required(VERSION 3.16)
project(CloudMusic VERSION 0.1 LANGUAGES CXX)
```

**新版本：**
```cmake
cmake_minimum_required(VERSION 3.16)
project(CloudMusic 
    VERSION 1.0.0
    DESCRIPTION "CloudMusic - A Modern Qt-based Music Player"
    LANGUAGES CXX
)
```

### 2. 新增构建选项

```cmake
option(BUILD_TESTS "Build unit tests" OFF)
option(BUILD_DOCS "Build documentation" OFF)
option(ENABLE_LOGGING "Enable logging system" ON)
option(ENABLE_ANALYTICS "Enable analytics" OFF)
```

使用方法：
```bash
cmake .. -DBUILD_TESTS=ON -DENABLE_LOGGING=ON
```

### 3. 文件组织优化

QML 文件现在按功能分组：
- `QML_PAGES`: 页面级组件
- `QML_COMPONENTS_COMMON`: 通用组件
- `QML_COMPONENTS_LEFT`: 左侧面板组件
- `QML_COMPONENTS_RIGHT_TOPBAR`: 右侧顶部栏组件
- `QML_COMPONENTS_RIGHT_CONTENT`: 右侧内容组件
- `QML_COMPONENTS_BOTTOM`: 底部播放器组件
- `QML_VIEWMODELS`: 视图模型
- `QML_THEME`: 主题

### 4. 版本管理

新增版本头文件自动生成：

**src/core/Version.h.in:**
```cpp
#define PROJECT_VERSION "@PROJECT_VERSION@"
#define PROJECT_VERSION_MAJOR @PROJECT_VERSION_MAJOR@
```

在代码中使用：
```cpp
#include "Version.h"
qDebug() << "Version:" << PROJECT_VERSION;
```

### 5. 配置文件系统

新增配置文件支持：

**config/app.config.example:**
```ini
[Application]
name=CloudMusic
version=1.0.0

[Network]
api_base_url=https://api.cloudmusic.com
```

### 6. 编译器警告

新增严格的编译器警告：

```cmake
if(MSVC)
    target_compile_options(appCloudMusic PRIVATE /W4)
else()
    target_compile_options(appCloudMusic PRIVATE 
        -Wall -Wextra -Wpedantic
    )
endif()
```

## 迁移步骤

### 步骤 1: 备份现有项目

```bash
cp CMakeLists.txt CMakeLists.txt.backup
```

### 步骤 2: 替换 CMakeLists.txt

```bash
cp CMakeLists_new.txt CMakeLists.txt
```

### 步骤 3: 创建必要的目录结构

```bash
mkdir -p src/core
mkdir -p src/models
mkdir -p src/services
mkdir -p src/utils
mkdir -p tests/unit
mkdir -p tests/integration
mkdir -p docs
mkdir -p config
```

### 步骤 4: 复制版本头文件模板

```bash
cp src/core/Version.h.in src/core/Version.h.in
```

### 步骤 5: 创建配置文件

```bash
cp config/app.config.example config/app.config
# 根据需要修改 config/app.config
```

### 步骤 6: 清理并重新构建

```bash
rm -rf build
mkdir build && cd build
cmake ..
cmake --build .
```

### 步骤 7: 验证构建

```bash
./appCloudMusic
```

## 兼容性说明

### 保持不变的部分

- 所有 QML 文件路径
- 资源文件路径
- 应用程序功能
- UI 界面
- 数据模型

### 新增的部分

- 构建选项
- 版本管理
- 配置系统
- 文档结构
- 测试框架

## 常见问题

### Q: 旧的构建目录还能用吗？

A: 建议删除旧的构建目录，重新构建：
```bash
rm -rf build
mkdir build && cd build
cmake ..
```

### Q: 如何启用测试？

A: 使用 BUILD_TESTS 选项：
```bash
cmake .. -DBUILD_TESTS=ON
cmake --build .
ctest
```

### Q: 版本号在哪里修改？

A: 在 CMakeLists.txt 的 project() 命令中：
```cmake
project(CloudMusic VERSION 1.0.0 ...)
```

### Q: 如何添加新的 QML 文件？

A: 在 CMakeLists.txt 中对应的变量中添加：
```cmake
set(QML_PAGES
    resources/qml/src/Main.qml
    resources/qml/src/NewPage.qml  # 新增
)
```

### Q: 配置文件在哪里？

A: 
- 开发环境: `config/app.config`
- 运行时: 
  - macOS: `~/.cloudmusic/app.config`
  - Windows: `%APPDATA%/CloudMusic/app.config`
  - Linux: `~/.config/cloudmusic/app.config`

## 回滚方案

如果遇到问题，可以回滚到旧版本：

```bash
cp CMakeLists.txt.backup CMakeLists.txt
rm -rf build
mkdir build && cd build
cmake ..
cmake --build .
```

## 后续优化建议

1. **添加单元测试**
   - 在 `tests/unit/` 目录下添加测试文件
   - 使用 Qt Test 框架

2. **实现配置管理**
   - 创建 `src/core/Config.cpp`
   - 读取和解析配置文件

3. **添加日志系统**
   - 创建 `src/core/Logger.cpp`
   - 实现日志级别控制

4. **模块化重构**
   - 将业务逻辑移到 `src/services/`
   - 创建数据模型类

5. **文档完善**
   - 添加 API 文档
   - 添加架构设计文档

## 支持

如有问题，请：
- 查看 [README.md](README.md)
- 查看 [CONTRIBUTING.md](CONTRIBUTING.md)
- 提交 Issue

---

更新日期: 2026-04-16
