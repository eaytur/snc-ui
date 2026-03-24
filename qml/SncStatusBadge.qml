import QtQuick
import Snc.Ui

Rectangle {
    id: root

    property string text:       "Ready"
    property color  badgeColor: theme.yellow

    Theme { id: theme }

    implicitWidth:  label.implicitWidth + 24
    implicitHeight: 30
    radius:         height / 2
    color:          Qt.rgba(badgeColor.r, badgeColor.g, badgeColor.b, 0.12)
    border.color:   badgeColor
    border.width:   1

    Text {
        id: label
        anchors.centerIn: parent
        text:             root.text
        color:            root.badgeColor
        font.pixelSize:   13
        font.bold:        true
    }
}
