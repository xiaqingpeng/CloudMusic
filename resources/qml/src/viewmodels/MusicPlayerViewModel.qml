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
    
    // ========== 播放控制方法 ==========
    function play() {
        isPlaying = true
        playRequested()
        console.log("MusicPlayerViewModel: 播放")
    }
    
    function pause() {
        isPlaying = false
        pauseRequested()
        console.log("MusicPlayerViewModel: 暂停")
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
        console.log("MusicPlayerViewModel: 下一首")
    }
    
    function previousSong() {
        currentSongIndex = (currentSongIndex - 1 + playlist.count) % playlist.count
        loadSong(currentSongIndex)
        previousSongRequested()
        console.log("MusicPlayerViewModel: 上一首")
    }
    
    function seek(position) {
        progress = position
        currentPosition = Math.floor(position * currentDuration)
        seekRequested(position)
        console.log("MusicPlayerViewModel: 跳转到", position)
    }
    
    // ========== 音量控制 ==========
    function setVolume(vol) {
        volume = Math.max(0, Math.min(100, vol))
        volumeAdjusted(volume)
        console.log("MusicPlayerViewModel: 音量设置为", volume)
    }
    
    function toggleMute() {
        isMuted = !isMuted
        console.log("MusicPlayerViewModel: 静音", isMuted)
    }
    
    // ========== 交互方法 ==========
    function toggleLike() {
        isLiked = !isLiked
        if (isLiked) {
            likeCount++
        } else {
            likeCount--
        }
        console.log("MusicPlayerViewModel: 点赞", isLiked)
    }
    
    function toggleShuffle() {
        isShuffleMode = !isShuffleMode
        console.log("MusicPlayerViewModel: 随机播放", isShuffleMode)
    }
    
    function cycleRepeatMode() {
        if (repeatMode === "off") {
            repeatMode = "all"
        } else if (repeatMode === "all") {
            repeatMode = "one"
        } else {
            repeatMode = "off"
        }
        console.log("MusicPlayerViewModel: 循环模式", repeatMode)
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
            console.log("MusicPlayerViewModel: 加载歌曲", currentSongName)
        }
    }
    
    function addToPlaylist(songName, artistName, duration) {
        playlist.append({
            songName: songName,
            artistName: artistName,
            duration: duration || 180
        })
        console.log("MusicPlayerViewModel: 添加到播放列表", songName)
    }
    
    function removeFromPlaylist(index) {
        if (index >= 0 && index < playlist.count) {
            playlist.remove(index)
            console.log("MusicPlayerViewModel: 从播放列表移除", index)
        }
    }
    
    function clearPlaylist() {
        playlist.clear()
        console.log("MusicPlayerViewModel: 清空播放列表")
    }
    
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
