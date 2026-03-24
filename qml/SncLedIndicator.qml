import QtQuick
import Snc.Ui

Item {
    id: root

    property bool   active:        true
    property color  ledColor:      theme.yellow
    property int    ledSize:       10
    property string text:          ""
    property string labelPosition: "right"

    Theme { id: theme }

    implicitWidth:  labelPosition === "right"
                        ? ledSize + (text !== "" ? 8 + lbl.implicitWidth : 0)
                        : Math.max(ledSize, lbl.implicitWidth)
    implicitHeight: labelPosition === "right"
                        ? Math.max(ledSize, lbl.implicitHeight)
                        : ledSize + (text !== "" ? 5 + lbl.implicitHeight : 0)

    Rectangle {
        anchors.centerIn: dot
        width:        dot.width  + 10
        height:       dot.height + 10
        radius:       (dot.width + 10) / 2
        color:        "transparent"
        border.width: 3
        border.color: root.active
                          ? Qt.rgba(root.ledColor.r, root.ledColor.g, root.ledColor.b, 0.35)
                          : "transparent"

        Behavior on border.color { ColorAnimation { duration: 200 } }
    }

    Rectangle {
        id:     dot
        width:  root.ledSize
        height: root.ledSize
        radius: root.ledSize / 2
        color:  root.active ? root.ledColor : theme.border

        x: labelPosition === "right" ? 0 : (root.width  - width)  / 2
        y: labelPosition === "right" ? (root.height - height) / 2 : 0

        Behavior on color { ColorAnimation { duration: 200 } }
    }

    Text {
        id:             lbl
        visible:        root.text !== ""
        text:           root.text
        color:          root.active ? theme.textSecondary : theme.textMuted
        font.pixelSize: 13

        x: labelPosition === "right" ? dot.x + dot.width + 8
                                     : (root.width - implicitWidth) / 2
        y: labelPosition === "right" ? (root.height - implicitHeight) / 2
                                     : dot.y + dot.height + 5

        Behavior on color { ColorAnimation { duration: 200 } }
    }
}
