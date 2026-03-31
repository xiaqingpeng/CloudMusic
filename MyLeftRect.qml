import QtQuick
import QtQuick.Window

Rectangle {

    id: leftRect

    width: 255

    color: "#1a1a21"

    // 在左侧栏内部添加拖动逻辑
    TapHandler {
        // 关键：由于这个组件在 Window 内，可以直接通过 id 访问 window
        // 或者使用 Window.window 附加属性
        onPressedChanged: {
            if (pressed) {
                // 这里的 'window' 对应 Main.qml 里的 Window id
                window.startSystemMove()
            }
        }
    }

    MyLeftTopRect {
        id: leftTopRect
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
    }

    MyLeftBottomRect {
        id: leftBottomRect
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: leftTopRect.bottom
    }
}
