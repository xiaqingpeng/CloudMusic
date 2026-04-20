import QtQuick
import QtQuick.Controls
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
        border.width: 1
        border.color: "#e0e0e0"
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
