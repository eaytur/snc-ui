import QtQuick
import Snc.Ui

Item {
    id: root

    property real   value:    0
    property real   step:     1
    property real   min:     -1e9
    property real   max:      1e9
    property int    decimals: 2
    property string unit:     ""

    Theme { id: theme }

    implicitWidth:  150
    implicitHeight: 36

    function increment() { value = Math.min(max, parseFloat((value + step).toFixed(decimals))) }
    function decrement() { value = Math.max(min, parseFloat((value - step).toFixed(decimals))) }

    Rectangle {
        anchors.fill: parent
        radius:       theme.radiusSm
        color:        theme.surfaceAlt
        border.width: 1
        border.color: minusArea.containsMouse || plusArea.containsMouse
                          ? theme.yellow : theme.border

        Behavior on border.color { ColorAnimation { duration: 120 } }

        Text {
            id:               minusText
            width:            32
            height:           parent.height
            text:             "−"
            color:            minusArea.pressed       ? theme.textPrimary
                            : minusArea.containsMouse ? theme.yellow : theme.textMuted
            font.pixelSize:   18
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment:   Text.AlignVCenter

            Behavior on color { ColorAnimation { duration: 100 } }

            MouseArea {
                id:           minusArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked:    root.decrement()
            }
        }

        Rectangle {
            x:      32
            width:  1
            height: parent.height * 0.5
            anchors.verticalCenter: parent.verticalCenter
            color:  theme.border
        }

        Text {
            anchors.centerIn: parent
            text:             root.value.toFixed(root.decimals)
                              + (root.unit !== "" ? " " + root.unit : "")
            color:            theme.textPrimary
            font.pixelSize:   13
            font.family:      "Courier New"
        }

        Rectangle {
            anchors.right:          plusText.left
            width:                  1
            height:                 parent.height * 0.5
            anchors.verticalCenter: parent.verticalCenter
            color:                  theme.border
        }

        Text {
            id:               plusText
            anchors.right:    parent.right
            width:            32
            height:           parent.height
            text:             "+"
            color:            plusArea.pressed       ? theme.textPrimary
                            : plusArea.containsMouse ? theme.yellow : theme.textMuted
            font.pixelSize:   18
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment:   Text.AlignVCenter

            Behavior on color { ColorAnimation { duration: 100 } }

            MouseArea {
                id:           plusArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked:    root.increment()
            }
        }
    }
}
