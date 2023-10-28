import QtQuick 2.0

Item {
    property alias value: arcSpan.angle
    property real minValue: 0
    property real maxValue: 100

    width: 200
    height: 200

    Canvas {
        anchors.fill: parent
        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();
            ctx.beginPath();
            ctx.arc(width / 2, height / 2, width / 2 - 2, 0, Math.PI * 2, false);
            ctx.lineWidth = 4;
            ctx.strokeStyle = "lightgray";
            ctx.stroke();

            ctx.beginPath();
            ctx.arc(width / 2, height / 2, width / 2 - 2, -Math.PI / 2, value * Math.PI * 2 / (maxValue - minValue) - Math.PI / 2, false);
            ctx.strokeStyle = "red";
            ctx.stroke();
        }
    }

    Shape {
        id: arcSpan
        anchors.centerIn: parent
        width: parent.width - 4
        height: parent.height - 4

        ShapePath {
            strokeWidth: 4
            fillColor: "transparent"
            strokeColor: "red"
            startX: parent.width / 2
            startY: parent.height / 2
            PathArc {
                x: parent.width / 2
                y: parent.height / 2
                radiusX: (parent.width - strokeWidth) / 2
                radiusY: (parent.height - strokeWidth) / 2
                useLargeArc: false
                direction: PathArc.Clockwise
                angleDeterminationMode: PathArc.AngleAtCenter
                angle: value * 360 / (maxValue - minValue)
            }
        }
    }
}
