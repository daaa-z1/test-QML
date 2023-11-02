import QtQuick 2.15

Item {
    property alias value: valueItem.value
    property real minValue: 0
    property real maxValue: 100
    property string label: "Label"

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
            ctx.arc(width / 2, height / 2, width / 2 - 2, Math.PI * 0.75, Math.PI * 1.25, false);
            ctx.lineWidth = width * 0.02;
            ctx.strokeStyle = "black";
            ctx.stroke();

            // Draw the numbers around the arc.
            ctx.font = width * 0.1 + "px Arial";
            ctx.fillStyle = "black";
            ctx.textAlign = "center";
            ctx.textBaseline = "middle";
            for (var i = minValue; i <= maxValue; i += (maxValue - minValue) / 10) {
                var angle = i * Math.PI * 0.5 / (maxValue - minValue) + Math.PI * 0.75;
                var x = width / 2 + Math.cos(angle) * (width / 2 - width * 0.15);
                var y = height / 2 + Math.sin(angle) * (height / 2 - height * 0.15);
                ctx.fillText(i.toFixed(0), x, y);
            }

            // Draw the needle.
            var valueAngle = valueItem.value * Math.PI * 0.5 / (maxValue - minValue) + Math.PI * 0.75;
            ctx.beginPath();
            ctx.moveTo(width / 2, height / 2);
            ctx.lineTo(width / 2 + Math.cos(valueAngle) * (width / 2 - width * 0.1), height / 2 + Math.sin(valueAngle) * (height / 2 - height * 0.1));
            ctx.lineWidth = width * 0.02;
            ctx.strokeStyle = "red";
            ctx.stroke();

            // Draw the needle base.
            ctx.beginPath();
            ctx.arc(width / 2, height / 2, width / 10, 0, Math.PI * 2, false);
            ctx.fillStyle = "red";
            ctx.fill();
        }
    }

    Text {
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
        }
        text: label
        font.pixelSize: parent.height * 0.1
        color: "#3498db" // Ganti warna label menjadi biru
    }

    Text {
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.bottom
        }
        text: valueItem.value.toFixed(1)
        font.pixelSize: Math.min(parent.width, parent.height) * 0.1
        color: "#3498db" // Ganti warna nilai menjadi biru
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
