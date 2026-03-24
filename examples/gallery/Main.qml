import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import Snc.Ui

Window {
    width:   1100
    height:  760
    visible: true
    title:   "snc-ui gallery"

    Theme { id: theme }
    color: theme.background

    property real  simT:          0
    property real  jobProgress:   0.12
    property real  xPos:          45.0
    property real  yPos:          32.0
    property real  feedRate:      0.72
    property real  bufferLoad:    0.28
    property real  spindleVal:    0.45
    property bool  limitX:        false
    property bool  limitY:        false
    property bool  probeActive:   true
    property bool  spindleOn:     true
    property int   statusIndex:   1

    readonly property var statusLabels: ["Ready", "Running", "Paused", "Alarm"]
    readonly property var statusColors: [theme.yellow, theme.orange, theme.amber, theme.accent]

    Timer {
        interval: 50
        running:  true
        repeat:   true
        onTriggered: {
            simT += 0.05

            jobProgress = Math.min(1.0, jobProgress + 0.0008)
            if (jobProgress >= 1.0) jobProgress = 0.0

            xPos = 80 + 60 * Math.sin(simT * 0.7)
            yPos = 55 + 40 * Math.sin(simT * 1.1)

            feedRate = Math.max(0.1, Math.min(1.0,
                0.68 + 0.18 * Math.sin(simT * 0.4) + (Math.random() - 0.5) * 0.04))

            bufferLoad = Math.max(0.05, Math.min(0.95,
                0.3 + 0.15 * Math.sin(simT * 0.9 + 1.2) + (Math.random() - 0.5) * 0.06))

            spindleVal = Math.max(0.1, Math.min(1.0,
                0.5 + 0.3 * Math.sin(simT * 0.3)))

            feedSpark.addValue(feedRate)
            bufferSpark.addValue(bufferLoad)
            spindleSpark.addValue(spindleVal)
        }
    }

    Timer {
        interval: 2200
        running:  true
        repeat:   true
        property int tick: 0
        onTriggered: {
            tick++

            if (tick % 6 === 0) statusIndex = (statusIndex + 1) % 4

            limitX = (Math.random() < 0.15)
            limitY = (Math.random() < 0.1)

            var msgs = [
                ["CMD",  "G0 X" + xPos.toFixed(2) + " Y" + yPos.toFixed(2) + " F2500"],
                ["INFO", "Buffer load: " + Math.round(bufferLoad * 100) + "%"],
                ["RUN",  "Job progress: " + Math.round(jobProgress * 100) + "%"],
                ["WARN", limitX ? "Soft limit triggered on X axis" : "Feed rate adjusted"],
                ["OK",   "Planner buffer stable"],
                ["CMD",  "M3 S" + Math.round(spindleVal * 1000)],
            ]
            var m = msgs[tick % msgs.length]
            demoConsole.append(m[0], m[1])
        }
    }

    Flickable {
        anchors.fill:    parent
        anchors.margins: 24
        contentWidth:    width
        contentHeight:   mainColumn.implicitHeight + 48
        clip:            true

        ColumnLayout {
            id:      mainColumn
            width:   parent.width
            spacing: 24

            RowLayout {
                spacing: 12
                SncLabel { text: "snc-ui"; variant: "title" }
                SncLabel { text: "·"; variant: "title"; color: theme.textMuted }
                SncLabel { text: "component gallery"; variant: "title"; font.bold: false; color: theme.textSecondary }

                Item { Layout.fillWidth: true }

                SncStatusBadge {
                    text:        statusLabels[statusIndex]
                    badgeColor:  statusColors[statusIndex]
                }
                SncStatusBadge { text: "COM4 · Connected"; badgeColor: theme.textSecondary }

                SncButton {
                    text: ThemeMode.current === "dark" ? "Light Mode" : "Dark Mode"
                    onClicked: ThemeMode.current = (ThemeMode.current === "dark" ? "light" : "dark")
                }
            }

            SncPanel {
                Layout.fillWidth: true
                implicitHeight:   labelSection.implicitHeight + 32
                ColumnLayout {
                    id: labelSection; width: parent.width; spacing: 12
                    SncLabel { text: "SncLabel"; variant: "section" }
                    GridLayout {
                        columns: 2; rowSpacing: 10; columnSpacing: 32
                        SncLabel { text: "section variant"; variant: "section" }
                        SncLabel { text: "caption variant"; variant: "caption" }
                        SncLabel { text: "title variant";   variant: "title" }
                        SncLabel { text: "default variant" }
                        SncLabel { text: "value: " + xPos.toFixed(2); variant: "value" }
                        SncLabel { text: "custom color"; color: theme.accent; font.pixelSize: 14 }
                    }
                }
            }

            SncPanel {
                Layout.fillWidth: true
                implicitHeight:   buttonSection.implicitHeight + 32
                ColumnLayout {
                    id: buttonSection; width: parent.width; spacing: 12
                    SncLabel { text: "SncButton"; variant: "section" }
                    RowLayout {
                        spacing: 10
                        SncButton { text: "Default" }
                        SncButton { text: "Unlock" }
                        SncButton { text: "Home All";  accent: true }
                        SncButton { text: "Start Job"; accent: true }
                        SncButton { text: "Stop";      accent: true }
                    }
                }
            }

            SncPanel {
                Layout.fillWidth: true
                implicitHeight:   badgeSection.implicitHeight + 32
                ColumnLayout {
                    id: badgeSection; width: parent.width; spacing: 12
                    SncLabel { text: "SncStatusBadge"; variant: "section" }
                    RowLayout {
                        spacing: 10
                        SncStatusBadge { text: statusLabels[0]; badgeColor: statusColors[0] }
                        SncStatusBadge { text: statusLabels[1]; badgeColor: statusColors[1] }
                        SncStatusBadge { text: statusLabels[2]; badgeColor: statusColors[2] }
                        SncStatusBadge { text: statusLabels[3]; badgeColor: statusColors[3] }
                        SncStatusBadge {
                            text:       statusLabels[statusIndex] + " ← live"
                            badgeColor: statusColors[statusIndex]
                        }
                    }
                }
            }

            SncPanel {
                Layout.fillWidth: true
                implicitHeight:   sliderSection.implicitHeight + 32
                ColumnLayout {
                    id: sliderSection; width: parent.width; spacing: 16
                    SncLabel { text: "SncSlider"; variant: "section" }
                    ColumnLayout {
                        spacing: 14
                        ColumnLayout {
                            spacing: 6
                            SncLabel { text: "Feed Rate  " + Math.round(feedRate * 100) + "%"; variant: "caption" }
                            SncSlider { Layout.fillWidth: true; value: feedRate; trackColor: theme.orange }
                        }
                        ColumnLayout {
                            spacing: 6
                            SncLabel { text: "Spindle / Pen Pressure  " + Math.round(spindleVal * 100) + "%"; variant: "caption" }
                            SncSlider { Layout.fillWidth: true; value: spindleVal; trackColor: theme.accent }
                        }
                        ColumnLayout {
                            spacing: 6
                            SncLabel { text: "Buffer Load (handle)  " + Math.round(bufferLoad * 100) + "%"; variant: "caption" }
                            SncSlider { Layout.fillWidth: true; value: bufferLoad; trackColor: theme.yellow; handleVisible: true }
                        }
                    }
                }
            }

            SncPanel {
                Layout.fillWidth: true
                implicitHeight:   comboSection.implicitHeight + 32
                ColumnLayout {
                    id: comboSection; width: parent.width; spacing: 12
                    SncLabel { text: "SncComboBox"; variant: "section" }
                    RowLayout {
                        spacing: 12
                        ColumnLayout {
                            spacing: 6
                            SncLabel { text: "Tool / Pen"; variant: "caption" }
                            SncComboBox { model: ["Pen 0.4mm", "Pen 0.8mm", "Marker", "Engraver"] }
                        }
                        ColumnLayout {
                            spacing: 6
                            SncLabel { text: "Units"; variant: "caption" }
                            SncComboBox { model: ["mm", "inch"]; implicitWidth: 100 }
                        }
                        ColumnLayout {
                            spacing: 6
                            SncLabel { text: "Serial Port"; variant: "caption" }
                            SncComboBox { model: ["COM3", "COM4", "COM5", "COM6"]; currentIndex: 1; implicitWidth: 120 }
                        }
                    }
                }
            }

            SncPanel {
                Layout.fillWidth: true
                implicitHeight:   statSection.implicitHeight + 32
                ColumnLayout {
                    id: statSection; width: parent.width; spacing: 12
                    SncLabel { text: "SncStatCard"; variant: "section" }
                    RowLayout {
                        spacing: 10
                        SncStatCard {
                            label: "X Position"
                            value: xPos.toFixed(2); unit: "mm"
                            progress: xPos / 200.0; indicatorColor: theme.yellow
                        }
                        SncStatCard {
                            label: "Y Position"
                            value: yPos.toFixed(2); unit: "mm"
                            progress: yPos / 120.0; indicatorColor: theme.yellow
                        }
                        SncStatCard {
                            label: "Job Progress"
                            value: Math.round(jobProgress * 100).toString(); unit: "%"
                            progress: jobProgress; indicatorColor: theme.orange
                        }
                        SncStatCard {
                            label: "Buffer Load"
                            value: Math.round(bufferLoad * 100).toString(); unit: "%"
                            progress: bufferLoad; indicatorColor: theme.accent
                        }
                        SncStatCard {
                            label: "Feed Rate"
                            value: Math.round(feedRate * 100).toString(); unit: "%"
                            progress: feedRate; indicatorColor: theme.amber
                        }
                    }
                }
            }

            SncPanel {
                Layout.fillWidth: true
                implicitHeight:   fieldSection.implicitHeight + 32
                ColumnLayout {
                    id: fieldSection; width: parent.width; spacing: 12
                    SncLabel { text: "SncTextField"; variant: "section" }
                    RowLayout {
                        spacing: 12
                        ColumnLayout {
                            spacing: 6
                            SncLabel { text: "Step"; variant: "caption" }
                            SncTextField { text: "1.00 mm"; implicitWidth: 100 }
                        }
                        ColumnLayout {
                            spacing: 6
                            SncLabel { text: "Speed"; variant: "caption" }
                            SncTextField { text: "2500"; implicitWidth: 100 }
                        }
                        ColumnLayout {
                            spacing: 6
                            SncLabel { text: "G-Code command"; variant: "caption" }
                            SncTextField { placeholderText: "e.g. G28 ; home all axes"; implicitWidth: 260 }
                        }
                    }
                }
            }

            SncPanel {
                Layout.fillWidth: true
                implicitHeight:   switchSection.implicitHeight + 32
                ColumnLayout {
                    id: switchSection; width: parent.width; spacing: 12
                    SncLabel { text: "SncSwitch"; variant: "section" }
                    GridLayout {
                        columns: 4; rowSpacing: 20; columnSpacing: 32
                        SncLabel { text: "right (default)"; variant: "caption"; Layout.columnSpan: 4 }
                        SncSwitch { text: "Grid On";     checked: true;  labelPosition: "right" }
                        SncSwitch { text: "Soft Limits"; checked: false; labelPosition: "right" }
                        SncSwitch { text: "Laser Mode";  checked: false; labelPosition: "right" }
                        SncSwitch { text: "Auto Home";   checked: spindleOn; labelPosition: "right" }
                        SncLabel { text: "top / bottom"; variant: "caption"; Layout.columnSpan: 4 }
                        SncSwitch { text: "Grid On";     checked: true;  labelPosition: "top" }
                        SncSwitch { text: "Soft Limits"; checked: false; labelPosition: "top" }
                        SncSwitch { text: "Laser Mode";  checked: false; labelPosition: "bottom" }
                        SncSwitch { text: "Spindle";     checked: spindleOn; labelPosition: "bottom" }
                    }
                }
            }

            SncPanel {
                Layout.fillWidth: true
                implicitHeight:   divSection.implicitHeight + 32
                ColumnLayout {
                    id: divSection; width: parent.width; spacing: 16
                    SncLabel { text: "SncDivider"; variant: "section" }
                    SncDivider { Layout.fillWidth: true }
                    SncDivider { Layout.fillWidth: true; text: "Machine Controls" }
                    SncDivider { Layout.fillWidth: true; text: "or" }
                }
            }

            SncPanel {
                Layout.fillWidth: true
                implicitHeight:   tabSection.implicitHeight + 32
                ColumnLayout {
                    id: tabSection; width: parent.width; spacing: 16
                    SncLabel { text: "SncTabBar"; variant: "section" }
                    SncTabBar {
                        Layout.fillWidth: true
                        model: ["Overview", "G-Code", "Layers", "Settings"]
                    }
                    SncTabBar {
                        Layout.fillWidth: true
                        model: ["Absolute", "Relative", "Machine"]
                        currentIndex: 1
                    }
                }
            }

            SncPanel {
                Layout.fillWidth: true
                implicitHeight:   ledSection.implicitHeight + 32
                ColumnLayout {
                    id: ledSection; width: parent.width; spacing: 16
                    SncLabel { text: "SncLedIndicator"; variant: "section" }
                    RowLayout {
                        spacing: 24
                        SncLedIndicator { text: "Limit X";   active: limitX;     ledColor: theme.accent }
                        SncLedIndicator { text: "Limit Y";   active: limitY;     ledColor: theme.accent }
                        SncLedIndicator { text: "Probe";     active: probeActive; ledColor: theme.yellow }
                        SncLedIndicator { text: "Door";      active: false;      ledColor: theme.orange }
                        SncLedIndicator { text: "Spindle";   active: spindleOn;  ledColor: "#4CAF82" }
                        SncLedIndicator { text: "Connected"; active: true;       ledColor: theme.yellow; ledSize: 14 }
                    }
                }
            }

            SncPanel {
                Layout.fillWidth: true
                implicitHeight:   circSection.implicitHeight + 32
                ColumnLayout {
                    id: circSection; width: parent.width; spacing: 12
                    SncLabel { text: "SncCircularProgress"; variant: "section" }
                    RowLayout {
                        spacing: 20
                        SncCircularProgress { value: jobProgress;  progressColor: theme.yellow; implicitWidth: 90;  implicitHeight: 90 }
                        SncCircularProgress { value: bufferLoad;   progressColor: theme.accent; implicitWidth: 80;  implicitHeight: 80 }
                        SncCircularProgress { value: feedRate;     progressColor: theme.orange; implicitWidth: 100; implicitHeight: 100; strokeWidth: 9 }
                        SncCircularProgress { value: spindleVal;   progressColor: "#4CAF82";    implicitWidth: 70;  implicitHeight: 70; strokeWidth: 5 }
                        SncCircularProgress { value: xPos / 200.0; progressColor: theme.amber;  implicitWidth: 70;  implicitHeight: 70 }
                    }
                }
            }

            SncPanel {
                Layout.fillWidth: true
                implicitHeight:   gaugeSection.implicitHeight + 32
                ColumnLayout {
                    id: gaugeSection; width: parent.width; spacing: 12
                    SncLabel { text: "SncGauge"; variant: "section" }
                    RowLayout {
                        spacing: 24
                        SncGauge { value: feedRate;   label: "Feed Rate";   gaugeColor: theme.orange; implicitWidth: 120; implicitHeight: 120 }
                        SncGauge { value: bufferLoad; label: "Buffer Load"; gaugeColor: theme.accent; implicitWidth: 120; implicitHeight: 120 }
                        SncGauge { value: spindleVal; label: "Spindle";     gaugeColor: theme.yellow; implicitWidth: 120; implicitHeight: 120 }
                        SncGauge { value: jobProgress; label: "Job";        gaugeColor: "#4CAF82";    implicitWidth: 100; implicitHeight: 100 }
                    }
                }
            }

            SncPanel {
                Layout.fillWidth: true
                implicitHeight:   sparkSection.implicitHeight + 32
                ColumnLayout {
                    id: sparkSection; width: parent.width; spacing: 12
                    SncLabel { text: "SncSparkline  (live)"; variant: "section" }
                    RowLayout {
                        spacing: 20

                        ColumnLayout {
                            spacing: 4
                            SncLabel { text: "Feed Rate  " + Math.round(feedRate * 100) + "%"; variant: "caption" }
                            SncSparkline {
                                id: feedSpark
                                implicitWidth: 200; implicitHeight: 52
                                lineColor: theme.orange; maxPoints: 60
                            }
                        }

                        ColumnLayout {
                            spacing: 4
                            SncLabel { text: "Buffer Load  " + Math.round(bufferLoad * 100) + "%"; variant: "caption" }
                            SncSparkline {
                                id: bufferSpark
                                implicitWidth: 200; implicitHeight: 52
                                lineColor: theme.accent; maxPoints: 60
                            }
                        }

                        ColumnLayout {
                            spacing: 4
                            SncLabel { text: "Spindle  " + Math.round(spindleVal * 100) + "%"; variant: "caption" }
                            SncSparkline {
                                id: spindleSpark
                                implicitWidth: 200; implicitHeight: 52
                                lineColor: theme.yellow; fillOpacity: 0; maxPoints: 60
                            }
                        }
                    }
                }
            }

            SncPanel {
                Layout.fillWidth: true
                implicitHeight:   coordSection.implicitHeight + 32
                ColumnLayout {
                    id: coordSection; width: parent.width; spacing: 12
                    SncLabel { text: "SncCoordinateDisplay"; variant: "section" }
                    RowLayout {
                        spacing: 10
                        SncCoordinateDisplay { axis: "X"; value: xPos;  axisColor: theme.yellow }
                        SncCoordinateDisplay { axis: "Y"; value: yPos;  axisColor: theme.orange }
                        SncCoordinateDisplay { axis: "Z"; value: -2.50; axisColor: theme.accent }
                        SncCoordinateDisplay { axis: "F"; value: Math.round(feedRate * 3000); unit: "mm/m"; decimals: 0; axisColor: theme.amber }
                    }
                }
            }

            SncPanel {
                Layout.fillWidth: true
                implicitHeight:   jogSection.implicitHeight + 32
                ColumnLayout {
                    id: jogSection; width: parent.width; spacing: 12
                    SncLabel { text: "SncJogButton"; variant: "section" }
                    Grid {
                        columns: 3; rows: 3; spacing: 6
                        Item          { width: 52; height: 52 }
                        SncJogButton  { text: "Y+" }
                        Item          { width: 52; height: 52 }
                        SncJogButton  { text: "X−" }
                        SncJogButton  { text: "⌂"; font.pixelSize: 18 }
                        SncJogButton  { text: "X+" }
                        Item          { width: 52; height: 52 }
                        SncJogButton  { text: "Y−" }
                        Item          { width: 52; height: 52 }
                    }
                }
            }

            SncPanel {
                Layout.fillWidth: true
                implicitHeight:   numSection.implicitHeight + 32
                ColumnLayout {
                    id: numSection; width: parent.width; spacing: 12
                    SncLabel { text: "SncNumberInput"; variant: "section" }
                    RowLayout {
                        spacing: 20
                        ColumnLayout {
                            spacing: 6
                            SncLabel { text: "Step"; variant: "caption" }
                            SncNumberInput { value: 1.0; step: 0.1; min: 0.1; max: 100; unit: "mm" }
                        }
                        ColumnLayout {
                            spacing: 6
                            SncLabel { text: "Speed"; variant: "caption" }
                            SncNumberInput { value: 2500; step: 100; min: 0; max: 10000; decimals: 0 }
                        }
                        ColumnLayout {
                            spacing: 6
                            SncLabel { text: "Z Offset"; variant: "caption" }
                            SncNumberInput { value: -2.5; step: 0.25; decimals: 2; unit: "mm" }
                        }
                    }
                }
            }

            SncPanel {
                Layout.fillWidth: true
                implicitHeight:   toolSection.implicitHeight + 32
                ColumnLayout {
                    id: toolSection; width: parent.width; spacing: 4
                    SncLabel { text: "SncToolCard"; variant: "section"; Layout.bottomMargin: 8 }
                    SncToolCard { name: "Outline";     dotColor: theme.yellow; layerVisible: true }
                    SncToolCard { name: "Fill Pass";   dotColor: theme.amber;  layerVisible: true }
                    SncToolCard { name: "Mark Points"; dotColor: theme.orange; layerVisible: false }
                    SncToolCard { name: "Calibration"; dotColor: theme.accent; layerVisible: true }
                }
            }

            SncPanel {
                Layout.fillWidth: true
                implicitHeight:   consoleSection.implicitHeight + 32
                ColumnLayout {
                    id: consoleSection; width: parent.width; spacing: 12
                    SncLabel { text: "SncConsole  (live)"; variant: "section" }
                    SncConsole {
                        id:               demoConsole
                        Layout.fillWidth: true
                        implicitHeight:   180

                        Component.onCompleted: {
                            append("INFO", "Serial connected on COM4")
                            append("CMD",  "G28 ; home all axes")
                            append("RUN",  "Loaded squirrel_outline_v03.gcode")
                            append("OK",   "Planner buffer stable")
                        }
                    }
                }
            }

            SncPanel {
                Layout.fillWidth: true
                implicitHeight:   tokenSection.implicitHeight + 32
                ColumnLayout {
                    id: tokenSection; width: parent.width; spacing: 12
                    SncLabel { text: "Theme Tokens"; variant: "section" }
                    GridLayout {
                        columns: 4; rowSpacing: 8; columnSpacing: 10
                        Repeater {
                            model: [
                                { name: "yellow",        hex: "#FFD400", col: theme.yellow },
                                { name: "amber",         hex: "#FFC300", col: theme.amber },
                                { name: "orange",        hex: "#FF8C00", col: theme.orange },
                                { name: "accent",        hex: "#FF5F00", col: theme.accent },
                                { name: "background",    hex: "#0B0F14", col: theme.background },
                                { name: "surface",       hex: "#1A1D21", col: theme.surface },
                                { name: "surfaceAlt",    hex: "#22262D", col: theme.surfaceAlt },
                                { name: "border",        hex: "#343A40", col: theme.border },
                                { name: "textPrimary",   hex: "#F5F7FA", col: theme.textPrimary },
                                { name: "textSecondary", hex: "#A7B0BA", col: theme.textSecondary },
                                { name: "textMuted",     hex: "#7D8794", col: theme.textMuted },
                            ]
                            delegate: Rectangle {
                                implicitWidth: 170; implicitHeight: 44
                                radius: theme.radiusSm
                                color: theme.surfaceAlt
                                border.color: theme.border; border.width: 1
                                Row {
                                    anchors.fill: parent; anchors.margins: 10; spacing: 10
                                    Rectangle {
                                        width: 20; height: 20; radius: 10
                                        color: modelData.col
                                        anchors.verticalCenter: parent.verticalCenter
                                        border.color: theme.border; border.width: 1
                                    }
                                    Column {
                                        anchors.verticalCenter: parent.verticalCenter; spacing: 2
                                        Text { text: modelData.name; color: theme.textPrimary; font.pixelSize: 12 }
                                        Text { text: modelData.hex;  color: theme.textMuted;   font.pixelSize: 11; font.family: "Courier New" }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Item { implicitHeight: 8 }
        }
    }

}
