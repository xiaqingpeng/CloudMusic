import QtQuick
import QtQuick.Controls
import "./components"

Rectangle {
    id: leftBottomRect
    color: "#1a1a21"
    
    property int selectedIndex: 0  // 默认选中精选
    
    // 使用 Flickable 实现滚动
    Flickable {
        anchors.fill: parent
        contentHeight: menuColumn.height
        clip: true
        boundsBehavior: Flickable.StopAtBounds
        
        Column {
            id: menuColumn
            width: parent.width
            spacing: 0
            padding: 12
            
            // 精选
            MenuItem {
                width: parent.width - 24
                icon: "🎵"
                text: "精选"
                selected: leftBottomRect.selectedIndex === 0
                onClicked: leftBottomRect.selectedIndex = 0
            }
            
            // 播客
            MenuItem {
                width: parent.width - 24
                icon: "📻"
                text: "播客"
                selected: leftBottomRect.selectedIndex === 1
                onClicked: leftBottomRect.selectedIndex = 1
            }
            
            // 关注
            MenuItem {
                width: parent.width - 24
                icon: "💬"
                text: "关注"
                selected: leftBottomRect.selectedIndex === 2
                onClicked: leftBottomRect.selectedIndex = 2
            }
            
            // 我喜欢的音乐
            MenuItem {
                width: parent.width - 24
                icon: "❤"
                text: "我喜欢的音乐"
                selected: leftBottomRect.selectedIndex === 3
                hasWaveIcon: true
                onClicked: leftBottomRect.selectedIndex = 3
            }
            
            // 最近播放
            MenuItem {
                width: parent.width - 24
                icon: "L"
                text: "最近播放"
                selected: leftBottomRect.selectedIndex === 4
                isCircleIcon: true
                onClicked: leftBottomRect.selectedIndex = 4
            }
            
            // 下载管理
            MenuItem {
                width: parent.width - 24
                icon: "↓"
                text: "下载管理"
                selected: leftBottomRect.selectedIndex === 5
                onClicked: leftBottomRect.selectedIndex = 5
            }
            
            // 间距
            Item {
                width: parent.width
                height: 12
            }
            
            // 创建的歌单
            MenuItem {
                width: parent.width - 24
                icon: "📁"
                text: "创建的歌单 0"
                selected: leftBottomRect.selectedIndex === 6
                onClicked: leftBottomRect.selectedIndex = 6
            }
        }
    }
}
