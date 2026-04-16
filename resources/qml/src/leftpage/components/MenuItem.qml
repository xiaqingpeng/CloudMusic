import QtQuick

// 菜单项组件
Rectangle {
    id: menuItem
    height: 48
    radius: 12
    
    property string icon: ""
    property string text: ""
    property bool selected: false
    property bool specialBg: false
    property bool hasWaveIcon: false
    property bool isCircleIcon: false
    property color selectedColor: "#ec4141"
    property color normalColor: "transparent"
    property color hoverColor: "#2a2a35"
    property color specialColor: "#ec4141"
    
    signal clicked()
    
    // 鼠标悬浮状态
    property bool hovered: false
    
    // 颜色逻辑：
    // - specialBg: 始终红色（关注项）
    // - selected: 选中时红色
    // - hovered: 悬浮时灰色
    // - 默认: 透明
    color: {
        if (specialBg) {
            return specialColor  // 关注始终红色，但不影响选中状态
        } else if (selected) {
            return selectedColor  // 选中时红色
        } else if (hovered) {
            return hoverColor  // 悬浮时灰色
        } else {
            return normalColor  // 默认透明
        }
    }
    
    Row {
        anchors.fill: parent
        anchors.leftMargin: 12
        anchors.rightMargin: 12
        spacing: 12
        
        // 图标容器
        Item {
            width: 28
            height: 28
            anchors.verticalCenter: parent.verticalCenter
            
            // 圆形背景（用于最近播放的L图标）
            Rectangle {
                anchors.fill: parent
                radius: 14
                color: isCircleIcon ? "#ffffff" : "transparent"
                visible: isCircleIcon
            }
            
            Text {
                text: menuItem.icon
                font.pixelSize: isCircleIcon ? 14 : 18
                font.bold: isCircleIcon
                color: isCircleIcon ? "#666666" : (selected ? "#ffffff" : "#999999")
                anchors.centerIn: parent
            }
        }
        
        // 文字
        Text {
            text: menuItem.text
            font.pixelSize: 14
            font.bold: selected
            color: "#ffffff"
            anchors.verticalCenter: parent.verticalCenter
        }
        
        // 弹簧
        Item {
            width: parent.width - 150
            height: 1
        }
        
        // 波浪图标（我喜欢的音乐）
        Text {
            text: "〰"
            font.pixelSize: 16
            color: "#666666"
            anchors.verticalCenter: parent.verticalCenter
            visible: hasWaveIcon && !selected
        }
    }
    
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        hoverEnabled: true
        onEntered: menuItem.hovered = true
        onExited: menuItem.hovered = false
        onClicked: menuItem.clicked()
    }
    
    Behavior on color {
        ColorAnimation { duration: 150 }
    }
}
