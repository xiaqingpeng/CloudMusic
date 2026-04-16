import QtQuick

// 播放/暂停按钮组件
Rectangle {
    id: playButton
    width: 70
    height: 70
    radius: 35
    color: "#ec4141"
    
    property bool isPlaying: false
    
    signal clicked()
    
    Text {
        text: playButton.isPlaying ? "❚❚" : "▶"
        font.pixelSize: playButton.isPlaying ? 20 : 24
        color: "white"
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: playButton.isPlaying ? 0 : 2
    }
    
    scale: playMouseArea.containsMouse ? 1.05 : 1.0
    
    Behavior on scale {
        NumberAnimation { duration: 150 }
    }
    
    MouseArea {
        id: playMouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: playButton.clicked()
    }
}
