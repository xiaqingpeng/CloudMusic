import QtQuick
import QtQuick.Controls
import "./components"
import "../viewmodels"

Rectangle {
    id: bottomRect
    height: 100
    color: "#2d2d37"
    
    // 播放列表请求信号
    signal playlistRequested()
    
    // 使用 ViewModel 的播放状态
    property bool isPlaying: MusicPlayerViewModel.isPlaying
    property real progress: MusicPlayerViewModel.progress
    property bool isLiked: MusicPlayerViewModel.isLiked
    
    // 顶部进度条
    ProgressBar {
        anchors.top: parent.top
        progress: bottomRect.progress
        onSeekRequested: (position) => {
            MusicPlayerViewModel.seek(position)
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
                songName: MusicPlayerViewModel.currentSongName
                artistName: MusicPlayerViewModel.currentArtistName
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
                count: bottomRect.isLiked ? (MusicPlayerViewModel.likeCount + 1) + "+" : MusicPlayerViewModel.likeCount + "+"
                iconColor: bottomRect.isLiked ? "#ec4141" : "#999999"
                onClicked: {
                    MusicPlayerViewModel.toggleLike()
                }
            }
            
            // 评论按钮
            ActionButton {
                anchors.verticalCenter: parent.verticalCenter
                icon: "💬"
                count: MusicPlayerViewModel.commentCount.toString()
            }
            
            // 转发按钮
            ActionButton {
                anchors.verticalCenter: parent.verticalCenter
                icon: "↻"
                iconSize: 26
            }
            
            // 收藏按钮
            ActionButton {
                anchors.verticalCenter: parent.verticalCenter
                icon: "←"
            }
            
            // 播放/暂停按钮
            PlayButton {
                anchors.verticalCenter: parent.verticalCenter
                isPlaying: bottomRect.isPlaying
                onClicked: {
                    MusicPlayerViewModel.togglePlayPause()
                }
            }
            
            // 下一首按钮
            ActionButton {
                anchors.verticalCenter: parent.verticalCenter
                icon: "→"
                onClicked: {
                    MusicPlayerViewModel.nextSong()
                }
            }
            
            // 播放列表按钮
            ActionButton {
                anchors.verticalCenter: parent.verticalCenter
                icon: "☰"
                onClicked: bottomRect.playlistRequested()
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
                id: qualityButton
                anchors.verticalCenter: parent.verticalCenter
                text: MusicPlayerViewModel.currentQuality
                bold: true
                
                onClicked: {
                    // 计算弹窗位置：在按钮正上方，但要确保不超出窗口边界
                    var buttonPos = qualityButton.mapToItem(null, 0, 0)
                    var windowWidth = bottomRect.Window.window ? bottomRect.Window.window.width : 1200
                    
                    // 计算居中位置
                    var centerX = buttonPos.x + (qualityButton.width - qualityMenu.width) / 2
                    
                    // 确保不超出右边界（留 20px 边距）
                    if (centerX + qualityMenu.width > windowWidth - 20) {
                        qualityMenu.x = windowWidth - qualityMenu.width - 20
                    } else if (centerX < 20) {
                        // 确保不超出左边界
                        qualityMenu.x = 20
                    } else {
                        qualityMenu.x = centerX
                    }
                    
                    qualityMenu.y = buttonPos.y - qualityMenu.height - 10
                    qualityMenu.open()
                }
            }
            
            // 「+」加号按钮
            ControlButton {
                anchors.verticalCenter: parent.verticalCenter
                text: "+"
                fontSize: 20
                implicitWidth: 28
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
                    onClicked: parent.lyricActive = !parent.lyricActive
                }
            }
            
            // 音量按钮
            Item {
                width: 40
                height: 40
                anchors.verticalCenter: parent.verticalCenter
                
                Text {
                    text: MusicPlayerViewModel.isMuted ? "🔇" : "🔊"
                    font.pixelSize: 20
                    color: "#999999"
                    anchors.centerIn: parent
                }
                
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        MusicPlayerViewModel.toggleMute()
                    }
                }
            }
            
            // 更多按钮（三个点）
            Item {
                id: moreButton
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
                    onClicked: {
                        // 计算弹窗位置：在按钮正上方，但要确保不超出窗口边界
                        var buttonPos = moreButton.mapToItem(null, 0, 0)
                        var windowWidth = bottomRect.Window.window ? bottomRect.Window.window.width : 1200
                        
                        // 计算居中位置
                        var centerX = buttonPos.x + (moreButton.width - moreMenu.width) / 2
                        
                        // 确保不超出右边界（留 20px 边距）
                        if (centerX + moreMenu.width > windowWidth - 20) {
                            moreMenu.x = windowWidth - moreMenu.width - 20
                        } else if (centerX < 20) {
                            // 确保不超出左边界
                            moreMenu.x = 20
                        } else {
                            moreMenu.x = centerX
                        }
                        
                        moreMenu.y = buttonPos.y - moreMenu.height - 10
                        moreMenu.open()
                    }
                }
            }
        }
    }
    
    // 音质选择菜单
    QualityMenu {
        id: qualityMenu
    }
    
    // 更多操作菜单
    MoreMenu {
        id: moreMenu
    }
}
