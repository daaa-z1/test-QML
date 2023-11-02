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

            // Draw the background arc.
            ctx.beginPath();
            ctx.arc(width / 2, height / 2, width / 2 - 2, Math.PI * 0.75, Math.PI * 0.75 + Math.PI * 1.5, false); // Menggambar dari 150 derajat kiri ke kanan
            ctx.lineWidth = width * 0.02;
            ctx.strokeStyle = "lightgray";
            ctx.stroke();

            // Draw tickmarks and numbers around the arc.
            ctx.font = width * 0.1 + "px Arial";
            ctx.fillStyle = "black";
            ctx.textAlign = "center";
            ctx.textBaseline = "middle";
            for (var i = minValue; i <= maxValue; i += (maxValue - minValue) / 10) {
                var angle = (i - minValue) * Math.PI * 1.5 / (maxValue - minValue) + Math.PI * 0.75;
                var x = width / 2 + Math.cos(angle) * (width / 2 - width * 0.15);
                var y = height / 2 + Math.sin(angle) * (height / 2 - height * 0.15);
                ctx.fillText(i.toFixed(0), x, y);

                // Draw tickmarks
                var tickX = width / 2 + Math.cos(angle) * (width / 2 - width * 0.05);
                var tickY = height / 2 + Math.sin(angle) * (height / 2 - height * 0.05);
                ctx.beginPath();
                ctx.moveTo(tickX, tickY);
                ctx.lineTo(x, y);
                ctx.lineWidth = width * 0.01;
                ctx.strokeStyle = "black";
                ctx.stroke();
            }

            // Draw the needle.
            var valueAngle = (value - minValue) * Math.PI * 1.5 / (maxValue - minValue) + Math.PI * 0.75;
            ctx.beginPath();
            ctx.moveTo(width / 2, height / 2);
            ctx.lineTo(width / 2 + Math.cos(valueAngle) * (width / 2 - width * 0.1), height / 2 + Math.sin(valueAngle) * (height / 2 - height * 0.1));
            ctx.lineWidth = width * 0.01;
            ctx.strokeStyle = "red";
            ctx.stroke();

            // Draw the smaller needle base.
            ctx.beginPath();
            ctx.arc(width / 2, height / 2, width * 0.03, 0, Math.PI * 2, false);
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
