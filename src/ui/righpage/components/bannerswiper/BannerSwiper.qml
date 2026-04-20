import QtQuick
import QtQuick.Controls

Rectangle {
    height: 180
    color: "#ddd"
    radius: 9
    clip: true

    SwipeView {
        id: swipeView
        anchors.fill: parent

        Repeater {
            model: 3
            delegate: Rectangle {
                color: "#eee"

                Column {
                    anchors.centerIn: parent
                    spacing: 8

                    Image {
                        anchors.horizontalCenter: parent.horizontalCenter
                        width: 80
                        height: 80
                        source: "qrc:/CloudMusic/src/resources/report.png"
                        fillMode: Image.PreserveAspectFit
                    }

                    Text {
                        text: "Banner " + (index+1)
                        anchors.horizontalCenter: parent.horizontalCenter
                        font.bold: true
                        font.pixelSize: 14
                    }
                }
            }
        }
    }

    PageIndicator {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        count: 3
        currentIndex: 0
    }

    Timer {
        running:true; interval:3000; repeat:true
        onTriggered: swipeView.currentIndex = (swipeView.currentIndex+1)%3
    }
}
