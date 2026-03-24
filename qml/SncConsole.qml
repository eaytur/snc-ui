import QtQuick
import QtQuick.Controls
import Snc.Ui

Rectangle {
    id: root

    Theme { id: theme }

    color:        theme.background
    border.color: theme.border
    border.width: 1
    radius:       theme.radiusMd
    clip:         true

    function append(type, message) {
        logModel.append({ entryType: type, entryMessage: message })
        Qt.callLater(() => logView.positionViewAtEnd())
    }

    function clear() {
        logModel.clear()
    }

    ListModel { id: logModel }

    ListView {
        id:             logView
        anchors.fill:   parent
        anchors.margins: 10
        model:          logModel
        clip:           true
        spacing:        3

        ScrollBar.vertical: ScrollBar {
            policy:       ScrollBar.AsNeeded
            width:        6
        }

        delegate: Row {
            spacing: 6
            width:   logView.width

            Text {
                text:           "[" + entryType + "]"
                font.pixelSize: 12
                font.family:    "Courier New"
                font.bold:      true
                color: {
                    switch (entryType) {
                        case "INFO": return theme.textMuted
                        case "CMD":  return theme.textSecondary
                        case "RUN":  return theme.orange
                        case "WARN": return theme.amber
                        case "ERR":  return theme.accent
                        case "OK":   return "#4CAF82"
                        default:     return theme.textMuted
                    }
                }
            }

            Text {
                text:           entryMessage
                color:          theme.textSecondary
                font.pixelSize: 12
                font.family:    "Courier New"
                width:          logView.width - 70
                wrapMode:       Text.WrapAnywhere
            }
        }
    }
}
