import QtQuick
import QtQuick.Window

Rectangle {

    id: rightRect

    color: "#13131a"
    MouseArea {
        id: mouseRightRect
        anchors.fill: parent

        onClicked: {
            console.log("打印mouseRightRect区域")
        }
    }

    Text {
        anchors.centerIn: parent
        color: "#ffffff"
        text: "RightRect区域"
        font.pointSize: 18
    }
}
