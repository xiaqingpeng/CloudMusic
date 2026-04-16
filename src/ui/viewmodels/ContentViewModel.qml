import QtQuick

pragma Singleton

QtObject {
    id: viewModel
    
    // ========== 官方歌单数据 ==========
    property ListModel officialPlaylists: ListModel {
        ListElement {
            coverColor: "#8B5A3C"
            coverImage: "/qt/qml/resources/image/cover1.jpg"
            playCount: "526.5万"
            mainTitle: "华语RNB趋势"
            subTitle: "宋慕勋,王嘉尔等华语热歌合集"
            tag1: "1 一点就好"
            tag2: "2 谎话"
            tag3: "3 嘿味道做"
        }
        ListElement {
            coverColor: "#8B3A8B"
            coverImage: "/qt/qml/resources/image/cover2.jpg"
            playCount: "70.2万"
            mainTitle: "Phonk"
            subTitle: "Phonk新歌到 | 更新2026 全球最新冯克单曲"
            tag1: ""
            tag2: ""
            tag3: ""
        }
        ListElement {
            coverColor: "#6B7B6B"
            coverImage: "/qt/qml/resources/image/cover3.jpg"
            playCount: "18.6万"
            mainTitle: "复古"
            subTitle: "复古咖啡馆 | 休息一下 来首熟悉的欧美小调"
            tag1: ""
            tag2: ""
            tag3: ""
        }
        ListElement {
            coverColor: "#C14B7B"
            coverImage: "/qt/qml/resources/image/cover4.jpg"
            playCount: "25.6万"
            mainTitle: "00s"
            subTitle: "00s华语流行 | 那些年追过的华语经典·HiFi高音质"
            tag1: ""
            tag2: ""
            tag3: ""
        }
        ListElement {
            coverColor: "#4A7C8B"
            coverImage: "/qt/qml/resources/image/cover5.jpg"
            playCount: "892.3万"
            mainTitle: "电音"
            subTitle: "电音狂潮 | 全球顶级DJ精选电音合集"
            tag1: ""
            tag2: ""
            tag3: ""
        }
        ListElement {
            coverColor: "#8B6A3C"
            coverImage: "/qt/qml/resources/image/cover6.jpg"
            playCount: "345.7万"
            mainTitle: "爵士"
            subTitle: "爵士之夜 | 经典爵士乐精选集"
            tag1: ""
            tag2: ""
            tag3: ""
        }
        ListElement {
            coverColor: "#6B4A8B"
            coverImage: "/qt/qml/resources/image/cover7.jpg"
            playCount: "567.9万"
            mainTitle: "摇滚"
            subTitle: "摇滚传奇 | 永不过时的摇滚经典"
            tag1: ""
            tag2: ""
            tag3: ""
        }
        ListElement {
            coverColor: "#8B4A5A"
            coverImage: "/qt/qml/resources/image/cover8.jpg"
            playCount: "234.1万"
            mainTitle: "民谣"
            subTitle: "民谣时光 | 温暖治愈的民谣歌曲"
            tag1: ""
            tag2: ""
            tag3: ""
        }
        ListElement {
            coverColor: "#5A8B4A"
            coverImage: "/qt/qml/resources/image/cover9.jpg"
            playCount: "678.4万"
            mainTitle: "说唱"
            subTitle: "说唱新势力 | 华语说唱精选榜单"
            tag1: ""
            tag2: ""
            tag3: ""
        }
        ListElement {
            coverColor: "#8B7A4A"
            coverImage: "/qt/qml/resources/image/cover10.jpg"
            playCount: "456.8万"
            mainTitle: "古风"
            subTitle: "古风雅韵 | 国风音乐精选集"
            tag1: ""
            tag2: ""
            tag3: ""
        }
    }
    
    // ========== 有声书数据 ==========
    property ListModel audioBooks: ListModel {
        ListElement {
            coverType: "special"
            title: "听过的有声书"
            desc: "听过的好书都在这"
            score: ""
            playCount: ""
            tags: ""
        }
        ListElement {
            coverType: "normal"
            title: "半夜别回头"
            desc: "招魂游戏，不要轻易尝试"
            score: "9.6分"
            playCount: "480.8万"
            tags: "高分必听"
        }
        ListElement {
            coverType: "normal"
            title: "广播剧《纸飞机》"
            desc: "一起走吧，一起寻找光"
            score: "9.8分"
            playCount: "1445.6万"
            tags: "高分必听"
        }
        ListElement {
            coverType: "normal"
            title: "月亮与六便士"
            desc: "满地都是六便士，他却抬头看见了月亮"
            score: "9.3分"
            playCount: "201.7万"
            tags: "高分必听"
        }
        ListElement {
            coverType: "normal"
            title: "我在荒岛被美女包围了"
            desc: "这座荒岛，我罩了！"
            score: "8.9分"
            playCount: "204.8万"
            tags: "新人免费听"
        }
        ListElement {
            coverType: "normal"
            title: "欲言难止 | 顺子X倒霉死勒"
            desc: "《囚于永夜》同作者人气作品"
            score: "9.8分"
            playCount: "2596.5万"
            tags: "高分必听"
        }
    }
    
    // ========== 轮播图数据 ==========
    property ListModel banners: ListModel {
        ListElement {
            imageUrl: ""
            title: "新歌推荐"
            link: ""
        }
        ListElement {
            imageUrl: ""
            title: "热门歌单"
            link: ""
        }
        ListElement {
            imageUrl: ""
            title: "独家专辑"
            link: ""
        }
    }
    
    // ========== 分类数据 ==========
    property ListModel categories: ListModel {
        ListElement { name: "全部"; categoryId: "all" }
        ListElement { name: "悬疑"; categoryId: "mystery" }
        ListElement { name: "言情"; categoryId: "romance" }
        ListElement { name: "都市"; categoryId: "urban" }
        ListElement { name: "玄幻"; categoryId: "fantasy" }
        ListElement { name: "历史"; categoryId: "history" }
    }
    
    property string currentCategory: "all"
    
    // ========== 信号 ==========
    signal playlistClicked(string playlistId)
    signal audioBookClicked(string bookId)
    signal bannerClicked(string link)
    signal categoryChanged(string categoryId)
    
    // ========== 方法 ==========
    function loadPlaylists() {
        console.log("ContentViewModel: 加载歌单列表")
        // 这里可以调用 API 加载数据
    }
    
    function loadAudioBooks(category) {
        currentCategory = category || "all"
        console.log("ContentViewModel: 加载有声书列表", currentCategory)
        categoryChanged(currentCategory)
        // 这里可以调用 API 加载数据
    }
    
    function loadBanners() {
        console.log("ContentViewModel: 加载轮播图")
        // 这里可以调用 API 加载数据
    }
    
    function refreshContent() {
        loadPlaylists()
        loadAudioBooks()
        loadBanners()
        console.log("ContentViewModel: 刷新内容")
    }
    
    // ========== 搜索和过滤 ==========
    function searchContent(keyword) {
        console.log("ContentViewModel: 搜索内容", keyword)
        // 实现搜索逻辑
    }
    
    function filterByCategory(categoryId) {
        loadAudioBooks(categoryId)
    }
}
