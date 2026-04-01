import QtQuick
import QtQuick.Controls
import "../theme"

Rectangle {
    width: 200
    height: 260
    color: theme.cardBg
    radius: theme.radius
    clip: true

    Column {
        anchors.fill: parent
        spacing: 8
        anchors.margins: 12

        Rectangle {
            width: parent.width-24
            height: 140
            color: "#eee"
            radius: theme.radius
        }

        Text {
            text: "歌单标题"
            font.bold:true; font.family: theme.font
            color: theme.text
        }
        Text {
            text: "这是一个描述信息"
            font.family: theme.font
            color: theme.textGray
            font.pixelSize: 12
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: parent.scale = 1.02
        onExited: parent.scale = 1.0
    }
    Behavior on scale { NumberAnimation { duration:100 } }
}
