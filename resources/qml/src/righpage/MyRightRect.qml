import QtQuick

Rectangle {
    id: rightRect
    color: "#13131a"
    
    // 顶部栏
    MyRightTopRect {
        id: rightTopRect
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        z: 10
    }
    
    // 内容区域
    MyRightBottomRect {
        id: rightBottomRect
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: rightTopRect.bottom
    }
}
