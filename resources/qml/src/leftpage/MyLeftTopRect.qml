import QtQuick
import QtQuick.Window

Rectangle {
    id: leftTopRect
    height: 60
    color: "#2d2d37"

    Row {
        spacing: 8

        anchors.centerIn: parent

        Rectangle {
            width: 18
            height: 18
            radius: 9
            color: "red"
            Text {
                anchors.centerIn: parent
                text: "♪"
                color: "white"
                font.bold: true
            }
        }

        Text {
            color: "#ffffff"
            text: "网易云音乐"
            font.pointSize: 12
            font.bold: true
            // 确保文字和左侧图标垂直对齐
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
