import QtQuick
import QtQuick.Window

Rectangle {
    id: rightTopRect
    height: 60
    color: "#2d2d37" // 建议换个深色，因为文字是白色的，否则看不见字

    // 系统控制图标
    MyControl {
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.verticalCenter: parent.verticalCenter
    }
}
