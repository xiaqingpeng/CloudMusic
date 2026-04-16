# CloudMusic 调试指南

## 调试脚本

项目提供了统一的调试脚本，支持本地和远程调试。

### 快速开始

```bash
# 本地调试 (macOS)
./scripts/debug.sh local

# 远程调试 (Ubuntu VM)
./scripts/debug.sh remote

# 构建后调试
./scripts/debug.sh local -b
./scripts/debug.sh remote -s -b
```

## 本地调试 (macOS)

### 使用 LLDB

```bash
# 基本调试
./scripts/debug.sh local

# 构建后调试
./scripts/debug.sh local -b

# 分析 core dump
./scripts/debug.sh local -c core.12345
```

### LLDB 常用命令

```lldb
# 设置断点
b main                          # 在 main 函数设置断点
b Application.cpp:50            # 在指定文件的行号设置断点
b CloudMusic::Core::Application::run  # 在指定函数设置断点

# 运行控制
r                               # 运行程序
c                               # 继续执行
n                               # 单步执行（不进入函数）
s                               # 单步执行（进入函数）
finish                          # 执行完当前函数

# 查看信息
bt                              # 显示调用栈
bt all                          # 显示所有线程的调用栈
frame variable                  # 显示当前帧的所有变量
p variable                      # 打印变量值
p/x variable                    # 以十六进制打印
po object                       # 打印对象描述

# 线程操作
thread list                     # 列出所有线程
thread select 2                 # 切换到线程 2
thread backtrace                # 显示当前线程的调用栈

# 断点管理
breakpoint list                 # 列出所有断点
breakpoint delete 1             # 删除断点 1
breakpoint disable 1            # 禁用断点 1
breakpoint enable 1             # 启用断点 1

# 其他
help                            # 显示帮助
q                               # 退出
```

### LLDB 高级技巧

```lldb
# 条件断点
b Application.cpp:50 -c "argc > 1"

# 监视点（watchpoint）
watchpoint set variable myVar
watchpoint list

# 表达式求值
expr int $myvar = 10
expr $myvar + 5

# 内存查看
memory read 0x12345678
x/10x 0x12345678

# 反汇编
disassemble --name main
disassemble --pc
```

## 远程调试 (Ubuntu VM)

### 使用 GDB

```bash
# 基本远程调试
./scripts/debug.sh remote

# 同步、构建后调试
./scripts/debug.sh remote -s -b

# 跳过构建，直接调试
./scripts/debug.sh remote -n

# 使用自定义端口
./scripts/debug.sh remote -p 3456
```

### GDB 常用命令

```gdb
# 设置断点
b main                          # 在 main 函数设置断点
b Application.cpp:50            # 在指定文件的行号设置断点
b CloudMusic::Core::Application::run  # 在指定函数设置断点

# 运行控制
c                               # 继续执行
n                               # 单步执行（不进入函数）
s                               # 单步执行（进入函数）
finish                          # 执行完当前函数
until 100                       # 执行到第 100 行

# 查看信息
bt                              # 显示调用栈
bt full                         # 显示调用栈和局部变量
frame 2                         # 切换到帧 2
info locals                     # 显示局部变量
info args                       # 显示函数参数
p variable                      # 打印变量值
p/x variable                    # 以十六进制打印

# 线程操作
info threads                    # 列出所有线程
thread 2                        # 切换到线程 2
thread apply all bt             # 显示所有线程的调用栈

# 断点管理
info breakpoints                # 列出所有断点
delete 1                        # 删除断点 1
disable 1                       # 禁用断点 1
enable 1                        # 启用断点 1

# 其他
help                            # 显示帮助
q                               # 退出
```

### GDB 高级技巧

```gdb
# 条件断点
b Application.cpp:50 if argc > 1

# 监视点
watch myVar
rwatch myVar                    # 读监视点
awatch myVar                    # 读写监视点

# 捕获点
catch throw                     # 捕获异常抛出
catch syscall                   # 捕获系统调用

# 内存查看
x/10x 0x12345678               # 查看 10 个十六进制值
x/s 0x12345678                 # 查看字符串

# 反汇编
disassemble main
disassemble /m main            # 混合源代码和汇编

# 调用函数
call myFunction()
print myFunction()
```

## 调试技巧

### 1. 调试 QML 问题

```bash
# 启用 QML 调试输出
export QT_LOGGING_RULES="*.debug=true"
export QML_IMPORT_TRACE=1

# 运行程序
./appCloudMusic
```

### 2. 调试崩溃

```bash
# 启用 core dump
ulimit -c unlimited

# 运行程序（如果崩溃会生成 core 文件）
./appCloudMusic

# 分析 core dump
./scripts/debug.sh local -c core.12345
```

### 3. 调试内存问题

```bash
# 使用 Valgrind (Linux)
valgrind --leak-check=full ./appCloudMusic

# 使用 Address Sanitizer
cmake -DCMAKE_CXX_FLAGS="-fsanitize=address" ..
cmake --build .
./appCloudMusic
```

### 4. 性能分析

```bash
# 使用 Instruments (macOS)
instruments -t "Time Profiler" ./appCloudMusic

# 使用 perf (Linux)
perf record ./appCloudMusic
perf report
```

## 常见问题

### 1. GDB 无法连接到 gdbserver

**问题**: `Connection refused` 或 `Connection timed out`

**解决方案**:
```bash
# 检查 gdbserver 是否运行
ssh xiaqingpeng@192.168.64.2 "pgrep -f gdbserver"

# 检查端口是否开放
nc -zv 192.168.64.2 2345

# 重启 gdbserver
ssh xiaqingpeng@192.168.64.2 "pkill gdbserver"
./scripts/debug.sh remote
```

### 2. 符号文件不匹配

**问题**: `warning: exec file is newer than core file`

**解决方案**:
```bash
# 确保使用相同版本的可执行文件
./scripts/debug.sh remote -b
```

### 3. 源代码路径不匹配

**问题**: GDB 找不到源代码文件

**解决方案**:
```gdb
# 在 GDB 中设置路径映射
set substitute-path /remote/path /local/path

# 或在脚本中已自动设置
```

### 4. LLDB 无法启动

**问题**: `error: unable to find a debugger`

**解决方案**:
```bash
# 安装 Xcode Command Line Tools
xcode-select --install

# 或安装完整的 Xcode
```

## VS Code 调试配置

项目已包含 `.vscode/launch.json` 配置文件，支持：

1. **本地调试 (macOS)**: 使用 LLDB
2. **远程调试 (Ubuntu VM)**: 使用 GDB

### 使用方法

1. 打开 VS Code
2. 按 `F5` 或点击调试按钮
3. 选择调试配置：
   - `Local Debug (macOS)`
   - `Remote Debug (Ubuntu VM)`

### 注意事项

- 远程调试前需要先启动 gdbserver
- 可以使用脚本自动启动：`./scripts/debug.sh remote -n`

## 调试工作流

### 开发调试流程

```bash
# 1. 修改代码
vim src/core/Application.cpp

# 2. 本地构建和调试
./scripts/debug.sh local -b

# 3. 如果需要在 Ubuntu 上测试
./scripts/debug.sh remote -s -b
```

### 问题排查流程

```bash
# 1. 复现问题
./appCloudMusic

# 2. 启用详细日志
export QT_LOGGING_RULES="*.debug=true"
./appCloudMusic 2>&1 | tee debug.log

# 3. 使用调试器
./scripts/debug.sh local

# 4. 设置断点并单步执行
(lldb) b Application.cpp:50
(lldb) r
(lldb) n
(lldb) p variable
```

## 参考资料

- [LLDB 官方文档](https://lldb.llvm.org/use/tutorial.html)
- [GDB 官方文档](https://sourceware.org/gdb/documentation/)
- [Qt 调试技巧](https://doc.qt.io/qt-6/debug.html)
- [远程调试指南](https://sourceware.org/gdb/onlinedocs/gdb/Remote-Debugging.html)
