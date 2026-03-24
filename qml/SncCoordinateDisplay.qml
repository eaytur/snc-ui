import QtQuick
import Snc.Ui

Rectangle {
    id: root

    property string axis:      "X"
    property real   value:     0.0
    property string unit:      "mm"
    property int    decimals:  2
    property color  axisColor: theme.yellow

    Theme { id: theme }

    implicitWidth:  170
    implicitHeight: 72
    color:          theme.surface
    border.color:   theme.border
    border.width:   1
    radius:         theme.radiusMd

    Row {
        anchors {
            left:           parent.left
            verticalCenter: parent.verticalCenter
            leftMargin:     14
        }
        spacing: 12

        Rectangle {
            width:  30
            height: 30
            radius: 7
            color:  Qt.rgba(root.axisColor.r, root.axisColor.g, root.axisColor.b, 0.15)
            border.color: root.axisColor
            border.width: 1
            anchors.verticalCenter: parent.verticalCenter

            Text {
                anchors.centerIn: parent
                text:           root.axis
                color:          root.axisColor
                font.pixelSize: 14
                font.bold:      true
            }
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter
            spacing: 1

            Text {
                text:           root.value.toFixed(root.decimals)
                color:          theme.textPrimary
                font.pixelSize: 22
                font.bold:      true
                font.family:    "Courier New"
            }

            Text {
                text:           root.unit
                color:          theme.textMuted
                font.pixelSize: 11
            }
        }
    }
}
