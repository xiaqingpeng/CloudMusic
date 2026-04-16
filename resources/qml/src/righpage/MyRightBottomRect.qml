import QtQuick
import QtQuick.Window
import QtQuick.Layouts

import "./components/audiobook"
import "./components/bannerswiper"
import "./components/songlist"
import "../viewmodels"

Rectangle {
    id: rightBottomRect
    color: "#1a1a21"
    
    // 使用 Flickable 包裹整个内容区，实现竖向滚动
    Flickable {
        anchors.fill: parent
        contentHeight: contentColumn.height
        clip: true
        boundsBehavior: Flickable.StopAtBounds
        
        // 使用 Column 来管理垂直布局
        Column {
            id: contentColumn
            width: parent.width
            spacing: 16
            padding: 16

        BannerSwiper {
            width: parent.width - 32
            height: 180
        }

        // 官方歌单标题栏
        Row {
            width: parent.width - 32
            height: 30
            spacing: 8
            
            Text {
                text: "官方歌单"
                font.bold: true
                font.pixelSize: 18
                color: "#ffffff"
                anchors.verticalCenter: parent.verticalCenter
            }
            
            Text {
                text: "›"
                font.pixelSize: 20
                color: "#999999"
                anchors.verticalCenter: parent.verticalCenter
                
                MouseArea {
                    anchors.fill: parent
                    anchors.margins: -8
                    cursorShape: Qt.PointingHandCursor
                    onClicked: console.log("进入官方歌单全列表")
                }
            }
        }

        // 横向滚动歌单区域
        Item {
            width: parent.width - 32
            height: 360
            
            // 左箭头按钮
            Rectangle {
                id: leftArrow
                width: 40
                height: 40
                radius: 20
                color: "#ffffff"
                opacity: 0.9
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: -20
                visible: playlistFlickable.contentX > 0
                z: 10
                
                Text {
                    text: "‹"
                    font.pixelSize: 28
                    color: "#000000"
                    anchors.centerIn: parent
                }
                
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
                    onEntered: parent.opacity = 1.0
                    onExited: parent.opacity = 0.9
                    onClicked: {
                        playlistFlickable.contentX = Math.max(0, playlistFlickable.contentX - 500)
                    }
                }
            }
            
            // 右箭头按钮
            Rectangle {
                id: rightArrow
                width: 40
                height: 40
                radius: 20
                color: "#ffffff"
                opacity: 0.9
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: -20
                visible: playlistFlickable.contentX < playlistFlickable.contentWidth - playlistFlickable.width
                z: 10
                
                Text {
                    text: "›"
                    font.pixelSize: 28
                    color: "#000000"
                    anchors.centerIn: parent
                }
                
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
                    onEntered: parent.opacity = 1.0
                    onExited: parent.opacity = 0.9
                    onClicked: {
                        playlistFlickable.contentX = Math.min(
                            playlistFlickable.contentWidth - playlistFlickable.width,
                            playlistFlickable.contentX + 500
                        )
                    }
                }
            }
            
            // 横向滚动视图
            Flickable {
                id: playlistFlickable
                anchors.fill: parent
                contentWidth: playlistRow.implicitWidth
                contentHeight: height
                clip: true
                boundsBehavior: Flickable.StopAtBounds
                
                Behavior on contentX {
                    NumberAnimation { duration: 300; easing.type: Easing.OutCubic }
                }
                
                Row {
                    id: playlistRow
                    spacing: 12
                    height: parent.height
                    rightPadding: 12
                    
                    Repeater {
                        model: ContentViewModel.officialPlaylists
                        
                        delegate: Rectangle {
                            id: playlistCard
                            width: 240
                            height: 340
                            radius: 12
                            color: model.coverColor
                            clip: true
                            
                            property bool isHovered: false
                            
                            // 背景图片（悬浮时显示）
                            Rectangle {
                                anchors.fill: parent
                                color: model.coverColor
                                radius: 12
                                
                                // 这里可以添加真实的图片，暂时用渐变模拟
                                Rectangle {
                                    anchors.fill: parent
                                    radius: 12
                                    gradient: Gradient {
                                        GradientStop { position: 0.0; color: Qt.lighter(model.coverColor, 1.3) }
                                        GradientStop { position: 1.0; color: Qt.darker(model.coverColor, 1.2) }
                                    }
                                    opacity: playlistCard.isHovered ? 1.0 : 0.0
                                    
                                    Behavior on opacity {
                                        NumberAnimation { duration: 200 }
                                    }
                                }
                            }
                            
                            // 内容区域
                            Item {
                                anchors.fill: parent
                                anchors.margins: 16
                                
                                // 播放次数
                                Row {
                                    id: playCountRow
                                    anchors.top: parent.top
                                    anchors.right: parent.right
                                    spacing: 4
                                    
                                    Text {
                                        text: "🎧"
                                        font.pixelSize: 16
                                        color: "#ffffff"
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                    
                                    Text {
                                        text: model.playCount
                                        font.pixelSize: 14
                                        font.bold: true
                                        color: "#ffffff"
                                        anchors.verticalCenter: parent.verticalCenter
                                    }
                                }
                                
                                // 底部内容区
                                Column {
                                    anchors.left: parent.left
                                    anchors.right: parent.right
                                    anchors.bottom: parent.bottom
                                    spacing: 0
                                    
                                    // 主标题
                                    Text {
                                        width: parent.width
                                        text: model.mainTitle
                                        font.pixelSize: 36
                                        font.bold: true
                                        color: "#ffffff"
                                        wrapMode: Text.WordWrap
                                    }
                                    
                                    // 副标题
                                    Text {
                                        width: parent.width
                                        text: model.subTitle
                                        font.pixelSize: 14
                                        color: "#ffffff"
                                        wrapMode: Text.WordWrap
                                        lineHeight: 1.4
                                        maximumLineCount: 2
                                        elide: Text.ElideRight
                                        topPadding: 12
                                        bottomPadding: model.tag1 !== "" ? 16 : 60
                                    }
                                    
                                    // 标签列表
                                    Column {
                                        width: parent.width
                                        spacing: 8
                                        visible: model.tag1 !== ""
                                        bottomPadding: 16
                                        
                                        Text {
                                            text: model.tag1
                                            font.pixelSize: 14
                                            color: "#ffffff"
                                            opacity: 0.95
                                            visible: model.tag1 !== ""
                                        }
                                        
                                        Text {
                                            text: model.tag2
                                            font.pixelSize: 14
                                            color: "#ffffff"
                                            opacity: 0.95
                                            visible: model.tag2 !== ""
                                        }
                                        
                                        Text {
                                            text: model.tag3
                                            font.pixelSize: 14
                                            color: "#ffffff"
                                            opacity: 0.95
                                            visible: model.tag3 !== ""
                                        }
                                    }
                                    
                                    // 播放按钮（仅悬浮时显示）
                                    Rectangle {
                                        width: 56
                                        height: 56
                                        radius: 28
                                        color: "#ffffff"
                                        anchors.right: parent.right
                                        opacity: playlistCard.isHovered ? 1.0 : 0.0
                                        visible: opacity > 0
                                        
                                        Behavior on opacity {
                                            NumberAnimation { duration: 200 }
                                        }
                                        
                                        Text {
                                            text: "▶"
                                            font.pixelSize: 20
                                            color: "#000000"
                                            anchors.centerIn: parent
                                            anchors.horizontalCenterOffset: 2
                                        }
                                        
                                        MouseArea {
                                            anchors.fill: parent
                                            cursorShape: Qt.PointingHandCursor
                                            onClicked: {
                                                console.log("播放歌单:", model.mainTitle)
                                                mouse.accepted = true
                                            }
                                        }
                                    }
                                }
                            }
                            
                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                hoverEnabled: true
                                onEntered: playlistCard.isHovered = true
                                onExited: playlistCard.isHovered = false
                                onClicked: console.log("打开歌单:", model.mainTitle)
                            }
                        }
                    }
                }
            }
        }

        // 精选有声书标题栏
        Row {
            width: parent.width - 32
            height: 30
            spacing: 12
            
            Text {
                text: "精选有声书"
                font.bold: true
                font.pixelSize: 18
                color: "#ffffff"
                anchors.verticalCenter: parent.verticalCenter
            }
            
            // 全部分类按钮
            Rectangle {
                width: 90
                height: 28
                radius: 14
                color: "#2d2d37"
                anchors.verticalCenter: parent.verticalCenter
                
                Row {
                    anchors.centerIn: parent
                    spacing: 4
                    
                    Text {
                        text: "全部分类"
                        font.pixelSize: 12
                        color: "#ffffff"
                    }
                    
                    Text {
                        text: "▾"
                        font.pixelSize: 10
                        color: "#999999"
                    }
                }
                
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: console.log("打开分类菜单")
                }
            }
        }

        // 双列网格列表
        GridView {
            id: audioBookGrid
            width: parent.width - 32
            height: Math.ceil(audioBookGrid.count / 2) * 130
            cellWidth: (width - 16) / 2
            cellHeight: 130
            clip: true
            interactive: false  // 禁用 GridView 自己的滚动，使用外层 Flickable 滚动
            
            model: ContentViewModel.audioBooks
            
            delegate: AudioBookCard {
                width: audioBookGrid.cellWidth - 8
                height: audioBookGrid.cellHeight - 8
                coverType: model.coverType
                titleText: model.title
                descText: model.desc
                scoreText: model.score
                playCountText: model.playCount
                tagText: model.tags
            }
        }
        }
    }
}
