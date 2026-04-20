import QtQuick
import QtQuick.Controls

Item {
    id: root
    height: 88
    clip: true
    
    property string icon: "H"
    property string iconBgColor: "#fff0f0"
    property string iconColor: "#ec4141"
    property string title: "高解析度无损 (Hi-Res)"
    property string description: "更饱满清晰的高解析度音质"
    property bool isSelected: false
    property bool showDivider: true
    property bool hovered: false  // 悬停状态
    
    signal clicked()
    
    // 悬停背景
    Rectangle {
        anchors.fill: parent
        color: "#fafafa"
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
        clip: true  // 裁剪超出部分
        
        // 图标
        Rectangle {
            id: iconRect
            width: 52
            height: 52
            radius: 26
            color: root.iconBgColor
            anchors.left: parent.left
            anchors.verticalCenter: parent.verticalCenter
            
            Text {
                text: root.icon
                font.pixelSize: root.icon.length > 1 ? 16 : 22
                font.weight: Font.Bold
                color: root.iconColor
                anchors.centerIn: parent
            }
        }
        
        // 文字信息
        Column {
            anchors.left: iconRect.right
            anchors.leftMargin: 16
            anchors.right: checkMark.left
            anchors.rightMargin: 16
            anchors.verticalCenter: parent.verticalCenter
            spacing: 6
            clip: true  // 裁剪超出部分
            
            Text {
                text: root.title
                font.pixelSize: 16
                font.weight: Font.Normal
                color: "#18191c"
                width: parent.width
                elide: Text.ElideRight
            }
            
            Text {
                text: root.description
                font.pixelSize: 13
                color: "#a0a4aa"
                width: parent.width
                wrapMode: Text.WordWrap
                lineHeight: 1.3
                maximumLineCount: 2
            }
        }
        
        // 选中标记
        Item {
            id: checkMark
            width: 32
            height: 32
            anchors.right: parent.right
            anchors.verticalCenter: parent.verticalCenter
            
            Rectangle {
                width: 20
                height: 20
                radius: 10
                color: root.isSelected ? "#ec4141" : "transparent"
                border.width: root.isSelected ? 0 : 1.5
                border.color: "#e1e3e6"
                anchors.centerIn: parent
                
                Behavior on color {
                    ColorAnimation { duration: 200 }
                }
                
                Behavior on border.color {
                    ColorAnimation { duration: 200 }
                }
                
                // 对勾
                Text {
                    text: "✓"
                    font.pixelSize: 14
                    font.weight: Font.Bold
                    color: "#ffffff"
                    anchors.centerIn: parent
                    visible: root.isSelected
                }
            }
        }
    }
    
    // 分隔线
    Rectangle {
        width: parent.width - 48
        height: 1
        color: "#f0f2f5"
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        visible: root.showDivider
    }
}
