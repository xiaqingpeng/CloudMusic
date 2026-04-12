import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Popup {
    id: root
    parent: Overlay.overlay
    x: (parent.width - width) / 2
    y: (parent.height - height) / 2
    width: 400
    height: 560
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    
    background: Rectangle {
        color: "#ffffff"
        radius: 16
        border.color: "#e0e0e0"
        border.width: 1
    }
    
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 24
        spacing: 20
        
        // 标题
        Text {
            text: "扫码登录"
            font.pixelSize: 24
            font.bold: true
            color: "#333333"
            Layout.alignment: Qt.AlignHCenter
        }
        
        // 二维码区域
        Rectangle {
            Layout.preferredWidth: 240
            Layout.preferredHeight: 240
            Layout.alignment: Qt.AlignHCenter
            color: "#f5f5f5"
            radius: 8
            border.color: "#e0e0e0"
            border.width: 1
            
            // 模拟二维码（使用网格图案）
            Grid {
                anchors.centerIn: parent
                columns: 8
                rows: 8
                spacing: 2
                
                Repeater {
                    model: 64
                    Rectangle {
                        width: 24
                        height: 24
                        color: {
                            var pattern = [
                                1,1,1,1,1,1,1,0,
                                1,0,0,0,0,0,1,0,
                                1,0,1,1,1,0,1,1,
                                1,0,1,0,1,0,1,0,
                                1,0,1,1,1,0,1,1,
                                1,0,0,0,0,0,1,0,
                                1,1,1,1,1,1,1,0,
                                0,0,1,0,1,0,0,1
                            ]
                            return pattern[index] === 1 ? "#333333" : "#ffffff"
                        }
                        radius: 2
                    }
                }
            }
            
            // 刷新按钮（右上角）
            Rectangle {
                width: 32
                height: 32
                radius: 16
                color: "#ffffff"
                border.color: "#e0e0e0"
                border.width: 1
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.margins: 8
                
                Text {
                    text: "🔄"
                    font.pixelSize: 16
                    anchors.centerIn: parent
                }
                
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: console.log("刷新二维码")
                }
            }
        }
        
        // 提示文字
        Column {
            Layout.alignment: Qt.AlignHCenter
            spacing: 8
            
            Text {
                text: "使用手机扫描二维码登录"
                font.pixelSize: 16
                color: "#333333"
                anchors.horizontalCenter: parent.horizontalCenter
            }
            
            Text {
                text: "打开手机 App，扫描上方二维码"
                font.pixelSize: 13
                color: "#999999"
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
        
        Item { Layout.fillHeight: true }
        
        // 其他登录方式
        RowLayout {
            Layout.fillWidth: true
            spacing: 16
            
            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: "#e0e0e0"
            }
            
            Text {
                text: "其他登录方式"
                font.pixelSize: 12
                color: "#999999"
            }
            
            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: "#e0e0e0"
            }
        }
        
        // 登录方式按钮
        Row {
            Layout.alignment: Qt.AlignHCenter
            spacing: 12
            
            Repeater {
                model: [
                    { icon: "📱", name: "手机号登录" },
                    { icon: "📧", name: "邮箱登录" },
                    { icon: "💬", name: "微信登录" }
                ]
                
                Rectangle {
                    width: 44
                    height: 44
                    radius: 22
                    color: mouseArea.containsMouse ? "#f5f5f5" : "#ffffff"
                    border.color: "#e0e0e0"
                    border.width: 1
                    
                    Text {
                        text: modelData.icon
                        font.pixelSize: 22
                        anchors.centerIn: parent
                    }
                    
                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: console.log(modelData.name)
                    }
                }
            }
        }
    }
}
