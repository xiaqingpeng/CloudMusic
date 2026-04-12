import QtQuick
import QtQuick.Window

import "./leftpage"
import "./righpage"
import "./bottompage"
import "./commonui"
import "./viewmodels"

MyWindowRect {
    id: window
    
    // ========== 全局 ViewModel 监听 ==========
    // 在应用根组件监听全局搜索事件
    Connections {
        target: SearchViewModel
        
        function onSearchRequested(text) {
            console.log("Main.qml: 全局搜索事件触发:", text)
            // 这里可以处理全局搜索逻辑
            // 例如：导航到搜索结果页面、更新其他组件等
        }
        
        function onHistoryUpdated() {
            console.log("Main.qml: 搜索历史已更新")
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
    }
}
