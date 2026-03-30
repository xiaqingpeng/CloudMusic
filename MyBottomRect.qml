import QtQuick
import QtQuick.Window

Rectangle {

    id: bottomRect

    height: 100

    color: "#2d2d37"

    MouseArea {
        id: mouseBottomRect
        anchors.fill: parent

        onClicked: {
            console.log("打印mouseBottomRect区域")

        }
    }

    Text {
        anchors.centerIn: parent
        color: "#ffffff"
        text: "BottomRect区域"
        font.pointSize: 18
    }
}
