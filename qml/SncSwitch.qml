import QtQuick
import QtQuick.Controls
import Snc.Ui

Switch {
    id: root

    property string labelPosition: "right"

    Theme { id: theme }

    font.pixelSize:  14
    focusPolicy:     Qt.NoFocus

    topPadding:    labelPosition === "top"    ? extraLabel.implicitHeight + 6 : 0
    bottomPadding: labelPosition === "bottom" ? extraLabel.implicitHeight + 6 : 0

    LayoutMirroring.enabled:       labelPosition === "left"
    LayoutMirroring.childrenInherit: false

    indicator: Rectangle {
        id: track
        x:      root.leftPadding
        y:      root.topPadding + (root.availableHeight - height) / 2
        width:  56
        height: 28
        radius: 14
        color:  root.checked
                    ? Qt.rgba(theme.yellow.r, theme.yellow.g, theme.yellow.b, 0.18)
                    : theme.surfaceAlt
        border.width: 1
        border.color: root.checked ? theme.yellow : theme.border

        Behavior on color        { ColorAnimation { duration: 150 } }
        Behavior on border.color { ColorAnimation { duration: 150 } }

        Rectangle {
            x:      root.checked ? parent.width - width - 4 : 4
            y:      (parent.height - height) / 2
            width:  20
            height: 20
            radius: 10
            color:  root.checked ? theme.yellow : theme.textMuted

            Behavior on x     { NumberAnimation { duration: 150; easing.type: Easing.InOutQuad } }
            Behavior on color { ColorAnimation  { duration: 150 } }

            Rectangle {
                anchors.centerIn: parent
                width:   parent.width + 8
                height:  parent.height + 8
                radius:  (parent.width + 8) / 2
                color:   "transparent"
                border.color: root.checked
                    ? Qt.rgba(theme.yellow.r, theme.yellow.g, theme.yellow.b, 0.35)
                    : "transparent"
                border.width: 3

                Behavior on border.color { ColorAnimation { duration: 150 } }
            }
        }
    }

    contentItem: Text {
        visible:       labelPosition === "right" || labelPosition === "left"
        leftPadding:   visible ? track.width + root.spacing : 0
        width:         visible ? implicitWidth : 0
        text:          root.text
        color:             root.checked ? theme.textPrimary : theme.textMuted
        font:              root.font
        verticalAlignment: Text.AlignVCenter

        Behavior on color { ColorAnimation { duration: 150 } }
    }

    Text {
        id:      extraLabel
        visible: labelPosition === "top" || labelPosition === "bottom"
        text:    root.text
        color:   root.checked ? theme.textPrimary : theme.textMuted
        font:    root.font

        x: track.x + (track.width - implicitWidth) / 2

        y: labelPosition === "top"
               ? 0
               : root.height - implicitHeight

        Behavior on color { ColorAnimation { duration: 150 } }
    }
}
