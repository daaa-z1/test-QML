// File: qml/controls/CircleGauge.qml
import QtQuick 2.0

Item {
    property real value: valueItem.value
    property real minValue: 0
    property real maxValue: 100
    property string fontFamily: "Arial"
    property string label: ""
    property string symbol: ""
    property color backgroundColor: "lightgray"

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
            ctx.arc(width / 2, height / 2, width / 2 - 2, Math.PI * 0.85, Math.PI * 0.15, false);
            ctx.lineWidth = 4;
            ctx.strokeStyle = backgroundColor;
            ctx.stroke();

            // Draw the numbers around the arc.
            ctx.font = "16px " + fontFamily;
            ctx.fillStyle = "black";
            ctx.textAlign = "center";
            ctx.textBaseline = "middle";
            for (var i = minValue; i <= maxValue; i += (maxValue - minValue) / 10) {
                var angle = i * Math.PI * 1.3 / (maxValue - minValue) + Math.PI * 0.85;
                var x = width / 2 + Math.cos(angle) * (width / 2 - 30);
                var y = height / 2 + Math.sin(angle) * (height / 2 - 30);
                ctx.fillText(i.toFixed(0), x, y);
            }

            // Draw the needle.
            var valueAngle = valueItem.value * Math.PI * 1.3 / (maxValue - minValue) + Math.PI * 0.85;
            ctx.beginPath();
            ctx.moveTo(width / 2, height / 2);
            ctx.lineTo(width / 2 + Math.cos(valueAngle) * (width / 2 - 20), height / 2 + Math.sin(valueAngle) * (height / 2 - 20));
            ctx.lineWidth = 4;
            ctx.strokeStyle = "red";
            ctx.stroke();

            // Draw the needle base.
            ctx.beginPath();
            ctx.arc(width / 2, height / 2, width / 20, 0, Math.PI * 2, false);
            ctx.fillStyle = "red";
            ctx.fill();
        }
    }

    Text {
        id: valueText
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.verticalCenter
        text: valueItem.value.toFixed(1) + " " + label
        font.pixelSize: parent.height * 0.1
    }

    Text {
        id: labelText
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.top
        text: label
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
