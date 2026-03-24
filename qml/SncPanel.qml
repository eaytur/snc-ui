import QtQuick
import Snc.Ui

Rectangle {
    id: root

    default property alias contentData: content.data

    Theme { id: theme }

    color: theme.surface
    border.color: theme.border
    border.width: 1
    radius: theme.radiusLg

    Item {
        id: content
        anchors.fill: parent
        anchors.margins: 16
    }
}
