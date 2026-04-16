import QtQuick

// 操作按钮组件（点赞、评论等）
Column {
    spacing: 4
    
    property string icon: "♡"
    property string count: ""
    property color iconColor: "#999999"
    property int iconSize: 24
    
    signal clicked()
    
    Text {
        text: icon
        font.pixelSize: iconSize
        color: iconColor
        anchors.horizontalCenter: parent.horizontalCenter
        
        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: parent.parent.clicked()
        }
    }
    
    Text {
        text: count
        font.pixelSize: 11
        color: "#999999"
        anchors.horizontalCenter: parent.horizontalCenter
        visible: count !== ""
    }
}
