import QtQuick
import Snc.Ui

Item {
    id: root

    property real   value:         0.0
    property color  progressColor: theme.yellow
    property int    strokeWidth:   7
    property bool   showText:      true
    property string unit:          "%"

    Theme { id: theme }

    implicitWidth:  80
    implicitHeight: 80

    Canvas {
        id: canvas
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d")
            ctx.clearRect(0, 0, width, height)

            var cx = width  / 2
            var cy = height / 2
            var r  = Math.min(width, height) / 2 - root.strokeWidth - 2

            ctx.beginPath()
            ctx.arc(cx, cy, r, 0, Math.PI * 2)
            ctx.strokeStyle = theme.border.toString()
            ctx.lineWidth   = root.strokeWidth
            ctx.lineCap     = "round"
            ctx.stroke()

            if (root.value > 0) {
                ctx.beginPath()
                ctx.arc(cx, cy, r, -Math.PI / 2,
                        -Math.PI / 2 + root.value * Math.PI * 2)
                ctx.strokeStyle = root.progressColor.toString()
                ctx.lineWidth   = root.strokeWidth
                ctx.lineCap     = "round"
                ctx.stroke()
            }
        }
    }

    onValueChanged:         canvas.requestPaint()
    onProgressColorChanged: canvas.requestPaint()
    onStrokeWidthChanged:   canvas.requestPaint()

    Column {
        anchors.centerIn: parent
        spacing: 0
        visible: root.showText

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text:           Math.round(root.value * 100) + root.unit
            color:          theme.textPrimary
            font.pixelSize: root.width * 0.22
            font.bold:      true
        }
    }
}
