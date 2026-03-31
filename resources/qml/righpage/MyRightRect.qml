import QtQuick
import QtQuick.Window

Rectangle {
    id: rightRect
    color: "#13131a"
    
    Rectangle {
        id: rightTopRect
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        
        
        height: 60
        color: "#2d2d37" // 建议换个深色，因为文字是白色的，否则看不见字
        
        Text {
            anchors.centerIn: parent
            color: "#ffffff"
            text: "rightTopRect区域"
            font.pointSize: 18
        }
    }
    
    Rectangle {
        id: rightBottomRect
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: rightTopRect.bottom
        
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
}
