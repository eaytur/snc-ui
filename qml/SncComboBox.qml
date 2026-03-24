import QtQuick
import QtQuick.Controls
import Snc.Ui

ComboBox {
    id: root

    Theme { id: theme }

    implicitWidth:  160
    implicitHeight: 36
    font.pixelSize: 14
    focusPolicy:    Qt.NoFocus

    background: Rectangle {
        radius:       theme.radiusSm
        color:        root.down ? theme.buttonBgPressed
                    : root.hovered ? theme.buttonBgHover
                    : theme.buttonBg
        border.width: 1
        border.color: root.down || root.hovered ? theme.yellow : theme.border

        Behavior on border.color { ColorAnimation { duration: 120 } }
        Behavior on color        { ColorAnimation { duration: 80  } }
    }

    contentItem: Row {
        leftPadding: 10
        spacing:     0

        Text {
            width:              root.availableWidth - arrow.width - 10
            height:             parent.height
            text:               root.displayText
            color:              theme.textPrimary
            font:               root.font
            verticalAlignment:  Text.AlignVCenter
            elide:              Text.ElideRight
        }

        Item {
            id:     arrow
            width:  28
            height: parent.height

            Text {
                anchors.centerIn: parent
                text:             root.popup.visible ? "▲" : "▼"
                color:            root.hovered ? theme.yellow : theme.textMuted
                font.pixelSize:   9

                Behavior on color { ColorAnimation { duration: 120 } }
            }
        }
    }

    popup: Popup {
        y:             root.height + 4
        width:         root.width
        padding:       4
        closePolicy:   Popup.CloseOnEscape | Popup.CloseOnPressOutsideParent

        background: Rectangle {
            radius:       theme.radiusSm
            color:        theme.surfaceAlt
            border.width: 1
            border.color: theme.border
        }

        contentItem: ListView {
            implicitHeight: contentHeight
            model:          root.delegateModel
            clip:           true
            currentIndex:   root.highlightedIndex

            ScrollIndicator.vertical: ScrollIndicator {}
        }
    }

    delegate: ItemDelegate {
        width:          root.width - 8
        height:         36
        font:           root.font
        focusPolicy:    Qt.NoFocus
        highlighted:    root.highlightedIndex === index

        background: Rectangle {
            radius:  theme.radiusSm - 2
            color:   parent.highlighted ? Qt.rgba(theme.yellow.r, theme.yellow.g, theme.yellow.b, 0.12)
                   : parent.hovered     ? theme.buttonBgHover
                   : "transparent"

            Behavior on color { ColorAnimation { duration: 80 } }
        }

        contentItem: Text {
            leftPadding:       6
            text:              modelData
            color:             parent.highlighted ? theme.yellow : theme.textPrimary
            font:              parent.font
            verticalAlignment: Text.AlignVCenter

            Behavior on color { ColorAnimation { duration: 80 } }
        }
    }
}
