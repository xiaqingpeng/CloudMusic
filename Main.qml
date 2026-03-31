import QtQuick
import QtQuick.Window

Window {
    id: window
    width: 640
    height: 480
    visible: true
    flags: Qt.Window | Qt.FramelessWindowHint // 必须开启无边框

    // 1. 顶部拖动区 (仅限顶部一行)
    Item {
        id: topDragArea
        height: 40
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        z: 99 // 确保在最顶层

        TapHandler {
            onPressedChanged: if (pressed)
                                  window.startSystemMove()
        }
    }

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
