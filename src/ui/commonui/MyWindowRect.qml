import QtQuick
import QtQuick.Window

Window {
    id: window

    width: 1317*0.8
    height: 933*0.8
    visible: true
    flags: Qt.Window | Qt.FramelessWindowHint | Qt.WindowSystemMenuHint
           | Qt.WindowMaximizeButtonHint | Qt.WindowMinimizeButtonHint // 必须开启无边框

    // ========== 优雅关闭处理 ==========
    property bool isClosing: false
    
    onClosing: function(close) {
        if (isClosing) {
            // 已经在关闭流程中，直接接受
            close.accepted = true
            return
        }
        
        console.log("窗口正在关闭，执行清理...")
        isClosing = true
        
        // 执行清理
        if (typeof MusicPlayerViewModel !== 'undefined') {
            if (MusicPlayerViewModel.cleanup) {
                MusicPlayerViewModel.cleanup()
            } else if (MusicPlayerViewModel.stop) {
                MusicPlayerViewModel.stop()
            }
        }
        
        // 接受关闭事件
        close.accepted = true
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
