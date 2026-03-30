import QtQuick
import QtQuick.Window

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("网易云音乐")

    MyLeftRect {
          id: leftRect
          anchors.bottom: parent.bottom
          anchors.top: parent.top
    }

    MyRightRect {
          id: rightRect
          anchors.bottom: bottomRect.top
          anchors.left: leftRect.right
          anchors.right: parent.right
          anchors.top: parent.top
    }

    MyBottomRect {
        id: bottomRect
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
    }

}
