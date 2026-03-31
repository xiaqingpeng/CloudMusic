import QtQuick
import QtQuick.Window

Rectangle {
    id: leftTopRect
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
