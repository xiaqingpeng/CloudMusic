import QtQuick
import QtQuick.Controls
import "./components"

Rectangle {
    id: leftBottomRect
    color: "#1a1a21"
    
    property int selectedIndex: 0
    
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
            
            // 主菜单项
            MenuItem {
                width: parent.width - 24
                icon: "🎵"
                text: "精选"
                selected: leftBottomRect.selectedIndex === 0
                onClicked: {
                    leftBottomRect.selectedIndex = 0
                    console.log("点击了精选")
                }
            }
            
            MenuItem {
                width: parent.width - 24
                icon: "🎙"
                text: "播客"
                selected: leftBottomRect.selectedIndex === 1
                onClicked: {
                    leftBottomRect.selectedIndex = 1
                    console.log("点击了播客")
                }
            }
            
            MenuItem {
                width: parent.width - 24
                icon: "👥"
                text: "关注"
                selected: leftBottomRect.selectedIndex === 2
                specialBg: true
                onClicked: {
                    leftBottomRect.selectedIndex = 2
                    console.log("点击了关注")
                }
            }
            
            // 分割线
            Divider {
                width: parent.width - 24
                anchors.horizontalCenter: parent.horizontalCenter
            }
            
            // 我喜欢的音乐
            MenuItem {
                width: parent.width - 24
                icon: "❤"
                text: "我喜欢的音乐"
                selected: leftBottomRect.selectedIndex === 3
                hasWaveIcon: true
                onClicked: {
                    leftBottomRect.selectedIndex = 3
                    console.log("点击了我喜欢的音乐")
                }
            }
            
            // 最近播放
            MenuItem {
                width: parent.width - 24
                icon: "L"
                text: "最近播放"
                selected: leftBottomRect.selectedIndex === 4
                isCircleIcon: true
                onClicked: {
                    leftBottomRect.selectedIndex = 4
                    console.log("点击了最近播放")
                }
            }
            
            // 下载管理
            MenuItem {
                width: parent.width - 24
                icon: "↓"
                text: "下载管理"
                selected: leftBottomRect.selectedIndex === 5
                onClicked: {
                    leftBottomRect.selectedIndex = 5
                    console.log("点击了下载管理")
                }
            }
            
            // 分割线
            Divider {
                width: parent.width - 24
                anchors.horizontalCenter: parent.horizontalCenter
            }
            
            // 创建的歌单
            SectionHeader {
                width: parent.width - 24
                anchors.horizontalCenter: parent.horizontalCenter
                title: "创建的歌单 0"
                showAddButton: true
                onAddClicked: console.log("创建歌单")
            }
            
            // 分割线
            Divider {
                width: parent.width - 24
                anchors.horizontalCenter: parent.horizontalCenter
            }
            
            // 收藏的歌单
            SectionHeader {
                width: parent.width - 24
                anchors.horizontalCenter: parent.horizontalCenter
                title: "收藏的歌单 0"
                showAddButton: false
            }
        }
    }
}
