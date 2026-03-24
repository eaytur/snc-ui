import QtQuick
import QtQuick.Controls
import Snc.Ui

Slider {
    id: root

    property color trackColor: theme.orange
    property bool  handleVisible: false

    Theme { id: theme }

    implicitWidth:  200
    implicitHeight: 20
    focusPolicy: Qt.NoFocus

    background: Item {
        x: root.leftPadding
        y: root.topPadding + (root.availableHeight - height) / 2
        width:  root.availableWidth
        height: 20

        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            width:  parent.width
            height: 4
            radius: 2
            color:  theme.border
        }

        Rectangle {
            anchors.verticalCenter: parent.verticalCenter
            width:  root.visualPosition * parent.width
            height: 4
            radius: 2
            color:  root.trackColor
        }
    }

    handle: Rectangle {
        x: root.leftPadding + root.visualPosition * (root.availableWidth - width)
        y: root.topPadding  + (root.availableHeight - height) / 2
        width:  root.handleVisible ? 14 : 0
        height: root.handleVisible ? 14 : 0
        radius: 7
        color:  root.trackColor
        visible: root.handleVisible

        Rectangle {
            anchors.centerIn: parent
            width:   parent.width + 8
            height:  parent.height + 8
            radius:  (parent.width + 8) / 2
            color:   "transparent"
            border.color: Qt.rgba(root.trackColor.r, root.trackColor.g, root.trackColor.b, 0.35)
            border.width: 3
        }
    }
}
