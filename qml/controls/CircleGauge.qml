import QtQuick 2.15

Item {
    width: width
    height: height

    property real value: 0
    property real minValue: 0
    property real maxValue: 100
    property string label: "Label"

    Canvas {
        anchors.fill: parent

        onPaint: {
            var ctx = getContext("2d");
            ctx.reset();

            var centerX = width / 2;
            var centerY = height / 2;
            var radius = Math.min(centerX, centerY) - 10;

            // Menggambar lingkaran latar belakang
            ctx.strokeStyle = "#000";
            ctx.lineWidth = 10;
            ctx.beginPath();
            ctx.arc(centerX, centerY, radius, 0, 2 * Math.PI);
            ctx.stroke();

            // Menggambar lingkaran value
            ctx.strokeStyle = "#000";
            ctx.lineWidth = 10;
            ctx.beginPath();
            var angle = (value - minValue) / (maxValue - minValue) * 360;
            ctx.arc(centerX, centerY, radius, -90 * (Math.PI / 180), (angle - 90) * (Math.PI / 180));
            ctx.stroke();
        }
    }

    Text {
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
        }
        text: label
        font.pixelSize: 20
        color: "#000"
    }

    Text {
        anchors {
            horizontalCenter: parent.horizontalCenter
            bottom: parent.bottom
        }
        text: value.toFixed(1)
        font.pixelSize: Math.min(parent.width, parent.height) * 0.1
        color: "#000"
    }
}
