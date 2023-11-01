import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Extras 1.4

Page {
    id: dashboardPage

    header: PageHeader {
        title: "Dashboard"
    }

    contentItem: Item {
        width: parent.width
        height: parent.height

        // Data AIN0 - AIN7 dan nilai minimum serta maksimum
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
                Gauge {
                    id: gauge
                    width: gaugeGrid.cellWidth
                    height: gaugeGrid.cellHeight
                    value: ainData[index].value
                    minimumValue: ainData[index].minValue
                    maximumValue: ainData[index].maxValue
                    anchors.centerIn: parent
                    radius: Math.min(width, height) / 2 - 10

                    Rectangle {
                        width: parent.width
                        height: parent.height
                        color: "transparent"
                        border.color: "#3498db"
                        border.width: 3

                        Rectangle {
                            width: parent.width
                            height: parent.height
                            color: Qt.rgba(0, 0, 0, 0.1)
                        }
                    }

                    Text {
                        anchors.centerIn: parent
                        text: gauge.value.toFixed(1)
                        font.pixelSize: 20
                        color: "#3498db"
                    }
                }
            }
        }
    }
}
