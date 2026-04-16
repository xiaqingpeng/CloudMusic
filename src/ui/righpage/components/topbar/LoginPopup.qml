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
    
    // 二维码数据（可以从外部设置）
    property string qrCodeData: "https://example.com/login?token=" + Date.now()
    
    signal refreshQrCode()
    signal phoneLoginClicked()
    signal emailLoginClicked()
    signal wechatLoginClicked()
    
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
            
            // 二维码占位符
            // TODO: 集成 QZXing 库后可以生成真实二维码
            // 参考: https://github.com/ftylitak/qzxing
            Column {
                anchors.centerIn: parent
                spacing: 12
                
                Text {
                    text: "📱"
                    font.pixelSize: 80
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                
                Text {
                    text: "二维码占位符"
                    font.pixelSize: 14
                    color: "#666666"
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                
                Rectangle {
                    width: 160
                    height: 32
                    radius: 4
                    color: "#f0f0f0"
                    anchors.horizontalCenter: parent.horizontalCenter
                    
                    Text {
                        text: "需要集成 QZXing 库"
                        font.pixelSize: 11
                        color: "#999999"
                        anchors.centerIn: parent
                    }
                }
            }
            
            // 刷新按钮（右上角）
            Rectangle {
                width: 32
                height: 32
                radius: 16
                color: refreshMouseArea.containsMouse ? "#f5f5f5" : "#ffffff"
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
                    id: refreshMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        console.log("刷新二维码")
                        // 更新二维码数据（添加时间戳使其变化）
                        root.qrCodeData = "https://example.com/login?token=" + Date.now()
                        root.refreshQrCode()
                    }
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
                    { icon: "📱", name: "手机号登录", signal: "phone" },
                    { icon: "📧", name: "邮箱登录", signal: "email" },
                    { icon: "💬", name: "微信登录", signal: "wechat" }
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
                        onClicked: {
                            console.log(modelData.name)
                            if (modelData.signal === "phone") {
                                root.phoneLoginClicked()
                            } else if (modelData.signal === "email") {
                                root.emailLoginClicked()
                            } else if (modelData.signal === "wechat") {
                                root.wechatLoginClicked()
                            }
                        }
                    }
                }
            }
        }
    }
}
