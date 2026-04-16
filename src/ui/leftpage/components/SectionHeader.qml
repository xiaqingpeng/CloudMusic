import QtQuick

// 分组标题组件
Row {
    id: sectionHeader
    height: 50
    spacing: 8
    
    property string title: ""
    property bool showAddButton: false
    
    signal addClicked()
    
    Text {
        text: sectionHeader.title
        font.pixelSize: 13
        color: "#999999"
        anchors.verticalCenter: parent.verticalCenter
    }
    
    Item {
        width: parent.width - 140
        height: 1
        visible: showAddButton
    }
    
    // +号按钮
    Rectangle {
        width: 32
        height: 32
        radius: 16
        color: "#2d2d37"
        anchors.verticalCenter: parent.verticalCenter
        visible: showAddButton
        
        Text {
            text: "+"
            font.pixelSize: 20
            color: "#999999"
            anchors.centerIn: parent
        }
        
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: sectionHeader.addClicked()
        }
    }
}
