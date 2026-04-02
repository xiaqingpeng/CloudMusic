import QtQuick
import QtQuick.Controls
import "./components"

Rectangle {
    id: bottomRect
    height: 100
    color: "#2d2d37"
    
    // 模拟播放状态
    property bool isPlaying: false
    property real progress: 0.0
    property bool isLiked: false
    
    // 进度条动画
    Timer {
        id: progressTimer
        interval: 100
        running: bottomRect.isPlaying
        repeat: true
        onTriggered: {
            if (bottomRect.progress < 1.0) {
                bottomRect.progress += 0.001
            } else {
                bottomRect.progress = 0
            }
        }
    }
    
    // 顶部进度条
    ProgressBar {
        anchors.top: parent.top
        progress: bottomRect.progress
        onSeekRequested: (position) => {
            bottomRect.progress = position
        }
    }
    
    // 主内容区
    Item {
        anchors.fill: parent
        anchors.topMargin: 3
        
        // 左侧：专辑封面 + 歌曲信息
        Row {
            id: leftSection
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            spacing: 15
            
            AlbumCover {
                isPlaying: bottomRect.isPlaying
                anchors.verticalCenter: parent.verticalCenter
            }
            
            SongInfo {
                anchors.verticalCenter: parent.verticalCenter
                songName: "栖息地"
                artistName: "Mikey-18 / 暴躁的兔子"
            }
        }
        
        // 中间：交互按钮（居中对齐）
        Row {
            id: centerSection
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            spacing: 25
            
            // 点赞按钮
            ActionButton {
                anchors.verticalCenter: parent.verticalCenter
                icon: bottomRect.isLiked ? "❤" : "♡"
                count: bottomRect.isLiked ? "1000+" : "999+"
                iconColor: bottomRect.isLiked ? "#ec4141" : "#999999"
                onClicked: {
                    bottomRect.isLiked = !bottomRect.isLiked
                }
            }
            
            // 评论按钮
            ActionButton {
                anchors.verticalCenter: parent.verticalCenter
                icon: "💬"
                count: "549"
                onClicked: console.log("打开评论")
            }
            
            // 转发按钮
            ActionButton {
                anchors.verticalCenter: parent.verticalCenter
                icon: "↻"
                iconSize: 26
                onClicked: console.log("转发")
            }
            
            // 收藏按钮
            ActionButton {
                anchors.verticalCenter: parent.verticalCenter
                icon: "←"
                onClicked: console.log("收藏")
            }
            
            // 播放/暂停按钮
            PlayButton {
                anchors.verticalCenter: parent.verticalCenter
                isPlaying: bottomRect.isPlaying
                onClicked: {
                    bottomRect.isPlaying = !bottomRect.isPlaying
                }
            }
            
            // 下一首按钮
            ActionButton {
                anchors.verticalCenter: parent.verticalCenter
                icon: "→"
                onClicked: console.log("下一首")
            }
            
            // 播放列表按钮
            ActionButton {
                anchors.verticalCenter: parent.verticalCenter
                icon: "☰"
                onClicked: console.log("播放列表")
            }
        }
        
        // 右侧：功能按钮（右对齐）
        Row {
            id: rightSection
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            spacing: 20
            
            // 「极高」音质按钮
            ControlButton {
                anchors.verticalCenter: parent.verticalCenter
                text: "极高"
                bold: true
                onClicked: console.log("切换音质")
            }
            
            // 「+」加号按钮
            ControlButton {
                anchors.verticalCenter: parent.verticalCenter
                text: "+"
                fontSize: 20
                implicitWidth: 28
                onClicked: console.log("添加到歌单")
            }
            
            // 「词」歌词按钮
            Item {
                width: 40
                height: 40
                anchors.verticalCenter: parent.verticalCenter
                
                property bool lyricActive: false
                
                Text {
                    text: "词"
                    font.pixelSize: 20
                    font.bold: true
                    color: parent.lyricActive ? "#ec4141" : "#999999"
                    anchors.centerIn: parent
                }
                
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        parent.lyricActive = !parent.lyricActive
                        console.log("切换歌词显示")
                    }
                }
            }
            
            // 音量按钮
            Item {
                width: 40
                height: 40
                anchors.verticalCenter: parent.verticalCenter
                
                Text {
                    text: "🔊"
                    font.pixelSize: 20
                    color: "#999999"
                    anchors.centerIn: parent
                }
                
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: console.log("音量控制")
                }
            }
            
            // 更多按钮（三个点）
            Item {
                width: 40
                height: 40
                anchors.verticalCenter: parent.verticalCenter
                
                Row {
                    spacing: 3
                    anchors.centerIn: parent
                    
                    Repeater {
                        model: 3
                        Rectangle {
                            width: 4
                            height: 4
                            radius: 2
                            color: "#999999"
                        }
                    }
                }
                
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: console.log("更多操作")
                }
            }
        }
    }
}
