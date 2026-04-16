# 调试速查表

## 快速命令

```bash
# 本地调试
./scripts/debug.sh local              # 直接调试
./scripts/debug.sh local -b           # 构建后调试

# 远程调试
./scripts/debug.sh remote             # 直接调试
./scripts/debug.sh remote -s -b       # 同步、构建后调试
./scripts/debug.sh remote -n          # 跳过构建

# Core dump 分析
./scripts/debug.sh local -c core.123
```

## LLDB 速查 (macOS)

| 命令 | 说明 |
|------|------|
| `r` | 运行程序 |
| `c` | 继续执行 |
| `n` | 单步执行（不进入） |
| `s` | 单步执行（进入） |
| `b main` | 设置断点 |
| `bt` | 显示调用栈 |
| `p var` | 打印变量 |
| `frame variable` | 显示所有变量 |
| `thread list` | 列出线程 |
| `q` | 退出 |

## GDB 速查 (Linux)

| 命令 | 说明 |
|------|------|
| `c` | 继续执行 |
| `n` | 单步执行（不进入） |
| `s` | 单步执行（进入） |
| `b main` | 设置断点 |
| `bt` | 显示调用栈 |
| `p var` | 打印变量 |
| `info locals` | 显示局部变量 |
| `info threads` | 列出线程 |
| `q` | 退出 |

## 常用断点

```bash
# LLDB
b main
b Application.cpp:50
b CloudMusic::Core::Application::run

# GDB
b main
b Application.cpp:50
b CloudMusic::Core::Application::run
```

## 调试环境变量

```bash
# QML 调试
export QT_LOGGING_RULES="*.debug=true"
export QML_IMPORT_TRACE=1

# 平台插件
export QT_QPA_PLATFORM=offscreen

# 启用 core dump
ulimit -c unlimited
```

## 故障排查

| 问题 | 解决方案 |
|------|----------|
| 无法连接 gdbserver | `ssh vm "pkill gdbserver"` |
| 符号不匹配 | 重新构建 `-b` |
| 找不到源码 | 检查路径映射 |
| LLDB 无法启动 | `xcode-select --install` |
