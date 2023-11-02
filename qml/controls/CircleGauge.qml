import QtQuick 2.15

Item {
    property alias value: valueItem.value
    property real minValue: 0
    property real maxValue: 100
    property string label: ""

    width: parent.width
    height: parent.width * 0.7  // Lebarnya diatur sebagai 70% dari tinggi parent.

    Canvas {
        id: canvas
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();

            // Draw the background arc.
            ctx.beginPath();
            ctx.arc(width / 2, height, width / 2 - 2, 0, Math.PI, false); // Lingkaran setengah bagian bawah
            ctx.lineWidth = width * 0.02;
            ctx.strokeStyle = "lightgray";
            ctx.stroke();

            // Draw the numbers around the arc.
            ctx.font = width * 0.1 + "px Arial";
            ctx.fillStyle = "black";
            ctx.textAlign = "center";
            ctx.textBaseline = "middle";
            for (var i = minValue; i <= maxValue; i += (maxValue - minValue) / 10) {
                var angle = i * Math.PI / (maxValue - minValue);
                var x = width / 2 - Math.cos(angle) * (width / 2 - width * 0.15);
                var y = height - Math.sin(angle) * (width / 2 - width * 0.15);
                ctx.fillText(i.toFixed(0), x, y);
            }

            // Draw the needle.
            var valueAngle = (valueItem.value - minValue) * Math.PI / (maxValue - minValue);
            ctx.beginPath();
            ctx.moveTo(width / 2, height);
            ctx.lineTo(width / 2 - Math.cos(valueAngle) * (width / 2 - width * 0.1), height - Math.sin(valueAngle) * (width / 2 - width * 0.1));
            ctx.lineWidth = width * 0.02;
            ctx.strokeStyle = "red";
            ctx.stroke();

            // Draw the needle base.
            ctx.beginPath();
            ctx.arc(width / 2, height, width / 10, 0, Math.PI * 2, false);
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
