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
    onClosing: function(close) {
        // 在这里可以添加清理逻辑
        console.log("窗口正在关闭，执行清理...")
        
        // 停止音频播放（如果有）
        if (typeof MusicPlayerViewModel !== 'undefined' && MusicPlayerViewModel.stop) {
            MusicPlayerViewModel.stop()
        }
        
        // 接受关闭事件
        close.accepted = true
        
        // 延迟退出，确保清理完成
        Qt.callLater(Qt.quit)
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
