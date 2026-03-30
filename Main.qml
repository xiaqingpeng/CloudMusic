import QtQuick
import QtQuick.Window

Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("NetEase CloudMusic")

    Rectangle{

      id:leftRect

      width:255

      anchors.top: parent.top

      anchors.bottom: parent.bottom

      color: "#1a1a21"


    }

    Rectangle{

      id: rightRect



      anchors.left: leftRect.right

      anchors.right: parent.right

      anchors.top: parent.top

      anchors.bottom: bottomRect.top

      color: "#13131a"


    }

    Rectangle{

      id: bottomRect

      height:100

      anchors.left: parent.left

      anchors.right: parent.right



      anchors.bottom: parent.bottom

      color: "#2d2d37"


    }

}
