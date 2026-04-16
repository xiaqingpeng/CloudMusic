import QtQuick
import QtQuick.Controls

// 播放列表抽屉
Item {
    id: drawer
    anchors.fill: parent
    visible: false
    
    // 控制抽屉显示/隐藏
    property bool opened: false
    
    // 播放列表数据模型
    property var playlist: [
        {
            title: "与君游",
            artist: "黄龄KAKI / 梦然...",
            duration: "02:12",
            cover: "",
            hasVideo: true,
            quality: "超清母带"
        },
        {
            title: "栖息地",
            artist: "Mikey-18 / 暴躁的...",
            duration: "03:12",
            cover: "",
            hasVideo: false,
            quality: "Hi-Res"
        },
        {
            title: "蝉与雪",
            artist: "五色石南叶 / 小爱...",
            duration: "04:46",
            cover: "",
            hasVideo: false,
            quality: "超清母带"
        },
        {
            title: "湖心亭看雪",
            artist: "李学仕",
            duration: "03:36",
            cover: "",
            hasVideo: false,
            quality: "超清母带"
        },
        {
            title: "缠风月",
            artist: "世界之外",
            duration: "04:34",
            cover: "",
            hasVideo: false,
            quality: "超清母带"
        },
        {
            title: "问关东",
            artist: "刘烨澈",
            duration: "04:12",
            cover: "",
            hasVideo: false,
            quality: "超清母带",
            isPlaying: true
        },
        {
            title: "阔影成玦（一二回人曲）",
            artist: "玄觞",
            duration: "04:39",
            cover: "",
            hasVideo: false,
            quality: "超清母带"
        },
        {
            title: "红昭愿",
            artist: "音阙诗听 / 王梓钰",
            duration: "03:38",
            cover: "",
            hasVideo: true,
            quality: "超清母带"
        },
        {
            title: "琵琶行",
            artist: "奇然 / 沈谧仁",
            duration: "05:21",
            cover: "",
            hasVideo: false,
            quality: "Hi-Res"
        },
        {
            title: "芒种",
            artist: "音阙诗听 / 赵方婧",
            duration: "03:36",
            cover: "",
            hasVideo: true,
            quality: "超清母带"
        },
        {
            title: "盗将行",
            artist: "花粥 / 马雨阳",
            duration: "04:21",
            cover: "",
            hasVideo: false,
            quality: "超清母带"
        },
        {
            title: "起风了",
            artist: "买辣椒也用券",
            duration: "05:26",
            cover: "",
            hasVideo: true,
            quality: "Hi-Res"
        },
        {
            title: "下山",
            artist: "要不要买菜",
            duration: "03:42",
            cover: "",
            hasVideo: false,
            quality: "超清母带"
        },
        {
            title: "世间美好与你环环相扣",
            artist: "柏松",
            duration: "04:28",
            cover: "",
            hasVideo: false,
            quality: "超清母带"
        },
        {
            title: "桥边姑娘",
            artist: "海伦",
            duration: "03:44",
            cover: "",
            hasVideo: true,
            quality: "Hi-Res"
        },
        {
            title: "可可托海的牧羊人",
            artist: "王琪",
            duration: "05:38",
            cover: "",
            hasVideo: false,
            quality: "超清母带"
        },
        {
            title: "踏山河",
            artist: "是七叔呢",
            duration: "03:18",
            cover: "",
            hasVideo: true,
            quality: "超清母带"
        },
        {
            title: "大风吹",
            artist: "王赫野 / 刘艺雯",
            duration: "04:15",
            cover: "",
            hasVideo: false,
            quality: "Hi-Res"
        },
        {
            title: "白月光与朱砂痣",
            artist: "大籽",
            duration: "04:01",
            cover: "",
            hasVideo: false,
            quality: "超清母带"
        },
        {
            title: "星辰大海",
            artist: "黄霄雲",
            duration: "04:33",
            cover: "",
            hasVideo: true,
            quality: "超清母带"
        },
        {
            title: "四季予你",
            artist: "程响",
            duration: "03:52",
            cover: "",
            hasVideo: false,
            quality: "Hi-Res"
        }
    ]
    
    property int currentIndex: 5 // 当前播放索引
    
    // 半透明背景遮罩
    Rectangle {
        anchors.fill: parent
        color: "#80000000"
        opacity: drawer.opened ? 1 : 0
        visible: opacity > 0
        
        Behavior on opacity {
            NumberAnimation { duration: 300 }
        }
        
        MouseArea {
            anchors.fill: parent
            onClicked: drawer.close()
        }
    }
    
    // 抽屉主体
    Rectangle {
        id: drawerContent
        width: 420
        height: parent.height
        anchors.right: parent.right
        anchors.rightMargin: drawer.opened ? 0 : -width
        color: "#f5f5f7"
        
        Behavior on anchors.rightMargin {
            NumberAnimation { duration: 300; easing.type: Easing.OutCubic }
        }
        
        // 抽屉内容
        Column {
            anchors.fill: parent
            
            // 头部
            Rectangle {
                width: parent.width
                height: 70
                color: "#ffffff"
                
                Row {
                    anchors.fill: parent
                    anchors.leftMargin: 20
                    anchors.rightMargin: 20
                    spacing: 10
                    
                    // 标题
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "播放列表"
                        font.pixelSize: 18
                        font.bold: true
                        color: "#333333"
                    }
                    
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text: drawer.playlist.length
                        font.pixelSize: 14
                        color: "#999999"
                    }
                    
                    Item {
                        width: parent.width - 300
                        height: 1
                    }
                    
                    // 收藏全部按钮
                    MouseArea {
                        width: 80
                        height: parent.height
                        cursorShape: Qt.PointingHandCursor
                        
                        Row {
                            anchors.centerIn: parent
                            spacing: 5
                            
                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                text: "⊕"
                                font.pixelSize: 18
                                color: "#666666"
                            }
                            
                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                text: "收藏全部"
                                font.pixelSize: 14
                                color: "#666666"
                            }
                        }
                    }
                    
                    // 清空按钮
                    MouseArea {
                        width: 60
                        height: parent.height
                        cursorShape: Qt.PointingHandCursor
                        
                        Row {
                            anchors.centerIn: parent
                            spacing: 5
                            
                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                text: "🗑"
                                font.pixelSize: 16
                                color: "#666666"
                            }
                            
                            Text {
                                anchors.verticalCenter: parent.verticalCenter
                                text: "清空"
                                font.pixelSize: 14
                                color: "#666666"
                            }
                        }
                    }
                }
            }
            
            // 推荐提示
            Rectangle {
                width: parent.width
                height: 50
                color: "#f0f0f2"
                
                Row {
                    anchors.fill: parent
                    anchors.leftMargin: 20
                    anchors.rightMargin: 20
                    spacing: 10
                    
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "荐"
                        font.pixelSize: 12
                        color: "#ec4141"
                    }
                    
                    Text {
                        anchors.verticalCenter: parent.verticalCenter
                        text: "在列表下方推荐你喜欢的相似歌曲"
                        font.pixelSize: 13
                        color: "#666666"
                    }
                    
                    Item {
                        width: parent.width - 280
                        height: 1
                    }
                    
                    // 开关
                    Rectangle {
                        width: 44
                        height: 24
                        radius: 12
                        color: "#c8c8cc"
                        anchors.verticalCenter: parent.verticalCenter
                        
                        Rectangle {
                            width: 20
                            height: 20
                            radius: 10
                            color: "#ffffff"
                            anchors.verticalCenter: parent.verticalCenter
                            x: 2
                        }
                        
                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                        }
                    }
                }
            }
            
            // 播放列表
            ListView {
                width: parent.width
                height: parent.height - 120
                clip: true
                boundsBehavior: Flickable.StopAtBounds
                
                model: drawer.playlist
                
                // 滚动条
                ScrollBar.vertical: ScrollBar {
                    policy: ScrollBar.AsNeeded
                    width: 8
                    
                    contentItem: Rectangle {
                        implicitWidth: 8
                        radius: 4
                        color: parent.pressed ? "#999999" : "#cccccc"
                        
                        Behavior on color {
                            ColorAnimation { duration: 150 }
                        }
                    }
                    
                    background: Rectangle {
                        color: "transparent"
                    }
                }
                
                delegate: Rectangle {
                    width: ListView.view.width
                    height: 70
                    color: index === drawer.currentIndex ? "#e8e8ea" : "transparent"
                    
                    // 鼠标悬停效果
                    property bool hovered: false
                    
                    MouseArea {
                        id: itemMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: parent.hovered = true
                        onExited: parent.hovered = false
                        onClicked: {
                            drawer.currentIndex = index
                        }
                    }
                    
                    // 悬停时显示背景
                    Rectangle {
                        anchors.fill: parent
                        color: "#f0f0f2"
                        opacity: parent.hovered && index !== drawer.currentIndex ? 1 : 0
                        
                        Behavior on opacity {
                            NumberAnimation { duration: 150 }
                        }
                    }
                    
                    Row {
                        anchors.fill: parent
                        anchors.leftMargin: 20
                        anchors.rightMargin: 20
                        spacing: 15
                        
                        // 专辑封面
                        Rectangle {
                            width: 50
                            height: 50
                            radius: 4
                            color: "#d0d0d5"
                            anchors.verticalCenter: parent.verticalCenter
                            
                            // 播放图标（如果是当前播放）
                            Text {
                                visible: index === drawer.currentIndex
                                anchors.centerIn: parent
                                text: "▶"
                                font.pixelSize: 16
                                color: "#ec4141"
                            }
                        }
                        
                        // 歌曲信息
                        Column {
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 5
                            width: 180
                            
                            // 歌曲名
                            Row {
                                spacing: 5
                                width: parent.width
                                
                                // MV标签
                                Rectangle {
                                    visible: modelData.hasVideo
                                    width: 24
                                    height: 16
                                    radius: 2
                                    color: "#ec4141"
                                    anchors.verticalCenter: parent.verticalCenter
                                    
                                    Text {
                                        anchors.centerIn: parent
                                        text: "MV"
                                        font.pixelSize: 10
                                        font.bold: true
                                        color: "#ffffff"
                                    }
                                }
                                
                                Text {
                                    text: modelData.title
                                    font.pixelSize: 15
                                    color: index === drawer.currentIndex ? "#ec4141" : "#333333"
                                    elide: Text.ElideRight
                                    width: parent.width - (modelData.hasVideo ? 29 : 0)
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }
                            
                            // 歌手名和音质标签
                            Row {
                                spacing: 5
                                width: parent.width
                                
                                // 音质标签
                                Rectangle {
                                    width: qualityText.width + 8
                                    height: 16
                                    radius: 2
                                    color: "#ffeaea"
                                    border.color: "#ec4141"
                                    border.width: 1
                                    anchors.verticalCenter: parent.verticalCenter
                                    
                                    Text {
                                        id: qualityText
                                        anchors.centerIn: parent
                                        text: modelData.quality
                                        font.pixelSize: 10
                                        color: "#ec4141"
                                    }
                                }
                                
                                Text {
                                    text: modelData.artist
                                    font.pixelSize: 13
                                    color: "#999999"
                                    elide: Text.ElideRight
                                    width: parent.width - qualityText.width - 13
                                    anchors.verticalCenter: parent.verticalCenter
                                }
                            }
                        }
                        
                        Item {
                            width: 10
                            height: 1
                        }
                        
                        // 时长
                        Text {
                            visible: modelData.duration !== ""
                            anchors.verticalCenter: parent.verticalCenter
                            text: modelData.duration
                            font.pixelSize: 13
                            color: "#999999"
                        }
                        
                        // 操作按钮
                        Row {
                            anchors.verticalCenter: parent.verticalCenter
                            spacing: 15
                            
                            // 链接图标
                            Text {
                                text: "🔗"
                                font.pixelSize: 18
                                color: "#999999"
                                
                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                }
                            }
                            
                            // 喜欢图标
                            Text {
                                text: "♡"
                                font.pixelSize: 20
                                color: "#999999"
                                
                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                }
                            }
                            
                            // 添加图标
                            Text {
                                text: "⊕"
                                font.pixelSize: 20
                                color: "#999999"
                                
                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                }
                            }
                            
                            // 更多图标
                            Text {
                                text: "⋯"
                                font.pixelSize: 20
                                color: "#999999"
                                
                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    // 打开抽屉
    function open() {
        drawer.visible = true
        drawer.opened = true
    }
    
    // 关闭抽屉
    function close() {
        drawer.opened = false
        closeTimer.start()
    }
    
    // 延迟隐藏（等待动画完成）
    Timer {
        id: closeTimer
        interval: 300
        onTriggered: drawer.visible = false
    }
}
