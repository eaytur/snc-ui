import QtQuick
import Snc.Ui

Item {
    id: root

    property real   value:       0.0
    property string label:       ""
    property string unit:        "%"
    property color  gaugeColor:  theme.orange
    property int    strokeWidth: 8

    Theme { id: theme }

    implicitWidth:  120
    implicitHeight: 120

    Canvas {
        id: canvas
        anchors.fill: parent

        readonly property real startDeg: 135
        readonly property real sweepDeg: 270

        onPaint: {
            var ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)

            var cx  = width  / 2
            var cy  = height / 2
            var r   = Math.min(width, height) / 2 - root.strokeWidth - 4

            var startRad = startDeg * Math.PI / 180
            var endRad   = (startDeg + sweepDeg) * Math.PI / 180
            var progRad  = startRad + root.value * sweepDeg * Math.PI / 180

            ctx.beginPath()
            ctx.arc(cx, cy, r, startRad, endRad)
            ctx.strokeStyle = theme.border.toString()
            ctx.lineWidth   = root.strokeWidth
            ctx.lineCap     = "round"
            ctx.stroke()

            if (root.value > 0) {
                ctx.beginPath()
                ctx.arc(cx, cy, r, startRad, progRad)
                ctx.strokeStyle = root.gaugeColor.toString()
                ctx.lineWidth   = root.strokeWidth
                ctx.lineCap     = "round"
                ctx.stroke()
            }

            ctx.strokeStyle = theme.border.toString()
            ctx.lineWidth   = 1
        }
    }

    onValueChanged:      canvas.requestPaint()
    onGaugeColorChanged: canvas.requestPaint()
    onStrokeWidthChanged: canvas.requestPaint()

    Column {
        anchors.centerIn: parent
        spacing:          2

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text:           Math.round(root.value * 100) + root.unit
            color:          theme.textPrimary
            font.pixelSize: root.width * 0.19
            font.bold:      true
        }

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            visible:        root.label !== ""
            text:           root.label
            color:          theme.textMuted
            font.pixelSize: 10
            font.capitalization: Font.AllUppercase
            font.letterSpacing:  0.6
        }
    }
}
