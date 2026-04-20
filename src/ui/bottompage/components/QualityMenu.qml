import QtQuick
import QtQuick.Controls
import QtQuick.Effects

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
        
        // 阴影效果
        layer.enabled: true
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowHorizontalOffset: 0
            shadowVerticalOffset: 8
            shadowBlur: 0.5
            shadowColor: "#30000000"
        }
    }
    
    // 当前选中的音质
    property string currentQuality: "极高"
    
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
        Column {
            width: qualityMenu.width
            spacing: 0
            
            // Hi-Res 高解析度无损
            QualityItem {
                width: qualityMenu.width
                icon: "H"
                iconBgColor: "#fff0f0"
                iconColor: "#ec4141"
                title: "高解析度无损 (Hi-Res)"
                description: "更饱满清晰的高解析度音质，最高192kHz/24bit"
                isSelected: qualityMenu.currentQuality === "Hi-Res"
                onClicked: {
                    qualityMenu.currentQuality = "Hi-Res"
                    qualityMenu.qualitySelected("Hi-Res")
                    qualityMenu.close()
                }
            }
            
            // SQ 无损
            QualityItem {
                width: qualityMenu.width
                icon: "SQ"
                iconBgColor: "#fff5e6"
                iconColor: "#ff9800"
                title: "无损 (SQ)"
                description: "高保真无损音质，最高48kHz/16bit"
                isSelected: qualityMenu.currentQuality === "无损"
                onClicked: {
                    qualityMenu.currentQuality = "无损"
                    qualityMenu.qualitySelected("无损")
                    qualityMenu.close()
                }
            }
            
            // HQ 极高
            QualityItem {
                width: qualityMenu.width
                icon: "HQ"
                iconBgColor: "#f3f0ff"
                iconColor: "#7c4dff"
                title: "极高 (HQ)"
                description: "近 CD 音质的细节体验，最高320kbps"
                isSelected: qualityMenu.currentQuality === "极高"
                onClicked: {
                    qualityMenu.currentQuality = "极高"
                    qualityMenu.qualitySelected("极高")
                    qualityMenu.close()
                }
            }
            
            // 标准
            QualityItem {
                width: qualityMenu.width
                icon: "标"
                iconBgColor: "#f5f5f5"
                iconColor: "#9e9e9e"
                title: "标准"
                description: "128kbps"
                isSelected: qualityMenu.currentQuality === "标准"
                showDivider: false
                onClicked: {
                    qualityMenu.currentQuality = "标准"
                    qualityMenu.qualitySelected("标准")
                    qualityMenu.close()
                }
            }
        }
    }
}
