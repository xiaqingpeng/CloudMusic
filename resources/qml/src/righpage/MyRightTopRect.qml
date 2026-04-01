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


        Image {
            Layout.preferredWidth: 24
            Layout.preferredHeight: 24
            Layout.alignment: Qt.AlignVCenter
            source: "qrc:/CloudMusic/resources/qrc/icon/left.svg"
            // fillMode: Image.PreserveAspectFit

            onStatusChanged: {
                if (status === Image.Error) {
                    console.log("Failed to load image:", source)
                }
            }
        }

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

        Image {
            Layout.preferredWidth: 24
            Layout.preferredHeight: 24
            Layout.alignment: Qt.AlignVCenter
            source: "qrc:/CloudMusic/resources/qrc/icon/mic.svg"


            onStatusChanged: {
                if (status === Image.Error) {
                    console.log("Failed to load image:", source)
                }
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

        Image {
            Layout.preferredWidth: 24
            Layout.preferredHeight: 24
            Layout.alignment: Qt.AlignVCenter
            source: "qrc:/CloudMusic/resources/qrc/icon/down.svg"


            onStatusChanged: {
                if (status === Image.Error) {
                    console.log("Failed to load image:", source)
                }
            }
        }

        Image {
            Layout.preferredWidth: 24
            Layout.preferredHeight: 24
            Layout.alignment: Qt.AlignVCenter
            source: "qrc:/CloudMusic/resources/qrc/icon/down_s.svg"


            onStatusChanged: {
                if (status === Image.Error) {
                    console.log("Failed to load image:", source)
                }
            }
        }

        Image {
            Layout.preferredWidth: 24
            Layout.preferredHeight: 24
            Layout.alignment: Qt.AlignVCenter
            source: "qrc:/CloudMusic/resources/qrc/icon/setting.svg"


            onStatusChanged: {
                if (status === Image.Error) {
                    console.log("Failed to load image:", source)
                }
            }
        }
        // 系统控制图标
        MyControl {
            Layout.alignment: Qt.AlignVCenter
        }

    }
}
