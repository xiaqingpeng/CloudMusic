#!/bin/bash

# CloudMusic 统一调试脚本
# 支持本地 (macOS) 和远程 (Ubuntu VM) 调试

# 配置
VM_HOST="xiaqingpeng@192.168.64.2"
VM_PROJECT_DIR="/home/xiaqingpeng/qt6/CloudMusic"
VM_BUILD_DIR="$VM_PROJECT_DIR/build/Desktop-Debug"
VM_EXECUTABLE="$VM_BUILD_DIR/appCloudMusic"
LOCAL_BUILD_DIR="build/unknown-Debug"
LOCAL_EXECUTABLE="$LOCAL_BUILD_DIR/appCloudMusic.app/Contents/MacOS/appCloudMusic"
GDB_PORT=2345

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[✓]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[!]${NC} $1"
}

print_error() {
    echo -e "${RED}[✗]${NC} $1"
}

print_step() {
    echo -e "${CYAN}[STEP]${NC} $1"
}

print_header() {
    echo ""
    echo "=========================================="
    echo "  $1"
    echo "=========================================="
    echo ""
}

# 显示帮助
show_help() {
    cat << 'EOF'
CloudMusic 调试脚本

用法: ./scripts/debug.sh [模式] [选项]

模式:
    local               本地调试 (macOS)
    remote              远程调试 (Ubuntu VM)
    
选项:
    -h, --help          显示此帮助信息
    -b, --build         构建后再调试
    -n, --no-build      跳过构建，直接调试
    -s, --sync          同步项目到虚拟机（仅远程模式）
    -p, --port PORT     指定 gdbserver 端口（默认: 2345）
    -c, --core FILE     分析 core dump 文件
    
示例:
    ./scripts/debug.sh local              # 本地调试
    ./scripts/debug.sh local -b           # 构建后本地调试
    ./scripts/debug.sh remote             # 远程调试
    ./scripts/debug.sh remote -s -b       # 同步、构建后远程调试
    ./scripts/debug.sh remote -n          # 跳过构建，直接远程调试
    ./scripts/debug.sh local -c core.123  # 分析 core dump

调试器命令:
    本地 (LLDB):
        b main                  设置断点
        r                       运行程序
        n                       单步执行（不进入函数）
        s                       单步执行（进入函数）
        c                       继续执行
        bt                      显示调用栈
        p variable              打印变量
        frame variable          显示当前帧的所有变量
        thread list             显示所有线程
        q                       退出
        
    远程 (GDB):
        b main                  设置断点
        c                       继续执行
        n                       单步执行（不进入函数）
        s                       单步执行（进入函数）
        bt                      显示调用栈
        p variable              打印变量
        info locals             显示局部变量
        info threads            显示所有线程
        q                       退出

EOF
}

# 检查 SSH 连接
check_vm_connection() {
    print_step "检查虚拟机连接..."
    if ! ssh -o ConnectTimeout=5 "$VM_HOST" "echo 'OK'" > /dev/null 2>&1; then
        print_error "无法连接到虚拟机！"
        return 1
    fi
    print_success "虚拟机连接正常"
    return 0
}

# 本地构建
build_local() {
    print_step "构建项目 (macOS Debug)..."
    
    if [ ! -d "$LOCAL_BUILD_DIR" ]; then
        cmake -B "$LOCAL_BUILD_DIR" -DCMAKE_BUILD_TYPE=Debug
    fi
    
    cmake --build "$LOCAL_BUILD_DIR" 2>&1 | tail -10
    
    if [ $? -eq 0 ]; then
        print_success "本地构建成功"
        return 0
    else
        print_error "本地构建失败"
        return 1
    fi
}

# 远程构建
build_remote() {
    print_step "在虚拟机上构建项目 (Debug)..."
    
    ssh "$VM_HOST" << 'ENDSSH' 2>&1 | tail -10
cd /home/xiaqingpeng/qt6/CloudMusic
cmake -B build/Desktop-Debug -DCMAKE_BUILD_TYPE=Debug
cmake --build build/Desktop-Debug
ENDSSH
    
    if [ $? -eq 0 ]; then
        print_success "远程构建成功"
        return 0
    else
        print_error "远程构建失败"
        return 1
    fi
}

# 同步项目
sync_project() {
    print_step "同步项目到虚拟机..."
    
    if [ -f "./sync-to-vm.sh" ]; then
        ./sync-to-vm.sh 2>&1 | grep -E "(同步完成|文件数量|目录大小)"
        print_success "项目同步完成"
        return 0
    else
        print_warning "sync-to-vm.sh 不存在"
        return 1
    fi
}

# 本地调试 (LLDB)
debug_local() {
    print_header "本地调试 (macOS - LLDB)"
    
    if [ ! -f "$LOCAL_EXECUTABLE" ]; then
        print_error "可执行文件不存在: $LOCAL_EXECUTABLE"
        print_info "请先构建项目: ./scripts/debug.sh local -b"
        return 1
    fi
    
    # 创建 LLDB 命令文件
    cat > /tmp/lldb_commands.txt << EOF
# 加载可执行文件
file $LOCAL_EXECUTABLE

# 设置断点（可选）
# breakpoint set --name main
# breakpoint set --file Application.cpp --line 50

# 显示设置
settings set target.process.stop-on-exec false
settings set target.x86-disassembly-flavor intel

# 启动提示
script print("\\n" + "="*50)
script print("  CloudMusic 本地调试会话 (LLDB)")
script print("="*50 + "\\n")
script print("常用命令:")
script print("  b <function>     - 设置断点")
script print("  r                - 运行程序")
script print("  c                - 继续执行")
script print("  n                - 单步执行（不进入函数）")
script print("  s                - 单步执行（进入函数）")
script print("  bt               - 显示调用栈")
script print("  p <var>          - 打印变量")
script print("  frame variable   - 显示所有局部变量")
script print("  q                - 退出")
script print("\\n输入 'r' 开始运行程序...\\n")

# 运行程序（可选，注释掉则手动运行）
# run
EOF
    
    print_info "启动 LLDB..."
    print_info "可执行文件: $LOCAL_EXECUTABLE"
    echo ""
    
    lldb -s /tmp/lldb_commands.txt
    
    rm -f /tmp/lldb_commands.txt
}

# 远程调试 (GDB)
debug_remote() {
    print_header "远程调试 (Ubuntu VM - GDB)"
    
    # 检查连接
    if ! check_vm_connection; then
        return 1
    fi
    
    # 检查 gdbserver
    print_step "检查 gdbserver..."
    if ! ssh "$VM_HOST" "which gdbserver" > /dev/null 2>&1; then
        print_warning "gdbserver 未安装，正在安装..."
        ssh "$VM_HOST" "sudo apt-get update && sudo apt-get install -y gdbserver" > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            print_success "gdbserver 安装成功"
        else
            print_error "gdbserver 安装失败"
            return 1
        fi
    else
        print_success "gdbserver 已安装"
    fi
    
    # 停止旧的 gdbserver
    print_step "停止旧的 gdbserver..."
    ssh "$VM_HOST" "pkill -9 gdbserver" > /dev/null 2>&1
    sleep 1
    
    # 启动 gdbserver
    print_step "启动 gdbserver (端口 $GDB_PORT)..."
    ssh "$VM_HOST" "cd $VM_BUILD_DIR && nohup gdbserver :$GDB_PORT $VM_EXECUTABLE > gdbserver.log 2>&1 &" &
    sleep 2
    
    # 检查 gdbserver 是否启动
    if ! ssh "$VM_HOST" "pgrep -f gdbserver" > /dev/null 2>&1; then
        print_error "gdbserver 启动失败"
        ssh "$VM_HOST" "cat $VM_BUILD_DIR/gdbserver.log"
        return 1
    fi
    print_success "gdbserver 已启动 ($VM_HOST:$GDB_PORT)"
    
    # 检查本地 GDB
    if ! command -v gdb &> /dev/null; then
        print_error "GDB 未安装！"
        print_info "安装方法: brew install gdb"
        return 1
    fi
    
    # 创建 GDB 命令文件
    cat > /tmp/gdb_commands.txt << EOF
# 连接到远程 gdbserver
target remote $VM_HOST:$GDB_PORT

# 设置源代码路径映射
set substitute-path /home/xiaqingpeng/qt6/CloudMusic $(pwd)

# 加载符号
file $LOCAL_EXECUTABLE

# 设置断点（可选）
# break main
# break CloudMusic::Core::Application::run

# 显示设置
set print pretty on
set print object on
set print static-members on
set print vtbl on
set print demangle on
set demangle-style gnu-v3
set pagination off

# 启动提示
echo \\n
echo ========================================\\n
echo   CloudMusic 远程调试会话 (GDB)\\n
echo ========================================\\n
echo \\n
echo 已连接到: $VM_HOST:$GDB_PORT\\n
echo \\n
echo 常用命令:\\n
echo   b <function>  - 设置断点\\n
echo   c             - 继续执行\\n
echo   n             - 单步执行（不进入函数）\\n
echo   s             - 单步执行（进入函数）\\n
echo   bt            - 显示调用栈\\n
echo   p <var>       - 打印变量\\n
echo   info locals   - 显示局部变量\\n
echo   info threads  - 显示所有线程\\n
echo   q             - 退出\\n
echo \\n
echo 输入 'c' 开始运行程序...\\n
echo \\n
EOF
    
    print_info "启动 GDB..."
    echo ""
    
    gdb -x /tmp/gdb_commands.txt
    
    # 清理
    print_step "清理..."
    ssh "$VM_HOST" "pkill -9 gdbserver" > /dev/null 2>&1
    rm -f /tmp/gdb_commands.txt
    print_success "清理完成"
}

# 分析 core dump
analyze_core() {
    local core_file="$1"
    
    print_header "分析 Core Dump"
    
    if [ ! -f "$core_file" ]; then
        print_error "Core dump 文件不存在: $core_file"
        return 1
    fi
    
    print_info "Core dump: $core_file"
    print_info "可执行文件: $LOCAL_EXECUTABLE"
    echo ""
    
    # 创建 LLDB 命令
    cat > /tmp/lldb_core.txt << EOF
target create $LOCAL_EXECUTABLE --core $core_file
bt all
script print("\\n使用 'bt' 查看调用栈，'frame select N' 切换帧，'p variable' 打印变量\\n")
EOF
    
    lldb -s /tmp/lldb_core.txt
    
    rm -f /tmp/lldb_core.txt
}

# 主函数
main() {
    # 默认参数
    MODE=""
    DO_BUILD=false
    DO_SYNC=false
    CORE_FILE=""
    
    # 解析参数
    while [[ $# -gt 0 ]]; do
        case $1 in
            local|remote)
                MODE="$1"
                shift
                ;;
            -h|--help)
                show_help
                exit 0
                ;;
            -b|--build)
                DO_BUILD=true
                shift
                ;;
            -n|--no-build)
                DO_BUILD=false
                shift
                ;;
            -s|--sync)
                DO_SYNC=true
                shift
                ;;
            -p|--port)
                GDB_PORT="$2"
                shift 2
                ;;
            -c|--core)
                CORE_FILE="$2"
                shift 2
                ;;
            *)
                print_error "未知选项: $1"
                show_help
                exit 1
                ;;
        esac
    done
    
    # 如果指定了 core 文件，直接分析
    if [ -n "$CORE_FILE" ]; then
        analyze_core "$CORE_FILE"
        exit $?
    fi
    
    # 检查模式
    if [ -z "$MODE" ]; then
        print_error "请指定调试模式: local 或 remote"
        echo ""
        show_help
        exit 1
    fi
    
    # 执行调试
    case $MODE in
        local)
            if [ "$DO_BUILD" = true ]; then
                build_local || exit 1
            fi
            debug_local
            ;;
        remote)
            if [ "$DO_SYNC" = true ]; then
                sync_project || exit 1
            fi
            if [ "$DO_BUILD" = true ]; then
                build_remote || exit 1
            fi
            debug_remote
            ;;
        *)
            print_error "无效的模式: $MODE"
            exit 1
            ;;
    esac
}

# 捕获 Ctrl+C
cleanup_on_exit() {
    if [ "$MODE" = "remote" ]; then
        ssh "$VM_HOST" "pkill -9 gdbserver" > /dev/null 2>&1
    fi
    rm -f /tmp/gdb_commands.txt /tmp/lldb_commands.txt /tmp/lldb_core.txt
}

trap cleanup_on_exit EXIT INT TERM

# 运行主函数
main "$@"
