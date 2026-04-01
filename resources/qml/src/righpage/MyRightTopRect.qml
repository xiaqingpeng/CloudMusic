import QtQuick
import QtQuick.Window

Rectangle {
    id: rightTopRect
    height: 60
    color: "#2d2d37" // 建议换个深色，因为文字是白色的，否则看不见字

    // 1. 上层：系统控制图标
    Row {
        spacing: 8
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter

        // 关闭按钮
        Rectangle {
            id: closeBtn
            width: 18
            height: 18
            radius: 9
            color: "#ff5f56"

            Image {
                            anchors.centerIn: parent
                            width: 12
                            height: 12
                            source: "qrc:/icon/close.svg"  // 使用资源文件
                            fillMode: Image.PreserveAspectFit
                        }

            // 悬停效果
            property bool isHovered: false

            Behavior on color {
                ColorAnimation {
                    duration: 150
                }
            }

            MouseArea {
                id: closeMouseArea
                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                    closeBtn.color = "#ffffff" // 悬停时变白色
                    closeBtn.isHovered = true
                }
                onExited: {
                    closeBtn.color = "#ff5f56" // 离开时恢复原色
                    closeBtn.isHovered = false
                }
                onClicked: Qt.quit()
            }
        }

        // 最小化按钮
        Rectangle {
            id: minBtn
            width: 18
            height: 18
            radius: 9
            color: "#ffbd2e"

            Behavior on color {
                ColorAnimation {
                    duration: 150
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                    minBtn.color = "#ffffff" // 悬停时变白色
                }
                onExited: {
                    minBtn.color = "#ffbd2e" // 离开时恢复原色
                }
                onClicked: window.showMinimized()
            }
        }

        // 最大化/还原按钮
        Rectangle {
            id: maxBtn
            width: 18
            height: 18
            radius: 9
            color: "#27c93f"

            Behavior on color {
                ColorAnimation {
                    duration: 150
                }
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onEntered: {
                    maxBtn.color = "#ffffff" // 悬停时变白色
                }
                onExited: {
                    maxBtn.color = "#27c93f" // 离开时恢复原色
                }
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
}
