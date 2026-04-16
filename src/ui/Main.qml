import QtQuick
import QtQuick.Window
import CloudMusic
import "./leftpage"
import "./righpage"
import "./bottompage"
import "./bottompage/components"
import "./commonui"

MyWindowRect {
    id: window
    
    // ========== 全局 ViewModel 监听 ==========
    // 在应用根组件监听全局搜索事件
    Connections {
        target: SearchViewModel
        
        function onSearchRequested(text) {
            // 这里可以处理全局搜索逻辑
            // 例如：导航到搜索结果页面、更新其他组件等
        }
        
        function onHistoryUpdated() {
            // 可以在这里同步到本地存储
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
        
        // 连接播放列表打开信号
        onPlaylistRequested: playlistDrawer.open()
    }
    
    // 播放列表抽屉（放在最上层）
    PlaylistDrawer {
        id: playlistDrawer
        anchors.fill: parent
        z: 1000
    }
}
