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
            ctx.arc(centerX, centerY, radius, -Math.PI * 0.75, -Math.PI * 0.25, false); // Lingkaran 150 derajat dengan bagian yang hilang di bawah
            ctx.lineWidth = width * 0.02;
            ctx.strokeStyle = "lightgray";
            ctx.stroke();

            // Draw the numbers around the arc.
            ctx.font = width * 0.1 + "px Arial";
            ctx.fillStyle = "black";
            ctx.textAlign = "center";
            ctx.textBaseline = "middle";
            for (var i = minValue; i <= maxValue; i += (maxValue - minValue) / 10) {
                var angle = (i - minValue) / (maxValue - minValue) * Math.PI * 0.5 - Math.PI * 0.75; // Sudut untuk angka
                var x = centerX + Math.cos(angle) * (radius + width * 0.15);
                var y = centerY + Math.sin(angle) * (radius + height * 0.15);
                ctx.fillText(i.toFixed(0), x, y);
            }

            // Draw the needle.
            var valueAngle = (value - minValue) / (maxValue - minValue) * Math.PI * 0.5 - Math.PI * 0.75; // Sudut untuk jarum
            ctx.beginPath();
            ctx.moveTo(centerX, centerY);
            ctx.lineTo(centerX + Math.cos(valueAngle) * (radius - width * 0.1), centerY + Math.sin(valueAngle) * (radius - height * 0.1));
            ctx.lineWidth = width * 0.02;
            ctx.strokeStyle = "red";
            ctx.stroke();

            // Draw the needle base.
            ctx.beginPath();
            ctx.arc(centerX, centerY, radius / 5, 0, Math.PI * 2, false);
            ctx.fillStyle = "red";
            ctx.fill();
        }
    }

    Text {
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: canvas.bottom
        } // Teks di atas lingkaran
        text: label
        font.pixelSize: 20
        color: "black"
    }

    Text {
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: canvas.top
        } // Teks di bawah lingkaran
        text: valueItem.value.toFixed(0)
        font.pixelSize: 20
        color: "black"
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
