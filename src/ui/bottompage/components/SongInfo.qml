import QtQuick

// 歌曲信息组件
Column {
    spacing: 8
    
    property string songName: "栖息地"
    property string artistName: "Mikey-18 / 暴躁的兔子"
    
    Text {
        text: songName
        font.pixelSize: 16
        font.bold: true
        color: "#ffffff"
    }
    
    Text {
        text: artistName
        font.pixelSize: 12
        color: "#999999"
    }
}
