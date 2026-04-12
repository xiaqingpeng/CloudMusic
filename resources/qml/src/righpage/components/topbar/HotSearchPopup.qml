import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "." as TopBar

Popup {
    id: root
    
    property alias searchHistoryModel: searchHistoryRepeater.model
    property alias guessLikeModel: guessLikeRepeater.model
    
    signal historyClicked(string text)
    signal historyLongPressed(int index)
    signal clearHistoryClicked()
    signal guessLikeClicked(string text)
    signal rankingItemClicked(string text)
    
    padding: 0
    closePolicy: Popup.NoAutoClose
    
    background: Rectangle {
        color: "#ffffff"
        radius: 12
        border.color: "#e0e0e0"
        border.width: 1
    }
    
    ScrollView {
        anchors.fill: parent
        clip: true
        
        ColumnLayout {
            width: root.width - 32
            spacing: 16
            
            // ================== 搜索历史区域 ==================
            ColumnLayout {
                Layout.fillWidth: true
                Layout.leftMargin: 16
                Layout.rightMargin: 16
                Layout.topMargin: 16
                spacing: 12
                
                // 标题栏 + 删除图标
                RowLayout {
                    Layout.fillWidth: true
                    spacing: 12
                    
                    Text {
                        text: "搜索历史"
                        font.pixelSize: 16
                        font.bold: true
                        color: "#333333"
                    }
                    
                    Rectangle {
                        width: 24
                        height: 24
                        color: "transparent"
                        visible: searchHistoryRepeater.count > 0
                        
                        Text {
                            text: "🗑️"
                            font.pixelSize: 16
                            anchors.centerIn: parent
                        }
                        
                        MouseArea {
                            anchors.fill: parent
                            cursorShape: Qt.PointingHandCursor
                            onClicked: root.clearHistoryClicked()
                        }
                    }
                    
                    Item { Layout.fillWidth: true }
                }
                
                // 搜索历史标签流
                Flow {
                    Layout.fillWidth: true
                    spacing: 8
                    visible: searchHistoryRepeater.count > 0
                    
                    Repeater {
                        id: searchHistoryRepeater
                        
                        delegate: Rectangle {
                            width: tagText.width + 16
                            height: tagText.height + 16
                            radius: 16
                            color: tagMouseArea.pressed ? "#e2e8f0" : "#f3f4f6"
                            
                            Text {
                                id: tagText
                                text: model.text
                                font.pixelSize: 13
                                color: "#4a5568"
                                anchors.centerIn: parent
                            }
                            
                            MouseArea {
                                id: tagMouseArea
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                acceptedButtons: Qt.LeftButton | Qt.RightButton
                                
                                onClicked: (mouse) => {
                                    if (mouse.button === Qt.LeftButton) {
                                        root.historyClicked(model.text)
                                    }
                                }
                                
                                onPressAndHold: root.historyLongPressed(index)
                            }
                        }
                    }
                }
                
                // 空状态提示
                Text {
                    text: "暂无搜索历史"
                    font.pixelSize: 13
                    color: "#999999"
                    visible: searchHistoryRepeater.count === 0
                    Layout.alignment: Qt.AlignHCenter
                    Layout.topMargin: 20
                    Layout.bottomMargin: 20
                }
            }
            
            // ================== 猜你喜欢区域 ==================
            ColumnLayout {
                Layout.fillWidth: true
                Layout.leftMargin: 16
                Layout.rightMargin: 16
                spacing: 12
                
                Text {
                    text: "猜你喜欢"
                    font.pixelSize: 16
                    font.bold: true
                    color: "#333333"
                }
                
                Flow {
                    Layout.fillWidth: true
                    spacing: 8
                    
                    Repeater {
                        id: guessLikeRepeater
                        
                        delegate: Rectangle {
                            width: guessText.width + 16
                            height: guessText.height + 16
                            radius: 16
                            color: guessMouseArea.pressed ? "#e2e8f0" : "#f3f4f6"
                            
                            Text {
                                id: guessText
                                text: model.text
                                font.pixelSize: 13
                                color: "#4a5568"
                                anchors.centerIn: parent
                            }
                            
                            MouseArea {
                                id: guessMouseArea
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: root.guessLikeClicked(model.text)
                            }
                        }
                    }
                }
            }
            
            // ================== 榜单区域 ==================
            TopBar.RankingCard {
                title: "热搜榜"
                Layout.topMargin: 16
                items: [
                    { rank: "1", title: "海屿你", tag: "爆" },
                    { rank: "2", title: "雨爱", tag: "" },
                    { rank: "3", title: "眼泪的汛期", tag: "" },
                    { rank: "4", title: "一半一半", tag: "" },
                    { rank: "5", title: "幻痛药", tag: "" },
                    { rank: "6", title: "巴拉莱卡", tag: "" }
                ]
                onItemClicked: (text) => root.rankingItemClicked(text)
            }
            
            TopBar.RankingCard {
                title: "说唱榜"
                items: [
                    { rank: "1", title: "DD backseat", tag: "" },
                    { rank: "2", title: "故意没接", tag: "" },
                    { rank: "3", title: "十里", tag: "" },
                    { rank: "4", title: "山歌王", tag: "" },
                    { rank: "5", title: "1 On 1", tag: "" },
                    { rank: "6", title: "21爱", tag: "" }
                ]
                onItemClicked: (text) => root.rankingItemClicked(text)
            }
            
            TopBar.RankingCard {
                title: "古风榜"
                items: [
                    { rank: "1", title: "我本将心向明月", tag: "" },
                    { rank: "2", title: "咏春", tag: "" },
                    { rank: "3", title: "知我", tag: "" },
                    { rank: "4", title: "一程山路", tag: "" },
                    { rank: "5", title: "诀别书", tag: "" },
                    { rank: "6", title: "武家坡2021", tag: "" }
                ]
                onItemClicked: (text) => root.rankingItemClicked(text)
            }
            
            TopBar.RankingCard {
                title: "摇滚榜"
                Layout.bottomMargin: 16
                items: [
                    { rank: "1", title: "夜空中最亮的星", tag: "" },
                    { rank: "2", title: "无法逃脱", tag: "" },
                    { rank: "3", title: "向阳花", tag: "" },
                    { rank: "4", title: "公路之歌", tag: "" },
                    { rank: "5", title: "再见杰克", tag: "" },
                    { rank: "6", title: "山海", tag: "" }
                ]
                onItemClicked: (text) => root.rankingItemClicked(text)
            }
        }
    }
}
