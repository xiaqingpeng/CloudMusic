import QtQuick
import QtQuick.Window

import "./leftpage"

import "./righpage"

import "./bottompage"

import "./commonui"

MyWindowRect {
    id: window

    MyLeftRect {
        id: leftRect
        anchors.bottom: parent.bottom
        anchors.top: parent.top
    }

    MyRightRect {
        id: rightRect
        anchors.bottom: bottomRect.top
        anchors.left: leftRect.right
        anchors.right: parent.right
        anchors.top: parent.top
    }

    MyBottomRect {
        id: bottomRect
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
    }
}
