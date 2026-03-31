import QtQuick
import QtQuick.Window

Rectangle {

    id: rightRect

    color: "#13131a"

    MyRightTopRect {
        id: rightTopRect
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
    }

    MyRightBottomRect {
        id: rightBottomRect
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: rightTopRect.bottom
    }
}
