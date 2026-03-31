import QtQuick
import QtQuick.Window

Window {
    id: window
    width: 1317
    height: 933
    visible: true
    flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowSystemMenuHint
           | Qt.WindowMaximizeButtonHint | Qt.WindowMinimizeButtonHint // 必须开启无边框

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

    MouseArea {
        // 只覆盖右侧区域，避开左侧边栏的按钮
        anchors.top: parent.top
        anchors.left: leftRect.right
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        property point clickPos: "0,0"

        onPressed: function (mouse) {
            clickPos = Qt.point(mouse.x, mouse.y)
        }
        onPositionChanged: function (mouse) {
            let delta = Qt.point(mouse.x - clickPos.x, mouse.y - clickPos.y)
            window.x += delta.x
            window.y += delta.y
        }
    }
}
