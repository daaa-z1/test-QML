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
            var radius = Math.min(centerX, centerY) - 10;

            // Draw the background arc.
            ctx.beginPath();
            ctx.arc(centerX, centerY, radius, Math.PI * 0.75, Math.PI * 0.75 + Math.PI * 1.5, false); // Menggambar dari 150 derajat kiri ke kanan
            ctx.lineWidth = width * 0.02;
            ctx.strokeStyle = "lightgray";
            ctx.stroke();

            // Draw the major tickmarks and numbers.
            for (var i = minValue; i <= maxValue; i += (maxValue - minValue) / 10) {
                var angle = (i - minValue) * Math.PI * 1.5 / (maxValue - minValue) + Math.PI * 0.75;
                var x1 = centerX + Math.cos(angle) * (radius - width * 0.1);
                var y1 = centerY + Math.sin(angle) * (radius - width * 0.1);
                var x2 = centerX + Math.cos(angle) * (radius - width * 0.15);
                var y2 = centerY + Math.sin(angle) * (radius - width * 0.15);
                ctx.lineWidth = width * 0.02;
                ctx.strokeStyle = "black";
                ctx.beginPath();
                ctx.moveTo(x1, y1);
                ctx.lineTo(x2, y2);
                ctx.stroke();

                ctx.font = width * 0.1 + "px Arial";
                ctx.fillStyle = "black";
                ctx.textAlign = "center";
                ctx.textBaseline = "middle";
                ctx.fillText(i.toFixed(0), x2, y2);
            }

            // Draw the needle.
            var valueAngle = (value - minValue) * Math.PI * 1.5 / (maxValue - minValue) + Math.PI * 0.75;
            var needleLength = radius - width * 0.2;
            var needleX = centerX + Math.cos(valueAngle) * needleLength;
            var needleY = centerY + Math.sin(valueAngle) * needleLength;
            ctx.beginPath();
            ctx.moveTo(centerX, centerY);
            ctx.lineTo(needleX, needleY);
            ctx.lineWidth = width * 0.02;
            ctx.strokeStyle = "red";
            ctx.stroke();

            // Draw the needle base.
            ctx.beginPath();
            ctx.arc(centerX, centerY, width * 0.05, 0, Math.PI * 2, false);
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
