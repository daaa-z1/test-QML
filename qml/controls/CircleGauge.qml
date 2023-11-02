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

            // Menggambar lingkaran latar belakang
            var radius = height * 0.35; // Ukuran lingkaran latar belakang sebesar 70% dari tinggi
            ctx.beginPath();
            ctx.arc(width / 2, height / 2, radius, Math.PI * 0.75, Math.PI * 1.25, false);
            ctx.lineWidth = width * 0.02;
            ctx.strokeStyle = "lightgray";
            ctx.stroke();

            // Menggambar angka-angka di sekeliling lingkaran
            ctx.font = height * 0.1 + "px Arial";
            ctx.fillStyle = "black";
            ctx.textAlign = "center";
            ctx.textBaseline = "middle";
            for (var i = minValue; i <= maxValue; i += (maxValue - minValue) / 10) {
                var angle = i * Math.PI * 0.5 / (maxValue - minValue) + Math.PI * 0.75;
                var x = width / 2 + Math.cos(angle) * (radius - height * 0.1);
                var y = height / 2 + Math.sin(angle) * (radius - height * 0.1);
                ctx.fillText(i.toFixed(0), x, y);
            }

            // Menggambar jarum
            var valueAngle = valueItem.value * Math.PI * 0.5 / (maxValue - minValue) + Math.PI * 0.75;
            ctx.beginPath();
            ctx.moveTo(width / 2, height / 2);
            ctx.lineTo(width / 2 + Math.cos(valueAngle) * (radius - height * 0.15), height / 2 + Math.sin(valueAngle) * (radius - height * 0.15));
            ctx.lineWidth = width * 0.02;
            ctx.strokeStyle = "red";
            ctx.stroke();

            // Menggambar pangkal jarum
            ctx.beginPath();
            ctx.arc(width / 2, height / 2, height * 0.05, 0, Math.PI * 2, false);
            ctx.fillStyle = "red";
            ctx.fill();
        }
    }

    Text {
        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter
        text: label
        font.pixelSize: height * 0.1
    }

    Text {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        text: valueItem.value.toFixed(0)
        font.pixelSize: height * 0.1
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
