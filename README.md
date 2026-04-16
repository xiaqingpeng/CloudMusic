# CloudMusic

一个基于 Qt6 和 QML 的现代化音乐播放器应用。

## 项目信息

- **版本**: 1.0.0
- **Qt 版本**: 6.2+
- **C++ 标准**: C++17
- **平台**: macOS, Windows, Linux

## 快速开始

### 环境要求

- Qt 6.2 或更高版本
- CMake 3.16+
- C++17 编译器
- macOS: Xcode Command Line Tools

### 构建项目

```bash
# 配置项目
cmake -B build -DCMAKE_BUILD_TYPE=Release

# 编译
cmake --build build

# 运行
./build/appCloudMusic.app/Contents/MacOS/appCloudMusic  # macOS
```

### 使用脚本构建

```bash
# 快速构建和运行
./scripts/build.sh && ./scripts/run.sh

# Debug 模式
./scripts/build.sh --debug

# 清理重建
./scripts/build.sh --clean
```

## 项目结构

```
CloudMusic/
├── src/                    # 源代码
│   ├── core/              # 核心模块（Application, Config, Logger）
│   ├── ui/                # QML 界面文件
│   ├── resources/         # 资源文件（图标、图片）
│   ├── models/            # 数据模型
│   ├── services/          # 服务层
│   └── utils/             # 工具类
├── scripts/               # 构建和打包脚本
├── config/                # 配置文件
├── docs/                  # 文档
│   ├── archive/          # 历史文档
│   └── development/      # 开发文档
├── tests/                 # 测试代码
└── CMakeLists.txt        # CMake 配置
```

## 功能特性

- 🎵 音乐播放控制
- 📝 播放列表管理
- 🔍 搜索功能
- 🎨 主题系统
- 📊 官方歌单展示
- 📚 有声书展示
- 🎬 轮播图
- ⚙️ 配置管理
- 📋 日志系统

## 开发

### 构建选项

```bash
# 启用测试
cmake -B build -DBUILD_TESTS=ON

# 启用文档
cmake -B build -DBUILD_DOCS=ON

# 禁用日志
cmake -B build -DENABLE_LOGGING=OFF
```

### 调试

项目提供了统一的调试脚本，支持本地和远程调试。

```bash
# 本地调试 (macOS)
./scripts/debug.sh local

# 远程调试 (Ubuntu VM)
./scripts/debug.sh remote

# 构建后调试
./scripts/debug.sh local -b
./scripts/debug.sh remote -s -b
```

详见 [调试指南](docs/DEBUGGING_GUIDE.md) 和 [调试速查表](docs/DEBUG_CHEATSHEET.md)

### 代码规范

- 使用 C++17 标准
- 遵循 Qt 编码规范
- 使用智能指针管理内存
- 采用 RAII 原则

详见 [CONTRIBUTING.md](CONTRIBUTING.md)

## 打包发布

### macOS DMG

```bash
cd build
cmake --build . --target packageDmg
```

生成的 DMG 文件位于 `build/CloudMusic-1.0.0.dmg`

## 文档

- [快速开始](QUICK_START.md) - 详细的入门指南
- [项目结构](PROJECT_STRUCTURE.md) - 项目架构说明
- [贡献指南](CONTRIBUTING.md) - 如何参与开发
- [更新日志](CHANGELOG.md) - 版本更新记录
- [开发文档](docs/development/) - 功能开发说明

## 许可证

MIT License

## 联系方式

- 问题反馈: [GitHub Issues](https://github.com/yourusername/CloudMusic/issues)
- 邮箱: support@cloudmusic.com
