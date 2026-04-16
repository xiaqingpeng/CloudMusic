#!/bin/bash

# CloudMusic 项目同步脚本
# 将 macOS 上的项目同步到虚拟机

SOURCE="/Applications/qingpengxia/qt/qt6/qml/CloudMusic/"
TARGET="xiaqingpeng@192.168.64.2:/home/xiaqingpeng/qt6/CloudMusic/"

echo "=========================================="
echo "  CloudMusic 项目同步到虚拟机"
echo "=========================================="
echo "源目录: $SOURCE"
echo "目标: $TARGET"
echo ""

# 检查源目录是否存在
if [ ! -d "$SOURCE" ]; then
    echo "错误: 源目录不存在!"
    exit 1
fi

# 测试虚拟机连接
echo "测试虚拟机连接..."
if ! ssh -o ConnectTimeout=5 xiaqingpeng@192.168.64.2 "echo 'OK'" > /dev/null 2>&1; then
    echo "错误: 无法连接到虚拟机!"
    exit 1
fi
echo "连接成功!"
echo ""

# 执行同步
echo "开始同步..."
rsync -avz --progress \
  --exclude 'build/' \
  --exclude '.git/' \
  --exclude '.DS_Store' \
  --exclude '*.o' \
  --exclude '*.so' \
  --exclude '*.dylib' \
  --exclude '*.app' \
  --exclude '.vscode/' \
  --exclude '.qtcreator/' \
  "$SOURCE" "$TARGET"

if [ $? -eq 0 ]; then
    echo ""
    echo "=========================================="
    echo "  同步完成！"
    echo "=========================================="
    echo ""
    echo "验证同步结果..."
    ssh xiaqingpeng@192.168.64.2 "cd /home/xiaqingpeng/qt6/CloudMusic && \
        echo '文件数量:' && find . -type f | wc -l && \
        echo '目录大小:' && du -sh ."
    echo ""
    echo "可以使用以下命令登录虚拟机:"
    echo "  ssh xiaqingpeng@192.168.64.2"
    echo ""
    echo "项目路径:"
    echo "  /home/xiaqingpeng/qt6/CloudMusic"
else
    echo ""
    echo "=========================================="
    echo "  同步失败！"
    echo "=========================================="
    exit 1
fi
