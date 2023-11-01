import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../controls"

Page {
    id: dashboardPage
    title: "Dashboard"
    width: parent.width
    height: parent.height

    GridLayout {
        id: gaugeGrid
        columns: 4
        anchors.centerIn: parent
        rowSpacing: 10
        columnSpacing: 10

        Rectangle {
            width: gaugeGrid.cellWidth
            height: gaugeGrid.cellHeight
            color: "transparent"
            border.color: "#3498db"
            border.width: 3
            radius: Math.min(width, height) / 2 - 10
            
            CircleGauge {
                id: voltageGauge
                minValue: 0
                maxValue: 220
                value: voltageValue // AIN0
                symbol: "V"
                label: "Voltage"
            }
        }

        CircleGauge {
            id: currentGauge
            minValue: 0
            maxValue: 1000
            value: currentValue // AIN1
            symbol: "mA"
            label: "Current"
        }

        CircleGauge {
            id: pressureGauge
            minValue: 0
            maxValue: 100
            value: pressureValue // AIN2
            symbol: "Psi"
            label: "Pressure"
        }
    }
}
