import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import CloudMusic
import "./components/topbar" as TopBar

Rectangle {
    id: rightTopRect
    height: 60
    color: "#2d2d37"
    
    // ========== 使用全局单例 ViewModel ==========
    // SearchViewModel 现在是全局单例，可以在任何地方访问
    // 通过 SearchViewModel.xxx 直接使用

    Row {
        id: topRow
        anchors.fill: parent
        anchors.leftMargin: 16
        anchors.rightMargin: 16
        spacing: 12
        
        // 返回按钮
        TopBar.IconButton {
            anchors.verticalCenter: parent.verticalCenter
            iconSource: Qt.platform.os === "osx"
                ? "qrc:/qt/qml/CloudMusic/src/resources/icons/left.svg"
                : "qrc:/CloudMusic/src/resources/icons/left.svg"
            color: "#3d3d47"
        }

        // 搜索框
        TopBar.SearchBar {
            id: searchBar
            width: parent.width - 450
            anchors.verticalCenter: parent.verticalCenter
            
            onSearchRequested: (text) => {
                SearchViewModel.performSearch(text)
                searchPopup.close()
                hotSearchPopup.close()
            }
            
            onVoiceSearchRequested: {}
            
            onInputTextChanged: (text) => {
                if (SearchViewModel.isSelectingFromPopup) {
                    SearchViewModel.isSelectingFromPopup = false
                    return
                }
                
                if (text.length > 0) {
                    SearchViewModel.fetchSuggestions(text)
                    hotSearchPopup.close()
                    searchPopup.open()
                } else {
                    searchPopup.close()
                    if (searchBar.hasFocus) {
                        hotSearchPopup.open()
                    }
                }
            }
            
            onInputFocusChanged: (hasFocus) => {
                if (hasFocus && searchBar.text.length === 0) {
                    hotSearchPopup.open()
                    searchPopup.close()
                } else if (!hasFocus) {
                    closeTimer.start()
                }
            }
        }
        
        // 弹簧占位
        Item {
            width: 20
            height: 1
        }

        // 未登录按钮
        TopBar.TextButton {
            anchors.verticalCenter: parent.verticalCenter
            text: SearchViewModel.isLoggedIn ? SearchViewModel.userName : "未登录"
            onClicked: {
                if (!SearchViewModel.isLoggedIn) {
                    loginPopup.open()
                }
            }
        }
        
        // VIP按钮
        TopBar.TextButton {
            anchors.verticalCenter: parent.verticalCenter
            text: "VIP"
            backgroundColor: "#ec4141"
            hoverColor: "#dc3030"
            bold: true
        }

        // 图标按钮组
        Row {
            spacing: 8
            anchors.verticalCenter: parent.verticalCenter
            
            TopBar.IconButton {
                iconSource: Qt.platform.os === "osx"
                    ? "qrc:/qt/qml/CloudMusic/src/resources/icons/down.svg"
                    : "qrc:/CloudMusic/src/resources/icons/down.svg"
                tooltip: "下载"
            }
            
            TopBar.IconButton {
                iconSource: Qt.platform.os === "osx"
                    ? "qrc:/qt/qml/CloudMusic/src/resources/icons/down_s.svg"
                    : "qrc:/CloudMusic/src/resources/icons/down_s.svg"
                tooltip: "换肤"
            }
            
            TopBar.IconButton {
                iconSource: Qt.platform.os === "osx"
                    ? "qrc:/qt/qml/CloudMusic/src/resources/icons/setting.svg"
                    : "qrc:/CloudMusic/src/resources/icons/setting.svg"
                tooltip: "设置"
            }
        }
        
        // 系统控制按钮
        TopBar.WindowControl {
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    
    // 热搜弹窗
    TopBar.HotSearchPopup {
        id: hotSearchPopup
        parent: rightTopRect
        x: topRow.spacing
        y: rightTopRect.height
        width: rightTopRect.width - topRow.spacing - 16
        height: rightBottomRect.height
        
        searchHistoryModel: SearchViewModel.searchHistoryModel
        guessLikeModel: SearchViewModel.guessLikeModel
        
        onHistoryClicked: (text) => {
            SearchViewModel.isSelectingFromPopup = true
            searchBar.text = text
            SearchViewModel.performSearch(text)
            hotSearchPopup.close()
        }
        
        onHistoryLongPressed: (index) => {
            SearchViewModel.removeSearchHistory(index)
        }
        
        onClearHistoryClicked: {
            SearchViewModel.clearSearchHistory()
        }
        
        onGuessLikeClicked: (text) => {
            SearchViewModel.isSelectingFromPopup = true
            searchBar.text = text
            SearchViewModel.performSearch(text)
            hotSearchPopup.close()
        }
        
        onRankingItemClicked: (text) => {
            SearchViewModel.isSelectingFromPopup = true
            searchBar.text = text
            SearchViewModel.performSearch(text)
            hotSearchPopup.close()
        }
    }
    
    // 搜索建议弹窗
    TopBar.SearchSuggestionPopup {
        id: searchPopup
        parent: rightTopRect
        x: topRow.spacing
        y: rightTopRect.height
        width: rightTopRect.width - topRow.spacing - 16
        height: rightBottomRect.height
        
        model: SearchViewModel.suggestionsModel
        searchText: searchBar.text
        
        onSuggestionSelected: (keyword, type) => {
            SearchViewModel.isSelectingFromPopup = true
            searchBar.text = keyword
            SearchViewModel.performSearch(keyword)
            searchPopup.close()
        }
    }
    
    // 登录弹窗
    TopBar.LoginPopup {
        id: loginPopup
        
        onPhoneLoginClicked: {
            // 模拟登录成功
            SearchViewModel.login("用户123")
            loginPopup.close()
        }
        
        onEmailLoginClicked: {}
        
        onWechatLoginClicked: {}
    }
    
    // 延迟关闭定时器
    Timer {
        id: closeTimer
        interval: 200
        onTriggered: {
            searchPopup.close()
            hotSearchPopup.close()
        }
    }
}
