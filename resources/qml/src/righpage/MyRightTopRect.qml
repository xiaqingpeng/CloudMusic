import QtQuick
import QtQuick.Controls
import "./components/topbar"

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
        IconButton {
            anchors.verticalCenter: parent.verticalCenter
            iconSource: "qrc:/CloudMusic/resources/qrc/icon/left.svg"
            color: "#3d3d47"
            onClicked: console.log("返回")
        }

        // 搜索框
        SearchBar {
            width: parent.width - 450
            anchors.verticalCenter: parent.verticalCenter
            onSearchRequested: (text) => console.log("搜索:", text)
            onVoiceSearchRequested: console.log("语音搜索")
        }
        
        // 弹簧占位
        Item {
            width: 20
            height: 1
        }

        // 未登录按钮
        TextButton {
            anchors.verticalCenter: parent.verticalCenter
            text: "未登录"
            onClicked: console.log("登录")
        }
        
        // VIP按钮
        TextButton {
            anchors.verticalCenter: parent.verticalCenter
            text: "VIP"
            backgroundColor: "#ec4141"
            hoverColor: "#dc3030"
            bold: true
            onClicked: console.log("开通VIP")
        }

        // 图标按钮组
        Row {
            spacing: 8
            anchors.verticalCenter: parent.verticalCenter
            
            IconButton {
                iconSource: "qrc:/CloudMusic/resources/qrc/icon/down.svg"
                tooltip: "下载"
                onClicked: console.log("下载")
            }
            
            IconButton {
                iconSource: "qrc:/CloudMusic/resources/qrc/icon/down_s.svg"
                tooltip: "换肤"
                onClicked: console.log("换肤")
            }
            
            IconButton {
                iconSource: "qrc:/CloudMusic/resources/qrc/icon/setting.svg"
                tooltip: "设置"
                onClicked: console.log("设置")
            }
        }
        
        // 系统控制按钮
        WindowControl {
            anchors.verticalCenter: parent.verticalCenter
        }
    }
}
