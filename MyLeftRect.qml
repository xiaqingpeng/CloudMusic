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

    Rectangle {
        id: leftTopRect
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        height: 60
        color: "#2d2d37"

        Column {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 12

            // 1. 上层：系统控制图标
            Row {
                spacing: 8
                // 关闭按钮
                Rectangle {
                    width: 12
                    height: 12
                    radius: 6
                    color: "#ff5f56"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: Qt.quit() // 或者使用 window.close()
                    }
                }
                // 最小化按钮
                Rectangle {
                    width: 12
                    height: 12
                    radius: 6
                    color: "#ffbd2e"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: window.showMinimized(
                                       ) // window 为 Main.qml 中的 Window id
                    }
                }

                // 最大化/还原按钮
                Rectangle {
                    width: 12
                    height: 12
                    radius: 6
                    color: "#27c93f"
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            if (window.visibility === Window.Maximized) {
                                window.showNormal()
                            } else {
                                window.showMaximized()
                            }
                        }
                    }
                }
            }

            // 2. 下层：Logo + 网易云音乐
            Row {
                spacing: 8

                // 修正位置：如果需要这一行相对于某处居中，使用 anchors
                // 但在 Column 里，通常子项会自动上下堆叠
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
    }

    Rectangle {

        id: leftBottomRect

        color: "#1a1a21"

        // 关键逻辑：
        anchors.top: leftTopRect.bottom // 顶部挨着上栏的屁股
        anchors.bottom: parent.bottom // 底部拉到父节点最下面
        anchors.left: parent.left
        anchors.right: parent.right

        Text {
            anchors.centerIn: parent
            color: "#ffffff"
            text: "leftBottomRect区域"
            font.pointSize: 18
        }
    }
}
