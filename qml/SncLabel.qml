import QtQuick
import Snc.Ui

Text {
    id: root

    property string variant: "section"

    Theme { id: theme }

    color: {
        switch (variant) {
            case "section": return theme.yellow
            case "caption": return theme.textMuted
            default:        return theme.textPrimary
        }
    }

    font.pixelSize: {
        switch (variant) {
            case "section": return 13
            case "caption": return 11
            case "title":   return 28
            case "value":   return 26
            default:        return 14
        }
    }

    font.bold: (variant === "title" || variant === "value")

    font.capitalization: (variant === "section" || variant === "caption")
        ? Font.AllUppercase
        : Font.MixedCase

    font.letterSpacing: (variant === "section") ? 0.4
                      : (variant === "caption")  ? 0.8
                      : 0
}
