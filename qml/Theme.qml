import QtQuick

QtObject {
    readonly property bool _dark: ThemeMode.current === "dark"

    readonly property color background:  _dark ? "#0B0F14" : "#F0F2F5"
    readonly property color surface:     _dark ? "#1A1D21" : "#FFFFFF"
    readonly property color surfaceAlt:  _dark ? "#22262D" : "#F5F7FA"
    readonly property color border:      _dark ? "#343A40" : "#DEE2E8"

    readonly property color textPrimary:   _dark ? "#F5F7FA" : "#111318"
    readonly property color textSecondary: _dark ? "#A7B0BA" : "#4A5568"
    readonly property color textMuted:     _dark ? "#7D8794" : "#718096"

    readonly property color yellow: _dark ? "#FFD400" : "#CC9E00"
    readonly property color amber:  _dark ? "#FFC300" : "#B88A00"
    readonly property color orange: _dark ? "#FF8C00" : "#CC6A00"
    readonly property color accent: _dark ? "#FF5F00" : "#CC4400"

    readonly property int radiusSm: 8
    readonly property int radiusMd: 12
    readonly property int radiusLg: 16

    readonly property color buttonBg:        _dark ? "#22262D" : "#FFFFFF"
    readonly property color buttonBgHover:   _dark ? "#2A2F36" : "#F0F2F5"
    readonly property color buttonBgPressed: _dark ? "#23282F" : "#E8EBF0"
    readonly property color buttonBorder:    border
    readonly property color buttonText:      textPrimary

    readonly property color buttonAccentBg:        _dark ? "#FFD400" : "#CC9E00"
    readonly property color buttonAccentBgHover:   _dark ? "#FFE04A" : "#D9AC00"
    readonly property color buttonAccentBgPressed: _dark ? "#E6BE00" : "#B88A00"
    readonly property color buttonAccentBorder:    _dark ? "#E0B800" : "#A87E00"
    readonly property color buttonAccentText:      "#111111"
}
