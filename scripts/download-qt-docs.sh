#!/bin/bash

# Qt 6 文档下载脚本

set -e

# 配置
QT_VERSION="6.10"
DOC_DIR="$HOME/Qt/Docs/Qt-${QT_VERSION}"

echo "📚 Qt ${QT_VERSION} 文档下载助手"
echo "=================================="
echo ""

# 创建文档目录
mkdir -p "$DOC_DIR"

echo "📁 文档目录: $DOC_DIR"
echo ""

# 检查是否已有文档
if [ -n "$(ls -A $DOC_DIR 2>/dev/null)" ]; then
    echo "⚠️  文档目录不为空，已有以下文件："
    ls -lh "$DOC_DIR"
    echo ""
    read -p "是否继续？(y/n) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 0
    fi
fi

echo "📥 下载方式选择："
echo ""
echo "1. 使用 Qt Maintenance Tool（推荐）"
echo "2. 手动下载"
echo "3. 查看在线文档链接"
echo ""
read -p "请选择 (1-3): " choice

case $choice in
    1)
        echo ""
        echo "🔧 使用 Qt Maintenance Tool："
        echo ""
        echo "步骤："
        echo "1. 下载 Qt Online Installer"
        echo "   https://www.qt.io/download-qt-installer"
        echo ""
        echo "2. 运行安装器并登录 Qt 账号"
        echo ""
        echo "3. 选择 'Add or remove components'"
        echo ""
        echo "4. 勾选: Qt ${QT_VERSION}"
        echo "   展开后找到并勾选："
        echo "   ✅ Documentation"
        echo ""
        echo "   注意：文档是整体安装的，不分单独模块"
        echo ""
        echo "5. 点击 'Next' 开始安装"
        echo ""
        echo "6. 文档将安装到: $DOC_DIR"
        echo ""
        ;;
    2)
        echo ""
        echo "📦 手动下载步骤："
        echo ""
        echo "1. 访问 Qt 下载仓库："
        echo "   https://download.qt.io/online/qtsdkrepository/"
        echo ""
        echo "2. 选择平台："
        if [[ "$OSTYPE" == "darwin"* ]]; then
            echo "   → mac_x64/desktop/qt6_${QT_VERSION//./}/"
        else
            echo "   → linux_x64/desktop/qt6_${QT_VERSION//./}/"
        fi
        echo ""
        echo "3. 查找文档包（以 .doc. 开头的目录）："
        echo "   - qt.qt6.${QT_VERSION//./}.doc.qtcore"
        echo "   - qt.qt6.${QT_VERSION//./}.doc.qtquick"
        echo "   - qt.qt6.${QT_VERSION//./}.doc.qtqml"
        echo "   - qt.qt6.${QT_VERSION//./}.doc.qtquickcontrols"
        echo ""
        echo "4. 下载 .7z 文件并解压到: $DOC_DIR"
        echo ""
        echo "5. 在 Qt Creator 中添加："
        echo "   Preferences → Help → Documentation → Add"
        echo "   选择 .qch 文件"
        echo ""
        
        # 尝试打开浏览器
        if command -v open &> /dev/null; then
            read -p "是否在浏览器中打开下载页面？(y/n) " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                open "https://download.qt.io/online/qtsdkrepository/"
            fi
        fi
        ;;
    3)
        echo ""
        echo "🌐 在线文档链接："
        echo ""
        echo "Qt 6 官方文档: https://doc.qt.io/qt-6/"
        echo ""
        echo "常用组件文档："
        echo "  • Qt Quick:     https://doc.qt.io/qt-6/qtquick-index.html"
        echo "  • QML Types:    https://doc.qt.io/qt-6/qmltypes.html"
        echo "  • Text:         https://doc.qt.io/qt-6/qml-qtquick-text.html"
        echo "  • Rectangle:    https://doc.qt.io/qt-6/qml-qtquick-rectangle.html"
        echo "  • ListView:     https://doc.qt.io/qt-6/qml-qtquick-listview.html"
        echo "  • Controls:     https://doc.qt.io/qt-6/qtquickcontrols-index.html"
        echo "  • Button:       https://doc.qt.io/qt-6/qml-qtquick-controls-button.html"
        echo ""
        echo "💡 提示：在 Qt Creator 中配置使用外部浏览器查看文档"
        echo "   Preferences → Help → General → Use External Viewer"
        echo ""
        ;;
    *)
        echo "无效选择"
        exit 1
        ;;
esac

echo ""
echo "✅ 完成！"
echo ""
echo "📝 后续步骤："
echo ""
echo "1. 在 Qt Creator 中添加文档："
echo "   Preferences → Help → Documentation → Add"
echo ""
echo "2. 选择文档文件 (.qch)："
echo "   $DOC_DIR/*.qch"
echo ""
echo "3. 测试文档："
echo "   - 打开 QML 文件"
echo "   - 将光标放在组件上（如 Text）"
echo "   - 按 F1 查看文档"
echo ""
