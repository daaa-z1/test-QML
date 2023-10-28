import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 2.2
import "qml/controls"
Window {
    visible: true
    width: 640
    height: 480
    title: "Dashboard"

    Grid {
        columns: 3
        spacing: 20
        anchors.centerIn: parent

        CircleGauge {
            id: voltageGauge
            minValue: 0
            maxValue: 220
            value: 110 // Ganti dengan nilai sebenarnya dari perangkat keras Anda.
            symbol: "V"
        }

        CircleGauge {
            id: currentGauge
            minValue: 0
            maxValue: 1000
            value: 500 // Ganti dengan nilai sebenarnya dari perangkat keras Anda.
            symbol: "mA"
        }

        CircleGauge {
            id: pressureGauge
            minValue: 0
            maxValue: 100
            value: 50 // Ganti dengan nilai sebenarnya dari perangkat keras Anda.
            symbol: "Psi"
        }
    }
}