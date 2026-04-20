import QtQuick

pragma Singleton

QtObject {
    id: viewModel
    
    // ========== 播放状态 ==========
    property bool isPlaying: false
    property real progress: 0.0  // 0.0 - 1.0
    property int volume: 80  // 0 - 100
    property bool isMuted: false
    property bool isLiked: false
    property bool isShuffleMode: false
    property string repeatMode: "off"  // "off", "one", "all"
    
    // ========== 当前歌曲信息 ==========
    property string currentSongName: "栖息地"
    property string currentArtistName: "Mikey-18 / 暴躁的兔子"
    property string currentAlbumCover: ""
    property int currentDuration: 240  // 秒
    property int currentPosition: 0  // 秒
    property string currentQuality: "极高"  // 当前音质
    
    // ========== 音质选项 ==========
    property ListModel qualityOptions: ListModel {
        ListElement {
            qualityId: "hires"
            icon: "H"
            iconBgColor: "#fff0f0"
            iconColor: "#ec4141"
            title: "高解析度无损 (Hi-Res)"
            description: "更饱满清晰的高解析度音质，最高192kHz/24bit"
            displayName: "Hi-Res"
        }
        ListElement {
            qualityId: "sq"
            icon: "SQ"
            iconBgColor: "#fff5e6"
            iconColor: "#ff9800"
            title: "无损 (SQ)"
            description: "高保真无损音质，最高48kHz/16bit"
            displayName: "无损"
        }
        ListElement {
            qualityId: "hq"
            icon: "HQ"
            iconBgColor: "#f3f0ff"
            iconColor: "#7c4dff"
            title: "极高 (HQ)"
            description: "近 CD 音质的细节体验，最高320kbps"
            displayName: "极高"
        }
        ListElement {
            qualityId: "standard"
            icon: "标"
            iconBgColor: "#f5f5f5"
            iconColor: "#9e9e9e"
            title: "标准"
            description: "128kbps"
            displayName: "标准"
        }
    }
    
    // ========== 播放列表 ==========
    property ListModel playlist: ListModel {
        ListElement {
            songName: "栖息地"
            artistName: "Mikey-18 / 暴躁的兔子"
            duration: 240
        }
        ListElement {
            songName: "告白气球"
            artistName: "周杰伦"
            duration: 210
        }
        ListElement {
            songName: "晴天"
            artistName: "周杰伦"
            duration: 270
        }
    }
    
    property int currentSongIndex: 0
    
    // ========== 统计数据 ==========
    property int likeCount: 999
    property int commentCount: 549
    property int shareCount: 123
    
    // ========== 信号 ==========
    signal playRequested()
    signal pauseRequested()
    signal nextSongRequested()
    signal previousSongRequested()
    signal seekRequested(real position)
    signal volumeAdjusted(int volume)
    signal songChanged(int index)
    signal qualityChanged(string quality)
    
    // ========== 播放控制方法 ==========
    function play() {
        isPlaying = true
        playRequested()
    }
    
    function pause() {
        isPlaying = false
        pauseRequested()
    }
    
    function togglePlayPause() {
        if (isPlaying) {
            pause()
        } else {
            play()
        }
    }
    
    function nextSong() {
        if (isShuffleMode) {
            currentSongIndex = Math.floor(Math.random() * playlist.count)
        } else {
            currentSongIndex = (currentSongIndex + 1) % playlist.count
        }
        loadSong(currentSongIndex)
        nextSongRequested()
    }
    
    function previousSong() {
        currentSongIndex = (currentSongIndex - 1 + playlist.count) % playlist.count
        loadSong(currentSongIndex)
        previousSongRequested()
    }
    
    function seek(position) {
        progress = position
        currentPosition = Math.floor(position * currentDuration)
        seekRequested(position)
    }
    
    // ========== 音量控制 ==========
    function setVolume(vol) {
        volume = Math.max(0, Math.min(100, vol))
        volumeAdjusted(volume)
    }
    
    function toggleMute() {
        isMuted = !isMuted
    }
    
    // ========== 交互方法 ==========
    function toggleLike() {
        isLiked = !isLiked
        if (isLiked) {
            likeCount++
        } else {
            likeCount--
        }
    }
    
    function toggleShuffle() {
        isShuffleMode = !isShuffleMode
    }
    
    function cycleRepeatMode() {
        if (repeatMode === "off") {
            repeatMode = "all"
        } else if (repeatMode === "all") {
            repeatMode = "one"
        } else {
            repeatMode = "off"
        }
    }
    
    // ========== 播放列表管理 ==========
    function loadSong(index) {
        if (index >= 0 && index < playlist.count) {
            currentSongIndex = index
            var song = playlist.get(index)
            currentSongName = song.songName
            currentArtistName = song.artistName
            currentDuration = song.duration
            currentPosition = 0
            progress = 0
            songChanged(index)
        }
    }
    
    function addToPlaylist(songName, artistName, duration) {
        playlist.append({
            songName: songName,
            artistName: artistName,
            duration: duration || 180
        })
    }
    
    function removeFromPlaylist(index) {
        if (index >= 0 && index < playlist.count) {
            playlist.remove(index)
        }
    }
    
    function clearPlaylist() {
        playlist.clear()
    }
    
    // ========== 音质控制 ==========
    function setQuality(quality) {
        currentQuality = quality
        qualityChanged(quality)
    }
    
    // ========== 更多菜单选项 ==========
    property ListModel moreMenuOptions: ListModel {
        ListElement {
            menuId: "download"
            icon: "⬇"
            text: "下载"
            showDivider: true
        }
        ListElement {
            menuId: "share"
            icon: "↻"
            text: "分享"
            showDivider: true
        }
        ListElement {
            menuId: "listen_together"
            icon: "👥"
            text: "一起听"
            showDivider: true
        }
        ListElement {
            menuId: "artist"
            icon: "👤"
            text: "歌手"
            dynamicText: true  // 表示文字需要动态生成
            showDivider: true
        }
        ListElement {
            menuId: "album"
            icon: "💿"
            text: "专辑"
            dynamicText: true  // 表示文字需要动态生成
            showDivider: true
        }
        ListElement {
            menuId: "sound_effect"
            icon: "🎵"
            text: "音效"
            showDivider: true
        }
        ListElement {
            menuId: "buy_song"
            icon: "🛒"
            text: "购买单曲"
            showDivider: true
            isLastInGroup: true  // 标记为组的最后一项
        }
        ListElement {
            menuId: "reduce_recommend"
            icon: "🚫"
            text: "减少推荐"
            showDivider: false
        }
    }
    
    // 获取动态菜单文字
    function getMenuText(menuId) {
        if (menuId === "artist") {
            // 只显示第一个歌手名，去掉 " / " 后面的部分
            var artistName = currentArtistName
            var slashIndex = artistName.indexOf(" / ")
            if (slashIndex > 0) {
                artistName = artistName.substring(0, slashIndex)
            }
            return "歌手: " + artistName
        } else if (menuId === "album") {
            return "专辑: " + currentSongName
        }
        return ""
    }
    
    // 处理更多菜单点击
    function handleMoreMenuAction(menuId) {
        console.log("更多菜单操作:", menuId)
        moreMenuActionTriggered(menuId)
    }
    
    signal moreMenuActionTriggered(string menuId)
    
    // ========== 进度更新定时器 ==========
    property Timer progressTimer: Timer {
        interval: 100
        running: viewModel.isPlaying
        repeat: true
        onTriggered: {
            if (viewModel.progress < 1.0) {
                viewModel.progress += 0.001
                viewModel.currentPosition = Math.floor(viewModel.progress * viewModel.currentDuration)
            } else {
                // 歌曲播放完毕
                if (viewModel.repeatMode === "one") {
                    viewModel.progress = 0
                    viewModel.currentPosition = 0
                } else if (viewModel.repeatMode === "all") {
                    viewModel.nextSong()
                } else {
                    viewModel.pause()
                }
            }
        }
    }
}
