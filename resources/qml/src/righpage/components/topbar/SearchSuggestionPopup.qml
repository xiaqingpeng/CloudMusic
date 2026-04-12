import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

Popup {
    id: root
    
    property alias model: suggestionList.model
    property string searchText: ""
    
    signal suggestionSelected(string keyword, string type)
    
    padding: 0
    closePolicy: Popup.NoAutoClose
    
    background: Rectangle {
        color: "#ffffff"
        radius: 12
        border.color: "#e0e0e0"
        border.width: 1
    }
    
    ListView {
        id: suggestionList
        anchors.fill: parent
        clip: true
        spacing: 0
        
        delegate: Rectangle {
            width: suggestionList.width
            height: 50
            color: mouseArea.containsMouse ? "#f3f4f6" : "transparent"
            
            RowLayout {
                anchors.fill: parent
                anchors.leftMargin: 16
                anchors.rightMargin: 16
                spacing: 12
                
                // 放大镜图标
                Rectangle {
                    width: 20
                    height: 20
                    color: "transparent"
                    Layout.preferredWidth: 20
                    
                    Text {
                        text: "🔍"
                        font.pixelSize: 16
                        anchors.centerIn: parent
                    }
                }
                
                // 搜索建议文本（关键词高亮）
                Text {
                    text: {
                        var keyword = model.keyword
                        var searchText = root.searchText
                        if (searchText === "" || keyword.indexOf(searchText) === -1) {
                            return '<font color="#94979e">' + keyword + '</font>'
                        }
                        var index = keyword.indexOf(searchText)
                        return '<font color="#94979e">' + keyword.substring(0, index) +
                            '</font><font color="#4a5568">' + searchText +
                            '</font><font color="#94979e">' + keyword.substring(index + searchText.length) + '</font>'
                    }
                    font.pixelSize: 14
                    textFormat: Text.RichText
                    Layout.fillWidth: true
                }
                
                // 类型标签
                Rectangle {
                    width: typeLabel.width + 12
                    height: 20
                    radius: 4
                    color: model.type === "hot" ? "#fff5f5" : 
                           model.type === "artist" ? "#f0f9ff" : 
                           model.type === "song" ? "#f0fdf4" : "#fef3f2"
                    visible: model.type !== "song"
                    Layout.preferredWidth: typeLabel.width + 12
                    
                    Text {
                        id: typeLabel
                        text: model.type === "hot" ? "热门" : 
                              model.type === "artist" ? "歌手" : 
                              model.type === "album" ? "专辑" : ""
                        font.pixelSize: 10
                        color: model.type === "hot" ? "#ef4444" : 
                               model.type === "artist" ? "#3b82f6" : "#f97316"
                        anchors.centerIn: parent
                    }
                }
            }
            
            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: root.suggestionSelected(model.keyword, model.type)
            }
            
            // 分割线
            Rectangle {
                width: parent.width - 32
                height: 1
                color: "#f0f0f0"
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                visible: index < suggestionList.count - 1
            }
        }
    }
}
