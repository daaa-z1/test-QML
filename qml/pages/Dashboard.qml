import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "../controls"

Page {
    id: dashboardPage
    title: "Dashboard"
    width: parent.width
    height: parent.height

    property real ain0Value: 30
    property real ain1Value: 50
    property real ain2Value: 70
    property real ain3Value: 40
    property real ain4Value: 60
    property real ain5Value: 20
    property real ain6Value: 80
    property real ain7Value: 90

    contentItem: Item {
        width: parent.width
        height: parent.height

        GridLayout {
            id: gaugeGrid
            rows: 2
            columns: 4
            anchors.centerIn: parent
            rowSpacing: 10
            columnSpacing: 10

            function createGaugeWrapper(value, minValue, maxValue) {
                Rectangle {
                    width: gaugeGrid.cellWidth
                    height: gaugeGrid.cellHeight
                    color: "transparent"
                    border.color: "#3498db"
                    border.width: 3
                    radius: Math.min(width, height) / 2 - 10

                    CircleGauge {
                        width: parent.width
                        height: parent.height
                        value: value
                        minValue: minValue
                        maxValue: maxValue
                    }
                }
            }

            createGaugeWrapper(ain0Value, 0, 100)
            createGaugeWrapper(ain1Value, 0, 100)
            createGaugeWrapper(ain2Value, 0, 100)
            createGaugeWrapper(ain3Value, 0, 100)
            createGaugeWrapper(ain4Value, 0, 100)
            createGaugeWrapper(ain5Value, 0, 100)
            createGaugeWrapper(ain6Value, 0, 100)
            createGaugeWrapper(ain7Value, 0, 100)
        }
    }
}
