# CloudMusic 快速开始

## 🚀 快速启动

### 方式 1: 使用脚本（推荐）

```bash
# 构建项目
./scripts/build.sh

# 运行应用
./scripts/run.sh
```

### 方式 2: 手动构建

```bash
# 创建构建目录
mkdir build && cd build

# 配置项目
cmake ..

# 编译
cmake --build .

# 运行
./appCloudMusic.app/Contents/MacOS/appCloudMusic
```

## 🛠️ 构建选项

### Debug 构建
```bash
./scripts/build.sh --debug
```

### 清理重新构建
```bash
./scripts/build.sh --clean
```

### 启用测试
```bash
./scripts/build.sh --tests
```

### 启用文档
```bash
./scripts/build.sh --docs
```

### 组合使用
```bash
./scripts/build.sh --clean --debug --tests
```

## 📦 打包

### 创建 DMG 安装包

```bash
cd build
cmake --build . --target packageDmg
```

生成的文件：`build/CloudMusic-1.0.0.dmg`

## 🔧 开发工具

### Qt Creator

1. 打开 Qt Creator
2. 文件 → 打开文件或项目
3. 选择 `CMakeLists.txt`
4. 配置构建套件
5. 点击运行

### VS Code

1. 安装 CMake Tools 扩展
2. 打开项目文件夹
3. Ctrl/Cmd + Shift + P → CMake: Configure
4. Ctrl/Cmd + Shift + P → CMake: Build
5. F5 运行

### Xcode

```bash
cd build
cmake .. -G Xcode
open CloudMusic.xcodeproj
```

## 📝 配置文件

### 创建配置文件

```bash
cp config/app.config.example config/app.config
```

### 编辑配置

```ini
[Application]
name=CloudMusic
version=1.0.0
language=zh_CN

[Network]
api_base_url=https://api.cloudmusic.com
timeout=30000

[Audio]
default_volume=50
buffer_size=4096
```

## 🧪 测试

### 运行测试

```bash
cd build
ctest --output-on-failure
```

### 运行特定测试

```bash
ctest -R AudioServiceTest
```

## 📚 文档

### 生成文档

```bash
./scripts/build.sh --docs
```

文档位置：`build/docs/html/index.html`

## 🐛 调试

### 启用日志

```bash
cmake .. -DENABLE_LOGGING=ON
```

### Debug 构建

```bash
./scripts/build.sh --debug
```

### 使用 lldb (macOS)

```bash
lldb build/appCloudMusic.app/Contents/MacOS/appCloudMusic
(lldb) run
```

## 🔍 常见问题

### Q: 编译失败，提示找不到 Qt

A: 确保 Qt 6.2+ 已安装并设置环境变量：
```bash
export Qt6_DIR=/path/to/Qt/6.x.x/macos/lib/cmake/Qt6
```

### Q: 运行时找不到 QML 模块

A: 检查 QML 导入路径：
```bash
export QML_IMPORT_PATH=/path/to/Qt/6.x.x/macos/qml
```

### Q: 如何清理构建

A: 删除构建目录：
```bash
rm -rf build
```

或使用脚本：
```bash
./scripts/build.sh --clean
```

### Q: 如何回滚到旧版本

A: 恢复备份的 CMakeLists.txt：
```bash
cp CMakeLists.txt.backup CMakeLists.txt
rm -rf build
mkdir build && cd build
cmake ..
cmake --build .
```

## 📖 更多信息

- [项目结构](PROJECT_STRUCTURE.md)
- [README](README.md)
- [贡献指南](CONTRIBUTING.md)
- [迁移指南](MIGRATION_GUIDE.md)
- [迁移完成报告](MIGRATION_COMPLETED.md)

## 💡 提示

- 使用 `--help` 查看脚本帮助：
  ```bash
  ./scripts/build.sh --help
  ```

- 查看构建配置摘要：
  ```bash
  cd build
  cmake .. 2>&1 | grep -A 10 "Configuration Summary"
  ```

- 检查应用程序信息：
  ```bash
  file build/appCloudMusic.app/Contents/MacOS/appCloudMusic
  ```

---

祝你开发愉快！🎉
