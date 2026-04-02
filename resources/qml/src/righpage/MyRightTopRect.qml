import QtQuick
import QtQuick.Controls

Rectangle {
    id: rightTopRect
    height: 60
    color: "#2d2d37"

    Row {
        anchors.fill: parent
        anchors.leftMargin: 16
        anchors.rightMargin: 16
        spacing: 12
        
        // 返回按钮
        Rectangle {
            width: 32
            height: 32
            radius: 16
            color: "#3d3d47"
            anchors.verticalCenter: parent.verticalCenter
            
            Image {
                width: 16
                height: 16
                anchors.centerIn: parent
                source: "qrc:/CloudMusic/resources/qrc/icon/left.svg"
                fillMode: Image.PreserveAspectFit
            }
            
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: console.log("返回")
            }
        }

        // 搜索框
        Rectangle {
            width: parent.width - 450
            height: 36
            radius: 18
            color: "#f0f0f0"
            anchors.verticalCenter: parent.verticalCenter
            
            Row {
                anchors.fill: parent
                anchors.leftMargin: 16
                anchors.rightMargin: 16
                spacing: 8
                
                TextField {
                    width: parent.width - 40
                    height: parent.height
                    placeholderText: "搜索歌曲、歌手、专辑"
                    font.pixelSize: 13
                    color: "#333333"
                    background: null
                    verticalAlignment: TextInput.AlignVCenter
                    
                    placeholderTextColor: "#999999"
                }
                
                Image {
                    width: 20
                    height: 20
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/CloudMusic/resources/qrc/icon/mic.svg"
                    fillMode: Image.PreserveAspectFit
                    
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: console.log("语音搜索")
                    }
                }
            }
        }
        
        // 弹簧占位
        Item {
            width: 20
            height: 1
        }

        // 未登录按钮
        Rectangle {
            width: 70
            height: 32
            radius: 16
            color: "#3d3d47"
            anchors.verticalCenter: parent.verticalCenter
            
            Text {
                text: "未登录"
                color: "#ffffff"
                font.pixelSize: 13
                anchors.centerIn: parent
            }
            
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: console.log("登录")
            }
        }
        
        // VIP按钮
        Rectangle {
            width: 50
            height: 32
            radius: 16
            color: "#ec4141"
            anchors.verticalCenter: parent.verticalCenter
            
            Text {
                text: "VIP"
                color: "#ffffff"
                font.pixelSize: 13
                font.bold: true
                anchors.centerIn: parent
            }
            
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: console.log("开通VIP")
            }
        }

        // 图标按钮组
        Row {
            spacing: 8
            anchors.verticalCenter: parent.verticalCenter
            
            // 下载按钮
            Rectangle {
                width: 32
                height: 32
                radius: 16
                color: "transparent"
                
                Image {
                    width: 20
                    height: 20
                    anchors.centerIn: parent
                    source: "qrc:/CloudMusic/resources/qrc/icon/down.svg"
                    fillMode: Image.PreserveAspectFit
                }
                
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: console.log("下载")
                }
            }
            
            // 皮肤按钮
            Rectangle {
                width: 32
                height: 32
                radius: 16
                color: "transparent"
                
                Image {
                    width: 20
                    height: 20
                    anchors.centerIn: parent
                    source: "qrc:/CloudMusic/resources/qrc/icon/down_s.svg"
                    fillMode: Image.PreserveAspectFit
                }
                
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: console.log("换肤")
                }
            }
            
            // 设置按钮
            Rectangle {
                width: 32
                height: 32
                radius: 16
                color: "transparent"
                
                Image {
                    width: 20
                    height: 20
                    anchors.centerIn: parent
                    source: "qrc:/CloudMusic/resources/qrc/icon/setting.svg"
                    fillMode: Image.PreserveAspectFit
                }
                
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: console.log("设置")
                }
            }
        }
        
        // 系统控制按钮
        MyControl {
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
