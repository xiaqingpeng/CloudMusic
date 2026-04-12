import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Rectangle {
    id: root
    
    property string title: ""
    property var items: []
    
    signal itemClicked(string text)
    
    Layout.fillWidth: true
    Layout.leftMargin: 16
    Layout.rightMargin: 16
    implicitHeight: column.height + 32
    color: "#fafafa"
    radius: 8
    
    ColumnLayout {
        id: column
        width: parent.width
        spacing: 12
        anchors.top: parent.top
        anchors.topMargin: 16
        
        Text {
            text: root.title
            font.pixelSize: 16
            font.bold: true
            color: "#333333"
            Layout.leftMargin: 16
        }
        
        GridLayout {
            Layout.fillWidth: true
            Layout.leftMargin: 16
            Layout.rightMargin: 16
            Layout.bottomMargin: 16
            columns: 3
            rowSpacing: 12
            columnSpacing: 12
            
            Repeater {
                model: root.items
                
                Rectangle {
                    Layout.fillWidth: true
                    implicitHeight: 40
                    color: mouseArea.containsMouse ? "#ffffff" : "transparent"
                    radius: 6
                    
                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 8
                        anchors.rightMargin: 8
                        spacing: 6
                        
                        Text {
                            text: modelData.rank
                            font.pixelSize: 14
                            font.bold: modelData.rank <= "3"
                            color: modelData.rank <= "3" ? "#ec4141" : "#999999"
                            Layout.preferredWidth: 20
                        }
                        
                        Text {
                            text: modelData.title
                            font.pixelSize: 13
                            color: "#333333"
                            elide: Text.ElideRight
                            Layout.fillWidth: true
                        }
                        
                        Rectangle {
                            visible: modelData.tag !== ""
                            implicitWidth: 20
                            implicitHeight: 16
                            radius: 3
                            color: modelData.tag === "爆" ? "#ec4141" : "#00b42a"
                            
                            Text {
                                text: modelData.tag
                                font.pixelSize: 10
                                font.bold: true
                                color: "#ffffff"
                                anchors.centerIn: parent
                            }
                        }
                    }
                    
                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: root.itemClicked(modelData.title)
                    }
                }
            }
        }
    }
}
