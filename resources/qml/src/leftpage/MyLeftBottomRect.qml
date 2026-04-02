import QtQuick
import QtQuick.Controls

Rectangle {
    id: leftBottomRect
    color: "#1a1a21"
    
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
            
            // 精选菜单项
            Rectangle {
                id: menuItem1
                width: parent.width - 24
                height: 48
                radius: 12
                color: "#ec4141"
                
                Row {
                    anchors.fill: parent
                    anchors.leftMargin: 12
                    anchors.rightMargin: 12
                    spacing: 12
                    
                    Text {
                        text: "🎵"
                        font.pixelSize: 18
                        color: "#ffffff"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    
                    Text {
                        text: "精选"
                        font.pixelSize: 14
                        font.bold: true
                        color: "#ffffff"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: console.log("点击了精选")
                }
            }
            
            // 播客菜单项
            Rectangle {
                id: menuItem2
                width: parent.width - 24
                height: 48
                radius: 12
                color: "transparent"
                
                Row {
                    anchors.fill: parent
                    anchors.leftMargin: 12
                    anchors.rightMargin: 12
                    spacing: 12
                    
                    Text {
                        text: "🎙"
                        font.pixelSize: 18
                        color: "#999999"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    
                    Text {
                        text: "播客"
                        font.pixelSize: 14
                        color: "#ffffff"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: console.log("点击了播客")
                }
            }
            
            // 关注菜单项
            Rectangle {
                id: menuItem3
                width: parent.width - 24
                height: 48
                radius: 12
                color: "#2d2d37"
                
                Row {
                    anchors.fill: parent
                    anchors.leftMargin: 12
                    anchors.rightMargin: 12
                    spacing: 12
                    
                    Text {
                        text: "👥"
                        font.pixelSize: 18
                        color: "#999999"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    
                    Text {
                        text: "关注"
                        font.pixelSize: 14
                        color: "#ffffff"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: console.log("点击了关注")
                }
            }
            
            // 分割线1
            Rectangle {
                width: parent.width - 24
                height: 1
                color: "#3d3d47"
                anchors.horizontalCenter: parent.horizontalCenter
            }
            
            // 我喜欢的音乐
            Rectangle {
                id: menuItem4
                width: parent.width - 24
                height: 48
                radius: 12
                color: "transparent"
                
                Row {
                    anchors.fill: parent
                    anchors.leftMargin: 12
                    anchors.rightMargin: 12
                    spacing: 12
                    
                    Text {
                        text: "❤"
                        font.pixelSize: 18
                        color: "#999999"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    
                    Text {
                        text: "我喜欢的音乐"
                        font.pixelSize: 14
                        color: "#ffffff"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    
                    Item {
                        width: parent.width - 180
                        height: 1
                    }
                    
                    Text {
                        text: "〰"
                        font.pixelSize: 16
                        color: "#666666"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: console.log("点击了我喜欢的音乐")
                }
            }
            
            // 最近播放
            Rectangle {
                id: menuItem5
                width: parent.width - 24
                height: 48
                radius: 12
                color: "transparent"
                
                Row {
                    anchors.fill: parent
                    anchors.leftMargin: 12
                    anchors.rightMargin: 12
                    spacing: 12
                    
                    Rectangle {
                        width: 28
                        height: 28
                        radius: 14
                        color: "#ffffff"
                        anchors.verticalCenter: parent.verticalCenter
                        
                        Text {
                            text: "L"
                            font.pixelSize: 14
                            font.bold: true
                            color: "#666666"
                            anchors.centerIn: parent
                        }
                    }
                    
                    Text {
                        text: "最近播放"
                        font.pixelSize: 14
                        color: "#ffffff"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: console.log("点击了最近播放")
                }
            }
            
            // 下载管理
            Rectangle {
                id: menuItem6
                width: parent.width - 24
                height: 48
                radius: 12
                color: "transparent"
                
                Row {
                    anchors.fill: parent
                    anchors.leftMargin: 12
                    anchors.rightMargin: 12
                    spacing: 12
                    
                    Text {
                        text: "↓"
                        font.pixelSize: 18
                        color: "#999999"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                    
                    Text {
                        text: "下载管理"
                        font.pixelSize: 14
                        color: "#ffffff"
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
                
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: console.log("点击了下载管理")
                }
            }
            
            // 分割线2
            Rectangle {
                width: parent.width - 24
                height: 1
                color: "#3d3d47"
                anchors.horizontalCenter: parent.horizontalCenter
            }
            
            // 创建的歌单区域
            Row {
                width: parent.width - 24
                height: 50
                spacing: 8
                anchors.horizontalCenter: parent.horizontalCenter
                
                Text {
                    text: "创建的歌单 0"
                    font.pixelSize: 13
                    color: "#999999"
                    anchors.verticalCenter: parent.verticalCenter
                }
                
                Item {
                    width: parent.width - 140
                    height: 1
                }
                
                // +号按钮
                Rectangle {
                    width: 32
                    height: 32
                    radius: 16
                    color: "#2d2d37"
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
                        onClicked: console.log("创建歌单")
                    }
                }
            }
            
            // 分割线3
            Rectangle {
                width: parent.width - 24
                height: 1
                color: "#3d3d47"
                anchors.horizontalCenter: parent.horizontalCenter
            }
            
            // 收藏的歌单区域
            Row {
                width: parent.width - 24
                height: 50
                spacing: 8
                anchors.horizontalCenter: parent.horizontalCenter
                
                Text {
                    text: "收藏的歌单 0"
                    font.pixelSize: 13
                    color: "#999999"
                    anchors.verticalCenter: parent.verticalCenter
                }
            }
        }
    }
}
