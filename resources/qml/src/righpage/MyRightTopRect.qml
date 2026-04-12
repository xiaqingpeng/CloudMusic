import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "./components/topbar" as TopBar

Rectangle {
    id: rightTopRect
    height: 60
    color: "#2d2d37"
    
    // 搜索建议数据模型
    ListModel {
        id: suggestionsModel
        ListElement { type: "hot"; keyword: "热门歌曲"; icon: "🔥" }
        ListElement { type: "artist"; keyword: "周杰伦"; icon: "👤" }
        ListElement { type: "song"; keyword: "告白气球"; icon: "🎵" }
        ListElement { type: "song"; keyword: "晴天"; icon: "🎵" }
        ListElement { type: "song"; keyword: "稻香"; icon: "🎵" }
        ListElement { type: "album"; keyword: "七里香"; icon: "💿" }
    }
    
    // 搜索历史数据模型
    ListModel {
        id: searchHistoryModel
        ListElement { text: "傻女" }
        ListElement { text: "深圳838" }
        ListElement { text: "DJ阿智" }
        ListElement { text: "刘德华" }
        ListElement { text: "李荣浩" }
        ListElement { text: "张杰" }
        ListElement { text: "深圳" }
    }
    
    // 猜你喜欢数据模型
    ListModel {
        id: guessLikeModel
        ListElement { text: "海屿你" }
        ListElement { text: "小半" }
        ListElement { text: "DJ阿智" }
        ListElement { text: "郑润泽" }
        ListElement { text: "精卫" }
        ListElement { text: "雨过后的风景" }
        ListElement { text: "颜人中" }
        ListElement { text: "陈奕迅" }
        ListElement { text: "林俊杰" }
        ListElement { text: "毛不易" }
        ListElement { text: "知我" }
        ListElement { text: "陶喆" }
        ListElement { text: "孙燕姿" }
        ListElement { text: "苦茶子" }
        ListElement { text: "薛之谦" }
        ListElement { text: "张杰" }
        ListElement { text: "赵雷" }
        ListElement { text: "红色高跟鞋" }
    }
    
    property bool isSelectingFromPopup: false
    
    // 搜索相关函数
    function fetchSuggestions(query) {
        console.log("模拟 API 请求:", query)
        searchTimer.restart()
    }
    
    function addSearchHistory(text) {
        if (text === "") return
        
        for (var i = 0; i < searchHistoryModel.count; i++) {
            if (searchHistoryModel.get(i).text === text) {
                searchHistoryModel.move(i, 0, 1)
                return
            }
        }
        
        searchHistoryModel.insert(0, { text: text })
        
        if (searchHistoryModel.count > 10) {
            searchHistoryModel.remove(10, searchHistoryModel.count - 10)
        }
    }
    
    function removeSearchHistory(index) {
        searchHistoryModel.remove(index)
    }
    
    function clearSearchHistory() {
        searchHistoryModel.clear()
    }
    
    function performSearch(text) {
        if (text === "") return
        console.log("执行搜索:", text)
        addSearchHistory(text)
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
            iconSource: "qrc:/CloudMusic/resources/qrc/icon/left.svg"
            color: "#3d3d47"
            onClicked: console.log("返回")
        }

        // 搜索框
        TopBar.SearchBar {
            id: searchBar
            width: parent.width - 450
            anchors.verticalCenter: parent.verticalCenter
            
            onSearchRequested: (text) => {
                console.log("搜索:", text)
                rightTopRect.performSearch(text)
                searchPopup.close()
                hotSearchPopup.close()
            }
            
            onVoiceSearchRequested: console.log("语音搜索")
            
            onInputTextChanged: (text) => {
                if (rightTopRect.isSelectingFromPopup) {
                    rightTopRect.isSelectingFromPopup = false
                    return
                }
                
                if (text.length > 0) {
                    rightTopRect.fetchSuggestions(text)
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
            text: "未登录"
            onClicked: {
                console.log("登录")
                loginPopup.open()
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
                iconSource: "qrc:/CloudMusic/resources/qrc/icon/down.svg"
                tooltip: "下载"
                onClicked: console.log("下载")
            }
            
            TopBar.IconButton {
                iconSource: "qrc:/CloudMusic/resources/qrc/icon/down_s.svg"
                tooltip: "换肤"
                onClicked: console.log("换肤")
            }
            
            TopBar.IconButton {
                iconSource: "qrc:/CloudMusic/resources/qrc/icon/setting.svg"
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
        
        searchHistoryModel: searchHistoryModel
        guessLikeModel: guessLikeModel
        
        onHistoryClicked: (text) => {
            console.log("点击搜索历史：", text)
            rightTopRect.isSelectingFromPopup = true
            searchBar.text = text
            rightTopRect.performSearch(text)
            hotSearchPopup.close()
        }
        
        onHistoryLongPressed: (index) => {
            console.log("长按删除搜索历史")
            rightTopRect.removeSearchHistory(index)
        }
        
        onClearHistoryClicked: {
            console.log("清空搜索历史")
            rightTopRect.clearSearchHistory()
        }
        
        onGuessLikeClicked: (text) => {
            console.log("点击猜你喜欢：", text)
            rightTopRect.isSelectingFromPopup = true
            searchBar.text = text
            rightTopRect.performSearch(text)
            hotSearchPopup.close()
        }
        
        onRankingItemClicked: (text) => {
            rightTopRect.isSelectingFromPopup = true
            searchBar.text = text
            console.log("选择榜单歌曲:", text)
            rightTopRect.performSearch(text)
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
        
        model: suggestionsModel
        searchText: searchBar.text
        
        onSuggestionSelected: (keyword, type) => {
            rightTopRect.isSelectingFromPopup = true
            searchBar.text = keyword
            console.log("选择建议:", keyword, "类型:", type)
            rightTopRect.performSearch(keyword)
            searchPopup.close()
        }
    }
    
    // 登录弹窗
    TopBar.LoginPopup {
        id: loginPopup
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
    
    // 模拟 API 请求延迟
    Timer {
        id: searchTimer
        interval: 300
        onTriggered: {
            console.log("API 请求完成，更新建议列表")
        }
    }
}
