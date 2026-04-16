import QtQuick

pragma Singleton

QtObject {
    id: viewModel
    
    // ========== 官方歌单数据 ==========
    property ListModel officialPlaylists: ListModel {
        ListElement {
            playCount: "569.5万"
            name: "全球流行趋势 | 单依纯,Mariah Carey,胡彦斌..."
            coverUrl: ""
        }
        ListElement {
            playCount: "64.8万"
            name: "Phonk新歌到 | 更新2026 全球最新冯克单曲"
            coverUrl: ""
        }
        ListElement {
            playCount: "169.7万"
            name: "R&B咖啡吧 | 用R&B和咖啡碰个杯"
            coverUrl: ""
        }
        ListElement {
            playCount: "452.6万"
            name: "华语流行Hi-Res | 经典华语歌曲随身听"
            coverUrl: ""
        }
        ListElement {
            playCount: "328.3万"
            name: "欧美经典 | 永不过时的旋律"
            coverUrl: ""
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
