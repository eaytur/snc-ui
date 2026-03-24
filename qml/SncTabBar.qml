import QtQuick
import Snc.Ui

Item {
    id: root

    property var model:        []
    property int currentIndex: 0

    signal tabClicked(int index)

    Theme { id: theme }

    implicitHeight: 36

    Row {
        id: tabRow
        height: root.height

        Repeater {
            model: root.model

            delegate: Item {
                width:  tabLabel.implicitWidth + 28
                height: root.height

                Text {
                    id:                tabLabel
                    anchors.centerIn:  parent
                    anchors.verticalCenterOffset: -1
                    text:              modelData
                    font.pixelSize:    13
                    color:             index === root.currentIndex
                                           ? theme.yellow : theme.textMuted

                    Behavior on color { ColorAnimation { duration: 150 } }
                }

                Rectangle {
                    anchors.bottom:            parent.bottom
                    anchors.horizontalCenter:  parent.horizontalCenter
                    height: 2
                    radius: 1
                    color:  theme.yellow
                    width:  index === root.currentIndex ? parent.width - 12 : 0

                    Behavior on width {
                        NumberAnimation { duration: 180; easing.type: Easing.InOutQuad }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        root.currentIndex = index
                        root.tabClicked(index)
                    }
                }
            }
        }
    }

    Rectangle {
        anchors.bottom: parent.bottom
        width:  parent.width
        height: 1
        color:  theme.border
    }
}
