import QtQuick
import Snc.Ui

Canvas {
    id: root

    property var   values:      []
    property color lineColor:   theme.yellow
    property real  fillOpacity: 0.15
    property int   maxPoints:   40

    Theme { id: theme }

    implicitWidth:  120
    implicitHeight: 36

    function addValue(v) {
        var buf = values.slice()
        buf.push(Math.max(0, Math.min(1, v)))
        if (buf.length > maxPoints) buf.shift()
        values = buf
    }

    onValuesChanged:    requestPaint()
    onLineColorChanged: requestPaint()

    onPaint: {
        var ctx = getContext("2d")
        ctx.clearRect(0, 0, width, height)

        if (!values || values.length < 2) return

        var pad = 2
        var w   = width  - pad * 2
        var h   = height - pad * 2

        var pts = []
        for (var i = 0; i < values.length; i++) {
            pts.push({
                x: pad + (i / (values.length - 1)) * w,
                y: pad + (1 - Math.max(0, Math.min(1, values[i]))) * h
            })
        }

        if (fillOpacity > 0) {
            ctx.beginPath()
            ctx.moveTo(pts[0].x, pts[0].y)
            for (var j = 1; j < pts.length; j++)
                ctx.lineTo(pts[j].x, pts[j].y)
            ctx.lineTo(pts[pts.length - 1].x, height)
            ctx.lineTo(pts[0].x, height)
            ctx.closePath()
            ctx.fillStyle = Qt.rgba(lineColor.r, lineColor.g, lineColor.b, fillOpacity).toString()
            ctx.fill()
        }

        ctx.beginPath()
        ctx.moveTo(pts[0].x, pts[0].y)
        for (var k = 1; k < pts.length; k++)
            ctx.lineTo(pts[k].x, pts[k].y)
        ctx.strokeStyle = lineColor.toString()
        ctx.lineWidth   = 1.5
        ctx.lineJoin    = "round"
        ctx.lineCap     = "round"
        ctx.stroke()

        var last = pts[pts.length - 1]
        ctx.beginPath()
        ctx.arc(last.x, last.y, 3, 0, Math.PI * 2)
        ctx.fillStyle = lineColor.toString()
        ctx.fill()
    }
}
