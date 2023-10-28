// File: qml/pages/Dashboard.qml
import QtQuick 2.9
import QtQuick.Controls 2.2
import "../controls"

Page {
    id: dashboardPage
    title: "Dashboard"
    width: parent.width
    height: parent.height

    Grid {
        columns: 3
        spacing: 20
        anchors.centerIn: parent

        CircleGauge {
            id: voltageGauge
            minValue: 0
            maxValue: 220
            value: 110 // AIN0
            symbol: "V"
            label: "Voltage"
        }

        CircleGauge {
            id: currentGauge
            minValue: 0
            maxValue: 1000
            value: 500 // AIN1
            symbol: "mA"
            label: "Current"
        }

        CircleGauge {
            id: pressureGauge
            minValue: 0
            maxValue: 100
            value: 50 // AIN2
            symbol: "Psi"
            label: "Pressure"
        }
    }
}
