import QtQuick

Rectangle {
    id: textButton
    height: 32
    radius: 16
    color: backgroundColor
    
    property string text: ""
    property color textColor: "#ffffff"
    property color backgroundColor: "#3d3d47"
    property color hoverColor: "#4d4d57"
    property bool bold: false
    
    signal clicked()
    
    implicitWidth: buttonText.width + 32
    
    Text {
        id: buttonText
        text: textButton.text
        color: textButton.textColor
        font.pixelSize: 13
        font.bold: textButton.bold
        anchors.centerIn: parent
    }
    
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor
        onClicked: textButton.clicked()
    }
    
    states: [
        State {
            name: "hovered"
            when: mouseArea.containsMouse
            PropertyChanges {
                target: textButton
                color: hoverColor
            }
        }
    ]
    
    transitions: Transition {
        ColorAnimation { duration: 150 }
    }
}
