import QtQuick 2.15

Item {
    property alias value: valueItem.value
    property real minValue: 0
    property real maxValue: 100
    property string label: ""

    width: parent.width
    height: parent.height

    Canvas {
        id: canvas
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();

            var centerX = width / 2;
            var centerY = height / 2;
            var radius = Math.min(centerX, centerY) - 2;
            var tickLength = radius * 0.1;
            var majorTickCount = 10;

            // Draw the background arc.
            ctx.beginPath();
            ctx.arc(centerX, centerY, radius, Math.PI * 0.75, Math.PI * 0.75 + Math.PI * 1.5, false); // Menggambar dari 150 derajat kiri ke kanan
            ctx.lineWidth = radius * 0.04;
            ctx.strokeStyle = "lightgray";
            ctx.stroke();

            // Draw major tickmarks, minor tickmarks, and numbers.
            for (var i = 0; i <= majorTickCount; i++) {
                var angle = Math.PI * 0.75 + (i / majorTickCount) * Math.PI * 1.5;
                var x1 = centerX + Math.cos(angle) * (radius - tickLength);
                var y1 = centerY + Math.sin(angle) * (radius - tickLength);
                var x2 = centerX + Math.cos(angle) * radius;
                var y2 = centerY + Math.sin(angle) * radius;

                ctx.beginPath();
                ctx.moveTo(x1, y1);
                ctx.lineTo(x2, y2);
                ctx.lineWidth = radius * 0.02;
                ctx.strokeStyle = "black";
                ctx.stroke();

                // Draw numbers near major tickmarks.
                if (i > 0 && i < majorTickCount) {
                    var num = minValue + (i / majorTickCount) * (maxValue - minValue);
                    var numAngle = angle - Math.PI * 0.5;
                    var numX = centerX + Math.cos(numAngle) * (radius - tickLength * 1.5);
                    var numY = centerY + Math.sin(numAngle) * (radius - tickLength * 1.5);

                    ctx.font = radius * 0.1 + "px Arial";
                    ctx.fillStyle = "black";
                    ctx.textAlign = "center";
                    ctx.textBaseline = "middle";
                    ctx.fillText(num.toFixed(0), numX, numY);
                }
            }

            // Draw the needle.
            var valueAngle = (value - minValue) / (maxValue - minValue) * Math.PI * 1.5 + Math.PI * 0.75;
            var needleLength = radius * 0.8;
            var needleBaseSize = radius * 0.1;

            ctx.beginPath();
            ctx.moveTo(centerX, centerY);
            ctx.lineTo(centerX + Math.cos(valueAngle) * needleLength, centerY + Math.sin(valueAngle) * needleLength);
            ctx.lineWidth = radius * 0.02;
            ctx.strokeStyle = "red";
            ctx.stroke();

            // Draw the needle base.
            ctx.beginPath();
            ctx.arc(centerX, centerY, needleBaseSize, 0, Math.PI * 2, false);
            ctx.fillStyle = "red";
            ctx.fill();
        }
    }

    Text {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        text: label
        font.pixelSize: parent.height * 0.1
    }

    Text {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        text: valueItem.value.toFixed(0)
        font.pixelSize: parent.height * 0.1
    }

    Item {
        id: valueItem
        property real value: 0

        onValueChanged: {
            canvas.requestPaint();
            valueText.text = value.toFixed(0);
        }
    }
}
