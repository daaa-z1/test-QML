import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtQuick.Extras 1.4

Page {
    id: dashboardPage

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

    contentItem: Item {
        width: parent.width
        height: parent.height

        GridLayout {
            id: gaugeGrid
            columns: 4
            anchors.centerIn: parent
            rowSpacing: 10
            columnSpacing: 10

            Repeater {
                model: ainData.length
                Item {
                    width: gaugeGrid.cellWidth
                    height: gaugeGrid.cellHeight

                    Gauge {
                        id: gauge
                        width: parent.width
                        height: parent.height
                        value: ainData[index].value
                        minimumValue: ainData[index].minValue
                        maximumValue: ainData[index].maxValue
                        anchors.fill: parent

                        Rectangle {
                            width: parent.width
                            height: parent.height
                            color: "transparent"
                            border.color: "#3498db"
                            border.width: 3
                            radius: Math.min(width, height) / 2

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
}
