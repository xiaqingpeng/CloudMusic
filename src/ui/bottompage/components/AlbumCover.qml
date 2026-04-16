import QtQuick

// 专辑封面组件
Rectangle {
    id: coverContainer
    width: 70
    height: 70
    radius: 35
    color: "#3d3d47"
    clip: true
    
    property bool isPlaying: false
    property string qualityLabel: "极高"
    
    Rectangle {
        anchors.centerIn: parent
        width: 60
        height: 60
        radius: 30
        color: "#ec4141"
        
        Text {
            anchors.centerIn: parent
            text: "♪"
            font.pixelSize: 30
            color: "white"
        }
        
        // 旋转动画
        RotationAnimation on rotation {
            from: 0
            to: 360
            duration: 20000
            loops: Animation.Infinite
            running: coverContainer.isPlaying
        }
    }
    
    // 音质标签
    Rectangle {
        width: 35
        height: 18
        color: "white"
        radius: 3
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 3
        
        Text {
            text: coverContainer.qualityLabel
            font.pixelSize: 10
            font.bold: true
            color: "#333333"
            anchors.centerIn: parent
        }
    }
}
