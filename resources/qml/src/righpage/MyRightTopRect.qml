import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import "./components/topbar"

Rectangle {
    id: rightTopRect
    height: 60
    color: "#2d2d37"
    
    // 搜索建议数据模型 - 模拟 API 返回的 JSON 结构
    ListModel {
        id: suggestionsModel
        ListElement {
            type: "hot"
            keyword: "热门歌曲"
            icon: "🔥"
        }
        ListElement {
            type: "artist"
            keyword: "周杰伦"
            icon: "👤"
        }
        ListElement {
            type: "song"
            keyword: "告白气球"
            icon: "🎵"
        }
        ListElement {
            type: "song"
            keyword: "晴天"
            icon: "🎵"
        }
        ListElement {
            type: "song"
            keyword: "稻香"
            icon: "🎵"
        }
        ListElement {
            type: "album"
            keyword: "七里香"
            icon: "💿"
        }
    }
    
    // 热门搜索数据模型
    ListModel {
        id: hotSearchModel
        ListElement {
            keyword: "周杰伦新歌"
            hotIndex: 1
            isHot: true
        }
        ListElement {
            keyword: "告白气球"
            hotIndex: 2
            isHot: true
        }
        ListElement {
            keyword: "晴天"
            hotIndex: 3
            isHot: false
        }
        ListElement {
            keyword: "稻香"
            hotIndex: 4
            isHot: false
        }
        ListElement {
            keyword: "七里香"
            hotIndex: 5
            isHot: false
        }
    }
    
    // 模拟 API 请求函数
    function fetchSuggestions(query) {
        console.log("模拟 API 请求:", query)
        // 这里可以添加实际的网络请求
        // 例如: xhr.get("https://api.example.com/search?q=" + query)
        
        // 模拟延迟
        searchTimer.restart()
    }
    
    // 标志：是否正在从弹窗选择项（避免触发搜索建议）
    property bool isSelectingFromPopup: false

    Row {
        id: topRow
        anchors.fill: parent
        anchors.leftMargin: 16
        anchors.rightMargin: 16
        spacing: 12
        
        // 返回按钮
        IconButton {
            anchors.verticalCenter: parent.verticalCenter
            iconSource: "qrc:/CloudMusic/resources/qrc/icon/left.svg"
            color: "#3d3d47"
            onClicked: console.log("返回")
        }

        // 搜索框
        SearchBar {
            id: searchBar
            width: parent.width - 450
            anchors.verticalCenter: parent.verticalCenter
            
            onSearchRequested: (text) => {
                console.log("搜索:", text)
                searchPopup.close()
            }
            
            onVoiceSearchRequested: console.log("语音搜索")
            
            onInputTextChanged: (text) => {
                // 如果是从弹窗选择的，不触发搜索建议
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
                    // 如果文本被清空且搜索框有焦点，显示热搜弹窗
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
        TextButton {
            anchors.verticalCenter: parent.verticalCenter
            text: "未登录"
            onClicked: console.log("登录")
        }
        
        // VIP按钮
        TextButton {
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
            
            IconButton {
                iconSource: "qrc:/CloudMusic/resources/qrc/icon/down.svg"
                tooltip: "下载"
                onClicked: console.log("下载")
            }
            
            IconButton {
                iconSource: "qrc:/CloudMusic/resources/qrc/icon/down_s.svg"
                tooltip: "换肤"
                onClicked: console.log("换肤")
            }
            
            IconButton {
                iconSource: "qrc:/CloudMusic/resources/qrc/icon/setting.svg"
                tooltip: "设置"
                onClicked: console.log("设置")
            }
        }
        
        // 系统控制按钮
        WindowControl {
            anchors.verticalCenter: parent.verticalCenter
        }
    }
    
    // 热门搜索弹窗（焦点聚焦时显示）- 竖直滚动榜单
    Popup {
        id: hotSearchPopup
        parent: rightTopRect
        x:  topRow.spacing
        y: rightTopRect.height
        width: rightTopRect.width-(topRow.spacing)-16
        height: rightBottomRect.height
        padding: 0
        closePolicy: Popup.NoAutoClose
        
        background: Rectangle {
            color: "#ffffff"
            radius: 12
            border.color: "#e0e0e0"
            border.width: 1
        }
        
        ScrollView {
            anchors.fill: parent
            clip: true
            
            ColumnLayout {
                width: hotSearchPopup.width - 32
                spacing: 16
                
                // ================== 搜索历史区域 ==================
                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.leftMargin: 16
                    Layout.rightMargin: 16
                    Layout.topMargin: 16
                    spacing: 12
                    
                    // 标题栏 + 删除图标
                    RowLayout {
                        Layout.fillWidth: true
                        spacing: 12
                        
                        Text {
                            text: "搜索历史"
                            font.pixelSize: 16
                            font.bold: true
                            color: "#333333"
                        }
                        
                        // 删除图标
                        Rectangle {
                            width: 24
                            height: 24
                            color: "transparent"
                            
                            Text {
                                text: "🗑️"
                                font.pixelSize: 16
                                anchors.centerIn: parent
                            }
                            
                            MouseArea {
                                anchors.fill: parent
                                cursorShape: Qt.PointingHandCursor
                                onClicked: {
                                    console.log("清空搜索历史")
                                    searchHistoryModel.clear()
                                }
                            }
                        }
                        
                        Item { Layout.fillWidth: true }
                    }
                    
                    // 搜索历史标签流
                    Flow {
                        Layout.fillWidth: true
                        spacing: 8
                        
                        Repeater {
                            model: ListModel {
                                id: searchHistoryModel
                                ListElement { text: "傻女" }
                                ListElement { text: "深圳838" }
                                ListElement { text: "DJ阿智" }
                                ListElement { text: "刘德华" }
                                ListElement { text: "李荣浩" }
                                ListElement { text: "张杰" }
                                ListElement { text: "深圳" }
                            }
                            
                            delegate: Rectangle {
                                width: tagText.width + 16
                                height: tagText.height + 16
                                radius: 16
                                color: tagMouseArea.pressed ? "#e2e8f0" : "#f3f4f6"
                                
                                Text {
                                    id: tagText
                                    text: model.text
                                    font.pixelSize: 13
                                    color: "#4a5568"
                                    anchors.centerIn: parent
                                }
                                
                                MouseArea {
                                    id: tagMouseArea
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        console.log("点击搜索历史：", model.text)
                                        rightTopRect.isSelectingFromPopup = true
                                        searchBar.text = model.text
                                        hotSearchPopup.close()
                                    }
                                }
                            }
                        }
                    }
                }
                
                // ================== 猜你喜欢区域 ==================
                ColumnLayout {
                    Layout.fillWidth: true
                    Layout.leftMargin: 16
                    Layout.rightMargin: 16
                    spacing: 12
                    
                    Text {
                        text: "猜你喜欢"
                        font.pixelSize: 16
                        font.bold: true
                        color: "#333333"
                    }
                    
                    // 猜你喜欢标签流
                    Flow {
                        Layout.fillWidth: true
                        spacing: 8
                        
                        Repeater {
                            model: ListModel {
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
                            
                            delegate: Rectangle {
                                width: guessText.width + 16
                                height: guessText.height + 16
                                radius: 16
                                color: guessMouseArea.pressed ? "#e2e8f0" : "#f3f4f6"
                                
                                Text {
                                    id: guessText
                                    text: model.text
                                    font.pixelSize: 13
                                    color: "#4a5568"
                                    anchors.centerIn: parent
                                }
                                
                                MouseArea {
                                    id: guessMouseArea
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: {
                                        console.log("点击猜你喜欢：", model.text)
                                        rightTopRect.isSelectingFromPopup = true
                                        searchBar.text = model.text
                                        hotSearchPopup.close()
                                    }
                                }
                            }
                        }
                    }
                }
                
                // 热搜榜
                Rectangle {
                    Layout.fillWidth: true
                    Layout.leftMargin: 16
                    Layout.rightMargin: 16
                    Layout.topMargin: 16
                    implicitHeight: hotColumn.height + 32
                    color: "#fafafa"
                    radius: 8
                    
                    ColumnLayout {
                        id: hotColumn
                        width: parent.width
                        spacing: 12
                        anchors.top: parent.top
                        anchors.topMargin: 16
                        
                        Text {
                            text: "热搜榜"
                            font.pixelSize: 16
                            font.bold: true
                            color: "#333333"
                            Layout.leftMargin: 16
                        }
                        
                        GridLayout {
                            Layout.fillWidth: true
                            Layout.leftMargin: 16
                            Layout.rightMargin: 16
                            Layout.bottomMargin: 16
                            columns: 3
                            rowSpacing: 12
                            columnSpacing: 12
                            
                            Repeater {
                                model: [
                                    { rank: "1", title: "海屿你", tag: "爆" },
                                    { rank: "2", title: "雨爱", tag: "" },
                                    { rank: "3", title: "眼泪的汛期", tag: "" },
                                    { rank: "4", title: "一半一半", tag: "" },
                                    { rank: "5", title: "幻痛药", tag: "" },
                                    { rank: "6", title: "巴拉莱卡", tag: "" }
                                ]
                                
                                Rectangle {
                                    Layout.fillWidth: true
                                    implicitHeight: 40
                                    color: rankMouseArea.containsMouse ? "#ffffff" : "transparent"
                                    radius: 6
                                    
                                    RowLayout {
                                        anchors.fill: parent
                                        anchors.leftMargin: 8
                                        anchors.rightMargin: 8
                                        spacing: 6
                                        
                                        Text {
                                            text: modelData.rank
                                            font.pixelSize: 14
                                            font.bold: modelData.rank <= "3"
                                            color: modelData.rank <= "3" ? "#ec4141" : "#999999"
                                            Layout.preferredWidth: 20
                                        }
                                        
                                        Text {
                                            text: modelData.title
                                            font.pixelSize: 13
                                            color: "#333333"
                                            elide: Text.ElideRight
                                            Layout.fillWidth: true
                                        }
                                        
                                        Rectangle {
                                            visible: modelData.tag !== ""
                                            implicitWidth: 20
                                            implicitHeight: 16
                                            radius: 3
                                            color: modelData.tag === "爆" ? "#ec4141" : "#00b42a"
                                            
                                            Text {
                                                text: modelData.tag
                                                font.pixelSize: 10
                                                font.bold: true
                                                color: "#ffffff"
                                                anchors.centerIn: parent
                                            }
                                        }
                                    }
                                    
                                    MouseArea {
                                        id: rankMouseArea
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: {
                                            rightTopRect.isSelectingFromPopup = true
                                            searchBar.text = modelData.title
                                            console.log("选择榜单歌曲:", modelData.title)
                                            hotSearchPopup.close()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                // 说唱榜
                Rectangle {
                    Layout.fillWidth: true
                    Layout.leftMargin: 16
                    Layout.rightMargin: 16
                    implicitHeight: rapColumn.height + 32
                    color: "#fafafa"
                    radius: 8
                    
                    ColumnLayout {
                        id: rapColumn
                        width: parent.width
                        spacing: 12
                        anchors.top: parent.top
                        anchors.topMargin: 16
                        
                        Text {
                            text: "说唱榜"
                            font.pixelSize: 16
                            font.bold: true
                            color: "#333333"
                            Layout.leftMargin: 16
                        }
                        
                        GridLayout {
                            Layout.fillWidth: true
                            Layout.leftMargin: 16
                            Layout.rightMargin: 16
                            Layout.bottomMargin: 16
                            columns: 3
                            rowSpacing: 12
                            columnSpacing: 12
                            
                            Repeater {
                                model: [
                                    { rank: "1", title: "DD backseat", tag: "" },
                                    { rank: "2", title: "故意没接", tag: "" },
                                    { rank: "3", title: "十里", tag: "" },
                                    { rank: "4", title: "山歌王", tag: "" },
                                    { rank: "5", title: "1 On 1", tag: "" },
                                    { rank: "6", title: "21爱", tag: "" }
                                ]
                                
                                Rectangle {
                                    Layout.fillWidth: true
                                    implicitHeight: 40
                                    color: rankMouseArea.containsMouse ? "#ffffff" : "transparent"
                                    radius: 6
                                    
                                    RowLayout {
                                        anchors.fill: parent
                                        anchors.leftMargin: 8
                                        anchors.rightMargin: 8
                                        spacing: 6
                                        
                                        Text {
                                            text: modelData.rank
                                            font.pixelSize: 14
                                            font.bold: modelData.rank <= "3"
                                            color: modelData.rank <= "3" ? "#ec4141" : "#999999"
                                            Layout.preferredWidth: 20
                                        }
                                        
                                        Text {
                                            text: modelData.title
                                            font.pixelSize: 13
                                            color: "#333333"
                                            elide: Text.ElideRight
                                            Layout.fillWidth: true
                                        }
                                        
                                        Rectangle {
                                            visible: modelData.tag !== ""
                                            implicitWidth: 20
                                            implicitHeight: 16
                                            radius: 3
                                            color: modelData.tag === "爆" ? "#ec4141" : "#00b42a"
                                            
                                            Text {
                                                text: modelData.tag
                                                font.pixelSize: 10
                                                font.bold: true
                                                color: "#ffffff"
                                                anchors.centerIn: parent
                                            }
                                        }
                                    }
                                    
                                    MouseArea {
                                        id: rankMouseArea
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: {
                                            rightTopRect.isSelectingFromPopup = true
                                            searchBar.text = modelData.title
                                            console.log("选择榜单歌曲:", modelData.title)
                                            hotSearchPopup.close()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                // 古风榜
                Rectangle {
                    Layout.fillWidth: true
                    Layout.leftMargin: 16
                    Layout.rightMargin: 16
                    implicitHeight: classicalColumn.height + 32
                    color: "#fafafa"
                    radius: 8
                    
                    ColumnLayout {
                        id: classicalColumn
                        width: parent.width
                        spacing: 12
                        anchors.top: parent.top
                        anchors.topMargin: 16
                        
                        Text {
                            text: "古风榜"
                            font.pixelSize: 16
                            font.bold: true
                            color: "#333333"
                            Layout.leftMargin: 16
                        }
                        
                        GridLayout {
                            Layout.fillWidth: true
                            Layout.leftMargin: 16
                            Layout.rightMargin: 16
                            Layout.bottomMargin: 16
                            columns: 3
                            rowSpacing: 12
                            columnSpacing: 12
                            
                            Repeater {
                                model: [
                                    { rank: "1", title: "我本将心向明月", tag: "" },
                                    { rank: "2", title: "咏春", tag: "" },
                                    { rank: "3", title: "知我", tag: "" },
                                    { rank: "4", title: "一程山路", tag: "" },
                                    { rank: "5", title: "诀别书", tag: "" },
                                    { rank: "6", title: "武家坡2021", tag: "" }
                                ]
                                
                                Rectangle {
                                    Layout.fillWidth: true
                                    implicitHeight: 40
                                    color: rankMouseArea.containsMouse ? "#ffffff" : "transparent"
                                    radius: 6
                                    
                                    RowLayout {
                                        anchors.fill: parent
                                        anchors.leftMargin: 8
                                        anchors.rightMargin: 8
                                        spacing: 6
                                        
                                        Text {
                                            text: modelData.rank
                                            font.pixelSize: 14
                                            font.bold: modelData.rank <= "3"
                                            color: modelData.rank <= "3" ? "#ec4141" : "#999999"
                                            Layout.preferredWidth: 20
                                        }
                                        
                                        Text {
                                            text: modelData.title
                                            font.pixelSize: 13
                                            color: "#333333"
                                            elide: Text.ElideRight
                                            Layout.fillWidth: true
                                        }
                                        
                                        Rectangle {
                                            visible: modelData.tag !== ""
                                            implicitWidth: 20
                                            implicitHeight: 16
                                            radius: 3
                                            color: modelData.tag === "爆" ? "#ec4141" : "#00b42a"
                                            
                                            Text {
                                                text: modelData.tag
                                                font.pixelSize: 10
                                                font.bold: true
                                                color: "#ffffff"
                                                anchors.centerIn: parent
                                            }
                                        }
                                    }
                                    
                                    MouseArea {
                                        id: rankMouseArea
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: {
                                            rightTopRect.isSelectingFromPopup = true
                                            searchBar.text = modelData.title
                                            console.log("选择榜单歌曲:", modelData.title)
                                            hotSearchPopup.close()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                
                // 摇滚榜
                Rectangle {
                    Layout.fillWidth: true
                    Layout.leftMargin: 16
                    Layout.rightMargin: 16
                    Layout.bottomMargin: 16
                    implicitHeight: rockColumn.height + 32
                    color: "#fafafa"
                    radius: 8
                    
                    ColumnLayout {
                        id: rockColumn
                        width: parent.width
                        spacing: 12
                        anchors.top: parent.top
                        anchors.topMargin: 16
                        
                        Text {
                            text: "摇滚榜"
                            font.pixelSize: 16
                            font.bold: true
                            color: "#333333"
                            Layout.leftMargin: 16
                        }
                        
                        GridLayout {
                            Layout.fillWidth: true
                            Layout.leftMargin: 16
                            Layout.rightMargin: 16
                            Layout.bottomMargin: 16
                            columns: 3
                            rowSpacing: 12
                            columnSpacing: 12
                            
                            Repeater {
                                model: [
                                    { rank: "1", title: "夜空中最亮的星", tag: "" },
                                    { rank: "2", title: "无法逃脱", tag: "" },
                                    { rank: "3", title: "向阳花", tag: "" },
                                    { rank: "4", title: "公路之歌", tag: "" },
                                    { rank: "5", title: "再见杰克", tag: "" },
                                    { rank: "6", title: "山海", tag: "" }
                                ]
                                
                                Rectangle {
                                    Layout.fillWidth: true
                                    implicitHeight: 40
                                    color: rankMouseArea.containsMouse ? "#ffffff" : "transparent"
                                    radius: 6
                                    
                                    RowLayout {
                                        anchors.fill: parent
                                        anchors.leftMargin: 8
                                        anchors.rightMargin: 8
                                        spacing: 6
                                        
                                        Text {
                                            text: modelData.rank
                                            font.pixelSize: 14
                                            font.bold: modelData.rank <= "3"
                                            color: modelData.rank <= "3" ? "#ec4141" : "#999999"
                                            Layout.preferredWidth: 20
                                        }
                                        
                                        Text {
                                            text: modelData.title
                                            font.pixelSize: 13
                                            color: "#333333"
                                            elide: Text.ElideRight
                                            Layout.fillWidth: true
                                        }
                                        
                                        Rectangle {
                                            visible: modelData.tag !== ""
                                            implicitWidth: 20
                                            implicitHeight: 16
                                            radius: 3
                                            color: modelData.tag === "爆" ? "#ec4141" : "#00b42a"
                                            
                                            Text {
                                                text: modelData.tag
                                                font.pixelSize: 10
                                                font.bold: true
                                                color: "#ffffff"
                                                anchors.centerIn: parent
                                            }
                                        }
                                    }
                                    
                                    MouseArea {
                                        id: rankMouseArea
                                        anchors.fill: parent
                                        hoverEnabled: true
                                        cursorShape: Qt.PointingHandCursor
                                        onClicked: {
                                            rightTopRect.isSelectingFromPopup = true
                                            searchBar.text = modelData.title
                                            console.log("选择榜单歌曲:", modelData.title)
                                            hotSearchPopup.close()
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    // 搜索建议弹窗（输入时显示）
    Popup {
        id: searchPopup
        parent: rightTopRect
        x:  topRow.spacing
        y: rightTopRect.height
        width: rightTopRect.width-(topRow.spacing)-16
        height: rightBottomRect.height
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
            model: suggestionsModel
            
            delegate: Rectangle {
                width: suggestionList.width
                height: 50
                color: suggestionMouseArea.containsMouse ? "#f3f4f6" : "transparent"
                
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
                            var searchText = searchBar.text
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
                    id: suggestionMouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        rightTopRect.isSelectingFromPopup = true
                        searchBar.text = model.keyword
                        console.log("选择建议:", model.keyword, "类型:", model.type)
                        searchPopup.close()
                    }
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
            // 这里可以更新 suggestionsModel
            // 例如: suggestionsModel.clear()
            //       suggestionsModel.append({...})
        }
    }
}
