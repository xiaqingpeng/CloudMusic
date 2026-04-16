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
    
    Component.onCompleted: {
        console.log("MyRightTopRect: 使用全局 SearchViewModel")
    }

    Row {
        id: topRow
        anchors.fill: parent
        anchors.leftMargin: 16
        anchors.rightMargin: 16
        spacing: 12
        
        // 返回按钮
        TopBar.IconButton {
            anchors.verticalCenter: parent.verticalCenter
            iconSource: "qrc:/qt/qml/CloudMusic/src/resources/icons/left.svg"
            color: "#3d3d47"
            onClicked: console.log("返回")
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
            
            onVoiceSearchRequested: console.log("语音搜索")
            
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
                    console.log("登录")
                    loginPopup.open()
                } else {
                    console.log("用户中心")
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
            onClicked: console.log("开通VIP")
        }

        // 图标按钮组
        Row {
            spacing: 8
            anchors.verticalCenter: parent.verticalCenter
            
            TopBar.IconButton {
                iconSource: "qrc:/qt/qml/CloudMusic/src/resources/icons/down.svg"
                tooltip: "下载"
                onClicked: console.log("下载")
            }
            
            TopBar.IconButton {
                iconSource: "qrc:/qt/qml/CloudMusic/src/resources/icons/down_s.svg"
                tooltip: "换肤"
                onClicked: console.log("换肤")
            }
            
            TopBar.IconButton {
                iconSource: "qrc:/qt/qml/CloudMusic/src/resources/icons/setting.svg"
                tooltip: "设置"
                onClicked: console.log("设置")
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
            console.log("点击搜索历史：", text)
            SearchViewModel.isSelectingFromPopup = true
            searchBar.text = text
            SearchViewModel.performSearch(text)
            hotSearchPopup.close()
        }
        
        onHistoryLongPressed: (index) => {
            console.log("长按删除搜索历史")
            SearchViewModel.removeSearchHistory(index)
        }
        
        onClearHistoryClicked: {
            console.log("清空搜索历史")
            SearchViewModel.clearSearchHistory()
        }
        
        onGuessLikeClicked: (text) => {
            console.log("点击猜你喜欢：", text)
            SearchViewModel.isSelectingFromPopup = true
            searchBar.text = text
            SearchViewModel.performSearch(text)
            hotSearchPopup.close()
        }
        
        onRankingItemClicked: (text) => {
            SearchViewModel.isSelectingFromPopup = true
            searchBar.text = text
            console.log("选择榜单歌曲:", text)
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
            console.log("选择建议:", keyword, "类型:", type)
            SearchViewModel.performSearch(keyword)
            searchPopup.close()
        }
    }
    
    // 登录弹窗
    TopBar.LoginPopup {
        id: loginPopup
        
        onPhoneLoginClicked: {
            console.log("手机号登录")
            // 模拟登录成功
            SearchViewModel.login("用户123")
            loginPopup.close()
        }
        
        onEmailLoginClicked: {
            console.log("邮箱登录")
        }
        
        onWechatLoginClicked: {
            console.log("微信登录")
        }
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
