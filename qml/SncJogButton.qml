import QtQuick
import QtQuick.Controls
import Snc.Ui

Button {
    id: root

    signal jogTriggered()

    property int initialDelay:   400
    property int repeatInterval: 80

    Theme { id: theme }

    implicitWidth:  52
    implicitHeight: 52
    font.pixelSize: 14
    focusPolicy:    Qt.NoFocus

    onPressed: {
        jogTriggered()
        holdTimer.restart()
    }
    onReleased: { holdTimer.stop(); repeatTimer.stop() }
    onCanceled: { holdTimer.stop(); repeatTimer.stop() }

    Timer {
        id:       holdTimer
        interval: root.initialDelay
        repeat:   false
        onTriggered: repeatTimer.start()
    }

    Timer {
        id:       repeatTimer
        interval: root.repeatInterval
        repeat:   true
        onTriggered: root.jogTriggered()
    }

    background: Rectangle {
        radius:       theme.radiusMd
        border.width: 1
        border.color: root.down ? theme.yellow : theme.border
        color:        root.down    ? Qt.rgba(theme.yellow.r, theme.yellow.g, theme.yellow.b, 0.12)
                    : root.hovered ? theme.buttonBgHover
                    :                theme.buttonBg

        Behavior on color        { ColorAnimation { duration: 80 } }
        Behavior on border.color { ColorAnimation { duration: 80 } }
    }

    contentItem: Text {
        text:               root.text
        color:              root.down ? theme.yellow : theme.textPrimary
        font:               root.font
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment:  Text.AlignVCenter

        Behavior on color { ColorAnimation { duration: 80 } }
    }
}
