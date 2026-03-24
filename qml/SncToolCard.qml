import QtQuick
import Snc.Ui

Rectangle {
    id: root

    property string name:         "Layer"
    property color  dotColor:     theme.yellow
    property bool   layerVisible: true

    signal visibilityToggled(bool visible)

    Theme { id: theme }

    implicitWidth:  240
    implicitHeight: 44
    radius:         theme.radiusSm
    color:          hoverArea.containsMouse ? theme.surfaceAlt : "transparent"

    Behavior on color { ColorAnimation { duration: 100 } }

    MouseArea {
        id:           hoverArea
        anchors.fill: parent
        hoverEnabled: true
        onClicked: {
            root.layerVisible = !root.layerVisible
            root.visibilityToggled(root.layerVisible)
        }
    }

    Rectangle {
        id:     colorDot
        width:  10
        height: 10
        radius: 5
        color:  root.dotColor
        anchors {
            left:           parent.left
            leftMargin:     12
            verticalCenter: parent.verticalCenter
        }

        Rectangle {
            anchors.centerIn: parent
            width:   parent.width  + 6
            height:  parent.height + 6
            radius:  (parent.width + 6) / 2
            color:   "transparent"
            border.color: Qt.rgba(root.dotColor.r, root.dotColor.g, root.dotColor.b, 0.3)
            border.width: 2
        }
    }

    Text {
        anchors {
            left:           colorDot.right
            leftMargin:     10
            verticalCenter: parent.verticalCenter
        }
        text:           root.name
        color:          root.layerVisible ? theme.textPrimary : theme.textMuted
        font.pixelSize: 14

        Behavior on color { ColorAnimation { duration: 150 } }
    }

    Text {
        anchors {
            right:          parent.right
            rightMargin:    12
            verticalCenter: parent.verticalCenter
        }
        text:           root.layerVisible ? "Visible" : "Hidden"
        color:          root.layerVisible ? theme.textMuted : theme.border
        font.pixelSize: 12

        Behavior on color { ColorAnimation { duration: 150 } }
    }
}
