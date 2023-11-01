import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import "controls"

Page {
    id: dashboardPage

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

            Rectangle {
                width: gaugeGrid.cellWidth
                height: gaugeGrid.cellHeight
                border.color: "#3498db"
                border.width: 3
                radius: Math.min(width, height) / 2

                CircleGauge {
                    value: ain0Value
                    minValue: 0
                    maxValue: 100
                }
            }

            Rectangle {
                width: gaugeGrid.cellWidth
                height: gaugeGrid.cellHeight
                border.color: "#3498db"
                border.width: 3
                radius: Math.min(width, height) / 2

                CircleGauge {
                    value: ain1Value
                    minValue: 0
                    maxValue: 100
                }
            }

            Rectangle {
                width: gaugeGrid.cellWidth
                height: gaugeGrid.cellHeight
                border.color: "#3498db"
                border.width: 3
                radius: Math.min(width, height) / 2

                CircleGauge {
                    value: ain2Value
                    minValue: 0
                    maxValue: 100
                }
            }

            Rectangle {
                width: gaugeGrid.cellWidth
                height: gaugeGrid.cellHeight
                border.color: "#3498db"
                border.width: 3
                radius: Math.min(width, height) / 2

                CircleGauge {
                    value: ain3Value
                    minValue: 0
                    maxValue: 100
                }
            }

            Rectangle {
                width: gaugeGrid.cellWidth
                height: gaugeGrid.cellHeight
                border.color: "#3498db"
                border.width: 3
                radius: Math.min(width, height) / 2

                CircleGauge {
                    value: ain4Value
                    minValue: 0
                    maxValue: 100
                }
            }

            Rectangle {
                width: gaugeGrid.cellWidth
                height: gaugeGrid.cellHeight
                border.color: "#3498db"
                border.width: 3
                radius: Math.min(width, height) / 2

                CircleGauge {
                    value: ain5Value
                    minValue: 0
                    maxValue: 100
                }
            }

            Rectangle {
                width: gaugeGrid.cellWidth
                height: gaugeGrid.cellHeight
                border.color: "#3498db"
                border.width: 3
                radius: Math.min(width, height) / 2

                CircleGauge {
                    value: ain6Value
                    minValue: 0
                    maxValue: 100
                }
            }

            Rectangle {
                width: gaugeGrid.cellWidth
                height: gaugeGrid.cellHeight
                border.color: "#3498db"
                border.width: 3
                radius: Math.min(width, height) / 2

                CircleGauge {
                    value: ain7Value
                    minValue: 0
                    maxValue: 100
                }
            }
        }
    }
}
