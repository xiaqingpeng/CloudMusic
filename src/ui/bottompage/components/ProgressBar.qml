import QtQuick

// 进度条组件
Rectangle {
    id: progressBarBg
    width: parent.width
    height: 3
    color: "#1a1a1a"
    
    property real progress: 0.0
    
    signal seekRequested(real position)
    
    Rectangle {
        id: progressBarFill
        width: parent.width * progressBarBg.progress
        height: parent.height
        color: "#ec4141"
    }
    
    MouseArea {
        anchors.fill: parent
        onClicked: (mouse) => {
            progressBarBg.seekRequested(mouse.x / parent.width)
        }
    }
}
