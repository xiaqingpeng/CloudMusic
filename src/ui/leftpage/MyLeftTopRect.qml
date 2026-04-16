import QtQuick
import QtQuick.Window
import QtQuick.Layouts

import QtQuick.Controls

Rectangle {
    id: leftTopRect
    height: 60
    color: "#2d2d37"

    Row {
        spacing: 8

        anchors.centerIn: parent

        Image {
            Layout.preferredWidth: 24
            Layout.preferredHeight: 24
            Layout.alignment: Qt.AlignVCenter

            anchors.verticalCenter: parent.verticalCenter

            source: "qrc:/qt/qml/CloudMusic/src/resources/icons/music.svg"


            onStatusChanged: {
                if (status === Image.Error) {
                    console.log("Failed to load image:", source)
                }
            }
        }

        Text {
            color: "#ffffff"
            text: "网易云音乐"
            font.pointSize: 18
            font.bold: true
            // 确保文字和左侧图标垂直对齐
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
