#!/bin/bash

# 在 Ubuntu VM 上初始化 Git 仓库
# 使用方法: 将此脚本复制到 Ubuntu VM 并运行

echo "=========================================="
echo "  在 Ubuntu 上初始化 Git 仓库"
echo "=========================================="
echo ""

cd ~/qt6/CloudMusic || {
    echo "错误: 目录 ~/qt6/CloudMusic 不存在!"
    exit 1
}

echo "当前目录: $(pwd)"
echo ""

# 检查是否已经是 git 仓库
if [ -d ".git" ]; then
    echo "警告: .git 目录已存在，将重新初始化..."
    rm -rf .git
fi

# 初始化 git 仓库
echo "1. 初始化 Git 仓库..."
git init
echo "✓ Git 仓库初始化完成"
echo ""

# 添加远程仓库
echo "2. 添加远程仓库..."
git remote add origin https://github.com/xiaqingpeng/CloudMusic.git
echo "✓ 远程仓库添加完成"
echo ""

# 获取远程分支
echo "3. 获取远程分支信息..."
git fetch origin
echo "✓ 远程分支获取完成"
echo ""

# 检出 main 分支并设置跟踪
echo "4. 检出 main 分支..."
git checkout -b main origin/main
echo "✓ main 分支检出完成"
echo ""

# 验证分支跟踪
echo "5. 验证分支跟踪..."
git branch -vv
echo "✓ 分支跟踪设置完成"
echo ""

echo "=========================================="
echo "  Git 设置完成！"
echo "=========================================="
echo ""
echo "验证 Git 状态:"
git status
echo ""
echo "最近的提交:"
git log --oneline -5
echo ""
echo "现在可以在 Ubuntu 上使用 git 命令了！"
