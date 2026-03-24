import QtQuick
import QtQuick.Controls
import Snc.Ui

Button {
    id: root

    property bool accent: false

    Theme { id: theme }

    implicitWidth: 120
    implicitHeight: 44
    font.pixelSize: 14
    focusPolicy: Qt.NoFocus

    background: Rectangle {
        anchors.fill: parent
        radius: theme.radiusMd
        border.width: 1
        border.color: root.accent ? theme.buttonAccentBorder : theme.buttonBorder

        color: {
            if (root.accent) {
                if (root.down)    return theme.buttonAccentBgPressed
                if (root.hovered) return theme.buttonAccentBgHover
                return theme.buttonAccentBg
            } else {
                if (root.down)    return theme.buttonBgPressed
                if (root.hovered) return theme.buttonBgHover
                return theme.buttonBg
            }
        }
    }

    contentItem: Text {
        text: root.text
        color: root.accent ? theme.buttonAccentText : theme.buttonText
        font: root.font
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }
}
