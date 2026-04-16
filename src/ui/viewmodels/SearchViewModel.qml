import QtQuick

pragma Singleton

QtObject {
    id: viewModel
    
    // ========== 数据模型 ==========
    property ListModel suggestionsModel: ListModel {
        ListElement { type: "hot"; keyword: "热门歌曲"; icon: "🔥" }
        ListElement { type: "artist"; keyword: "周杰伦"; icon: "👤" }
        ListElement { type: "song"; keyword: "告白气球"; icon: "🎵" }
        ListElement { type: "song"; keyword: "晴天"; icon: "🎵" }
        ListElement { type: "song"; keyword: "稻香"; icon: "🎵" }
        ListElement { type: "album"; keyword: "七里香"; icon: "💿" }
    }
    
    property ListModel searchHistoryModel: ListModel {
        ListElement { text: "傻女" }
        ListElement { text: "深圳838" }
        ListElement { text: "DJ阿智" }
        ListElement { text: "刘德华" }
        ListElement { text: "李荣浩" }
        ListElement { text: "张杰" }
        ListElement { text: "深圳" }
    }
    
    property ListModel guessLikeModel: ListModel {
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
    
    // ========== 状态属性 ==========
    property string currentSearchText: ""
    property bool isSelectingFromPopup: false
    property bool isLoggedIn: false
    property string userName: ""
    
    // ========== 信号 ==========
    signal searchRequested(string text)
    signal suggestionsFetched()
    signal historyUpdated()
    
    // ========== 搜索相关方法 ==========
    function fetchSuggestions(query) {
        currentSearchText = query
        searchTimer.restart()
    }
    
    function performSearch(text) {
        if (text === "") return
        addSearchHistory(text)
        searchRequested(text)
    }
    
    // ========== 搜索历史管理 ==========
    function addSearchHistory(text) {
        if (text === "") return
        
        // 检查是否已存在，如果存在则移到最前面
        for (var i = 0; i < searchHistoryModel.count; i++) {
            if (searchHistoryModel.get(i).text === text) {
                searchHistoryModel.move(i, 0, 1)
                historyUpdated()
                return
            }
        }
        
        // 添加新记录到最前面
        searchHistoryModel.insert(0, { text: text })
        
        // 限制最多10条记录
        if (searchHistoryModel.count > 10) {
            searchHistoryModel.remove(10, searchHistoryModel.count - 10)
        }
        
        historyUpdated()
    }
    
    function removeSearchHistory(index) {
        if (index >= 0 && index < searchHistoryModel.count) {
            searchHistoryModel.remove(index)
            historyUpdated()
        }
    }
    
    function clearSearchHistory() {
        searchHistoryModel.clear()
        historyUpdated()
    }
    
    // ========== 用户相关方法 ==========
    function login(username) {
        isLoggedIn = true
        userName = username
    }
    
    function logout() {
        isLoggedIn = false
        userName = ""
    }
    
    // ========== 内部定时器 ==========
    property Timer searchTimer: Timer {
        interval: 300
        onTriggered: {
            viewModel.suggestionsFetched()
        }
    }
}
