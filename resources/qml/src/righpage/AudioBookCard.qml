import QtQuick
import QtQuick.Controls
import "../theme"

Rectangle {
    id: root
    width: 300
    height: 120
    color: "transparent"
    
    property string coverType: "normal"  // "special" 或 "normal"
    property string titleText: "有声书标题"
    property string descText: "精彩简介内容"
    property string scoreText: "9.5分"
    property string playCountText: "123.4万"
    property string tagText: ""

    Row {
        anchors.fill: parent
        spacing: 12

        // 左侧封面
        Rectangle {
            width: 100
            height: 100
            radius: 8
            anchors.verticalCenter: parent.verticalCenter
            
            // 渐变背景
            gradient: Gradient {
                GradientStop { position: 0.0; color: "#c9cdd1" }
                GradientStop { position: 0.5; color: "#f0f2f5" }
                GradientStop { position: 1.0; color: "#c9cdd1" }
            }
            
            // 特殊样式：听过的有声书（L图标）
            Rectangle {
                width: 50
                height: 50
                radius: 25
                color: "#ffffff"
                anchors.centerIn: parent
                visible: root.coverType === "special"
                
                Text {
                    text: "L"
                    font.pixelSize: 24
                    font.bold: true
                    color: "#666666"
                    anchors.centerIn: parent
                }
            }
        }

        // 右侧信息区域
        Column {
            width: parent.width - 112
            height: parent.height
            spacing: 6
            anchors.verticalCenter: parent.verticalCenter

            // 标题行（标题 + 评分）
            Row {
                width: parent.width
                spacing: 8
                
                Text {
                    text: root.titleText
                    font.pixelSize: 14
                    font.bold: true
                    color: "#ffffff"
                    elide: Text.ElideRight
                    width: root.scoreText === "" ? parent.width : parent.width - 60
                }
                
                Text {
                    text: root.scoreText
                    font.pixelSize: 13
                    font.bold: true
                    color: "#999999"
                    visible: root.scoreText !== ""
                }
            }

            // 描述行
            Text {
                text: root.descText
                font.pixelSize: 12
                color: "#999999"
                elide: Text.ElideRight
                width: parent.width
            }

            // 标签 + 播放量行
            Row {
                width: parent.width
                spacing: 8
                
                // 标签
                Rectangle {
                    height: 20
                    width: tagLabel.width + 12
                    radius: 4
                    visible: root.tagText !== ""
                    color: root.tagText === "高分必听" ? "#4a1a1a" : 
                           root.tagText === "新人免费听" ? "#1a2a4a" : "#2d2d37"
                    border.color: root.tagText === "高分必听" ? "#ec4141" : 
                                  root.tagText === "新人免费听" ? "#4169e1" : "#4d4d57"
                    border.width: 1
                    
                    Text {
                        id: tagLabel
                        text: root.tagText
                        font.pixelSize: 10
                        font.bold: true
                        color: root.tagText === "高分必听" ? "#ec4141" : 
                               root.tagText === "新人免费听" ? "#4169e1" : "#999999"
                        anchors.centerIn: parent
                    }
                }
                
                // 播放量
                Row {
                    spacing: 4
                    visible: root.playCountText !== ""
                    anchors.verticalCenter: parent.verticalCenter
                    
                    Text {
                        text: "▶"
                        font.pixelSize: 10
                        color: "#666666"
                    }
                    
                    Text {
                        text: root.playCountText
                        font.pixelSize: 11
                        color: "#666666"
                    }
                }
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onEntered: parent.scale = 1.02
        onExited: parent.scale = 1.0
        onClicked: console.log("点击了有声书：", root.titleText)
    }
    
    Behavior on scale { 
        NumberAnimation { duration: 150; easing.type: Easing.OutCubic } 
    }
}
