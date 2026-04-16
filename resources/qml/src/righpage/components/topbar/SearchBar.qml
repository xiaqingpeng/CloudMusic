import QtQuick
import QtQuick.Controls

Rectangle {
    id: searchBar
    height: 36
    radius: 18
    color: "#f0f0f0"
    
    signal searchRequested(string text)
    signal voiceSearchRequested()
    signal suggestionSelected(string text)
    signal inputTextChanged(string text)
    signal inputFocusChanged(bool hasFocus)
    
    property alias text: searchField.text
    property bool hasFocus: searchField.activeFocus
    
    Row {
        anchors.fill: parent
        anchors.leftMargin: 16
        anchors.rightMargin: 16
        spacing: 8
        
        TextField {
            id: searchField
            width: parent.width - 40
            height: parent.height
            placeholderText: "搜索歌曲、歌手、专辑"
            font.pixelSize: 13
            color: "#333333"
            background: null
            verticalAlignment: TextInput.AlignVCenter
            placeholderTextColor: "#999999"
            
            onAccepted: {
                searchBar.searchRequested(text)
            }
            
            onTextChanged: {
                searchBar.inputTextChanged(text)
            }
            
            onFocusChanged: {
                searchBar.inputFocusChanged(focus)
            }
        }
        
        Image {
            width: 20
            height: 20
            anchors.verticalCenter: parent.verticalCenter
            source: "qrc:/qt/qml/CloudMusic/resources/qrc/icon/mic.svg"
            fillMode: Image.PreserveAspectFit
            
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: searchBar.voiceSearchRequested()
            }
        }
    }
}
