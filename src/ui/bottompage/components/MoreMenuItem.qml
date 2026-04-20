import QtQuick
import QtQuick.Controls

Item {
    id: root
    height: 56
    clip: true
    
    property string icon: "↓"
    property string text: "下载"
    property bool showDivider: true
    property bool hovered: false
    
    signal clicked()
    
    // 悬停背景
    Rectangle {
        anchors.fill: parent
        color: "#f5f5f5"
        opacity: root.hovered ? 1 : 0
        
        Behavior on opacity {
            NumberAnimation { duration: 150 }
        }
    }
    
    // MouseArea
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onEntered: root.hovered = true
        onExited: root.hovered = false
        onClicked: root.clicked()
    }
    
    // 内容
    Item {
        anchors.fill: parent
        anchors.leftMargin: 24
        anchors.rightMargin: 24
        
        // 图标
        Text {
            id: iconText
            text: root.icon
            font.pixelSize: 22
            color: "#666666"
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
        }
        
        // 文字
        Text {
            text: root.text
            font.pixelSize: 15
            color: "#333333"
            anchors.left: iconText.right
            anchors.leftMargin: 16
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    
    // 分隔线
    Rectangle {
        width: parent.width - 48
        height: 1
        color: "#eeeeee"
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        visible: root.showDivider
    }
}
