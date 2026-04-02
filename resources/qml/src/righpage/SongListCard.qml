import QtQuick
import QtQuick.Controls
import "../theme"

Rectangle {
    id: root
    width: 180
    height: 220
    color: theme.cardBg
    radius: theme.radius
    clip: true
    
    property string playCountText: "100万"
    property string nameText: "歌单标题"

    Column {
        anchors.fill: parent
        spacing: 0

        // 封面区域
        Rectangle {
            width: parent.width
            height: 140
            color: "#c9cdd1"
            radius: theme.radius
            
            // 渐变效果
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#c9cdd1" }
                GradientStop { position: 0.5; color: "#f0f2f5" }
                GradientStop { position: 1.0; color: "#c9cdd1" }
            }
            
            // 播放量标签（右上角）
            Row {
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.margins: 8
                spacing: 4
                
                Text {
                    text: "🎧"
                    font.pixelSize: 14
                    color: "#ffffff"
                }
                
                Text {
                    text: root.playCountText
                    font.pixelSize: 12
                    font.bold: true
                    color: "#ffffff"
                }
            }
        }

        // 底部信息栏
        Rectangle {
            width: parent.width
            height: 80
            color: "#c9cdd1"
            
            Text {
                text: root.nameText
                font.family: theme.font
                color: "#ffffff"
                font.pixelSize: 13
                wrapMode: Text.WordWrap
                anchors.fill: parent
                anchors.margins: 12
                verticalAlignment: Text.AlignVCenter
                lineHeight: 1.3
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onEntered: parent.scale = 1.03
        onExited: parent.scale = 1.0
        onClicked: console.log("点击了歌单：", root.nameText)
    }
    
    Behavior on scale { 
        NumberAnimation { duration: 150; easing.type: Easing.OutCubic } 
    }
}
