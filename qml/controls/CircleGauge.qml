// File: qml/controls/CircleGauge.qml
import QtQuick 2.0

Item {
    property alias value: valueItem.value
    property real minValue: 0
    property real maxValue: 100
    property string symbol: ""

    width: 200
    height: 200

    Canvas {
        id: canvas
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();

            // Draw the background arc.
            ctx.beginPath();
            ctx.arc(width / 2, height / 2, width / 2 - 2, Math.PI * 0.75, Math.PI * 1.25, false);
            ctx.lineWidth = 4;
            ctx.strokeStyle = "lightgray";
            ctx.stroke();

            // Draw the numbers around the arc.
            ctx.font = "20px Arial";
            ctx.textAlign = "center";
            ctx.textBaseline = "middle";
            for (var i = minValue; i <= maxValue; i += (maxValue - minValue) / 10) {
                var angle = i * Math.PI * 0.5 / (maxValue - minValue) + Math.PI * 0.75;
                var x = width / 2 + Math.cos(angle) * (width / 2 - 30);
                var y = height / 2 + Math.sin(angle) * (height / 2 - 30);
                ctx.fillText(i.toFixed(0), x, y);
            }

            // Draw the needle.
            var valueAngle = valueItem.value * Math.PI * 0.5 / (maxValue - minValue) + Math.PI * 0.75;
            ctx.beginPath();
            ctx.moveTo(width / 2, height / 2);
            ctx.lineTo(width / 2 + Math.cos(valueAngle) * (width / 2 - 20), height / 2 + Math.sin(valueAngle) * (height / 2 - 20));
            ctx.lineWidth = 2;
            ctx.strokeStyle = "red";
            ctx.stroke();
        }
    }

    Text {
        id: symbolText
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        text: symbol
        font.pixelSize: parent.height * 0.1
    }

    Text {
        id: valueText
        anchors.top: symbolText.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        text: valueItem.value.toFixed(1)
        font.pixelSize: parent.height * 0.1
    }

    Item {
        id: valueItem
        property real value: 0

        onValueChanged: {
            canvas.requestPaint();
            valueText.text = value.toFixed(1);
        }
    }
}
