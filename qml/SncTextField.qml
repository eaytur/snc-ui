import QtQuick
import QtQuick.Controls
import Snc.Ui

TextField {
    id: root

    Theme { id: theme }

    implicitWidth:       120
    implicitHeight:      36
    font.pixelSize:      14
    color:               theme.textPrimary
    placeholderTextColor: theme.textMuted
    selectByMouse:       true
    focusPolicy:         Qt.ClickFocus
    leftPadding:         10
    rightPadding:        10

    background: Rectangle {
        radius:       theme.radiusSm
        color:        theme.surfaceAlt
        border.width: 1
        border.color: root.activeFocus ? theme.yellow : theme.border

        Behavior on border.color {
            ColorAnimation { duration: 120 }
        }
    }
}
