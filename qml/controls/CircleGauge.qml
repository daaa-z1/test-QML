// File: qml/controls/CircleGauge.qml
import QtQuick 2.0

Item {
    property alias value: valueItem.value
    property real minValue: 0
    property real maxValue: 100

    width: 200
    height: 200

    Canvas {
        id: canvas
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();

            // Draw the background circle.
            ctx.beginPath();
            ctx.arc(width / 2, height / 2, width / 2 - 2, 0, Math.PI * 2, false);
            ctx.lineWidth = 4;
            ctx.strokeStyle = "lightgray";
            ctx.stroke();

            // Draw the numbers around the circle.
            ctx.font = "20px Arial";
            ctx.textAlign = "center";
            ctx.textBaseline = "middle";
            for (var i = minValue; i <= maxValue; i += (maxValue - minValue) / 10) {
                var angle = i * Math.PI * 2 / (maxValue - minValue) - Math.PI / 2;
                var x = width / 2 + Math.cos(angle) * (width / 2 - 30);
                var y = height / 2 + Math.sin(angle) * (height / 2 - 30);
                ctx.fillText(i.toFixed(0), x, y);
            }

            // Draw the needle.
            var valueAngle = valueItem.value * Math.PI * 2 / (maxValue - minValue) - Math.PI / 2;
            ctx.beginPath();
            ctx.moveTo(width / 2, height / 2);
            ctx.lineTo(width / 2 + Math.cos(valueAngle) * (width / 2 - 20), height / 2 + Math.sin(valueAngle) * (height / 2 - 20));
            ctx.lineWidth = 2;
            ctx.strokeStyle = "red";
            ctx.stroke();
        }
    }

    Item {
        id: valueItem
        property real value: 0

        onValueChanged: canvas.requestPaint()
    }
}
