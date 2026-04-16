#!/bin/bash

# CloudMusic 远程 GDB 调试脚本
# 用于在 macOS 上调试运行在 Ubuntu 虚拟机上的应用程序

# 配置
VM_HOST="xiaqingpeng@192.168.64.2"
VM_PROJECT_DIR="/home/xiaqingpeng/qt6/CloudMusic"
VM_BUILD_DIR="$VM_PROJECT_DIR/build/Desktop-Debug"
VM_EXECUTABLE="$VM_BUILD_DIR/appCloudMusic"
GDB_PORT=2345

# 颜色输出
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

print_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo ""
    echo "=========================================="
    echo "  $1"
    echo "=========================================="
    echo ""
}

# 检查 SSH 连接
check_connection() {
    print_info "检查虚拟机连接..."
    if ! ssh -o ConnectTimeout=5 "$VM_HOST" "echo 'OK'" > /dev/null 2>&1; then
        print_error "无法连接到虚拟机！"
        exit 1
    fi
    print_success "虚拟机连接正常"
}

# 检查 gdbserver 是否安装
check_gdbserver() {
    print_info "检查 gdbserver..."
    if ! ssh "$VM_HOST" "which gdbserver" > /dev/null 2>&1; then
        print_warning "gdbserver 未安装，正在安装..."
        ssh "$VM_HOST" "sudo apt-get update && sudo apt-get install -y gdbserver"
        if [ $? -eq 0 ]; then
            print_success "gdbserver 安装成功"
        else
            print_error "gdbserver 安装失败"
            exit 1
        fi
    else
        print_success "gdbserver 已安装"
    fi
}

# 同步项目到虚拟机
sync_project() {
    print_info "同步项目到虚拟机..."
    if [ -f "./sync-to-vm.sh" ]; then
        ./sync-to-vm.sh > /dev/null 2>&1
        print_success "项目同步完成"
    else
        print_warning "sync-to-vm.sh 不存在，跳过同步"
    fi
}

# 在虚拟机上构建项目
build_project() {
    print_info "在虚拟机上构建项目（Debug 模式）..."
    ssh "$VM_HOST" << 'ENDSSH'
cd /home/xiaqingpeng/qt6/CloudMusic
cmake -B build/Desktop-Debug -DCMAKE_BUILD_TYPE=Debug
cmake --build build/Desktop-Debug
ENDSSH
    
    if [ $? -eq 0 ]; then
        print_success "构建成功"
    else
        print_error "构建失败"
        exit 1
    fi
}

# 停止之前的 gdbserver
stop_gdbserver() {
    print_info "停止之前的 gdbserver 进程..."
    ssh "$VM_HOST" "pkill -9 gdbserver" > /dev/null 2>&1
    sleep 1
}

# 启动 gdbserver
start_gdbserver() {
    print_info "在虚拟机上启动 gdbserver (端口 $GDB_PORT)..."
    
    # 在后台启动 gdbserver
    ssh "$VM_HOST" "cd $VM_BUILD_DIR && nohup gdbserver :$GDB_PORT $VM_EXECUTABLE > gdbserver.log 2>&1 &" &
    
    sleep 2
    
    # 检查 gdbserver 是否启动
    if ssh "$VM_HOST" "pgrep -f gdbserver" > /dev/null 2>&1; then
        print_success "gdbserver 已启动"
        print_info "监听端口: $GDB_PORT"
    else
        print_error "gdbserver 启动失败"
        exit 1
    fi
}

# 创建 GDB 命令文件
create_gdb_commands() {
    print_info "创建 GDB 命令文件..."
    
    cat > /tmp/gdb_commands.txt << EOF
# 连接到远程 gdbserver
target remote $VM_HOST:$GDB_PORT

# 设置源代码路径映射
set substitute-path /home/xiaqingpeng/qt6/CloudMusic $(pwd)

# 加载符号
file build/unknown-Debug/appCloudMusic.app/Contents/MacOS/appCloudMusic

# 常用断点
# break main
# break CloudMusic::Core::Application::run

# 显示设置
set print pretty on
set print object on
set print static-members on
set print vtbl on
set print demangle on
set demangle-style gnu-v3

# 启动时的提示
echo \\n
echo ========================================\\n
echo   CloudMusic 远程调试会话\\n
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
echo   info threads  - 显示所有线程\\n
echo   q             - 退出\\n
echo \\n
echo 输入 'c' 开始运行程序...\\n
echo \\n
EOF
    
    print_success "GDB 命令文件已创建"
}

# 启动本地 GDB
start_gdb() {
    print_header "启动 GDB 调试会话"
    
    print_info "启动 GDB..."
    print_info "使用 Ctrl+C 可以中断程序"
    print_info "使用 'q' 命令退出 GDB"
    echo ""
    
    # 检查是否有 gdb
    if ! command -v gdb &> /dev/null; then
        print_error "GDB 未安装！"
        print_info "请安装 GDB: brew install gdb"
        exit 1
    fi
    
    # 启动 GDB
    gdb -x /tmp/gdb_commands.txt
}

# 清理
cleanup() {
    print_info "清理..."
    stop_gdbserver
    rm -f /tmp/gdb_commands.txt
    print_success "清理完成"
}

# 显示帮助
show_help() {
    cat << EOF
CloudMusic 远程 GDB 调试脚本

用法: $0 [选项]

选项:
    -h, --help          显示此帮助信息
    -s, --sync          同步项目到虚拟机
    -b, --build         在虚拟机上构建项目
    -n, --no-build      跳过构建步骤
    -p, --port PORT     指定 gdbserver 端口（默认: 2345）
    
示例:
    $0                  # 完整流程：同步、构建、调试
    $0 -n               # 跳过构建，直接调试
    $0 -s -b            # 只同步和构建，不启动调试
    $0 -p 3456          # 使用自定义端口

调试流程:
    1. 检查虚拟机连接
    2. 同步项目文件
    3. 在虚拟机上构建（Debug 模式）
    4. 启动 gdbserver
    5. 启动本地 GDB 并连接

GDB 常用命令:
    b main              设置断点在 main 函数
    b file.cpp:123      设置断点在指定文件的行号
    c                   继续执行
    n                   单步执行（不进入函数）
    s                   单步执行（进入函数）
    bt                  显示调用栈
    p variable          打印变量值
    info locals         显示局部变量
    info threads        显示所有线程
    thread 2            切换到线程 2
    q                   退出 GDB

EOF
}

# 主函数
main() {
    # 解析参数
    DO_SYNC=true
    DO_BUILD=true
    DO_DEBUG=true
    
    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                show_help
                exit 0
                ;;
            -s|--sync)
                DO_BUILD=false
                DO_DEBUG=false
                shift
                ;;
            -b|--build)
                DO_DEBUG=false
                shift
                ;;
            -n|--no-build)
                DO_BUILD=false
                shift
                ;;
            -p|--port)
                GDB_PORT="$2"
                shift 2
                ;;
            *)
                print_error "未知选项: $1"
                show_help
                exit 1
                ;;
        esac
    done
    
    print_header "CloudMusic 远程 GDB 调试"
    
    # 检查连接
    check_connection
    
    # 检查 gdbserver
    check_gdbserver
    
    # 同步项目
    if [ "$DO_SYNC" = true ]; then
        sync_project
    fi
    
    # 构建项目
    if [ "$DO_BUILD" = true ]; then
        build_project
    fi
    
    # 启动调试
    if [ "$DO_DEBUG" = true ]; then
        # 停止旧的 gdbserver
        stop_gdbserver
        
        # 启动 gdbserver
        start_gdbserver
        
        # 创建 GDB 命令
        create_gdb_commands
        
        # 启动 GDB
        start_gdb
        
        # 清理
        cleanup
    fi
    
    print_success "完成！"
}

# 捕获 Ctrl+C
trap cleanup EXIT INT TERM

# 运行主函数
main "$@"
