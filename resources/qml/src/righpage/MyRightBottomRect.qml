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

        Text {
            text: "官方歌单"
            font.bold: true
            font.pixelSize: 18
            color: "#ffffff" // 使用具体颜色值代替theme.text
        }

        GridView {
            Layout.fillWidth: true
            height: 280
            cellWidth: 200
            cellHeight: 260
            // cellSpacing: Qt.size(20, 20)
            model: 4
            delegate: SongListCard {}
        }

        Text {
            text: "有声书"
            font.bold: true
            font.pixelSize: 18
            color: "#ffffff" // 使用具体颜色值代替theme.text
        }

        GridView {
            Layout.fillWidth: true
            height: 260
            cellWidth: 300
            cellHeight: 120
            // cellSpacing: Qt.size(20, 20)
            model: 3
            delegate: AudioBookCard {}
        }
    }
}
