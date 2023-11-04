import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Extras 1.4

Gauge {
    id: circleGauge
    width: 200
    height: 200

    property alias value: circleGauge.value

    minimumValue: 0
    maximumValue: 5
    stepSize: 1
    tickmarksVisible: true
    labelsVisible: true

    style: GaugeStyle {
        valueBar: Rectangle {
            implicitWidth: 20
            implicitHeight: control.height / 2
            color: "steelblue"
            radius: width / 2
        }
        tickmarkStepSize: control.stepSize
        minorTickmarkCount: 4
        tickmarkLabel: Text {
            text: styleData.value
            color: "black"
            font.pixelSize: 8
        }
        needle: Rectangle {
            implicitWidth: 4
            implicitHeight: control.height * 0.45
            color: "red"
            antialiasing: true
            transformOrigin: Item.Bottom
            radius: width / 2
        }
    }
}
