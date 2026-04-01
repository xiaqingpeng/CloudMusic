import QtQuick
import QtQuick.Window
import QtQuick.Layouts

import QtQuick.Controls

Image {
    onStatusChanged: {
        if (status === Image.Error) {
            console.log("Failed to load image:", source)
        }
    }
}
