# CloudMusic 项目结构

## 目录结构

```
CloudMusic/
├── src/                          # C++ 源代码
│   ├── main.cpp                  # 应用程序入口
│   ├── core/                     # 核心模块
│   │   ├── Application.h/cpp     # 应用程序类
│   │   ├── Config.h/cpp          # 配置管理
│   │   └── Logger.h/cpp          # 日志系统
│   ├── models/                   # 数据模型
│   │   ├── PlaylistModel.h/cpp   # 歌单模型
│   │   ├── SongModel.h/cpp       # 歌曲模型
│   │   └── AudioBookModel.h/cpp  # 有声书模型
│   ├── services/                 # 业务服务
│   │   ├── AudioService.h/cpp    # 音频服务
│   │   ├── NetworkService.h/cpp  # 网络服务
│   │   └── CacheService.h/cpp    # 缓存服务
│   └── utils/                    # 工具类
│       ├── FileUtils.h/cpp       # 文件工具
│       └── StringUtils.h/cpp     # 字符串工具
├── resources/                    # 资源文件
│   ├── qml/                      # QML 文件
│   │   └── src/
│   │       ├── Main.qml
│   │       ├── pages/            # 页面组件
│   │       ├── components/       # 通用组件
│   │       ├── viewmodels/       # 视图模型
│   │       └── theme/            # 主题
│   ├── qrc/                      # 资源文件
│   │   └── icon/                 # 图标
│   └── image/                    # 图片
├── tests/                        # 测试代码
│   ├── unit/                     # 单元测试
│   └── integration/              # 集成测试
├── docs/                         # 文档
│   ├── api/                      # API 文档
│   ├── design/                   # 设计文档
│   └── user/                     # 用户文档
├── scripts/                      # 构建脚本
├── cmake/                        # CMake 模块
└── CMakeLists.txt               # 主构建文件
```

## 模块说明

### Core 模块
- **Application**: 应用程序生命周期管理
- **Config**: 配置文件读写、环境变量管理
- **Logger**: 日志记录、日志级别控制

### Models 模块
- 数据模型定义
- 数据验证
- 数据序列化/反序列化

### Services 模块
- **AudioService**: 音频播放、暂停、进度控制
- **NetworkService**: HTTP 请求、API 调用
- **CacheService**: 本地缓存管理

### Utils 模块
- 通用工具函数
- 跨平台兼容性处理

## 设计原则

1. **单一职责原则**: 每个类只负责一个功能
2. **依赖注入**: 通过构造函数或 setter 注入依赖
3. **接口隔离**: 定义清晰的接口，降低耦合
4. **开闭原则**: 对扩展开放，对修改关闭
5. **模块化**: 功能模块独立，便于测试和维护
