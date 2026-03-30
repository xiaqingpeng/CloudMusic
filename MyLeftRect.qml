import QtQuick
import QtQuick.Window

Rectangle {

    id: leftRect

    width: 255

    color: "#1a1a21"

    MouseArea {
        id: mouseLeftRect
        anchors.fill: parent

        onClicked: {
            console.log("打印mouseLeftRect区域")
        }
    }

    Text {
        anchors.centerIn: parent
        color: "#ffffff"
        text: "LeftRectt区域"
        font.pointSize: 18
    }
}
