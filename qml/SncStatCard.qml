import QtQuick
import Snc.Ui

Rectangle {
    id: root

    property string label:          "LABEL"
    property string value:          "0"
    property string unit:           ""
    property real   progress:       -1
    property color  indicatorColor: theme.yellow

    Theme { id: theme }

    implicitWidth:  160
    implicitHeight: 90
    color:          theme.surface
    border.color:   theme.border
    border.width:   1
    radius:         theme.radiusMd

    Text {
        id: captionText
        anchors {
            top:       parent.top
            left:      parent.left
            margins:   14
            topMargin: 12
        }
        text:                root.label
        color:               theme.textMuted
        font.pixelSize:      11
        font.capitalization: Font.AllUppercase
        font.letterSpacing:  0.8
    }

    Row {
        anchors {
            top:        captionText.bottom
            left:       parent.left
            leftMargin: 14
            topMargin:  4
        }
        spacing: 5

        Text {
            text:           root.value
            color:          theme.textPrimary
            font.pixelSize: 26
            font.bold:      true
            anchors.baseline: unitText.baseline
        }

        Text {
            id: unitText
            text:           root.unit
            color:          theme.textSecondary
            font.pixelSize: 13
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 3
            visible:        root.unit !== ""
        }
    }

    Item {
        visible: root.progress >= 0
        anchors {
            right:       parent.right
            bottom:      parent.bottom
            rightMargin: 14
            bottomMargin: 12
        }
        width:  56
        height: 4

        Rectangle {
            anchors.fill: parent
            radius:       2
            color:        theme.border
        }

        Rectangle {
            width:  Math.max(0, Math.min(1, root.progress)) * parent.width
            height: parent.height
            radius: 2
            color:  root.indicatorColor
        }
    }
}
