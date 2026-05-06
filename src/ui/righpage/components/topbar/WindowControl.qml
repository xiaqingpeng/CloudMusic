import QtQuick
import QtQuick.Window

Row {
    spacing: 8
    
    // 关闭按钮
    Rectangle {
        id: closeBtn
        width: 18
        height: 18
        radius: 9
        color: closeMouseArea.containsMouse ? "#ff3b30" : "#ff5f56"
        
        Text {
            text: "×"
            font.pixelSize: 14
            font.bold: true
            color: closeMouseArea.containsMouse ? "#ffffff" : "transparent"
            anchors.centerIn: parent
        }
        
        Behavior on color {
            ColorAnimation { duration: 150 }
        }
        
        MouseArea {
            id: closeMouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                // 优雅关闭：先关闭窗口，让Qt事件循环处理清理
                window.close()
            }
        }
    }
    
    // 最小化按钮
    Rectangle {
        id: minBtn
        width: 18
        height: 18
        radius: 9
        color: minMouseArea.containsMouse ? "#f5a623" : "#ffbd2e"
        
        Text {
            text: "−"
            font.pixelSize: 14
            font.bold: true
            color: minMouseArea.containsMouse ? "#ffffff" : "transparent"
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -2
        }
        
        Behavior on color {
            ColorAnimation { duration: 150 }
        }
        
        MouseArea {
            id: minMouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
            onClicked: window.showMinimized()
        }
    }
    
    // 最大化/还原按钮
    Rectangle {
        id: maxBtn
        width: 18
        height: 18
        radius: 9
        color: maxMouseArea.containsMouse ? "#1fb834" : "#27c93f"
        
        Text {
            text: window.visibility === Window.Maximized ? "□" : "□"
            font.pixelSize: 10
            font.bold: true
            color: maxMouseArea.containsMouse ? "#ffffff" : "transparent"
            anchors.centerIn: parent
        }
        
        Behavior on color {
            ColorAnimation { duration: 150 }
        }
        
        MouseArea {
            id: maxMouseArea
            anchors.fill: parent
            hoverEnabled: true
            cursorShape: Qt.PointingHandCursor
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
