import QtQuick
import QtQuick.Window

Rectangle {
    id: rightTopRect
    height: 60
    color: "#2d2d37" // 建议换个深色，因为文字是白色的，否则看不见字
    
    Text {
        anchors.centerIn: parent
        color: "#ffffff"
        text: "rightTopRect区域"
        font.pointSize: 18
    }
}
