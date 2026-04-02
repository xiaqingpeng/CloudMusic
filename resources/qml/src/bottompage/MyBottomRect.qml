import QtQuick
import QtQuick.Controls

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
    Rectangle {
        id: progressBarBg
        width: parent.width
        height: 3
        color: "#1a1a1a"
        anchors.top: parent.top
        
        Rectangle {
            id: progressBarFill
            width: parent.width * bottomRect.progress
            height: parent.height
            color: "#ec4141"
        }
        
        MouseArea {
            anchors.fill: parent
            onClicked: (mouse) => {
                bottomRect.progress = mouse.x / parent.width
            }
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
            
            // 圆形专辑封面
            Rectangle {
                id: coverContainer
                width: 70
                height: 70
                radius: 35
                color: "#3d3d47"
                clip: true
                
                Rectangle {
                    anchors.centerIn: parent
                    width: 60
                    height: 60
                    radius: 30
                    color: "#ec4141"
                    
                    Text {
                        anchors.centerIn: parent
                        text: "♪"
                        font.pixelSize: 30
                        color: "white"
                    }
                    
                    // 旋转动画
                    RotationAnimation on rotation {
                        from: 0
                        to: 360
                        duration: 20000
                        loops: Animation.Infinite
                        running: bottomRect.isPlaying
                    }
                }
                
                // 音质标签
                Rectangle {
                    width: 35
                    height: 18
                    color: "white"
                    radius: 3
                    anchors.top: parent.top
                    anchors.left: parent.left
                    anchors.margins: 3
                    
                    Text {
                        text: "极高"
                        font.pixelSize: 10
                        font.bold: true
                        color: "#333333"
                        anchors.centerIn: parent
                    }
                }
            }
            
            // 歌曲信息
            Column {
                spacing: 8
                anchors.verticalCenter: parent.verticalCenter
                
                Text {
                    text: "栖息地"
                    font.pixelSize: 16
                    font.bold: true
                    color: "#ffffff"
                }
                
                Text {
                    text: "Mikey-18 / 暴躁的兔子"
                    font.pixelSize: 12
                    color: "#999999"
                }
            }
        }
        
        // 中间：交互按钮（居中对齐）
        Row {
            id: centerSection
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            spacing: 25
            
            // 点赞按钮
            Column {
                spacing: 4
                anchors.verticalCenter: parent.verticalCenter
                
                Text {
                    text: bottomRect.isLiked ? "❤" : "♡"
                    font.pixelSize: 24
                    color: bottomRect.isLiked ? "#ec4141" : "#999999"
                    anchors.horizontalCenter: parent.horizontalCenter
                    
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            bottomRect.isLiked = !bottomRect.isLiked
                        }
                    }
                }
                
                Text {
                    text: bottomRect.isLiked ? "1000+" : "999+"
                    font.pixelSize: 11
                    color: "#999999"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            
            // 评论按钮
            Column {
                spacing: 4
                anchors.verticalCenter: parent.verticalCenter
                
                Text {
                    text: "💬"
                    font.pixelSize: 24
                    color: "#999999"
                    anchors.horizontalCenter: parent.horizontalCenter
                    
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: console.log("打开评论")
                    }
                }
                
                Text {
                    text: "549"
                    font.pixelSize: 11
                    color: "#999999"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            
            // 转发按钮
            Column {
                spacing: 4
                anchors.verticalCenter: parent.verticalCenter
                
                Text {
                    text: "↻"
                    font.pixelSize: 26
                    color: "#999999"
                    anchors.horizontalCenter: parent.horizontalCenter
                    
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: console.log("转发")
                    }
                }
            }
            
            // 收藏按钮
            Column {
                spacing: 4
                anchors.verticalCenter: parent.verticalCenter
                
                Text {
                    text: "←"
                    font.pixelSize: 24
                    color: "#999999"
                    anchors.horizontalCenter: parent.horizontalCenter
                    
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: console.log("收藏")
                    }
                }
            }
            
            // 播放/暂停按钮
            Rectangle {
                width: 70
                height: 70
                radius: 35
                color: "#ec4141"
                anchors.verticalCenter: parent.verticalCenter
                
                Text {
                    text: bottomRect.isPlaying ? "❚❚" : "▶"
                    font.pixelSize: bottomRect.isPlaying ? 20 : 24
                    color: "white"
                    anchors.centerIn: parent
                    anchors.horizontalCenterOffset: bottomRect.isPlaying ? 0 : 2
                }
                
                // 悬停效果
                scale: playMouseArea.containsMouse ? 1.05 : 1.0
                Behavior on scale {
                    NumberAnimation { duration: 150 }
                }
                
                MouseArea {
                    id: playMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        bottomRect.isPlaying = !bottomRect.isPlaying
                    }
                }
            }
            
            // 下一首按钮
            Column {
                spacing: 4
                anchors.verticalCenter: parent.verticalCenter
                
                Text {
                    text: "→"
                    font.pixelSize: 24
                    color: "#999999"
                    anchors.horizontalCenter: parent.horizontalCenter
                    
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: console.log("下一首")
                    }
                }
            }
            
            // 播放列表按钮
            Column {
                spacing: 4
                anchors.verticalCenter: parent.verticalCenter
                
                Text {
                    text: "☰"
                    font.pixelSize: 24
                    color: "#999999"
                    anchors.horizontalCenter: parent.horizontalCenter
                    
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: console.log("播放列表")
                    }
                }
            }
        }
        
        // 右侧：功能按钮（右对齐）
        Row {
            id: rightSection
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            spacing: 20
            
            // // 分隔线
            // Rectangle {
            //     width: 1
            //     height: 40
            //     color: "#4d4d57"
            //     anchors.verticalCenter: parent.verticalCenter
            // }
            
            // 「极高」音质按钮
            Rectangle {
                width: 50
                height: 28
                radius: 6
                color: "transparent"
                border.color: "#999999"
                border.width: 1.5
                anchors.verticalCenter: parent.verticalCenter
                
                Text {
                    text: "极高"
                    font.pixelSize: 12
                    font.bold: true
                    color: "#999999"
                    anchors.centerIn: parent
                }
                
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: console.log("切换音质")
                }
            }
            
            // 「+」加号按钮
            Rectangle {
                width: 28
                height: 28
                radius: 6
                color: "transparent"
                border.color: "#999999"
                border.width: 1.5
                anchors.verticalCenter: parent.verticalCenter
                
                Text {
                    text: "+"
                    font.pixelSize: 20
                    color: "#999999"
                    anchors.centerIn: parent
                }
                
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: console.log("添加到歌单")
                }
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
