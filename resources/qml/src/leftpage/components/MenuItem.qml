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
    property color specialColor: "#2d2d37"
    
    signal clicked()
    
    color: selected ? selectedColor : (specialBg ? specialColor : normalColor)
    
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
        onClicked: menuItem.clicked()
    }
    
    Behavior on color {
        ColorAnimation { duration: 150 }
    }
}
