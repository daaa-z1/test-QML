import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "controls"

Page {
    id: dashboardPage

    header: PageHeader {
        title: "Dashboard"
    }

    contentItem: Item {
        width: parent.width
        height: parent.height

        property var ainData: [
            { value: 30, minValue: 0, maxValue: 100 },
            { value: 50, minValue: 0, maxValue: 100 },
            { value: 70, minValue: 0, maxValue: 100 },
            { value: 40, minValue: 0, maxValue: 100 },
            { value: 60, minValue: 0, maxValue: 100 },
            { value: 20, minValue: 0, maxValue: 100 },
            { value: 80, minValue: 0, maxValue: 100 },
            { value: 90, minValue: 0, maxValue: 100 }
        ]

        GridLayout {
            id: gaugeGrid
            rows: 2
            columns: 4
            anchors.centerIn: parent
            spacing: 10

            Repeater {
                model: ainData.length
                Item {
                    width: gaugeGrid.cellWidth
                    height: gaugeGrid.cellHeight

                    CircleGauge {
                        id: gauge
                        width: parent.width
                        height: parent.height
                        value: ainData[index].value
                        minValue: ainData[index].minValue
                        maxValue: ainData[index].maxValue
                    }
                }
            }
        }
    }
}
