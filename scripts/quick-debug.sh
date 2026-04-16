#!/bin/bash

# CloudMusic 快速远程调试脚本
# 适用于已经构建好的项目，快速启动调试会话

VM_HOST="xiaqingpeng@192.168.64.2"
VM_BUILD_DIR="/home/xiaqingpeng/qt6/CloudMusic/build/Desktop-Debug"
VM_EXECUTABLE="$VM_BUILD_DIR/appCloudMusic"
GDB_PORT=2345

echo "=========================================="
echo "  CloudMusic 快速调试"
echo "=========================================="
echo ""

# 停止旧的 gdbserver
echo "[1/3] 停止旧的 gdbserver..."
ssh "$VM_HOST" "pkill -9 gdbserver" > /dev/null 2>&1
sleep 1

# 启动 gdbserver
echo "[2/3] 启动 gdbserver..."
ssh "$VM_HOST" "cd $VM_BUILD_DIR && gdbserver :$GDB_PORT $VM_EXECUTABLE" &
sleep 2

# 创建 GDB 命令文件
cat > /tmp/quick_gdb.txt << EOF
target remote $VM_HOST:$GDB_PORT
set substitute-path /home/xiaqingpeng/qt6/CloudMusic $(pwd)
file build/unknown-Debug/appCloudMusic.app/Contents/MacOS/appCloudMusic
set print pretty on
echo \\n已连接到远程调试会话\\n
echo 输入 'c' 继续执行，'q' 退出\\n\\n
EOF

# 启动 GDB
echo "[3/3] 启动 GDB..."
echo ""
gdb -x /tmp/quick_gdb.txt

# 清理
ssh "$VM_HOST" "pkill -9 gdbserver" > /dev/null 2>&1
rm -f /tmp/quick_gdb.txt
