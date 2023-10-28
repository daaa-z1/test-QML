import QtQuick 2.11
import QtQuick.Controls 2.4
import "../controls"

Page {
    title: "Dashboard"

    Rectangle {
        width: parent.width
        height: parent.height

        // Voltage Gauge
        CircleGauge {
            anchors.top: parent.top
            anchors.horizontalCenter: parent.horizontalCenter
            value: voltageValue
            label: "Voltage"
            symbol: "V"
        }

        // mA Gauge
        CircleGauge {
            anchors.top: voltageGauge.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            value: mAValue
            label: "mA"
            symbol: "mA"
        }

        // Fluid Pressure Gauge
        CircleGauge {
            anchors.top: mAGauge.bottom
            anchors.horizontalCenter: parent.horizontalCenter
            value: pressureValue
            label: "Fluid Pressure"
            symbol: "psi"
        }
    }
}
