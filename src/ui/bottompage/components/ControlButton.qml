import QtQuick

// 控制按钮组件（音质、加号、歌词等）
Rectangle {
    id: controlButton
    width: implicitWidth
    height: 28
    radius: 6
    color: "transparent"
    border.color: "#999999"
    border.width: 1.5
    
    property string text: ""
    property int fontSize: 12
    property bool bold: false
    property int implicitWidth: 50
    
    signal clicked()
    
    Text {
        text: controlButton.text
        font.pixelSize: controlButton.fontSize
        font.bold: controlButton.bold
        color: "#999999"
        anchors.centerIn: parent
    }
    
    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: controlButton.clicked()
    }
}
