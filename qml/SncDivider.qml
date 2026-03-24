import QtQuick
import Snc.Ui

Item {
    id: root

    property string orientation: "horizontal"
    property string text:        ""

    Theme { id: theme }

    implicitWidth:  orientation === "horizontal" ? 200 : 1
    implicitHeight: orientation === "horizontal"
                        ? (text !== "" ? divLabel.implicitHeight + 2 : 1)
                        : 200

    Rectangle {
        visible:          orientation === "horizontal"
        anchors.verticalCenter: parent.verticalCenter
        x:     0
        width: text !== "" ? (parent.width - divLabel.implicitWidth - 16) / 2
                           : parent.width
        height: 1
        color:  theme.border
    }

    Text {
        id:      divLabel
        visible: text !== "" && orientation === "horizontal"
        anchors.centerIn: parent
        text:              root.text
        color:             theme.textMuted
        font.pixelSize:    11
        font.capitalization: Font.AllUppercase
        font.letterSpacing:  0.8
    }

    Rectangle {
        visible: text !== "" && orientation === "horizontal"
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        width:  (parent.width - divLabel.implicitWidth - 16) / 2
        height: 1
        color:  theme.border
    }

    Rectangle {
        visible:          orientation === "vertical"
        anchors.horizontalCenter: parent.horizontalCenter
        width:  1
        height: parent.height
        color:  theme.border
    }
}
