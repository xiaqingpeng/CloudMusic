import QtQuick
import QtQuick.Window
import QtQuick.Layouts

Rectangle {
    id: rightBottomRect
    color: "#1a1a21"
    
    // 使用ColumnLayout来管理垂直布局
    ColumnLayout {
        anchors.fill: parent
        spacing: 16
        anchors.margins: 16

        BannerSwiper {
            Layout.fillWidth: true
            height: 180
        }

        // 官方歌单标题栏
        Row {
            Layout.fillWidth: true
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
                text: "→"
                font.pixelSize: 20
                color: "#999999"
                anchors.verticalCenter: parent.verticalCenter
                
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: console.log("进入官方歌单全列表")
                }
            }
        }

        // 横向滚动歌单区域
        Item {
            Layout.fillWidth: true
            height: 240
            
            // 左箭头按钮
            Rectangle {
                id: leftArrow
                width: 36
                height: 36
                radius: 18
                color: "#3d3d47"
                anchors.left: parent.left
                anchors.verticalCenter: parent.verticalCenter
                anchors.leftMargin: 5
                visible: playlistFlickable.contentX > 0
                z: 10
                
                Text {
                    text: "‹"
                    font.pixelSize: 24
                    color: "#ffffff"
                    anchors.centerIn: parent
                }
                
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        playlistFlickable.contentX = Math.max(0, playlistFlickable.contentX - 400)
                    }
                }
            }
            
            // 右箭头按钮
            Rectangle {
                id: rightArrow
                width: 36
                height: 36
                radius: 18
                color: "#3d3d47"
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.rightMargin: 5
                visible: playlistFlickable.contentX < playlistFlickable.contentWidth - playlistFlickable.width
                z: 10
                
                Text {
                    text: "›"
                    font.pixelSize: 24
                    color: "#ffffff"
                    anchors.centerIn: parent
                }
                
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        playlistFlickable.contentX = Math.min(
                            playlistFlickable.contentWidth - playlistFlickable.width,
                            playlistFlickable.contentX + 400
                        )
                    }
                }
            }
            
            // 横向滚动视图
            Flickable {
                id: playlistFlickable
                anchors.fill: parent
                contentWidth: playlistRow.width
                contentHeight: height
                clip: true
                boundsBehavior: Flickable.StopAtBounds
                
                Behavior on contentX {
                    NumberAnimation { duration: 300; easing.type: Easing.OutCubic }
                }
                
                Row {
                    id: playlistRow
                    spacing: 16
                    height: parent.height
                    
                    Repeater {
                        model: ListModel {
                            ListElement {
                                playCount: "569.5万"
                                name: "全球流行趋势 | 单依纯,Mariah Carey,胡彦斌..."
                            }
                            ListElement {
                                playCount: "64.8万"
                                name: "Phonk新歌到 | 更新2026 全球最新冯克单曲"
                            }
                            ListElement {
                                playCount: "169.7万"
                                name: "R&B咖啡吧 | 用R&B和咖啡碰个杯"
                            }
                            ListElement {
                                playCount: "452.6万"
                                name: "华语流行Hi-Res | 经典华语歌曲随身听"
                            }
                            ListElement {
                                playCount: "328.3万"
                                name: "欧美经典 | 永不过时的旋律"
                            }
                        }
                        
                        delegate: SongListCard {
                            playCountText: model.playCount
                            nameText: model.name
                        }
                    }
                }
            }
        }

        // 精选有声书标题栏
        Row {
            Layout.fillWidth: true
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
            Layout.fillWidth: true
            Layout.fillHeight: true
            cellWidth: (parent.width - 16) / 2
            cellHeight: 130
            clip: true
            
            model: ListModel {
                ListElement {
                    coverType: "special"
                    title: "听过的有声书"
                    desc: "听过的好书都在这"
                    score: ""
                    playCount: ""
                    tags: ""
                }
                ListElement {
                    coverType: "normal"
                    title: "半夜别回头"
                    desc: "招魂游戏，不要轻易尝试"
                    score: "9.6分"
                    playCount: "480.8万"
                    tags: "高分必听"
                }
                ListElement {
                    coverType: "normal"
                    title: "广播剧《纸飞机》"
                    desc: "一起走吧，一起寻找光"
                    score: "9.8分"
                    playCount: "1445.6万"
                    tags: "高分必听"
                }
                ListElement {
                    coverType: "normal"
                    title: "月亮与六便士"
                    desc: "满地都是六便士，他却抬头看见了月亮"
                    score: "9.3分"
                    playCount: "201.7万"
                    tags: "高分必听"
                }
                ListElement {
                    coverType: "normal"
                    title: "我在荒岛被美女包围了"
                    desc: "这座荒岛，我罩了！"
                    score: "8.9分"
                    playCount: "204.8万"
                    tags: "新人免费听"
                }
                ListElement {
                    coverType: "normal"
                    title: "欲言难止 | 顺子X倒霉死勒"
                    desc: "《囚于永夜》同作者人气作品"
                    score: "9.8分"
                    playCount: "2596.5万"
                    tags: "高分必听"
                }
            }
            
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
