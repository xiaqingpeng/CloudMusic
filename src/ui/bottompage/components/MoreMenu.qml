import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import "../../viewmodels"

Popup {
    id: moreMenu
    width: 240
    height: 500
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    
    // 设置为 Overlay，这样可以在整个窗口上显示
    parent: Overlay.overlay
    
    // 背景
    background: Rectangle {
        color: "#ffffff"
        radius: 8
        
        // 阴影效果
        layer.enabled: true
        layer.effect: MultiEffect {
            shadowEnabled: true
            shadowHorizontalOffset: 0
            shadowVerticalOffset: 4
            shadowBlur: 0.4
            shadowColor: "#30000000"
        }
    }
    
    contentItem: Column {
        width: moreMenu.width
        spacing: 0
        clip: true
        
        Repeater {
            model: MusicPlayerViewModel.moreMenuOptions
            
            delegate: Column {
                width: moreMenu.width
                spacing: 0
                
                MoreMenuItem {
                    width: moreMenu.width
                    icon: model.icon
                    text: model.dynamicText ? 
                          MusicPlayerViewModel.getMenuText(model.menuId) : 
                          model.text
                    showDivider: model.showDivider
                    onClicked: {
                        MusicPlayerViewModel.handleMoreMenuAction(model.menuId)
                        moreMenu.close()
                    }
                }
                
                // 分组间隔
                Item {
                    width: moreMenu.width
                    height: model.isLastInGroup ? 8 : 0
                    visible: model.isLastInGroup
                }
            }
        }
    }
}
