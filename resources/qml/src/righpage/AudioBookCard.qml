import QtQuick
import QtQuick.Controls
import "../theme"

Rectangle {
    width: 300
    height: 120
    color: theme.cardBg
    radius: theme.radius
    clip: true

    Row {
        anchors.fill: parent
        spacing: 12
        anchors.margins: 12

        Rectangle {
            width: 80; height:80; color:"#eee"; radius: theme.radius
        }

        Column {
            width: parent.width - 104
            height: parent.height
            // verticalAlignment: Qt.AlignVCenter
            spacing: 4

            Text {
                text: "有声书标题"
                font.bold:true; font.family: theme.font
                color: theme.text
                // maximumHeight: 40;
                wrapMode: Text.Wrap
            }
            Text {
                text: "精彩简介内容"
                font.family: theme.font
                color: theme.textGray
                font.pixelSize:12
            }
            Row {
                spacing: 10
                Text { text:"⭐ 9.5"; color:theme.textGray; font.pixelSize:12 }
                Text { text:"123.4万"; color:theme.textGray; font.pixelSize:12 }
            }
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
