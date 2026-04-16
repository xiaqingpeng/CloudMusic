import QtQuick

Rectangle {
    id: iconButton
    width: 32
    height: 32
    radius: 16
    color: mouseArea.containsMouse ? "#3d3d47" : "transparent"
    
    property string iconSource: ""
    property string tooltip: ""
    
    signal clicked()
    
    Image {
        width: 20
        height: 20
        anchors.centerIn: parent
        source: iconButton.iconSource
        fillMode: Image.PreserveAspectFit
    }
    
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: iconButton.clicked()
    }
    
    Behavior on color {
        ColorAnimation { duration: 150 }
    }
}
