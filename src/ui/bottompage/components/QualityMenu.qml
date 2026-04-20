import QtQuick
import QtQuick.Controls
import "../../viewmodels"

Popup {
    id: qualityMenu
    width: 360
    height: 420
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    
    // 设置为 Overlay，这样可以在整个窗口上显示
    parent: Overlay.overlay
    
    // 背景
    background: Rectangle {
        color: "#ffffff"
        radius: 16
        border.width: 1
        border.color: "#e0e0e0"
    }
    
    signal qualitySelected(string quality)
    
    contentItem: Column {
        width: qualityMenu.width
        spacing: 0
        clip: true  // 裁剪超出部分
        
        // 标题栏
        Rectangle {
            width: qualityMenu.width
            height: 64
            color: "transparent"
            
            Item {
                anchors.fill: parent
                anchors.leftMargin: 24
                anchors.rightMargin: 24
                
                Text {
                    id: titleText
                    text: "当前歌曲音质"
                    font.pixelSize: 17
                    font.weight: Font.DemiBold
                    color: "#18191c"
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                }
                
                Text {
                    text: "了解音质"
                    font.pixelSize: 14
                    color: "#507daf"
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    
                    MouseArea {
                        anchors.fill: parent
                        anchors.margins: -8
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            console.log("了解音质")
                        }
                    }
                }
            }
        }
        
        // 音质选项列表
        Repeater {
            model: MusicPlayerViewModel.qualityOptions
            
            QualityItem {
                width: qualityMenu.width
                icon: model.icon
                iconBgColor: model.iconBgColor
                iconColor: model.iconColor
                title: model.title
                description: model.description
                isSelected: MusicPlayerViewModel.currentQuality === model.displayName
                showDivider: index < MusicPlayerViewModel.qualityOptions.count - 1
                onClicked: {
                    MusicPlayerViewModel.setQuality(model.displayName)
                    qualityMenu.qualitySelected(model.displayName)
                    qualityMenu.close()
                }
            }
        }
    }
}
