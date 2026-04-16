# 调试系统总结

## 已创建的调试工具

### 1. 统一调试脚本
**文件**: `scripts/debug.sh`

功能：
- ✅ 本地调试 (macOS + LLDB)
- ✅ 远程调试 (Ubuntu VM + GDB)
- ✅ 自动构建
- ✅ 项目同步
- ✅ Core dump 分析
- ✅ 彩色输出
- ✅ 错误处理

使用示例：
```bash
./scripts/debug.sh local              # 本地调试
./scripts/debug.sh local -b           # 构建后本地调试
./scripts/debug.sh remote             # 远程调试
./scripts/debug.sh remote -s -b       # 同步、构建后远程调试
./scripts/debug.sh local -c core.123  # 分析 core dump
```

### 2. 快速调试脚本
**文件**: `scripts/quick-debug.sh`

功能：
- 快速启动远程调试
- 适用于已构建的项目
- 最小化输出

### 3. 远程调试脚本
**文件**: `scripts/remote-debug.sh`

功能：
- 完整的远程调试流程
- 详细的步骤说明
- 自动安装 gdbserver

### 4. VS Code 调试配置
**文件**: `.vscode/launch.json`

功能：
- 本地调试配置 (LLDB)
- 远程调试配置 (GDB)
- 源代码路径映射

## 文档

### 1. 调试指南
**文件**: `docs/DEBUGGING_GUIDE.md`

内容：
- 详细的调试步骤
- LLDB 和 GDB 命令参考
- 调试技巧
- 常见问题解决
- 工作流程

### 2. 调试速查表
**文件**: `docs/DEBUG_CHEATSHEET.md`

内容：
- 快速命令参考
- LLDB 命令表
- GDB 命令表
- 常用断点
- 故障排查

## 调试工作流

### 本地开发调试

```bash
# 1. 修改代码
vim src/core/Application.cpp

# 2. 调试
./scripts/debug.sh local -b

# 3. 在 LLDB 中
(lldb) b Application.cpp:50
(lldb) r
(lldb) n
(lldb) p variable
```

### 远程调试

```bash
# 1. 同步代码
./sync-to-vm.sh

# 2. 远程调试
./scripts/debug.sh remote -b

# 3. 在 GDB 中
(gdb) b main
(gdb) c
(gdb) bt
```

### VS Code 调试

```bash
# 1. 打开 VS Code
code .

# 2. 按 F5 选择调试配置
# - Local Debug (macOS)
# - Remote Debug (Ubuntu VM)

# 3. 设置断点并开始调试
```

## 调试器对比

| 特性 | LLDB (macOS) | GDB (Linux) |
|------|--------------|-------------|
| 平台 | macOS | Linux/Ubuntu |
| 设置断点 | `b main` | `b main` |
| 运行 | `r` | `c` (远程) |
| 单步 | `n` / `s` | `n` / `s` |
| 调用栈 | `bt` | `bt` |
| 打印变量 | `p var` | `p var` |
| 查看变量 | `frame variable` | `info locals` |
| 线程 | `thread list` | `info threads` |
| 退出 | `q` | `q` |

## 常见调试场景

### 1. 应用崩溃

```bash
# 启用 core dump
ulimit -c unlimited

# 运行应用
./appCloudMusic

# 分析 core dump
./scripts/debug.sh local -c core.12345
```

### 2. QML 错误

```bash
# 启用 QML 调试
export QT_LOGGING_RULES="*.debug=true"
export QML_IMPORT_TRACE=1

# 运行应用
./appCloudMusic 2>&1 | tee qml_debug.log
```

### 3. 内存泄漏

```bash
# 使用 Address Sanitizer
cmake -DCMAKE_CXX_FLAGS="-fsanitize=address" -B build
cmake --build build
./build/appCloudMusic
```

### 4. 性能问题

```bash
# macOS - Instruments
instruments -t "Time Profiler" ./appCloudMusic

# Linux - perf
perf record ./appCloudMusic
perf report
```

## 故障排查

### 问题 1: GDB 无法连接

```bash
# 检查 gdbserver
ssh xiaqingpeng@192.168.64.2 "pgrep -f gdbserver"

# 重启 gdbserver
ssh xiaqingpeng@192.168.64.2 "pkill gdbserver"
./scripts/debug.sh remote
```

### 问题 2: 符号不匹配

```bash
# 重新构建
./scripts/debug.sh remote -b
```

### 问题 3: 找不到源代码

```gdb
# 在 GDB 中设置路径
set substitute-path /remote/path /local/path
```

## 最佳实践

1. **使用统一脚本**: 优先使用 `scripts/debug.sh`
2. **保持同步**: 远程调试前先同步代码
3. **Debug 构建**: 始终使用 Debug 模式构建
4. **设置断点**: 在关键位置设置断点
5. **查看日志**: 结合日志输出分析问题
6. **单步执行**: 使用单步执行定位问题
7. **检查变量**: 及时检查变量值
8. **保存会话**: 记录调试过程和发现

## 快速参考

```bash
# 查看帮助
./scripts/debug.sh --help

# 本地调试
./scripts/debug.sh local -b

# 远程调试
./scripts/debug.sh remote -s -b

# 快速远程调试
./scripts/quick-debug.sh

# 查看文档
cat docs/DEBUGGING_GUIDE.md
cat docs/DEBUG_CHEATSHEET.md
```

## 总结

调试系统已完整搭建，包括：

- ✅ 3 个调试脚本
- ✅ VS Code 配置
- ✅ 完整文档
- ✅ 速查表
- ✅ 本地和远程支持
- ✅ 自动化流程

开发者可以轻松进行本地和远程调试，提高开发效率。
