import QtQuick 2.15

Item {
    property alias value: valueItem.value
    property real minValue: 0
    property real maxValue: 100
    property string label: ""

    width: parent.width
    height: parent.width * 0.7

    Canvas {
        id: canvas
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();

            // Menggambar lingkaran latar belakang
            var centerX = width / 2;
            var centerY = height / 2;
            var radius = (width / 2) * 0.7; // Menggunakan 70% dari diameter
            ctx.beginPath();
            ctx.arc(centerX, centerY, radius, Math.PI * 0.75, Math.PI * 1.25, false);
            ctx.lineWidth = width * 0.02;
            ctx.strokeStyle = "lightgray";
            ctx.stroke();

            // Menggambar angka di sekitar lingkaran
            ctx.font = width * 0.1 + "px Arial";
            ctx.fillStyle = "black";
            ctx.textAlign = "center";
            ctx.textBaseline = "middle";
            for (var i = minValue; i <= maxValue; i += (maxValue - minValue) / 10) {
                var angle = i * Math.PI * 0.5 / (maxValue - minValue) + Math.PI * 0.75;
                var x = centerX + Math.cos(angle) * (radius - width * 0.15);
                var y = centerY + Math.sin(angle) * (radius - width * 0.15);
                ctx.fillText(i.toFixed(0), x, y);
            }

            // Menggambar jarum
            var valueAngle = valueItem.value * Math.PI * 0.5 / (maxValue - minValue) + Math.PI * 0.75;
            ctx.beginPath();
            ctx.moveTo(centerX, centerY);
            ctx.lineTo(centerX + Math.cos(valueAngle) * (radius - width * 0.1), centerY + Math.sin(valueAngle) * (radius - width * 0.1));
            ctx.lineWidth = width * 0.02;
            ctx.strokeStyle = "red";
            ctx.stroke();

            // Menggambar dasar jarum
            ctx.beginPath();
            ctx.arc(centerX, centerY, width * 0.1, 0, Math.PI * 2, false);
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
