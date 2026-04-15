# 嵌入式 Qt + 车载开发技能要求

## 职位定位
- 嵌入式 Qt 开发工程师
- 车载系统开发工程师
- 嵌入式 Linux 车载开发
- 目标薪资：RMB 40K+/月

---

## 核心技能要求

### 1. Qt/QML 开发（必须精通）

#### 1.1 Qt Framework 核心
- **Qt Core 模块**
  - QObject 对象模型和生命周期管理
  - 元对象系统（Meta-Object System）
  - 信号槽机制（Signal & Slot）
    - 直接连接、队列连接、自动连接
    - Lambda 表达式连接
    - 跨线程信号槽
  - 属性系统（Property System）
  - 事件系统（Event System）
    - 事件过滤器（Event Filter）
    - 自定义事件
    - 事件循环机制
  - 容器类（QList, QVector, QMap, QHash）
  - 字符串处理（QString, QByteArray）
  - 文件和 I/O（QFile, QDataStream, QTextStream）
  - 定时器（QTimer, QElapsedTimer）

- **Qt GUI 模块**
  - 图形视图框架（Graphics View Framework）
  - 2D 绘图（QPainter, QPaintDevice）
  - 图像处理（QImage, QPixmap）
  - 字体和文本渲染
  - 拖放操作（Drag & Drop）
  - 剪贴板操作

- **Qt Widgets（传统 UI）**
  - 常用控件（QLabel, QPushButton, QLineEdit 等）
  - 布局管理（QLayout, QHBoxLayout, QVBoxLayout, QGridLayout）
  - 对话框（QDialog, QMessageBox, QFileDialog）
  - 主窗口架构（QMainWindow, QDockWidget, QToolBar）
  - Model/View 架构
    - QAbstractItemModel
    - QTableView, QListView, QTreeView
    - 自定义委托（QStyledItemDelegate）
  - 样式表（QSS - Qt Style Sheets）

- **Qt Quick / QML 2.x**
  - QML 引擎和运行时
  - Qt Quick Scene Graph
  - Qt Quick Compiler
  - Qt Quick 3D

#### 1.2 QML 深度开发
- **QML 语法精通**
  - 声明式语法和属性绑定
  - 属性别名（property alias）
  - 附加属性（Attached Properties）
  - 默认属性（default property）
  - 必需属性（required property）
  - 枚举类型定义
  - 组件生命周期（Component.onCompleted, Component.onDestruction）

- **QML 组件开发**
  - 自定义可复用组件
  - 组件继承和扩展
  - 单例模式（pragma Singleton）
  - 组件加载器（Loader, Component）
  - 动态对象创建（Qt.createComponent, Qt.createQmlObject）

- **JavaScript 集成**
  - QML 中的 JavaScript 表达式
  - JavaScript 函数定义
  - 导入 JavaScript 文件（.js）
  - JavaScript 模块化
  - 与 C++ 的数据交互

- **Qt Quick Controls 2**
  - Material 风格
  - Universal 风格
  - 自定义主题和样式
  - 控件定制（Button, TextField, ComboBox 等）
  - 响应式布局

- **QML 动画和过渡**
  - 属性动画（PropertyAnimation）
  - 数字动画（NumberAnimation）
  - 颜色动画（ColorAnimation）
  - 序列动画（SequentialAnimation）
  - 并行动画（ParallelAnimation）
  - 路径动画（PathAnimation）
  - 状态和过渡（State, Transition）
  - 行为动画（Behavior）
  - 弹簧动画（SpringAnimation）

- **QML 性能优化**
  - 避免不必要的属性绑定
  - 使用 Loader 延迟加载
  - 列表视图优化（ListView, GridView）
    - 缓存策略（cacheBuffer）
    - 异步加载
    - 重用机制
  - 减少 JavaScript 计算
  - 使用 C++ 处理复杂逻辑
  - Scene Graph 优化
  - 纹理图集（Texture Atlas）
  - 批处理渲染

#### 1.3 C++ 与 QML 深度集成
- **数据暴露给 QML**
  - Q_PROPERTY 宏详解
    - READ, WRITE, NOTIFY, RESET
    - CONSTANT, FINAL
    - MEMBER, REVISION
  - Q_INVOKABLE 方法
  - Q_ENUM / Q_FLAG 枚举注册
  - Context Properties（setContextProperty）
  - QML 单例注册（qmlRegisterSingletonType）

- **QML 类型注册**
  - qmlRegisterType - 注册可实例化类型
  - qmlRegisterUncreatableType - 注册不可实例化类型
  - qmlRegisterSingletonType - 注册单例
  - qmlRegisterInterface - 注册接口
  - QML_ELEMENT, QML_SINGLETON 宏（Qt 6）
  - 类型版本控制

- **Model/View 架构**
  - QAbstractListModel 实现
  - QAbstractTableModel 实现
  - 角色（Role）定义和使用
  - 数据更新通知（dataChanged, beginInsertRows 等）
  - 自定义排序和过滤（QSortFilterProxyModel）
  - 树形模型（QAbstractItemModel）

- **高级交互**
  - QML 调用 C++ 方法
  - C++ 调用 QML 方法（QMetaObject::invokeMethod）
  - 信号槽跨语言连接
  - QVariant 类型转换
  - 自定义类型注册（Q_DECLARE_METATYPE）
  - QML 对象所有权管理

#### 1.4 Qt 多线程编程
- **线程基础**
  - QThread 类使用
  - 线程创建和管理
  - 线程优先级设置
  - 线程亲和性（Thread Affinity）

- **线程间通信**
  - 信号槽跨线程通信
  - 队列连接（Qt::QueuedConnection）
  - 事件循环和消息队列
  - QMetaObject::invokeMethod 跨线程调用

- **并发编程**
  - QtConcurrent 框架
    - map, filter, reduce
    - run 异步执行
  - QFuture 和 QFutureWatcher
  - QThreadPool 线程池

- **线程同步**
  - QMutex 互斥锁
  - QReadWriteLock 读写锁
  - QSemaphore 信号量
  - QWaitCondition 条件变量
  - QAtomicInteger 原子操作
  - 死锁预防

- **线程安全设计**
  - 可重入函数设计
  - 线程局部存储（QThreadStorage）
  - 无锁编程技巧
  - 线程安全的单例模式

#### 1.5 Qt 网络编程
- **TCP/IP 编程**
  - QTcpSocket 客户端
  - QTcpServer 服务器
  - 异步 I/O 处理
  - 数据包封装和解析

- **UDP 编程**
  - QUdpSocket
  - 广播和组播

- **HTTP 通信**
  - QNetworkAccessManager
  - QNetworkRequest / QNetworkReply
  - RESTful API 调用
  - JSON 数据解析（QJsonDocument）
  - SSL/TLS 加密通信

- **WebSocket**
  - QWebSocket 客户端
  - QWebSocketServer 服务器
  - 实时双向通信

#### 1.6 Qt 数据库
- **SQL 数据库**
  - QSqlDatabase 连接管理
  - QSqlQuery 查询执行
  - QSqlTableModel / QSqlRelationalTableModel
  - 事务处理
  - 预编译语句（Prepared Statements）
  - SQLite 嵌入式数据库

#### 1.7 Qt 序列化
- **数据持久化**
  - QSettings 配置管理
  - QDataStream 二进制序列化
  - JSON 序列化（QJsonDocument, QJsonObject）
  - XML 处理（QXmlStreamReader, QXmlStreamWriter）
  - 自定义类型序列化

### 2. 嵌入式 Linux 系统（核心能力）

#### 2.1 Linux 内核深入理解
- **内核架构**
  - 内核空间 vs 用户空间
  - 系统调用接口
  - 内核模块（Loadable Kernel Modules）
  - 内核配置和编译（make menuconfig）
  - 内核启动流程

- **进程管理**
  - 进程创建（fork, exec）
  - 进程调度算法（CFS, RT）
  - 进程优先级和 nice 值
  - 进程状态和生命周期
  - 僵尸进程和孤儿进程处理
  - 进程间关系（父子、会话、进程组）

- **内存管理**
  - 虚拟内存机制
  - 页表和 MMU
  - 内存分配（kmalloc, vmalloc）
  - Slab 分配器
  - OOM Killer
  - 内存映射（mmap）
  - 共享内存
  - 内存碎片管理

- **文件系统**
  - VFS（虚拟文件系统）
  - ext4 文件系统
  - squashfs（只读压缩文件系统）
  - ubifs（NAND Flash 文件系统）
  - tmpfs / ramfs（内存文件系统）
  - overlayfs（联合文件系统）
  - 文件系统挂载和卸载
  - inode 和 dentry 缓存

- **I/O 系统**
  - 块设备和字符设备
  - I/O 调度器（CFQ, Deadline, NOOP）
  - 直接 I/O（Direct I/O）
  - 异步 I/O（AIO）
  - 页缓存（Page Cache）
  - 缓冲区管理

#### 2.2 设备驱动开发
- **字符设备驱动**
  - 设备号分配（主设备号、次设备号）
  - file_operations 结构
  - open, read, write, ioctl 实现
  - 设备文件创建（mknod, udev）

- **块设备驱动**
  - request_queue 管理
  - bio 结构处理
  - 块设备注册

- **网络设备驱动**
  - net_device 结构
  - sk_buff 数据包处理
  - NAPI 机制

- **平台设备驱动**
  - platform_device / platform_driver
  - 设备树（Device Tree）绑定
  - 资源管理（内存、中断、DMA）

- **中断处理**
  - 中断注册（request_irq）
  - 中断处理函数（top half）
  - 软中断和 tasklet（bottom half）
  - 工作队列（workqueue）
  - 中断共享
  - 中断线程化

- **DMA 操作**
  - DMA 缓冲区分配
  - 一致性 DMA vs 流式 DMA
  - DMA 映射和同步
  - Scatter-Gather DMA

- **常见总线驱动**
  - I2C 驱动开发
  - SPI 驱动开发
  - USB 驱动开发
  - PCI/PCIe 驱动开发
  - CAN 总线驱动

#### 2.3 嵌入式 Linux 构建系统
- **Yocto Project**
  - BitBake 构建引擎
  - Recipe 编写（.bb, .bbappend）
  - Layer 管理
  - 镜像定义（image recipe）
  - 包管理（RPM, DEB, IPK）
  - SDK 生成
  - 交叉编译工具链
  - 依赖关系管理
  - 补丁管理

- **Buildroot**
  - Kconfig 配置系统
  - Makefile 基础
  - 包定义（.mk 文件）
  - 根文件系统定制
  - 外部工具链集成

- **交叉编译**
  - 工具链组成（gcc, binutils, glibc/musl）
  - sysroot 概念
  - 交叉编译 CMake 配置
  - 交叉编译 Qt 应用
  - 库依赖处理

#### 2.4 引导加载程序
- **U-Boot**
  - U-Boot 配置和编译
  - 启动流程
  - 环境变量设置
  - 启动脚本编写
  - 网络启动（TFTP, NFS）
  - Flash 烧写
  - 设备树加载

- **其他 Bootloader**
  - GRUB（x86 平台）
  - Barebox

#### 2.5 设备树（Device Tree）
- **DTS/DTB 基础**
  - 设备树语法
  - 节点和属性定义
  - phandle 引用
  - 设备树编译（dtc）
  - 设备树覆盖（overlay）

- **设备树绑定**
  - 驱动与设备树匹配
  - compatible 属性
  - 资源获取（reg, interrupts, clocks）
  - GPIO 和 Pinctrl 配置

#### 2.6 系统初始化
- **Init 系统**
  - SysVinit
  - Systemd
    - Unit 文件编写
    - Service 管理
    - Target 依赖
    - 日志管理（journalctl）
    - 定时任务（timer）
  - BusyBox init

- **启动优化**
  - 启动时间分析（bootchart, systemd-analyze）
  - 并行启动
  - 延迟启动
  - 预加载优化

#### 2.7 实时性能（RTOS 特性）
- **实时 Linux**
  - PREEMPT_RT 补丁
  - 实时内核配置
  - 中断线程化
  - 优先级继承
  - 实时调度策略（SCHED_FIFO, SCHED_RR）

- **实时性能调优**
  - CPU 亲和性设置
  - 中断亲和性
  - 内存锁定（mlockall）
  - 禁用页交换
  - 实时优先级设置
  - 延迟测试（cyclictest）

- **时间管理**
  - 高精度定时器（hrtimer）
  - POSIX 定时器
  - 时钟源选择
  - TSC（Time Stamp Counter）

#### 2.8 调试和性能分析
- **内核调试**
  - printk 和 dmesg
  - ftrace 跟踪
  - kgdb 内核调试器
  - KASAN（内核地址消毒器）
  - UBSAN（未定义行为消毒器）
  - kdump 崩溃转储

- **用户空间调试**
  - GDB 调试
  - strace 系统调用跟踪
  - ltrace 库调用跟踪
  - Valgrind 内存检测
  - AddressSanitizer

- **性能分析**
  - perf 性能分析工具
  - oprofile
  - 火焰图（Flame Graph）
  - CPU 使用率分析
  - 内存使用分析
  - I/O 性能分析

#### 2.9 进程间通信（IPC）
- **传统 IPC**
  - 管道（pipe, FIFO）
  - 信号（signal）
  - 消息队列（message queue）
  - 共享内存（shared memory）
  - 信号量（semaphore）

- **现代 IPC**
  - Unix Domain Socket
  - D-Bus
    - D-Bus 架构（系统总线、会话总线）
    - 服务注册和发现
    - 方法调用、信号、属性
    - GDBus / QtDBus
  - Binder（Android）

- **网络 IPC**
  - TCP/IP Socket
  - UDP Socket
  - ZeroMQ
  - gRPC

### 3. 车载系统专业知识（行业特定）

#### 3.1 车载通信协议
- **CAN（Controller Area Network）**
  - CAN 2.0A / 2.0B 标准
  - CAN-FD（Flexible Data-Rate）
  - 帧格式（数据帧、远程帧、错误帧）
  - 仲裁机制和优先级
  - 位填充和 CRC 校验
  - 错误检测和处理
  - SocketCAN 编程
  - CAN 数据库（DBC 文件）
  - CANopen 协议
  - J1939 协议（商用车）

- **LIN（Local Interconnect Network）**
  - LIN 总线架构（主从模式）
  - LIN 帧结构
  - 调度表（Schedule Table）
  - LDF 文件（LIN Description File）
  - 诊断服务

- **FlexRay**
  - FlexRay 架构（双通道冗余）
  - 时间触发通信
  - 静态段和动态段
  - FIBEX 文件格式
  - FlexRay 集群配置

- **车载以太网**
  - 100BASE-T1 / 1000BASE-T1
  - AVB（Audio Video Bridging）
    - gPTP 时间同步
    - FQTSS 流量整形
    - AVTP 传输协议
  - TSN（Time-Sensitive Networking）
    - 时间同步
    - 流量调度
    - 帧抢占
  - DoIP（Diagnostics over IP）

- **SOME/IP（Scalable service-Oriented MiddlewarE over IP）**
  - 服务发现（Service Discovery）
  - 方法调用（Method Call）
  - 事件通知（Event Notification）
  - 字段访问（Field Access）
  - SOME/IP-SD 协议
  - vsomeip 开源实现
  - FIDL（Franca IDL）接口定义

- **其他协议**
  - MOST（Media Oriented Systems Transport）- 多媒体
  - Ethernet/IP
  - MQTT（车联网）
  - DDS（Data Distribution Service）

#### 3.2 AUTOSAR（Automotive Open System Architecture）
- **AUTOSAR 架构**
  - Classic AUTOSAR vs Adaptive AUTOSAR
  - 分层架构（应用层、RTE、BSW）
  - ECU 软件架构

- **Classic AUTOSAR**
  - Software Component（SWC）
  - Runtime Environment（RTE）
  - Basic Software（BSW）
    - OS 层
    - 通信层（COM, PDU Router, CAN/LIN Driver）
    - 诊断层（DCM, DEM）
    - 内存层（NvM, MemIf, Fee, Fls）
  - ARXML 配置文件
  - 配置工具（DaVinci, EB tresos）

- **Adaptive AUTOSAR**
  - 基于 POSIX 的操作系统
  - ara::com 通信中间件
  - ara::exec 执行管理
  - ara::per 持久化存储
  - ara::diag 诊断
  - ara::log 日志
  - Manifest 配置
  - Service-Oriented Architecture（SOA）

- **AUTOSAR 方法论**
  - 系统设计
  - ECU 提取
  - 软件组件设计
  - 配置和集成
  - 代码生成

#### 3.3 车载中间件平台
- **GENIVI（已并入 COVESA）**
  - GENIVI 架构
  - 核心组件
    - Audio Manager
    - Node State Manager
    - Persistence
    - CommonAPI（IPC 框架）
  - GENIVI 合规性

- **AGL（Automotive Grade Linux）**
  - AGL 平台架构
  - AGL 应用框架
  - App Framework Binder
  - Wayland/Weston 显示
  - PipeWire 音频
  - CAN 和车辆信号
  - AGL Demo 平台

- **Qt Automotive Suite**
  - Qt IVI（In-Vehicle Infotainment）
  - Qt Application Manager
  - Qt GENIVI Extras
  - Qt Safe Renderer
  - Neptune 3 UI 参考设计
  - Qt for Automation

- **Android Automotive OS**
  - AAOS 架构
  - Vehicle HAL
  - Car Service
  - Car App Library
  - 与 Android Auto 的区别

#### 3.4 功能安全（ISO 26262）
- **ISO 26262 标准**
  - ASIL 等级（A, B, C, D）
  - V 模型开发流程
  - 安全生命周期
  - 危害分析和风险评估（HARA）
  - 安全目标（Safety Goals）
  - 技术安全要求（TSR）

- **安全机制**
  - 故障检测
  - 故障容错
  - 冗余设计
  - 看门狗（Watchdog）
  - 内存保护（MPU/MMU）
  - CRC 校验
  - E2E 保护（End-to-End）

- **软件开发要求**
  - 编码规范（MISRA C/C++）
  - 静态代码分析
  - 单元测试覆盖率
  - 集成测试
  - 需求追溯
  - 配置管理

- **安全分析方法**
  - FMEA（失效模式与影响分析）
  - FTA（故障树分析）
  - FMEDA（失效模式影响及诊断分析）
  - DFA（相关失效分析）

#### 3.5 车载诊断
- **UDS（Unified Diagnostic Services - ISO 14229）**
  - 诊断会话控制
  - ECU 复位
  - 安全访问
  - 通信控制
  - 读写数据（DID）
  - 故障码管理（DTC）
  - 例程控制
  - 数据传输（下载/上传）
  - 刷写（Flash Programming）

- **OBD-II（On-Board Diagnostics）**
  - OBD-II 标准
  - PID（Parameter ID）
  - 故障码读取
  - 排放相关诊断

- **DoIP（Diagnostics over IP）**
  - DoIP 协议栈
  - 车辆识别
  - 路由激活
  - 诊断消息传输

- **诊断工具**
  - CANoe / CANalyzer（Vector）
  - INCA（ETAS）
  - ODX（Open Diagnostic Data Exchange）

#### 3.6 车辆信号和数据
- **VSS（Vehicle Signal Specification）**
  - VSS 数据模型
  - 信号树结构
  - VISS（Vehicle Information Service Specification）
  - W3C 车辆数据标准

- **DDS（Data Distribution Service）**
  - 发布-订阅模式
  - QoS 策略
  - 实时数据分发
  - RTI Connext DDS

#### 3.7 车载安全（Cybersecurity）
- **ISO/SAE 21434**
  - 网络安全管理
  - 威胁分析和风险评估（TARA）
  - 安全概念
  - 安全要求

- **安全技术**
  - 安全启动（Secure Boot）
  - 固件签名验证
  - 加密通信（TLS/DTLS）
  - 密钥管理
  - HSM（Hardware Security Module）
  - 入侵检测系统（IDS）
  - 防火墙

- **OTA 安全**
  - 差分更新
  - 回滚保护
  - A/B 分区
  - 更新验证

### 4. 图形和多媒体（重要）

#### 4.1 图形渲染技术
- **OpenGL ES**
  - OpenGL ES 2.0 / 3.0 / 3.1
  - 着色器编程（GLSL）
    - 顶点着色器（Vertex Shader）
    - 片段着色器（Fragment Shader）
    - 几何着色器（Geometry Shader）
  - 纹理映射
  - 帧缓冲对象（FBO）
  - 顶点缓冲对象（VBO）
  - 顶点数组对象（VAO）
  - 混合和透明
  - 深度测试和模板测试
  - 抗锯齿（MSAA, FXAA）

- **Vulkan**
  - Vulkan 架构
  - 实例和设备
  - 命令缓冲区
  - 渲染通道
  - 管线状态对象
  - 描述符集
  - 同步原语（Fence, Semaphore）
  - 内存管理
  - SPIR-V 着色器

- **EGL（Embedded-System Graphics Library）**
  - EGL 上下文创建
  - Surface 管理
  - 与 Wayland/X11 集成
  - 多缓冲渲染

- **Qt 图形栈**
  - Qt Quick Scene Graph
    - 场景图节点
    - 批处理渲染
    - 材质系统
    - 自定义渲染节点
  - Qt RHI（Rendering Hardware Interface）
  - QPainter 硬件加速
  - Qt 3D 框架
    - 实体-组件系统
    - 材质和效果
    - 帧图（Frame Graph）

- **2D 图形加速**
  - Skia 图形库
  - Cairo 图形库
  - 矢量图形渲染
  - 路径填充和描边
  - 图像合成

#### 4.2 显示系统
- **Wayland**
  - Wayland 协议
  - Compositor 开发
  - Weston 参考实现
  - Qt Wayland Compositor
  - 多屏幕支持
  - 输入事件处理
  - Buffer 管理

- **X11（传统）**
  - X Server / X Client
  - Xlib / XCB
  - 窗口管理器

- **DRM/KMS（Direct Rendering Manager / Kernel Mode Setting）**
  - DRM 驱动架构
  - KMS 显示配置
  - GEM（Graphics Execution Manager）
  - DMA-BUF 共享
  - Atomic Mode Setting
  - 多显示器配置

- **帧缓冲（Framebuffer）**
  - /dev/fb 设备
  - 直接帧缓冲访问
  - 双缓冲/三缓冲
  - VSync 同步

#### 4.3 多媒体框架
- **GStreamer**
  - GStreamer 架构
  - Element / Pad / Bin / Pipeline
  - 插件开发
  - 常用插件
    - 解复用器（demuxer）
    - 解码器（decoder）
    - 编码器（encoder）
    - 复用器（muxer）
    - 音视频同步
  - GStreamer 命令行工具（gst-launch）
  - 与 Qt 集成（QGst）
  - 硬件加速（VA-API, VDPAU, V4L2）

- **FFmpeg**
  - libavcodec（编解码）
  - libavformat（封装格式）
  - libavfilter（滤镜）
  - libswscale（图像缩放）
  - libswresample（音频重采样）
  - FFmpeg API 编程
  - 硬件加速（VAAPI, NVDEC, QSV）

- **Qt Multimedia**
  - QMediaPlayer
  - QCamera
  - QAudioInput / QAudioOutput
  - QVideoWidget / QVideoSink
  - 自定义视频输出

#### 4.4 音频系统
- **ALSA（Advanced Linux Sound Architecture）**
  - ALSA 架构
  - PCM 设备操作
  - 音频参数配置（采样率、位深、通道）
  - 混音器控制
  - ALSA 插件

- **PulseAudio**
  - PulseAudio 架构
  - 音频路由
  - 音量控制
  - 多应用音频混合
  - 网络音频传输

- **PipeWire**
  - PipeWire 架构（新一代音频服务器）
  - 低延迟音频
  - 视频流支持
  - 与 PulseAudio 兼容

- **JACK（JACK Audio Connection Kit）**
  - 专业音频路由
  - 低延迟实时音频

- **音频编解码**
  - AAC, MP3, Opus, Vorbis
  - FLAC（无损）
  - 音频 DSP 处理
  - 均衡器、混响、压缩器

#### 4.5 视频编解码
- **视频编码标准**
  - H.264 / AVC
  - H.265 / HEVC
  - VP8 / VP9
  - AV1
  - MPEG-2, MPEG-4

- **硬件加速**
  - VA-API（Video Acceleration API）- Intel/AMD
  - VDPAU（Video Decode and Presentation API）- NVIDIA
  - V4L2（Video4Linux2）- 嵌入式平台
  - OMX（OpenMAX）- ARM 平台
  - NVDEC / NVENC（NVIDIA）
  - QSV（Quick Sync Video）- Intel

- **视频容器格式**
  - MP4, MKV, AVI, MOV
  - MPEG-TS（传输流）
  - WebM

#### 4.6 Camera 和图像处理
- **V4L2（Video4Linux2）**
  - V4L2 设备操作
  - 视频捕获
  - 格式协商
  - Buffer 管理（mmap, userptr, dmabuf）
  - 控制接口

- **图像处理**
  - OpenCV
    - 图像滤波
    - 边缘检测
    - 特征提取
    - 目标检测
  - 图像格式转换（YUV, RGB, NV12）
  - 图像缩放和裁剪
  - 色彩空间转换

- **ISP（Image Signal Processor）**
  - 去噪
  - 白平衡
  - 曝光控制
  - HDR 处理

#### 4.7 3D 图形和渲染
- **Qt 3D**
  - 场景管理
  - 实体-组件系统
  - 材质和着色器
  - 光照和阴影
  - 物理引擎集成

- **高级渲染技术**
  - PBR（基于物理的渲染）
  - 延迟渲染
  - 阴影映射
  - 环境光遮蔽（SSAO）
  - 后处理效果
  - 粒子系统

#### 4.8 UI 渲染优化
- **性能优化**
  - 减少过度绘制
  - 纹理压缩（ETC2, ASTC）
  - Mipmap 生成
  - 批处理渲染
  - 视锥剔除
  - LOD（Level of Detail）

- **内存优化**
  - 纹理图集（Texture Atlas）
  - 资源池管理
  - 延迟加载
  - 资源卸载策略

- **帧率优化**
  - VSync 控制
  - 帧率限制
  - 动态分辨率
  - 异步渲染

### 5. 硬件平台经验

#### 5.1 主流车载芯片平台
- **NXP i.MX 系列**
  - i.MX6（Cortex-A9, 四核）
    - 多媒体处理能力
    - 双显示输出
    - CAN-FD 支持
  - i.MX8（Cortex-A53/A72）
    - 高性能计算
    - 虚拟化支持
    - 多核异构架构
  - i.MX8M Plus
    - NPU（神经网络处理单元）
    - ISP 图像处理
    - 4K 视频编解码
  - BSP 开发和定制
  - Yocto 层适配

- **Qualcomm Snapdragon Automotive**
  - SA8155P / SA8295P
  - Kryo CPU 架构
  - Adreno GPU
  - Hexagon DSP
  - 5G 连接
  - 计算机视觉加速
  - Android Automotive OS 支持

- **Renesas R-Car 系列**
  - R-Car H3 / M3 / E3
  - ARM Cortex-A57/A53
  - PowerVR GPU
  - 车载以太网 AVB
  - CAN-FD 控制器
  - 功能安全支持（ASIL-D）
  - Hypervisor 虚拟化

- **TI Jacinto 系列**
  - TDA4VM（视觉处理）
  - DRA8xx（信息娱乐）
  - ARM Cortex-A72 + R5F
  - C7x DSP
  - 深度学习加速器
  - ADAS 应用

- **NVIDIA Drive 平台**
  - Drive AGX Orin
  - Drive AGX Xavier
  - CUDA 编程
  - TensorRT 推理
  - 自动驾驶计算
  - 多传感器融合

- **Intel / AMD x86 平台**
  - Apollo Lake / Elkhart Lake
  - Ryzen Embedded
  - 高性能计算
  - 虚拟化技术
  - 多操作系统支持

#### 5.2 硬件接口开发
- **GPIO（General Purpose I/O）**
  - GPIO 子系统
  - sysfs 接口
  - libgpiod 库
  - 中断触发（边沿、电平）
  - GPIO 复用（Pinmux）

- **I2C（Inter-Integrated Circuit）**
  - I2C 协议
  - 主从模式
  - 设备地址
  - 寄存器读写
  - i2c-tools 工具集
  - 内核 I2C 驱动框架

- **SPI（Serial Peripheral Interface）**
  - SPI 协议（MOSI, MISO, SCK, CS）
  - 全双工通信
  - 时钟极性和相位
  - spidev 用户空间接口
  - SPI Flash 操作

- **UART（Universal Asynchronous Receiver/Transmitter）**
  - 串口通信
  - 波特率配置
  - 流控制（RTS/CTS）
  - termios 配置
  - RS-232 / RS-485

- **PWM（Pulse Width Modulation）**
  - PWM 控制
  - 占空比调节
  - 频率设置
  - 背光控制
  - 电机控制

- **ADC/DAC（模数/数模转换）**
  - IIO（Industrial I/O）子系统
  - 电压采集
  - 传感器数据读取

#### 5.3 显示接口
- **LVDS（Low-Voltage Differential Signaling）**
  - LVDS 时序配置
  - 单通道/双通道
  - 显示参数设置

- **MIPI-DSI（Display Serial Interface）**
  - MIPI-DSI 协议
  - 命令模式 vs 视频模式
  - Lane 配置
  - 面板初始化序列

- **HDMI / DisplayPort**
  - HDMI 驱动
  - EDID 读取
  - 音频传输
  - HDCP 加密

- **eDP（Embedded DisplayPort）**
  - eDP 配置
  - 面板自刷新（PSR）

#### 5.4 触摸屏技术
- **电容触摸**
  - 多点触控
  - I2C 触摸控制器
  - 触摸事件上报
  - 手势识别

- **电阻触摸**
  - 单点触控
  - ADC 采样

- **Linux Input 子系统**
  - evdev 接口
  - 输入事件类型（EV_ABS, EV_KEY）
  - 多点触控协议（Protocol A/B）
  - libinput 库

- **触摸校准**
  - 坐标映射
  - 旋转和镜像
  - tslib 库

#### 5.5 音频接口
- **I2S（Inter-IC Sound）**
  - I2S 协议
  - 主从模式
  - 时钟配置
  - DMA 传输

- **PCM（Pulse Code Modulation）**
  - PCM 接口
  - TDM（Time Division Multiplexing）

- **Codec 芯片**
  - 音频 Codec 驱动
  - ALSA Codec 框架
  - 音频路由配置
  - 音量控制

- **数字音频接口**
  - S/PDIF
  - HDMI Audio
  - USB Audio

#### 5.6 存储设备
- **eMMC / SD Card**
  - MMC 子系统
  - 分区管理
  - 文件系统选择
  - 磨损均衡

- **NAND Flash**
  - MTD（Memory Technology Device）
  - UBI（Unsorted Block Images）
  - UBIFS 文件系统
  - 坏块管理

- **NOR Flash**
  - SPI NOR Flash
  - 启动代码存储
  - 配置数据存储

- **NVMe SSD**
  - PCIe 接口
  - 高速存储
  - 企业级应用

#### 5.7 网络接口
- **Ethernet**
  - MAC 控制器
  - PHY 芯片
  - MDIO 接口
  - 网络驱动开发
  - TSN 配置

- **Wi-Fi**
  - 802.11 a/b/g/n/ac/ax
  - cfg80211 / mac80211
  - wpa_supplicant
  - hostapd（AP 模式）

- **Bluetooth**
  - BlueZ 协议栈
  - HCI 接口
  - A2DP 音频
  - HFP 免提
  - BLE（低功耗蓝牙）

- **4G/5G 模组**
  - USB 接口
  - AT 命令
  - PPP 拨号
  - QMI 协议

#### 5.8 电源管理
- **PMIC（Power Management IC）**
  - 电源域管理
  - 电压调节
  - 电源序列
  - 电池管理

- **Linux 电源管理**
  - Runtime PM
  - System Suspend/Resume
  - CPU 频率调节（cpufreq）
  - CPU 空闲管理（cpuidle）
  - 设备电源状态

- **低功耗设计**
  - 休眠模式
  - 唤醒源配置
  - 功耗测量
  - 功耗优化策略

#### 5.9 传感器集成
- **IMU（惯性测量单元）**
  - 加速度计
  - 陀螺仪
  - 磁力计
  - 传感器融合

- **环境传感器**
  - 温度传感器
  - 湿度传感器
  - 光线传感器
  - 气压传感器

- **车辆传感器**
  - 轮速传感器
  - 转向角传感器
  - 油门/刹车位置
  - 档位传感器

- **IIO 框架**
  - IIO 设备驱动
  - Buffer 模式
  - Trigger 机制
  - 数据采集

### 6. 软件工程能力
- **编程语言**
  - C++11/14/17（精通）
  - QML/JavaScript
  - Python（脚本和工具）
  - Shell 脚本

- **开发工具**
  - Qt Creator
  - CMake / QMake
  - GDB 调试
  - Valgrind 内存分析
  - Perf 性能分析
  - Git 版本控制

- **软件架构**
  - MVC/MVVM 设计模式
  - 插件架构
  - 状态机设计
  - 多线程编程
  - IPC 进程间通信（D-Bus, Socket）

### 7. 性能优化（关键能力）
- **启动优化**
  - 快速启动技术
  - 启动时间分析
  - 延迟加载策略

- **运行时优化**
  - CPU 和内存优化
  - 渲染性能优化
  - 帧率稳定性
  - 功耗管理

- **资源管理**
  - 内存占用优化
  - 存储空间管理
  - 网络带宽优化

### 8. 车载应用开发经验
- **常见车载应用**
  - 仪表盘（Instrument Cluster）
  - 中控娱乐系统（IVI - In-Vehicle Infotainment）
  - HUD（抬头显示）
  - 后座娱乐系统
  - ADAS 显示界面

- **用户体验**
  - 车载 UI/UX 设计规范
  - 触摸和物理按键交互
  - 语音控制集成
  - 多屏联动
  - 日夜模式切换

---

## 加分技能

### 1. 高级技术
- **AI/ML 集成**
  - TensorFlow Lite
  - ONNX Runtime
  - 车载 AI 应用

- **云连接**
  - OTA 升级系统
  - 车联网（V2X）
  - 远程诊断

- **虚拟化**
  - Hypervisor（如 Xen, KVM）
  - 容器技术（Docker）
  - 多 OS 共存

### 2. 测试和质量保证
- Qt Test Framework
- 单元测试和集成测试
- 自动化测试
- CI/CD 流程
- 代码审查

### 3. 项目管理
- Agile/Scrum 开发流程
- JIRA/Confluence
- 需求分析和设计文档
- 跨团队协作

---

## 学习路径建议

### 阶段 1：基础巩固（3-6 个月）
1. 深入学习 C++ 和 Qt Framework
2. 掌握 QML 开发和 Qt Quick
3. 熟悉 Linux 系统编程
4. 学习嵌入式 Linux 基础

### 阶段 2：专业深化（6-12 个月）
1. 学习车载通信协议（CAN, SOME/IP）
2. 研究 AUTOSAR 和 AGL
3. 实践嵌入式 Linux 开发（Yocto）
4. 开发车载 Demo 项目

### 阶段 3：项目实战（12+ 个月）
1. 参与实际车载项目
2. 优化性能和稳定性
3. 学习 ISO 26262 功能安全
4. 积累行业经验

---

## 推荐资源

### 官方文档
- Qt Documentation: https://doc.qt.io/
- Qt Automotive Suite: https://www.qt.io/qt-automotive-suite
- AGL Documentation: https://docs.automotivelinux.org/
- Yocto Project: https://www.yoctoproject.org/

### 开源项目
- AGL Demo Platform
- GENIVI Development Platform
- Qt Automotive Examples

### 书籍推荐
- 《Qt 5 Cadaques》
- 《Mastering Qt 5》
- 《Embedded Linux Primer》
- 《Linux Device Drivers》

### 在线课程
- Qt Academy
- Udemy Qt/QML 课程
- Linux Foundation 培训

---

## 薪资达成建议

要达到 40K+ 月薪水平，通常需要：

1. **工作经验**：3-5 年以上相关经验
2. **项目经验**：至少 2-3 个完整车载项目
3. **技术深度**：在某个领域有深入研究（如性能优化、功能安全）
4. **行业认知**：了解车载行业标准和趋势
5. **软技能**：良好的沟通和团队协作能力

### 目标公司类型
- 传统车企（如大众、宝马、奔驰）
- 新能源车企（如特斯拉、蔚来、小鹏）
- Tier 1 供应商（如博世、大陆、德尔福）
- 车载系统公司（如斑马网络、华为车 BU）
- 芯片厂商（如 NXP、Qualcomm、NVIDIA）

---

## 总结

嵌入式 Qt 车载开发是一个技术密集型领域，需要：
- 扎实的 C++/Qt 编程能力
- 深入的嵌入式 Linux 知识
- 车载行业专业知识
- 性能优化和问题解决能力
- 持续学习和适应新技术的能力

这是一个高薪但也有一定门槛的职业方向，需要系统学习和实践积累。
