import QtQuick
import QtQuick.Window
import QtQuick.Layouts

import QtQuick.Controls

Rectangle {
    id: rightTopRect
    height: 60
    color: "#2d2d37" // 建议换个深色，因为文字是白色的，否则看不见字

    RowLayout {
        anchors.fill: parent
        spacing: 16
        anchors.margins: 16

        // 自定义搜索框，避免TextField的背景样式问题
        Rectangle {
            Layout.fillWidth: true
            height: 36
            radius: 9
            color: "#f0f0f0"
            
            TextField {
                anchors.fill: parent
                anchors.margins: 8
                height: 36
                placeholderText: "搜索歌曲、歌手、专辑"
                // 去掉默认背景
                background: null
            }
        }

        Text {
            text: "未登录"
            color: "#f0f0f0"
        }
        Text {
            text: "VIP"
            color: "#f0f0f0"
        }

        // 系统控制图标
        MyControl {
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
        }

    }
}
