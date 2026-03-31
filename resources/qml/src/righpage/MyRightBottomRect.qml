import QtQuick
import QtQuick.Window

Rectangle {
    id: rightBottomRect
    color: "#1a1a21"
    
    // 关键逻辑：
    // 顶部挨着上栏的屁股
    // 底部拉到父节点最下面
    Text {
        anchors.centerIn: parent
        color: "#ffffff"
        text: "rightBottomRect区域"
        font.pointSize: 18
    }
}
