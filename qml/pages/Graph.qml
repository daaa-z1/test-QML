import QtQuick 2.15
import QtQuick.Controls 2.15

Page {
    visible: true
    width: 640
    height: 480
    title: "Real-time Plot"

    Rectangle {
        id: plotArea
        anchors.fill: parent
        color: "black"

        Canvas {
            id: canvas
            anchors.fill: parent

            property var values: []

            onPaint: {
                var ctx = getContext("2d");
                ctx.clearRect(0, 0, width, height);
                ctx.beginPath();
                ctx.strokeStyle = "red";
                ctx.lineWidth = 2;
                for (var i = 0; i < values.length; ++i) {
                    var x = i / values.length * width;
                    var y = height - values[i] / 100 * height;
                    if (i === 0)
                        ctx.moveTo(x, y);
                    else
                        ctx.lineTo(x, y);
                }
                ctx.stroke();
            }

            Component.onCompleted: {
                // Connect to the valueChanged signal of mainApp
                mainApp.valueChanged.connect(updatePlot);
            }

            function updatePlot() {
                // Append the new value to the series
                var value = mainApp.value["press_in"]; // replace "press_in" with the key you are interested in
                values.push(value);
                if (values.length > width)
                    values.shift();
                canvas.requestPaint();
            }
        }
    }
}
